Return-Path: <virtio-dev-return-10227-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3AB4E9864B3
	for <virtio-dev@lists.oasis-open.org>; Wed, 23 Nov 2022 15:27:08 +0000 (UTC)
Message-ID: <412f1bdf-724e-8b9d-4f28-213d82654f83@siemens.com>
Date: Wed, 23 Nov 2022 16:27:00 +0100
References: <20221017074724.89569-1-xuanzhuo@linux.alibaba.com>
 <1942d5c0-48e0-fd4c-5cfc-5ab31ae25914@siemens.com>
 <f6a44da5-4d23-308c-6c0a-895f45bf9ab0@siemens.com>
 <1668564815.5461683-5-xuanzhuo@linux.alibaba.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <1668564815.5461683-5-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH 0/2] introduce virtio-ism: internal shared
 memory device
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, gerry@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com, jasowang@redhat.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 16.11.22 03:13, Xuan Zhuo wrote:
> On Mon, 14 Nov 2022 22:30:53 +0100, Jan Kiszka <jan.kiszka@siemens.com> wrote:
>> On 18.10.22 09:32, Jan Kiszka wrote:
>>> On 17.10.22 09:47, Xuan Zhuo wrote:
>>>> Hello everyone,
>>>>
>>>> # Background
>>>>
>>>> Nowadays, there is a common scenario to accelerate communication between
>>>> different VMs and containers, including light weight virtual machine based
>>>> containers. One way to achieve this is to colocate them on the same host.
>>>> However, the performance of inter-VM communication through network stack is not
>>>> optimal and may also waste extra CPU cycles. This scenario has been discussed
>>>> many times, but still no generic solution available [1] [2] [3].
>>>>
>>>> With pci-ivshmem + SMC(Shared Memory Communications: [4]) based PoC[5],
>>>> We found that by changing the communication channel between VMs from TCP to SMC
>>>> with shared memory, we can achieve superior performance for a common
>>>> socket-based application[5]:
>>>>   - latency reduced by about 50%
>>>>   - throughput increased by about 300%
>>>>   - CPU consumption reduced by about 50%
>>>>
>>>> Since there is no particularly suitable shared memory management solution
>>>> matches the need for SMC(See ## Comparison with existing technology), and virtio
>>>> is the standard for communication in the virtualization world, we want to
>>>> implement a virtio-ism device based on virtio, which can support on-demand
>>>> memory sharing across VMs, containers or VM-container. To match the needs of SMC,
>>>> the virtio-ism device need to support:
>>>>
>>>> 1. Dynamic provision: shared memory regions are dynamically allocated and
>>>>    provisioned.
>>>> 2. Multi-region management: the shared memory is divided into regions,
>>>>    and a peer may allocate one or more regions from the same shared memory
>>>>    device.
>>>> 3. Permission control: The permission of each region can be set seperately.
>>>>
>>>> # Virtio ism device
>>>>
>>>> ISM devices provide the ability to share memory between different guests on a
>>>> host. A guest's memory got from ism device can be shared with multiple peers at
>>>> the same time. This shared relationship can be dynamically created and released.
>>>>
>>>> The shared memory obtained from the device is divided into multiple ism regions
>>>> for share. ISM device provides a mechanism to notify other ism region referrers
>>>> of content update events.
>>>>
>>>> # Usage (SMC as example)
>>>>
>>>> Maybe there is one of possible use cases:
>>>>
>>>> 1. SMC calls the interface ism_alloc_region() of the ism driver to return the
>>>>    location of a memory region in the PCI space and a token.
>>>> 2. The ism driver mmap the memory region and return to SMC with the token
>>>> 3. SMC passes the token to the connected peer
>>>> 3. the peer calls the ism driver interface ism_attach_region(token) to
>>>>    get the location of the PCI space of the shared memory
>>>>
>>>>
>>>> # About hot plugging of the ism device
>>>>
>>>>    Hot plugging of devices is a heavier, possibly failed, time-consuming, and
>>>>    less scalable operation. So, we don't plan to support it for now.
>>>>
>>>> # Comparison with existing technology
>>>>
>>>> ## ivshmem or ivshmem 2.0 of Qemu
>>>>
>>>>    1. ivshmem 1.0 is a large piece of memory that can be seen by all devices that
>>>>    use this VM, so the security is not enough.
>>>>
>>>>    2. ivshmem 2.0 is a shared memory belonging to a VM that can be read-only by all
>>>>    other VMs that use the ivshmem 2.0 shared memory device, which also does not
>>>>    meet our needs in terms of security.
>>>
>>> This is addressed by establishing separate links between VMs (modeled
>>> with separate devices). That is a trade-off between simplicity of the
>>> model and convenience, for sure.
>>
>> BTW, simplicity can also brings security because it reduces the trusted
>> code base.
>>
>> Another feature of ivshmem-v2 is permitting direct access to essential
>> resources of the device from /unprivileged/ userspace, including to the
>> event triggering registers. Is your model designed for that as well? It
>> not only permits VM-to-VM, it actually makes app-to-app (in VMs) very cheap.
> 
> Yes, there are two actual application scenarios or design goals:
> 
> * As we mentioned above, docking with SMC inside the linux kernel to achieve high-speed communication.
> * Virtio-ISM also has an interface below /dev. Ordinary users can also directly
>   obtain the SHM region resources to achieve sharing with other APPs on other
>   VMs.
> 
> https://github.com/fengidri/linux-kernel-virtio-ism/commit/55a8ed21344e26f574dd81b0213b0d61d80e2ecb
> https://github.com/fengidri/linux-kernel-virtio-ism/commit/6518739f9a9a36f25d5709da940b7a7938f8e0ee
> 

An example for the missing detach notification in ISM.

And the model of ivshmem-v2 permits syscall-free notification (sending,
not IRQ-based receiving, obviously). On reception, it avoids one vmexit
to throttle incoming events if you have continuously firing sender in
combination with a non-reacting unprivileged receiver task.

Would be great to combine the best of all worlds here. But specifically
missing life-cycle management on the detach side makes the ISM not
better than legacy ivshmem IHMO.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

