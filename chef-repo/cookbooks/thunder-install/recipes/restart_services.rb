# Cookbook name :: restart_services.rb
# Recipe :: default
#
# Copyright 2015, AQORN
#
# All rights reserved - Do Not Redistribute
#

# Unmount /mnt if its not empty
execute "unmount-tmp" do
  command "umount /mnt"
  action :run
  not_if "ls /mnt" 
end

# Restart the cobbler service
include_recipe 'thunder-common::cobbler'

# Mount bootstrap image
execute "mount-bootstrap" do
  command "mount -t iso9660 -o loop,ro /usr/local/src/bootstrap.iso /mnt"
  action :run
end

# import bootstrap iso to cobbler (If the import fails, execute the next command)
execute "import-bootstrap-1" do
  command "cobbler import --name=default --arch=x86_64 --path=/mnt || true"
  action :run
end
execute "import-bootstrap-2" do
  command "cobbler distro add --name=default --kernel=/var/www/cobbler/ks_mirror/default-x86_64/casper/vmlinuz --initrd=/var/www/cobbler/ks_mirror/default-x86_64/casper/initrd.gz --kopts=\"nfsroot=#{node['thunder']['pxe_ip']}:/var/www/cobbler/ks_mirror/default-x86_64 netboot=nfs boot=casper\" --arch=x86_64 --breed=ubuntu"
  action :run
end  

# Adding a new cobbler profile
execute "add-cobbler-profile" do
  command "cobbler profile add --name=default --distro=default"
  action :run
end

# Adding the profile to system (to ignore pxe default)
execute "sys-cobbler-profile" do
  command "cobbler system add --name=default --profile=default"
  action :run
end

# Unmounting mnt tmp
execute "unmount-tmp" do
  command "umount /mnt"
  action :run
end

# Mount ubuntu-12 image
execute "mount-ubuntu12" do
  command "mount -t iso9660 -o loop,ro /usr/local/src/ubuntu-12.04.2-server-amd64.iso /mnt"
  action :run
end

# import ubuntu12 iso to cobbler
execute "import-ubuntu12" do
  command "cobbler import --name=ubuntu-12_04 --arch=x86_64  --path=/mnt"
  action :run
end

# Unmounting mnt tmp
execute "unmount-tmp" do
  command "umount /mnt"
  action :run
end

# Restart the cobbler service
include_recipe 'thunder-common::cobbler'

# Execute cobbler sync
execute "cobbler-sync" do
  command "cobbler sync"
  action :run
end

# Command to reconfigure request for chef-server
execute "chef-reconfigure" do
  command "chef-server-ctl reconfigure"
  action :run
end

# Command to restart nsfd
execute "nsfd-restart" do
  command "/etc/init.d/nfs-kernel-server restart"
  action :run
end
