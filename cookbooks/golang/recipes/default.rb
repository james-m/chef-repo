#
# Cookbook Name:: hvf-go
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

directory "/opt/lib/" do
    owner "root"
    group "root"
    recursive true
end 

# this will fail if the archive is not there.
# this is fine as we can't install much without it.
tar_fname = "go1.0.2.linux-amd64.tar.gz"
execute "cp_golang_tar" do
    command "cp /vagrant/go1.0.2.linux-amd64.tar.gz /opt/lib/#{tar_fname}"
end

execute "untar_go" do
    command "tar -C /usr/local -xzf /opt/lib/#{tar_fname}"
    not_if "test -d /usr/local/go"
end

directory "/usr/local/lib/go" do
    owner "root"
    group "root"
    recursive true
end

cookbook_file "/etc/profile.d/env-go.sh" do
    source "etc/profile.d/env-go.sh"
    owner "root"
    group "root"
    mode  0744
end

cookbook_file "/etc/sudoers.d/go" do
    source "etc/sudoers.d/go"
    owner "root"
    group "root"
    mode  0440
end

