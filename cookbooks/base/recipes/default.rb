#
# Cookbook Name:: hvf-general
# Recipe:: default
#
# Copyright 2012, HVF INC.
#
# All rights reserved - Do Not Redistribute
#

include_recipe "apt"

include_recipe "base::users"
include_recipe "base::packages"
include_recipe "base::pylibs"

