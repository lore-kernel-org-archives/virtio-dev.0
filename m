Return-Path: <virtio-dev-return-12172-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61D5CC77B6E
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:48:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BA8563E319
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:48:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B2518986617
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 04:48:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A518398650E; Wed, 12 Apr 2023 04:48:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 94890986509;
	Wed, 12 Apr 2023 04:48:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eCau0oE2O87fqbepxBVMwO2mIYAigHAVz6cCMHyhqVZKfBiiroHWHHV3KV5sOMmObtrsJ78097K+DbRaRDQe9brrQFbeBMjV2lWOBb0yJBkwU5H9qpFNPj+arCg4txuphe0G72BhSRnrzwxdqjgrgQHz0XBEeR+0fd7xXi4g/QqO5B4HdCYzzGYTgMRJIdqWpEInvhsTXWEHw/vNfcMagVA3ZqurA12qrPaarp43fxabZnkO8wbc8mGPEFETlrCloar0FuFSV9cGAL6QDDzUp2YHyQn1LsFIkBHsM94WIYaivh6eMYXsdpf/9x3REhY9C+CRFvtK/rciHySqm+GPjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zaf/9V8De7MOBNnhDNc2r7j9T4dnbsfIj2YfplKwjLo=;
 b=Gm5VpjcbMSwl3tklXyf806ksjkNoHHAJfLnirXr9GsBvD1QbvNBAAqxCWFM9tAypTHI5CtvIQNs0+X/G/qWPn+yGE+Q2RpofaDEFirY1vovsNeZMWoZhGdFYBb2C30qtVupd7Y3IdDJ0gCZuIqt2qBHnzoeTY+i8hbABCYtU6ZUFBJI8BAIFQTgHz7jbZgvgKbLTIeGNIFgQ3X/s3PDKZ+P+BoZbqK9ONMS+Uz2A7v2c5o3vuE8Rn7zbqlCoflae7Ser1D/O9hL5Q+4WXb40/rpNPv6VQQHXC0tI2Sny85QO8JWUWuQwGUNf0hM06qWjfS0YODOVaZ5nVGsPcX/N4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>
Thread-Topic: [PATCH 10/11] transport-pci: Use driver notification PCI
 capability
Thread-Index: AQHZY1tLBn6tX00VoEql9uT0hRsw3K8nKIQAgAAAVNCAAAL9AIAAAFBg
Date: Wed, 12 Apr 2023 04:48:41 +0000
Message-ID:
 <PH0PR12MB548170E8002F19709C6D55ADDC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-11-parav@nvidia.com>
 <20230412003006-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481394D07C5CFBB2347B5F0DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230412004152-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230412004152-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA0PR12MB7721:EE_
