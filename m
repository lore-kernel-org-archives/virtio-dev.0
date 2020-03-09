Return-Path: virtio-dev-return-6899-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7016D98425C
	for <virtio-dev@lists.oasis-open.org>; Mon,  9 Mar 2020 08:50:56 +0000 (UTC)
References: <CAJPjb1K2W=wcer3+6XNzi+pcyGPAU2E3HXbq5_cuBVNQad=_zg@mail.gmail.com>
 <20200309030251-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ff63b1e2-e4aa-1b13-0b4a-72fd23badc06@redhat.com>
Date: Mon, 9 Mar 2020 16:50:43 +0800
MIME-Version: 1.0
In-Reply-To: <20200309030251-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Subject: Re: [virtio-dev] Dirty Page Tracking (DPT)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Rob Miller <rob.miller@broadcom.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


On 2020/3/9 =E4=B8=8B=E5=8D=883:38, Michael S. Tsirkin wrote:
> On Fri, Mar 06, 2020 at 10:40:13AM -0500, Rob Miller wrote:
>> I understand that DPT isn't really on the forefront of the vDPA framewor=
k, but
>> wanted to understand if there any initial thoughts on how this would wor=
k...
> And judging by the next few chapters, you are actually
> talking about vhost pci, right?
>
>> In the migration framework, in its simplest form, (I gather) its QEMU vi=
a KVM
>> that is reading the dirty page table, converting bits to page numbers, t=
hen
>> flushing remote VM/copying local page(s)->remote VM, ect.
>>
>> While this is fine for a VM (say VM1) dirtying its own memory and the ac=
cesses
>> are trapped in the kernel as well as the log is being updated, I'm not s=
ure
>> what happens in the situation=C2=A0of vhost, where a remote VM (say VM2)=
 is dirtying
>> up VM1's memory since it can directly access it, during packet reception=
 for
>> example.
>> Whatever technique is employed=C2=A0to catch this, how would this differ=
 from a HW
>> based Virtio device doing DMA directly into a VM's DDR, wrt to DPT? Is Q=
EMU
>> going to have a 2nd place to query the dirty logs - ie: the vDPA layer?
> I don't think anyone has a good handle at the vhost pci migration yet.
> But I think a reasonable way to handle that would be to
> activate dirty tracking in VM2's QEMU.
>
> And then VM2's QEMU would periodically copy the bits to the log - does
> this sound right?
>
>> Further I heard about a SW based DPT within the vDPA framework for those
>> devices that do not (yet) support DPT inherently in HW. How is this envi=
sioned
>> to work?
> What I am aware of is simply switching to a software virtio
> for the duration of migration. The software can be pretty simple
> since the formats match: just copy available entries to device ring,
> and for used entries, see a used ring entry, mark page
> dirty and then copy used entry to guest ring.


That looks more heavyweight than e.g just relay used ring (as what dpdk=20
did) I believe?


>
>
> Another approach that I proposed and was prototyped at some point by
> Alex Duyck is guest driver touching the page in question before
> processing it within guest e.g. by an atomic xor with 0.
> Sounds attractive but didn't perform all that well.


Intel posted i40e software solution that traps queue tail/head write.=20
But I'm not sure it's good enough.

https://lore.kernel.org/kvm/20191206082232.GH31791@joy-OptiPlex-7040/


>
>
>> Finally, for those HW vendors that do support DPT in HW, a mapping of a =
bit ->
>> page isn't really an option, since no one wants to do a byte wide
>> read-modify-write across the PCI bus, but rather=C2=A0 map a whole byte =
to page is
>> likely more desirable - the HW can just do non-posted writes to the dirt=
y page
>> table. If byte wise, then the QEMU/vDPA layer has to either fix-up the m=
apping
>> (from byte->bit) or have the capability to handle the granularity diffs.
>>
>> Thoughts?
>>
>> Rob Miller
>> rob.miller@broadcom.com
>> (919)721-3339
> If using an IOMMU, DPT can also be done using either PRI or dirty bit in
> a PTE. PRI is an interrupt so it can kick off a thread to set bits in
> the log I guess, but if it's the dirty bit then I don't think there's an
> interrupt. And a polling thread does not sound attractive.  I guess
> we'll need a new interface to notify VDPA that QEMU is looking for dirty
> logs, and then VDPA can send them to QEMU in some way.  Will probably be
> good enough to support vendor specific logging interfaces, too.  I don't
> actually have hardware which supports either so actually coding it up is
> not yet practical.


Yes, both PRI and PTE dirty bit requires special hardware support. We=20
can extend vDPA API to support both. For page fault, probably just a=20
IOMMU page fault handler.


>
> Further, at my KVM forum presentaiton I proposed a virtio-specific
> pagefault handling interface.  If there's a wish to standardize and
> implement that, let me know and I will try to write this up in a more
> formal way.


Besides pagefault, if we want virito to be more like vhost, we need also=20
formalize the device state feching. E.g per vq index etc.

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

