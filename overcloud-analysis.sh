. /home/stack/stackrc
echo "os-collect-config -> os-refresh-config -> os-apply-config -> os-net-config"
controller_ip=$(nova list | grep overcloud-controller | head -1 | awk '{ print $12 }' | cut -d = -f 2)
echo $controller_ip
echo -e "\n----" Introspection iPXE boot config from openstack-ironic-inspector-dnsmasq.service
echo -e "----" cat /etc/ironic-inspector/dnsmasq.conf
cat /etc/ironic-inspector/dnsmasq.conf
echo -e "\n----" dhcp options for neutron boot for OS load
echo cat /var/lib/neutron/dhcp/$(neutron net-list | grep 172.16.0.0 | awk '{print $2;}')/opts
cat /var/lib/neutron/dhcp/$(neutron net-list | grep 172.16.0.0 | awk '{print $2;}')/opts
echo -e "\n\n----" cloud init to configure os-collect-config from /var/lib/cloud/data/cfn-init-data 
ssh heat-admin@$controller_ip sudo cat /var/lib/cloud/data/cfn-init-data 
echo -e "\n\n----" os-collect-config that monitors metadata from the heat api
ssh heat-admin@$controller_ip sudo systemctl status os-collect-config | head -8
echo -e "\n----" metadata collected by os-collect-config.conf
ssh heat-admin@$controller_ip sudo ls -l /var/lib/os-collect-config/*.json
echo -e "\n----" cat /etc/os-collect-config.conf 
cat /etc/os-collect-config.conf 
echo -e "\n----" ls /usr/libexec/os-refresh-config/configure.d/
ssh heat-admin@$controller_ip sudo ls /usr/libexec/os-refresh-config/configure.d/
echo -e "\n----" heat templates
set -x
ls -l /usr/share/openstack-tripleo-heat-templates/overcloud-without-mergepy.yaml
ls -l /usr/share/openstack-tripleo-heat-templates/overcloud-resource-registry-puppet.yaml


