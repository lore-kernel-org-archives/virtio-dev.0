Return-Path: <virtio-dev-return-11279-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3EDBC64EC7
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 21:38:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 08FDA2CAD6
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 21:38:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F1C74986790
	for <virtio-dev@archiver.kernel.org>; Sat, 25 Feb 2023 21:38:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E600298413F; Sat, 25 Feb 2023 21:38:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CAD909866A9;
	Sat, 25 Feb 2023 21:38:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diadPIdOl1UjC33JDvmQm4fx+YJZUDoB9e+h565Fs0Snp61Bf45HqYZK26htG2udjJaLYc7bhAmGz2z2Uo25zFzwPq9SG2OyJw7UjhNA0WtRiXS4xEgQ4W3clLLE7DZgOGBYZudp1HVPCDdsO0WeLiBAZ2E7bKt30xVVFULmTi3gJEb/hWemVBKXtIvyzUxKJ/kgC8wVShWskzCLU3mZ3bhXh7gJAMdFwtVJXdHlyUsLjf+/PbzETfLlKNOpI+nueBE/LHwoB68zDkKRGIOg+qcac/oEWieQsfFqp95v4V+gJfMelC89pI9DHi6ANPYXYHHU1oUrzXMPRqFdWBkrTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gka5fCWCBtWd5ca6dzRkYAvRoltKXq6EnKKLrSpf0pU=;
 b=Zf7Ncgdep1oJlA4egaoSgHa457NSknSWLR3zfTIDA5W47met7GJp8+jp/IcvI+NVPg/RQm7T6xrG/+JlCAUXwngQsXjqp0T75JF4ju9zc2AGqyN9wuC2ni7D0R11wIHnKJgTo2j1WECnohP5YVUP/fFjH+nPl7bpUEqE3ZnxccQya0PF9jh3ddoybXuOXF9FJxeeczNi97SzUgKIo/CK55ZBYo8BLDYjErxM7x4ix7rS/7kNvn14wj3uGOEfUV4DgNkvXnF5BrS8lsDsvJWIpOXc6GMcdSs+oudfLvjpFTt/VcvQ9KdzD/LQEPqTegyjEiqs9joyECMM+b9lRy60cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH 2/2] transport-pci: Move transitional device id to legacy
 section
Thread-Index: AQHZSKWLZtovU46h0Eyc/FiMVdpv0a7f61+AgABDQKA=
Date: Sat, 25 Feb 2023 21:38:16 +0000
Message-ID: <PH0PR12MB5481088CBC9B4C99D2527A92DCA99@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230224231232.340814-1-parav@nvidia.com>
 <20230224231232.340814-3-parav@nvidia.com>
 <20230225121237-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230225121237-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH8PR12MB6842:EE_
