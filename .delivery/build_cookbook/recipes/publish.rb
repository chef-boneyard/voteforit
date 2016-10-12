#
# Cookbook Name:: build_cookbook
# Recipe:: publish
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

log "Executing Publish Phase"

include_recipe "delivery-truck::publish"
