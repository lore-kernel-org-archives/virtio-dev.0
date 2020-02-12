Return-Path: virtio-dev-return-6742-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 57B33985DD2
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Feb 2020 09:07:20 +0000 (UTC)
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
 <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
 <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
 <ad96269f-753d-54b8-a4ae-59d1595dd3b2@redhat.com>
 <5522f205-207b-b012-6631-3cc77dde3bfe@linux.intel.com>
 <45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com>
 <4c19292f-9d25-a859-3dde-6dd5a03fdf0b@linux.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <44209f3c-613c-3766-ca83-321b77b0f0dd@redhat.com>
Date: Wed, 12 Feb 2020 17:06:52 +0800
MIME-Version: 1.0
In-Reply-To: <4c19292f-9d25-a859-3dde-6dd5a03fdf0b@linux.intel.com>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt
 feature support
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Liu, Jing2" <jing2.liu@linux.intel.com>, Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, slp@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 2020/2/12 =E4=B8=8A=E5=8D=8811:54, Liu, Jing2 wrote:
>
>
> On 2/11/2020 3:40 PM, Jason Wang wrote:
>>
>> On 2020/2/11 =E4=B8=8B=E5=8D=882:02, Liu, Jing2 wrote:
>>>
>>>
>>> On 2/11/2020 12:02 PM, Jason Wang wrote:
>>>>
>>>> On 2020/2/11 =E4=B8=8A=E5=8D=8811:35, Liu, Jing2 wrote:
>>>>>
>>>>> On 2/11/2020 11:17 AM, Jason Wang wrote:
>>>>>>
>>>>>> On 2020/2/10 =E4=B8=8B=E5=8D=885:05, Zha Bin wrote:
>>>>>>> From: Liu Jiang<gerry@linux.alibaba.com>
>>>>>>>
>>>>>>> Userspace VMMs (e.g. Qemu microvm, Firecracker) take advantage=20
>>>>>>> of using
>>>>>>> virtio over mmio devices as a lightweight machine model for modern
>>>>>>> cloud. The standard virtio over MMIO transport layer only=20
>>>>>>> supports one
>>>>>>> legacy interrupt, which is much heavier than virtio over PCI=20
>>>>>>> transport
>>>>>>> layer using MSI. Legacy interrupt has long work path and causes=20
>>>>>>> specific
>>>>>>> VMExits in following cases, which would considerably slow down the
>>>>>>> performance:
>>>>>>>
>>>>>>> 1) read interrupt status register
>>>>>>> 2) update interrupt status register
>>>>>>> 3) write IOAPIC EOI register
>>>>>>>
>>>>>>> We proposed to add MSI support for virtio over MMIO via new feature
>>>>>>> bit VIRTIO_F_MMIO_MSI[1] which increases the interrupt performance.
>>>>>>>
>>>>>>> With the VIRTIO_F_MMIO_MSI feature bit supported, the=20
>>>>>>> virtio-mmio MSI
>>>>>>> uses msi_sharing[1] to indicate the event and vector mapping.
>>>>>>> Bit 1 is 0: device uses non-sharing and fixed vector per event=20
>>>>>>> mapping.
>>>>>>> Bit 1 is 1: device uses sharing mode and dynamic mapping.
>>>>>>
>>>>>>
>>>>>> I believe dynamic mapping should cover the case of fixed vector?
>>>>>>
>>>>> Actually this bit *aims* for msi sharing or msi non-sharing.
>>>>>
>>>>> It means, when msi sharing bit is 1, device doesn't want vector=20
>>>>> per queue
>>>>>
>>>>> (it wants msi vector sharing as name) and doesn't want a high=20
>>>>> interrupt rate.
>>>>>
>>>>> So driver turns to !per_vq_vectors and has to do dynamical mapping.
>>>>>
>>>>> So they are opposite not superset.
>>>>>
>>>>> Thanks!
>>>>>
>>>>> Jing
>>>>
>>>>
>>>> I think you need add more comments on the command.
>>>>
>>>> E.g if I want to map vector 0 to queue 1, how do I need to do?
>>>>
>>>> write(1, queue_sel);
>>>> write(0, vector_sel);
>>>
>>> That's true. Besides, two commands are used for msi sharing mode,
>>>
>>> VIRTIO_MMIO_MSI_CMD_MAP_CONFIG and VIRTIO_MMIO_MSI_CMD_MAP_QUEUE.
>>>
>>> "To set up the event and vector mapping for MSI sharing mode, driver=20
>>> SHOULD write a valid MsiVecSel followed by=20
>>> VIRTIO_MMIO_MSI_CMD_MAP_CONFIG/VIRTIO_MMIO_MSI_CMD_MAP_QUEUE command=20
>>> to map the configuration change/selected queue events respectively.=C2=
=A0=20
>>> " (See spec patch 5/5)
>>>
>>> So if driver detects the msi sharing mode, when it does setup vq,=20
>>> writes the queue_sel (this already exists in setup vq), vector sel=20
>>> and then MAP_QUEUE command to do the queue event mapping.
>>>
>>
>> So actually the per vq msix could be done through this.=20
>
> Right, per vq msix can also be mapped by the 2 commands if we want.
>
> The current design benefits for those devices requesting per vq msi=20
> that driver
>
> doesn't have to map during setup each queue,
>
> since we define the relationship by default.
>

