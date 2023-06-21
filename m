Return-Path: <virtio-dev-return-13025-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07EF3EB64D8
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 20:23:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 632287A067
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 20:23:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5AB769866D9
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 20:23:06 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4DCA09865CF; Wed, 21 Jun 2023 20:23:06 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 392979865CE;
	Wed, 21 Jun 2023 20:23:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcFGMyTscD9AbS/yuUlOiCQExnJJouJTb63KBDMBbz4ZMxwsL8fY07VLVKDD/vksEUSAVWpV0Wo7NMvtIMFPMapCq2BgdyusI7w2q4hCE5ieIXk5G9t09hOTtq9+GgKS0jADr+nMmiMBysALwntwEnQfx8TBv2Gf00QMLX7lUBpcuGMvcTxgmVAHGdC+6EGhx1jz7KyBIchJ9aTRzDlqaeNZ6ErdFQeec0GoCBKM1kEk4LVu9HtBnIg9OcTwSwps97Oj9/FqdNkDXr4miHN7/nCrRTJdn9C3ittf1NgvLTTqMAKC8blhsYZNBOqHIUZ//4G1jq+IgsbR/5F4Y6FJDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wt2SumuXW7r4RWeDKY4Kf2Trt4K5RL3JzxFTH2EjiZ0=;
 b=iR5QXBNLQE5X+iP3BG68M04TC3tFJbmlmNN6q8KwPlaf4kdvtgxBG1pFxJJ6YQKelKdugpec9sSwW0w6nzz3AviHbQuvmaGLSedwBiP99GqUOxlVwGUjGpPZsUPShJ/DJOkfnPPmVHDy/6zsou9sqDgev+zqgxzEdPQVwTGo0BzmFyHV0+rStYSmki7rde8koYmW97pdrRNIWMHTFlN6EUNVPXlzWZYlPdUSmeY5SkAYWRCfirgng3RPqGH40UdsZlB9NKQjuRJuebpHsGoA0c9JKXSYVe75k1m8PXWypfJZMVTb+td24Zhtp5TxVuYJylPKCFsSRaVTKJ6/QPJ+Ng==
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
Thread-Topic: [virtio-comment] RE: [PATCH v6 4/4] transport-pci: Introduce
 group legacy group member config region access
Thread-Index: AQHZnhzOtKzAnSMZqEmlUO1lSJmuDq+SVpeAgAAEMcCAA2BzAIAAAXvA
Date: Wed, 21 Jun 2023 20:22:58 +0000
Message-ID:
 <PH0PR12MB54815544B2D409AC9BBDAAC6DC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <20230613173015.1244486-5-parav@nvidia.com>
 <20230619112050-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548149CD1C28AA21A203C13ADC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230621154832-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230621154832-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH3PR12MB8582:EE_
