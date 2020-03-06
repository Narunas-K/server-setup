##variables
$start_hour = 03
$start_min = 10
$minutes_from_midnight = $start_hour*60+$start_min
#Iterface names and IP addrays
mss_values_array = [88, 216, 472, 984, 1460]

#mss_values_array = [2008, 4056, 8152, 8960]
test_number_array = [0, 1, 2, 3, 4]
$global_test_number = 0
$cron_hour = 0
$cron_min = 0

#Cron creation loop
#Assuming that one measurement is taken every 6 minutes and no more than 240 measurements are taken during a 24hr day
for test_number in test_number_array do
    for mss_value in mss_values_array do
        until $minutes_from_midnight <1440 do
          $minutes_from_midnight = $minutes_from_midnight - 1440
        end
        $cron_hour = $minutes_from_midnight/60.floor
        $cron_min = $minutes_from_midnight-($cron_hour*60)
          cron "mss-#{mss_value}_#{test_number}" do
            hour "#$cron_hour"
            minute "#$cron_min"
            user 'narunas'
            command "/home/narunas/repos/scripts/iperf3-scripts/k8s-run/iperf-k8s-run-only-sar.sh mss-#{mss_value}_#{test_number}  > /tmp/phys-tcp-throughput-test/script-logs/mss-#{mss_value}_#{test_number} 2>&1"
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

