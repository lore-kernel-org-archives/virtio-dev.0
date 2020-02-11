Return-Path: virtio-dev-return-6715-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 247AD9840F2
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Feb 2020 07:40:40 +0000 (UTC)
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
 <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
 <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
 <ad96269f-753d-54b8-a4ae-59d1595dd3b2@redhat.com>
 <5522f205-207b-b012-6631-3cc77dde3bfe@linux.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <45e22435-08d3-08fe-8843-d8db02fcb8e3@redhat.com>
Date: Tue, 11 Feb 2020 15:40:23 +0800
MIME-Version: 1.0
In-Reply-To: <5522f205-207b-b012-6631-3cc77dde3bfe@linux.intel.com>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt
 feature support
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Liu, Jing2" <jing2.liu@linux.intel.com>, Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, slp@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 2020/2/11 =E4=B8=8B=E5=8D=882:02, Liu, Jing2 wrote:
>
>
> On 2/11/2020 12:02 PM, Jason Wang wrote:
>>
>> On 2020/2/11 =E4=B8=8A=E5=8D=8811:35, Liu, Jing2 wrote:
>>>
>>> On 2/11/2020 11:17 AM, Jason Wang wrote:
>>>>
>>>> On 2020/2/10 =E4=B8=8B=E5=8D=885:05, Zha Bin wrote:
>>>>> From: Liu Jiang<gerry@linux.alibaba.com>
>>>>>
>>>>> Userspace VMMs (e.g. Qemu microvm, Firecracker) take advantage of=20
>>>>> using
>>>>> virtio over mmio devices as a lightweight machine model for modern
>>>>> cloud. The standard virtio over MMIO transport layer only supports=20
>>>>> one
>>>>> legacy interrupt, which is much heavier than virtio over PCI=20
>>>>> transport
>>>>> layer using MSI. Legacy interrupt has long work path and causes=20
>>>>> specific
>>>>> VMExits in following cases, which would considerably slow down the
>>>>> performance:
>>>>>
>>>>> 1) read interrupt status register
>>>>> 2) update interrupt status register
>>>>> 3) write IOAPIC EOI register
>>>>>
>>>>> We proposed to add MSI support for virtio over MMIO via new feature
>>>>> bit VIRTIO_F_MMIO_MSI[1] which increases the interrupt performance.
>>>>>
>>>>> With the VIRTIO_F_MMIO_MSI feature bit supported, the virtio-mmio MSI
>>>>> uses msi_sharing[1] to indicate the event and vector mapping.
>>>>> Bit 1 is 0: device uses non-sharing and fixed vector per event=20
>>>>> mapping.
>>>>> Bit 1 is 1: device uses sharing mode and dynamic mapping.
>>>>
>>>>
>>>> I believe dynamic mapping should cover the case of fixed vector?
>>>>
>>> Actually this bit *aims* for msi sharing or msi non-sharing.
>>>
>>> It means, when msi sharing bit is 1, device doesn't want vector per=20
>>> queue
>>>
>>> (it wants msi vector sharing as name) and doesn't want a high=20
>>> interrupt rate.
>>>
>>> So driver turns to !per_vq_vectors and has to do dynamical mapping.
>>>
>>> So they are opposite not superset.
>>>
>>> Thanks!
>>>
>>> Jing
>>
>>
>> I think you need add more comments on the command.
>>
>> E.g if I want to map vector 0 to queue 1, how do I need to do?
>>
>> write(1, queue_sel);
>> write(0, vector_sel);
>
> That's true. Besides, two commands are used for msi sharing mode,
>
> VIRTIO_MMIO_MSI_CMD_MAP_CONFIG and VIRTIO_MMIO_MSI_CMD_MAP_QUEUE.
>
> "To set up the event and vector mapping for MSI sharing mode, driver=20
> SHOULD write a valid MsiVecSel followed by=20
> VIRTIO_MMIO_MSI_CMD_MAP_CONFIG/VIRTIO_MMIO_MSI_CMD_MAP_QUEUE command=20
> to map the configuration change/selected queue events respectively.=C2=A0=
 "=20
> (See spec patch 5/5)
>
> So if driver detects the msi sharing mode, when it does setup vq,=20
> writes the queue_sel (this already exists in setup vq), vector sel and=20
> then MAP_QUEUE command to do the queue event mapping.
>

So actually the per vq msix could be done through this. I don't get why=20
you need to introduce MSI_SHARING_MASK which is the charge of driver=20
instead of device. The interrupt rate should have no direct relationship=20
with whether it has been shared or not.

Btw, you introduce mask/unmask without pending, how to deal with the=20
lost interrupt during the masking then?


> For msi non-sharing mode, no special action is needed because we make=20
> the rule of per_vq_vector and fixed relationship.
>
> Correct me if this is not that clear for spec/code comments.
>

The ABI is not as straightforward as PCI did. Why not just reuse the PCI=20
layout?

E.g having

queue_sel
queue_msix_vector
msix_config

for configuring map between msi vector and queues/config

Then

vector_sel
address
data
pending
mask
unmask

for configuring msi table?

Thanks


> Thanks!
>
> Jing
>
>
>>
>> ?
>>
>> Thanks
>>
>>
>>>
>>>
>>>> Thanks
>>>>
>>>>
>>>>
>>>> ---------------------------------------------------------------------
>>>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>>>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>>>
>>>
>>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

