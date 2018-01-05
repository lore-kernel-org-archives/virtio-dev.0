Return-Path: virtio-dev-return-2918-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id EDEAB1CB807E
	for <virtio-dev@lists.oasis-open.org>; Fri,  5 Jan 2018 00:39:03 -0800 (PST)
References: <20171222064151.29266-1-tiwei.bie@intel.com>
 <fcf3858e-6643-350c-37b9-71698f1d26a5@redhat.com>
 <20180104061853.jkdzbueashv2klka@debian-xvivbkq.sh.intel.com>
 <aca10596-f8d4-417e-26b6-ed09ef766552@redhat.com>
 <D0158A423229094DA7ABF71CF2FA0DA34E845FAD@SHSMSX104.ccr.corp.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a1319915-6492-af8d-a35d-5aedad61eb76@redhat.com>
Date: Fri, 5 Jan 2018 16:38:35 +0800
MIME-Version: 1.0
In-Reply-To: <D0158A423229094DA7ABF71CF2FA0DA34E845FAD@SHSMSX104.ccr.corp.intel.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [Qemu-devel] [virtio-dev] [RFC 0/3] Extend vhost-user to support
 VFIO based accelerators
To: "Liang, Cunming" <cunming.liang@intel.com>, "Bie, Tiwei" <tiwei.bie@intel.com>
Cc: "Tan, Jianfeng" <jianfeng.tan@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Wang, Xiao W" <xiao.w.wang@intel.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Wang, Zhihong" <zhihong.wang@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Daly, Dan" <dan.daly@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 2018年01月05日 14:58, Liang, Cunming wrote:
>> Thanks for the pointer. Looks rather interesting.
>>
>>> We're also working on it (including defining a standard device for
>>> vhost data path acceleration based on mdev to hide vendor specific
>>> details).
>> This is exactly what I mean. Form my point of view, there's no need for any
>> extension for vhost protocol, we just need to reuse qemu iothread to
>> implement a userspace vhost dataplane and do the mdev inside that thread.
> On functional perspective, it makes sense to have qemu native support of those certain usage. However, qemu doesn't have to take responsibility for dataplane. There're already huge amounts of codes for different devices emulation, leveraging external dataplane library is an effective way to introduce more.

This does not mean to drop external dataplane library. Actually, you can 
link dpdk to qemu directly.

> The beauty of vhost_user is to open a door for variable userland workloads(e.g. vswitch). The dataplane connected with VM usually need to be close integrated with those userland workloads, a control place interface(vhost-user) is better than a datapath interface(e.g. provided by dataplace in qemu iothread).

Do we really need vswitch for vDPA?

>   On workloads point of view, it's not excited to be part of qemu process.

Don't see why, qemu have dataplane for virtio-blk/scsi.

> That comes up with the idea of vhost-user extension. Userland workloads decides to enable accelerators or not, qemu provides the common control plane infrastructure.

It brings extra complexity: endless new types of messages and a huge 
brunch of bugs. And what's more important, the split model tends to be 
less efficient in some cases, e.g guest IOMMU integration. I'm pretty 
sure we will meet more in the future.

>>> And IMO it's also not a bad idea to extend vhost-user protocol
>>> to support the accelerators if possible. And it could be more
>>> flexible because it could support (for example) below things
>>> easily without introducing any complex command line options or
>>> monitor commands to QEMU:
>> Maybe I was wrong but I don't think we care about the complexity of
>> command line or monitor command in this case.
>>
>>> - the switching among different accelerators and software version
>>>     can be done at runtime in vhost process;
>>> - use different accelerators to accelerate different queue pairs
>>>     or just accelerate some (instead of all) queue pairs;
>> Well, technically, if we want, these could be implemented in qemu too.
> You're right if just considering I/O. The ways to consume those I/O is another perspective.
> Simply 1:1 associating guest virtio-net and accelerator w/ SW datapath fallback is not the whole picture.

Pay attention:

1) What I mean is not a fallback here. You can still do a lot of tricks 
e.g offloading datapath to hardware or doorbell map.
2) Qemu supports (very old and inefficient) a split model of device 
emulation and network backend. This means we can switch between backends 
(though not implemented).

>   It's variable usages on workload side to abstract the device (e.g. port re-presenter for vswitch) and etc. I don't think qemu is interested for all bunch of things there.
>

Again, you can link any dataplane to qemu directly instead of using 
vhost-user if vhost-user tends to be less useful in some cases (vDPA is 
one of the case I think).

Thanks

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

