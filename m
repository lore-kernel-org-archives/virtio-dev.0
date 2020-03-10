Return-Path: virtio-dev-return-6908-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 312E3985D7D
	for <virtio-dev@lists.oasis-open.org>; Tue, 10 Mar 2020 03:22:13 +0000 (UTC)
References: <CAJPjb1K2W=wcer3+6XNzi+pcyGPAU2E3HXbq5_cuBVNQad=_zg@mail.gmail.com>
 <20200309030251-mutt-send-email-mst@kernel.org>
 <ff63b1e2-e4aa-1b13-0b4a-72fd23badc06@redhat.com>
 <20200309060238-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fdedf8ac-74ed-f502-daef-38896f23e526@redhat.com>
Date: Tue, 10 Mar 2020 11:22:00 +0800
MIME-Version: 1.0
In-Reply-To: <20200309060238-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Subject: Re: [virtio-dev] Dirty Page Tracking (DPT)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Rob Miller <rob.miller@broadcom.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


On 2020/3/9 =E4=B8=8B=E5=8D=886:13, Michael S. Tsirkin wrote:
> On Mon, Mar 09, 2020 at 04:50:43PM +0800, Jason Wang wrote:
>> On 2020/3/9 =E4=B8=8B=E5=8D=883:38, Michael S. Tsirkin wrote:
>>> On Fri, Mar 06, 2020 at 10:40:13AM -0500, Rob Miller wrote:
>>>> I understand that DPT isn't really on the forefront of the vDPA framew=
ork, but
>>>> wanted to understand if there any initial thoughts on how this would w=
ork...
>>> And judging by the next few chapters, you are actually
>>> talking about vhost pci, right?
>>>
>>>> In the migration framework, in its simplest form, (I gather) its QEMU =
via KVM
>>>> that is reading the dirty page table, converting bits to page numbers,=
 then
>>>> flushing remote VM/copying local page(s)->remote VM, ect.
>>>>
>>>> While this is fine for a VM (say VM1) dirtying its own memory and the =
accesses
>>>> are trapped in the kernel as well as the log is being updated, I'm not=
 sure
>>>> what happens in the situation=C2=A0of vhost, where a remote VM (say VM=
2) is dirtying
>>>> up VM1's memory since it can directly access it, during packet recepti=
on for
>>>> example.
>>>> Whatever technique is employed=C2=A0to catch this, how would this diff=
er from a HW
>>>> based Virtio device doing DMA directly into a VM's DDR, wrt to DPT? Is=
 QEMU
>>>> going to have a 2nd place to query the dirty logs - ie: the vDPA layer=
?
>>> I don't think anyone has a good handle at the vhost pci migration yet.
>>> But I think a reasonable way to handle that would be to
>>> activate dirty tracking in VM2's QEMU.
>>>
>>> And then VM2's QEMU would periodically copy the bits to the log - does
>>> this sound right?
>>>
>>>> Further I heard about a SW based DPT within the vDPA framework for tho=
se
>>>> devices that do not (yet) support DPT inherently in HW. How is this en=
visioned
>>>> to work?
>>> What I am aware of is simply switching to a software virtio
>>> for the duration of migration. The software can be pretty simple
>>> since the formats match: just copy available entries to device ring,
>>> and for used entries, see a used ring entry, mark page
>>> dirty and then copy used entry to guest ring.
>>
>> That looks more heavyweight than e.g just relay used ring (as what dpdk =
did)
>> I believe?
> That works for used but not for the packed ring.


For packed ring, we can relay the descriptor ring?


>
>>>
>>> Another approach that I proposed and was prototyped at some point by
>>> Alex Duyck is guest driver touching the page in question before
>>> processing it within guest e.g. by an atomic xor with 0.
>>> Sounds attractive but didn't perform all that well.
>>
>> Intel posted i40e software solution that traps queue tail/head write. Bu=
t
>> I'm not sure it's good enough.
>>
>> https://lore.kernel.org/kvm/20191206082232.GH31791@joy-OptiPlex-7040/
>
> DMA unmap time seems more generic to me. But again I suspect
> the main issue is the same - it's handled on the data path
> blocking packet RX until dirty tracking is handled.
>
> Hardware solutions by comparison queue writes and make
> progress, dirty page is handled by the migration CPU.
>
>
>>>
>>>> Finally, for those HW vendors that do support DPT in HW, a mapping of =
a bit ->
>>>> page isn't really an option, since no one wants to do a byte wide
>>>> read-modify-write across the PCI bus, but rather=C2=A0 map a whole byt=
e to page is
>>>> likely more desirable - the HW can just do non-posted writes to the di=
rty page
>>>> table. If byte wise, then the QEMU/vDPA layer has to either fix-up the=
 mapping
>>>> (from byte->bit) or have the capability to handle the granularity diff=
s.
>>>>
>>>> Thoughts?
>>>>
>>>> Rob Miller
>>>> rob.miller@broadcom.com
>>>> (919)721-3339
>>> If using an IOMMU, DPT can also be done using either PRI or dirty bit i=
n
>>> a PTE. PRI is an interrupt so it can kick off a thread to set bits in
>>> the log I guess, but if it's the dirty bit then I don't think there's a=
n
>>> interrupt. And a polling thread does not sound attractive.  I guess
>>> we'll need a new interface to notify VDPA that QEMU is looking for dirt=
y
>>> logs, and then VDPA can send them to QEMU in some way.  Will probably b=
e
>>> good enough to support vendor specific logging interfaces, too.  I don'=
t
>>> actually have hardware which supports either so actually coding it up i=
s
>>> not yet practical.
>>
>> Yes, both PRI and PTE dirty bit requires special hardware support. We ca=
n
>> extend vDPA API to support both. For page fault, probably just a IOMMU p=
age
>> fault handler.
>>
>>
>>> Further, at my KVM forum presentaiton I proposed a virtio-specific
>>> pagefault handling interface.  If there's a wish to standardize and
>>> implement that, let me know and I will try to write this up in a more
>>> formal way.
>>
>> Besides pagefault, if we want virito to be more like vhost, we need also
>> formalize the device state feching. E.g per vq index etc.
>>
>> Thanks
> Yes that would clearly be in-scope for the spec.   I would not start
> with a guest/host interface even.  I would start by just listing what
> the state that needs to be migrated is, for each device. And it would
> also be useful to list, for each device, how to make two devices
> compatible migration wise.  We can do that in a non-normative section.
> Again the big blocker here is lack of manpower.


Yes.

Thanks

>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

