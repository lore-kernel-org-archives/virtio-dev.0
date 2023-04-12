Return-Path: <virtio-dev-return-12161-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAC6FC77B73
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:05:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 25C8F3E308
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:05:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A2A3C98669E
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:05:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 22AA098650E; Wed, 12 Apr 2023 04:05:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5D4C99864B3
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Apr 2023 04:05:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: NF9Ed1FYOVyAnP5jBedckA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681272297; x=1683864297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FE3xaEBOTLPTHryURCkmUKM0m1MQP6b15DE1FP+EKZs=;
        b=I68sgSN/4NJIsgZ8BJtceFg4kvGcz3RTXjS7G66xMqV6GyGVr8FT+eq4S36Hq5T67W
         jybk4JUptLX1nylvSc7yxy6Gh2qr1mkqH60jLYyVvW85ZJ3zGNaAWfQDOTer85nj6Gj4
         AKCjHOe+ZFbQG4+gGcDxiXpyzzIkpsaB8qw2HIk+YSDzpAAarxyBbjxh5XapJ72YtdxB
         jkYWoFj7DZDfAs0Uw+YD8LtXxdMzlkpTG9ipYVzebv/NnkKJfw5b9X+GIhtCBzxeWtxP
         iZpT30PSo+zU7Kz6cQOylqlIM7RhfUgln8ojlkvG8b+lJtnGZhAUEl5f5hR+qlolAU1N
         bVOA==
X-Gm-Message-State: AAQBX9f2lFWaFlh+wBqsV6quZ6KWNAYKNCResfzsl7wUA0OuoZ6ZASon
	fUyGNjB+lVC4bnAnAASxyl5JaEyyaIUjfx7aITEH0xOHiFA6IjF84brkRWbU7g2dGcCBO/WfGTr
	7P3MoWq15yBQhsP5Kp1jwI30Ss7XMfjoTkwqK7G9iZsZc
X-Received: by 2002:a05:620a:29c6:b0:746:9ff2:27f with SMTP id s6-20020a05620a29c600b007469ff2027fmr4304173qkp.8.1681272296767;
        Tue, 11 Apr 2023 21:04:56 -0700 (PDT)
X-Google-Smtp-Source: AKy350bBJ6+l6jQb52+nyUfNzuUb3GNyoikftZr/hAvIsis2jNP92ODy24O8QRboZXJoodQZODPX1RAXMQM0FeKHBNk=
X-Received: by 2002:a05:620a:29c6:b0:746:9ff2:27f with SMTP id
 s6-20020a05620a29c600b007469ff2027fmr4304167qkp.8.1681272296534; Tue, 11 Apr
 2023 21:04:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230330225834.506969-1-parav@nvidia.com> <20230330225834.506969-9-parav@nvidia.com>
 <CACGkMEtMOy4B-O-52ka+9P3OBQ_hs1KvdjWodNYg-XKLff+giw@mail.gmail.com>
 <307a9f8f-6184-0403-97ab-1b1c16d4fd3c@nvidia.com> <CACGkMEucOwwFDMqyWA+DgYV7X=9f5-P4Ba_AP=5kTsjna=n+7A@mail.gmail.com>
 <PH0PR12MB548194B46A3E32329C10D00EDC9A9@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB548194B46A3E32329C10D00EDC9A9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Apr 2023 12:04:45 +0800
Message-ID: <CACGkMEstkFaH1rh+O-D9h=bin_09ut2_GnSZDsxrQi_ptDtBKg@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "mst@redhat.com" <mst@redhat.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, 
	Satananda Burla <sburla@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] [PATCH 08/11] transport-pci: Introduce virtio
 extended capability

On Wed, Apr 12, 2023 at 3:01=E2=80=AFAM Parav Pandit <parav@nvidia.com> wro=
te:
>
>
> > From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org>=
 On
> > Behalf Of Jason Wang
> > Sent: Monday, April 10, 2023 11:29 PM
>
> > > However, it is not backward compatible, if the device place them in
> > > extended capability, it will not work.
> > >
> >
> > It is kind of intended since it is only used for new PCI-E features:
> >
> New fields in new extended pci cap area is fine.
> Migrating old fields to be present in the new extended pci cap, is not yo=
ur intention. Right?

Right, but what I want to say is, such migration may cause unnecessary
problems. And I don't see why it is a must for your legacy MMIO bar
proposal.

>
> > "
> > +The location of the virtio structures that depend on the PCI Express
> > +capability are specified using a vendor-specific extended capabilities
> > +on the extended capabilities list in PCI Express extended configuratio=
n
> > +space of the device.
> > "
> >
> > > To make it backward compatible, a device needs to expose existing
> > > structure in legacy area. And extended structure for same capability
> > > in extended pci capability region.
> > >
> > > In other words, it will have to be a both places.
> >
> > Then we will run out of config space again?
> No.
> Only currently defined caps to be placed in two places.

What's the advantage of doing this?

New drivers should provide backward compatibility so they must scan the pci=
 cap.
The Old driver can only scan the pci cap.

> New fields don=E2=80=99t need to be placed in PCI cap, because no driver =
is looking there.

It would be much more simple if we forbid placing new fields in the
PCI cap, it is already out of space.

Thanks

>
> We probably already discussed this in previous email by now.
>
> > Otherwise we need to deal with the
> > case when existing structures were only placed at extended capability. =
Michael
> > suggest to add a new feature, but the driver may not negotiate the feat=
ure
> > which requires more thought.
> >
> Not sure I understand feature bit.
> PCI transport fields existence is usually not dependent on upper layer pr=
otocol.
>
> > > We may need it even sooner than this because the AQ patch is expandin=
g
> > > the structure located in legacy area.
> >
> > Just to make sure I understand this, assuming we have adminq, any reaso=
n a
> > dedicated pcie ext cap is required?
> >
> No. it was my short sight. I responded right after above text that AQ doe=
sn=E2=80=99t need cap extension.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

