Return-Path: <virtio-dev-return-12848-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3221EC7EE23
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 14:32:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 80ABE6846B
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 14:32:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 78D3E98645C
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 14:32:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6AFE49862E3; Sun,  4 Jun 2023 14:32:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 507FA9862D0;
	Sun,  4 Jun 2023 14:32:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6esPXArPHIFITfqieQbiPLqOTIB27cRnOv8D/gDRo+LvJmf8/MMzzQHPriGUiZ+0mrQ+Wpc6uPo7aeVQh7r9SjpDgMhZSMv83Ptwr3V0pR3+B8N0Fp+/WPjZ+BdKtuhP/Halb/kf8w+e14Y1P1Px0oZeDWa+fXok3h30WSG0sO6CL9z5u9l7UtCaEeLMhUveu6LAcVJpgCRfOwvUFUi4qrj2wXs8XpDhZu3zyD9y8JEqSwTkznGSVnKjwjc3yL/xyfqIXimD9klHghpP9xfuzvmtyyeRmb9OeLIEoXdV+5ktnMKkeOMELmSpHTcD1B4AOP7FHrK97m1WidXL5vLTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2t7wAFGYwG+B32JNcQHljicqHwQ/aNeLIl/CMTyNhaI=;
 b=DewhvUJbKzGpgnwh1MLdW9hjbRnK5/UE6GakUPhIede4fCkB7gsGRV9770zBkJn0U+VX20itHHPWL0yjOmJB/AzUkDdVq2eM9gPc2AmKT/dIDC/wmTXdpNMeFsrNIeKMgi6Zd0CV1ii5a/PviAhWczgIaP6Ne43bQIyNg2sSfL9k6IMz+wLnrqf2nhBJMacB4rktV+Zt4VEQQbYyjIvwadHVu85cCdlljAknRuoAlaTJvXDOFK5FAJCIec53HZxgnFbq9N7O7HKrqmeDqTt9qhL4qfD0an1mTF/tvFIgNfVC1AZmB+2sYex0SqdHL13KEK+X197qYKG6czG2QE+X/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v3 2/3] transport-pci: Introduce legacy registers access
 commands
Thread-Index: AQHZlZHrjhTPPTQ0ZUaNTBTq19TtJ696o/kAgAAGnPCAAAfAAIAAAPOA
Date: Sun, 4 Jun 2023 14:32:23 +0000
Message-ID:
 <PH0PR12MB5481D7C7EEAC610BBBDEB69ADC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230602203604.627661-1-parav@nvidia.com>
 <20230602203604.627661-3-parav@nvidia.com>
 <20230604091651-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481195B63FD61C35447FFDFDC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604095615-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230604095615-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM8PR12MB5479:EE_
