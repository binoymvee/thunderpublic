# @author: Geo Varghese
# @create_date: 21-Apr-2015
# @modified by: Geo Varghese    
# @modified_date: 21-Apr-2015
# @linking to other page: 
# @description: The recipe to setup ip temporarly in nic

# check ping to thunder machine
execute "check ping to thunder ip #{node['thunder']['ip']}" do
  command "ping -c 1 #{node['thunder']['ip']}"
  action :run
end

nic_name = node['thunder']['attach_nic']

# if valn enabled, install related packages
if !node['thunder']['vlan_tag'].to_s.empty?
  
  # change source list
  changeAptSourceList(node['thunder']['local_repo_ip'])
  
  # install valn package
  platform_options = node['thunder']['common']
  package "vlan" do
    options platform_options['package_options']
    action :install
  end
  
  # add kernal module temporary
  execute "add kernal module temporary" do
    command "modprobe 8021q"
  end
  
  # up device
  execute "up net device" do
    command "ifconfig #{nic_name} up"
  end
  
  # add vlan device
  execute "add vlan device" do
    command "vconfig add #{node['thunder']['attach_nic']} #{node['thunder']['vlan_tag']}"
    not_if "cat /proc/net/vlan/config | grep #{node['thunder']['attach_nic']}.#{node['thunder']['vlan_tag']}"
  end
  
  nic_name = nic_name + "." + node['thunder']['vlan_tag'].to_s
   
end

ip_address = if node['thunder']['from_node'] == 1 then node['thunder']['from_ip'] else node['thunder']['attach_ip'] end
netmask = if node['thunder']['netmask'] then node['thunder']['netmask'] else "255.255.255.0" end 
  
# setup ip temporarly
execute "setup ip #{ip_address} in #{nic_name} temporarly" do
  command "ifconfig #{nic_name} #{ip_address} netmask #{netmask} up"
  action :run
end