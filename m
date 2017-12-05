Return-Path: virtio-dev-return-2750-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 96CBD5818F5C
	for <virtio-dev@lists.oasis-open.org>; Tue,  5 Dec 2017 02:34:23 -0800 (PST)
Message-ID: <5A2676A4.9060801@intel.com>
Date: Tue, 05 Dec 2017 18:36:20 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com> <3be9aa23-ca3b-2b16-ecf1-83388365c6b0@redhat.com> <5A264780.2030808@intel.com> <668fc7b0-4a3a-7a3b-e939-7a0d80c03166@redhat.com> <B84047ECBD981D4B93EAE5A6245AA3610159300B@FRAEML521-MBX.china.huawei.com>
In-Reply-To: <B84047ECBD981D4B93EAE5A6245AA3610159300B@FRAEML521-MBX.china.huawei.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] [PATCH v3 0/7] Vhost-pci for inter-VM communication
To: "Avi Cohen (A)" <avi.cohen@huawei.com>, Jason Wang <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>
Cc: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "zhiyong.yang@intel.com" <zhiyong.yang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 12/05/2017 04:49 PM, Avi Cohen (A) wrote:
>
>> -----Original Message-----
>> From: Jason Wang [mailto:jasowang@redhat.com]
>> Sent: Tuesday, 05 December, 2017 9:19 AM
>> To: Wei Wang; virtio-dev@lists.oasis-open.org; qemu-devel@nongnu.org;
>> mst@redhat.com; marcandre.lureau@redhat.com; stefanha@redhat.com;
>> pbonzini@redhat.com
>> Cc: jan.kiszka@siemens.com; Avi Cohen (A); zhiyong.yang@intel.com
>> Subject: Re: [virtio-dev] [PATCH v3 0/7] Vhost-pci for inter-VM communication
>>
>>
>>
>> On 2017年12月05日 15:15, Wei Wang wrote:
>>> On 12/05/2017 03:01 PM, Jason Wang wrote:
>>>>
>>>> On 2017年12月05日 11:33, Wei Wang wrote:
>>>>> Vhost-pci is a point-to-point based inter-VM communication solution.
>>>>> This
>>>>> patch series implements the vhost-pci-net device setup and
>>>>> emulation. The device is implemented as a virtio device, and it is
>>>>> set up via the vhost-user protocol to get the neessary info (e.g the
>>>>> memory info of the remote VM, vring info).
>>>>>
>>>>> Currently, only the fundamental functions are implemented. More
>>>>> features, such as MQ and live migration, will be updated in the
>>>>> future.
>>>>>
>>>>> The DPDK PMD of vhost-pci has been posted to the dpdk mailinglist here:
>>>>> http://dpdk.org/ml/archives/dev/2017-November/082615.html
>>>>>
>>>>> v2->v3 changes:
>>>>> 1) static device creation: instead of creating and hot-plugging the
>>>>>      device when receiving a vhost-user msg, the device is not
>>>>> created
>>>>>      via the qemu booting command line.
>>>>> 2) remove vqs: rq and ctrlq are removed in this version.
>>>>>       - receive vq: the receive vq is not needed anymore. The PMD
>>>>> directly
>>>>>                     shares the remote txq and rxq - grab from remote
>>>>> txq to
>>>>>                     receive packets, and put to rxq to send packets.
>>>>>       - ctrlq: the ctrlq is replaced by the first 4KB metadata area
>>>>> of the
>>>>>                device Bar-2.
>>>>> 3) simpler implementation: the entire implementation has been
>>>>> tailored
>>>>>      from ~1800 LOC to ~850 LOC.
>>>> Hi:
>>>>
>>>> Any performance numbers you can share?
>>>>
>>> Hi Jason,
>>>
>>> Performance testing and tuning on the data plane is in progress (btw,
>>> that wouldn't affect the device part patches).
>>> If possible, could we start the device part patch review in the meantime?
>>>
>>> Best,
>>> Wei
>>>
>> Hi Wei:
>>
>> Will do, but basically, the cover lacks of the motivation for vhost-pci and I want
>> to see some numbers first since I suspect it can over-perform exist data-path.
>>
>> Thanks
> [Avi Cohen (A)]
> Hi Wei
> I can try testing to get **numbers**  - I can do it now , need a little help from you
> I've started with downloading/building and installing  of > driver: https://github.com/wei-w-wang/vhost-pci-driver  to the kernel guest,
>   **without**  downloading the 2nd patch > device: https://github.com/wei-w-wang/vhost-pci-device
> But my guest kernel was corrupted after reboot (kernel panic/out of mem ..) -  can you tell me the steps to apply these patches ?
> Best Regards
> Avi

The kernel driver do have some bugs in some environment, so it might be 
a good source to get feeling about how it works, but I wouldn't 
recommend you to test it by yourself at this point.

We are currently focusing on the dpdk pmd, and wouldn't get back to the 
kernel driver until all are merged. Sorry about that.

Best,
Wei


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

