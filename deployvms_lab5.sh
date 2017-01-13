#!/bin/bash
set -x

#for i in {1..5}; do virsh destroy overcloud-node$i; done
#for i in {1..5}; do virsh undefine overcloud-node$i; done
#rm -f overcloud*.qcow2
rm -f /tmp/overcloud*.xml
#read -p "press any key"

for i in {1..5}; do qemu-img create -f qcow2 \
   -o preallocation=metadata /home/libvirt/overcloud-node$i.qcow2 60G; done
read -p "press any key"

for i in {1..5}; do \
    virt-install --ram 8192 --vcpus 4 --os-variant rhel7 \
    --disk path=/home/libvirt/overcloud-node$i.qcow2,device=disk,bus=virtio,format=qcow2 \
    --noautoconsole --vnc --network network:provisioning \
    --network network:default --name overcloud-node$i \
    --cpu Nehalem,+vmx \
    --dry-run --print-xml > /tmp/overcloud-node$i.xml; \
    virsh define --file /tmp/overcloud-node$i.xml; done

for i in $(virsh list --all | awk ' /overcloud/ { print $2 } '); \
    do mac=$(virsh domiflist $i | awk ' /provisioning/ { print $5 } '); \
    echo -e "$mac" >> /tmp/nodes.txt; done

scp /tmp/nodes.txt stack@undercloud:/tmp/
