Return-Path: <virtio-dev-return-12609-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3816C7EE24
	for <virtio-dev@archiver.kernel.org>; Mon,  8 May 2023 02:23:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DE2112A8F4
	for <virtio-dev@archiver.kernel.org>; Mon,  8 May 2023 02:23:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C97BB9863CE
	for <virtio-dev@archiver.kernel.org>; Mon,  8 May 2023 02:23:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BCA479862A9; Mon,  8 May 2023 02:23:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A5C84986298
	for <virtio-dev@lists.oasis-open.org>; Mon,  8 May 2023 02:23:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: eAi7KdY2Pz2qm8dPoJLhWg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683512631; x=1686104631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMcy8JJJwdZBEVkCfVaorw/bBGg2/m4UmX3pIleLcrE=;
        b=DCgeUvgnajNxAqNjFsc/T60cSWRQ9jISfSEGcD06BsxbDbc5HO1p7XB78zz6runDL0
         rS262JJkynf5HUf0zk5ooVi0olYwespBkpn1HjbPDulpwbs09/kkvy9B5F+NWtNdIwyw
         xLlT7p5OxsHWCVsldIkmglwY5Zk2AZyBLSUXbaeaM7+92qzAr21WNySpNaEi41l1W5l7
         tZI7/y8IRrITDXeBxqcFrKndIrKkyxrBv41CZPgtWXqbo14zJH1mODGlSBgjstszFZR8
         ibLlBW7PE34LfAwEME8mqWjA0zlYq7ZK2/udx4/i1Zt0mCBlVVkRpOtCY9wsJGCnAnNQ
         Ulgw==
X-Gm-Message-State: AC+VfDx8JUU/MZMsUytG5BWXiTH+XuXqM8+CjeJIBRsnkdnA1Z3lCKwj
	6MYts394fIJjRUCtICepX6akns0TXhWlTxwuF7KZuiTKB/l3xKm3A+Edxn96Q5VdT56RhDVHKyL
	YoYoQEmGQO/oLojXnFt58f034Tt7KwIW2YwEanV2fKs21
X-Received: by 2002:a19:5517:0:b0:4eb:44c2:ab6c with SMTP id n23-20020a195517000000b004eb44c2ab6cmr2039999lfe.2.1683512630827;
        Sun, 07 May 2023 19:23:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5aAs+3E4zj92k364T8J6tEEnSXyatFMCts2ZwjKWx2izzEyhAY8QBMuNdLC18pxSAMT/ARtKfjkj/Vg//+3io=
X-Received: by 2002:a19:5517:0:b0:4eb:44c2:ab6c with SMTP id
 n23-20020a195517000000b004eb44c2ab6cmr2039994lfe.2.1683512630466; Sun, 07 May
 2023 19:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230506000135.628899-1-parav@nvidia.com> <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230507093959-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 8 May 2023 10:23:39 +0800
Message-ID: <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, 
	david.edmondson@oracle.com, sburla@marvell.com, yishaih@nvidia.com, 
	maorg@nvidia.com, virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

On Sun, May 7, 2023 at 9:44=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Sat, May 06, 2023 at 10:31:30AM +0800, Jason Wang wrote:
> > On Sat, May 6, 2023 at 8:02=E2=80=AFAM Parav Pandit <parav@nvidia.com> =
wrote:
> > >
> > > This short series introduces legacy registers access commands for the=
 owner
> > > group member PCI PF to access the legacy registers of the member VFs.
> > >
> > > If in future any SIOV devices to support legacy registers, they
> > > can be easily supported using same commands by using the group
> > > member identifiers of the future SIOV devices.
> > >
> > > More details as overview, motivation, use case are further described
> > > below.
> > >
> > > Patch summary:
> > > --------------
> > > patch-1 adds administrative virtuqueue commands
> > > patch-2 adds its conformance section
> > >
> > > This short series is on top of latest work [1] from Michael.
> > > It uses the newly introduced administrative virtqueue facility with 3=
 new
> > > commands which uses the existing virtio_admin_cmd.
> > >
> > > [1] https://lists.oasis-open.org/archives/virtio-comment/202305/msg00=
112.html
> > >
> > > Usecase:
> > > --------
> > > 1. A hypervisor/system needs to provide transitional
> > >    virtio devices to the guest VM at scale of thousands,
> > >    typically, one to eight devices per VM.
> > >
> > > 2. A hypervisor/system needs to provide such devices using a
> > >    vendor agnostic driver in the hypervisor system.
> > >
> > > 3. A hypervisor system prefers to have single stack regardless of
> > >    virtio device type (net/blk) and be future compatible with a
> > >    single vfio stack using SR-IOV or other scalable device
> > >    virtualization technology to map PCI devices to the guest VM.
> > >    (as transitional or otherwise)
> > >
> > > Motivation/Background:
> > > ----------------------
> > > The existing virtio transitional PCI device is missing support for
> > > PCI SR-IOV based devices. Currently it does not work beyond
> > > PCI PF, or as software emulated device in reality. Currently it
> > > has below cited system level limitations:
> > >
> > > [a] PCIe spec citation:
> > > VFs do not support I/O Space and thus VF BARs shall not indicate I/O =
Space.
> > >
> > > [b] cpu arch citiation:
> > > Intel 64 and IA-32 Architectures Software Developer=E2=80=99s Manual:
> > > The processor=E2=80=99s I/O address space is separate and distinct fr=
om
> > > the physical-memory address space. The I/O address space consists
> > > of 64K individually addressable 8-bit I/O ports, numbered 0 through F=
FFFH.
> > >
> > > [c] PCIe spec citation:
> > > If a bridge implements an I/O address range,...I/O address range will=
 be
