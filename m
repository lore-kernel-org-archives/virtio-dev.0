Return-Path: <virtio-dev-return-13661-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 714A2EE57DF
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 06:31:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CDD298504E
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 06:31:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C529B986499
	for <virtio-dev@archiver.kernel.org>; Mon, 11 Sep 2023 06:31:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B905A981BDD; Mon, 11 Sep 2023 06:31:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9F525986461
	for <virtio-dev@lists.oasis-open.org>; Mon, 11 Sep 2023 06:30:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: tOKKEMUUMzih41LqTSSvPg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694413842; x=1695018642;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zs6opqtgpDNVgyyoPb5IDKMXXIryVQLxq3I5A/AjfQg=;
        b=fHBS/NSgmwKbKum9mkVifgrFLjYzlpsO6YEsZP7Xgrt0cJPYz5HQxMd9hDOLdyyasy
         rihJfLq1qRTGkyZg/wQPwIKl2+foFIacazyUdqZXLbkDp1QBsUfEpkZ3I5T20UUFE+0A
         IOpDVDSIRoJ3vo/0MRInavY/UrDGvVmkHWdVnNHqmxwTr1fAJAXW2J1Q5//uv0otQulX
         Qnj4UnXs79F8hw5rFu8uwSlinCTPt4DLeofiMK7QAS3RO+YJ0bmDk57TmdQgCEUVQzO5
         cgaeCGIeyVt1/bAUvy/dYT8R2aE+FUNnxHxmctjRCW79nV4f+BywaNcQcLwimMdeVZik
         5K4g==
X-Gm-Message-State: AOJu0Yw/cOu3KanZ1o4x4FFi95bzyB2SqEfuNVLv9bHkVxmebAnXCHm/
	4U9etE30yTWOiHG5KLF9tMnDMWdK+5NdGBQv3nztBILny2/Fp2BufchduugmN0r2wCKtTVCQ4Bh
	Skd+DUhPVfOY7Ku3I4fdeRZk0lqm3M02bpp2fwMRbwRfZ
X-Received: by 2002:a05:6512:239e:b0:4f8:4512:c846 with SMTP id c30-20020a056512239e00b004f84512c846mr8195847lfv.49.1694413842688;
        Sun, 10 Sep 2023 23:30:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE77Emf1/xwl41eUsNG+hRogwnpcthgoltjJZmC+PL0mzwqljAh+hSZyo541WOIoLIXYXryn9mb23XA9rlOj7c=
X-Received: by 2002:a05:6512:239e:b0:4f8:4512:c846 with SMTP id
 c30-20020a056512239e00b004f84512c846mr8195820lfv.49.1694413842325; Sun, 10
 Sep 2023 23:30:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-6-lingshan.zhu@intel.com> <20230906043016-mutt-send-email-mst@kernel.org>
 <CACGkMEu4R_nUFmpoNesmjJ-PtoE5brpWh8NLruWhEWycm2K4yg@mail.gmail.com> <PH0PR12MB5481A50B1B13CE1756B98D0DDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481A50B1B13CE1756B98D0DDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 11 Sep 2023 14:30:31 +0800
Message-ID: <CACGkMEtMmwWGJDYe5BLvLCcetThv-yfPR2QbphNuuh+bp-+ikg@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>, 
	"eperezma@redhat.com" <eperezma@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, 
	"stefanha@redhat.com" <stefanha@redhat.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] [PATCH 5/5] virtio-pci: implement VIRTIO_F_QUEUE_STATE

On Mon, Sep 11, 2023 at 12:12=E2=80=AFPM Parav Pandit <parav@nvidia.com> wr=
ote:
>
> Hi Michael,
>
> > From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> > open.org> On Behalf Of Jason Wang
> > Sent: Monday, September 11, 2023 8:31 AM
> >
> > On Wed, Sep 6, 2023 at 4:33=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Wed, Sep 06, 2023 at 04:16:37PM +0800, Zhu Lingshan wrote:
> > > > This patch adds two new le16 fields to common configuration
> > > > structure to support VIRTIO_F_QUEUE_STATE in PCI transport layer.
> > > >
> > > > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > >
> > >
> > > I do not see why this would be pci specific at all.
> >
> > This is the PCI interface for live migration. The facility is not speci=
fic to PCI.
> >
> > It can choose to reuse the common configuration or not, but the semanti=
c is
> > general enough to be used by other transports. We can introduce one for
> > MMIO for sure.
> >
> > >
> > > But besides I thought work on live migration will use admin queue.
> > > This was explicitly one of the motivators.
> >
> Please find the proposal that uses administration commands for device mig=
ration at [1] for passthrough devices.
>
> [1] https://lists.oasis-open.org/archives/virtio-comment/202309/msg00061.=
html

This proposal couples live migration with several requirements, and
suffers from the exact issues I've mentioned below.

In some cases, it's even worse (coupling with PCI/SR-IOV, second state
machine other than the device status).

>
>  > I think not. Using admin virtqueue will end up with several problems:
> >
> > 1) the feature is not self contained so at the end we need transport sp=
ecific
> > facility to migrate the admin virtqueue
>
> You mixed up.
> Admin queue of the owner device is not migrated.

Why not? Ling Shan's proposal makes everything work including
migrating the owner or in the case there's even no owner.

In this proposal, the facility (suspending, queue state, inflight
descriptors) is decoupled from the transport specific API. Each
transport can implement one or more types of interfaces. A MMIO based
interface is proposed but It doesn't prevent you from adding admin
commands for those facilities on top.

> Admin queue of the member device is migrated like any other queue using a=
bove [1].
>
> > 2) won't work in the nested environment, or we need complicated SR-IOV
> > emulation in order to work
> >
> > >
> > > Poking at the device from the driver to migrate it is not going to
> > > work if the driver lives within guest.
> >
> > This is by design to allow live migration to work in the nested layer.
> > And it's the way we've used for CPU and MMU. Anything may virtio differ=
ent
> > here?
>
> Nested and non-nested use cases likely cannot be addressed by single solu=
tion/interface.

I think Ling Shan's proposal addressed them both.

> So both are orthogonal requirements to me.
>
> One can defined some administration commands to issue on the AQ of the me=
mber device itself for nested case.

This is not easy, DMA needs to be isolated so this means you need to
either emulate SR-IOV and use AQ on virtual PF in the guest or using
PASID.

Customers don't want to have admin stuff, SR-IOV or PASID in the guest
in order to migrate a single virtio device in the nest.

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

