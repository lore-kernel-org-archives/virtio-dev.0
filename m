Return-Path: <virtio-dev-return-12989-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18FBCEB64D9
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 21:08:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 718D923D58
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 21:08:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 61E48986579
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 21:08:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 51D0498640E; Mon, 19 Jun 2023 21:08:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 367D69863BD;
	Mon, 19 Jun 2023 21:08:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHmsbv7cWsC7iLLd3dqfdFH4qvzoFJn1V2+Rt1u/Rk0f7fE9NMHPRauRj8v4A+YpfEvbenhloV64wy+VP2QGnXXXP/pT4h7BbNljZoof9e0H4VhDGu/TdjZmqqJA18y5YMCe9gZW/XFVB6vqE90GTJNlc+eu/MBlQPfeiLQ2QDyOX2nxi0wOrHh8psW9TyqT3baNWoOLICbSgwPoO2yMgaIJedfUX6BsaeL5W8Q5dCr934iNiO8t0mzWYoZA5miACBXH5JtfUG8IP+RiFE8EbWV5Bmbf0C0EASjCPiiSgrdhcxRGT2ngBGrdjUDtqFbSmqdLXdypK2ZvGYaAUTyFvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TbUEKkV+snbWM3iLhudLrt/m+U2TSX2T9ZjX3Q2MD4=;
 b=U90DPEdr1qKUiPKo2r8th5jGlhMc+lllg3IRh1zuLqHjcBOU5v2gIpMKingmi6rVHxLCtB438shb6I8QG7shI+dCC1cTmRh0LY+FjS2xnBHN25hN8hMMuquvSXsXSVWwvuB/7DL+8bhNJFaruzViGSBHcygsqWW3REczx/c1wrC0/fudP+KysXNood5e4Ylgzj2vfJDAzxCbduJkdqubGp7bHDZHFZmD2EC19gvQhtSDIglrxIasRYqh8oTmOIOKOKTE2ofkVR3AvMrHDl2kwWCzbB9O0hVyHVeeOvbvA5G4axnra7fndXQa2OEWv3zV6Q2oxxVgsnfbTTZ1EZJQ/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [PATCH v6 4/4] transport-pci: Introduce group legacy group
 member config region access
Thread-Index: AQHZnhzOtKzAnSMZqEmlUO1lSJmuDq+SVpeAgAAEMcA=
Date: Mon, 19 Jun 2023 21:07:56 +0000
Message-ID:
 <PH0PR12MB548149CD1C28AA21A203C13ADC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <20230613173015.1244486-5-parav@nvidia.com>
 <20230619112050-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230619112050-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB8826:EE_
