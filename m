Return-Path: virtio-dev-return-6891-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D4E46985FBD
	for <virtio-dev@lists.oasis-open.org>; Fri,  6 Mar 2020 15:40:40 +0000 (UTC)
MIME-Version: 1.0
From: Rob Miller <rob.miller@broadcom.com>
Date: Fri, 6 Mar 2020 10:40:13 -0500
Message-ID: <CAJPjb1K2W=wcer3+6XNzi+pcyGPAU2E3HXbq5_cuBVNQad=_zg@mail.gmail.com>
Subject: [virtio-dev] Dirty Page Tracking (DPT)
Content-Type: multipart/alternative; boundary="000000000000b4a75105a031790d"
To: Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

--000000000000b4a75105a031790d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

I understand that DPT isn't really on the forefront of the vDPA framework,
but wanted to understand if there any initial thoughts on how this would
work...

In the migration framework, in its simplest form, (I gather) its QEMU via
KVM that is reading the dirty page table, converting bits to page numbers,
then flushing remote VM/copying local page(s)->remote VM, ect.

While this is fine for a VM (say VM1) dirtying its own memory and the
accesses are trapped in the kernel as well as the log is being updated, I'm
not sure what happens in the situation of vhost, where a remote VM (say
VM2) is dirtying up VM1's memory since it can directly access it, during
packet reception for example.

Whatever technique is employed to catch this, how would this differ from a
HW based Virtio device doing DMA directly into a VM's DDR, wrt to DPT? Is
QEMU going to have a 2nd place to query the dirty logs - ie: the vDPA layer=
?

Further I heard about a SW based DPT within the vDPA framework for those
devices that do not (yet) support DPT inherently in HW. How is this
envisioned to work?

Finally, for those HW vendors that do support DPT in HW, a mapping of a bit
-> page isn't really an option, since no one wants to do a byte wide
read-modify-write across the PCI bus, but rather  map a whole byte to page
is likely more desirable - the HW can just do non-posted writes to the
dirty page table. If byte wise, then the QEMU/vDPA layer has to either
fix-up the mapping (from byte->bit) or have the capability to handle the
granularity diffs.

Thoughts?

Rob Miller
rob.miller@broadcom.com
(919)721-3339

--000000000000b4a75105a031790d
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I understand that DPT isn&#39;t really on the forefront of=
 the vDPA framework, but wanted to understand if there any initial thoughts=
 on how this would work...<div><br></div><div>In the migration framework, i=
n its simplest form, (I gather) its QEMU via KVM that is reading the dirty =
page table, converting bits to page numbers, then flushing remote VM/copyin=
g local page(s)-&gt;remote VM, ect.=C2=A0</div><div><br></div><div>While th=
is is fine for a VM (say VM1) dirtying its own memory and the accesses are =
trapped in the kernel as well as the log is being updated, I&#39;m not sure=
 what happens in the situation=C2=A0of vhost, where a remote VM (say VM2) i=
s dirtying up VM1&#39;s memory since it can directly access it, during pack=
et reception for example.</div><div><br></div><div>Whatever technique is em=
ployed=C2=A0to catch this, how would this differ from a HW based Virtio dev=
ice doing DMA directly into a VM&#39;s DDR, wrt to DPT? Is QEMU going to ha=
ve a 2nd place to query the dirty logs - ie: the vDPA layer?</div><div><br>=
</div><div>Further I heard about a SW based DPT within the vDPA framework f=
or those devices that do not (yet) support DPT inherently in HW. How is thi=
s envisioned to work?</div><div><br></div><div>Finally, for those HW vendor=
s that do support DPT in HW, a mapping of a bit -&gt; page isn&#39;t really=
 an option, since no one wants to do a byte wide read-modify-write across t=
he PCI bus, but rather=C2=A0 map a whole byte to page is likely more desira=
ble - the HW can just do non-posted writes to the dirty page table. If byte=
 wise, then the QEMU/vDPA layer has to either fix-up the mapping (from byte=
-&gt;bit) or have the capability to handle the granularity diffs.</div><div=
><br></div><div>Thoughts?</div><div><br clear=3D"all"><div><div dir=3D"ltr"=
 class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div dir=3D"l=
tr">Rob Miller<div><a href=3D"mailto:rob.miller@broadcom.com" target=3D"_bl=
ank">rob.miller@broadcom.com</a></div><div>(919)721-3339</div></div></div><=
/div></div></div>

--000000000000b4a75105a031790d--

