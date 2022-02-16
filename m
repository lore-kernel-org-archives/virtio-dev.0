Return-Path: <weijunji@bytedance.com>
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [virtio-dev] Re: [RFC] Virtio RDMA
From: Junji Wei <weijunji@bytedance.com>
In-Reply-To: <CACGkMEsafzRWYxEw1YUYHka3sm3tH7qXYhcad++NYcfS6LXFLg@mail.gmail.com>
Date: Wed, 16 Feb 2022 15:13:11 +0800
Message-Id: <F801A40A-FB1B-41C6-B409-0106A66E6EDB@bytedance.com>
References: <20220215081353.10351-1-weijunji@bytedance.com>
 <CACGkMEv44vBkUD4YZHg-irzNfxsKjZ4kMZH91LkEYfmmWWhsBA@mail.gmail.com>
 <B07F1166-36A4-4B17-A063-F5447296B99D@bytedance.com>
 <CACGkMEsoKact5us2tHK226ui9fe7DTcMy0BPbE1Ohd0bTpxwWg@mail.gmail.com>
 <19CC8304-C2B3-45A7-BFDB-28E9D0D4A02A@bytedance.com>
 <CACGkMEsafzRWYxEw1YUYHka3sm3tH7qXYhcad++NYcfS6LXFLg@mail.gmail.com>
Content-Type: text/plain;
	charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Jason Wang <jasowang@redhat.com>
Cc: Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, mst <mst@redhat.com>, yuval.shaia.ml@gmail.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Cornelia Huck <cohuck@redhat.com>, Hannes Reinecke <hare@suse.de>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Yongji Xie <xieyongji@bytedance.com>, =?utf-8?B?5p+056iz?= <chaiwen.cc@bytedance.com>, Xiongchun Duan <duanxiongchun@bytedance.com>, zhoujielong@bytedance.com, zhangqianyu.sys@bytedance.com, RDMA mailing list <linux-rdma@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>



