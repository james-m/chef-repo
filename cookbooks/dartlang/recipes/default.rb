package "unzip"
directory "/opt/lib/" do
    owner "root"
    group "root"
    recursive true
end 

tar_filename = "dartsdk-linux-64.tar.gz"
execute "cp_dartlang" do
    command "cp /vagrant/#{tar_filename} /opt/lib/"
    not_if "test -f /opt/lib/#{tar_filename}"
end

execute "untar_dartlang" do
    command "tar xzvf #{tar_filename}"
    cwd "/opt/lib/"
    not_if "test -d /opt/lib/dart-sdk"
end

execute "chown_sdk" do
    command "chown -R root:root dart-sdk/"
    cwd "/opt/lib/"
end

execute "chmod_sdk_dirs" do
    command "find . -type d -exec chmod 0755 {} \\;"
    cwd "/opt/lib/dart-sdk/"
end

execute "chmod_sdk_files" do
    command "find . -type f -exec chmod 0644 {} \\;"
    cwd "/opt/lib/dart-sdk/"
end

execute "chmod_sdk_bins" do
    command "chmod 0755 *"
    cwd "/opt/lib/dart-sdk/bin/"
end

cookbook_file "/etc/profile.d/env-dartlang.sh" do
    source "etc/profile.d/env-dartlang.sh"
    owner "root"
    group "root"
    mode  0744
end