> > > aligned to a 4 KB boundary.
> > >
> > > Overview:
> > > ---------
> > > Above usecase requirements can be solved by PCI PF group owner access=
ing
> > > its group member PCI VFs legacy registers using an admin virtqueue of
> > > the group owner PCI PF.
> > >
> > > Two new admin virtqueue commands are added which read/write PCI VF
> > > registers.
> > >
> > > The third command suggested by Jason queries the VF device's driver
> > > notification region.
> > >
> > > Software usage example:
> > > -----------------------
> > > One way to use and map to the guest VM is by using vfio driver
> > > framework in Linux kernel.
> > >
> > >                 +----------------------+
> > >                 |pci_dev_id =3D 0x100X   |
> > > +---------------|pci_rev_id =3D 0x0      |-----+
> > > |vfio device    |BAR0 =3D I/O region     |     |
> > > |               |Other attributes      |     |
> > > |               +----------------------+     |
> > > |                                            |
> > > +   +--------------+     +-----------------+ |
> > > |   |I/O BAR to AQ |     | Other vfio      | |
> > > |   |rd/wr mapper  |     | functionalities | |
> > > |   +--------------+     +-----------------+ |
> > > |                                            |
> > > +------+-------------------------+-----------+
> > >        |                         |
> > >   +----+------------+       +----+------------+
> > >   | +-----+         |       | PCI VF device A |
> > >   | | AQ  |-------------+---->+-------------+ |
> > >   | +-----+         |   |   | | legacy regs | |
> > >   | PCI PF device   |   |   | +-------------+ |
> > >   +-----------------+   |   +-----------------+
> > >                         |
> > >                         |   +----+------------+
> > >                         |   | PCI VF device N |
> > >                         +---->+-------------+ |
> > >                             | | legacy regs | |
> > >                             | +-------------+ |
> > >                             +-----------------+
> > >
> > > 2. Virtio pci driver to bind to the listed device id and
> > >    use it as native device in the host.
> > >
> > > 3. Use it in a light weight hypervisor to run bare-metal OS.
> > >
> > > Please review.
> > >
> > > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/167
> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > >
> > > ---
> > > changelog:
> > > v1->v2:
> > > - addressed comments from Michael
> > > - added theory of operation
> > > - grammar corrections
> > > - removed group fields description from individual commands as
> > >   it is already present in generic section
> > > - added endianness normative for legacy device registers region
> > > - renamed the file to drop vf and add legacy prefix
> > > - added overview in commit log
> > > - renamed subsection to reflect command
> >
> > So as replied in V1, I think it's not a good idea to invent commands
> > for a partial transport just for legacy devices. It's better either:
> >
> > 1) rebase or collaborate this work on top of the transport virtqueue
> >
> > or
> >
> > 2) having a PCI over admin virtqueue transport, since this proposal
> > has already had BAR access, we can add config space access then it is
> > self-contained so we don't need to go through every corner case like
> > inventing dedicated commands to accessing some function that is
> > duplicated with capabilities. It will become yet another transport and
> > legacy support is just a good byproduct.
> >
> > Thanks
>
>
> I thought so too originally. Unfortunately I now think that no, legacy is=
 not
> going to be a byproduct of transport virtqueue for modern -
> it is different enough that it needs dedicated commands.

If you mean the transport virtqueue, I think some dedicated commands
for legacy are needed. Then it would be a transport that supports
transitional devices. It would be much better than having commands for
a partial transport like this patch did.

> Consider simplest case, multibyte fields. Legacy needs multibyte write,
> modern does not even need multibyte read.

I'm not sure I will get here, since we can't expose admin vq to
guests, it means we need some software mediation. So if we just
implement what PCI allows us, then everything would be fine (even if
some method is not used).

Thanks

>
> > >
> > > v0->v1:
> > > - addressed comments, suggesetions and ideas from Michael Tsirkin and=
 Jason Wang
> > > - far more simpler design than MMR access
> > > - removed complexities of MMR device ids
> > > - removed complexities of MMR registers and extended capabilities
> > > - dropped adding new extended capabilities because if if they are
> > >   added, a pci device still needs to have existing capabilities
> > >   in the legacy configuration space and hypervisor driver do not
> > >   need to access them
> > >
> > >
> > > Parav Pandit (2):
> > >   transport-pci: Introduce legacy registers access commands
> > >   transport-pci: Add legacy register access conformance section
> > >
> > >  admin.tex                     |   5 +-
> > >  conformance.tex               |   2 +
> > >  transport-pci-legacy-regs.tex | 133 ++++++++++++++++++++++++++++++++=
++
> > >  transport-pci.tex             |   2 +
> > >  4 files changed, 141 insertions(+), 1 deletion(-)
> > >  create mode 100644 transport-pci-legacy-regs.tex
> > >
> > > --
> > > 2.26.2
> > >
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

