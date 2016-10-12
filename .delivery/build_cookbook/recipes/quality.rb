#
# Cookbook Name:: build_cookbook
# Recipe:: quality
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

log "Running Quality Tests"

include_recipe 'delivery-truck::quality'
