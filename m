Return-Path: <virtio-dev-return-12714-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5167FC77B75
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 05:38:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7455E23D67
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 05:38:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 516BC9865B0
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 05:38:11 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 32FB3983E4A; Tue, 16 May 2023 05:38:11 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1E01F986510
	for <virtio-dev@lists.oasis-open.org>; Tue, 16 May 2023 05:38:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: KlBAAL1JMYy8lbY7nbcV0Q-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684215487; x=1686807487;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J3L3sxiIv2iMIYjweg4bwNR0mcDkJJqub61egE6dp44=;
        b=dyisO+gaJMXxeiCqRkDFlNfnn+P1QCxeoSSecaNmWkdeLj7PEqXrHo49e0M+weUVQ+
         7sHFs5XFwxHFJVMM9mhBLrEBe7PRkyj68c2ENCdMowen/Gz+A+yRFVbkMAuHnPheLCnt
         KaiGwa/OI2CdhdehKypc/sQ/CaJ1j9DnEBJf93BgELdDUKYQubvrV4I7qQgQa5N/r7Qr
         yEx1QFDo7/4NVNUXmh58JoTmouu+UkuGSKBFBs3bQJz5zVOC4UbuTB84CdcnbgGzJVxW
         2cjEjV9UnPJHn0TZltI8lcaN61I+Z0qW9Dw5jIV6LBetgzTI70wKqD8sphcA43P2c5m7
         RQlA==
X-Gm-Message-State: AC+VfDws5nOYxGb5SAnx9aV6NA6+GzIZYXuyoJlqFSgup/6HWX7Yi1Fk
	XjLEpqvJsZVQJjg/LgiyuMoDb5QW74Ofn9tu8UNlMAJ7nxE+ANvHmmkoKXJGaYYRDq2hBXN1CAF
	uvBojsH7w6O/+ZBzo9KXUDXGpYAk4
X-Received: by 2002:a1c:f402:0:b0:3f0:44d1:3ba5 with SMTP id z2-20020a1cf402000000b003f044d13ba5mr25235320wma.5.1684215487712;
        Mon, 15 May 2023 22:38:07 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6uZdsPQOyXLLWdjQ6em8yx4Rm7wrXu4OlLdsQ2E8l4QKJ+biJ8NVOH+t9gjcgn2z5wo8pHUA==
X-Received: by 2002:a1c:f402:0:b0:3f0:44d1:3ba5 with SMTP id z2-20020a1cf402000000b003f044d13ba5mr25235308wma.5.1684215487423;
        Mon, 15 May 2023 22:38:07 -0700 (PDT)
Date: Tue, 16 May 2023 01:38:03 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230516013721-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB5481DE0569EC53A862A4D2E9DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <893b6ec0-a74f-69b7-95a3-988f0f9382a8@redhat.com>
 <PH0PR12MB5481CF52380D414AFFBA6A9FDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230515133719-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810DE3ECAE95689F80C596DC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230515135513-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481923CB4F23968C39F14D8DC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230515140052-mutt-send-email-mst@kernel.org>
 <78ade48a-6f5d-8a2d-1524-44340f0154ce@redhat.com>
 <CACGkMEteeW0yxcguiZ2zBVzmqt12pVRZwofJwVJFo7=FBdyx5A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEteeW0yxcguiZ2zBVzmqt12pVRZwofJwVJFo7=FBdyx5A@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

On Tue, May 16, 2023 at 11:43:09AM +0800, Jason Wang wrote:
> On Tue, May 16, 2023 at 11:37 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> >
> > 在 2023/5/16 02:01, Michael S. Tsirkin 写道:
> > > On Mon, May 15, 2023 at 06:00:02PM +0000, Parav Pandit wrote:
> > >>> From: Michael S. Tsirkin <mst@redhat.com>
> > >>> Sent: Monday, May 15, 2023 1:56 PM
> > >>>
> > >>> On Mon, May 15, 2023 at 05:51:05PM +0000, Parav Pandit wrote:
> > >>>>> From: Michael S. Tsirkin <mst@redhat.com>
> > >>>>> Sent: Monday, May 15, 2023 1:45 PM
> > >>>>>
> > >>>>> On Mon, May 15, 2023 at 03:49:44PM +0000, Parav Pandit wrote:
> > >>>>>> All legacy interface via AQ.
> > >>>>>> All modern interface access via PCI or its own transport between
> > >>>>>> driver and
> > >>>>> device.
> > >>>>>
> > >>>>> I am wondering however about the hypervisor notifications.
> > >>>>> Generally these are the most problematic aspect here I feel.  For
> > >>>>> example, how does it interact with VIRTIO_F_NOTIF_CONFIG_DATA?  And
> > >>>>> generally, having both guest and host be allowed to access device's BAR
> > >>> seems problematic.
> > >>>>> Can we reserve a PF BAR region for these things or is that too expensive?
> > >>>> VIRTIO_F_NOTIF_CONFIG_DATA is not present for the legacy.
> > >>> it is not but it just might be required, or it won't be there.
> > >>>
> > >> How can it be required if it not part of it?
> > >> I likely didn't follow your question/comment, can you please explain.
> > > VIRTIO_F_NOTIF_CONFIG_DATA is there presumably for a reason.
> > >
> > >>>> For modern device, guest driver will access the device own BAR directly with
> > >>> its own config_data anyway.
> > >>>> Should we reserve a region in the PF BAR for SF/SIOV device?, should device
> > >>> report which BAR/area to use for the given SF/SIOV device?
> > >>>> May be yes, those are different discussions with tradeoff to consider during
> > >>> SIOV discussions. It is not related to VFs.
> > >>>
> > >>> For SIOV it's a given. But we can do this for SRIOV: reserve a PF region per VF.
> > >> Each VF has its own BAR area for driver notifications.
> > > But it is passed through to guest presumably.
> >
> >
> > Probably not in the case of VIRTIO_F_NOTIF_CONFIG_DATA. Did you see any
> > problem if we do mediation here except for some performance penalty?
> 
> Ok, rethink of this, when using legacy, VIRTIO_F_NOTIF_CONFIG_DATA
> should be assumed to be not negotiated. So I think I agree with Parav,
> it should not be a problem.
> 
> Or do you mean for the devices that have some mandated features?
> 
> Thanks

Exactly. VIRTIO_F_NOTIF_CONFIG_DATA if there is likely to be
required for device to work as opposed to being an optimization.

> >
> > Thanks
> >
> >
> > >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

