template '/etc/motd' do
  source 'motd-workernode1.erb'
end

hostname 'kube-worker1'
