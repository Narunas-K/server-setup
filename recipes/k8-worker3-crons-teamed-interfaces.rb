##variables
$start_hour = 03
$start_min = 10
$minutes_from_midnight = $start_hour*60+$start_min
#Iperf server interfaces IP addresses
$kw1team1 = '192.168.2.1'
#Iperf client interfaces IP addresses
$kw3team2 = '192.168.2.101'
#Iterface names and IP addrays
iperf_server_interfaces_array = [$kw1team1]
iperf_client_interfaces_array = [$kw3team2]
iperf_server_interfaces_names_array = ["kw1team1"]
iperf_client_interfaces_names_array = ["kw3team2"]
iperf_server_instances_ports_array = [5000, 5001]
iperf_client_instances_ports_array = [5004, 5006]
mss_values_array = [88, 216, 472, 984, 1460]
#mss_values_array = [2008, 4056, 8152, 8960]
interfaces_number_array = [0]
number_of_iperf_instances_array = [0, 1]
test_number_array = [0, 1, 2, 3, 4]
$global_test_number = 0
$cron_hour = 0
$cron_min = 0

#Cron creation loop
#Assuming that one measurement is taken every 6 minutes and no more than 240 measurements are taken during a 24hr day
for interface_number in  interfaces_number_array do 
  for test_number in test_number_array do
    for mss_value in mss_values_array do
      for instance_number in number_of_iperf_instances_array do
        until $minutes_from_midnight <1440 do
          $minutes_from_midnight = $minutes_from_midnight - 1440
        end
        $cron_hour = $minutes_from_midnight/60.floor  
        $cron_min = $minutes_from_midnight-($cron_hour*60)
        if "#{instance_number}" == "0"
          cron "#{iperf_server_interfaces_names_array[interface_number]}_#{iperf_client_interfaces_names_array[interface_number]}_instance-#{instance_number}_mss-#{mss_value}_#{test_number}" do
            hour "#$cron_hour"
            minute "#$cron_min"
            user 'narunas'
            command "/home/narunas/repos/iperf3-scripts/iperf-client-run.sh #{iperf_client_interfaces_array[interface_number]} #{iperf_server_interfaces_array[interface_number]} #{iperf_server_instances_ports_array[instance_number]} #{iperf_server_interfaces_names_array[interface_number]}_#{iperf_client_interfaces_names_array[interface_number]}_instance-#{instance_number}_mss-#{mss_value}_#{test_number} #{mss_value} #{iperf_client_instances_ports_array[instance_number]} > /tmp/phys-tcp-throughput-test/script-logs/#{iperf_server_interfaces_names_array[interface_number]}_#{iperf_client_interfaces_names_array[interface_number]}_instance-#{instance_number}_mss-#{mss_value}_#{test_number} 2>&1"
          end
        else
          cron "#{iperf_server_interfaces_names_array[interface_number]}_#{iperf_client_interfaces_names_array[interface_number]}_instance-#{instance_number}_mss-#{mss_value}_#{test_number}" do
            hour "#$cron_hour"
            minute "#$cron_min"
            user 'narunas'
            command "/home/narunas/repos/iperf3-scripts/iperf-client-run-without-sar.sh #{iperf_client_interfaces_array[interface_number]} #{iperf_server_interfaces_array[interface_number]} #{iperf_server_instances_ports_array[instance_number]} #{iperf_server_interfaces_names_array[interface_number]}_#{iperf_client_interfaces_names_array[interface_number]}_instance-#{instance_number}_mss-#{mss_value}_#{test_number} #{mss_value} #{iperf_client_instances_ports_array[instance_number]} > /tmp/phys-tcp-throughput-test/script-logs/#{iperf_server_interfaces_names_array[interface_number]}_#{iperf_client_interfaces_names_array[interface_number]}_instance-#{instance_number}_mss-#{mss_value}_#{test_number} 2>&1"
          end
        end
      end
    $global_test_number = $global_test_number + 1
    $minutes_from_midnight = $minutes_from_midnight + 6
    end
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

