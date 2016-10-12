#
# Cookbook Name:: voteforit_deploy
# Recipe:: app
#
# Copyright 2016 The Authors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_recipe "voteforit_deploy::default"

origin = "fnichol"
name = "voteforit"

peer_ip = node.fetch("voteforit", {}).fetch("redis_peer_ip", "127.0.0.1")
redis_sg = node.fetch("voteforit", {}).fetch("redis_service_group", "redis.default")

directory "/hab/svc/#{name}" do
  recursive true
end

file "/hab/svc/#{name}/user.toml" do
  content <<_CONTENT_
question = "What the what?"

[choices]
poo = "Poop"
_CONTENT_
end

systemd_unit "#{name}.service" do
  enabled true
  content <<_CONTENT_
[Unit]
Description=#{origin}/#{name}
After=network.target auditd.service

[Service]
ExecStart=/bin/hab start #{origin}/#{name} --listen-http 0.0.0.0:9641 --listen-peer 0.0.0.0:9644 --peer #{peer_ip} --bind redis:#{redis_sg}
Restart=on-failure
_CONTENT_
  action [:create, :enable, :start]
end
