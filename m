Return-Path: <virtio-dev-return-12604-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A723DC77B7D
	for <virtio-dev@archiver.kernel.org>; Sat,  6 May 2023 02:24:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C4FEE2B02C
	for <virtio-dev@archiver.kernel.org>; Sat,  6 May 2023 02:24:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A36149866D5
	for <virtio-dev@archiver.kernel.org>; Sat,  6 May 2023 02:24:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8D19D9841A9; Sat,  6 May 2023 02:24:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 75A5F9866CF
	for <virtio-dev@lists.oasis-open.org>; Sat,  6 May 2023 02:24:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: mTIQUs44PSqwHgnyDlHYVA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683339871; x=1685931871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L20I05a1ZD0uGuPIxXOeh8hC231/sFaWMDptFiwlPR4=;
        b=Pon8W4Hx0BDZtR3/7HpnsTz4aLW+rgIk2uuMxP7vYTvZv+copGRAAvKuvenR/zwNcB
         C/KvRqKeoon+2GiUwodjMTwIuQSQQ8rY+Skny7i5qriIQuBtUy3qeHVVkbt8NV94Oey7
         geLPLS8/a5NDXU7LKm4ZsKKS1SBNNTJDYDfiiuJ8Hjnej8v+Vx/pb3Y5USrdA6Rx4L6n
         opUuawa64bqopam6RRjTnc9nEeJQVBSTEGHaR/6XlzTvbNF21IcNtkyWjTzXcF2AqzIa
         L6uUPtdKWxUsgkug580unt+0z3HU8s06Wyk1fm9H9YhVKXsaEcYrXpBqCaek55VV3VgH
         6pnw==
X-Gm-Message-State: AC+VfDzNuP5s0vaRkJDUlny3ISaO1sZUtA/3xZAURRq20ZihqQMd5Atk
	4eAlsipCzHFGg0NC2ebbSwGzUlRblAn9cinmIFUgUzDskemSj4wrtLlGkD3QPv072JQGt5Z2ApD
	vkDMDJgVYJGD0Hv+0iuPVX1mLt8UTMWlwvHOjcXDyUMUp
X-Received: by 2002:ac2:4282:0:b0:4ef:e87e:df88 with SMTP id m2-20020ac24282000000b004efe87edf88mr793332lfh.64.1683339871705;
        Fri, 05 May 2023 19:24:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7plVaBMEcSgLRJIeUhkNE3Ruy5ynq4oH7stw9oNnA/kHKoDyZ4wUC2MMywug/PhOgCG1XP8EdeinxTtz48G3c=
X-Received: by 2002:ac2:4282:0:b0:4ef:e87e:df88 with SMTP id
 m2-20020ac24282000000b004efe87edf88mr793325lfh.64.1683339871360; Fri, 05 May
 2023 19:24:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230503032659.530330-1-parav@nvidia.com> <20230503032659.530330-2-parav@nvidia.com>
 <dba64a65-0538-a060-47a1-24d30f42ca49@redhat.com> <PH0PR12MB548178D2363F81D26062592BDC729@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB548178D2363F81D26062592BDC729@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sat, 6 May 2023 10:24:20 +0800
Message-ID: <CACGkMEsbeZdXD4XPX_1deMDV-0bFHwj4U6GE4ytrYiKgOem2aQ@mail.gmail.com>
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

On Fri, May 5, 2023 at 8:49=E2=80=AFPM Parav Pandit <parav@nvidia.com> wrot=
e:
>
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Thursday, May 4, 2023 11:27 PM
> >
> > So the "single stack" is kind of misleading, you need a dedicated virti=
o
> > mediation layer which has different code path than a simpler vfio-pci w=
hich is
> > completely duplicated with vDPA subsystem.
> Huh. No. it is not duplicated.
> Vfio-pci provides the framework for extension than doing simple vfio-pci =
for extensions.

I'm not sure how to define simple here, do you mean mdev?

