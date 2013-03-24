directory "/opt/lib/" do
    owner "root"
    group "root"
    recursive true
end 

# this will fail if the archive is not there.
# this is fine as we can't install much without it.

libs = ["leveldb-1.9.0", "snappy-1.1.0"]
for lib_name in libs do  
    tar_fname = "#{lib_name}.tar.gz"
    execute "cp_#{lib_name}_tar" do
        command "cp /vagrant/#{tar_fname} /opt/lib/#{tar_fname}"
        not_if "test -f /opt/lib/#{tar_fname}"
    end

    execute "untar_#{lib_name}" do
        command "tar xzf #{tar_fname}"
        cwd "/opt/lib/"
        not_if "test -d /opt/lib/#{lib_name}"
    end
end

cookbook_file "/opt/lib/install_leveldb.sh" do
    source "install_leveldb.sh"
    mode 0700
end

# install snappy
#
package "pkg-config"
package "automake"
package "libtool"

#execute "install_leveldb_sh" do
#    command "./install_leveldb.sh"
#    cmd "/opt/lib/"

#execute "install_snappy" do
#    command "./autogen.sh && ./configure --enable-shared=no --enable-static=yes && make clean && make CXXFLAGS='-g -O2 -fPIC'"
#    cwd "/opt/lib/snappy-1.1.0"
#    not_if "test -d /opt/lib/snappy-1.1.0/.libs"
#end

# install leveldb
# 
#execute "install_leveldb" do
#    command "make clean && make libleveldb.a LDFLAGS='-L../snappy-1.1.0/.libs/ -Bstatic -lsnappy' OPT='-fPIC -O2 -DNDEBUG -DSNAPPY -I../snappy-1.1.0' SNAPPY_CFLAGS=''"
#    cwd "/opt/lib/leveldb-1.9.0/"
#    not_if "test -f /opt/lib/leveldb-1.9.0/libleveldb.a"
#end
