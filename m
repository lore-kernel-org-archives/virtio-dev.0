Return-Path: virtio-dev-return-6577-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 34EAA985C94
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Jan 2020 06:29:24 +0000 (UTC)
References: <cover.1577240905.git.zhabin@linux.alibaba.com>
 <a11d4c616158c9fb1ca4575ca0530b2e17b952fa.1577240905.git.zhabin@linux.alibaba.com>
 <229e689d-10f1-2bfb-c393-14dfa9c78971@redhat.com>
 <0460F92A-3DF6-4F7A-903B-6434555577CC@linux.alibaba.com>
 <f8b46502-a5a5-c5c6-88df-101dbfd02fda@redhat.com>
 <56703BDA-B7AE-4656-8061-85FD1A130597@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <16000124-bf6f-5762-845c-80514d1e6ea7@redhat.com>
Date: Thu, 2 Jan 2020 14:28:52 +0800
MIME-Version: 1.0
In-Reply-To: <56703BDA-B7AE-4656-8061-85FD1A130597@linux.alibaba.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v1 2/2] virtio-mmio: add features for virtio-mmio
 specification version 3
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Liu, Jiang" <gerry@linux.alibaba.com>
Cc: Zha Bin <zhabin@linux.alibaba.com>, linux-kernel@vger.kernel.org, mst@redhat.com, slp@redhat.com, virtio-dev@lists.oasis-open.org, jing2.liu@intel.com, chao.p.peng@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 2019/12/26 =E4=B8=8B=E5=8D=889:16, Liu, Jiang wrote:
>
>> On Dec 26, 2019, at 4:09 PM, Jason Wang <jasowang@redhat.com> wrote:
>>
>>
>> On 2019/12/25 =E4=B8=8B=E5=8D=8811:20, Liu, Jiang wrote:
>>>> On Dec 25, 2019, at 6:20 PM, Jason Wang <jasowang@redhat.com> wrote:
>>>>
>>>>
>>>> On 2019/12/25 =E4=B8=8A=E5=8D=8810:50, Zha Bin wrote:
>>>>> From: Liu Jiang <gerry@linux.alibaba.com>
>>>>>
>>>>> Userspace VMMs (e.g. Qemu microvm, Firecracker) take advantage of usi=
ng
>>>>> virtio over mmio devices as a lightweight machine model for modern
>>>>> cloud. The standard virtio over MMIO transport layer only supports on=
e
>>>>> legacy interrupt, which is much heavier than virtio over PCI transpor=
t
>>>>> layer using MSI. Legacy interrupt has long work path and causes speci=
fic
>>>>> VMExits in following cases, which would considerably slow down the
>>>>> performance:
>>>>>
>>>>> 1) read interrupt status register
>>>>> 2) update interrupt status register
>>>>> 3) write IOAPIC EOI register
>>>>>
>>>>> We proposed to update virtio over MMIO to version 3[1] to add the
>>>>> following new features and enhance the performance.
>>>>>
>>>>> 1) Support Message Signaled Interrupt(MSI), which increases the
>>>>>     interrupt performance for virtio multi-queue devices
>>>>> 2) Support per-queue doorbell, so the guest kernel may directly write
>>>>>     to the doorbells provided by virtio devices.
>>>>>
>>>>> The following is the network tcp_rr performance testing report, teste=
d
>>>>> with virtio-pci device, vanilla virtio-mmio device and patched
>>>>> virtio-mmio device (run test 3 times for each case):
>>>>>
>>>>> =09netperf -t TCP_RR -H 192.168.1.36 -l 30 -- -r 32,1024
>>>>>
>>>>> =09=09Virtio-PCI    Virtio-MMIO   Virtio-MMIO(MSI)
>>>>> =09trans/s=09    9536=096939=09=099500
>>>>> =09trans/s=09    9734=097029=09=099749
>>>>> =09trans/s=09    9894=097095=09=099318
>>>>>
>>>>> [1] https://lkml.org/lkml/2019/12/20/113
>>>> Thanks for the patch. Two questions after a quick glance:
>>>>
>>>> 1) In PCI we choose to support MSI-X instead of MSI for having extra f=
lexibility like alias, independent data and address (e.g for affinity) . An=
y reason for not start from MSI-X? E.g having MSI-X table and PBA (both of =
which looks pretty independent).
>>> Hi Jason,
>>> =09Thanks for reviewing patches on Christmas Day:)
>>> =09The PCI MSI-x has several advantages over PCI MSI, mainly
>>> 1) support 2048 vectors, much more than 32 vectors supported by MSI.
>>> 2) dedicated address/data for each vector,
>>> 3) per vector mask/pending bits.
>>> The proposed MMIO MSI extension supports both 1) and 2),
>>
>> Aha right, I mis-read the patch. But more questions comes:
>>
>> 1) The association between vq and MSI-X vector is fixed. This means it c=
an't work for a device that have more than 2047 queues. We probably need so=
mething similar to virtio-pci to allow a dynamic association.
> We have considered both the PCI MSI-x like dynamic association design and=
 fix mapping design.
