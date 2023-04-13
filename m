Return-Path: <virtio-dev-return-12200-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD1B8C77B6F
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 01:48:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 244CE29FDA
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 01:48:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1DD5898660D
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Apr 2023 01:48:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 115099862A1; Thu, 13 Apr 2023 01:48:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F25609865F6
	for <virtio-dev@lists.oasis-open.org>; Thu, 13 Apr 2023 01:48:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: i2uDPAWMOYmZKh1Nng86sw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681350507; x=1683942507;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=almJ8p0/Qto89wZ66zB1mHYoG6KAMGa8GGvkZRb41nk=;
        b=GBApGyrCs1VRPRqS7WziwcTdoPBRR6dgNbwir+nDgL4sqOiLgNeAoB+tzZNZD9R1C8
         +FkcvbUj5h8si58ghdE6DQAzBUcC8JChBvTlIncI7rNWDLJ8gcyxiZQiXUyC/TQsmRp9
         sw4RhxqGrgfKu3ZPlH2HvO8+Rav2/0SumCcyY7I0fJ5awvowrTHBwzur45tsZGxUDTKL
         6CP4GN3NR7JKo9Lqu+Z8fXWZnIpMb5dLIxgpI5zXNW472LqCBlKmb7wjLi7RNfgm2hhl
         bvsqhxrlDB3JhrkNl06LDMDE8qeoOicnJHStt8RFfAdHlDx/7RGG3XFJV4Bx84KFC2Ir
         gblA==
X-Gm-Message-State: AAQBX9c9Kz5osa6LlubLU05zM/RhHnHeT++fSscXmQOldStcNFEq70eE
	qmku+sjXXMcWjKQN7TV7zfOWbr4R3pZb4/slqGIG7Xmd9kKZ6aLCwHPSGa91q5yH1g2FsadV9DD
	/9x8HjgDz6nmcP1TzvIieWetylBUbkDLjMyExJxrfMXdz
X-Received: by 2002:a05:6830:2093:b0:6a1:cbc6:f1b3 with SMTP id y19-20020a056830209300b006a1cbc6f1b3mr109861otq.2.1681350507337;
        Wed, 12 Apr 2023 18:48:27 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZIB53w1XrsRupwy8W7U9TiPvYnRX34T50iW7cjRqfgrbZiPHVSZomHkfIbrCCnF49+IjWo1bKYyYJlIFuUV8o=
X-Received: by 2002:a05:6830:2093:b0:6a1:cbc6:f1b3 with SMTP id
 y19-20020a056830209300b006a1cbc6f1b3mr109844otq.2.1681350507063; Wed, 12 Apr
 2023 18:48:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230410020906-mutt-send-email-mst@kernel.org>
 <CACGkMEtiROwuB+ECJqd13qdpMJSTMoDOzi1u_i85==42C0XSXw@mail.gmail.com>
 <20230410023715-mutt-send-email-mst@kernel.org> <CACGkMEs+E_OarQxP3NmLk3iSi7U0WgAn-m3b4eX7ULu1+v=sOw@mail.gmail.com>
 <20230410060417-mutt-send-email-mst@kernel.org> <CACGkMEuc47PdmQdC67Nz4AvX_+jy+XBgCkwZ1BHmM8VGb9gywA@mail.gmail.com>
 <20230411030056-mutt-send-email-mst@kernel.org> <CACGkMEt2QAfhCgpYjSRNzf3n4W_HJLrMfE9JHzocR_gPH_Zrtg@mail.gmail.com>
 <20230411063945-mutt-send-email-mst@kernel.org> <CACGkMEufWUXHKahg3GLOKfV5aptbiek_DKwy+7rCfMya2GPaTQ@mail.gmail.com>
 <20230412000802-mutt-send-email-mst@kernel.org> <CACGkMEshNydwBD=Q0JW-SDY6xyiJ4uVrLn+pxbUrinycBKwsrw@mail.gmail.com>
 <PH0PR12MB548118F57BB4B4A4F8DC9D7ADC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvYsz1fSPG+fKpRaZ05Ut7ffKwvMPvR8xbRBsXA_6vGQw@mail.gmail.com>
 <PH0PR12MB548137D7A25C99EAA42B4D12DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshW82qztmGw8YJWJ8=QCoRd6cPxQ+ySazxsO_o+U6c4Q@mail.gmail.com>
 <PH0PR12MB548147CF939CB9C2A0586310DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu2B_GogDR9HUwB7mT8fkGh+Q_buPLz4nhwhK7h9k6BQQ@mail.gmail.com> <PH0PR12MB5481F0CF5A555A6BB2CE856CDC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481F0CF5A555A6BB2CE856CDC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 13 Apr 2023 09:48:15 +0800