x-ms-office365-filtering-correlation-id: b6b2b032-3f56-49d8-6a80-08db17789abe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 cWG3f4b07VwCj9eYxorI3OxoBeaxEkP8wWx7X4W9Q0dkmhvXOXuJI+vKfo7ZudO4dGZz4Y9Q0Ktr9ixli+6coZv/HWCJyoWVzDflyHzLTQiIxxLOuquNNKtK6Iqk9B88/HRfhiFjM60Mvj8pMJ5xehnT3oxILhSou/Udp6sw3GChp/ydxiZV9L1CeR/HKhukQI8niobt5m9FTa2VMsqiuxQmzJtfbsvnrdBl8xKMNVjfbNDWoEchAJTxnZ9DKiGVSoFzBiIZxvEXOGel6yicG90gQDkwOUqwmyjSxedOQDL0xD9QEfovm9PBkZdDY6Fx1OrTngaiNb9faJZoeCAvs3hGdsq6Ggs0Lci9mzTXF5UqESJySnrdjIBxklzPLiIvVhRMiHpWw/W53mKwu8uktwn09KoPmCH66FrkYNe/PolnCLM/GZjMScXmrjgf8pcbhqnRX5CvajMHDZzUsYFowMYfJqgp1bXOF/zkiFfpFCXiC4pP9Sd8ovsHdd/HnfWaLjEsiUz329o+tktHE2MpfK9rHOQfGh7YJXw4RBaF1+IxQ8lGci8/uql6TSqjxnnLs3bmdtJ/ITzhmESIyrcKtLd2+RF8KeNNUc8XrwiE6r5Pbh7IYZZGp+x2DscNGj64j7KRRRGSiktrhI8sGAADrdeZasNrfwv0eVHC+RMWJXI7DXUSzCDkCc08HzkE1OAHkv+TgFVh61VTDBtQlXP3cEf2eho7e/KiHJiaDWYOmEWlg34N3SW7pR40S8xTjeAK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(346002)(136003)(396003)(366004)(451199018)(8936002)(5660300002)(52536014)(71200400001)(2906002)(41300700001)(66946007)(76116006)(66476007)(66446008)(64756008)(66556008)(4326008)(6916009)(8676002)(54906003)(478600001)(316002)(966005)(7696005)(107886003)(26005)(6506007)(9686003)(186003)(122000001)(86362001)(33656002)(38070700005)(83380400001)(38100700002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?w0Va1KgN+XS9NhfZ1F3SH4G7xOQEz2FJCWy0m115WGGzK1xUnGGg9tYsJOqP?=
 =?us-ascii?Q?uCEUEK3YA8vNGmTrrPDQgLTmDE4yzXFqg4iW/+2ajZIMrRvBjobM2KWlnB1t?=
 =?us-ascii?Q?nyz4C7ASRVDUBi5QZvpg/7G1gSVUjZcNenpLfs0masfhAnaI01G+px01zMB9?=
 =?us-ascii?Q?VmlUDKd3QmyuAqpX7gS+8K8Y48swFKr0UO3QauMGcXJZRMmeZJlr+0XerS3z?=
 =?us-ascii?Q?4C3bxxqERIitwcTCrQgr4pA0G9eyplUANCwiy16F2EDBGadUWmJwWlORFr/u?=
 =?us-ascii?Q?8H2HQkyVr3zSAf5SKOSrwg5dQTUARf6YtFdX7lIrgkMiY4bYpUUUE9jO+l8R?=
 =?us-ascii?Q?3CRW6azpz/ht+2te5MnH4GiSAjrETjGrEm8KIEPClxOjchV2UzkQRLPM33qc?=
 =?us-ascii?Q?4djCC/rewOoTeYEm/gHT55zHu2D4y9Bk3g2IUj75JAJDEKEzJro05t/h1sZl?=
 =?us-ascii?Q?pDS1wAa2SSDukTIvgcWrKOQl7YlTqAsFT46AlZiqAn6Htns93dLY0AkFYC5Y?=
 =?us-ascii?Q?o7bpEyFtRgcqAG1xz0iljDaYPDCteuvCCnYGCiZll+rviXEgb8ooR9LctDPQ?=
 =?us-ascii?Q?BTGHUP1QvH+igYSBftj9GIEvmGjHmPSiML8EyqWmWU2tYFI86J0EDqiz1tid?=
 =?us-ascii?Q?cd/i5jSB6zuK2fbiY7LLIki3lsfzM1D+bUUUFUm7YF02dv8V9nJyON5ehrEL?=
 =?us-ascii?Q?8Um6j0e8muFUdzhksCELIRsDkgjGZXednqTAVL6RQiElrv7MDIZ5o1oo740Q?=
 =?us-ascii?Q?bz2OdqZbcgd4/+HC3lO0mA+JMB0/cZXHqLtFTujLsQPDTkAuKDbWJOuCEFBo?=
 =?us-ascii?Q?R3hNZ6et309j2Ahn7sQ869lqOjfj6A3C5moaGucRyR4nu9ckpvZyJeRxkFdl?=
 =?us-ascii?Q?4d+RcZNPY5nxsxW7X5yRP7F6ezZJGm3S9CyJTPdlkh21dWM4oXG1XT5zIaw+?=
 =?us-ascii?Q?g2vheJ5Jq4MPQLAjDoVfr73QXiV+Kx7M/RO0DPJv2mHzdgsMdx0FTulVFPv/?=
 =?us-ascii?Q?1z9anf1vhcPCSgWA9u01LjZEXmrmClx8DFKFz91sgoI4ikWKI1+aW8WU+W3L?=
 =?us-ascii?Q?t2Mqx+U0hbxFJ2aUBFswf6D+6n/AgATpo9COSRF2aKbIoA5qYeJC7MwU8nQ9?=
 =?us-ascii?Q?HVZBXuXd8Hu7Lx7ZdmOi+Z+0XnaNpJJapKTRJ+JbDf/eP4Fl9PlmrnQhPyWE?=
 =?us-ascii?Q?TcKdfbeXF/PDbXdQsyzCmvIE9fASOjV+0uNFWVYiz4kJGfguJ2NP20vPBy4/?=
 =?us-ascii?Q?1E7cFB13V1yEoS9x7E57TKuozm0wtII59spmGypoe+Uz0uMhClwG90KB0v2o?=
 =?us-ascii?Q?d1mSwsMRW023b+j1qp18waCBSl4HWiG8387+E76KcdDazfvKwPgRdCv8fb/O?=
 =?us-ascii?Q?UNDv3G9sM1ODfLHp3ngw6b/0fY8LguSviszf91ssLITI32KtIk/blrk9fqKV?=
 =?us-ascii?Q?f+HdFbY8d6NSdxPn6V7kkrzAIdMRnkVrt78kfxXCaB1sl+HHr58Sw9wqbd/y?=
 =?us-ascii?Q?4SH2GNoE14Oke69TMzbjhBSuC1GU60LyO/sfqPIEblDfwjOFV0VgWTV2VMBM?=
 =?us-ascii?Q?wtxMwE9423Gj4aMOo4o=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6b2b032-3f56-49d8-6a80-08db17789abe
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2023 21:38:16.2116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s8HbdhW452foyxzp7oTU85iw9MgrK1E/kpAqaA5PimqL+Ml4FoB/vExGcNrdqXJTZkk+4lFaRwXuI9pMxQ51ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6842
Subject: [virtio-dev] RE: [PATCH 2/2] transport-pci: Move transitional device id to legacy
 section
Message-ID: <20230225213816.BvbD8u9tGtfirQ0nOtseVd9x6aIHIKnxheYCA4EMb70@z>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Saturday, February 25, 2023 12:27 PM
>=20
> On Sat, Feb 25, 2023 at 01:12:32AM +0200, Parav Pandit wrote:
> > Currently PCI device requirements section contains mix of normative
> > statements for for regular (non transitional) device and transitional
> > device under one section.
> >
> > Some requirements of the transitional device are also located in
> > legacy interface section which is the right section for it.
>=20
> > Hence,
> > 1. Move transitional device requirements to their designated Legacy
> >    interface section
> > 2. Describe regular device requirements without quoting it as "non
> >    transitional device"
>=20
> I do not think this is the way to go.
>=20
> Spec covers the functioning of modern devices and the transitional device=
s
> when operated by modern drivers.
We do not have a modern driver term in the spec.
We have the legacy driver and the transitional driver in spec.
The modern driver is the way of Linux implementation as far as I understand=
 that binds to transitional and nontransitional devices.

> The text that covers using modern interfaces belongs in the regular secti=
on.
>
What do you mean by modern interfaces in the context of spec?

Spec at beginning says "Requirements pertaining to transitional devices and=
 drivers is contained in sections named 'Legacy Interface'
like this one."

So the content I moved is for the "transitional device" to the Legacy inter=
face section.

A Linux implementation is free to implement a modern driver that probes tra=
nsitional and non-transitional devices.
=20
> Legacy devices and drivers are covered in separate legacy sections which =
are
> non-normative (not because they have to, but simply because writing
> normative sections for legacy devices would be extra effort).
>=20
> Take this example. Modern drivers ignore revision, but transitional ones =
need
> to have 0 because this is what legacy drivers expect.
> Reporting 0 in revision this belongs in legacy section.
>=20
Sure. And that is how the spec is documented as you have described.

"Transitional devices MUST have a PCI Revision ID of 0.".

> >
> > While at it, write the description using a singular object definition.
> >
> > This is only an editorial change.
> >
> > This patch is on top of [1].
> >
> > [1]
> > https://lists.oasis-open.org/archives/virtio-dev/202302/msg00578.html
> >
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > ---
> >  transport-pci.tex | 70
> > ++++++++++++++++++++++++-----------------------
> >  1 file changed, 36 insertions(+), 34 deletions(-)
> >
> > diff --git a/transport-pci.tex b/transport-pci.tex index
> > e271d51..9686cc8 100644
> > --- a/transport-pci.tex
> > +++ b/transport-pci.tex
> > @@ -28,46 +28,24 @@ \subsection{PCI Device Discovery}\label{sec:Virtio
> > Transport Options / Virtio Ov
> >
> >  \devicenormative{\subsubsection}{PCI Device Discovery}{Virtio
> > Transport Options / Virtio Over PCI Bus / PCI Device Discovery}
> >
> > -Devices MUST have the PCI Vendor ID 0x1AF4.
> > -Devices MUST either have the PCI Device ID calculated by adding
> > 0x1040
> > +The device MUST have the PCI Vendor ID 0x1AF4.
> > +The device MUST calculate PCI Device ID by adding 0x1040
> >  to the Virtio Device ID, as indicated in section \ref{sec:Device
> > -Types} or have the Transitional PCI Device ID depending on the device
> > type, -as follows:
> > -
> > -\begin{tabular}{|l|c|}
> > -\hline
> > -Transitional PCI Device ID  &  Virtio Device    \\
> > -\hline \hline
> > -0x1000      &   network device     \\
> > -\hline
> > -0x1001     &   block device     \\
> > -\hline
> > -0x1002     & memory ballooning (traditional)  \\
> > -\hline
> > -0x1003     &      console       \\
> > -\hline
> > -0x1004     &     SCSI host      \\
> > -\hline
> > -0x1005     &  entropy source    \\
> > -\hline
> > -0x1009     &   9P transport     \\
> > -\hline
> > -\end{tabular}
> > +Types}
> >
> >  For example, the network device with the Virtio Device ID 1 -has the
> > PCI Device ID 0x1041 or the Transitional PCI Device ID 0x1000.
> > -
> > -The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY
> > reflect -the PCI Vendor and Device ID of the environment (for informati=
onal
> purposes by the driver).
> > +has the PCI Device ID 0x1041.
> >
> > -Non-transitional devices SHOULD have a PCI Device ID in the range
> > -0x1040 to 0x107F.
> > -Non-transitional devices SHOULD have a PCI Revision ID of 1 or higher.
> > -Non-transitional devices SHOULD have a PCI Subsystem Device ID of 0x40=
 or
> higher.
> > +The device SHOULD have a PCI Device ID in the range 0x1040 to 0x107F.
> > +The device SHOULD have a PCI Revision ID of 1 or higher.
> > +The device SHOULD have a PCI Subsystem Device ID of 0x40 or higher.
> >
> >  This is to reduce the chance of a legacy driver attempting  to drive
> > the device.
> >
> > +The PCI Subsystem Vendor ID and the PCI Subsystem Device ID MAY
> > +reflect the PCI Vendor and Device ID of the environment (for informati=
onal
> purposes by the driver).
> > +
> >  \drivernormative{\subsubsection}{PCI Device Discovery}{Virtio
> > Transport Options / Virtio Over PCI Bus / PCI Device Discovery}
> > Drivers MUST match devices with the PCI Vendor ID 0x1AF4 and  the PCI
> > Device ID in the range 0x1040 to 0x107F, @@ -85,8 +63,32 @@
> > \subsection{PCI Device Discovery}\label{sec:Virtio Transport Options / =
Virtio
> Ov  PCI Subsystem Device ID value.
> >
> >  \subsubsection{Legacy Interfaces: A Note on PCI Device
> > Discovery}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / P=
CI
> Device Discovery / Legacy Interfaces: A Note on PCI Device Discovery} -
> Transitional devices MUST have a PCI Revision ID of 0.
> > -Transitional devices MUST have the PCI Subsystem Device ID
> > +
> > +The transitional device has one of the following PCI Device ID
> > +depending on the device type:
> > +
> > +\begin{tabular}{|l|c|}
> > +\hline
> > +Transitional PCI Device ID  &  Virtio Device    \\
> > +\hline \hline
> > +0x1000      &   network device     \\
> > +\hline
> > +0x1001     &   block device     \\
> > +\hline
> > +0x1002     & memory ballooning (traditional)  \\
> > +\hline
> > +0x1003     &      console       \\
> > +\hline
> > +0x1004     &     SCSI host      \\
> > +\hline
> > +0x1005     &  entropy source    \\
> > +\hline
> > +0x1009     &   9P transport     \\
> > +\hline
> > +\end{tabular}
> > +
> > +The transitional device MUST have a PCI Revision ID of 0.
> > +The transitional device MUST have the PCI Subsystem Device ID
> >  matching the Virtio Device ID, as indicated in section \ref{sec:Device=
 Types}.
> >  Transitional devices MUST have the Transitional PCI Device ID in  the
> > range 0x1000 to 0x103F.
> > --
> > 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

