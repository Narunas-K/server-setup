template '/etc/motd' do
  source 'motd-workernode2.erb'
end

hostname 'kube-worker2'
