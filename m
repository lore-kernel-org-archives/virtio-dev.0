Return-Path: <virtio-dev-return-12064-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62EE7C77B61
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 15:20:24 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B979C2B151
	for <virtio-dev@archiver.kernel.org>; Fri,  7 Apr 2023 15:20:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by host09.ws5.connectedcommunity.org (Postfix) with QMQP
	id A75E23D8D4; Fri,  7 Apr 2023 15:20:23 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A66629865DA;
	Fri,  7 Apr 2023 15:18:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OUs4Osb2+kWCK6Q8vXBwXpPMYDKgv/d8TAE9ZjJHUFNWJ+DNlFhMtQlgvGop/Rl1KeRaDrVd2xjHUMiBnGrP3ObKif45ylQkwuLGqK27DAHPNdsCCWXxRV7PfD2/bOwI7+FARWrU/rYk3pCCSWBApEY9zfDzm9JlcXmA3sXW0HEPyg1V5tDUAAFSUEdph2Hx73CZK3oYCenutTOg/o2r5rLlPAoYdoSvpqsddyEZTjiC0p+6pwUEsS66BglN0aVVuDNrV6pXxzAI4diktEr3AQ6H/HYVFYn1EW6D8a7n2b63BqjdeF4UaaPoaQn4tgipBwKfZZckepMiEn8iVkomgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U65dHwDJ1sdSF9cCNffHo13O4m7NsGU9dWyUZUdKZVk=;
 b=gAmOPTvZeBJ933Nevn6LzTK5mcdGrILwh1doVb/1bRk4VFzGwIzNts8wSwgww53cjJ9RRWwYpX5ahYZsLQT08Bqy90ZDNewo510DBk6x+GbVGllKePK0TCCA3UmqBdkVaC83hliIf31lzTsSlAJhvKXhdoCS/EewqUzB9J6BWGi4RR9cliJZSmQZbyOgygSoAlxOIyLOqr7I6ycvoJmCOSzj2zOTtSf1bZM4yWFZt06LP6CurMFpL2+UJh7E4pEzueDMVqzwaZ7VmgNpFlyjZirhvDrhrHM0fKlqTB63H91Fu2UwjAA+EUhRkRJBnJnFNx1CV90JqgYmbQw4vO01qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>
Thread-Topic: [virtio-comment] Re: [PATCH 07/11] transport-pci: Introduce
 transitional MMR device id
Thread-Index: AQHZY1tHbf+nicr9uUaxzLNq1cXcgq8ax2UAgACRZQCABHJagIAALYOw
Date: Fri, 7 Apr 2023 15:18:47 +0000
Message-ID:
 <PH0PR12MB5481BF6222A169B898B6A5BEDC969@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-8-parav@nvidia.com>
 <20230404032700-mutt-send-email-mst@kernel.org>
 <94b217ee-29d9-42da-f2b8-28ced7e64371@nvidia.com>
 <20230407074605-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230407074605-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB8116:EE_
