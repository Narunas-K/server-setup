##variables
$start_hour = 12
$start_min = 10
$minutes_from_midnight = $start_hour*60+$start_min
#Iperf server interfaces IP addresses
$kw1eth0 = '192.168.1.1'
$kw1eth1 = '192.168.2.1'
$kw1eth2 = '192.168.3.1'
$kw1eth3 = '192.168.4.1'
$kw1eth4 = '192.168.5.1'
#Iperf client interfaces IP addresses
$kw3eth0 = '192.168.1.2'
$kw3eth1 ='192.168.2.2'
$kw3eth2 = '192.168.3.2'
$kw3eth3 = '192.168.4.2'
$kw3eth4 = '192.168.5.2'
$iperf_server_port = '50001'
#Iterface names and IP addrays
iperf_server_interfaces_array = [$kw1eth0, $kw1eth1, $kw1eth2, $kw1eth3, $kw1eth4]
iperf_client_interfaces_array = [$kw3eth0, $kw3eth1, $kw1eth2, $kw3eth3, $kw3eth4]
iperf_server_interfaces_names_array = ["kw1eth0", "kw1eth1", "kw1eth2", "kw1eth3", "kw1eth4"]
iperf_client_interfaces_names_array = ["kw3eth0", "kw3eth1", "kw3eth2", "kw3eth3", "kw3eth4"]
interfaces_number_array = [0, 1, 2, 3, 4]
test_number_array = [0, 1, 2, 3, 4]
$global_test_number = 0
$cron_hour = 0
$cron_min = 0

#Cron creation loop
for interface_number in  interfaces_number_array do 
  for test_number in test_number_array do
    $cron_hour = $minutes_from_midnight/60.floor  
    $cron_min = $minutes_from_midnight-($cron_hour*60)
    puts $cron_hour
    puts $cron_min
    cron "#{iperf_server_interfaces_names_array[interface_number]}_#{iperf_client_interfaces_names_array[interface_number]}_#{test_number}" do
      hour "#$cron_hour"
      minute "#$cron_min"
      user 'narunas'
      command "/home/narunas/repos/iperf3-scripts/iperf-client-run.sh #{iperf_client_interfaces_names_array[interface_number]} #{iperf_server_interfaces_names_array[interface_number]} #$iperf_server_port #{iperf_server_interfaces_names_array[interface_number]}_#{iperf_client_interfaces_names_array[interface_number]}_#{test_number} > /tmp/phys-tcp-throughput-test/script-logs/#{iperf_server_interfaces_names_array[interface_number]}_#{iperf_client_interfaces_names_array[interface_number]}_#{test_number} 2>&1"
    end
  $global_test_number = $global_test_number + 1
  $minutes_from_midnight = $minutes_from_midnight + 6
  end
end

#After tests are completed cleanup cron:
$cron_hour = $minutes_from_midnight/60.floor
$cron_min = $minutes_from_midnight-($cron_hour*60)
cron 'Cleanup cron' do
  hour "#$cron_hour"
  minute "#$cron_min"
  user 'narunas'
  command "/usr/bin/crontab -r "
end
