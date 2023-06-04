Return-Path: <virtio-dev-return-12852-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9C4BC77B73
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 15:02:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6218660049
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 15:01:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 49FDA986339
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 15:01:59 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3A3FE9862CE; Sun,  4 Jun 2023 15:01:59 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 256189862D0;
	Sun,  4 Jun 2023 15:01:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cj2DD0Ovkc7km0sb5LddGTkbjZNWEnRzuB6X+bJRqiOGqPZ5h0TBmS8k8AOz7FSkfzb8P51gWFYuucHaTE7+BLOtWkKrgoFcVGQtSyAeMm9yxjYiyRyQiWS9BcFbcotnzvEpmLurXctXuzkaixNoYzRdomy7vCQhOFLUY+Luqp4glL60F05v8fZEM5XDctfrkKVUT4z9DbUEuzYMoHK+6MV1LOHbaBA5E7wGas4j1QTfiSg0UedP/pT10pacjz+hfhsj1NYYm9qUJ7/vXblDTcpN70oETV5Sotsbe2HT5sSk4xwDNpBQBxmDwxuFl6k+tDnBzmmKdNi+DORBxP+C5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r4viIdiO7aul+NFL06rE2R8Nj3E0Xm8DzJVx6J2BPpY=;
 b=QmmjvqoFMq5Yq5k9erl74ht4fqm1mveYrN6GbNQItqtyRi7MTNIitUYrsKyoO0U0xZAhBEgPXZOHM5nOJmyREp/N9FEfnvtM7/p9V/1aSH6gmR0IHr3vlbuygDkmIrCns++Jd1K+902+IZDPPe/dz7J6nin41dBLTqGIYmlY5VB/FPF2mV1CELnyZtoiHkv2jcK50yMuukKPNIE6aMu9jIo17RJ9YagxO019O6SxTJ4096/mMOQehzAJCYiwsK670S5a6kzE5lIrfLrpM5h2fXXgr/nfJVDn86olTsFydpwYjsyWE3m0Movmbt9dTnJML7mkgNiFPOi9q4notvp/cQ==
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
Thread-Index:
 AQHZlZHrjhTPPTQ0ZUaNTBTq19TtJ696o/kAgAAGnPCAAAfAAIAAAPOAgAAG/ICAAAKAQA==
Date: Sun, 4 Jun 2023 15:01:52 +0000
Message-ID:
 <PH0PR12MB54813E50A9821F960C43C5BFDC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230602203604.627661-1-parav@nvidia.com>
 <20230602203604.627661-3-parav@nvidia.com>
 <20230604091651-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481195B63FD61C35447FFDFDC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604095615-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D7C7EEAC610BBBDEB69ADC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604103309-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230604103309-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS0PR12MB7605:EE_
