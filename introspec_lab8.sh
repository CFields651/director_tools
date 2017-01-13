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
      "name": "overcloud-ceph1",
      "pm_addr": "192.168.122.1",
      "pm_password": "$(cat ~/.ssh/id_rsa)",
      "pm_type": "pxe_ssh",
      "mac": [
        "$(sed -n 1p /tmp/nodes.txt)"
      ],
      "cpu": "1",
      "memory": "1024",
      "disk": "10",
      "arch": "x86_64",
      "pm_user": "stack"
    },
    {
      "name": "overcloud-ceph2",
      "pm_addr": "192.168.122.1",
      "pm_password": "$(cat ~/.ssh/id_rsa)",
      "pm_type": "pxe_ssh",
      "mac": [
        "$(sed -n 2p /tmp/nodes.txt)"
      ],
      "cpu": "1",
      "memory": "1024",
      "disk": "10",
      "arch": "x86_64",
      "pm_user": "stack"
    },
    {
      "name": "overcloud-ceph3",
      "pm_addr": "192.168.122.1",
      "pm_password": "$(cat ~/.ssh/id_rsa)",
      "pm_type": "pxe_ssh",
      "mac": [
        "$(sed -n 3p /tmp/nodes.txt)"
      ],
      "cpu": "1",
      "memory": "1024",
      "disk": "10",
      "arch": "x86_64",
      "pm_user": "stack"
    },
    {
      "name": "overcloud-compute1",
      "pm_addr": "192.168.122.1",
      "pm_password": "$(cat ~/.ssh/id_rsa)",
      "pm_type": "pxe_ssh",
      "mac": [
        "$(sed -n 4p /tmp/nodes.txt)"
      ],
      "cpu": "1",
      "memory": "1024",
      "disk": "10",
      "arch": "x86_64",
      "pm_user": "stack"
    },
    {
      "name": "overcloud-compute2",
      "pm_addr": "192.168.122.1",
      "pm_password": "$(cat ~/.ssh/id_rsa)",
      "pm_type": "pxe_ssh",
      "mac": [
        "$(sed -n 5p /tmp/nodes.txt)"
      ],
      "cpu": "1",
      "memory": "1024",
      "disk": "10",
      "arch": "x86_64",
      "pm_user": "stack"
    },
    {
      "name": "overcloud-controller1",
      "pm_addr": "192.168.122.1",
      "pm_password": "$(cat ~/.ssh/id_rsa)",
      "pm_type": "pxe_ssh",
      "mac": [
        "$(sed -n 6p /tmp/nodes.txt)"
      ],
      "cpu": "1",
      "memory": "1024",
      "disk": "10",
      "arch": "x86_64",
      "pm_user": "stack"
    },
    {
      "name": "overcloud-controller2",
      "pm_addr": "192.168.122.1",
      "pm_password": "$(cat ~/.ssh/id_rsa)",
      "pm_type": "pxe_ssh",
      "mac": [
        "$(sed -n 7p /tmp/nodes.txt)"
      ],
      "cpu": "1",
      "memory": "1024",
      "disk": "10",
      "arch": "x86_64",
      "pm_user": "stack"
    },
    {
      "name": "overcloud-controller3",
      "pm_addr": "192.168.122.1",
      "pm_password": "$(cat ~/.ssh/id_rsa)",
      "pm_type": "pxe_ssh",
      "mac": [
        "$(sed -n 8p /tmp/nodes.txt)"
      ],
      "cpu": "1",
      "memory": "1024",
      "disk": "10",
      "arch": "x86_64",
      "pm_user": "stack"
    }
  ]
}
F > ~/instackenv.json
{
  "ssh-user": "stack",
  "ssh-key": "$(cat ~/.ssh/id_rsa)",
  "power_manager": "nova.virt.baremetal.virtual_power_driver.VirtualPowerManager",
  "host-ip": "192.168.122.1",
  "arch": "x86_64",
  "nodes": [
    {
      "name": "overcloud-ceph1",
      "pm_addr": "192.168.122.1",
      "pm_password": "$(cat ~/.ssh/id_rsa)",
      "pm_type": "pxe_ssh",
      "mac": [
        "$(sed -n 1p /tmp/nodes.txt)"
      ],
      "cpu": "1",
      "memory": "1024",
      "disk": "10",
      "arch": "x86_64",
      "pm_user": "stack"
    },
    {
      "name": "overcloud-ceph2",
      "pm_addr": "192.168.122.1",
      "pm_password": "$(cat ~/.ssh/id_rsa)",
      "pm_type": "pxe_ssh",
      "mac": [
        "$(sed -n 2p /tmp/nodes.txt)"
      ],
      "cpu": "1",
      "memory": "1024",
      "disk": "10",
      "arch": "x86_64",
      "pm_user": "stack"
    },
    {
      "name": "overcloud-ceph3",
      "pm_addr": "192.168.122.1",
      "pm_password": "$(cat ~/.ssh/id_rsa)",
      "pm_type": "pxe_ssh",
      "mac": [
        "$(sed -n 3p /tmp/nodes.txt)"
      ],
      "cpu": "1",
      "memory": "1024",
      "disk": "10",
      "arch": "x86_64",
      "pm_user": "stack"
    },
    {
      "name": "overcloud-compute1",
      "pm_addr": "192.168.122.1",
      "pm_password": "$(cat ~/.ssh/id_rsa)",
      "pm_type": "pxe_ssh",
      "mac": [
        "$(sed -n 4p /tmp/nodes.txt)"
      ],
      "cpu": "1",
      "memory": "1024",
      "disk": "10",
      "arch": "x86_64",
      "pm_user": "stack"
    },
    {
      "name": "overcloud-compute2",
      "pm_addr": "192.168.122.1",
      "pm_password": "$(cat ~/.ssh/id_rsa)",
      "pm_type": "pxe_ssh",
      "mac": [
        "$(sed -n 5p /tmp/nodes.txt)"
      ],
      "cpu": "1",
      "memory": "1024",
      "disk": "10",
      "arch": "x86_64",
      "pm_user": "stack"
    },
    {
      "name": "overcloud-controller1",
      "pm_addr": "192.168.122.1",
      "pm_password": "$(cat ~/.ssh/id_rsa)",
      "pm_type": "pxe_ssh",
      "mac": [
        "$(sed -n 6p /tmp/nodes.txt)"
      ],
      "cpu": "1",
      "memory": "1024",
      "disk": "10",
      "arch": "x86_64",
      "pm_user": "stack"
    },
    {
      "name": "overcloud-controller2",
      "pm_addr": "192.168.122.1",
      "pm_password": "$(cat ~/.ssh/id_rsa)",
      "pm_type": "pxe_ssh",
      "mac": [
        "$(sed -n 7p /tmp/nodes.txt)"
      ],
      "cpu": "1",
      "memory": "1024",
      "disk": "10",
      "arch": "x86_64",
      "pm_user": "stack"
    },
    {
      "name": "overcloud-controller3",
      "pm_addr": "192.168.122.1",
      "pm_password": "$(cat ~/.ssh/id_rsa)",
      "pm_type": "pxe_ssh",
      "mac": [
        "$(sed -n 8p /tmp/nodes.txt)"
      ],
      "cpu": "1",
      "memory": "1024",
      "disk": "10",
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
echo Now tag ironic nodes with a profile
