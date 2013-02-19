#
# Cookbook Name:: hvf-general
# Recipe:: users 
#
# Copyright 2012, HVF INC.
#
# All rights reserved - Do Not Redistribute
#
# Load the keys of the items in the 'users' data bag
users = data_bag("users")
users.each do |login|
  # This causes a round-trip to the server for each users in the data bag
  user_info = data_bag_item("users", login)
  home = "/home/#{login}"
   
  # for each user in the data bag, make a user resource
  # to ensure they exist
  user login do
    action    :create
    password  user_info["shadow"] 
    shell     "/bin/bash"
    home      home
    supports  :manage_home => true
  end
  # mkdir the .ssh directory 
  directory "/home/#{login}/.ssh" do
    action :create
    owner "#{login}"
    group "#{login}"
  end

  # copy over the user's homedir
  #
  remote_directory "/home/#{login}" do
      source "user_homedir/#{login}"
      files_owner "#{login}"
      files_group "#{login}"
  end
end
 
# Create an "admins" group on the system
# You might use this group in the /etc/sudoers file
# to provide sudo access to the admins
admins = data_bag_item('admins', 'usernames')
group "admins" do
  gid     111
  not_if "grep admin /etc/group"
end

admin_groups = admins['info']
admin_users = admin_groups[node.chef_environment]
  
admin_users.each do |login|
    execute "add #{login} to admin" do
        command "usermod -a -G admin #{login}"
        not_if "grep admin /etc/group | grep #{login}"
    end
end
