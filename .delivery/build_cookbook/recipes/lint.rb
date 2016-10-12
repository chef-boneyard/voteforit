#
# Cookbook Name:: build_cookbook
# Recipe:: lint
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

log "Executing lint phase"

include_recipe 'delivery-truck::lint'
