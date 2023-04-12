Return-Path: <virtio-dev-return-12176-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AF48C7619A
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:55:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 01CD829FCC
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:55:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F140F9865B3
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:55:57 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E656F98650E; Wed, 12 Apr 2023 04:55:57 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D5405986509
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Apr 2023 04:55:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: hGNqWtBYM7iIq3HXi_R6Mw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681275351; x=1683867351;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=filE9Lqtnzk1DU5Kt4NqqjI1ImBhYxDbzsA2JLSiIkc=;
        b=6cPB4viLNJ66k0CqWjujIBP2KkpTtPI5/dUT3rlpCrIgGzQcnKzjnQG9i4J5RzFsxc
         bfYXspL0RwyZF4U2CsSJnidn2ROUv8vE9mHXWXW78jY2xsYJr9pXj7NAm4UZ+5y7Lgma
         a+ttMZ46EDF9MdviNIySZh5VGCSb3knpCjUJpE8kE0yS0yShySR22T6b4fq/aQ8WAyrn
         C+wxycLZQJaLIOliySEbOrbADD3n4eclk5vEtyIPsofTXSP/3FXZvgigcXB2AOZ1KVcg
         024VwYvjXS21C9orvQqihUzyhTAK7P2bc0C1UAXjxGiKkO6iNejtAUtuxcrZuZFmMPu6
         2zcw==
X-Gm-Message-State: AAQBX9drNhszObE8fMAts8b6oAqrbulRsEWxdUDTkwrFcV558PbLgL4o
	gxW0yjifX6C2RzCk//28rxoLTamkGZ/sNR0CeV42XMgAxJ9TBiDPAkVm0YAFDjLbaiCngo+SLlv
	6f9psrFMf/2lSOm0U3FMk59hNrK9ETJwzsfeKLDf/wB5j
X-Received: by 2002:ac8:5c85:0:b0:3bf:b9d9:675f with SMTP id r5-20020ac85c85000000b003bfb9d9675fmr6283595qta.10.1681275351429;
        Tue, 11 Apr 2023 21:55:51 -0700 (PDT)
X-Google-Smtp-Source: AKy350YgY3Fh4OE8b4SJvBZOk9J1zZ5OHAy4uJy0qdTmas7wyg6RtUE7UEe6xjc9N5o5yfe6eQmwiv7kcLHA+OlzQf4=
X-Received: by 2002:ac8:5c85:0:b0:3bf:b9d9:675f with SMTP id
 r5-20020ac85c85000000b003bfb9d9675fmr6283587qta.10.1681275351212; Tue, 11 Apr
 2023 21:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230330225834.506969-1-parav@nvidia.com> <20230330225834.506969-9-parav@nvidia.com>
 <CACGkMEtMOy4B-O-52ka+9P3OBQ_hs1KvdjWodNYg-XKLff+giw@mail.gmail.com>
 <307a9f8f-6184-0403-97ab-1b1c16d4fd3c@nvidia.com> <CACGkMEucOwwFDMqyWA+DgYV7X=9f5-P4Ba_AP=5kTsjna=n+7A@mail.gmail.com>
 <PH0PR12MB548194B46A3E32329C10D00EDC9A9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEstkFaH1rh+O-D9h=bin_09ut2_GnSZDsxrQi_ptDtBKg@mail.gmail.com> <20230412002017-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230412002017-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Apr 2023 12:55:39 +0800
Message-ID: <CACGkMEvQ5NgunpgrGiOkjfL0wBVWn6uZpoOOdiV8J932UaL-Jw@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, 
	Satananda Burla <sburla@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] [PATCH 08/11] transport-pci: Introduce virtio
 extended capability

On Wed, Apr 12, 2023 at 12:21=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Wed, Apr 12, 2023 at 12:04:45PM +0800, Jason Wang wrote:
> > On Wed, Apr 12, 2023 at 3:01=E2=80=AFAM Parav Pandit <parav@nvidia.com>=
 wrote:
> > >
> > >
> > > > From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.=
org> On
> > > > Behalf Of Jason Wang
> > > > Sent: Monday, April 10, 2023 11:29 PM
> > >
> > > > > However, it is not backward compatible, if the device place them =
in
> > > > > extended capability, it will not work.
> > > > >
> > > >
> > > > It is kind of intended since it is only used for new PCI-E features=
:
> > > >
> > > New fields in new extended pci cap area is fine.
> > > Migrating old fields to be present in the new extended pci cap, is no=
t your intention. Right?
> >
> > Right, but what I want to say is, such migration may cause unnecessary
> > problems. And I don't see why it is a must for your legacy MMIO bar
> > proposal.
> >
> > >
> > > > "
> > > > +The location of the virtio structures that depend on the PCI Expre=
ss
> > > > +capability are specified using a vendor-specific extended capabili=
ties
> > > > +on the extended capabilities list in PCI Express extended configur=
ation
> > > > +space of the device.
> > > > "
> > > >
> > > > > To make it backward compatible, a device needs to expose existing
> > > > > structure in legacy area. And extended structure for same capabil=
ity
> > > > > in extended pci capability region.
> > > > >
> > > > > In other words, it will have to be a both places.
> > > >
> > > > Then we will run out of config space again?
> > > No.
> > > Only currently defined caps to be placed in two places.
> >
> > What's the advantage of doing this?
> >
> > New drivers should provide backward compatibility so they must scan the=
 pci cap.
>
> No, they can start with express cap. Finding one they can skip
> the old cap completely.

Then the driver can't work on the old device.

Thanks

>
> > The Old driver can only scan the pci cap.
> >
> > > New fields don=E2=80=99t need to be placed in PCI cap, because no dri=
ver is looking there.
> >
> > It would be much more simple if we forbid placing new fields in the
> > PCI cap, it is already out of space.
> >
> > Thanks
> >
> > >
> > > We probably already discussed this in previous email by now.
> > >
> > > > Otherwise we need to deal with the
> > > > case when existing structures were only placed at extended capabili=
ty. Michael
> > > > suggest to add a new feature, but the driver may not negotiate the =
feature
> > > > which requires more thought.
> > > >
> > > Not sure I understand feature bit.
> > > PCI transport fields existence is usually not dependent on upper laye=
r protocol.
> > >
> > > > > We may need it even sooner than this because the AQ patch is expa=
nding
> > > > > the structure located in legacy area.
> > > >
> > > > Just to make sure I understand this, assuming we have adminq, any r=
eason a
> > > > dedicated pcie ext cap is required?
> > > >
> > > No. it was my short sight. I responded right after above text that AQ=
 doesn=E2=80=99t need cap extension.
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