> On Feb 16, 2022, at 2:58 PM, Jason Wang <jasowang@redhat.com> wrote:
>=20
> On Wed, Feb 16, 2022 at 2:50 PM Junji Wei <weijunji@bytedance.com> wrote:
>>=20
>>=20
>>=20
>>> On Feb 16, 2022, at 1:54 PM, Jason Wang <jasowang@redhat.com> wrote:
>>>=20
>>> On Tue, Feb 15, 2022 at 6:02 PM Junji Wei <weijunji@bytedance.com> wrot=
e:
>>>>=20
>>>>=20
>>>>> On Feb 15, 2022, at 4:44 PM, Jason Wang <jasowang@redhat.com> wrote:
>>>>>=20
>>>>> On Tue, Feb 15, 2022 at 4:15 PM Junji Wei <weijunji@bytedance.com> wr=
ote:
>>>>>>=20
>>>>>> Hi all,
>>>>>>=20
>>>>>> This RFC aims to introduce our recent work on VirtIO-RDMA.
>>>>>>=20
>>>>>> We have finished a draft of VirtIO-RDMA specification and a vhost-us=
er
>>>>>> RDMA demo based on the spec.This demo can work with CM/Socket
>>>>>> and UD/RC QP now.
>>>>>>=20
>>>>>> NOTE that this spec now only focuses on emulating a soft
>>>>>> RoCE (RDMA over Converged Ethernet) device with normal Network Inter=
face
>>>>>> Card (without RDMA capability). So most Infiniband (IB) specific fea=
tures
>>>>>> such as Subnet Manager (SM), Local Identifier (LID) and Automatic Pa=
th
>>>>>> Migration (APM) are not covered in this specification.
>>>>>>=20
>>>>>> There are four parts of our work:
>>>>>>=20
>>>>>> 1. VirtIO-RDMA driver in linux kernel:
>>>>>> https://github.com/weijunji/linux/tree/virtio-rdma-patch
>>>>>>=20
>>>>>> 2. VirtIO-RDMA userspace provider in rdma-core:
>>>>>> https://github.com/weijunji/rdma-core/tree/virtio-rdma
>>>>>>=20
>>>>>> 3. VHost-User RDMA backend in QEMU:
>>>>>> https://github.com/weijunji/qemu/tree/vhost-user-rdma
>>>>>>=20
>>>>>> 4. VHost-User RDMA demo implements with DPDK:
>>>>>> https://github.com/weijunji/dpdk-rdma
>>>>>>=20
>>>>>>=20
>>>>>> To test with our demo:
>>>>>>=20
>>>>>> 1. Build Linux kernel with config INFINIBAND_VIRTIO_RDMA
>>>>>>=20
>>>>>> 2. Build QEMU with config VHOST_USER_RDMA
>>>>>>=20
>>>>>> 3. Build rdma-core and install it to VM image
>>>>>>=20
>>>>>> 4. Build and install DPDK(NOTE that we only tested on DPDK 20.11.3)
>>>>>>=20
>>>>>> 5. Build dpdk-rdma:
>>>>>>  $ cd dpdk-rdma
>>>>>>  $ meson build
>>>>>>  $ cd build
>>>>>>  $ ninja
>>>>>>=20
>>>>>> 6. Run dpdk-rdma:
>>>>>>  $ sudo ./dpdk-rdma --vdev 'net_vhost0,iface=3D/tmp/sock0,queues=3D1=
' \
>>>>>>    --vdev 'net_tap0' --lcore '1-3'
>>>>>>  $ sudo brctl addif virbr0 dtap0
>>>>>>=20
>>>>>> 7. Boot kernel with qemu with following args using libvirt:
>>>>>> <qemu:commandline>
>>>>>>  <qemu:arg value=3D'-chardev'/>
>>>>>>  <qemu:arg value=3D'socket,path=3D/tmp/sock0,id=3Dvunet'/>
>>>>>>  <qemu:arg value=3D'-netdev'/>
>>>>>>  <qemu:arg value=3D'vhost-user,id=3Dnet1,chardev=3Dvunet,vhostforce,=
queues=3D1'/>
>>>>>>  <qemu:arg value=3D'-device'/>
>>>>>>  <qemu:arg value=3D'virtio-net-pci,netdev=3Dnet1,bus=3Dpci.0,multifu=
nction=3Don,addr=3D0x2'/>
>>>>>>  <qemu:arg value=3D'-chardev'/>
>>>>>>  <qemu:arg value=3D'socket,path=3D/tmp/vhost-rdma0,id=3Dvurdma'/>
>>>>>>  <qemu:arg value=3D'-device'/>
>>>>>>  <qemu:arg value=3D'vhost-user-rdma-pci,page-per-vq,disable-legacy=
=3Don,addr=3D2.1,chardev=3Dvurdma'/>
>>>>>> </qemu:commandline>
>>>>>>=20
>>>>>> NOTE that virtio-net-pci and vhost-user-rdma-pci MUST in same PCI ad=
dresss.
>>>>>>=20
>>>>>=20
>>>>> A silly question, if RoCE is the focus, why not extending virtio-net =
instead?
>>>>=20
>>>> I think it's OK to extend virtio-net to implement virtio-rdma. But if =
we want to
>>>> support IB in the future, would it be better to implement the virtio-r=
dma in an
>>>> independent way?
>>>=20
>>> I'm not sure but a question is whether IB is useful to be visible by
>>> the guest. E.g can you implement the soft RoCE backend via IB
>>> hardware?
>>=20
>> We can't. So do you mean we can implement virtio-rdma only for IB in the=
 future?
>=20
> It's probably virtio-IB but we need to listen to others.

Agreed, one problem is that there might be some duplicated works.

>=20
>>=20
>>>> And currently virtio-rdma doesn't have a strong dependency on
>>>> virtio-net (except for gid and ah stuffs). Is it OK to mix them up?
>>>=20
>>> There are a bunch of hardware vendors that ship a converged Ethernet
>>> adapter. It simplifies the management and deployment.
>>=20
>> Virtio-rdma is not depend on virtio-net, we can bind it to another ether=
net device
>> via mac address in the future. And is it too mass to mix up two differen=
t device
>> in one spec?
>=20
> So either should be fine, we just need to figure out which one is
> better. What I meant is to extend the virtio-net to be capable of
> converged ethernet.

Got it. One question is whether there will be some cases that user want
to use virtio-rdma binding to other types of ethernet device such as
passthroughed net device. In this case, we don=E2=80=99t need a virtio-net
device actually.

Thanks.

