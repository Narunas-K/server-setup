include_recipe 'server-setup::default-worker-setup'
#include_recipe 'server-setup::k8-worker3-crons'
include_recipe 'server-setup::k8-worker3-crons-teamed-interfaces'

template '/etc/motd' do
  source 'motd-workernode3.erb'
end

hostname 'kube-worker3'