x-ms-office365-filtering-correlation-id: 9c369330-7729-4199-480d-08db650882f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rNz0vZiESYy1Fq5j5zcMPYWcr4ymyaJZeXzyS7mStNZBf7L7UEb+Tg+9rEABIbNyvgVpbh4jb7a8JQO++G59aq6yE2bTW34pFqDZeR2y1Azka4t+nDTCx3RHXawcPOAb9fl3OPXyfbp2FRcjad4rqY0+rsWbmhgM3bMfrb2alhV1aFQ8nTJ29U5qgcrHtLVvH0r4MMtGsh03p1FdA3UIUJxNmhh7faCKytbZrcp0Eb23d132tJtCPUypI06vuszPepLlVvCMH7rziEsaxUqPVlzHJPXPeNwBqF/2jn9jKP84fZeJpT/w0U3jhApXzwgv6Xep2rrvdpCfIMVgdsH5OQ3adE4lgCVuPEmrGGQmAMyzrUpjxWTYA93pbLUkWevvqNvNzFbI5OSHchDvj34OYki7iOAEXWdr0n980oEJxosgOMl9q5Dbfi3/rFDR7h+65NW4CmZKP9rMaWjnNfQYeyrJqb6wZyooPtfbx+uYirqwtHn6aCHWoT7HJc90L8SJcUIAJtZKa3qqgT1xra/S/DYahDHNq5h3JfVIQoSOuxoeMbCu4g3G2/NEuanJI+eX0JPNBGaGIzVOg5iO4BEmh1+yAmPXmNRtm8pMJlilf122MnIet84j/TYsvU4gYr7q
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199021)(38070700005)(41300700001)(478600001)(71200400001)(55016003)(2906002)(86362001)(83380400001)(122000001)(5660300002)(316002)(186003)(38100700002)(52536014)(8936002)(7696005)(9686003)(8676002)(107886003)(6506007)(26005)(33656002)(6916009)(4326008)(76116006)(66946007)(66446008)(66476007)(66556008)(54906003)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?n3eskfiWgoRjUSWEzHf6DfO1h56N17qDBJ8LNm3DBIpRbHhXG1zA0YwCJeK0?=
 =?us-ascii?Q?a3CFwMuuM2DJT57Ouo01OOrs69y7zjC1LuDvVcVU16ZTelOoR6pNloR+lsu4?=
 =?us-ascii?Q?zE/HwqAlIUn0Dp5anRf33vVvLPpV0nqB+JrsCNsrqjnNfwunBbtSz7PWtPns?=
 =?us-ascii?Q?u3KggYyr6HtozYhAup1urRS3wR/fLr4hbrKZv9PX/EAJ+qECgSB7OVbz7MGv?=
 =?us-ascii?Q?g2kjfWVzHJdqnHIWEN4kBXJPhjgdYpHGmGPRvcZ7jxPlZzoPB4YRM2qzdCot?=
 =?us-ascii?Q?OxgTsmzdOGjiUWkLgiMICfCqKK/xCU1p8+BIem352VrBR3yzjAENNAgQ9NRa?=
 =?us-ascii?Q?BUavQOXJ8RQe940nHFC2aUXRgXaQg7LTyAFFgzMST01zXdK3M2UmcXJFZieI?=
 =?us-ascii?Q?9HJIq8sObeIuHaMDCYn8N314ZfS8e6/fDqHUydO0UHAULzpjIbNQY1c1q/O4?=
 =?us-ascii?Q?IKkx0gnfiAjdmCZT+d4WVvyRqbTB+Ko8xuBbxTnylC/L7lr+S2kICQjzfaYv?=
 =?us-ascii?Q?o7lnZ7wjqy+MA7yuLLPu1DGKIQ2YKI9Thcrcx5/7FOrjuHJJFSXKnqwXOou0?=
 =?us-ascii?Q?noaeZUks9Sw7PbHXZZXrhB7puH9zzm0P2nvmXnHy8cLQU5Nw8Q1AS4AsO5Jl?=
 =?us-ascii?Q?LYXw1gPYG6BkD3nxjoq3YuC+fObq9bDpZBPlagiJoiLM++YRt21YLOVInSqp?=
 =?us-ascii?Q?xyDCyVcmdhSO4OfCD0sfYZDqAMlJV8NPRZzy7jHYl8Ql1tvjF0BdCXHKxDjh?=
 =?us-ascii?Q?2ZoC2RnuyjpXVPtezx9RFcHdxMX0AkK6l8dC5D00HfiFVrnEu+PGRrMUdbfv?=
 =?us-ascii?Q?HY8WkM2qPEB8DSp4S507Tpn6KA1mnOkDzt79CZek3fe/OHpOY/RNIMFesk8F?=
 =?us-ascii?Q?sH9zSubs9S8NLbKcky7hVV7/Ii1WRunB4dg4LL/LK4bvr/4sqmB5jLSp0l9M?=
 =?us-ascii?Q?NbBcQNHuriKItazGROLUL6NJSMN57DvFasuBdDpPc99MdUrH2AoFf1rQKyhb?=
 =?us-ascii?Q?3t+m/KGtyS94/PqxslaTxNSbti1SS3IT7HzdUYsMPoxYCfRlDENERPzwJTup?=
 =?us-ascii?Q?VgK/kXrCOD7hRcFREG1LTg42WKTG9ZnNb4cui9MNvS34GbJxHM9Tlhb0QCn2?=
 =?us-ascii?Q?r0UzLaz0LDxY1O6d41rzSyIuSAEeE+H1Culxg3jKmzHEVFQVOYpmoC+vNI62?=
 =?us-ascii?Q?dEderpXrmwba6+8ZjEN6MyBE3yK/DOGJUm/kzC7pMFLR0OF/oKm4Yoc9O4fh?=
 =?us-ascii?Q?Xi5VZ5yzAUu0PlghJ+fy0QiFh2BvSEGbfXzLrdkZR+ZSvVoyD1Sm0j2zmOyG?=
 =?us-ascii?Q?ti13cEIs5/fsgLkVhPY/95cc6IImss83hv5V85aVw2huKZgynHdwdDzUz5mn?=
 =?us-ascii?Q?XRSKrT7YOBJ3ftaWAAD1ScNfsI5wQ94YTruGBNdo/WYEbcEFN2DAsgJeeSSl?=
 =?us-ascii?Q?tfELOM4hL6iWQZVm8VY225ni4xvEzJYqErqDvNXO8ei4iMhSwBPt+/AfoUFC?=
 =?us-ascii?Q?EpiJKMwWUzS+Kmpx8raC6jxjnkbvvpVdJrrN7VxE3PhLGdq6pAaZft5H1L/a?=
 =?us-ascii?Q?rvHJS7e+r4RYQsqvaeY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c369330-7729-4199-480d-08db650882f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2023 14:32:23.3886
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c4iQXU6iQfQBHzS4S+8KA5RQNKJNUZ4E5bqKlYWGK5751ZU0krVFxklduMdGUIWTHMB6aSX3LgARA5u2gFvA3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5479
Subject: [virtio-dev] RE: [PATCH v3 2/3] transport-pci: Introduce legacy registers access
 commands

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Sunday, June 4, 2023 10:14 AM
>=20
> On Sun, Jun 04, 2023 at 01:51:20PM +0000, Parav Pandit wrote:
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Sunday, June 4, 2023 9:22 AM
> >
> > > > +The driver that may use the driver notifications region of the VF
> > > > +device returned in this result likely attain higher performance
> > > > +or the drier may use the VIRTIO_ADMIN_CMD_LREG_WRITE command.
> > >
> > > Obtain I guess ... but how? There's no explanation.
> > >
> > Do you suggest to rewrite, above as below?
> >
> > The driver that MAY use the driver notifications region of the VF likel=
y obtain
> higher performance.
> > The driver may use VIRTIO_ADMIN_CMD_LCC_REG_WRITE command for
> doorbell notifications.
>=20
> No this does not address the issue that there is no description of how th=
is
> command is used just a hint at what it returns.=20

