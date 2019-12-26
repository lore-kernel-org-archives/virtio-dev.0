Return-Path: virtio-dev-return-6571-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 51577985D91
	for <virtio-dev@lists.oasis-open.org>; Thu, 26 Dec 2019 08:09:56 +0000 (UTC)
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
 <229e689d-10f1-2bfb-c393-14dfa9c78971@redhat.com>
 <0460F92A-3DF6-4F7A-903B-6434555577CC@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <f8b46502-a5a5-c5c6-88df-101dbfd02fda@redhat.com>
Date: Thu, 26 Dec 2019 16:09:24 +0800
MIME-Version: 1.0
In-Reply-To: <0460F92A-3DF6-4F7A-903B-6434555577CC@linux.alibaba.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v1 2/2] virtio-mmio: add features for virtio-mmio
 specification version 3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Liu, Jiang" <gerry@linux.alibaba.com>
Cc: Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org, mst@redhat.com, slp@redhat.com, virtio-dev@lists.oasis-open.org, jing2.liu@intel.com, chao.p.peng@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 2019/12/25 =E4=B8=8B=E5=8D=8811:20, Liu, Jiang wrote:
>
>> On Dec 25, 2019, at 6:20 PM, Jason Wang <jasowang@redhat.com> wrote:
>>
>>
>> On 2019/12/25 =E4=B8=8A=E5=8D=8810:50, Zha Bin wrote:
>>> From: Liu Jiang <gerry@linux.alibaba.com>
>>>
>>> Userspace VMMs (e.g. Qemu microvm, Firecracker) take advantage of using
>>> virtio over mmio devices as a lightweight machine model for modern
>>> cloud. The standard virtio over MMIO transport layer only supports one
>>> legacy interrupt, which is much heavier than virtio over PCI transport
>>> layer using MSI. Legacy interrupt has long work path and causes specifi=
c
>>> VMExits in following cases, which would considerably slow down the
>>> performance:
>>>
>>> 1) read interrupt status register
>>> 2) update interrupt status register
>>> 3) write IOAPIC EOI register
>>>
>>> We proposed to update virtio over MMIO to version 3[1] to add the
>>> following new features and enhance the performance.
>>>
>>> 1) Support Message Signaled Interrupt(MSI), which increases the
>>>     interrupt performance for virtio multi-queue devices
>>> 2) Support per-queue doorbell, so the guest kernel may directly write
>>>     to the doorbells provided by virtio devices.
>>>
>>> The following is the network tcp_rr performance testing report, tested
>>> with virtio-pci device, vanilla virtio-mmio device and patched
>>> virtio-mmio device (run test 3 times for each case):
>>>
>>> =09netperf -t TCP_RR -H 192.168.1.36 -l 30 -- -r 32,1024
>>>
>>> =09=09Virtio-PCI    Virtio-MMIO   Virtio-MMIO(MSI)
>>> =09trans/s=09    9536=096939=09=099500
>>> =09trans/s=09    9734=097029=09=099749
>>> =09trans/s=09    9894=097095=09=099318
>>>
>>> [1] https://lkml.org/lkml/2019/12/20/113
>>
>> Thanks for the patch. Two questions after a quick glance:
>>
>> 1) In PCI we choose to support MSI-X instead of MSI for having extra fle=
xibility like alias, independent data and address (e.g for affinity) . Any =
reason for not start from MSI-X? E.g having MSI-X table and PBA (both of wh=
ich looks pretty independent).
> Hi Jason,
> =09Thanks for reviewing patches on Christmas Day:)
> =09The PCI MSI-x has several advantages over PCI MSI, mainly
> 1) support 2048 vectors, much more than 32 vectors supported by MSI.
> 2) dedicated address/data for each vector,
> 3) per vector mask/pending bits.
> The proposed MMIO MSI extension supports both 1) and 2),


Aha right, I mis-read the patch. But more questions comes:

1) The association between vq and MSI-X vector is fixed. This means it=20
can't work for a device that have more than 2047 queues. We probably=20
need something similar to virtio-pci to allow a dynamic association.
2) The mask and unmask control is missed


>   but the extension doesn=E2=80=99t support 3) because
> we noticed that the Linux virtio subsystem doesn=E2=80=99t really make us=
e of interrupt masking/unmasking.


Not directly used but masking/unmasking is widely used in irq subsystem=20
which allows lots of optimizations.


>
> On the other hand, we want to simplify VMM implementations as simple as p=
ossible, and mimicking the PCI MSI-x
> will cause some complexity to VMM implementations.


I agree to simplify VMM implementation, but it looks to me introducing=20
masking/pending won't cost too much code in the VMM implementation. Just=20
new type of command for VIRTIO_MMIO_MSI_COMMAND.

Thanks


>
>> 2) It's better to split notify_multiplexer out of MSI support to ease th=
e reviewers (apply to spec patch as well)
> Great suggestion, we will try to split the patch.
>
> Thanks,
> Gerry
>
>> Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

