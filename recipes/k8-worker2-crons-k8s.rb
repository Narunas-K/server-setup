##variables
$start_hour = 03
$start_min = 10
$minutes_from_midnight = $start_hour*60+$start_min
#Iterface names and IP addrays
iperf_server_names_array = ["iperf3-server1", "iperf3-server2"]
iperf_client_names_array = ["iperf3-client1", "iperf3-client2"]
iperf_server_instances_ports_array = [5201, 5202]
iperf_client_instances_ports_array = [5004, 5004]
mss_values_array = [88, 216, 472, 984, 1460]
services_path = "/home/narunas/repos/scripts/iperf3-scripts/k8s-run/k8s/services"
pods_path = "/home/narunas/repos/scripts/iperf3-scripts/k8s-run/k8s/pods"
iperf_service_conf_file = ["#{services_path}/iperf3-srv-svc-1.yaml", "#{services_path}/iperf3-srv-svc-2.yaml"]
iperf_server_yaml_file = ["#{pods_path}/iperf3-server1.yaml", "#{pods_path}/iperf3-server2.yaml"]
iperf_client_yaml_file = ["#{pods_path}/iperf3-client1.yaml", "#{pods_path}/iperf3-client2.yaml"]
instance_tag_array = ["first", "second"]

#mss_values_array = [2008, 4056, 8152, 8960]
number_of_iperf_instances_array = [0, 1]
test_number_array = [0, 1, 2, 3, 4]
$global_test_number = 0
$cron_hour = 0
$cron_min = 0

#Cron creation loop
#Assuming that one measurement is taken every 6 minutes and no more than 240 measurements are taken during a 24hr day
for test_number in test_number_array do
    for mss_value in mss_values_array do
      for instance_number in number_of_iperf_instances_array do
        until $minutes_from_midnight <1440 do
          $minutes_from_midnight = $minutes_from_midnight - 1440
        end
        $cron_hour = $minutes_from_midnight/60.floor
        $cron_min = $minutes_from_midnight-($cron_hour*60)
        if "#{instance_number}" == "0"
          cron "#{iperf_server_names_array[instance_number]}_#{iperf_client_names_array[instance_number]}_instance-#{instance_number}_mss-#{mss_value}_#{test_number}" do
            hour "#$cron_hour"
            minute "#$cron_min"
            user 'narunas'
            command "/home/narunas/repos/scripts/iperf3-scripts/k8s-run/iperf-k8s-run.sh #{iperf_server_names_array[instance_number]} #{iperf_server_instances_ports_array[instance_number]}  #{iperf_server_names_array[instance_number]}_#{iperf_client_names_array[instance_number]}_instance-#{instance_number}_mss-#{mss_value}_#{test_number} #{mss_value} #{iperf_client_instances_ports_array[instance_number]} #{iperf_service_conf_file[instance_number]} #{iperf_server_yaml_file[instance_number]} #{iperf_client_yaml_file[instance_number]} #{iperf_server_names_array[instance_number]} #{iperf_client_names_array[instance_number]} #{instance_tag_array[instance_number]} > /tmp/phys-tcp-throughput-test/script-logs/#{iperf_server_names_array[instance_number]}_#{iperf_client_names_array[instance_number]}_instance-#{instance_number}_mss-#{mss_value}_#{test_number} 2>&1"
          end
        else
          cron "#{iperf_server_names_array[instance_number]}_#{iperf_client_names_array[instance_number]}_instance-#{instance_number}_mss-#{mss_value}_#{test_number}" do
            hour "#$cron_hour"
            minute "#$cron_min"
            user 'narunas'
            command "/home/narunas/repos/scripts/iperf3-scripts/k8s-run/iperf-k8s-run-without-sar.sh #{iperf_server_names_array[instance_number]} #{iperf_server_instances_ports_array[instance_number]}  #{iperf_server_names_array[instance_number]}_#{iperf_client_names_array[instance_number]}_instance-#{instance_number}_mss-#{mss_value}_#{test_number} #{mss_value} #{iperf_client_instances_ports_array[instance_number]} #{iperf_service_conf_file[instance_number]} #{iperf_server_yaml_file[instance_number]} #{iperf_client_yaml_file[instance_number]} #{iperf_server_names_array[instance_number]} #{iperf_client_names_array[instance_number]} #{instance_tag_array[instance_number]} > /tmp/phys-tcp-throughput-test/script-logs/#{iperf_server_names_array[instance_number]}_#{iperf_client_names_array[instance_number]}_instance-#{instance_number}_mss-#{mss_value}_#{test_number} 2>&1"
          end
        end
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

for inst_number in number_of_iperf_instances_array do
  template "#{services_path}/iperf3-srv-svc-#{inst_number}.yaml" do
    owner 'narunas'
    group 'narunas'
    mode '0644'
    source "iperf3-server-svc.erb"
    variables(
      :service_name => "iperf-server#{inst_number+1}",
      :instance_tag => instance_tag_array[inst_number],
      :port => iperf_server_instances_ports_array[inst_number],
    )
  end
end