Well since you've defined the dynamic mapping, having some "default"=20
mapping won't help to reduce the complexity but increase it.


>
>> I don't get why you need to introduce MSI_SHARING_MASK which is the=20
>> charge of driver instead of device.=20
>
> MSI_SHARING_MASK is just for identifying the msi_sharing bit in=20
> readl(MsiState) (0x0c4). The device tells whether it wants msi_sharing.
>
> MsiState register: R
>
> le32 {
> =C2=A0=C2=A0=C2=A0 msi_enabled : 1;
> =C2=A0=C2=A0=C2=A0 msi_sharing: 1;
> =C2=A0=C2=A0=C2=A0 reserved : 30;
> };
>

The question is why device want such information.


>
>> The interrupt rate should have no direct relationship with whether it=20
>> has been shared or not.
>
>>
>> Btw, you introduce mask/unmask without pending, how to deal with the=20
>> lost interrupt during the masking then?
>>
>>
>>> For msi non-sharing mode, no special action is needed because we=20
>>> make the rule of per_vq_vector and fixed relationship.
>>>
>>> Correct me if this is not that clear for spec/code comments.
>>>
>>
>> The ABI is not as straightforward as PCI did. Why not just reuse the=20
>> PCI layout?
>>
>> E.g having
>>
>> queue_sel
>> queue_msix_vector
>> msix_config
>>
>> for configuring map between msi vector and queues/config
>
> Thanks for the advice. :)
>
> Actually when looking into pci, the queue_msix_vector/msix_config is=20
> the msi vector index, which is the same as the mmio register MsiVecSel=20
> (0x0d0).
>
> So we don't introduce two extra registers for mapping even in sharing=20
> mode.
>
> What do you think?
>

I'm not sure I get the point, but I still prefer the separate vector_sel=20
from queue_msix_vector.

Btw, Michael propose per vq registers which could also work.

Thanks


>
>>
>> Then
>>
>> vector_sel
>> address
>> data
>> pending
>> mask
>> unmask
>>
>> for configuring msi table?
>
> PCI-like msix table is not introduced to device and instead simply use=20
> commands to tell the mask/configure/enable.
>
> Thanks!
>
> Jing
>
>>
>> Thanks
>>
>>
>>> Thanks!
>>>
>>> Jing
>>>
>>>
>>>>
>>>> ?
>>>>
>>>> Thanks
>>>>
>>>>
>>>>>
>>>>>
>>>>>> Thanks
>>>>>>
>>>>>>
>>>>>>
>>>>>> --------------------------------------------------------------------=
-=20
>>>>>>
>>>>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>>>>> For additional commands, e-mail:=20
>>>>>> virtio-dev-help@lists.oasis-open.org
>>>>>>
>>>>>
>>>>
>>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

