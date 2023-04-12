Return-Path: <virtio-dev-return-12195-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5F92C7619A
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 06:15:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D4FB92AEE4
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 06:15:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B3A4A9865B2
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 06:15:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9260E986509; Wed, 12 Apr 2023 06:15:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8100D98650E
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Apr 2023 06:15:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 1XW9hOvcP6S7gUNHHvEGeQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681280129; x=1683872129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z/8MC357/TAEwQ91xMANiv2cWSco2KclG4XavyId9Yw=;
        b=I4izx05dFbJv8bG5TfqkAlIjIBWzOCmwWe78Ogkoa+2rmV7Es0Ase3+ZTfhF0JqV7/
         r+ItjvPvdtgl4CzoJJBYT6K0BVum2WmcIzKftgxV1u2kCks2EYWa+nzKseFJiMj9I7gV
         avSbYg1ihXW3vqmbQJBUiP2mXu28NJQRy6fRlZaMgd3Y77KXyDA7Y5+Ee2wizl9WGwJR
         9EF+v9kD7E2fudJqL4UsfeIgiqLZEmJSipiwt+Qy6++GcrfBw528JC3k/xoOQlFcKOEr
         cAdP6CwMcijE02mLUlQSpzVdrIjDra1P6PANY3KjEQ5IEYHM84iJx33xUjcCpNrw184O
         DPDQ==
X-Gm-Message-State: AAQBX9eaogTDzpKX0ceOgEUPO08RxzTdYtvlsAkO0FbxK13HwIDlpLCQ
	ywb+Euvm9kxkYd3nCRqxQPk7sNctCc2WHExeFdewBu4qaTGFmv+qBNysD3L/K9C9GjmyK1Kq138
	quuTaSB03VY/zg6fuyogyujdrLt4yXqsFH0EgYLDeFK4t
X-Received: by 2002:a05:622a:1890:b0:3e3:7c8b:24fa with SMTP id v16-20020a05622a189000b003e37c8b24famr5394904qtc.10.1681280129499;
        Tue, 11 Apr 2023 23:15:29 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZHn7lgQphGq1zOQdDEAQR2g8NXgeSAy7LXNrFDg9hsuBl6QP8bcmBQGRBOqEnIObpBefN8rsqfRu/CCYJcZTM=
X-Received: by 2002:a05:622a:1890:b0:3e3:7c8b:24fa with SMTP id
 v16-20020a05622a189000b003e37c8b24famr5394892qtc.10.1681280129243; Tue, 11
 Apr 2023 23:15:29 -0700 (PDT)
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
 <CACGkMEshW82qztmGw8YJWJ8=QCoRd6cPxQ+ySazxsO_o+U6c4Q@mail.gmail.com> <PH0PR12MB548147CF939CB9C2A0586310DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB548147CF939CB9C2A0586310DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Apr 2023 14:15:17 +0800
Message-ID: <CACGkMEu2B_GogDR9HUwB7mT8fkGh+Q_buPLz4nhwhK7h9k6BQQ@mail.gmail.com>
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

On Wed, Apr 12, 2023 at 1:55=E2=80=AFPM Parav Pandit <parav@nvidia.com> wro=
te:
>
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, April 12, 2023 1:38 AM
>
> > > Modern device says FEAETURE_1 must be offered and must be negotiated =
by
> > driver.
> > > Legacy has Mac as RW area. (hypervisor can do it).
> > > Reset flow is difference between the legacy and modern.
> >
> > Just to make sure we're at the same page. We're talking in the context =
of
> > mediation. Without mediation, your proposal can't work.
> >
> Right.
>
> > So in this case, the guest driver is not talking with the device direct=
ly. Qemu
> > needs to traps whatever it wants to achieve the
> > mediation:
> >
> I prefer to avoid picking specific sw component here, but yes. QEMU can t=
rap.
>
> > 1) It's perfectly fine that Qemu negotiated VERSION_1 but presented a
> > mediated legacy device to guests.
> Right but if VERSION_1 is negotiated, device will work as V_1 with 12B vi=
rtio_net_hdr.

Shadow virtqueue could be used here. And we have much more issues
without shadow virtqueue, more below.

>
> > 2) For MAC and Reset, Qemu can trap and do anything it wants.
> >
> The idea is not to poke in the fields even though such sw can.
> MAC is RW in legacy.
> Mac ia RO in 1.x.
>
> So QEMU cannot make RO register into RW.

It can be done via using the control vq. Trap the MAC write and
forward it via control virtqueue.

>
> The proposed solution in this series enables it and avoid per field sw in=
terpretation and mediation in parsing values etc.

I don't think it's possible. See the discussion about ORDER_PLATFORM
and ACCESS_PLATFORM in previous threads.

>
> > > The PCI device exposed is transitional to the guest VM, so it can do =
legacy as
> > well as newer features.
> > > And if BAR 0 is hard coded, it may not be able to support features th=
at may
> > need additional BAR.
> >
> > This part I don't understand, you can just put existing modern capabili=
ties in
> > BAR0, then everything is fine.
> >
> Not sure I follow.
> May be a step back.
>
> What is proposed here, that
> a. legacy registers are emulated as MMIO in a BAR.
> b. This can be either be BAR0 or some other BAR
>
> Your question was why this flexibility?

Yes.

>
> The reason is:
> a. if device prefers to implement only two BARs, it can do so and have wi=
ndow for this 60+ config registers in an existing BAR.
> b. if device prefers to implement a new BAR dedicated for legacy register=
s emulation, it is fine too.
>
> A mediating sw will be able to forward them regardless.

I'm not sure I fully understand this. The only difference is that for
b, it can only use BAR0. Unless there's a new feature that mandates
BAR0 (which I think is impossible since all the features are
advertised via capabilities now). We're fine.

>
> > > Right, it doesn=E2=80=99t. But spec shouldn=E2=80=99t write BAR0 is o=
nly for legacy MMIO
> > emulation, that would prevent BAR0 usage.
> >
> > How can it be prevented? Can you give me an example?
>
> I mean to say, that say if we write a spec like below,
>
> A device exposes BAR 0 of size X bytes for supporting legacy configuratio=
n and device specific registers as memory mapped region.
>

Ok, it looks just a matter of how the spec is written. The problematic
part is that it tries to enforce a size which is suboptimal.

What's has been done is:

"
Transitional devices MUST expose the Legacy Interface in I/O space in BAR0.
"

Without mentioning the size.

Thanks


> Above line will prevent using BAR0 beyond legacy register emulation.
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

