Return-Path: <virtio-dev-return-12157-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F227CC77B70
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 02:56:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2AA9CC6237
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 02:56:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 075429865B3
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 02:56:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DC7419864B3; Wed, 12 Apr 2023 02:56:46 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C7DF7986509
	for <virtio-dev@lists.oasis-open.org>; Wed, 12 Apr 2023 02:56:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 7qJi9Uh2Mm6zuow5NmD-NQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681268203;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tXDVNq8hBrjWw1O/AXkT8kMmUohD8bANB/4wIOb1fog=;
        b=IqBHrB4fT+z5Ud3ojQUBmZaZdWLZM8hDQhwNuTAmdn05b5PCWyx8JXVStUDfZK+1XB
         HjSk9xNQLBJA5mjkXZ56j3N0BZ4ICiaJ7RFmMo0FvT+55T79Z07VDXHOn3pdhztVDAPE
         SpcQBIDrxDVO9o5PTcKVh3WBs8JIusTMahiD/QUjMShPcKhYg94e0m/JY/+MzYQ9e1eO
         eqWVSNCRz43rAZIgTgY0ADR/pqPfpVRWGL3wyP3+FpHC9noeBRiMFYh5jZ8XQVDuoXDz
         442W32Q550kyzOGpv1nOp3y2Ch8eSXKuDLs3HgbCZA5KLCd9OVNW3jccgTCNX/nkW2+I
         04CQ==
X-Gm-Message-State: AAQBX9ckxz+Oro4BLbOgCAEfvjfbvJYV/uIWqo7BLMsPsRe8QAf8pgPw
	yCdQXJcS0GQEcsTJBFbxTcb/GN2MjVNluKDZHc+OwbAP0ZEgUBpNx9yDl2xcY9ekD+NOs8bFCiR
	zKgvEtPk1h/Ydt+bMnxspp03Usn1W
X-Received: by 2002:a7b:cb85:0:b0:3ef:acf6:f829 with SMTP id m5-20020a7bcb85000000b003efacf6f829mr11453228wmi.19.1681268203174;
        Tue, 11 Apr 2023 19:56:43 -0700 (PDT)
X-Google-Smtp-Source: AKy350YeFowl16CAr/nmf9NOeNCxuY2E3Gl6Lb1i0kUiQWlVt06UG0NeyTaapwK7k5hAF+R3EhihFw==
X-Received: by 2002:a7b:cb85:0:b0:3ef:acf6:f829 with SMTP id m5-20020a7bcb85000000b003efacf6f829mr11453224wmi.19.1681268202890;
        Tue, 11 Apr 2023 19:56:42 -0700 (PDT)
Date: Tue, 11 Apr 2023 22:56:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Satananda Burla <sburla@marvell.com>
Message-ID: <20230411225515-mutt-send-email-mst@kernel.org>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
 <CACGkMEtMOy4B-O-52ka+9P3OBQ_hs1KvdjWodNYg-XKLff+giw@mail.gmail.com>
 <307a9f8f-6184-0403-97ab-1b1c16d4fd3c@nvidia.com>
 <CACGkMEucOwwFDMqyWA+DgYV7X=9f5-P4Ba_AP=5kTsjna=n+7A@mail.gmail.com>
 <PH0PR12MB548194B46A3E32329C10D00EDC9A9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230411172207-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D2F7893E4FBA32837EFFDC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481D2F7893E4FBA32837EFFDC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio-dev] [PATCH 08/11] transport-pci: Introduce virtio
 extended capability

On Wed, Apr 12, 2023 at 12:40:53AM +0000, Parav Pandit wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, April 11, 2023 5:25 PM
> > 
> > On Tue, Apr 11, 2023 at 07:01:16PM +0000, Parav Pandit wrote:
> > >
> > > > From: virtio-dev@lists.oasis-open.org
> > > > <virtio-dev@lists.oasis-open.org> On Behalf Of Jason Wang
> > > > Sent: Monday, April 10, 2023 11:29 PM
> > >
> > > > > However, it is not backward compatible, if the device place them
> > > > > in extended capability, it will not work.
> > > > >
> > > >
> > > > It is kind of intended since it is only used for new PCI-E features:
> > > >
> > > New fields in new extended pci cap area is fine.
> > > Migrating old fields to be present in the new extended pci cap, is not your
> > intention. Right?
> > >
> > > > "
> > > > +The location of the virtio structures that depend on the PCI
> > > > +Express capability are specified using a vendor-specific extended
> > > > +capabilities on the extended capabilities list in PCI Express
> > > > +extended configuration space of the device.
> > > > "
> > > >
> > > > > To make it backward compatible, a device needs to expose existing
> > > > > structure in legacy area. And extended structure for same
> > > > > capability in extended pci capability region.
> > > > >
> > > > > In other words, it will have to be a both places.
> > > >
> > > > Then we will run out of config space again?
> > > No.
> > > Only currently defined caps to be placed in two places.
> > > New fields don’t need to be placed in PCI cap, because no driver is looking
> > there.
> > >
> > > We probably already discussed this in previous email by now.
> > >
> > > > Otherwise we need to deal with the
> > > > case when existing structures were only placed at extended
> > > > capability. Michael suggest to add a new feature, but the driver may
> > > > not negotiate the feature which requires more thought.
> > > >
> > > Not sure I understand feature bit.
> > 
> > This is because we have a concept of dependency between features but not a
> > concept of dependency of feature on capability.
> > 
> A feature bit is accessible after virtio level initialization is complete.
> Virtio level initialization depends on the PCI layer transport attributes.
> So pci level attributes should exists regardless of upper layer initialization.

sure

> > > PCI transport fields existence is usually not dependent on upper layer
> > protocol.
> > >
> > > > > We may need it even sooner than this because the AQ patch is
> > > > > expanding the structure located in legacy area.
> > > >
> > > > Just to make sure I understand this, assuming we have adminq, any
> > > > reason a dedicated pcie ext cap is required?
> > > >
> > > No. it was my short sight. I responded right after above text that AQ doesn’t
> > need cap extension.
> > 
> > 
> > 
> > You know, thinking about this, I begin to feel that we should require that if at
> > least one extended config exists then all caps present in the regular config are
> > *also* mirrored in the extended config. IOW extended >= regular.
> Fair but why is this a requirement to mirror?
> Is the below one to improve the perf?

yes

> If so, it is fine, but I guess it is optional.

It can not be optional otherwise guest has to scan legacy capability list too
losing perf advantage :).

> > The reason is that extended config can be emulated more efficiently (2x less
> > exits).
> > WDYT?
> > 
> > 
> > --
> > MST
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

