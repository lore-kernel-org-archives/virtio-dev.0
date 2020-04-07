Return-Path: virtio-dev-return-7016-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 745B6985E77
	for <virtio-dev@lists.oasis-open.org>; Tue,  7 Apr 2020 10:28:27 +0000 (UTC)
MIME-Version: 1.0
References: <CAJPjb1K2W=wcer3+6XNzi+pcyGPAU2E3HXbq5_cuBVNQad=_zg@mail.gmail.com>
 <20200309030251-mutt-send-email-mst@kernel.org> <ff63b1e2-e4aa-1b13-0b4a-72fd23badc06@redhat.com>
 <20200309060238-mutt-send-email-mst@kernel.org> <fdedf8ac-74ed-f502-daef-38896f23e526@redhat.com>
 <20200310021729-mutt-send-email-mst@kernel.org> <89358cf3-7ce0-7b60-f4a7-2672970a635e@redhat.com>
 <CAJPjb1Jg3Md7GrzAG2-6hJk4YwmpkqDCLFWMpXrvvkUY=5pMpQ@mail.gmail.com>
 <0f43a280-5425-3a10-1312-22ea87d320ca@redhat.com> <CAJaqyWfeSgj=+RMM_Zy4gTAkNJ42Ax5Axvc8okHOhH7UTsxhaA@mail.gmail.com>
In-Reply-To: <CAJaqyWfeSgj=+RMM_Zy4gTAkNJ42Ax5Axvc8okHOhH7UTsxhaA@mail.gmail.com>
From: Rob Miller <rob.miller@broadcom.com>
Date: Tue, 7 Apr 2020 06:27:59 -0400
Message-ID: <CAJPjb1KvZSgMxfUPnaeXfS=aRTJqNnoS7zpz-81zEhG4OWzHqA@mail.gmail.com>
Subject: Re: [virtio-dev] Dirty Page Tracking (DPT)
Content-Type: multipart/alternative; boundary="000000000000067b3805a2b0d8cd"
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Michael Tsirkin <mst@redhat.com>, Juan Quintela <quintela@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--000000000000067b3805a2b0d8cd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Does this mean that SW takes over the datapath during LM?
If so, is there any infrastructure to "gracefully" do a hand-off from HW
mode (pci device is managing the rings) to SW mode, in that when switching
from HW->SW, HW is stalled & quiesced, then the SW takes from where HW
left off?

Rob Miller
rob.miller@broadcom.com
(919)721-3339


On Tue, Apr 7, 2020 at 5:53 AM Eugenio Perez Martin <eperezma@redhat.com>
wrote:

> Hi!
>
> So, from the previous mails, it seems that monitoring the used ring
> (and the packed descriptors) is a good first step in that direction,
> as DPDK did. This way, the device does not need to worry about the
> dirty page tracking using a bitmap and the PCI writes limitation, and
> we can evaluate later the proposed alternatives:
> * Alternate used descriptors in packed.
> * vDPA interface for vDPA devices in a convenient format.
>
> Any thoughts? Do you think that we should start with another way?
>
> Thanks!
>
>

--000000000000067b3805a2b0d8cd
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Does this mean that SW takes over the datapath during LM?<=
div>If so, is there any infrastructure=C2=A0to &quot;gracefully&quot; do a =
hand-off from HW mode (pci device is managing the rings) to SW mode, in tha=
t when switching from HW-&gt;SW, HW is stalled &amp; quiesced, then the SW =
takes from where HW left=C2=A0off?</div><div><br clear=3D"all"><div><div di=
r=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signature"><div=
 dir=3D"ltr">Rob Miller<div><a href=3D"mailto:rob.miller@broadcom.com" targ=
et=3D"_blank">rob.miller@broadcom.com</a></div><div>(919)721-3339</div></di=
v></div></div><br></div></div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Tue, Apr 7, 2020 at 5:53 AM Eugenio Perez Martin=
 &lt;<a href=3D"mailto:eperezma@redhat.com">eperezma@redhat.com</a>&gt; wro=
te:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px =
0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi!<br>
<br>
So, from the previous mails, it seems that monitoring the used ring<br>
(and the packed descriptors) is a good first step in that direction,<br>
as DPDK did. This way, the device does not need to worry about the<br>
dirty page tracking using a bitmap and the PCI writes limitation, and<br>
we can evaluate later the proposed alternatives:<br>
* Alternate used descriptors in packed.<br>
* vDPA interface for vDPA devices in a convenient format.<br>
<br>
Any thoughts? Do you think that we should start with another way?<br>
<br>
Thanks!<br>
<br>
</blockquote></div>

--000000000000067b3805a2b0d8cd--