x-ms-office365-filtering-correlation-id: 6150da55-ad83-4b9f-5910-08db650ca1af
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 mT83f1yxJ2K/mQQuyp+SyO6Zmrgs90OXkngmb7haQBMkviQSdxwLy1RXUeLkvUDbh59yauQm/PEGf7gv4pheYjvs+r9+D7cSFhTZbnuYo1Ptbmt51wwVvnfo/a0l/u0iKAJcnMahL2EVKDSphjIv9llR+CX94+gH6HiFBvikN+NGB/n0AFw37PZr/UwCES6JRoIph4JtFMc6ZTY46sxpgaBeXPPJjFemR8YuUysvsGTt62Ghg5bhdqrR/xzjrNeJB7K4T+4jC+JC6h1kltmXRWa0PVKMcOWaGlneMuuUPDQdwwhrCl+M5QXMeN8AjlrBMiSNEwSLrpxYTphDaDvyVSZxUNosCD3wY2MLCnPXo9mmuKsUrRdfKGaXtqiSHZ/TM+Gi/zro3jVn2oRwrmasoKmz0yrMGmvgVDW53t2BQGe/hUHEd+Q8/e/uAunwUTqJnDXo0sDMQI3mBOr7taaDDv4e0e1ovfxG5V6Nb893KEtoUCLcmmNU8rBeNCzcv3OdRKz4VXnexHuqWe9oRjqNNtPYrh/CA50Oej/GK/bS+XvE7fycqadcHUqw7DDCi71U2wbdpvrHfwPSyUH9oWzDGM8xxIJ3p5KJtasCX1N2STPidaxXAABFa87hj66Aeqhk
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199021)(107886003)(186003)(26005)(6506007)(9686003)(83380400001)(7696005)(71200400001)(2906002)(8676002)(8936002)(54906003)(478600001)(55016003)(33656002)(86362001)(66556008)(66476007)(66446008)(64756008)(122000001)(4326008)(38100700002)(5660300002)(6916009)(316002)(41300700001)(38070700005)(66946007)(76116006)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9cK14Jl2oz1YVkgS40bisc4uzSQz3rTpi/+UetN8ckYtAgGqYqNlq623PeEU?=
 =?us-ascii?Q?HGvn7tmErDWKsZUtfc3+4HhpSLijsz6WO94FbCtrfDxgngUx7G/c+vhF8bUG?=
 =?us-ascii?Q?6C46HFwegFgdDsUzSQpbe6y92+ipvdLQkEz4ng2NMfct21isqdPmS5w1Fiqi?=
 =?us-ascii?Q?6NLzzOhxRkfnTqwHmWMDbTch+mWOuFs2wXiVyiWzYgHwasXabrAckgsRLf/p?=
 =?us-ascii?Q?5cDInWoXiSEdQVoyYZHIZfxQcWAT20BPtGv6caxWl2ILJdWKrvEYQDsDqzs/?=
 =?us-ascii?Q?pwf7vfRGrLX+s37Y2t9ocCB5gnpyKJwu2J1aPXdM/vMbt19H/4CWZ8QqMGZy?=
 =?us-ascii?Q?Wr+ZDYPExen3BqRuGQO0hQyuRiAk0E3PAJ97wHu+qaGqTvPCSq+umZ6R0lFM?=
 =?us-ascii?Q?JNGR9IiE6nXtlCEH0+9xHFv1P8W7J1YwRtWrEiCgTtLUQ//qlDlSAwvcTBoL?=
 =?us-ascii?Q?4iC6MoQMd5MuS57gouorLYx67+PHKLVd7JroSFoXPBx23vHxQ4oct7oO+li0?=
 =?us-ascii?Q?yvOU0QU6W3ZA488q9Fq4Q4vTYU8Tk6RZy2Rhe77a27bu/jZWXf6hv5ZmfpUN?=
 =?us-ascii?Q?dNoVHBMavlILF42XgN1w6fV7z8ACR/3m1YRUsNvG0OXQisnuwQdj/3a30Gst?=
 =?us-ascii?Q?BKgW9l/X2m075fbIz2Ue0yjRllA2f+e0r2M17ARxNzNY+M1KX4oxnvr2Z/lL?=
 =?us-ascii?Q?6v7cs3HlTApdrCstXfVdMMUnqWBYy7dnImIFvNuinlGPr2q4ysWjBq0aJq2E?=
 =?us-ascii?Q?AihjHH/Cg7z3lf9P9x7WKGBnFSXn1FaW5yamqiClxWtDrcqn7iO+MSuNByl+?=
 =?us-ascii?Q?1CuQVn6rGxgOlu3+UjR7mTSq2OQi9NZ6itoF5LFXrK87VX8IU6jmuURlTju0?=
 =?us-ascii?Q?5/F/7CIoK64G5W8cE/SZ0PSAL/r2ZAv9bxmD/nIj7xmKO6wZek2u3891U/ws?=
 =?us-ascii?Q?6QUQ+udCt1u+LR8XwikfOI7BMsD+kV1T3v7Av3zUQE+faHElRMFM4OXvtoBQ?=
 =?us-ascii?Q?28Cgg4t/cUnGwBdISUbkNS5vVAm/ya6PD4Pk+tQxecLxQZDBmhU9uIbQuzdY?=
 =?us-ascii?Q?77w1Y60Ktx4MRdvV+4bAhysepD2HkrrNj13VHXUIpSgMDeTzX2TTZY9tWW7D?=
 =?us-ascii?Q?uOpJ/9Z6BcWlPwcJJ5l2X8pHovq2OoBNFLVFrn9IGghaEf1no0oC6Xe1ZJWg?=
 =?us-ascii?Q?1jczVj7axnNfuRLnzpABe91L1u7T53CnRG1CRS5uu7JB60Egm+bqxo5whbIF?=
 =?us-ascii?Q?SVsq4fjBbHqR9d+rVDCOsFVtAbPtD5vu7PYmbY2iGZn5zXXt/dtDVHAc8Njh?=
 =?us-ascii?Q?OHlvUBsc+p+qNebK2XsCTGgRiYSJVxk+Mgk99Tj9bt3se5ebgDSU8H+VPmau?=
 =?us-ascii?Q?6kNgzo4cfXj9FjbJsDIvKs32fc7/PFSly+sz9UbvXclYo33cjfugazw7Mkdg?=
 =?us-ascii?Q?4u7qj9VYS9caPzK3YrQIypd93j4dYF2/970od7gBkpferdQezXe+3AD4m4Cr?=
 =?us-ascii?Q?HOZqx9PuDohNitZI7BjP7i/VygGS6gch5oHvh0nQ9nQK5u+H2j+m+Lv2qflV?=
 =?us-ascii?Q?jsnZYG8BKvgs+rxiCKU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6150da55-ad83-4b9f-5910-08db650ca1af
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2023 15:01:52.9514
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9+bKFdG2+lwIKqu5vDTwUVF08wqhvOzZS/JR66RUp4+Zh4SgRjFCAnmEp6tyEEP6USxV1mJBUmKJ+cTFPUTHKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7605
Subject: [virtio-dev] RE: [PATCH v3 2/3] transport-pci: Introduce legacy registers access
 commands



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Sunday, June 4, 2023 10:42 AM

