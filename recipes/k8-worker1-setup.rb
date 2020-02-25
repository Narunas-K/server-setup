include_recipe 'server-setup::default-worker-setup'
#include_recipe 'server-setup::k8-worker1-crons'
include_recipe 'server-setup::k8-worker1-crons-teamed-interfaces'

#variables
$start_hour=20
$tst_window_1 = 0
$tst_window_2 = 10
$tst_window_3 = 20
$tst_window_4 = 30
$tst_window_5 = 40
$tst_window_6 = 50

$kw1eth0='enp3s0f1'
$kw1eth1='enp4s0f0'
$kw1eth2='enp4s0f1'
$kw1eth3='ens2f0'
$kw1eth4='ens2f1'

template '/etc/motd' do
  source 'motd-workernode1.erb'
end
