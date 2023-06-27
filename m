Return-Path: <virtio-dev-return-13104-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB00EB64D9
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 15:03:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BDD8741F27
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 15:03:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B6876986456
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 15:03:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AB25F986412; Tue, 27 Jun 2023 15:03:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 913C098635C;
	Tue, 27 Jun 2023 15:03:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QtMEnYsM7TK7o2o1oETzukIpNnrbCX0OEp0JQ5Yv+kUk0fPxvsuGvLoIhcb3P3qsQoBgAHUECongQU5oOZIuWG91+tR0x10xCcaD9Z1hmvwPnQyDo+DmYZZrjKSHrACEXsR0Qu8NtoGjasKH2mLRuXJQpjHmY1jvxFXCvetuPZhwn0af+7FsUgirosCi1xfFXd6kTh4gFqdJn28aUhOlFsvyBaq5+tfzT4Pky9u6K+06Ev17P83aNJ53EXGScwGON5qLWZCAGQxvDLIAa+gNvOQE41+/QxDEEuyFRQigTxzrWNC4H+ibgmeYdl/cYtTekWTo6CdTQKXMoKqOm65ofA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JIErldAB6kJynXMFu/EhlW4P1iRGfF+zmQ/cFLNc6Fw=;
 b=IgrBZiyr9A92HI3313le6eddYO/4DuKQSC7Mbeovagz8VlvwmYRzPq/c8rsbicnqKazo4Z+jp+42uCDfHkXm+aXhrHHs6TSNValkG1BqcFNppsyKvnKnAud9+JW1wSMs9CrpNAuTrhVTSiuKrxWdA7vOYHTr9ASxwaKRowtpCDPBIrPxAdKJpCrxlyfmi3p9JjYHM2Zi0hkFYYJqsqqBVBNxwswP5E3QXFBm2T89K4Xcuj72ShJUypFoO8NM9gYqPuanMlSYZebrEO3BiC/x11yvv+4GAN4byDnWLCUrTBlP8IFy0OF5oJ7XywlBhY+JGOP5+Yp5FakNhhwxfXAWRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"mst@redhat.com" <mst@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>,
	"Zhu, Lingshan" <lingshan.zhu@intel.com>
Thread-Topic: [virtio-comment] [RFC PATCH] admin-queue: bind the group member
 to the device
Thread-Index: AQHZp/aO4VG7c5VX5U2HGCV+HZ1m26+eUUOAgABm3oA=
Date: Tue, 27 Jun 2023 15:03:21 +0000
Message-ID:
 <PH0PR12MB54818D4D5DF06AA506D0947ADC27A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230626062210.49020-1-xuanzhuo@linux.alibaba.com>
 <1687854185.3344731-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1687854185.3344731-3-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB6397:EE_
