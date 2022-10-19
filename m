Return-Path: <jasowang@redhat.com>
Message-ID: <361c918e-b628-2428-2219-e2fa58ce3645@redhat.com>
Date: Wed, 19 Oct 2022 11:55:18 +0800
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH 0/2] introduce virtio-ism: internal shared
 memory device
References: <20221017074724.89569-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuh0N5sQ1K2Bk70Z-CrQSFb8ttp9vBG+tMypg3pAB0Mpg@mail.gmail.com>
 <1666009602.9397366-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuaUfLEs-+37GZyTLyTQdbvWXSJMkbFxr7TwFU5-tdvNg@mail.gmail.com>
 <F492EC50-9477-45F9-891A-E2B662F0B377@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <F492EC50-9477-45F9-891A-E2B662F0B377@linux.alibaba.com>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: Gerry <gerry@linux.alibaba.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtio-dev@lists.oasis-open.org, hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


在 2022/10/18 16:33, Gerry 写道:
>
>
>> 2022年10月18日 14:54，Jason Wang <jasowang@redhat.com> 写道：
>>
>> On Mon, Oct 17, 2022 at 8:31 PM Xuan Zhuo 
>> <xuanzhuo@linux.alibaba.com> wrote:
>>>
>>> On Mon, 17 Oct 2022 16:17:31 +0800, Jason Wang <jasowang@redhat.com> 
>>> wrote:
>>>> Adding Stefan.
>>>>
>>>>
>>>> On Mon, Oct 17, 2022 at 3:47 PM Xuan Zhuo 
>>>> <xuanzhuo@linux.alibaba.com> wrote:
>>>>>
>>>>> Hello everyone,
>>>>>
>>>>> # Background
>>>>>
>>>>> Nowadays, there is a common scenario to accelerate communication 
>>>>> between
>>>>> different VMs and containers, including light weight virtual 
>>>>> machine based
>>>>> containers. One way to achieve this is to colocate them on the 
>>>>> same host.
>>>>> However, the performance of inter-VM communication through network 
>>>>> stack is not
>>>>> optimal and may also waste extra CPU cycles. This scenario has 
>>>>> been discussed
>>>>> many times, but still no generic solution available [1] [2] [3].
>>>>>
>>>>> With pci-ivshmem + SMC(Shared Memory Communications: [4]) based 
>>>>> PoC[5],
>>>>> We found that by changing the communication channel between VMs 
>>>>> from TCP to SMC
>>>>> with shared memory, we can achieve superior performance for a common
>>>>> socket-based application[5]:
>>>>>  - latency reduced by about 50%
>>>>>  - throughput increased by about 300%
>>>>>  - CPU consumption reduced by about 50%
>>>>>
>>>>> Since there is no particularly suitable shared memory management 
>>>>> solution
>>>>> matches the need for SMC(See ## Comparison with existing 
>>>>> technology), and virtio
>>>>> is the standard for communication in the virtualization world, we 
>>>>> want to
>>>>> implement a virtio-ism device based on virtio, which can support 
>>>>> on-demand
>>>>> memory sharing across VMs, containers or VM-container. To match 
>>>>> the needs of SMC,
>>>>> the virtio-ism device need to support:
>>>>>
>>>>> 1. Dynamic provision: shared memory regions are dynamically 
>>>>> allocated and
>>>>>   provisioned.
>>>>> 2. Multi-region management: the shared memory is divided into regions,
>>>>>   and a peer may allocate one or more regions from the same shared 
>>>>> memory
>>>>>   device.
>>>>> 3. Permission control: The permission of each region can be set 
>>>>> seperately.
>>>>
>>>> Looks like virtio-ROCE
>>>>
>>>> https://lore.kernel.org/all/20220511095900.343-1-xieyongji@bytedance.com/T/
>>>>
>>>> and virtio-vhost-user can satisfy the requirement?
>>>>
>>>>>
>>>>> # Virtio ism device
>>>>>
>>>>> ISM devices provide the ability to share memory between different 
>>>>> guests on a
>>>>> host. A guest's memory got from ism device can be shared with 
>>>>> multiple peers at
>>>>> the same time. This shared relationship can be dynamically created 
>>>>> and released.
>>>>>
>>>>> The shared memory obtained from the device is divided into 
>>>>> multiple ism regions
>>>>> for share. ISM device provides a mechanism to notify other ism 
>>>>> region referrers
>>>>> of content update events.
>>>>>
>>>>> # Usage (SMC as example)
>>>>>
>>>>> Maybe there is one of possible use cases:
>>>>>
>>>>> 1. SMC calls the interface ism_alloc_region() of the ism driver to 
>>>>> return the
>>>>>   location of a memory region in the PCI space and a token.
>>>>> 2. The ism driver mmap the memory region and return to SMC with 
>>>>> the token
>>>>> 3. SMC passes the token to the connected peer
>>>>> 3. the peer calls the ism driver interface ism_attach_region(token) to
>>>>>   get the location of the PCI space of the shared memory
>>>>>
>>>>>
>>>>> # About hot plugging of the ism device
>>>>>
>>>>>   Hot plugging of devices is a heavier, possibly failed, 
>>>>> time-consuming, and
>>>>>   less scalable operation. So, we don't plan to support it for now.
>>>>>
>>>>> # Comparison with existing technology
>>>>>
>>>>> ## ivshmem or ivshmem 2.0 of Qemu
>>>>>
>>>>>   1. ivshmem 1.0 is a large piece of memory that can be seen by 
>>>>> all devices that
>>>>>   use this VM, so the security is not enough.
>>>>>
>>>>>   2. ivshmem 2.0 is a shared memory belonging to a VM that can be 
>>>>> read-only by all
>>>>>   other VMs that use the ivshmem 2.0 shared memory device, which 
>>>>> also does not
>>>>>   meet our needs in terms of security.
>>>>>
>>>>> ## vhost-pci and virtiovhostuser
>>>>>
>>>>>   Does not support dynamic allocation and therefore not suitable 
>>>>> for SMC.
>>>>
>>>> I think this is an implementation issue, we can support VHOST IOTLB
>>>> message then the regions could be added/removed on demand.
>>>
>>>
>>> 1. After the attacker connects with the victim, if the attacker does not
>>>   dereference memory, the memory will be occupied under 
>>> virtiovhostuser. In the
>>>   case of ism devices, the victim can directly release the 
>>> reference, and the
>>>   maliciously referenced region only occupies the attacker's resources
>>
>> Let's define the security boundary here. E.g do we trust the device or
>> not? If yes, in the case of virtiovhostuser, can we simple do
>> VHOST_IOTLB_UNMAP then we can safely release the memory from the
>> attacker.
> Thanks, Jason:)
> In our the design, there are several roles involved:
> 1) a virtio-ism-smc front-end driver
> 2) a Virtio-ism backend device driver and its associated vmm
> 3) a global device manager
> 4) a group of remote/peer virtio-ism backend devices/vmms
> 5) a group of remote/peer virtio-ism-smc front-end drivers
>
> Among which , we treat 1, 2 and 3 as trusted, 4 and 5 as untrusted.


