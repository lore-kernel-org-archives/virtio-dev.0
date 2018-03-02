Return-Path: virtio-dev-return-3364-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 343B05818EF8
	for <virtio-dev@lists.oasis-open.org>; Thu,  1 Mar 2018 22:55:59 -0800 (PST)
From: "Tian, Kevin" <kevin.tian@intel.com>
Date: Fri, 2 Mar 2018 06:55:44 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D1910253DC@SHSMSX101.ccr.corp.intel.com>
References: <20180227190520.3273.79728.stgit@localhost.localdomain>
        <20180227144015.228d4f5c@w520.home>
        <CAKgT0Ucq8vF9Kxx31QMG=OUwRr61vurHCPw5NCjxPhR_2JM5MQ@mail.gmail.com>
        <CAKgT0Ufq7EHCErECEbK2urHczZSpOoJKR2a5GWn5BxhZshx0vA@mail.gmail.com>
        <20180228155949.00fde8ae@w520.home>
        <CAKgT0UeVZUB7h6g=Eqppt-6VP=X4=Ko3=kB_rh_1JanFJXZF9g@mail.gmail.com>
 <20180301132224.1ca06949@w520.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D1910253BF@SHSMSX101.ccr.corp.intel.com>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D1910253BF@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH] pci-iov: Add support for unmanaged SR-IOV
To: 'Alex Williamson' <alex.williamson@redhat.com>, Alexander Duyck <alexander.duyck@gmail.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "Duyck, Alexander H" <alexander.h.duyck@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Netdev <netdev@vger.kernel.org>, "Daly, Dan" <dan.daly@intel.com>, LKML <linux-kernel@vger.kernel.org>, Maximilian Heyne <mheyne@amazon.de>, "Wang, Liang-min" <liang-min.wang@intel.com>, "Rustad,
 Mark D" <mark.d.rustad@intel.com>, David Woodhouse <dwmw2@infradead.org>, "dwmw@amazon.co.uk" <dwmw@amazon.co.uk>, Ilya Lesokhin <ilyal@mellanox.com>, Don Dutile <ddutile@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> From: Tian, Kevin
> Sent: Friday, March 2, 2018 2:54 PM
>=20
> > From: Alex Williamson
> > Sent: Friday, March 2, 2018 4:22 AM
> > >
> > > I am pretty sure that you are describing is true of some, but not for
> > > all. I think the Amazon solutions and the virtio solution are doing
> > > hard partitioning of the part. I will leave it to those guys to speak
> > > for themselves since I don't know anything about the hardware design
> > > of those parts.
> >
> > I think we'd need device specific knowledge and enablement to be able
> > to take advantage of any hardware partitioning, otherwise we need to
> > assume the pf is privileged, as implemented in other sriov devices.
> >
> > I'm also trying to imagine whether there's a solution via the new
> > vfio/mdev interface, where the mdev vendor driver would bind to the pf
> > and effectively present itself as the mdev device.  The vendor driver
> > could provide sriov capabilities and bear the burden of ensuring that
> > the pf is used cooperatively.  The only existing mdev vendor drivers ar=
e
> > vGPUs and rely on on-device DMA translation and isolation, such as
> > through GTTs, but there have been some thoughts on providing IOMMU
> > based
> > isolation of mdev/sriov mixed devices (assuming DMA is even required
> > for userspace management of the pf in this use case).  [Cc Kirti]
> > Thanks,
> >
>=20
> Hope not distracting this thread, but above sounds like an interesting
> idea. Actually we ever brainstormed similar thought for another
> potential usage - supporting VF live migration. We are already working
> on an generic extension to allow state save/restore of mdev instance.
> If vendor driver could further wrap pf as a mdev instance, it could

I meant "wrap vf as a mdev instance" here.

> leverage the same framework for a clean state migration on VF. based
> on mmap callback the vendor driver can easily switch back-and-forth
> between pass through and trap/emulation of the VF resources. Of
> course doing so alone doesn't address all the demands of VF live
> migration (e.g. dirty page tracking still requires other techniques),
> but it does pave a way toward a general framework to support VF
> live migration.
>=20
> If above is feasible, finally we could use one mdev framework to
> manage both mdev and pf/vf assignment, while providing added
> values which are difficult to achieve today. :-)
>=20
> Thanks
> Kevin

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