x-ms-office365-filtering-correlation-id: dcf5ced4-093e-47b1-071c-08db72954dd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 m/yRPQT/g+T8kK8Oi9c5Eb+XC8V4JMTN3tHdcxsWLgqw2YkoZu4thOVCFUgqTgVebmTkeZrvro0hdcVDmI8qmcGDYiXIXcUQqVUARl1ayEuuglu5E9Bs58+Wnc+/T9Jb7ULJJuOLHAHJYQeNsmykCKavqrfN0FvBlJp+B3Q8oXkl+uChByT0zMYL8TvjSXsCUDScZ27CM0MLBS3WVXOBLh7bbpF7xHB/C7u+K/rqNNeTlvZGS8A3SqzqOnjJgBsKsRHMrCvhEPFk38u1NWer19jlIUsbkd5GvYnLWQM4mxEcyDCB+d2ObFBr7oMLuuqq0r21cduF1W276g//sekWoSCO4zNf94qeF73rxNxKBuaR2vwTHalknJRtfRFuM1W7w6VWPRRKb0/zoek9PohBA0o6jcxG6MHGRx5fHgtb/nCswdCkcBupzvTHvcEYcNcuR2JhkqV/iFdXFpVqONJdSIrPz8WB2sPOcqdKAT9XhXljx5vBup+9jriW1NcTxZLyQVii5vMUhxdsY71zab267fD9BaJzhntQhazdvEqc4+xGwhUXoEgHyjVy4ED+ucWSaeILAjvHMfyyz85ot64vQHK1J1RGEmNpdu3xtsFuSLWe6H6O+SzDaPOytU4J90iB
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(451199021)(33656002)(66476007)(5660300002)(52536014)(86362001)(8936002)(6916009)(76116006)(8676002)(38070700005)(66446008)(41300700001)(66556008)(316002)(122000001)(38100700002)(55016003)(66946007)(4326008)(107886003)(2906002)(9686003)(186003)(6506007)(64756008)(71200400001)(54906003)(83380400001)(478600001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9JKl2NSfdoO2YRiPH8N4RICiiV25BT6XyO6QCGqbFym9dFY/C3Nn/ASiK5N5?=
 =?us-ascii?Q?GavvCsyRc32e0XfTfFIFM7lWTiX7GO4tTgFPS/4OPKnuy5A/xW6+bQ/8oGuc?=
 =?us-ascii?Q?mVpt24GesSmoweGcXoPB2puKMoljniA+k8OaoYjw5FVrzCIOI1KPy7FeM9Rv?=
 =?us-ascii?Q?SBMgchNHhy/Ci6OWHsb2qJNQrPNsAN6+mL0Aw0QZPDrnQ8i5zxd5lU4W+rtm?=
 =?us-ascii?Q?vNd2fpYwQYUHysMQdmfVIsKQPygLOjA68FTpaasRjYrpdbJxr+p804STipCZ?=
 =?us-ascii?Q?QmwkbZPS2z8LmN2h8tobhIEudeCe7NPHMMI4XYPYhDFKz7wIdwZQiq0LF7mI?=
 =?us-ascii?Q?lyzEgrKNcURo4MXZjy2x3Jg50lQW1frZnKhZQzKkB91RBmmYyCqvbRb+h83B?=
 =?us-ascii?Q?0DcE5LBP2m+UUt5RFVByBH9vDuvvElS45FGyEpGSh1BuhA1aVEztcLv/Icar?=
 =?us-ascii?Q?fbj66wyk6IZhpiBahI0+bi9nMg7/mKzFozpaBMNfDn8fyf+Am5YaXf9UDIpt?=
 =?us-ascii?Q?AkrqwdUWBwmOIDQgOD5heJEQiH4ssqyoO8Z6TKJeAseBXo5U9IVIrJbWNaJp?=
 =?us-ascii?Q?8WnxmodzMLx4hzlsOsIKVQm1u9NgAEUEPgzlLOlWz862KSc2iXyV9Ct/bElN?=
 =?us-ascii?Q?ecJvx7xJLFT90xaadhohdyNvaJVYyi0reev6vsnFECwbfA5n5IQkow4JF2s5?=
 =?us-ascii?Q?JvEHDxyhe+AigMkb88/QfSLFRmU+ygxrskxq6Z2oPESgTKjISJwKjN798yVk?=
 =?us-ascii?Q?IvSd9t4a5XiMIJkhbkbMK6dz0L/NOh+bZWk8BliCk5R3X3BwXwN6poELLKWW?=
 =?us-ascii?Q?frZD9k6fnbT8ShVLwHOZ2mdOgBav3tRfPzcWE5d32JxeuF7f7bcrGwB8pv6H?=
 =?us-ascii?Q?aFCnPrG0qgN02xb3g/dXrQaqJWDpOhOcClp/I2gQH74oKvYgQarz8HUNLKTo?=
 =?us-ascii?Q?+vY8j6iqQ/i5QgUoYoUvNcIs/p0Iy9EDCIPaCwZZCWVJl9X6C53aIdCP5ofE?=
 =?us-ascii?Q?mB9Rvuenp65PeeQ3hcRbOQ0Cl2Ai7jDXOx2pbiVZIdeIEBjJWtqpuO5kzas6?=
 =?us-ascii?Q?m0huwfNDLdFWC4UL+OW60B4QAMLjIYFdx1lAeR8IvqY1mzesrXO8pOuyhDsD?=
 =?us-ascii?Q?L+PjeVHr77PqPEdSm/36nYV9YJbY7396wy3v8ynnMoTDCQYtYYqdGKFvSGkO?=
 =?us-ascii?Q?BW66hBaK28i65LqRCPyZZIz4qhjlftadxVp2SDtVVHiuq4ZAhIK/7LBZuAzo?=
 =?us-ascii?Q?GA1c5/3zlOdILVNwwD64gqdMF3DDSQDbMK7vPvazYzR6YfXgjAntFHZmEr6C?=
 =?us-ascii?Q?Qrm4iWjScvpGxm7kKJ7absWkYOOZXK852itJWiZgCH6Z8LQ92YvS2FU8owCp?=
 =?us-ascii?Q?kT2uoatuJeyA4kUMJwCkHN5HRgLnJIUiZ1Kg8CnEzAmCQdkPhcFLg6Xxq/1Q?=
 =?us-ascii?Q?QIKrRL5QnnV0/MOz/zZS0QwITdq0zDfv5pqwsuihOM4dbCgiPCydZcTbtwuW?=
 =?us-ascii?Q?JyJeMS7Tz0kSLzj7xx1k1CAP56pTMLge7zRZW3tz8kaxYwQfWt72E2PxUmR1?=
 =?us-ascii?Q?NyihLAvGPWCYI0/1xupJrBg8TiKvLygLu8YLrKGiKMtCPiBhNlJkJIDb3SwZ?=
 =?us-ascii?Q?DI/fRYrdJQ4HN1fAeB746OQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf5ced4-093e-47b1-071c-08db72954dd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2023 20:22:58.4200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IcNMuIEWGJF8M6+B2qRqtwgv3y/ZlfNEKABhFBuxJMr9jjl0sfMIxBQSTZ+R4m5zPQYnrJlozoQFehvHfpUpfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8582
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v6 4/4] transport-pci: Introduce
 group legacy group member config region access



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, June 21, 2023 4:06 PM