x-ms-office365-filtering-correlation-id: ed10a71d-55b1-4e96-a821-08db377b629c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 BxUg4CBa+Ye99DJjm+TAusBO7i7JDLDHZx6lDbnvvIyyDoFBHIDXGOOXMTfqm2jNrAEq4d695izyMt9kdTjGf7OzyHeSiTTBAlqOAo5lrswA9bSa7/mNprE7jqxglLcs8lFX7m3p0BSuq10G0cV/Qvx4Ao/IB4nyVPy2ydM68NbBShlVv+XgktugLk81vaQCwAnqEi/cZZNCP5VnstkB6aiOOC1GSYMkYsx6yIVDrc8bcr1tNm3v3oWxb7ttzMNhlxpxiVB1rV7PMBg66Wi7KU23QPPvhHOfPxwyKOnaKzGMArgoFtv7NJHuDSKIj93iV2h0KXBeIm4NuX6O24R5oLD+EYZdxW3E+4+vD4WxNKmmnJzPXyI9r5ezNFfebZVsBkcK94ZMgem1SlDWSasZE2Ts49cxHW/hBTFVtavTeTJvMw+TJa0aC3uJ7nWb2QKQJM6guYBpE//nyFBakqNmIfdxouye9AZnIbmBrAHmtLurijZeRfjsNn8P9XMmnWg2P5kbeNfUjplXK34vx7F7vUVQSeiEvAChN1kMDbxTJK4s3zpdiUX5cl6GVXb/PkWoy7KctTaoRbv5AunIufuEB9aRAoH7ThvZ5nEKmAnCsyBVdzsyqFvITeLgqNfe4Pnl
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199021)(26005)(38070700005)(86362001)(122000001)(33656002)(71200400001)(38100700002)(2906002)(478600001)(6506007)(9686003)(8936002)(316002)(5660300002)(54906003)(52536014)(66899021)(41300700001)(186003)(66446008)(4326008)(66946007)(64756008)(66556008)(66476007)(76116006)(7696005)(55016003)(8676002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?PR6GDXBw1RIGo48O0eSHlMbe3G6hbfA3dQqFz757kbg0cI0zFP416S9CYbsw?=
 =?us-ascii?Q?RYbZCZk+k3H+oGWPK1iehq2dPRFbrUmPuiaWPeu0QCIhpNmCAHmuNPe5ofq3?=
 =?us-ascii?Q?bQSZsars5hkkdQSmF66vFAm9bMYZ2gO0uThOxbL3hxyde2e4UokdHr8l64zV?=
 =?us-ascii?Q?egBa7Vs6T6AASXHxK7zw7J+PJdCWk2gNCOxlKnNAYC59QlEKqOnrym+urRdH?=
 =?us-ascii?Q?ScHF6r0IXsUMAUCgPouJBfiZXdc9ExU1XqKIwFjzmmrkiSLt9AhBs7I05BjO?=
 =?us-ascii?Q?ldhLJhS6mgmFwD8E/KI/FtUhAsbwBnZcaecK5uYVOxkHWwCE5kE46eemNtXB?=
 =?us-ascii?Q?If/5mkYnPfOGDfrzEe4SMEeI9dsbhjKOoscv00VZ+lMkNcJ0I91Anw/RR9M7?=
 =?us-ascii?Q?PsSG+z0sLMhlOIbtLTGJ2qqyok2AXhmrm/v7klrY1tJdERT80lo5wvkJpEmn?=
 =?us-ascii?Q?PYHTZ9byv+02RqyRgag3ayjL40RcIl2Ok6gMZOMUeGJyrMcyK7Eer2IA2og9?=
 =?us-ascii?Q?yJObf/rvWpl7StiXlQDdsbzJDgahVAMRk3dBSzG1NDa8Azlgd26GNr/+x8dY?=
 =?us-ascii?Q?juE1zw9AZ+xuXkdmwIQCBf5nhU6ASRZcy6YNvgaAUZvUJUUFl/xAP233bGa2?=
 =?us-ascii?Q?ZsvA11K0xpcDCBu38JyNwmVDQZ0ZR9vSBDexYFKadZAPmHYlTwpcd1lugFgu?=
 =?us-ascii?Q?0H2wd8J43MX/RA9O0B7gBtFMM9n2MAu65NGBWWuM8FTecQ37uSDbWE4mMryz?=
 =?us-ascii?Q?NZwtx5t2qgXGf83iqzSI78s8sfbfH/wvRvUXcIkScoXV0rvhNl748ESQimY/?=
 =?us-ascii?Q?HcBVrpWkrBiEvrGVE9L5W2nhtF+b93fjIIR22CucBTwA/89cLzMN+DVO5n2U?=
 =?us-ascii?Q?Z5bI03LQsCRzJp4CLTeIoIa2HKplWRQl62/vXU6qpB2PUU4Y+Bktjy3EJvpw?=
 =?us-ascii?Q?RHL7onsqb654IAqYFHKVSpVwJ2jplmUyxzgNsZcVayWf0wwVwijw7qWdYlJ2?=
 =?us-ascii?Q?jIUgQlfrY0iu/vkbNtc+ESte5QNrcICMMFg4BoAHgG4Ng4yECkKDyr0u92HZ?=
 =?us-ascii?Q?HVNKYSibNPC//ghT++MFepA1EcYzI2/BKaNLaj6eefPBcRb5ahS+0yKgQ+CS?=
 =?us-ascii?Q?PBUp2z9baJ8v9w/E+5i2vhYH5/VKpGnKgEpi13H468FbKKjr3EOwEopbjDtV?=
 =?us-ascii?Q?jArTaQhPv2gD30A4Qjt72A55EOUtx/QksSivbzDgk6kEacNEzNPHMtuA3/2s?=
 =?us-ascii?Q?HPiyk4Vlr5k06SQEHrKAa2Ph1uBkZA+nInTbg1QpUwGQGjwn2mC+yZem1iIn?=
 =?us-ascii?Q?LJN4+RMsa3rmUdMLS3udyPdgkBrH9e7jWC86nO2+3noljdaLH/ErPAOBVR5m?=
 =?us-ascii?Q?3+pOIML3cqLnMxxvS/2ZOEm7wbKmJuQqK7H6wzp3CATw0IcBbA1MQ/MZsmDQ?=
 =?us-ascii?Q?GYFoCQchc9VvCFAoKdVqVkUjkCqJI7+EFvFp+wdhuqWyFkfEYjeUso2K2/5M?=
 =?us-ascii?Q?4jUW1qQ5XCPOY3n3aqWcab+CVVqVZhZtdqV3yKW3OF62YaZytjj/xL/V1xFr?=
 =?us-ascii?Q?fi9tzV8+cD2Z6X/Ua2A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed10a71d-55b1-4e96-a821-08db377b629c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2023 15:18:47.7814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sTlwP0FPGh6Cq6LrvafOV2rSZ22TwGyGVctzDAIe2fhlNUUu+3+NMd+hg6wvdhzTH2NH/X9cuVmxxdBDJGoLXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8116
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 07/11] transport-pci: Introduce
 transitional MMR device id


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Friday, April 7, 2023 8:03 AM
>=20
> On Tue, Apr 04, 2023 at 12:08:54PM -0400, Parav Pandit wrote:

