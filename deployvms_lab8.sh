set -x
 for i in {1..3}; do \
    qemu-img create -f qcow2 -o preallocation=metadata /home/libvirt/overcloud-controller$i.qcow2 30G; done

for i in 1 2; do \
    qemu-img create -f qcow2 -o preallocation=metadata /home/libvirt/overcloud-compute$i.qcow2 20G; done

#for i in {1..3}; do \
#    qemu-img create -f qcow2 -o preallocation=metadata /home/libvirt/overcloud-ceph$i.qcow2 20G; done

#for i in {1..3}; do \
#    qemu-img create -f qcow2 -o preallocation=metadata /home/libvirt/overcloud-ceph-osd$i.qcow2 20G; done

read -p "Press enter to continue"

for i in {1..3}; do virt-install --ram 8192 --vcpus 4 --os-variant rhel7 \
    --disk path=/home/libvirt/overcloud-controller$i.qcow2,device=disk,bus=virtio,format=qcow2 \
    --noautoconsole --vnc --network network:provisioning --network network:default \
    --network network:default --name overcloud-controller$i --dry-run \
    --print-xml > /tmp/overcloud-controller$i.xml; \
    virsh define --file /tmp/overcloud-controller$i.xml; done

read -p "Press enter to continue"

for i in 1 2; do virt-install --ram 6144 --vcpus 2 --os-variant rhel7 \
    --disk path=/home/libvirt/overcloud-compute$i.qcow2,device=disk,bus=virtio,format=qcow2 \
    --noautoconsole --vnc --network network:provisioning --network network:default \
    --network network:default --name overcloud-compute$i --dry-run \
    --cpu Nehalem,+vmx \
    --print-xml > /tmp/overcloud-compute$i.xml; \
    virsh define --file /tmp/overcloud-compute$i.xml; done

read -p "Press enter to continue"

#for i in {1..3}; do virt-install --ram 4096 --vcpus 2 --os-variant rhel7 \
#    --disk path=/home/libvirt/overcloud-ceph$i.qcow2,device=disk,bus=virtio,format=qcow2 \
#    --disk path=/home/libvirt/overcloud-ceph-osd$i.qcow2,device=disk,bus=virtio,format=qcow2 \
#    --noautoconsole --vnc --network network:provisioning --network network:default \
#    --network network:default --name overcloud-ceph$i --dry-run \
#    --print-xml > /tmp/overcloud-ceph$i.xml; \
#    virsh define --file /tmp/overcloud-ceph$i.xml; done

read -p "Press enter to continue"

for i in $(virsh list --all | awk ' /overcloud/ { print $2 } '); \
    do mac=$(virsh domiflist $i | awk ' /provisioning/ { print $5 } '); \
    echo -e "$mac" >> /tmp/nodes.txt; done

scp /tmp/nodes.txt stack@undercloud:/tmp/

