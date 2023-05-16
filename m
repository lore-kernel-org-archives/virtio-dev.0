Return-Path: <virtio-dev-return-12707-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD27C77B75
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 03:43:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 80C602AFF1
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 03:43:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 61628986579
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 03:43:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4711C986510; Tue, 16 May 2023 03:43:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 34FBB986511
	for <virtio-dev@lists.oasis-open.org>; Tue, 16 May 2023 03:43:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: TGx2wGFXPf6nrCWTsh7Usg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684208601; x=1686800601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YFtEmpHHyFqIczufRsyvhP4JPgzdSWld8ykLyEHmwUM=;
        b=COsRLVupzjwonLZVN4yTm3TIoBsI77m9gs7RvLuaNXl56Tls37v7mydSSh+pl86z8t
         zQvsSmEFfEQV5cB77W28qOt3WAu2SrjMMD1gilBInFNAWBq89qyTw31r/ehiySkbGne7
         YI8TU+MQui5XtMODigSP/vTRJLK7kqGWBdS10dy3tA9lJ8E4/L5SHiMgG1T6g6J/Hgn5
         3qBJkzTW+aLCL8KknSyTMR1rDeKOO98Ei3xO/gmM980ZgxPTJQBDLRDuuZN95VMpkK/r
         WWGLPDoAzASHvfipaQsrSZjbRf5nxOOmW9RUQtuT/ikgYr1i1fbV381ydOjXY0IqaYnH
         E1jA==
X-Gm-Message-State: AC+VfDxdFiwqkTwc6uk+GY/YGYuBJz+e5SGQ6Fy2DErgyx9aLeWlZtkM
	LTO9sB5DkS03Nm5eSEabFKArisdy2M8LwsleJuuwiwiyrrWqKosw75+cmbXRNkUgn1NHMkfBeYT
	VptZNbbEzQzRq+v66vkPFrKy5cgnzPsrv/hxC7jvkh/+k
X-Received: by 2002:a05:6512:208:b0:4ec:9ef9:e3d with SMTP id a8-20020a056512020800b004ec9ef90e3dmr6505201lfo.26.1684208601349;
        Mon, 15 May 2023 20:43:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5BZZ+xkQz5IzSA+9OnjQtRl740UPrPdr8ge1IoUe8efZVn9AMZ6no2p1oh7i2vm2sk8G/SX4n9IJaFGJFIOl0=
X-Received: by 2002:a05:6512:208:b0:4ec:9ef9:e3d with SMTP id
 a8-20020a056512020800b004ec9ef90e3dmr6505189lfo.26.1684208601066; Mon, 15 May
 2023 20:43:21 -0700 (PDT)
MIME-Version: 1.0
References: <PH0PR12MB5481F030A76141320F03956EDC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481CEB307F413E53B03D502DC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtm5AS50YmPi6A5=gzZZ9Jm55NEJ3GKOTzv-Z0m5E5J_w@mail.gmail.com>
 <PH0PR12MB5481DE0569EC53A862A4D2E9DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <893b6ec0-a74f-69b7-95a3-988f0f9382a8@redhat.com> <PH0PR12MB5481CF52380D414AFFBA6A9FDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230515133719-mutt-send-email-mst@kernel.org> <PH0PR12MB54810DE3ECAE95689F80C596DC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230515135513-mutt-send-email-mst@kernel.org> <PH0PR12MB5481923CB4F23968C39F14D8DC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230515140052-mutt-send-email-mst@kernel.org> <78ade48a-6f5d-8a2d-1524-44340f0154ce@redhat.com>
In-Reply-To: <78ade48a-6f5d-8a2d-1524-44340f0154ce@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 May 2023 11:43:09 +0800
Message-ID: <CACGkMEteeW0yxcguiZ2zBVzmqt12pVRZwofJwVJFo7=FBdyx5A@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, 
	"cohuck@redhat.com" <cohuck@redhat.com>, 
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>, 
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

On Tue, May 16, 2023 at 11:37=E2=80=AFAM Jason Wang <jasowang@redhat.com> w=
rote:
>
>
> =E5=9C=A8 2023/5/16 02:01, Michael S. Tsirkin =E5=86=99=E9=81=93:
> > On Mon, May 15, 2023 at 06:00:02PM +0000, Parav Pandit wrote:
> >>> From: Michael S. Tsirkin <mst@redhat.com>
> >>> Sent: Monday, May 15, 2023 1:56 PM
> >>>
> >>> On Mon, May 15, 2023 at 05:51:05PM +0000, Parav Pandit wrote:
> >>>>> From: Michael S. Tsirkin <mst@redhat.com>
> >>>>> Sent: Monday, May 15, 2023 1:45 PM
> >>>>>
> >>>>> On Mon, May 15, 2023 at 03:49:44PM +0000, Parav Pandit wrote:
> >>>>>> All legacy interface via AQ.
> >>>>>> All modern interface access via PCI or its own transport between
> >>>>>> driver and
> >>>>> device.
> >>>>>
> >>>>> I am wondering however about the hypervisor notifications.
> >>>>> Generally these are the most problematic aspect here I feel.  For
> >>>>> example, how does it interact with VIRTIO_F_NOTIF_CONFIG_DATA?  And
> >>>>> generally, having both guest and host be allowed to access device's=
 BAR
> >>> seems problematic.
> >>>>> Can we reserve a PF BAR region for these things or is that too expe=
nsive?
> >>>> VIRTIO_F_NOTIF_CONFIG_DATA is not present for the legacy.
> >>> it is not but it just might be required, or it won't be there.
> >>>
> >> How can it be required if it not part of it?
> >> I likely didn't follow your question/comment, can you please explain.
> > VIRTIO_F_NOTIF_CONFIG_DATA is there presumably for a reason.
> >
> >>>> For modern device, guest driver will access the device own BAR direc=
tly with
> >>> its own config_data anyway.
> >>>> Should we reserve a region in the PF BAR for SF/SIOV device?, should=
 device
> >>> report which BAR/area to use for the given SF/SIOV device?
> >>>> May be yes, those are different discussions with tradeoff to conside=
r during
> >>> SIOV discussions. It is not related to VFs.
> >>>
> >>> For SIOV it's a given. But we can do this for SRIOV: reserve a PF reg=
ion per VF.
> >> Each VF has its own BAR area for driver notifications.
> > But it is passed through to guest presumably.
>
>
> Probably not in the case of VIRTIO_F_NOTIF_CONFIG_DATA. Did you see any
> problem if we do mediation here except for some performance penalty?

Ok, rethink of this, when using legacy, VIRTIO_F_NOTIF_CONFIG_DATA
should be assumed to be not negotiated. So I think I agree with Parav,
it should not be a problem.

Or do you mean for the devices that have some mandated features?

Thanks

>
> Thanks
>
>
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