x-ms-office365-filtering-correlation-id: 701c88d5-3b42-44e4-5290-08db71094156
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 VGh3/qBgWuqwVJ42/hGpMErTN2WkWB/OnuEHKJT3DI1J0eSmdQ7mDQNa3UqJg3KC+awn+bczZxk8gIBxaeURwpfChrfMP93YEyBHe2zcqUIbu7tKoEkAjonA8hO/BBQMQEYHXOC3EzPWLFiwyNeQU3thFDTYsEBWOulcRu1d1UQN1sGTeX6SVQkaWJtK95lGMUdnSPCx49HOacqqwFP6eKYkZmMgPJHizbm7WAJX6kGVX7Z6X6yVosoKVgl+luKVqUl9ijfudnOovu1Ltnum6RZVjq4B3RjQPkzZAKQCp+1UzePRLDvqkAAuMg+Wi9eaNWlfKZognn7Tu/X1XOYnmqYulgsY81nPH5Y/nE1ACBZguXW6I+OGW+J0KStybDSQTYx0NRAsjvmuUpxwcf0OLKraHIAMMoPEoy5PWLJuL68WD+5tDRKudIGc3c8L5B+YpTkGBfIXnv2K4VQgT6HbRbLRVbhldWEELsrFRr/y5PLCr8NBYXrAYLvmjc2gPwBmULFvDvXbcAG7/MEOhg9/RMebsi0Z/vBDJzUPVENsaP5X3w0C0dYRXyIvZUfdBm//a8esM8P/MfA9m7FZtvVEB0UhkBHLFS9TGpsVinAD2Sb7jNoTgYcmQLNt0+QDC1Ps
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(451199021)(8936002)(66946007)(8676002)(66556008)(64756008)(76116006)(66446008)(66476007)(52536014)(107886003)(38070700005)(186003)(6506007)(9686003)(83380400001)(41300700001)(38100700002)(5660300002)(6916009)(4326008)(316002)(54906003)(7696005)(30864003)(55016003)(478600001)(2906002)(33656002)(122000001)(71200400001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cgx2C5Ksa0YKpCQW60gWamy2PPhuzr9KRX7Honq59rOiBk1qoVzskYQBNSUQ?=
 =?us-ascii?Q?B7b8qBt0RiAFCmVgkN2+x7KtwlyXqo2JUCP4wAxnY8R6YZUpAsy1ut5fKLnU?=
 =?us-ascii?Q?rksyQkUYpR1A78rvEAtuqhT8mMMJBcZs8Yiu1+/5uPOsIfdj2xTb7rQOISmR?=
 =?us-ascii?Q?AxcX9C6UwbMRU/TsaOhxHCZ2AJgXFBegvmgc92hi6i9/TjKZzkcYuOzhyEcO?=
 =?us-ascii?Q?Xcr1cqkdamHFi5Qk1WZye4fl2dfWECQ7mCaMtaMfUQxT4K+EMC7kNq/oAYLZ?=
 =?us-ascii?Q?KXn0GIFwsED81y4u25kkKGsmn8Z8F20PEhowR98t3VO7UIjzyIBEOQtARvD9?=
 =?us-ascii?Q?qXX7eBkufqzC+OH3PxBCYoiWP9CDiRLPgxup+4O+25nhWGlLyDtae3nduRgf?=
 =?us-ascii?Q?74UQPTfG/AKpfK95zteWFahcNtLE6laUKlKzcDehOqO6zFwoUy/734HS0HtL?=
 =?us-ascii?Q?370wst6qjxzQFi5zC57d8yEoGJPTE12tonwp4dq069hlei0paQw8XWwHm2O2?=
 =?us-ascii?Q?o7WfZSsup87q1kijdY35IJ+H5/YlIoEFpLE0q5QcWkFiKLO3qe2q4eArGWbD?=
 =?us-ascii?Q?3RnlQlF4eVltVXg73BIKJ17Mr5GSEjXel+dqycFJPBzzhCjQVhiPvAb9nli9?=
 =?us-ascii?Q?M3GS9Ebz1HW0W03hYF+aUEBb/pNQmHPy+rJe8KvtT8SjISYZDu9eFIFYl46D?=
 =?us-ascii?Q?yhcIgoMVvYIEwv0g3JbubmaNM0PyFTWf8LRqKlqvG6WffVjq4fQU5DFVc0ZO?=
 =?us-ascii?Q?xrwLxDMdofWf7O7zY9DxAbKxyeUxQj5FdN2/qcPZSvIweLuIc40MO2En4bH6?=
 =?us-ascii?Q?Wn5jc+JtJxR/JA/slBcpjOCZQTPCHLH3DGLJgScDrlYJmRsQf5tX7nSInOls?=
 =?us-ascii?Q?aYH2QdPAyzLrh6t+Bu9lL+8JWmoyADol9uVp17PlHHm9EpvkNqGR1EHA0QVs?=
 =?us-ascii?Q?UsNvsnOHTvmG5GhiHNvEL6dY7XC/ZUwr/BHgfmK2CaxNOv8050d9dZckZvCc?=
 =?us-ascii?Q?ldr/revtQot/NIYF3H5k/t9MWXuEo6mckwGkshhg7LI7OVwukthIHFqSGZ34?=
 =?us-ascii?Q?OT7/tnWXF4vNNwzg36/waWFqmpJTqyyH8SoC3dIKGXzBuqh2+76/pj/G6aiC?=
 =?us-ascii?Q?GYBVfboyQ2MyO+nh1Wl2hUjnQ8zIspG0FT+B+uN7e9qBLv3oIg/n/23CKHdz?=
 =?us-ascii?Q?8JLBSw54AGkgZlUyIE4SSmnh6v4Lyudw8g0/yhIDYVzzwwrq8YFD8MOW5vvE?=
 =?us-ascii?Q?bH5gAWXHhofYaxugSUPtgMnNPGrj98rFn/yYlQoWAmc+HnpjfUSu3QEhnl6Y?=
 =?us-ascii?Q?OIjW7SJh6PsO1kWs9kbn9gwfB6lObhJF8nYOCi04adQ7737VWWJ7zfibqf+n?=
 =?us-ascii?Q?JPu+0T01k8KhfRJehJPlyxuOXBZ69oL4fdGcH+EwoEghDj62vO/s1Z8urwx7?=
 =?us-ascii?Q?fscOD0vJbLJFJ+BzinYStWc3QvIvxL7W18XxidASxeBM1BTwbYHrFdUm81F0?=
 =?us-ascii?Q?r0LqThqcjejPTCTNW6kVk3mTLgZhhNa7AICdLq+WudpdBbHKpm4zm2YqL3ku?=
 =?us-ascii?Q?lc/6SPIBqgndz+Wd0XrDwZ6s9UM95jh7N8nxB20sA8qJD1Mj7VBw8VU852+9?=
 =?us-ascii?Q?dnmQFE/w4zjAL4F7ok3jQys=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 701c88d5-3b42-44e4-5290-08db71094156
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 21:07:56.7772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b3GeCO07cJKhLBLDdQV9YFlx3znDbhLNr4R0iXOzROCMD0YOVACILC2dJWyLHono/QcVAaLYJnArDeFpI5GlMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8826
Subject: [virtio-dev] RE: [PATCH v6 4/4] transport-pci: Introduce group legacy group member
 config region access


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, June 19, 2023 12:17 PM

> I'd love to just put this stuff in a separate tex document and just link =
there from
> the generic thing.
> Or if it's too hard, please create new sections for this stuff. But in th=
is case each
> of these sections has to start with repeating the description when things=
 apply.
> E.g. "when using legacy interface"
> when using commands "A B C to access" etc etc.
>=20
> I wrote a bunch of comments below.
>
I will stick to them as most things are taken out to generic section anyway=
 in patch 3.
Only PCI transport part stays here.
I will move some more text to generic section.
=20
> > +As described in PCIe base specification \hyperref[intro:PCIe]{[PCIe]}
> > +PCI VFs do not support the I/O space BAR. Due to this limitation, a
> > +PCI VF hardware device that supports legacy interfaces cannot be
> > +attached as passthrough device to the guest virtual machine.
>=20
> That's not the only reason. Let's keep things generic and start by saying
> something like "Some configurations with a need to support legacy drivers=
 can
> not implement a transitional device. For example .... ".
>
I will avoid For example part and move this to generic section.
=20
> > +
> > +To have a transitional or legacy virtio device in the guest virtual
> > +machine, a PCI PF device as a group owner may
>=20
> may -> can outside conformance statements.
>=20
Ack.

> > support accessing its group member
>=20
> Pls keep it generic. A group owner ....
>
Ack
=20
>=20
> > +device's legacy configuration region using the group administration
> > +commands listed at \ref{sec:Basic Facilities of a Virtio Device /
> > +Device groups / Group administration commands / Legacy Interfaces: leg=
acy
> configuration access commands}.
> > +These legacy configuration access commands are transported via the
> > +administration virtqueue.
>=20
> are these called legacy configuration access commands then?
> why do you introduce this term? it does not look like it's used anywhere =
else.
>=20
It is used and referred PCI section " Legacy Interfaces: Group member devic=
e Configuration Region Access".
>=20
> I would prefer it if you just use the term "legacy interface"
> it is well defined and widely used in the spec.
>=20
It is "legacy interface", with suffix for group member config access.
In future, there may be a section for other things than config access.

> again leave virtqueue out of it pls we'll have other ways down the road. =
what
> matters is that they are transferred to a group member by sending legacy
> configuration access commands to the group owner.
>
Ack.
It is theory of operation, not a normative.
Tomorrow if other than aq exists, one will write as "AQ or xyz"..

But fine to me to reduce changes from 216 to less lines. :)
=20
>=20
> > This mechanism enables minimal involvement of the
> > +hypervisor software only for the purpose of the legacy configuration r=
egion
> access.
>=20
> Leave marketing out of it pls, kill last sentence.
>
Huh, I don't see theory of operation and scope of the hypervisor as marketi=
ng at all.
I will remove as it makes this patch shorter.
=20
>=20
>=20
> > +
> > +When a guest virtual machine requests legacy configuration and device
> > +specific regions
>=20
> wait so now it's legacy configuration and device specific regions and the=
se two
> are distinct?
>=20
> > of group member device, a hypervisor software accesses
> > +it using an administration virtqueue
>=20
> please talk of administration commands. virtqueue does not matter at all.
>=20
Ack.

