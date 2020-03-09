Return-Path: virtio-dev-return-6897-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 55AD098425C
	for <virtio-dev@lists.oasis-open.org>; Mon,  9 Mar 2020 07:38:24 +0000 (UTC)
Date: Mon, 9 Mar 2020 03:38:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200309030251-mutt-send-email-mst@kernel.org>
References: <CAJPjb1K2W=wcer3+6XNzi+pcyGPAU2E3HXbq5_cuBVNQad=_zg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJPjb1K2W=wcer3+6XNzi+pcyGPAU2E3HXbq5_cuBVNQad=_zg@mail.gmail.com>
Subject: Re: [virtio-dev] Dirty Page Tracking (DPT)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Rob Miller <rob.miller@broadcom.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Mar 06, 2020 at 10:40:13AM -0500, Rob Miller wrote:
> I understand that DPT isn't really on the forefront of the vDPA framework=
, but
> wanted to understand if there any initial thoughts on how this would work=
...

And judging by the next few chapters, you are actually
talking about vhost pci, right?

> In the migration framework, in its simplest form, (I gather) its QEMU via=
 KVM
> that is reading the dirty page table, converting bits to page numbers, th=
en
> flushing remote VM/copying local page(s)->remote VM, ect.=A0
>=20
> While this is fine for a VM (say VM1) dirtying its own memory and the acc=
esses
> are trapped in the kernel as well as the log is being updated, I'm not su=
re
> what happens in the situation=A0of vhost, where a remote VM (say VM2) is =
dirtying
> up VM1's memory since it can directly access it, during packet reception =
for
> example.
> Whatever technique is employed=A0to catch this, how would this differ fro=
m a HW
> based Virtio device doing DMA directly into a VM's DDR, wrt to DPT? Is QE=
MU
> going to have a 2nd place to query the dirty logs - ie: the vDPA layer?

I don't think anyone has a good handle at the vhost pci migration yet.
But I think a reasonable way to handle that would be to
activate dirty tracking in VM2's QEMU.

And then VM2's QEMU would periodically copy the bits to the log - does
this sound right?

> Further I heard about a SW based DPT within the vDPA framework for those
> devices that do not (yet) support DPT inherently in HW. How is this envis=
ioned
> to work?

What I am aware of is simply switching to a software virtio
for the duration of migration. The software can be pretty simple
since the formats match: just copy available entries to device ring,
and for used entries, see a used ring entry, mark page
dirty and then copy used entry to guest ring.


Another approach that I proposed and was prototyped at some point by
Alex Duyck is guest driver touching the page in question before
processing it within guest e.g. by an atomic xor with 0.
Sounds attractive but didn't perform all that well.


> Finally, for those HW vendors that do support DPT in HW, a mapping of a b=
it ->
> page isn't really an option, since no one wants to do a byte wide
> read-modify-write across the PCI bus, but rather=A0 map a whole byte to p=
age is
> likely more desirable - the HW can just do non-posted writes to the dirty=
 page
> table. If byte wise, then the QEMU/vDPA layer has to either fix-up the ma=
pping
> (from byte->bit) or have the capability to handle the granularity diffs.
>=20
> Thoughts?
>=20
> Rob Miller
> rob.miller@broadcom.com
> (919)721-3339

If using an IOMMU, DPT can also be done using either PRI or dirty bit in
a PTE. PRI is an interrupt so it can kick off a thread to set bits in
the log I guess, but if it's the dirty bit then I don't think there's an
interrupt. And a polling thread does not sound attractive.  I guess
we'll need a new interface to notify VDPA that QEMU is looking for dirty
logs, and then VDPA can send them to QEMU in some way.  Will probably be
good enough to support vendor specific logging interfaces, too.  I don't
actually have hardware which supports either so actually coding it up is
not yet practical.

Further, at my KVM forum presentaiton I proposed a virtio-specific
pagefault handling interface.  If there's a wish to standardize and
implement that, let me know and I will try to write this up in a more
formal way.


--=20
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

