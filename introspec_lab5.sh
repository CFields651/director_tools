set -x
for node in $(ironic node-list | grep overcloud | awk '{ print $2 }'); 
  do ironic node-delete $node
done

rm ~/instackenv.json

 jq . << EOF > ~/instackenv.json
{
  "ssh-user": "stack",
  "ssh-key": "$(cat ~/.ssh/id_rsa)",
  "power_manager": "nova.virt.baremetal.virtual_power_driver.VirtualPowerManager",
  "host-ip": "192.168.122.1",
  "arch": "x86_64",
  "nodes": [
    {
      "name": "overcloud-node1",
      "pm_addr": "192.168.122.1",
      "pm_password": "$(cat ~/.ssh/id_rsa)",
      "pm_type": "pxe_ssh",
      "mac": [
        "$(sed -n 1p /tmp/nodes.txt)"
      ],
      "cpu": "4",
      "memory": "8192",
      "disk": "60",
      "arch": "x86_64",
      "pm_user": "stack"
    },
    {
      "name": "overcloud-node2",
      "pm_addr": "192.168.122.1",
      "pm_password": "$(cat ~/.ssh/id_rsa)",
      "pm_type": "pxe_ssh",
      "mac": [
        "$(sed -n 2p /tmp/nodes.txt)"
      ],
      "cpu": "4",
      "memory": "8192",
      "disk": "60",
      "arch": "x86_64",
      "pm_user": "stack"
    },
    {
      "name": "overcloud-node3",
      "pm_addr": "192.168.122.1",
      "pm_password": "$(cat ~/.ssh/id_rsa)",
      "pm_type": "pxe_ssh",
      "mac": [
        "$(sed -n 3p /tmp/nodes.txt)"
      ],
      "cpu": "4",
      "memory": "8192",
      "disk": "60",
      "arch": "x86_64",
      "pm_user": "stack"
    },
    {
      "name": "overcloud-node4",
      "pm_addr": "192.168.122.1",
      "pm_password": "$(cat ~/.ssh/id_rsa)",
      "pm_type": "pxe_ssh",
      "mac": [
        "$(sed -n 4p /tmp/nodes.txt)"
      ],
      "cpu": "4",
      "memory": "8192",
      "disk": "60",
      "arch": "x86_64",
      "pm_user": "stack"
    },
    {
      "name": "overcloud-node5",
      "pm_addr": "192.168.122.1",
      "pm_password": "$(cat ~/.ssh/id_rsa)",
      "pm_type": "pxe_ssh",
      "mac": [
        "$(sed -n 5p /tmp/nodes.txt)"
      ],
      "cpu": "4",
      "memory": "8192",
      "disk": "60",
      "arch": "x86_64",
      "pm_user": "stack"
    }
  ]
}

EOF
openstack baremetal import --json instackenv.json
read -p "press Enter to continue"
ironic node-list
read -p "press Enter to continue"
openstack baremetal configure boot
ironic node-list --fields name extra  properties 
read -p "press Enter to continue"
openstack baremetal introspection bulk start