It looks to me VIRTIO_ISM_PERM_MANAGE violates what you've described 
here. E.g what happens if 1 grant this permission to 5?


> Because 4 and 5 are trusted, we can’t guarantee that IOTLB Invalidate 
> requests have been executed as expected.


Interesting, I wonder how this is guaranteed by ISM. Anything that can 
work for ISM but not IOTLB? Note that the only difference for me is the 
device API. We can hook anything that works for ISM to IOTLB.


> Say when disconnecting an SMC connection, a malicious peer may ignore 
> the IOTLB invalidation request and keep access the shared memory region.
>
> We have considered the IOTLB based design but encountered several issues:
> 1) It depends on the way to provision guest vm memory. We need a 
> memory resource descriptor to support vhost-user IOTLB messages, thus 
> can’t support anonymous memory based vm.


Hypervisor (Qemu) is free to hook IOTLB message to any kind of memory 
backend, isn't? E.g Qemu can choose to implement IOTLB by its own 
instead of forwarding it to another VM.


> 2) Lack of fine-grain access control of memory resource descriptor. 
> When send a memory resource descriptor to an untrusted peer, we can’t 
> enforce region based access control. Memfd supports file level seal 
> operations, but still lack of region based permission control. 
> Hugetlbfs based fd doesn’t support seal at all.


