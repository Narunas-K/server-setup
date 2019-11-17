template '/etc/motd' do
  source 'motd-kubemaster.erb'
end

hostname 'kube-master'
