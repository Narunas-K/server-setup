include_recipe 'server-setup::default-worker-setup'

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

hostname 'kube-worker1'

#1st pair of interfaces
cron 'kw1eth0_kw3eth0_1' do
  minute $tst_window_1
  hour $start_hour
  user 'narunas'
  command "/home/narunas/repos/iperf3-scripts/iperf-server-run.sh #$kw1eth0 50002 kw1eth0_kw3eth0_1 > /tmp/phys-tcp-throughput-test/script-logs/kw1eth0_kw3eth0_1 2>&1"
end

cron 'kw1eth0_kw3eth0_2' do
  minute $tst_window_2
  hour $start_hour
  user 'narunas'
  command "/home/narunas/repos/iperf3-scripts/iperf-server-run.sh #$kw1eth0 50002 kw1eth0_kw3eth0_2 > /tmp/phys-tcp-throughput-test/script-logs/kw1eth0_kw3eth0_2 2>&1"
end

cron 'kw1eth0_kw3eth0_3' do
  minute $tst_window_3
  hour $start_hour
  user 'narunas'
  command "/home/narunas/repos/iperf3-scripts/iperf-server-run.sh #$kw1eth0 50002 kw1eth0_kw3eth0_3 > /tmp/phys-tcp-throughput-test/script-logs/kw1eth0_kw3eth0_3 2>&1"
end

#2nd pair of interfaces
cron 'kw1eth1_kw3eth1_1' do
  minute $tst_window_4
  hour $start_hour
  user 'narunas'
  command "/home/narunas/repos/iperf3-scripts/iperf-server-run.sh #$kw1eth1 50002 kw1eth1_kw3eth1_1 > /tmp/phys-tcp-throughput-test/script-logs/kw1eth1_kw3eth1_1 2>&1"
end

cron 'kw1eth1_kw3eth1_2' do
  minute $tst_window_5
  hour $start_hour
  user 'narunas'
  command "/home/narunas/repos/iperf3-scripts/iperf-server-run.sh #$kw1eth1 50002 kw1eth1_kw3eth1_2 > /tmp/phys-tcp-throughput-test/script-logs/kw1eth1_kw3eth1_2 2>&1"
end

cron 'kw1eth1_kw3eth1_3' do
  minute $tst_window_6
  hour $start_hour
  user 'narunas'
  command "/home/narunas/repos/iperf3-scripts/iperf-server-run.sh #$kw1eth1 50002 kw1eth1_kw3eth1_3 > /tmp/phys-tcp-throughput-test/script-logs/kw1eth1_kw3eth1_3 2>&1"
end

#3rd pair of interfaces
cron 'kw1eth2_kw3eth2_1' do
  minute $tst_window_1
  hour $start_hour+1
  user 'narunas'
  command "/home/narunas/repos/iperf3-scripts/iperf-server-run.sh #$kw1eth2 50002 kw1eth2_kw3eth2_1 > /tmp/phys-tcp-throughput-test/script-logs/kw1eth2_kw3eth2_1 2>&1"
end

cron 'kw1eth2_kw3eth2_2' do
  minute $tst_window_2
  hour $start_hour+1
  user 'narunas'
  command "/home/narunas/repos/iperf3-scripts/iperf-server-run.sh #$kw1eth2 50002 kw1eth2_kw3eth2_2 > /tmp/phys-tcp-throughput-test/script-logs/kw1eth2_kw3eth2_2 2>&1"
end

cron 'kw1eth2_kw3eth2_3' do
  minute $tst_window_3
  hour $start_hour+1
  user 'narunas'
  command "/home/narunas/repos/iperf3-scripts/iperf-server-run.sh #$kw1eth2 50002 kw1eth2_kw3eth2_3 > /tmp/phys-tcp-throughput-test/script-logs/kw1eth2_kw3eth2_3 2>&1"
end

#4th pair of interfaces
cron 'kw1eth3_kw3eth3_1' do
  minute $tst_window_4
  hour $start_hour+1
  user 'narunas'
  command "/home/narunas/repos/iperf3-scripts/iperf-server-run.sh #$kw1eth3 50002 kw1eth3_kw3eth3_1 > /tmp/phys-tcp-throughput-test/script-logs/kw1eth3_kw3eth3_1 2>&1"
end