> > > BTW all these may/must/should need to go into conformance section.
> > >
> > Conformance section for the AQ itself is missing. And I am aware to fix=
 it post
> your v13 series.
>=20
> Hmm missing where? It was supposed to be added here:
>
Conformance chapter doesn't have any links to aq requirements.

=20
> commit bf1d6b0d24ae899d08c7cf24ed480cf5881c49ef
> Author: Michael S. Tsirkin <mst@redhat.com>
> Date:   Sun Nov 20 19:43:45 2022 -0500
>=20
>     admin: conformance clauses
>=20
> what did I miss?
>=20
>=20
> > > Generally the way we structure the spec is an explanation of the
> > > theory of operation (mostly missing here)
> > >
> > It is not any different from v2.
> > Theory of operation is not going to describe the whole driver design.
> > It is not likely the scope like any other section.
> > Section "Legacy Interfaces: SR-IOV VFs Registers Access" has theory of
> operation described and also in commit log.
> >
> > This is like recent AQ patches and notification coalescing and more.
> >
> > So if can pin point what exactly you want to see in theory of operation=
, it will
> be helpful.
> > Because for one person, 10 lines of theory is enough like how we have m=
ost
> of the spec, another wants 100 lines with pseudo code in appendix.
>=20
> yes but I think this assumes a bit much. you start by saying there's no I=
O BAR.
> Okay, it's not even mandatory to give motivation, but can't hurt. The nex=
t step is
> you describe a bunch of commands. Presumably the reader will draw the
> conclusion that they replace an io bar?
> But it's implicit, and that is not good.
>=20
> So, I imagine we have a driver that translates legacy accesses to AQ comm=
ands,
> yes?=20
Yes.

> And it also somehow uses the extra command to get an address and then
> translates notifications to writes at that address? This kind of thing is=
 what I
> called a theory of operation.
>
=20
> A couple of paragraphs.
>
Yes, but I don't see such details for the AQ, notification coalescing.
These commands are not special.
Commands described "what" they do. "When and how" is not described in the s=
pec.
It is left to the driver to compose such things.

How Net device should use "queue reset" is not explained in theory of opera=
tion.
What is described is mechanics of queue reset steps...

Those details were put in the commit log, and not in the spec.
If you want to add theory of operation like nvme spec, we need to have dedi=
cated section.
I don't see a reason, why this should be the first patch set to do so in v4=
.

I am more than happy to add, but it can be done in generic way as follow up=
.
=20
>=20
>=20
> > > v2 had other issues so I missed this one.
> > >
> > > > But ok.
> > > >
> > > > No. It is not related to last command.
> > > > What does a PCI Device use BAR for?
> > >
> > > To reserve address space and know which addresses to claim.
> > >
> > > Generally if I heard "not use BAR0" I would assume that the meaning
> > > is that VF
> > > BAR0 in SRIOV expended capability should be 0. However, that affects
> > > all VFs and not just this VF so I don't really know what can it mean.
> > >
> > A PCI PF and VF device which wants to support legacy emulation should n=
ot
> expose BAR 0 in the struct virtio_pci_cap struct.
> > Instead it should use other BARs.
> >
> > > > As described in the spec, it uses the BAR in struct virtio_pci_cap
> > > > for exposing
> > > various things.
> > >
> > > Now I'm confused.
> > > So do you mean the \field{bar} in virtio_pci_cap or PCI BAR?
> > >
> > Yes.
> > > > So it means that PCI VF should use other than PCI BAR 0 for
> > > > various Virtio
> > > Structure PCI Capabilities that it exposes.
> > >
> > > I suspect you then want to say "should not expose to driver any
> > > structures inside it's BAR0"?
> > Instead of bisecting at structure level, it is indicated on usage so th=
at it doesn't
> need to bisect on "what about MSI-X".
>=20
> But what is the answer?
>
BAR 0 should not be used at all by the VF device for anything including MSI=
-X.

> > > And does this include this new command you are adding or not?
> > > It mentions bar too.  What about e.g. MSIX tables? Could there be
> > > other capabilities referring to a BAR?
> >
>=20
> ?
>=20
New command also should not report BAR 0.

> > > How does hypervisor know whether VF followed this rule (it's a
> > > should, not a hard rule after all)?
> > >
> > It is not a MUST.
> > Hypervisor software using this VF very easily know this when VF is atta=
ched to
> the hypervisor driver by reading the capability.
>=20
> which capability? E.g. there's a vendor specific capability we don't even=
 know
> what's in there. If you really want to save code in the hypervisor this "=
should" is
> pretty useless.
>=20
All the pci vendor capabilities for which all the code already exists.
It is not related to code saving.

Even those cap check is not needed.
Hypervisor driver needs to only check that BAR-0 is empty of not from the P=
CI layer.=20

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

