Return-Path: virtio-dev-return-6713-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DE69C985D19
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Feb 2020 04:03:06 +0000 (UTC)
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c3d13be5a391b1fc50416838de57d903cbf8038.1581305609.git.zhabin@linux.alibaba.com>
 <0c71ff9d-1a7f-cfd2-e682-71b181bdeae4@redhat.com>
 <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ad96269f-753d-54b8-a4ae-59d1595dd3b2@redhat.com>
Date: Tue, 11 Feb 2020 12:02:50 +0800
MIME-Version: 1.0
In-Reply-To: <c42c8b49-5357-f341-2942-ba84afc25437@linux.intel.com>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH v2 4/5] virtio-mmio: add MSI interrupt
 feature support
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Liu, Jing2" <jing2.liu@linux.intel.com>, Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org
Cc: virtio-dev@lists.oasis-open.org, slp@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, chao.p.peng@linux.intel.com, gerry@linux.alibaba.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 2020/2/11 =E4=B8=8A=E5=8D=8811:35, Liu, Jing2 wrote:
>
> On 2/11/2020 11:17 AM, Jason Wang wrote:
>>
>> On 2020/2/10 =E4=B8=8B=E5=8D=885:05, Zha Bin wrote:
>>> From: Liu Jiang<gerry@linux.alibaba.com>
>>>
>>> Userspace VMMs (e.g. Qemu microvm, Firecracker) take advantage of using
>>> virtio over mmio devices as a lightweight machine model for modern
>>> cloud. The standard virtio over MMIO transport layer only supports one
>>> legacy interrupt, which is much heavier than virtio over PCI transport
>>> layer using MSI. Legacy interrupt has long work path and causes=20
>>> specific
>>> VMExits in following cases, which would considerably slow down the
>>> performance:
>>>
>>> 1) read interrupt status register
>>> 2) update interrupt status register
>>> 3) write IOAPIC EOI register
>>>
>>> We proposed to add MSI support for virtio over MMIO via new feature
>>> bit VIRTIO_F_MMIO_MSI[1] which increases the interrupt performance.
>>>
>>> With the VIRTIO_F_MMIO_MSI feature bit supported, the virtio-mmio MSI
>>> uses msi_sharing[1] to indicate the event and vector mapping.
>>> Bit 1 is 0: device uses non-sharing and fixed vector per event mapping.
>>> Bit 1 is 1: device uses sharing mode and dynamic mapping.
>>
>>
>> I believe dynamic mapping should cover the case of fixed vector?
>>
> Actually this bit *aims* for msi sharing or msi non-sharing.
>
> It means, when msi sharing bit is 1, device doesn't want vector per queue
>
> (it wants msi vector sharing as name) and doesn't want a high=20
> interrupt rate.
>
> So driver turns to !per_vq_vectors and has to do dynamical mapping.
>
> So they are opposite not superset.
>
> Thanks!
>
> Jing


I think you need add more comments on the command.

E.g if I want to map vector 0 to queue 1, how do I need to do?

write(1, queue_sel);
write(0, vector_sel);

?

Thanks


>
>
>> Thanks
>>
>>
>>
>> ---------------------------------------------------------------------
>> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>>
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

