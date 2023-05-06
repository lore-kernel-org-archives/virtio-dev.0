Return-Path: <virtio-dev-return-12605-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11368C77B7C
	for <virtio-dev@archiver.kernel.org>; Sat,  6 May 2023 02:25:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 48BDF2B028
	for <virtio-dev@archiver.kernel.org>; Sat,  6 May 2023 02:25:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3F9169866DD
	for <virtio-dev@archiver.kernel.org>; Sat,  6 May 2023 02:25:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 345539841A9; Sat,  6 May 2023 02:25:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 23DFF9866CF
	for <virtio-dev@lists.oasis-open.org>; Sat,  6 May 2023 02:25:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: FQQ2Ze3UPI23k1tYErE9iQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683339943; x=1685931943;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xxHkuBfHOe3YORjfza9JzkBfavuxqwNspWf4Tf6+jn4=;
        b=Uqx5H1YvF930qk3WRBrcFQ+0SlWoYdevVYVzVDWhbdZzCqtYeudBmf5f/IGGjKJ5HR
         Q93MSeNeMsa4bScpxzx3BNFqKhn8tKdH6IlxaCXWoLGBK6G0sSeUL2eIJWI2cRmMItZR
         JR3ormSYf1CkHrFvW2LPac7bBX6Eg3iBcgjTMoTY6LbSJHNOhYlNwMpX9BvQon8dgCOR
         xkEsxeuNxz+XGNYAot384uM1Yk+uiwddIhZSLxQFiTTscBJJbbH+hmZdJZ9SpkDFqYHR
         geVXFOzu/gIXhYVQMWXQbvl3RjUm/CtnkYqme8L2zDKaD9MNFfJot+kinGKfDgPPAcKX
         zzGQ==
X-Gm-Message-State: AC+VfDx8fFxNrpCqqz6RZu1HPWB0Sm+WOEhZKZ+nMTJNea7k0NP+GsDU
	V/XNgMwJov8F5N+UhtqCN/rTJKDiKjUfWkEIrI4mfH5nKJqHBV1EWtaLq1TBTXElQL9Wip8Ihq9
	6LDMTCVDlI/R5XpCLnO9zRPa6spAwZLTedfLlt1eyxZXl
X-Received: by 2002:a2e:928a:0:b0:2a6:2444:9892 with SMTP id d10-20020a2e928a000000b002a624449892mr912989ljh.25.1683339943537;
        Fri, 05 May 2023 19:25:43 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6MKmaKx3Fv4qoZ54qql7HiC9HiHy3wnA/W1Hd6KWnW1GtDbe12tlhsnH+oFbziiRhEL0mL51zPA78o4liaHVQ=
X-Received: by 2002:a2e:928a:0:b0:2a6:2444:9892 with SMTP id
 d10-20020a2e928a000000b002a624449892mr912985ljh.25.1683339943181; Fri, 05 May
 2023 19:25:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230503032659.530330-1-parav@nvidia.com> <20230503032659.530330-2-parav@nvidia.com>
 <dba64a65-0538-a060-47a1-24d30f42ca49@redhat.com> <PH0PR12MB548178D2363F81D26062592BDC729@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsbeZdXD4XPX_1deMDV-0bFHwj4U6GE4ytrYiKgOem2aQ@mail.gmail.com>
In-Reply-To: <CACGkMEsbeZdXD4XPX_1deMDV-0bFHwj4U6GE4ytrYiKgOem2aQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sat, 6 May 2023 10:25:31 +0800
Message-ID: <CACGkMEvU5fZgrMDDpqGe3VLHAa-e-0E=VWXpDqrEksaBAmp5PA@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "mst@redhat.com" <mst@redhat.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, 
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, 
	"Zhu, Lingshan" <lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH v1 1/2] transport-pci: Introduce legacy registers access commands

On Sat, May 6, 2023 at 10:24=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, May 5, 2023 at 8:49=E2=80=AFPM Parav Pandit <parav@nvidia.com> wr=
ote:
> >
> >
> >
> > > From: Jason Wang <jasowang@redhat.com>
> > > Sent: Thursday, May 4, 2023 11:27 PM
> > >
> > > So the "single stack" is kind of misleading, you need a dedicated vir=
tio
> > > mediation layer which has different code path than a simpler vfio-pci=
 which is
> > > completely duplicated with vDPA subsystem.
> > Huh. No. it is not duplicated.
> > Vfio-pci provides the framework for extension than doing simple vfio-pc=
i for extensions.
>
> I'm not sure how to define simple here, do you mean mdev?
>
> > I am not debating here vdpa vs non vdpa yet again.
> >
> > > And you lose all the advantages of
> > > vDPA in this way. The device should not be designed for a single type=
 of