[..]
> > > To put it in our terms, something like this:
> > > 	when a legacy driver accesses a member device of
> > > 	a group using the
> > > 	legacy interface, a modern driver can intercept
> > > 	the access and forward it to the owner device.
> > >
> > I will not mention "modern driver" as it has zero reference in spec and=
 don't
> want to bring Linux terms here.
> > "the driver can intercept" is enough.
>=20
> Good point but since you say "a legacy driver" then "the driver" seems to=
 refer
> to exactly that. How about:
>=20
>  	when a legacy member device driver accesses a member device of
>  	a group using the
>  	legacy interface, an owner device driver can intercept
>  	the access and forward it to the owner device.
>=20
Above is not correct.

We have 3 drivers in picture.
1. guest driver
2. hypervisor level member device driver
3. group owner device driver

Trying to write without introducing guest and hypervisor term,

A group owner device driver provides the service to access member device's =
configuration region.=20
A member device driver avail this service when it wants to access the membe=
r device's configuration region.


> > I will rewrite it as,
> >
> > The group owner device should not expose PCI BAR0 in the PCI SR-IOV
> > extended capability for the group member PCI VF devices when it prefers=
 to
> support legacy interface for legacy configuration access using this group=
 owner.
>
>=20
> This seems to ignore all my comments.
>
I replied after that, probably missed in exchanges.

How about:
The group owner device MUST hardwire PCI BAR0 in the PCI SR-IOV extended ca=
pability for the group member PCI VF devices when it supports legacy config=
uration access commands.
=20
>=20
>=20
> > > > for the group member
> > > > +devices when it prefers to support legacy interface for legacy
> > > > +configuration access using its group owner.
> > >
> > > don't use should outside conformance
> > >
> > What should be used instead of "should"?
>=20
> Depends on context, generally we just say what it does. E.g. "VF BAR0 is
> hardwired to zero".
>=20
Ok.

>=20
>=20
> > >
> > > I think this specific case actually should be more specific.
> > > Something like:
> > >
> > > - For PCI SRIOV groups, when group owner device implements commands
> > >   A,B,C the group owner's VF BAR 0 is hardwired to 0
> > >   in its PCI SRIOV capability.
> > >
> > I wrote it slightly differently above.
>=20
> I don't see why what you wrote is any better than what you had to be fran=
k. You
> are coming up with our own terminology instead of just using what's in th=
e SR
> IOV spec. Please don't.
>=20
> > >
> > > > +This facilitates hypervisor software to operate with least amount
> > > > +of complexities
> > >
> > > complexity is its own plural
> > >
> > > > to emulate the legacy interface I/O space BAR and passthrough
> > > > +other PCI BARs and PCI device capabilities to the guest virtual
> > > > +machine without any translation.
> > > > +
> > > > +The group member device should not expose PCI BAR0 in various PCI
> > > capabilities.
> > > > +
> > > > +\devicenormative{\subsubsection}{Legacy Interfaces Requirements:
> > > > +Group Member Device Legacy Configuration Access}{Virtio Transport
> > > > +Options / Virtio Over PCI Bus / Legacy Interfaces Requirements:
> > > > +Group Member Device Legacy Configuration Access}
> > > > +
> > > > +When a PCI SR-IOV group owner device supports
> > > > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_READ,
> > > > +VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE,
> > > > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_READ,
> > > > +VIRTIO_ADMIN_CMD_LEGACY_DEV_CFG_WRITE commands, the group
> > > owner
> > > > +device SHOULD NOT expose PCI BAR0 in the SR-IOV Extended capabilit=
y.
> > > > +This is to facilitate the software to emulate I/O region BAR0 for
> > > > +supporting
> > > the legacy interface.
> > >
> > > not PCI BAR0 - VF BAR0. Check the PCI spec you can not "not expose
> > > it". if you want to register can be "unimplemented".
> > > Base Address registers are hardwired to zero
> > >
> > > But it is better to be specific on what should happen. hardwire VF
> > > BAR0 to 0, right?
> > >
> > Hardwire to zero and not expose is same thing to me.
>=20
> Maybe, though previously you said it just means not put any capabilities =
there.
> More importantly I don't see expose or not expose anywhere in the PCI or
> SRIOV spec.  When spec wants to say how not to have a given BAR it says e=
xactly
> hardwired to zero.
>=20
Hardwired to zero is fine, done above now.

