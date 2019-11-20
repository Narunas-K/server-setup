#
# Cookbook:: server-setup
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.
package 'vim'
package 'binutils'
package 'tree'
package 'git'
package 'dstat'
package 'iperf3'

template '/home/narunas/.bashrc' do
  source 'bashrc'
  owner 'narunas'
  group 'narunas'
  mode '644'
end

directory '/home/narunas/.ssh' do
  owner 'narunas'
  group 'narunas'
  mode '700'
end

template '/home/narunas/.ssh/authorized_keys' do
  source 'authorized_keys'
  owner 'narunas'
  group 'narunas'
  mode '600'
end

file '/etc/environment' do
content 'LANG=en_US.utf-8
LC_ALL=en_US.utf-8'
end

include_recipe 'server-setup::k8-master-setup'
#include_recipe 'server-setup::k8-worker1-setup'
#include_recipe 'server-setup::k8-worker2-setup'
#include_recipe 'server-setup::k8-worker3-setup'
