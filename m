Return-Path: <virtio-dev-return-12166-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37A74C77B6E
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:21:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A7DB22AC59
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:21:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9F7F99865A6
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:21:08 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 934909864B3; Wed, 12 Apr 2023 04:21:08 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 844CA986509
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Apr 2023 04:21:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: F7E5TSSNNFmNYbWN60uKaw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681273263;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PqpuHF4Mi9VcxFgkf1M9251n7aY1Xeds05xh7jpHVDk=;
        b=t2VexRgbctXng/QH72eMfM5xkF8V0Ef/3HyXMM0DAFItHZGGq0LWUIu9reFvh/Ap3t
         NMAXiVc3V8Fvzt13QdK6s3psdt83el3mmurHOYHjzSy6mURBSC/UsyXHX/ftYVPfn74U
         MoCaLvWrwDTBVKFiA99YKdKxCj16zjygAIHaqDoTCIMnm0OTJj2FOFv/GaYL8aGuJvHF
         NXN+pgc53s2uKoBQEhS7JE3/npi23pLmLFHi7DbaaiWhKy0piVfKNjyHVQp85tMiEGzj
         /eqOmdPgXgXfTpoBhO7t7ODo73INp98htCPM/MMUsi1aC2CJQ22/XxZPD8MX7+uR5NT1
         Rbcg==
X-Gm-Message-State: AAQBX9f+wr3k+mnBF39U8OsXSOxgycME0icZCP1E+lWAS5g1HLIxr9L+
	Bmq5LjqVFq1vMp5GL8NywqzMYLw54AYnJvhdsXiLS/21blxw3ojZtBOozRUohd9/1kGMwbNAJ2J
	afh15UIOIDPIJnaymTRV0VHIkEpDt
X-Received: by 2002:a1c:7406:0:b0:3f0:7db5:6077 with SMTP id p6-20020a1c7406000000b003f07db56077mr717643wmc.39.1681273263016;
        Tue, 11 Apr 2023 21:21:03 -0700 (PDT)
X-Google-Smtp-Source: AKy350YxP9aJXz8zaC1mmG3g9Huuh5f0i4O6Rkm8eciBOAClCMWfphsnda4MjtMqfX1hDsDi2uIhDQ==
X-Received: by 2002:a1c:7406:0:b0:3f0:7db5:6077 with SMTP id p6-20020a1c7406000000b003f07db56077mr717632wmc.39.1681273262744;
        Tue, 11 Apr 2023 21:21:02 -0700 (PDT)
Date: Wed, 12 Apr 2023 00:20:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Satananda Burla <sburla@marvell.com>
Message-ID: <20230412002017-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
 <CACGkMEtMOy4B-O-52ka+9P3OBQ_hs1KvdjWodNYg-XKLff+giw@mail.gmail.com>
 <307a9f8f-6184-0403-97ab-1b1c16d4fd3c@nvidia.com>
 <CACGkMEucOwwFDMqyWA+DgYV7X=9f5-P4Ba_AP=5kTsjna=n+7A@mail.gmail.com>
 <PH0PR12MB548194B46A3E32329C10D00EDC9A9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEstkFaH1rh+O-D9h=bin_09ut2_GnSZDsxrQi_ptDtBKg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEstkFaH1rh+O-D9h=bin_09ut2_GnSZDsxrQi_ptDtBKg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] [PATCH 08/11] transport-pci: Introduce virtio
 extended capability

On Wed, Apr 12, 2023 at 12:04:45PM +0800, Jason Wang wrote:
> On Wed, Apr 12, 2023 at 3:01 AM Parav Pandit <parav@nvidia.com> wrote:
> >
> >
> > > From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> On
> > > Behalf Of Jason Wang
> > > Sent: Monday, April 10, 2023 11:29 PM
> >
> > > > However, it is not backward compatible, if the device place them in
> > > > extended capability, it will not work.
> > > >
> > >
> > > It is kind of intended since it is only used for new PCI-E features:
> > >
> > New fields in new extended pci cap area is fine.
> > Migrating old fields to be present in the new extended pci cap, is not your intention. Right?
> 
> Right, but what I want to say is, such migration may cause unnecessary
> problems. And I don't see why it is a must for your legacy MMIO bar
> proposal.
> 
> >
> > > "
> > > +The location of the virtio structures that depend on the PCI Express
> > > +capability are specified using a vendor-specific extended capabilities
> > > +on the extended capabilities list in PCI Express extended configuration
> > > +space of the device.
> > > "
> > >
> > > > To make it backward compatible, a device needs to expose existing
> > > > structure in legacy area. And extended structure for same capability
> > > > in extended pci capability region.
> > > >
> > > > In other words, it will have to be a both places.
> > >
> > > Then we will run out of config space again?
> > No.
> > Only currently defined caps to be placed in two places.
> 
> What's the advantage of doing this?
> 
> New drivers should provide backward compatibility so they must scan the pci cap.

No, they can start with express cap. Finding one they can skip
the old cap completely.

> The Old driver can only scan the pci cap.
> 
> > New fields don’t need to be placed in PCI cap, because no driver is looking there.
> 
> It would be much more simple if we forbid placing new fields in the
> PCI cap, it is already out of space.
> 
> Thanks
> 
> >
> > We probably already discussed this in previous email by now.
> >
> > > Otherwise we need to deal with the
> > > case when existing structures were only placed at extended capability. Michael
> > > suggest to add a new feature, but the driver may not negotiate the feature
> > > which requires more thought.
> > >
> > Not sure I understand feature bit.
> > PCI transport fields existence is usually not dependent on upper layer protocol.
> >
> > > > We may need it even sooner than this because the AQ patch is expanding
> > > > the structure located in legacy area.
> > >
> > > Just to make sure I understand this, assuming we have adminq, any reason a
> > > dedicated pcie ext cap is required?
> > >
> > No. it was my short sight. I responded right after above text that AQ doesn’t need cap extension.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