x-ms-office365-filtering-correlation-id: 89cae10b-8fbe-402d-63e1-08db771fa61e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xpltz+ufDVdnhMCZeKRqTIxFTTw9hLINYzpD57coBUp1lt8G6nnFpedmbckXsPJIxRlzEQTLjkFMuX/YxQpwGSuz2bAtviw1xtVZDzjZNqyDqoafDxQHghRFlvlGK/CQ3vJHcYypdiWYexzvl4ct5cDqPYIB1Ao7csR7hSUXDE3GCXR9ROXi8DArSVa5XBfjdV4n68ma1lJQPtzwJ5jUU8zsG83n4kJGtVYTpwbBsmChc2tWkE+hQTi0V2A56AtcIxyk/B5tbfZBFkXs9JHt8Em7os4hcqiqVYzX/ekTz91CS6HnYh0DkqhXzdnppvyaDipqRRoKaDRNsNv/EbNuHXSVuCsZN2dIiAXmBIDx691JUql+BlAPrjQaT7QRwiABNZzzxBc4Y/8HA3wxf79qs0RjtR5StgIU+nN5ceh5lNGkkzu2GtgMTbM58idoX5NWUe6eMij+3ogtI+42pbqcpw6JR3nqcm+IU/bWIRi/qkTj0TE534C1vi2NRTYyUJW1YDkyhiTckDnysgfnA+FDewndGla5H5sgWIKRaq7RNqiF/uvg+GqmlyImCqIO9ifCXeqdp6zcqbaWo76LPUQi1mrrX9kSEmRfz7JwKfSAJzw1HWZurvha1bZibu78Nphh6TlmIOWjYq3RRcHysndIIvFf3/Myr2+nPqDvjL6O1f26M4mNkfEdtiqQhaOgIaLe
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199021)(9686003)(966005)(54906003)(71200400001)(83380400001)(7696005)(478600001)(6506007)(186003)(26005)(2906002)(6916009)(5660300002)(30864003)(52536014)(76116006)(122000001)(55016003)(316002)(38100700002)(38070700005)(8936002)(8676002)(86362001)(66946007)(4326008)(64756008)(66556008)(66446008)(33656002)(41300700001)(66476007)(66899021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?c+55i2lP1OBs+G7whV96LWBpbyf8YVPtMiD8RnTQ9ElbQtW3jAGfzudy0Agh?=
 =?us-ascii?Q?yoAM2zms+MKlV9hVu98puqcFiE8dvMfoVeOyT4fzeZcKQ/OLKiMUNLx+EY6d?=
 =?us-ascii?Q?rAPuNYsj28vGd5YN+3gM7n/JRgaBfgUkEk9JtwtlIXL7eyhNvUtJ0kNb83R2?=
 =?us-ascii?Q?HLUfuz7WNzCKbY1AQySNf8Qc6Bvf6pgf3gpPAD47mTFH3Vebf0nfGJ9Rh/u7?=
 =?us-ascii?Q?Zfjew7gjWsAEgCYhgQWzoECNwdCi8xYCGoyyvGEvcy/sOB24c7CDnD8rchcF?=
 =?us-ascii?Q?1JNJ+1zfe8OONd1KKdWmUGE5VdGF/NWiANMhmwnMFo56m7cer2F17rb7RzQc?=
 =?us-ascii?Q?o2sZ357NsxzKkP2ZEg/mKkJVV22pT/2xsk/7as+Q3zrmLOD5dTzRhIh7KiuR?=
 =?us-ascii?Q?itKg27rUpTBOtCsWSm+fwGLzXHsLvVUNIJPQCywl1gA79J2+rIjBVQaSEBva?=
 =?us-ascii?Q?kHD7+cczeonbs3sF9pynZwPhymjIExXjEladJz+eFoc+a4KM3s69KxsaMFD1?=
 =?us-ascii?Q?uxbckp1C+os6XFS6elgtpW91WjxNUD6y3+KgBVYUDciIpdY/KQP+nVDfRRb5?=
 =?us-ascii?Q?i6Eq3UNRr/KSxK5o9gtC7a0f3DrBfRjHpqh/qfZ8NBK2LuGW9thHT8POM2R9?=
 =?us-ascii?Q?Ge+7+OC0NLp4IXgYEQGV/jHxeoY+jbEfHpqIcManRy7iFeDz5aH85J4AUOHn?=
 =?us-ascii?Q?iQUJBa4fzSSGyT6bF4SuSzk42783pdWITlk6vb88OdbXgJ2i4ybseXV7K6wB?=
 =?us-ascii?Q?EE1uR6DF2eXuz/ndWkJhpO4vZrD9pOp/WkbzVpgOfLn83mczFKGEoQ4/+p/V?=
 =?us-ascii?Q?Q/E2d68KlyH+QgmQZfPREho/YPWt03nq/9W5gE9wOfgvZlPkMllpazPlk4tt?=
 =?us-ascii?Q?1iNwr4U/8IaPBzWrwCXxxs8YTpfFbf72YW3HLjLXz/DqSYx9YjocQzRJn/4f?=
 =?us-ascii?Q?IVWIck4NHt/4Il42Qo9s+JxcWF6aQQCJR4IO3wTE2rjALelgMNjZyOlIQdvl?=
 =?us-ascii?Q?zBP/Nh6Vh0SynR3QXbi9jGJbdwGlmAbuKyQn75AC3ljky7M5WhvMmEWd5UAm?=
 =?us-ascii?Q?xtyUapwzV66/WZLjmkeIB+NtcjAzlci1RPIqsQX4qXUHOyCsLq2H1Q4l2I5x?=
 =?us-ascii?Q?vGPnGYzSR5lJ58khQRL5QXf6tW9qI2Ya/gAfPLeYdzzRMydo8sZDHdGNjOUa?=
 =?us-ascii?Q?n5DpY26EPNysV5Ky0LSggo3XLGumFSTYfAtuNVEFG+gtOtUYoolAO+5ZX1LY?=
 =?us-ascii?Q?7u6Cmv/z2lu3bDg/xqjobSh6u9eIrxZgazAGBbs2cMnchRF8EwqOVLOBptVK?=
 =?us-ascii?Q?7c7lbyRnpoJqMoC5ESMtYCmbnvIR6Kk+Zb7KMK+r2QVBULDEfwNEtGzi7x0j?=
 =?us-ascii?Q?bt7flosZ8G/XfC7HgCLOiN9OdrMLcRymsY7MuRXR0IQEe8Wb4YVle3bzGgzN?=
 =?us-ascii?Q?sgy939Q69pnwSKIrEWB8t42rtfUeGGdwcLGFp4tkzmSbnWwEJREFh/xB3r5r?=
 =?us-ascii?Q?48cP6Q9O7EyvxWypJQGX/Dhztrvf3DLsPyUxfit7/Tw5YuRIvjDDzJV3rqeM?=
 =?us-ascii?Q?3Gl74RxV44V13PbKhrA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89cae10b-8fbe-402d-63e1-08db771fa61e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 15:03:21.7252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6SnzZ4IOTl4Aqk35lMtKBuPsMS1kZVwmCGR2Mz/A6ahoL3cHlzmKPQz/PdM++qG8Qpd4ULoBJhwVPqTP5hYtYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6397
Subject: [virtio-dev] RE: [virtio-comment] [RFC PATCH] admin-queue: bind the group member
 to the device


> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Tuesday, June 27, 2023 4:23 AM
>=20
> Thanks Parav for pointing it out. We may have some gaps on the case.
>=20
> Let me introduce our case, which I think it is simple and should be easy =
to
> understand.
>=20
> First, the user (customer) purchased a bare metal machine.
>=20
> ## Bare metal machine
>=20
> Let me briefly explain the characteristics of a bare metal machine. It is=
 not a
> virtual machine, it is a physical machine, and the difference between it =
and a
> general physical machine is that its PCI is connected to a device similar=
 to a DPU.
> This DPU provides devices such as virtio-blk/net to the host through PCI.
> These devices are managed by the vendor, and must be created and purchase=
d
> on the vendor's management platform.
>=20
Each of this device can have a unique serial number or id.
Or a parent PF can have the unique serial number.

> ## DPU
>=20
> There is a software implementation in the DPU, which will respond to PCI
> operations. But as mentioned above, resources such as network cards must =
be
> purchased and created before they can exist. So users can create VF, whic=
h is
> just a pci-level operation, but there may not be a corresponding backend.
>=20
> ## Management Platform
>=20
> The creation and configuration of devices is realized on the management
> platform.
>=20
> After the user completed the purchase on the management platform (this is=
 an
> independent platform provided by the vendor and has nothing to do with
> virtio), then there will be a corresponding device implementation in the =
DPU.
> This includes some user configurations, available bandwidth resources and
> other information.
>=20
> ## Usage
>=20
> Since the user is directly on the HOST, the user can create VMs, passthro=
ugh PF
> or VF into the VM. Or users can create a large number of dockers, all of =
which
> use a separate virtio-net device for performance.
>=20
> The reason why users use vf is that we need to use a large number of virt=
io-net
> devices. This number reaches 1k+.
>=20
> Based on this scenario, we need to bind vf to the backend device. Because=
, we
> cannot automatically complete the creation of the virtio-net backend devi=
ce
> when the user creates a vf.
>=20
Yes, this is common practice for us as well.
A backend device needs to know the unique serial number/id of the virtio de=
vice.

> ## Migration
>=20
> In addition, let's consider another scenario of migration. If a vm is mig=
rated
> from another host, of course its corresponding virtio device is also migr=
ated to
> the DPU. At this time, our newly created vf can only be used by the vm af=
ter it is
> bound to the migrated device. We do not want this vf to be a brand new de=
vice.
>
Same for us too.
=20
> ## Abstraction
>=20
> So, this is how I understand the process of creating vf:
>=20
> 1. Create a PCI VF, at this time there may be no backend virtio device, o=
r there
>     is only a default backend. It does not fully meet our expectations.
> 2. Create device or migrate device
> 3. Bind the backend virtio device to the vf
>=20
> In most scenarios, the first step may be enough. We can make some fine-tu=
ning
> on this default device, such as modifying its mac. In the future, we can =
use
> admin queue to modify its msix vector and other configurations.
>=20
Yep.

> But we should allow, we bind a backend virtio device to a certain vf. Thi=
s is
> useful for live migration and virtio devices with special configurations.
>
This is the job of non virtio layer to do the work in backend.
=20
> The design of virtio itself is two layers, and virtio should allow switch=
ing the
> transport layer by nature. This is our advantage.
>=20
> ## About the identity
>=20
> In this patch, I used a vendor's id. The purpose of this is that I hope t=
o be
> compatible with all devices. In the network scenario, it is actually poss=
ible to
> use a mac.
>
Mac is not good as during migration there is transient where two vfs will h=
ave same mac.

So we should use the unique device identifier.

There are few options that I am aware of.

1. Have unique serial number for the PCI PF in the PCI VPD data and VF numb=
er to uniquely identify the VF of a PF.
Management system backend will know and able to identify this.
Pros:
This does not need any virtio spec involvement. Can be done today on existi=
ng virtio device.
Cons:
There is no single device handle to work with backend, but not a big proble=
m.
If the REST APIs etc of the VPC are crafted properly.

2. Expose unique serial number per each VF using same above PCI VPD data.
This option #2 is good in theory, not efficient to implement as PCI level.
Pros:
a. Unique per device.
b. accessible without binding to the actual driver (vfio vs virtio for diff=
erent use case)

3. Expose unique serial number/identifier at virtio device level over a vir=
tqueue interface
Pros:
a. achieves the desired scale
b. unique per device
Cons:
a. One needs to bind to the driver to discover the unique device identifier=
 and involve the device reset flow.
Not an optimal solution when dealing with container.

In practice, we found #1 solves most issues.

=20
> Perhaps, introduce a standard id for each device/driver, I think this may=
 be more
> in line with the habit of virtio spec.
>=20

One way this is solved today for non virtio already is:

when a VF is created a PCI VF device should have the VPD data to contain a =
unique ID.

> Thanks.
>=20
> On Mon, 26 Jun 2023 14:22:10 +0800, Xuan Zhuo
> <xuanzhuo@linux.alibaba.com> wrote:
> > The VFs of the SR-IOV are created by the user inside the guest OS, so
> > the virtio devices don't know about these VFs. Because each VF may be
> > assigned a different role by the user, the virtio device can not choose=
 one VF
> to bind random.
> > So only the user knows how to bind the virtio devices to the VFs.
> > On the other hand, generally the virtio devices are not created by the
> > user inside the guest OS. This requires some management platform to
> participate.
> >
> > So the usage of this command:
> > 1. The user purchases a virtio network card on the management platform,
> >    and sets the ip, queue number, etc. The user obtains the identity of
> >    the network card.
> > 2. The user creates a VF with echo 8 > sriov_numvfs 3. The user binds
> > the net crad to a VF with identity through the command
> >    of the patch
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  admin.tex | 41 ++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 40 insertions(+), 1 deletion(-)
> >
> > diff --git a/admin.tex b/admin.tex
> > index 2efd4d7..64d0667 100644
> > --- a/admin.tex
> > +++ b/admin.tex
> > @@ -115,7 +115,8 @@ \subsection{Group administration
> > commands}\label{sec:Basic Facilities of a Virti  \hline \hline
> >  0x0000 & VIRTIO_ADMIN_CMD_LIST_QUERY & Provides to driver list of
> commands supported for this group type    \\
> >  0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of
> commands used for this group type \\
> > -0x0002 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}  =
  \\
> > +0x0002 & VIRTIO_ADMIN_CMD_BIND_DEVICE & Bind the device to one
> group member \\
> > +0x0003 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}  =
  \\
