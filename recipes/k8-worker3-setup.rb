template '/etc/motd' do
  source 'motd-workernode3.erb'
end

hostname 'kube-worker3'
