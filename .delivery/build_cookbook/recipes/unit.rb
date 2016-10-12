#
# Cookbook Name:: build-cookbook
# Recipe:: unit
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

log "Running Unit Tests"

include_recipe 'delivery-truck::unit'
