Return-Path: <virtio-dev-return-12165-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB630C77B73
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:20:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 403D62B01F
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:20:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 21D58986511
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:20:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 09DC69864B3; Wed, 12 Apr 2023 04:20:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E328F98650E
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Apr 2023 04:20:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: oleIworpPR2OtUT8SnNp7w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681273214;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nKJYIrn2LtPWj3lT6FVEwJs5C92bnXjn3LdSC9a5fvQ=;
        b=SmFfig+PXtv0M3J5n0k2QoDCw/mVVTFq0izlKXDThmWKvEE+rltsEBsWbPQDQwczNX
         brD/RQvFdGw16Zuag7UhokPQHi31FvuLIv7W9tXNWiHorWWLYChr6nZSIOqrtgFAKMkF
         anHiEQMpQLSqVXZwXFbROBmMSpyN/93rLG0pH64QK6kBu0MnBadWo9zAs9x2rN7rp3sg
         9vc9PHYHOL9IvP5NvBTZQmDiyCH7nQG5CoW1wqeiFrlcjTPc82f3jgVSruroV/bfvWW2
         4ugjSw5pqyhOMs8dlciGOMUKlv4mRripvg4JkhN28o/afcfpEqZxetswarT/xS2pkEVD
         /Z8A==
X-Gm-Message-State: AAQBX9dWnQPHwwtna6QnZc5XPf0dvtljGUXejby9wGO00LHsBA/HwUBJ
	U1ChlHMicRbMgWuzWLhZCNbID1Bc9oKtyIFh+UPHbX2xJMuyEmcnp2rvUcxSCvwdgfJXH7RRcWo
	oUh6vxpV8rC1+jet5s7ygZtrH/gRF
X-Received: by 2002:a5d:4090:0:b0:2f4:3b2c:1b2e with SMTP id o16-20020a5d4090000000b002f43b2c1b2emr813717wrp.31.1681273214261;
        Tue, 11 Apr 2023 21:20:14 -0700 (PDT)
X-Google-Smtp-Source: AKy350Zcg/9zn6jbbMwPvqAFbRIUiE15e1jmZrmghOYzX1V18CN28i1CL9We8qr2venu5yIZ1S65og==
X-Received: by 2002:a5d:4090:0:b0:2f4:3b2c:1b2e with SMTP id o16-20020a5d4090000000b002f43b2c1b2emr813704wrp.31.1681273213968;
        Tue, 11 Apr 2023 21:20:13 -0700 (PDT)
Date: Wed, 12 Apr 2023 00:20:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Satananda Burla <sburla@marvell.com>
Message-ID: <20230412001803-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
 <CACGkMEtMOy4B-O-52ka+9P3OBQ_hs1KvdjWodNYg-XKLff+giw@mail.gmail.com>
 <307a9f8f-6184-0403-97ab-1b1c16d4fd3c@nvidia.com>
 <CACGkMEucOwwFDMqyWA+DgYV7X=9f5-P4Ba_AP=5kTsjna=n+7A@mail.gmail.com>
 <PH0PR12MB548194B46A3E32329C10D00EDC9A9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230411172207-mutt-send-email-mst@kernel.org>
 <CACGkMEsSxnn0+T6ng99HV-PwA3kEe6J050GNDKJjcjBQfQxbfA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsSxnn0+T6ng99HV-PwA3kEe6J050GNDKJjcjBQfQxbfA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] [PATCH 08/11] transport-pci: Introduce virtio
 extended capability

On Wed, Apr 12, 2023 at 12:07:26PM +0800, Jason Wang wrote:
> On Wed, Apr 12, 2023 at 5:25 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Apr 11, 2023 at 07:01:16PM +0000, Parav Pandit wrote:
> > >
> > > > From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> On
> > > > Behalf Of Jason Wang
> > > > Sent: Monday, April 10, 2023 11:29 PM
> > >
> > > > > However, it is not backward compatible, if the device place them in
> > > > > extended capability, it will not work.
> > > > >
> > > >
> > > > It is kind of intended since it is only used for new PCI-E features:
> > > >
> > > New fields in new extended pci cap area is fine.
> > > Migrating old fields to be present in the new extended pci cap, is not your intention. Right?
> > >
> > > > "
> > > > +The location of the virtio structures that depend on the PCI Express
> > > > +capability are specified using a vendor-specific extended capabilities
> > > > +on the extended capabilities list in PCI Express extended configuration
> > > > +space of the device.
> > > > "
> > > >
> > > > > To make it backward compatible, a device needs to expose existing
> > > > > structure in legacy area. And extended structure for same capability
> > > > > in extended pci capability region.
> > > > >
> > > > > In other words, it will have to be a both places.
> > > >
> > > > Then we will run out of config space again?
> > > No.
> > > Only currently defined caps to be placed in two places.
> > > New fields don’t need to be placed in PCI cap, because no driver is looking there.
> > >
> > > We probably already discussed this in previous email by now.
> > >
> > > > Otherwise we need to deal with the
> > > > case when existing structures were only placed at extended capability. Michael
> > > > suggest to add a new feature, but the driver may not negotiate the feature
> > > > which requires more thought.
> > > >
> > > Not sure I understand feature bit.
> >
> > This is because we have a concept of dependency between
> > features but not a concept of dependency of feature on
> > capability.
> >
> > > PCI transport fields existence is usually not dependent on upper layer protocol.
> > >
> > > > > We may need it even sooner than this because the AQ patch is expanding
> > > > > the structure located in legacy area.
> > > >
> > > > Just to make sure I understand this, assuming we have adminq, any reason a
> > > > dedicated pcie ext cap is required?
> > > >
> > > No. it was my short sight. I responded right after above text that AQ doesn’t need cap extension.
> >
> >
> >
> > You know, thinking about this, I begin to feel that we should
> > require that if at least one extended config exists then
> > all caps present in the regular config are *also*
> > mirrored in the extended config. IOW extended >= regular.
> > The reason is that extended config can be emulated more efficiently
> > (2x less exits).
> 
> Any reason for it to get less exits?

For a variety of reasons having to do with buggy hardware e.g. linux
likes to use cf8/cfc for legacy ranges. 2 accesses are required for each
read/write.  extended space is just 1.


> At least it has not been done in
> current Qemu's emulation. (And do we really care about the performance
> of config space access?)
> 
> Thanks

For boot speed, yes. Not minor 5% things but 2x, sure.

> > WDYT?
> >
> >
> > --
> > MST
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