> > on behalf of the guest virtual machine.
>=20
>=20
>=20
> To put it in our terms, something like this:
> 	when a legacy driver accesses a member device of
> 	a group using the
> 	legacy interface, a modern driver can intercept
> 	the access and forward it to the owner device.
>=20
I will not mention "modern driver" as it has zero reference in spec and don=
't want to bring Linux terms here.
"the driver can intercept" is enough.

>=20
>=20
> > +
> > +Even though virtqueue driver notifications can be communicated
> > +through administration virtqueue, if the group member device support
> > +such
>=20
> supports?
>
Ack.
=20
> > +notifications using a memory-mapped operation, such driver
> > +notifications are sent using a group member device defined notificatio=
n
> region.
>=20
> what does "are sent" imply here? is there a matching conformance statemen=
t?
> who sends them?
>=20
It has the same meaning as "Driver notifications" section first line has.
Isnt it implicit that driver notifications are sent by driver based on "Dri=
ver notifications" section?

> > +
> > +The group owner device
>=20
> this is the 1st you mention any group or its owner.
>=20
> > should not expose PCI BAR0
>=20
> Not PCI BAR0. That is in header. You mean VF BAR0.
>=20
I will rewrite it as,

The group owner device should not expose PCI BAR0 in the PCI SR-IOV extende=
d capability for the group member PCI VF devices when it prefers to
support legacy interface for legacy configuration access using this group o=
wner.