x-ms-office365-filtering-correlation-id: c0b5f502-e57f-4c08-55f4-08db3b11309a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Kg1vsRghK/FJEYC5v/x+UFXWUIWnWuJanooz1/0EEhVCnM9U7EW8cNcnrsPZuP2wmLcKQ9ptfxWL6w2edrjpkDESMT6FaqjTJMFciX4PUZxe0M/wESjrMBWCgblnR1NZ8u/dxs9ebfPJWcq8SzkIqleFnQLhhFvvWNJAceCpfTAcs9f+RHW3KXFXn3vFZmB8Arn64LmOs/dhgx894CVXcVQjUAgCWtvrtmHX+fu49EScq7ABXA2FHaWYyM5OjHexLwifIsZN0N7g6Wud0+c8+D+j9ZQE7gC4qlnYHwLHMFooViDik/Xe3rMpNaTIcdoEUPTPt1ceTdUjtzJIdhwM4mdiaAzE6haPjsf4ALvezi1rD1vVzD1uAMmZkvrbaqFT8Z+r9wPa8cJjjmO6tj8xLQZtaVaAzkj1lYTZKJJCOfZ0Ces6kGSIwNjWeO77FVpQE6BcUpsDzCQhUUK/ASL9/85weHhFobMb5NlXij3Qi5gNoP4xbgAjvg2xgmjN0R3mAp6Bcklvl+LFjgiICC9Gyh6hfyxprnBBcfD3PIJlZMy+HYyUKj+33OODnbqHkRoqHYrb8u+JpFcBOiaBS844TtA3n04JlogM9cVZbSe4vEndhwnyN/O9k87JWX3LhwUU
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(451199021)(33656002)(71200400001)(86362001)(478600001)(66476007)(316002)(41300700001)(38070700005)(8676002)(76116006)(64756008)(6916009)(66556008)(4326008)(66946007)(54906003)(7696005)(66446008)(15650500001)(55016003)(5660300002)(2906002)(8936002)(38100700002)(122000001)(186003)(6506007)(9686003)(53546011)(83380400001)(52536014)(66899021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jk6RlAwsON7kfYCrW4iuvExdNLOVGSPOTR539704MY8P6Xs+oG7GuepNwocM?=
 =?us-ascii?Q?RxjcBdPhST7qpvquxhs7Uy8gFZlu22Qnaf0ac+WU3LPK2pvesA5pvp8zY9cV?=
 =?us-ascii?Q?JhUcMVBR1Q7nSfrdB1WhcV6KwWBWT8D0ojC+0l3GTM9+wOKdPrbmXeo7PTy/?=
 =?us-ascii?Q?twHrSCliXrLJGVgvFkF45qI0Moc/cEGjul4T1tpsWVTHd7a3ayuedm8aCc7o?=
 =?us-ascii?Q?yMlnuC5GdaUY69LSaLXZf6MrFdNW90PDIQtm+cSmPaiPUUgq07qWmcCZXNXE?=
 =?us-ascii?Q?2uiVXz3TQBiHvnWzV8HaqFIyCMEYypnbJWGPUeJZRlwM+gpn4oJamXUTqgjg?=
 =?us-ascii?Q?iCGL1iI7a6zLqHsj+cIc5KrTWSSxu7Atr7zR+t4gOHaivRMa1fZYxL51gAAg?=
 =?us-ascii?Q?SiNPw6zYtuNDruXEb0L6Lg7nl3ja7krfY5+qFxHbSJ05DghX2u5bJiw9EdoV?=
 =?us-ascii?Q?4vyFlG7tqibqYdpH4moghOL7vjkr4B3p91s/knhKp3/C3DUXtiqg0B4jsYVQ?=
 =?us-ascii?Q?vKylShuOXJrB+l5JV/8xbxUvayPoWtkaJrn/mEbRlWG8NMBE7gCxiR6AkNCi?=
 =?us-ascii?Q?r76ThFzKmzOdiGqQi58kXb0b3wiFYfEpHoGScQWf/zsgQ8TGrWF5HA05zD0n?=
 =?us-ascii?Q?nK5UL77Ugal7D7fNi/rcQQhcsdgU8NSCRqxOdfyGrg6LFCGw+/A6C36gIJGt?=
 =?us-ascii?Q?ePApZPw/jut7o0bBaQOv3cDhBNTFDghdzuSTzs4ZC8G1JVpb4qLbSsDX1s4l?=
 =?us-ascii?Q?58I/2qHZCe8nVTzIinunK4x67BXoWrrh/JUlbPfJwoKSBwsvQA7AoUCjdDDn?=
 =?us-ascii?Q?bDhKMmLLG1zLHtcL1F1eDbybEThtmNFcVfULAlApH4q2e1lW09FPlhWlVS8e?=
 =?us-ascii?Q?1DVm/OpPmZUH0jQeWuP8cz44AR0IUS91MoIVJ+L5VVuALZYisJ7Idsn5FAGz?=
 =?us-ascii?Q?UYdvxiKid66cxFUoBYYhlDQhj0PS4WB3vI16X3ZCLhgSqPIDMFQ8wAubmIKI?=
 =?us-ascii?Q?XPAYrx/vLsbC23Y6Z6s8hK4bDzPM4E/okFihehr5qsE0qNQUTwix54YtD8MU?=
 =?us-ascii?Q?85rJn7f53pmIitTz2ZYLog7BM1ITC3yBE7b+YIUZlI2FkXbfvKxNvzUmCi5T?=
 =?us-ascii?Q?NhLtRKN+LCG5qlg4yRgeJGxB27XaB5nn/SwCCO6aj3m2VRcnzJgOZyoWVn4t?=
 =?us-ascii?Q?jxX2tn/yFLJ22DpUSxwcYHTFUmvW/QvNK0H4yYlgWE1XZqcxWzbblZWgbMs9?=
 =?us-ascii?Q?/cZpbf5T9bHdA4o6OjBmCGvabLWgG0kosa+ClupSs6wyQT4yFT22LLkuj4uD?=
 =?us-ascii?Q?aKqh1aKxLARmippQlq122Zcaei0vBrQImHKbo4Hti93AfiW11nxiOZIR6fGF?=
 =?us-ascii?Q?6tNayDCHptsgmrCRA9CWA9YRCSqqJoWRD07r78YAU+uCiw7A4n1XKlMEd/co?=
 =?us-ascii?Q?KemvPB7Yyk6ezQ2lTw0sxI1XTmnrBANpveqIPypTVNYlMWlC9AaatbIKjado?=
 =?us-ascii?Q?1DNqleAZzGsFix9s5e1U5iqUa8adDEYEZFhTdYfbJurOK4KeVRuCPdh4r0ge?=
 =?us-ascii?Q?FWMXnCVt6uE1r3dQkjQmttOJEcPL/gzcSGod9lhRSZDAkAWDFJADCZicdjA2?=
 =?us-ascii?Q?daiV+BEGk5CeJLFbK8AoOh4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0b5f502-e57f-4c08-55f4-08db3b11309a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 04:48:41.8542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VTV/Ue1POcw6ALYi5aghsJfPjYFdUHDpEXtI7jy6BEqsoIkJe4BbTwKVDGlaCohLohQOP7zXHpgFA46tpsOO9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7721
Subject: [virtio-dev] RE: [PATCH 10/11] transport-pci: Use driver notification PCI
 capability

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, April 12, 2023 12:43 AM
> To: Parav Pandit <parav@nvidia.com>
> Cc: virtio-dev@lists.oasis-open.org; cohuck@redhat.com; virtio-
> comment@lists.oasis-open.org; Shahaf Shuler <shahafs@nvidia.com>;
> Satananda Burla <sburla@marvell.com>
> Subject: Re: [PATCH 10/11] transport-pci: Use driver notification PCI cap=
ability
>=20
> On Wed, Apr 12, 2023 at 04:37:05AM +0000, Parav Pandit wrote:
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Wednesday, April 12, 2023 12:31 AM
> > >
> > > On Fri, Mar 31, 2023 at 01:58:33AM +0300, Parav Pandit wrote:
> > > > PCI devices support memory BAR regions for performant driver
> > > > notifications using the notification capability.
> > > > Enable transitional MMR devices to use it in simpler manner.
> > > >
> > > > Co-developed-by: Satananda Burla <sburla@marvell.com>
> > > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > > ---
> > > >  transport-pci.tex | 28 ++++++++++++++++++++++++++++
> > > >  1 file changed, 28 insertions(+)
> > > >
> > > > diff --git a/transport-pci.tex b/transport-pci.tex index
> > > > 55a6aa0..4fd9898 100644
> > > > --- a/transport-pci.tex
> > > > +++ b/transport-pci.tex
> > > > @@ -763,6 +763,34 @@ \subsubsection{Notification structure
> > > > layout}\label{sec:Virtio Transport Options  cap.length >=3D
> > > > queue_notify_off * notify_off_multiplier + 4  \end{lstlisting}
> > > >
> > > > +\paragraph{Transitional MMR Interface: A note on Notification
> > > > +Capability} \label{sec:Virtio Transport Options / Virtio Over PCI
> > > > +Bus / Virtio Structure PCI Capabilities / Notification capability
> > > > +/ Transitional MMR Interface}
> > > > +
> > > > +The transitional MMR device benefits from receiving driver
> > > > +notifications at the Queue Notification address offered using the
> > > > +notification capability, rather than via the memory mapped legacy
> > > > +QueueNotify configuration register.
> > > > +
> > > > +Transitional MMR device uses same Queue Notification address
> > > > +within a BAR for all virtqueues:
> > > > +\begin{lstlisting}
> > > > +cap.offset
> > > > +\end{lstlisting}
> > > > +
> > > > +The transitional MMR device MUST support Queue Notification
> > > > +address within a BAR for all virtqueues at:
> > > > +\begin{lstlisting}
> > > > +cap.offset
> > > > +\end{lstlisting}
> > > > +
> > > > +The transitional MMR driver that wants to use driver
> > > > +notifications offered using notification capability MUST use same
> > > > +Queue Notification address within a BAR for all virtqueues at:
> > > > +
> > > > +\begin{lstlisting}
> > > > +cap.offset
> > > > +\end{lstlisting}
> > > > +
> > > Why? What exactly is going on here? legacy drivers will not do this.
> >
> > Legacy driver does in the q notify register that was sandwitched in bet=
ween
> of slow configuration registers.
> > This is the notification offset for the hypervisor driver to perform th=
e
> notification on behalf of the guest driver so that the acceleration avail=
able for
> the non-transitional device can be utilized here as well.
>=20
> I don't get it. What acceleration? for guests you need a separate page so=
 card
> can be mapped directly while config causes an exit. But hypervisor can ac=
cess
> any register without vmexits.

Typically when guest VM writes to IOBAR q notification register, a vmexit o=
ccurs.
On that occurrence, hypervisor driver forwards the q notification using the=
 q notification region which is defined by struct virtio_pci_notify_cap.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