> I am not debating here vdpa vs non vdpa yet again.
>
> > And you lose all the advantages of
> > vDPA in this way. The device should not be designed for a single type o=
f
> > software stack , it need to leave the decision to the hypervisor/cloud =
vendors.
> >
> It is left to the hypervisor/cloud user to decide to use vdpa or vfio or =
something else.
>
> >
> > >     virtio device type (net/blk) and be future compatible with a
> > >     single vfio stack using SR-IOV or other scalable device
> > >     virtualization technology to map PCI devices to the guest VM.
> > >     (as transitional or otherwise)
> > >
> > > Motivation/Background:
> > > ----------------------
> > > The existing virtio transitional PCI device is missing support for PC=
I
> > > SR-IOV based devices. Currently it does not work beyond PCI PF, or as
> > > software emulated device in reality. Currently it has below cited
> > > system level limitations:
> > >
> > > [a] PCIe spec citation:
> > > VFs do not support I/O Space and thus VF BARs shall not indicate I/O =
Space.
> > >
> > > [b] cpu arch citiation:
> > > Intel 64 and IA-32 Architectures Software Developer=E2=80=99s Manual:
> > > The processor=E2=80=99s I/O address space is separate and distinct fr=
om the
> > > physical-memory address space. The I/O address space consists of 64K
> > > individually addressable 8-bit I/O ports, numbered 0 through FFFFH.
> > >
> > > [c] PCIe spec citation:
> > > If a bridge implements an I/O address range,...I/O address range will
> > > be aligned to a 4 KB boundary.
> > >
> > > Above usecase requirements can be solved by PCI PF group owner
> > > enabling the access to its group member PCI VFs legacy registers usin=
g
> > > an admin virtqueue of the group owner PCI PF.
> > >
> > > Software usage example:
> > > -----------------------
> > > The most common way to use and map to the guest VM is by using vfio
> > > driver framework in Linux kernel.
> > >
> > >                  +----------------------+
> > >                  |pci_dev_id =3D 0x100X   |
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
> > >         |                         |
> >
> >
> > So the mapper here is actually the control path mediation layer which
> > duplicates with vDPA.
> >
> Yet again no. It implements PCI level abstraction.
> It is not touching the whole QEMU layer and not at all getting involved i=
n virtio device flow of understanding device reset, and device config space=
, cvq, features bits and more.

I think you miss the fact that QEMU can choose to not understand all
you mentioned here with the help of the general vdpa device.
Vhost-vDPA provides a much simpler device abstraction than vfio-pci.
If a cloud vendor wants a tiny/thin hypervisor layer, it can be done
through vDPA for sure.

> All of these were discussed in v0, lets not repeat.
>
> >
> > >    +----+------------+       +----+------------+
> > >    | +-----+         |       | PCI VF device A |
> > >    | | AQ  |-------------+---->+-------------+ |
> > >    | +-----+         |   |   | | legacy regs | |
> > >    | PCI PF device   |   |   | +-------------+ |
> > >    +-----------------+   |   +-----------------+
> > >                          |
> > >                          |   +----+------------+
> > >                          |   | PCI VF device N |
> > >                          +---->+-------------+ |
> > >                              | | legacy regs | |
> > >                              | +-------------+ |
> > >                              +-----------------+
> > >
> > > 2. Virtio pci driver to bind to the listed device id and
> > >     use it as native device in the host.
> >
> >
> > How this can be done now?
> >
> Currently a PCI VF binds to the virtio driver and without any vdpa layeri=
ng, virtio net/blk etc devices are created on top of virtio PCI VF device.
> Not sure I understood your question.

I meant the current virtio-pci driver can use what you propose here.

>
> > > +\begin{lstlisting}
> > > +struct virtio_admin_cmd_lreg_wr_data {
> > > +   u8 offset; /* Starting byte offset of the register(s) to write */
> > > +   u8 size; /* Number of bytes to write into the register. */
> > > +   u8 register[];
> > > +};
> > > +\end{lstlisting}
> >
> >
> > So this actually implements a transport, I wonder if it would be better
> > (and simpler) to do it on top of the transport vq proposal:
> >
> > https://lists.oasis-open.org/archives/virtio-comment/202208/msg00003.ht=
ml
> >
> I also wonder why TVQ cannot use AQ.

It can for sure, but whether using a single virtqueue type for both
administration and transport is still questionable.

>
> > Then it aligns with SIOV natively.
> >
> SIOV is not well defined spec, whenever it is defined, it can use AQ or T=
VQ.
>
> We also discussed that mediation of hypervisor for control path in some u=
se case is not desired, hence I will leave that discussion to the future wh=
en SIOV arrives.

We need to plan it ahead. We don't want to end up with redundant
design. For example, this proposal is actually a partial transport
implementation. Transport virtqueue can do much better in this case.

Thanks


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