> > for the group member
> > +devices when it prefers to support legacy interface for legacy
> > +configuration access using its group owner.
>=20
> don't use should outside conformance
>=20
What should be used instead of "should"?

>=20
> I think this specific case actually should be more specific.
> Something like:
>=20
> - For PCI SRIOV groups, when group owner device implements commands
>   A,B,C the group owner's VF BAR 0 is hardwired to 0
>   in its PCI SRIOV capability.
>
I wrote it slightly differently above.
=20
>=20
> > +This facilitates hypervisor software to operate with least amount of
> > +complexities
>=20
> complexity is its own plural
>=20
> > to emulate the legacy interface I/O space BAR and passthrough
> > +other PCI BARs and PCI device capabilities to the guest virtual
> > +machine without any translation.
> > +
> > +The group member device should not expose PCI BAR0 in various PCI
> capabilities.
> > +
> > +\devicenormative{\subsubsection}{Legacy Interfaces Requirements:
> > +Group Member Device Legacy Configuration Access}{Virtio Transport
> > +Options / Virtio Over PCI Bus / Legacy Interfaces Requirements: Group
> > +Member Device Legacy Configuration Access}
> > +
> > +When a PCI SR-IOV group owner device supports
> > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
> > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ,
> > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE commands, the group
> owner
> > +device SHOULD NOT expose PCI BAR0 in the SR-IOV Extended capability.
> > +This is to facilitate the software to emulate I/O region BAR0 for supp=
orting
> the legacy interface.
>=20
> not PCI BAR0 - VF BAR0. Check the PCI spec you can not "not expose it". i=
f you
> want to register can be "unimplemented".
> Base Address registers are hardwired to zero
>=20
> But it is better to be specific on what should happen. hardwire VF BAR0 t=
o 0,
> right?
>=20
Hardwire to zero and not expose is same thing to me.

