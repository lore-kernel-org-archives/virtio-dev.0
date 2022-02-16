Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <20220215081353.10351-1-weijunji@bytedance.com>
 <CACGkMEv44vBkUD4YZHg-irzNfxsKjZ4kMZH91LkEYfmmWWhsBA@mail.gmail.com>
 <B07F1166-36A4-4B17-A063-F5447296B99D@bytedance.com> <CACGkMEsoKact5us2tHK226ui9fe7DTcMy0BPbE1Ohd0bTpxwWg@mail.gmail.com>
 <19CC8304-C2B3-45A7-BFDB-28E9D0D4A02A@bytedance.com>
In-Reply-To: <19CC8304-C2B3-45A7-BFDB-28E9D0D4A02A@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 16 Feb 2022 14:58:20 +0800
Message-ID: <CACGkMEsafzRWYxEw1YUYHka3sm3tH7qXYhcad++NYcfS6LXFLg@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [RFC] Virtio RDMA
Content-Type: text/plain; charset="UTF-8"
To: Junji Wei <weijunji@bytedance.com>
Cc: Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, mst <mst@redhat.com>, yuval.shaia.ml@gmail.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Hannes Reinecke <hare@suse.de>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Yongji Xie <xieyongji@bytedance.com>, =?UTF-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>, Xiongchun Duan <duanxiongchun@bytedance.com>, zhoujielong@bytedance.com, zhangqianyu.sys@bytedance.com, RDMA mailing list <linux-rdma@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 16, 2022 at 2:50 PM Junji Wei <weijunji@bytedance.com> wrote:
>
>
>
> > On Feb 16, 2022, at 1:54 PM, Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Tue, Feb 15, 2022 at 6:02 PM Junji Wei <weijunji@bytedance.com> wrote:
> >>
> >>
> >>> On Feb 15, 2022, at 4:44 PM, Jason Wang <jasowang@redhat.com> wrote:
> >>>
> >>> On Tue, Feb 15, 2022 at 4:15 PM Junji Wei <weijunji@bytedance.com> wrote:
> >>>>
> >>>> Hi all,
> >>>>
> >>>> This RFC aims to introduce our recent work on VirtIO-RDMA.
> >>>>
> >>>> We have finished a draft of VirtIO-RDMA specification and a vhost-user
> >>>> RDMA demo based on the spec.This demo can work with CM/Socket
> >>>> and UD/RC QP now.
> >>>>
> >>>> NOTE that this spec now only focuses on emulating a soft
> >>>> RoCE (RDMA over Converged Ethernet) device with normal Network Interface
> >>>> Card (without RDMA capability). So most Infiniband (IB) specific features
> >>>> such as Subnet Manager (SM), Local Identifier (LID) and Automatic Path
> >>>> Migration (APM) are not covered in this specification.
> >>>>
> >>>> There are four parts of our work:
> >>>>
> >>>> 1. VirtIO-RDMA driver in linux kernel:
> >>>> https://github.com/weijunji/linux/tree/virtio-rdma-patch
> >>>>
> >>>> 2. VirtIO-RDMA userspace provider in rdma-core:
> >>>> https://github.com/weijunji/rdma-core/tree/virtio-rdma
> >>>>
> >>>> 3. VHost-User RDMA backend in QEMU:
> >>>> https://github.com/weijunji/qemu/tree/vhost-user-rdma
> >>>>
> >>>> 4. VHost-User RDMA demo implements with DPDK:
> >>>> https://github.com/weijunji/dpdk-rdma
> >>>>
> >>>>
> >>>> To test with our demo:
> >>>>
> >>>> 1. Build Linux kernel with config INFINIBAND_VIRTIO_RDMA
> >>>>
> >>>> 2. Build QEMU with config VHOST_USER_RDMA
> >>>>
> >>>> 3. Build rdma-core and install it to VM image
> >>>>
> >>>> 4. Build and install DPDK(NOTE that we only tested on DPDK 20.11.3)
> >>>>
> >>>> 5. Build dpdk-rdma:
> >>>>   $ cd dpdk-rdma
> >>>>   $ meson build
> >>>>   $ cd build
> >>>>   $ ninja
> >>>>
> >>>> 6. Run dpdk-rdma:
> >>>>   $ sudo ./dpdk-rdma --vdev 'net_vhost0,iface=/tmp/sock0,queues=1' \
> >>>>     --vdev 'net_tap0' --lcore '1-3'
> >>>>   $ sudo brctl addif virbr0 dtap0
> >>>>
> >>>> 7. Boot kernel with qemu with following args using libvirt:
> >>>> <qemu:commandline>
> >>>>   <qemu:arg value='-chardev'/>
> >>>>   <qemu:arg value='socket,path=/tmp/sock0,id=vunet'/>
> >>>>   <qemu:arg value='-netdev'/>
> >>>>   <qemu:arg value='vhost-user,id=net1,chardev=vunet,vhostforce,queues=1'/>
> >>>>   <qemu:arg value='-device'/>
> >>>>   <qemu:arg value='virtio-net-pci,netdev=net1,bus=pci.0,multifunction=on,addr=0x2'/>
> >>>>   <qemu:arg value='-chardev'/>
> >>>>   <qemu:arg value='socket,path=/tmp/vhost-rdma0,id=vurdma'/>
> >>>>   <qemu:arg value='-device'/>
> >>>>   <qemu:arg value='vhost-user-rdma-pci,page-per-vq,disable-legacy=on,addr=2.1,chardev=vurdma'/>
> >>>> </qemu:commandline>
> >>>>
> >>>> NOTE that virtio-net-pci and vhost-user-rdma-pci MUST in same PCI addresss.
> >>>>
> >>>
> >>> A silly question, if RoCE is the focus, why not extending virtio-net instead?
> >>
> >> I think it's OK to extend virtio-net to implement virtio-rdma. But if we want to
> >> support IB in the future, would it be better to implement the virtio-rdma in an
> >> independent way?
> >
> > I'm not sure but a question is whether IB is useful to be visible by
> > the guest. E.g can you implement the soft RoCE backend via IB
> > hardware?
>
> We can't. So do you mean we can implement virtio-rdma only for IB in the future?

It's probably virtio-IB but we need to listen to others.

>
> >> And currently virtio-rdma doesn't have a strong dependency on
> >> virtio-net (except for gid and ah stuffs). Is it OK to mix them up?
> >
> > There are a bunch of hardware vendors that ship a converged Ethernet
> > adapter. It simplifies the management and deployment.
>
> Virtio-rdma is not depend on virtio-net, we can bind it to another ethernet device
> via mac address in the future. And is it too mass to mix up two different device
> in one spec?

So either should be fine, we just need to figure out which one is
better. What I meant is to extend the virtio-net to be capable of
converged ethernet.

Thanks

>

