#
# Cookbook Name:: build_cookbook
# Recipe:: syntax
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

log "Running Syntax Tests"

include_recipe 'delivery-truck::syntax'