[..]
> > > I took a fresh look at it, and I don't get it: what exactly is wrong
> > > with just using modern ID? Why do we need new ones?
> >
> > A modern (non transitional device) do not support legacy functionality
> > such as virtio net hdr,
>=20
> It's all a question of terminology, but it is not worth sacrificing funct=
ionality for
> cleaner terminology.
> Basically most of the spec just talks about the legacy interface, and wil=
l work
> fine with this.
>=20
> Yes we do say:
> Devices or drivers with no legacy compatibility are referred to as non-
> transitional devices and drivers, respectively.
>=20
>=20
> So we will want to refine this somewhat. Maybe:
>=20
> 	Devices not compatible with legacy drivers and drivers not compatible
> 	with legacy devices are referred to as non-transitional devices and
> 	drivers, respectively.
>=20
>=20
> This allows non-transitional devices to expose the legacy capability - ha=
ving this
> capability does not make them compatible with
>=20
> Similarly in the conformance section:
>=20
> An implementation MAY choose to implement OPTIONAL support for the
> legacy interface, including support for legacy drivers or devices, by con=
forming
> to all of the MUST or REQUIRED level requirements for the legacy interfac=
e for
> the transitional devices and drivers.
>=20
> we would just remove "for the transitional devices and drivers"
> here as now non-transitional can have a legacy interface.
>=20
> Similarly:
>=20
> The requirements for the legacy interface for transitional implementation=
s
>=20
> would become:
>=20
> "The requirements for the legacy interface"
>=20
>
I will hold to respond to other emails in this series, because the key part=
 is here.

If I understand you correctly, will above wording translate to below behavi=
or?

1. A non-transitional device will expose a capability (not a feature bit, b=
ut a capability at transport level).
This capability indicates that, it supports legacy interface.
Lets name it legacy_if_emulation for sake of this discussion.
It is a two-way pci capability.
Device reports it.
And driver enables it. (Why two way and why driver needs to enable it, desc=
ribed later in point #d below).

Hence, such non transitional device does not need to comply to below listed=
 requirements #a and #b.

a. A driver MUST accept VIRTIO_F_VERSION_1 if it is offered.
(Because hypervisor driver is a passthrough driver; and legacy driver will =
not accept this feature bit).

b. device MAY fail to operate further if VIRTIO_F_VERSION_1 is not accepted=
.

c. A non-transitional device with above legacy_if_supported capability, wil=
l allow device reset sequence, described in
[1] Driver Requirements: Device Initialization (3.1.1)
[2] Legacy Interface: Device Initialization (3.1.2)

> > device reset sequence.
>=20
> what is this one?

I listed above in #c.
And=20

d. When legacy_if_emulation capability is offered and hypervisor driver ena=
bled it, when driver perform device reset, driver will not wait for device =
reset to go zero.
When legacy_if_emulation capability is not enabled by (hypervisor or other =
say existing) driver, driver will wait for device reset to turn 0. (Followi=
ng the driver requirement 2.4.2).

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