So in the above, you said 4 and 5 are untrusted. If yes how you can 
enforce regioned based access control (the memory is still mapped by the 
untrsuted VMM)? And again, virtio-vhost-user is not limited to 
memfd/hugetlbfs, it can do want you've done in your protoype (hooking to 
/dev/shm).


> 3) Lack of reliable way to reclaim granted access permissions from 
> untrusted peers, as stated above.


It would be better to explain how this "reclaim" works.


> 4) How implement resource accounting. Say a vm has shared some memory 
> regions from peers, and those peers exited unexpectedly, then those 
> shared memory will be accounted to the victim vm, and may cause 
> unexpected OOM.
>
> Based on the above consideration, we adopted another design and 
> introduced the device manager to solve above issues:
> 1) the device manager is the owner of memory buffers.


I don't see the definition "device manager" in your proposal, this needs 
to be clarified in both the spec and the changelog or the cover letter.


> 2) the device manager creates a memfd for each memory buffer/region, 
> and configure SEALs according to requested access permissions.


Ok, but this seems not what you've implemented in your qemu prototype?


> 3) When a guest vm reclaims a shared memory buffer, the device manager 
> will provision a new memfd to the guest vm.


How can this be done for the untrusted peers?


> And it will take the responsibility to reclaim the old buffer from 
> peer and eventually release the old buffer.
> 4) Simplify the control communication channel. Every guest vm only 
> needs to talk with the device manager and no need to discover and 
> communicate with other peers.


Not sure but it's better not mandate any model in the application layer.

Thanks