> The fix mapping design simplifies both the interrupt configuration proces=
s and VMM implementations.


Well, for VMM just an indirection and for guest, it can choose to use=20
fixed mapping, just need to program once during probe.


> And the virtio mmio transport layer is mainly used by light VMMs to suppo=
rt small scale virtual machines,


Let's not limit the interface to be used by a specific case :).=20
Eliminating PCIE would be appealing for other scenarios.


>    2048 vectors should be enough for these usage cases.
> So the fix mapping design has been used.
>
>> 2) The mask and unmask control is missed
>>
>>
>>>   but the extension doesn=E2=80=99t support 3) because
>>> we noticed that the Linux virtio subsystem doesn=E2=80=99t really make =
use of interrupt masking/unmasking.
>>
>> Not directly used but masking/unmasking is widely used in irq subsystem =
which allows lots of optimizations.
>>
>>
>>> On the other hand, we want to simplify VMM implementations as simple as=
 possible, and mimicking the PCI MSI-x
>>> will cause some complexity to VMM implementations.
>>
>> I agree to simplify VMM implementation, but it looks to me introducing m=
asking/pending won't cost too much code in the VMM implementation. Just new=
 type of command for VIRTIO_MMIO_MSI_COMMAND.
> We want to make VMM implementations as simple as possible:)
> And based on following observations, we have disabled support of mask/unm=
ask,
> 1) MSI is edge triggering, which means it won=E2=80=99t be shared with ot=
her interrupt sources,


Is this true? I think the spec does not forbid such usages, e.g using=20
the same MSI address/command for different queues or devices?


> so masking/unmasking won=E2=80=99t be used for normal interrupt managemen=
t logic.
> 2) Linux virtio mmio transport layer doesn=E2=80=99t support  suspend/res=
ume yet, so there=E2=80=99s no need to quiesce the device by masking interr=
upts.


Yes, but it's a limitation only for virtio mmio transport. We can add it.


> 3) The legacy PCI 2.2 devices doesn=E2=80=99t support irq masking/unmaski=
ng, so irq masking/unmasking may be optional operations.


Yes, but as you said, it helps for performance and some other cases. I=20
still prefer to implement that consider it is not complex. If we do MSI=20
without masking/unmasking, I suspect we will implement MSI-X finally=20
somedays then maintaining MSI will become a burden... (still takes=20
virtio-pci as an example, it choose to implement MSI-X not MSI).


> So we skipped support of irq masking/unmasking. We will recheck whether i=
rq masking/unmasking is mandatory for MMIO devices.
> On the other hand, we may enhance the spec to define command codes for ma=
sking/unmasking, and VMM may optionally support masking/unmasking.


Yes, thanks.


>
> Thanks,
> Gerry
>
>> Thanks
>>
>>
>>>> 2) It's better to split notify_multiplexer out of MSI support to ease =
the reviewers (apply to spec patch as well)
>>> Great suggestion, we will try to split the patch.
>>>
>>> Thanks,
>>> Gerry
>>>
>>>> Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