> > >
> > > > +
> > > > +\drivernormative{\subsubsection}{Legacy Interfaces Requirements:
> > > > +Group Member Device Legacy Configuration Access}{Virtio Transport
> > > > +Options / Virtio Over PCI Bus / Legacy Interfaces Requirements:
> > > > +Group Member Device Legacy Configuration Access}
> > > > +
> > > > +The driver SHOULD NOT emulate I/O region BAR0 if a device group
> > > > +member exposes a PCI BAR0.
> > >
> > > what does "emulate" mean here? which driver it is?
> > >
> > I will add the line to theory of operation, but I recollect "emulate" l=
ine came
> from you.
>=20
> I generally am fine with using this term but we need to then define it be=
fore
> use.
>=20
> This specific thing I would just drop.
>=20
> Instead of wasting time just say device MUST hardwire VF BAR0 to zero as
> opposed to SHOULD, and we do not need to worry about how drivers recover.=
 If
> they want to they will validate, if they don't then they won't.
>
This limitation seems fine to me.
Will drop.
=20
>=20
> > > > diff --git a/transport-pci.tex b/transport-pci.tex index
> > > > a5c6719..3647485 100644
> > > > --- a/transport-pci.tex
> > > > +++ b/transport-pci.tex
> > > > @@ -541,6 +541,8 @@ \subsubsection{Notification structure
> > > > layout}\label{sec:Virtio Transport Options  struct virtio_pci_notif=
y_cap {
> > > >          struct virtio_pci_cap cap;
> > > >          le32 notify_off_multiplier; /* Multiplier for
> > > > queue_notify_off. */
> > > > +        u8 legacy_q_notify_supported;
> > >
> > > I am still mulling whether VIRTIO_PCI_CAP_NOTIFY_CFG would be better.
> > >
> > >
> > > > +	u8 reserved[3];
> > >
> > >
> > > align with spaces pls.
> > >
> > Ack.
> >
> > >
> > > >  };
> > > >  \end{lstlisting}
> > > >
> > > > @@ -560,6 +562,14 @@ \subsubsection{Notification structure
> > > > layout}\label{sec:Virtio Transport Options  the same Queue Notify
> > > > address for
> > > all queues.
> > > >  \end{note}
> > > >
> > > > +\field{legacy_q_notify_supported} when set to 1,
> > >
> > >
> > > Do you mean something like:
> > > When \field{legacy_q_notify_supported} this indicates that ...
> > >
> > Yes will fix.
> >
> > > > indicates that the device
> > > > +supports legacy queue notifications at this notification location.
> > >
> > > And what location? this refers to what? the location described by
> > > this capability maybe?
> > >
> > Ack.
> >
> > >
> > > More specifically, assume a transitional device (with an IO BAR as
> > > normal). Does presence of this flag in the capability imply we can
> > > use a legacy queue but use this notification with this capability?
> > I don't know how this combination can be even possible by the device ot=
her
> than a buggy software who will do both.
> >
> > > I worry that if we allow that, it opens floodgates of people who are
> > > too lazy to upgrade to 1.0 but just hack this notification in there.
> > >
> > Don't understand the concern.
> > If a device has transitional device, it is 1.0 device supporting legacy=
 with
> IOBAR and newer interface.
> > So...
>=20
>=20
> if we are switching to admin commands for this, then let's not argue abou=
t it.
>=20
Ok.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