> > > software stack , it need to leave the decision to the hypervisor/clou=
d vendors.
> > >
> > It is left to the hypervisor/cloud user to decide to use vdpa or vfio o=
r something else.
> >
> > >
> > > >     virtio device type (net/blk) and be future compatible with a
> > > >     single vfio stack using SR-IOV or other scalable device
> > > >     virtualization technology to map PCI devices to the guest VM.
> > > >     (as transitional or otherwise)
> > > >
> > > > Motivation/Background:
> > > > ----------------------
> > > > The existing virtio transitional PCI device is missing support for =
PCI
> > > > SR-IOV based devices. Currently it does not work beyond PCI PF, or =
as
> > > > software emulated device in reality. Currently it has below cited
> > > > system level limitations:
> > > >
> > > > [a] PCIe spec citation:
> > > > VFs do not support I/O Space and thus VF BARs shall not indicate I/=
O Space.
> > > >
> > > > [b] cpu arch citiation:
> > > > Intel 64 and IA-32 Architectures Software Developer=E2=80=99s Manua=
l:
> > > > The processor=E2=80=99s I/O address space is separate and distinct =
from the
> > > > physical-memory address space. The I/O address space consists of 64=
K
> > > > individually addressable 8-bit I/O ports, numbered 0 through FFFFH.
> > > >
> > > > [c] PCIe spec citation:
> > > > If a bridge implements an I/O address range,...I/O address range wi=
ll
> > > > be aligned to a 4 KB boundary.
> > > >
> > > > Above usecase requirements can be solved by PCI PF group owner
> > > > enabling the access to its group member PCI VFs legacy registers us=
ing
> > > > an admin virtqueue of the group owner PCI PF.
> > > >
> > > > Software usage example:
> > > > -----------------------
> > > > The most common way to use and map to the guest VM is by using vfio
> > > > driver framework in Linux kernel.
> > > >
> > > >                  +----------------------+
> > > >                  |pci_dev_id =3D 0x100X   |
> > > > +---------------|pci_rev_id =3D 0x0      |-----+
> > > > |vfio device    |BAR0 =3D I/O region     |     |
> > > > |               |Other attributes      |     |
> > > > |               +----------------------+     |
> > > > |                                            |
> > > > +   +--------------+     +-----------------+ |
> > > > |   |I/O BAR to AQ |     | Other vfio      | |
> > > > |   |rd/wr mapper  |     | functionalities | |
> > > > |   +--------------+     +-----------------+ |
> > > > |                                            |
> > > > +------+-------------------------+-----------+
> > > >         |                         |
> > >
> > >
> > > So the mapper here is actually the control path mediation layer which
> > > duplicates with vDPA.
> > >
> > Yet again no. It implements PCI level abstraction.
> > It is not touching the whole QEMU layer and not at all getting involved=
 in virtio device flow of understanding device reset, and device config spa=
ce, cvq, features bits and more.
>
> I think you miss the fact that QEMU can choose to not understand all
> you mentioned here with the help of the general vdpa device.
> Vhost-vDPA provides a much simpler device abstraction than vfio-pci.
> If a cloud vendor wants a tiny/thin hypervisor layer, it can be done
> through vDPA for sure.
>
> > All of these were discussed in v0, lets not repeat.
> >
> > >
> > > >    +----+------------+       +----+------------+
> > > >    | +-----+         |       | PCI VF device A |
> > > >    | | AQ  |-------------+---->+-------------+ |
> > > >    | +-----+         |   |   | | legacy regs | |
> > > >    | PCI PF device   |   |   | +-------------+ |
> > > >    +-----------------+   |   +-----------------+
> > > >                          |
> > > >                          |   +----+------------+
> > > >                          |   | PCI VF device N |
> > > >                          +---->+-------------+ |
> > > >                              | | legacy regs | |
> > > >                              | +-------------+ |
> > > >                              +-----------------+
> > > >
> > > > 2. Virtio pci driver to bind to the listed device id and
> > > >     use it as native device in the host.
> > >
> > >
> > > How this can be done now?
> > >
> > Currently a PCI VF binds to the virtio driver and without any vdpa laye=
ring, virtio net/blk etc devices are created on top of virtio PCI VF device=
.
> > Not sure I understood your question.
>
> I meant the current virtio-pci driver can use what you propose here.

Actually, I meant "can't".

Thanks

>
> >
> > > > +\begin{lstlisting}
> > > > +struct virtio_admin_cmd_lreg_wr_data {
> > > > +   u8 offset; /* Starting byte offset of the register(s) to write =
*/
> > > > +   u8 size; /* Number of bytes to write into the register. */
> > > > +   u8 register[];
> > > > +};
> > > > +\end{lstlisting}
> > >
> > >
> > > So this actually implements a transport, I wonder if it would be bett=
er
> > > (and simpler) to do it on top of the transport vq proposal:
> > >
> > > https://lists.oasis-open.org/archives/virtio-comment/202208/msg00003.=
html
> > >
> > I also wonder why TVQ cannot use AQ.
>
> It can for sure, but whether using a single virtqueue type for both
> administration and transport is still questionable.
>
> >
> > > Then it aligns with SIOV natively.
> > >
> > SIOV is not well defined spec, whenever it is defined, it can use AQ or=
 TVQ.
> >
> > We also discussed that mediation of hypervisor for control path in some=
 use case is not desired, hence I will leave that discussion to the future =
when SIOV arrives.
>
> We need to plan it ahead. We don't want to end up with redundant
> design. For example, this proposal is actually a partial transport
> implementation. Transport virtqueue can do much better in this case.
>
> Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