>=20
> > +
> > +\drivernormative{\subsubsection}{Legacy Interfaces Requirements:
> > +Group Member Device Legacy Configuration Access}{Virtio Transport
> > +Options / Virtio Over PCI Bus / Legacy Interfaces Requirements: Group
> > +Member Device Legacy Configuration Access}
> > +
> > +The driver SHOULD NOT emulate I/O region BAR0 if a device group
> > +member exposes a PCI BAR0.
>=20
> what does "emulate" mean here? which driver it is?
>
I will add the line to theory of operation, but I recollect "emulate" line =
came from you.
=20
> > diff --git a/transport-pci.tex b/transport-pci.tex index
> > a5c6719..3647485 100644
> > --- a/transport-pci.tex
> > +++ b/transport-pci.tex
> > @@ -541,6 +541,8 @@ \subsubsection{Notification structure
> > layout}\label{sec:Virtio Transport Options  struct virtio_pci_notify_ca=
p {
> >          struct virtio_pci_cap cap;
> >          le32 notify_off_multiplier; /* Multiplier for
> > queue_notify_off. */
> > +        u8 legacy_q_notify_supported;
>=20
> I am still mulling whether VIRTIO_PCI_CAP_NOTIFY_CFG would be better.
>=20
>=20
> > +	u8 reserved[3];
>=20
>=20
> align with spaces pls.
>=20
Ack.

>=20
> >  };
> >  \end{lstlisting}
> >
> > @@ -560,6 +562,14 @@ \subsubsection{Notification structure
> > layout}\label{sec:Virtio Transport Options  the same Queue Notify addre=
ss for
> all queues.
> >  \end{note}
> >
> > +\field{legacy_q_notify_supported} when set to 1,
>=20
>=20
> Do you mean something like:
> When \field{legacy_q_notify_supported} this indicates that ...
>
Yes will fix.
=20
> > indicates that the device
> > +supports legacy queue notifications at this notification location.
>=20
> And what location? this refers to what? the location described by this ca=
pability
> maybe?
>=20
Ack.

>=20
> More specifically, assume a transitional device (with an IO BAR as normal=
). Does
> presence of this flag in the capability imply we can use a legacy queue b=
ut use
> this notification with this capability?
I don't know how this combination can be even possible by the device other =
than a buggy software who will do both.

> I worry that if we allow that, it opens floodgates of people who are too =
lazy to
> upgrade to 1.0 but just hack this notification in there.
>
Don't understand the concern.
If a device has transitional device, it is 1.0 device supporting legacy wit=
h IOBAR and newer interface.
So...
=20
>=20
>=20
>=20
>=20
> > Legacy Queue
> > +Notification address is derived within a BAR for a virtqueue:
> > +
> > +\begin{lstlisting}
> > +        cap.offset
> > +\end{lstlisting}
> > +
> >  \devicenormative{\paragraph}{Notification capability}{Virtio
> > Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notificat=
ion
> capability}  The device MUST present at least one notification capability=
.
> >
>=20
> I don't get what this is saying.  I *think* you really mean is that
> queue_notify_off is 0.
>=20
Please refer to the current notification address definition.
Above is written in similar way where it doesnt need to describe queue_noti=
fy_off.
>=20
> > @@ -596,6 +606,14 @@ \subsubsection{Notification structure
> > layout}\label{sec:Virtio Transport Options  cap.length >=3D
> > queue_notify_off * notify_off_multiplier + 4  \end{lstlisting}
> >
> > +\paragraph{Legacy Interfaces: Notification
> > +capability}\label{par:Virtio Transport Options / Virtio Over PCI Bus
> > +/ PCI Device Layout / Legacy Interfaces: Notification capability}
> > +
> > +The device SHOULD set \field{legacy_q_notify_supported}
>=20
> why SHOULD and not MUST here - if driver checks for it then it won't work
> without no?
>=20
If device doesn't want to support queue notifications, it has ability to se=
t to 0.

> > when the device
> > +notification location supports legacy driver notifications.
>=20
> legacy driver notifications is ambigous.
> what you want here and elsewhere is something like "when used through a
> legacy interface, device supports driver
>
Ack.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

