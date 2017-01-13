set -x
#openstack --debug overcloud deploy --templates ~/my_templates/ \
openstack overcloud deploy --templates ~/my_templates/ \
   --ntp-server 10.5.26.10 \
    --control-flavor control --compute-flavor compute --ceph-storage-flavor ceph \
    --control-scale 3 --compute-scale 2 --ceph-storage-scale 3 \
    --neutron-tunnel-types vxlan --neutron-network-type vxlan \
    -e ~/my_templates/environments/storage-environment.yaml \
    -e ~/my_templates/advanced-networking.yaml \
    -e ~/my_templates/firstboot-environment.yaml \
    -e ~/my_templates/ceilometer.yaml  \
    --validation-errors-fatal \
    --validation-warnings-fatal \
    --force-postconfig
#     --dry-run
    