Message-ID: <CACGkMEuNOYOxvcSzrs0UFEyk+xOkGUpOfhK8rOy_Mebz5b5wdg@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, 
	Satananda Burla <sburla@marvell.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, 
	Yan Vugenfirer <yan@daynix.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

On Wed, Apr 12, 2023 at 10:23=E2=80=AFPM Parav Pandit <parav@nvidia.com> wr=
ote:
>
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, April 12, 2023 2:15 AM
> >
> > On Wed, Apr 12, 2023 at 1:55=E2=80=AFPM Parav Pandit <parav@nvidia.com>=
 wrote:
> > >
> > >
> > >
> > > > From: Jason Wang <jasowang@redhat.com>
> > > > Sent: Wednesday, April 12, 2023 1:38 AM
> > >
> > > > > Modern device says FEAETURE_1 must be offered and must be
> > > > > negotiated by
> > > > driver.
> > > > > Legacy has Mac as RW area. (hypervisor can do it).
> > > > > Reset flow is difference between the legacy and modern.
> > > >
> > > > Just to make sure we're at the same page. We're talking in the
> > > > context of mediation. Without mediation, your proposal can't work.
> > > >
> > > Right.
> > >
> > > > So in this case, the guest driver is not talking with the device
> > > > directly. Qemu needs to traps whatever it wants to achieve the
> > > > mediation:
> > > >
> > > I prefer to avoid picking specific sw component here, but yes. QEMU c=
an trap.
> > >
> > > > 1) It's perfectly fine that Qemu negotiated VERSION_1 but presented
> > > > a mediated legacy device to guests.
> > > Right but if VERSION_1 is negotiated, device will work as V_1 with 12=
B
> > virtio_net_hdr.
> >
> > Shadow virtqueue could be used here. And we have much more issues witho=
ut
> > shadow virtqueue, more below.
> >
> > >
> > > > 2) For MAC and Reset, Qemu can trap and do anything it wants.
> > > >
> > > The idea is not to poke in the fields even though such sw can.
> > > MAC is RW in legacy.
> > > Mac ia RO in 1.x.
> > >
> > > So QEMU cannot make RO register into RW.
> >
> > It can be done via using the control vq. Trap the MAC write and forward=
 it via
> > control virtqueue.
> >
> This proposal Is not implementing about vdpa mediator that requires far h=
igher understanding in hypervisor.

It's not related to vDPA, it's about a common technology that is used
in virtualization. You do a trap and emulate the status, why can't you
do that for others?

> Such mediation works fine for vdpa and it is upto vdpa layer to do. Not r=
elevant here.
>
> > >
> > > The proposed solution in this series enables it and avoid per field s=
w
> > interpretation and mediation in parsing values etc.
> >
> > I don't think it's possible. See the discussion about ORDER_PLATFORM an=
d
> > ACCESS_PLATFORM in previous threads.
> >
> I have read the previous thread.
> Hypervisor will be limiting to those platforms where ORDER_PLATFORM is no=
t needed.

So you introduce a bunch of new facilities that only work on some
specific archs. This breaks the architecture independence of virtio
since 1.0. The root cause is legacy is not fit for hardware
implementation, any kind of hardware that tries to offer legacy
function will finally run into those corner cases which require extra
interfaces which may finally end up with a (partial) duplication of
the modern interface.

> And this is a pci transitional device that uses the standard platform dma=
 anyway so ACCESS_PLATFORM is not related.

So which type of transactions did this device use when it is used via
legacy MMIO BAR? Translated request or not?