> >  \hline
> >  0x8000 - 0xFFFF & - & Reserved for future commands (possibly using a
> different structure)    \\
> >  \hline
> > @@ -429,6 +430,44 @@ \subsection{Group administration
> > commands}\label{sec:Basic Facilities of a Virti  \field{VF Enable}
> > refer to registers within the SR-IOV Extended  Capability as specified =
by
> \hyperref[intro:PCIe]{[PCIe]}.
> >
> > +\subsubsection{Bind the device for member}
> > +
> > +The VFs of the SR-IOV are created by the user inside the guest OS, so
> > +the virtio devices don't know about these VFs. Because each VF may be
> > +assigned a different role by the user, the virtio device can not choos=
e one VF
> to bind random.
> > +So only the user knows how to bind the virtio devices to the VFs.
> > +On the other hand, generally the virtio devices are not created by
> > +the user inside the guest OS. This requires some management platform t=
o
> participate.
> > +
> > +So we introduce a new admin queue command to bind the VFs and the
> > +virtio devices.
> > +
> > +\begin{lstlisting}
> > +struct virtio_admin_cmd_bind {
> > +    u64 identity;
> > +};
> > +\end{lstlisting}
> > +
> > +The user got the \field{identity} from the management platform, that
> > +is not included by this spec.
> > +
> > +\drivernormative{\paragraph}{Group administration commands}{Basic
> > +Facilities of a Virtio Device / Device groups / Group administration
> > +commands / Bind the device for member}
> > +
> > +VIRTIO_ADMIN_CMD_BIND_DEVICE requires that the
> \field{group_member_id} MUST be set.
> > +
> > +The \field{identity} is passed by the user. It is the identity of the
> > +virtio device.
> > +
> > +\devicenormative{\paragraph}{Group administration commands}{Basic
> > +Facilities of a Virtio Device / Device groups / Group administration
> > +commands / Bind the device for member}
> > +
> > +Every device MUST have one unique \field{identity} in the host.
> > +
> > +If the PF device can not find the device by the \field{identity}, the
> > +\field{status} MUST be set to VIRTIO_ADMIN_STATUS_EINVAL.
> > +
> > +If the device is found by the \field{identity}, the device MUST work
> > +as the device of this group member specified by the
> \field{group_member_id}.
> > +
> >  \section{Administration Virtqueues}\label{sec:Basic Facilities of a
> > Virtio Device / Administration Virtqueues}
> >
> >  An administration virtqueue of an owner device is used to submit
> > --
> > 2.32.0.3.g01195cf9f
> >
> >
> > This publicly archived list offers a means to provide input to the
> > OASIS Virtual I/O Device (VIRTIO) TC.
> >
> > In order to verify user consent to the Feedback License terms and to
> > minimize spam in the list archive, subscription is required before
> > posting.
> >
> > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > List help: virtio-comment-help@lists.oasis-open.org
> > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > Feedback License:
> > https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > List Guidelines:
> > https://www.oasis-open.org/policies-guidelines/mailing-lists
> > Committee: https://www.oasis-open.org/committees/virtio/
> > Join OASIS: https://www.oasis-open.org/join/
> >

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

