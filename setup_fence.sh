set -x
pcs stonith create fence_controller0 fence_xvm pcmk_host_map="overcloud-controller-0:overcloud-controller2"
pcs stonith create fence_controller1 fence_xvm pcmk_host_map="overcloud-controller-1:overcloud-controller1"
pcs stonith create fence_controller2 fence_xvm pcmk_host_map="overcloud-controller-2:overcloud-controller3"
pcs constraint location fence_controller0 avoids overcloud-controller-0
pcs constraint location fence_controller1 avoids overcloud-controller-1
pcs constraint location fence_controller2 avoids overcloud-controller-2