>
> > >
> > > What is proposed here, that
> > > a. legacy registers are emulated as MMIO in a BAR.
> > > b. This can be either be BAR0 or some other BAR
> > >
> > > Your question was why this flexibility?
> >
> > Yes.
> >
> > >
> > > The reason is:
> > > a. if device prefers to implement only two BARs, it can do so and hav=
e window
> > for this 60+ config registers in an existing BAR.
> > > b. if device prefers to implement a new BAR dedicated for legacy regi=
sters
> > emulation, it is fine too.
> > >
> > > A mediating sw will be able to forward them regardless.
> >
> > I'm not sure I fully understand this. The only difference is that for b=
, it can only
> > use BAR0.
> Why do say it can use only BAR 0?

Because:

1) It's the way current transitional device works
2) it's simple, a small extension to the transitional device instead
of a brunch of facilities that is can do much less than this
3) it works for legacy drivers on some OSes such as Linux and DPDK, it
means it works for bare metal which can't be achieved by your proposal
here

>
> For example, a device may have implemented say only BAR2, and small porti=
on of the BAR2 is pointing to legacy MMIO config registers.

We're discussing spec changes, not a specific implementation here. Why
is the device can't use BAR0, do you see any restriction in the spec?

> A mediator hypervisor sw will be able to read/write to it when BAR0 is ex=
posed towards the guest VM as IOBAR 0.

So I don't think it can work:

1) This is very dangerous unless the spec mandates the size (this is
also tricky since page size varies among arches) for any
BAR/capability which is not what virtio wants, the spec leave those
flexibility to the implementation:

E.g

"""
The driver MUST accept a cap_len value which is larger than specified here.
"""

2) A blocker for live migration (and compatibility), the hypervisor
should not assume the size for any capability so for whatever case it
should have a fallback for the case where the BAR can't be assigned.

>
> > Unless there's a new feature that mandates
> > BAR0 (which I think is impossible since all the features are advertised=
 via
> > capabilities now). We're fine.
> >
> No new feature. Legacy BAR emulation is exposed via the extended capabili=
ty we discussed providing the location.
>
> > >
> > > > > Right, it doesn=E2=80=99t. But spec shouldn=E2=80=99t write BAR0 =
is only for
> > > > > legacy MMIO
> > > > emulation, that would prevent BAR0 usage.
> > > >
> > > > How can it be prevented? Can you give me an example?
> > >
> > > I mean to say, that say if we write a spec like below,
> > >
> > > A device exposes BAR 0 of size X bytes for supporting legacy configur=
ation
> > and device specific registers as memory mapped region.
> > >
> >
> > Ok, it looks just a matter of how the spec is written. The problematic =
part is that
> > it tries to enforce a size which is suboptimal.
> >
> > What's has been done is:
> >
> > "
> > Transitional devices MUST expose the Legacy Interface in I/O space in B=
AR0.
> > "
> >
> > Without mentioning the size.
>
> For new legacy MMIO registers can be implemented as BAR0 with same size. =
But better to not place such restriction like above wording.

Let me summarize, we had three ways currently:

1) legacy MMIO BAR via capability:

Pros:
- allow some flexibility to place MMIO BAR other than 0
Cons:
- new device ID
- non trivial spec changes which ends up of the tricky cases that
tries to workaround legacy to fit for a hardware implementation
- work only for the case of virtualization with the help of
meditation, can't work for bare metal
- only work for some specific archs without SVQ

2) allow BAR0 to be MMIO for transitional device

Pros:
- very minor change for the spec
- work for virtualization (and it work even without dedicated
mediation for some setups)
- work for bare metal for some setups (without mediation)
Cons:
- only work for some specific archs without SVQ
- BAR0 is required

3) modern device mediation for legacy

Pros:
- no changes in the spec
Cons:
- require mediation layer in order to work in bare metal
- require datapath mediation like SVQ to work for virtualization

Compared to method 2) the only advantages of method 1) is the
flexibility of BAR0 but it has too many disadvantages. If we only care
about virtualization, modern devices are sufficient. Then why bother
for that?

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

