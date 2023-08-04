Return-Path: <virtio-dev-return-13459-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E314C001DE
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 03:29:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D9F2094EE6
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 03:29:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CAE0E986724
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 03:29:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BE13F9866DD; Fri,  4 Aug 2023 03:29:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9EA409866E2
	for <virtio-dev@lists.oasis-open.org>; Fri,  4 Aug 2023 03:29:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: dxl8JNHlOHqCGZOZMrTijQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691119757; x=1691724557;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/yWB8G/g/S3tqgQtlmdTnMbrPkyAJHrsfQ79w64H4f4=;
        b=Z43nK+EKpqOiHDEnBMBWGCi0+XGOg4ylmhCRbsuBVpag8B4HskHf9HRpsA02rrB8Bg
         yHMgRiB2vZlujY+LZ2mByd5+yq/wWvxl7Mcg0DdP2vmxCjKMl0IrElFMZJ+WCqkhkeMf
         5zy2QnJ6wCmZlnTVxA3oXef2dScXtTnTA96E2ahuq9hRFuMafDDtX1PYXEIedw4qjMDL
         FGcZ/J3xeCXeRkiDwmKgNnwD2kPRYG7mRIKvpmyV5HcuAEFNqpxluTlRTNaE9cy/eX3y
         rMfoyEKfCj2eRfH5eTlDeIo75Rmx3nmU4X6jrUelgck/wgskFR492JdhHrPDBNOlCc66
         UzDA==
X-Gm-Message-State: AOJu0Yy3PDpaum9GkysP9+aKJYpulMU4zhqx/XYAsrfrLOAchIqItBdx
	o5nyCMCrH1aLiKuPDtq1jEudzTvK/THlpAj66gMUP+RryUnTYk1R47VV3VOYC3YwazJ4okZ9kcH
	hmL/pXJylnni52CTSaUPkG2eBv1a3Xrxl4BtD92XBNwaS
X-Received: by 2002:a2e:904c:0:b0:2b6:d13a:8e34 with SMTP id n12-20020a2e904c000000b002b6d13a8e34mr430768ljg.46.1691119757283;
        Thu, 03 Aug 2023 20:29:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECeAAyLYm4XGgTyERIinh69AgUiD6+DJ8LlpWp5cnnCdfqZRDSrt8QLRGe/VaksHbMbUv2MqiRGmxDMP50gIw=
X-Received: by 2002:a2e:904c:0:b0:2b6:d13a:8e34 with SMTP id
 n12-20020a2e904c000000b002b6d13a8e34mr430760ljg.46.1691119756969; Thu, 03 Aug
 2023 20:29:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230803083150.46745-1-xuanzhuo@linux.alibaba.com>
 <20230803054333-mutt-send-email-mst@kernel.org> <1691059929.235804-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481B5B3C5366CCACB221083DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691060652.3764465-2-xuanzhuo@linux.alibaba.com> <PH0PR12MB548191AE225B08BACFC0C350DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691061508.9066079-5-xuanzhuo@linux.alibaba.com> <PH0PR12MB5481CB7BE555F4672394A6ECDC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062204.2378864-7-xuanzhuo@linux.alibaba.com> <PH0PR12MB5481E104793F9E68E1DC95CADC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062877.0013635-8-xuanzhuo@linux.alibaba.com> <PH0PR12MB5481C3CE21016385BF7D6FF0DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <SJ0PR18MB44773DCEDDEF6B612F7BC5B7C308A@SJ0PR18MB4477.namprd18.prod.outlook.com>
In-Reply-To: <SJ0PR18MB44773DCEDDEF6B612F7BC5B7C308A@SJ0PR18MB4477.namprd18.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 4 Aug 2023 11:29:05 +0800
Message-ID: <CACGkMEt25xSujE2nfzna-thhPgsOqLn_=+wKJYFGE9jh3Yhq9Q@mail.gmail.com>
To: Satananda Burla <sburla@marvell.com>
Cc: Parav Pandit <parav@nvidia.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] RE: RE: RE: RE: [RFC] virtio-net: support access
 and control the member devices

On Fri, Aug 4, 2023 at 1:03=E2=80=AFAM Satananda Burla <sburla@marvell.com>=
 wrote:
>
>
>
> > -----Original Message-----
> > From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org>
> > On Behalf Of Parav Pandit
> > Sent: Thursday, August 3, 2023 6:16 AM
> > To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Cc: virtio-dev@lists.oasis-open.org; jasowang@redhat.com; virtio-
> > comment@lists.oasis-open.org; Michael S. Tsirkin <mst@redhat.com>
> > Subject: [EXT] [virtio-dev] RE: [virtio-comment] RE: RE: RE: RE: [RFC]
> > virtio-net: support access and control the member devices
> >
> > External Email
> >
> > ----------------------------------------------------------------------
> >
> >
> > > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > Sent: Thursday, August 3, 2023 5:11 PM
> > >
> > > On Thu, 3 Aug 2023 11:39:20 +0000, Parav Pandit <parav@nvidia.com>
> > wrote:
> > > >
> > > > > From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > Sent: Thursday, August 3, 2023 5:00 PM
> > > >
> > > >
> > > > > > Admin command is what is suitable for device management,
> > including
> > > > > features and configspace fields setup.
> > > > >
> > > > > I agree.
> > > > >
> > > > > But some configuration such as mac, ip(eswitch rule) for vfs that
> > > > > are suitable for the admin queue?
> > > > Mac, why not.
> > >
> > > Mac is the concept of the virtio-net.
> > > How do abstract it? Or a admin queue command
> > > VIRTIO_ADMIN_CMD_NET_MAC_SET?
> > >
> > I don't think we should abstract it.
> > A one command that can set one or multiple fields of the config space i=
s
> > fine.
> >
> > > >
> > > > Eswith rules should be programmed through the flow vq, that we are
> > working
> > > with Heng, Satananda and David.
> > >
> > > I know you are doing for the n-tuple receive flow filters.
> > >
> > > Here I mean we want to limit the ip of the VF. In the cloud case, the
> > vm is
> > > untrust, we should force the vm that it just can use the specified ip=
.
> > >
> > That is fine,
> >  It is just that the flow filter commands may be different for ingress
> > and egress direction of the VF.
> > The command that we are adding does not have concept of switch ports,
> > because there is no switch.
> >
> > For eswitch case, you would define more commands that will have switch
> > ports...
> >
> > > Then can we configure the ip of the vfs via the admin queue?
> >
> > It should be through the flow filter queue so that it can be performant
> > like nic tx/rxq which has dedicated role.
> > For switch use case command formats or fields needs extension.
> IMO, kernel already prescribes using representors for mac/vlan  programmi=
ng
> for SRIOV/SIOV eswitch devices, member devices may have to support repres=
entor
> interfaces.

I second this.

Thanks

> >
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>
>
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
>
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
>
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-l=
ists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