cron 'kw1eth3_kw3eth3_2' do
  minute $tst_window_5
  hour $start_hour+1
  user 'narunas'
  command "/home/narunas/repos/iperf3-scripts/iperf-server-run.sh #$kw1eth3 50002 kw1eth3_kw3eth3_2 > /tmp/phys-tcp-throughput-test/script-logs/kw1eth3_kw3eth3_1 2>&1"
end

cron 'kw1eth3_kw3eth3_3' do
  minute $tst_window_6
  hour $start_hour+1
  user 'narunas'
  command "/home/narunas/repos/iperf3-scripts/iperf-server-run.sh #$kw1eth3 50002 kw1eth3_kw3eth3_3 > /tmp/phys-tcp-throughput-test/script-logs/kw1eth3_kw3eth3_1 2>&1"
end

#5th pair of interfaces
cron 'kw1eth4_kw3eth4_1' do
  minute $tst_window_1
  hour $start_hour+2
  user 'narunas'
  command "/home/narunas/repos/iperf3-scripts/iperf-server-run.sh #$kw1eth4 50002 kw1eth4_kw3eth4_1 > /tmp/phys-tcp-throughput-test/script-logs/kw1eth4_kw3eth4_1 2>&1"
end

cron 'kw1eth4_kw3eth4_2' do
  minute $tst_window_2
  hour $start_hour+2
  user 'narunas'
  command "/home/narunas/repos/iperf3-scripts/iperf-server-run.sh #$kw1eth4 50002 kw1eth4_kw3eth4_2 > /tmp/phys-tcp-throughput-test/script-logs/kw1eth4_kw3eth4_2 2>&1"
end

cron 'kw1eth4_kw3eth4_3' do
  minute $tst_window_3
  hour $start_hour+2
  user 'narunas'
  command "/home/narunas/repos/iperf3-scripts/iperf-server-run.sh #$kw1eth4 50002 kw1eth4_kw3eth4_3 > /tmp/phys-tcp-throughput-test/script-logs/kw1eth4_kw3eth4_3 2>&1"
end

#6th pair of interfaces
cron 'kw1eth2_kw3eth3_1' do
  minute $tst_window_4
  hour $start_hour+2
  user 'narunas'
  command "/home/narunas/repos/iperf3-scripts/iperf-server-run.sh #$kw1eth2 50002 kw1eth2_kw3eth3_1 > /tmp/phys-tcp-throughput-test/script-logs/kw1eth2_kw3eth3_1 2>&1"
end

cron 'kw1eth2_kw3eth3_2' do
  minute $tst_window_5
  hour $start_hour+2
  user 'narunas'
  command "/home/narunas/repos/iperf3-scripts/iperf-server-run.sh #$kw1eth2 50002 kw1eth2_kw3eth3_2 > /tmp/phys-tcp-throughput-test/script-logs/kw1eth2_kw3eth3_2 2>&1"
end

cron 'kw1eth2_kw3eth3_3' do
  minute $tst_window_6
  hour $start_hour+2
  user 'narunas'
  command "/home/narunas/repos/iperf3-scripts/iperf-server-run.sh #$kw1eth2 50002 kw1eth2_kw3eth3_3 > /tmp/phys-tcp-throughput-test/script-logs/kw1eth2_kw3eth3_3 2>&1"
end

#7th pair of interfaces
cron 'kw1eth3_kw3eth2_1' do
  minute $tst_window_1
  hour $start_hour+3
  user 'narunas'
  command "/home/narunas/repos/iperf3-scripts/iperf-server-run.sh #$kw1eth3 50002 kw1eth3_kw3eth2_1 > /tmp/phys-tcp-throughput-test/script-logs/kw1eth3_kw3eth2_1 2>&1"
end

cron 'kw1eth3_kw3eth2_2' do
  minute $tst_window_2
  hour $start_hour+3
  user 'narunas'
  command "/home/narunas/repos/iperf3-scripts/iperf-server-run.sh #$kw1eth3 50002 kw1eth3_kw3eth2_2 > /tmp/phys-tcp-throughput-test/script-logs/kw1eth3_kw3eth2_2 2>&1"
end

cron 'kw1eth3_kw3eth2_3' do
  minute $tst_window_3
  hour $start_hour+3
  user 'narunas'
  command "/home/narunas/repos/iperf3-scripts/iperf-server-run.sh #$kw1eth3 50002 kw1eth3_kw3eth2_3 > /tmp/phys-tcp-throughput-test/script-logs/kw1eth3_kw3eth2_3 2>&1"
end