>
> Thanks,
> Gerry
>
>>
>>>
>>> 2. The ism device of a VM can be shared with multiple (1000+) VMs at 
>>> the same
>>>   time, which is a challenge for virtiovhostuser
>>
>> Please elaborate more the the challenges, anything make
>> virtiovhostuser different?
>>
>>>
>>> 3. The sharing relationship of ism is dynamically increased, and 
>>> virtiovhostuser
>>>   determines the sharing relationship at startup.
>>
>> Not necessarily with IOTLB API?
>>
>>>
>>> 4. For security issues, the device under virtiovhostuser may mmap 
>>> more memory,
>>>   while ism only maps one region to other devices
>>
>> With VHOST_IOTLB_MAP, the map could be done per region.
>>
>> Thanks
>>
>>>
>>> Thanks.
>>>
>>>>
>>>> Thanks
>>>>
>>>>>
>>>>> # Design
>>>>>
>>>>>   This is a structure diagram based on ism sharing between two vms.
>>>>>
>>>>>    |-------------------------------------------------------------------------------------------------------------|
>>>>>    | |------------------------------------------------| 
>>>>>       |------------------------------------------------| |
>>>>>    | | Guest                                          |       | 
>>>>> Guest                                          | |
>>>>>    | |                                                |       | 
>>>>>                                                | |
>>>>>    | |   ----------------                             |       | 
>>>>>   ----------------                             | |
>>>>>    | |   |    driver    |     [M1]   [M2]   [M3]      |       | 
>>>>>   |    driver    |             [M2]   [M3]     | |
>>>>>    | |   ----------------       |      |      |       |       | 
>>>>>   ----------------               |      |      | |
>>>>>    | |    |cq|                  |map   |map   |map    |       | 
>>>>>    |cq|                          |map   |map   | |
>>>>>    | |    |  |                  |      |      |       |       | 
>>>>>    |  |                          |      |      | |
>>>>>    | |    |  |                -------------------     |       | 
>>>>>    |  |                --------------------    | |
>>>>>    | |----|--|----------------|  device memory  |-----| 
>>>>>       |----|--|----------------|  device memory   |----| |
>>>>>    | |    |  |                -------------------     |       | 
>>>>>    |  |                --------------------    | |
>>>>>    | |                                |               |       | 
>>>>>                               |                | |
>>>>>    | |                                |               |       | 
>>>>>                               |                | |
>>>>>    | | Qemu                           |               |       | 
>>>>> Qemu                          |                | |
>>>>>    | |--------------------------------+---------------| 
>>>>>       |-------------------------------+----------------| |
>>>>>    |                                  | 
>>>>>                                                       | 
>>>>>                  |
>>>>>    |                                  | 
>>>>>                                                       | 
>>>>>                  |
>>>>>    | 
>>>>>                                  |------------------------------+------------------------| 
>>>>>                  |
>>>>>    | 
>>>>>                                                                 | 
>>>>>                                           |
>>>>>    | 
>>>>>                                                                 | 
>>>>>                                           |
>>>>>    | 
>>>>>                                                   -------------------------- 
>>>>>                                |
>>>>>    |                                                    | M1 |   | 
>>>>> M2 |   | M3 |                                 |
>>>>>    | 
>>>>>                                                   -------------------------- 
>>>>>                                |
>>>>>    | 
>>>>>                                                                                                             |
>>>>>    | HOST 
>>>>>                                                                                                        |
>>>>>    ---------------------------------------------------------------------------------------------------------------
>>>>>
>>>>> # POC code
>>>>>
>>>>>   Kernel: 
>>>>> https://github.com/fengidri/linux-kernel-virtio-ism/commits/ism
>>>>>   Qemu: https://github.com/fengidri/qemu/commits/ism
>>>>>
>>>>> If there are any problems, please point them out.
>>>>>
>>>>> Hope to hear from you, thank you.
>>>>>
>>>>> [1] https://projectacrn.github.io/latest/tutorials/enable_ivshmem.html
>>>>> [2] https://dl.acm.org/doi/10.1145/2847562
>>>>> [3] https://hal.archives-ouvertes.fr/hal-00368622/document
>>>>> [4] https://lwn.net/Articles/711071/
>>>>> [5] 
>>>>> https://lore.kernel.org/netdev/20220720170048.20806-1-tonylu@linux.alibaba.com/T/
>>>>>
>>>>>
>>>>> Xuan Zhuo (2):
>>>>>  Reserve device id for ISM device
>>>>>  virtio-ism: introduce new device virtio-ism
>>>>>
>>>>> content.tex    |   3 +
>>>>> virtio-ism.tex | 340 +++++++++++++++++++++++++++++++++++++++++++++++++
>>>>> 2 files changed, 343 insertions(+)
>>>>> create mode 100644 virtio-ism.tex
>>>>>
>>>>> --
>>>>> 2.32.0.3.g01195cf9f
>>>>>
>>>>>
>>>>> ---------------------------------------------------------------------
>>>>> To unsubscribe, e-mail: 
>>>>> virtio-dev-unsubscribe@lists.oasis-open.org 
>>>>> <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
>>>>> For additional commands, e-mail: 
>>>>> virtio-dev-help@lists.oasis-open.org 
>>>>> <mailto:virtio-dev-help@lists.oasis-open.org>
>>>>>
>>>>
>>>
>>> ---------------------------------------------------------------------
>>> To unsubscribe, e-mail:virtio-dev-unsubscribe@lists.oasis-open.org
>>> For additional commands, e-mail:virtio-dev-help@lists.oasis-open.org
>