> So this gets us some offset into
> some bar now what? =20
> I am guessing writing vqn at this offset into bar has the
> same effect as issuing VIRTIO_ADMIN_CMD_LCC_REG_WRITE with offset 16
> and data including the vqn?
>=20
I can add the one line description that describes above. I take note for v4=
.

>=20
> BTW all these may/must/should need to go into conformance section.
>
Conformance section for the AQ itself is missing. And I am aware to fix it =
post your v13 series.
=20
> Generally the way we structure the spec is an explanation of the theory o=
f
> operation (mostly missing here)
>
It is not any different from v2.
Theory of operation is not going to describe the whole driver design.
It is not likely the scope like any other section.
Section "Legacy Interfaces: SR-IOV VFs Registers Access" has theory of oper=
ation described and also in commit log.

This is like recent AQ patches and notification coalescing and more.

So if can pin point what exactly you want to see in theory of operation, it=
 will be helpful.
Because for one person, 10 lines of theory is enough like how we have most =
of the spec, another wants 100 lines with pseudo code in appendix.

> v2 had other issues so I missed this one.
>=20
> > But ok.
> >
> > No. It is not related to last command.
> > What does a PCI Device use BAR for?
>=20
> To reserve address space and know which addresses to claim.
>=20
> Generally if I heard "not use BAR0" I would assume that the meaning is th=
at VF
> BAR0 in SRIOV expended capability should be 0. However, that affects all =
VFs
> and not just this VF so I don't really know what can it mean.
>
A PCI PF and VF device which wants to support legacy emulation should not e=
xpose BAR 0 in the struct virtio_pci_cap struct.
Instead it should use other BARs.

> > As described in the spec, it uses the BAR in struct virtio_pci_cap for =
exposing
> various things.
>=20
> Now I'm confused.
> So do you mean the \field{bar} in virtio_pci_cap or PCI BAR?
>
Yes.
=20
> > So it means that PCI VF should use other than PCI BAR 0 for various Vir=
tio
> Structure PCI Capabilities that it exposes.
>=20
> I suspect you then want to say "should not expose to driver any structure=
s
> inside it's BAR0"?
Instead of bisecting at structure level, it is indicated on usage so that i=
t doesn't need to bisect on "what about MSI-X".

> And does this include this new command you are adding or not?
> It mentions bar too.  What about e.g. MSIX tables? Could there be other
> capabilities referring to a BAR?=20

> How does hypervisor know whether VF followed
> this rule (it's a should, not a hard rule after all)?
>=20
It is not a MUST.
Hypervisor software using this VF very easily know this when VF is attached=
 to the hypervisor driver by reading the capability.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

