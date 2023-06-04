Return-Path: <virtio-dev-return-12853-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7489FC7EE2D
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 15:07:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9F6CEF3F56
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 15:07:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8EE61986337
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 15:07:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 811F29862DD; Sun,  4 Jun 2023 15:07:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6B5E89862D0;
	Sun,  4 Jun 2023 15:07:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiLR+bByTiy9XK5wO+5ZKqpYQLg3mDxGOv/ypGPFtC8dn16FrC8zXNa8WmfjBjyuHhH/Gtd6Rko8IPdOhlmrirtGZ+OrQIImqNMjjSYez30MZt3EkPgmsFJNLlt29dghhNXu99nLK5FK4OkKGz/p9406awNsU3Pw7FyZ/M+ndAQkipSf3TozTdyjjVIg25iDdw2UT11RhzjsTCYD0VH3ek/Ckp8y16Gs9bqxAtFAXSwVPRC0v1VrNSTb/lDJ4ZMoYX/9CuEtPH4wTFZ6wwqHaPk7Rzv02xAqOmeekuJ/ahy/vLOdaJR3IYF+lKc0794uQ+pZndSvl7bHOaFnVnZxcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bK1exW9+HU9Pbkd3d5+GcQZmof7+rGoOBWUcYLQFUqg=;
 b=cCZVB3UwwTrjvVPSoXG51LmbJYEjYXj4UT+b+ken8Uk4HRZipW6glQVyrZ8t+VTzza9PvbgnVd56VOai+egCqyKh2TzrDGCRZXcKDtMU6+6c/VBn1BuxCLB07fPBxVV5JOsOVbGJ0A9FAFDi/pDwPmX7sIiuiOl/CXRnMVqnUIedrLPfYZDfy6kyKeOp336y3PWPWjM3S6W4EsFO+rVRYhtQzUsMeW7F+99lDrVE4gDGZUc0qz2sbVWIcwkxGO0v7ISt+YDgmq1dvL9EL5IDa3SavYYAOiv9ExRcfLpRRnRIDXjxoP7/uTEV+0fJW2x7GCs4GsAvZWiNpUZX8z5Dqw==
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
Thread-Topic: [PATCH v3 0/3] transport-pci: Introduce legacy registers access
 using AQ
Thread-Index:
 AQHZlZHqSKW+Shm580CRlUjcCTH7qK96p2iAgAAAjkCAAAV4gIAAAhyAgAAFe4CAAALHYIAABcIAgAAChLA=
Date: Sun, 4 Jun 2023 15:07:27 +0000
Message-ID:
 <PH0PR12MB5481B721C34D85D63FCC1F3DDC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230602203604.627661-1-parav@nvidia.com>
 <20230604092441-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815C9677C9E1F3EDE032A9DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604094535-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481443CD383D9BFA0369151DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604101351-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548139ACEC00E7CA6D988182DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604105027-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230604105027-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW4PR12MB6827:EE_
x-ms-office365-filtering-correlation-id: 895aa1eb-d1bd-461f-4d64-08db650d6925
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Vln6vxv9U918QhaCgzNMINBZoTi2r8K+A2sO/fRh9a7yfytsSOoAwaSw9ogpKSKS1hb0V60YcCJ/N1G1Oy1LL3fzL40dW3/nLy0INy4hTtAKWW4d3HHbxhUU1IGxZLlksxrgqFX1oMMzYXjWbMQjz/1bTx3mfI4OEuR1rWIMeEz1w/QttIwpKtuj09OsBnWgQjdtmeblyZMqoc+x3Nrj5YU02bget3xcC2t56LipW+MIEKlQhg/845B5sqqHDowL2ugNAHTDkJrdUwUwNW9hHKi5yh7Q0J4c2JjHIGP9HNBeM1a2LpODvvPROabe/tFH0ZUef5ZH4NgPhA7zr0F51YjxoF2HmFouLwzkP4ZxajF5WkLNSveTEYprYmRdNjlVgfKk+Q8nDW/qw+6ZiI5Dtjd/DpxGqqBhtGGqqr9ggs9/MP/dwJQPHUETl8JMIoZJ06/u6MtNe8sBbqCRsUXCSfVRUD/BS/zv6DmmwKCGlx0//ZmfTsbAJfN0n7hkbri8eSXyNuTLGp01LLgs97klczSAvrNPRAJThlrM8YpNcGs6YwkUzNtHYqe5uH8S/D8YR3H4De5oFS+mrUgV3UDr2SHsEDCgEhspNyM9F8qirOnhSKWbZzXbfCyiaRDhT+pd
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199021)(107886003)(186003)(26005)(9686003)(6506007)(83380400001)(38100700002)(122000001)(86362001)(33656002)(38070700005)(55016003)(52536014)(54906003)(5660300002)(2906002)(316002)(478600001)(41300700001)(8676002)(4326008)(8936002)(66556008)(66476007)(66446008)(66946007)(64756008)(6916009)(76116006)(71200400001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/6J4F7r0C8E4Q+jDbbuUvCYpQKBaxCnoRMyGjJMNAfdT6et3wBw/4qJjvK3V?=
 =?us-ascii?Q?rDJaSkyyNZdAjmKXOpfY1Rxh4WgqWTO1yuEytNHvHrq3sveYOkt4EBdaEB1v?=
 =?us-ascii?Q?J7LAsxiCEZkEBCYX0SUsujkxVHbWy9QtpDoFVTiHjwgBlPa5Ci+jJwGziY/D?=
 =?us-ascii?Q?bM3wwer/sirRt6EJm7dFfuFXIVP/ad/j2idLW53Hf/z64H8Vt99V5ksx830X?=
 =?us-ascii?Q?pqkvXLg2HCCPg8X2o+Lf/fRMK4Xy8AT38jE8+lqsSN2RCoCqpKthfTSp8fng?=
 =?us-ascii?Q?n8PMd9dd0ZnEnHSZ4ujX96h0TH4B3c82Wt9YfWVBriqvOkNs3EmSDU+BMcXg?=
 =?us-ascii?Q?ZyFRcqRGvt71cnSKqTaf1ssczI5gVktDvtgXnIOkHuvMemvaRUjCVTTVN04p?=
 =?us-ascii?Q?MGuHxKMhGB0e3wxHzr3ZKKtlVTCSd8MfRhyoWvtE4p/YiSUXKB2J73ixjX9z?=
 =?us-ascii?Q?CRDuqcKdbxGug/qCAFbmSTKsyNsQ3wCMLug6KoXFirMwXwseegZMSR/Sv2VU?=
 =?us-ascii?Q?NhlgJKKoeV06w8yb//V3yB0rYz33LpSK51pfgUlM7biKFcpjUDcNDBEDD8s7?=
 =?us-ascii?Q?Yy6hLq+FL4iMw3G4uA2VsH4k4iy/wZdZ1kNcY4ASqVnFoZ6y0hjvx6YU8EN2?=
 =?us-ascii?Q?w02/yQHaSdd3Bq65z3fyOGJ2pKoRkoXqMx0DPkH3u19UZ0313nJNcdMuwbb1?=
 =?us-ascii?Q?bcQ4/bCXanpoPxdXSTFjZMXTBhTcCmkV+TLKhgMRMoOsDtOFaiSDs1hZPPSz?=
 =?us-ascii?Q?n9jIx50gZUl3xP8CiulaWOiwgo+PE3I6tIxzEYwL/cpgoaegbY7JWb8BjkWe?=
 =?us-ascii?Q?Oe6lsumk8+yf6Xo0HvLTM/5lWWAyk0SXAITU2/t/wFsKda8Yj3mV63DfBZI6?=
 =?us-ascii?Q?YdcKtBlLR3zLjm99HminXiq4StnCbY/q83F/PzHQcf6nTbsBWc/1MxFXOG89?=
 =?us-ascii?Q?2e9sMqnGJM+oK3hVMSzFrHioc6+V33XmPSlFrOKbEFEDinn3jA6HSt+pA8vJ?=
 =?us-ascii?Q?Tmw2d6VZ5Zyl/bws0tKuRldc2Ks4REQmuGQzTRM6sTpsUseUt/azks3bCYU2?=
 =?us-ascii?Q?DN55hJMYkRgtvCHYMAiAsyywhHORc4dVozA+RCtTapfy0oXeJYEULLZMWwuk?=
 =?us-ascii?Q?4XFd10ONGrLMHuphCRoLYt0deWZkXDY6p12FU+vpGUJPgRd+6pjTlFPWsejy?=
 =?us-ascii?Q?IYHo9b8pYnPAduytldIhm+K3nx9s+aRNayHhTC/awme0rSGCalstYvRdlmNT?=
 =?us-ascii?Q?57OyxtWw/tcONJY6qGM2hyR7N4Yca/GmtbJEZwh5mqljSaI5/XIVu+HXAPk6?=
 =?us-ascii?Q?esZ7fP05DwNsMsarxX9xKBqKpeOFewdEf1B2cxb59S0dSV2a93eZi1evSod9?=
 =?us-ascii?Q?2sjsbzkk+RHrgjWd2pKw7WXC2rz9hdABGMvZEciNp/Zzfx67K6BzGwzrgvhz?=
 =?us-ascii?Q?PXj0ZoBNwAX+Y1f93WzmQDvti7LoDVvwZPATE0zIbQWl0q4sZc8w/SK8vSv2?=
 =?us-ascii?Q?gFJTJpLdwwylpQ50mSvnWKEFA7TxvWboRxpYk0xVkvpvfiN3PjsK0VOiVcnI?=
 =?us-ascii?Q?0HyDBRPBAiTMs7ZLh5g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 895aa1eb-d1bd-461f-4d64-08db650d6925
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2023 15:07:27.5738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7MLZKqzJvR+Mkvs1m1ljGRfDhSX3VvRfufidYnqSB1M5kO2PS1qUvw8ph7TqVcDTdWpNkMpQKkIjV1AzZR86RA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6827
Subject: [virtio-dev] RE: [PATCH v3 0/3] transport-pci: Introduce legacy registers access
 using AQ



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Sunday, June 4, 2023 10:54 AM

> > Each VF has its own available buffer notification in hardware like 1.x.
> > We do not want to duplicate (and add) such functionality on the PF BAR
> hardware when it already exists on the VF.
>=20
> yes but here we are talking about legacy notifications, not 1.x
>
Legacy can utilize the 1.x hw plumbing without building new hypothetical PF=
 hardware.
=20
> > > We are talking about an interface that will be used tens of years
> > > from now. If the interface is awkward to use on some platforms let's
> > > make it easier not hide behind excuses of no demand to fix it as of l=
ast
> Friday.
> > It is not hiding.
> > The fact that virtio drivers are not inbox. I don't see an actual user =
by the OS
> vendor for the decade passed.
>=20
> But why does it matter? There are a bunch of users of virtio, I know that=
.
>=20
> > And, I do not anticipate use of legacy for tens of years from now.
> >
> > It is not even a conclusion that it is awkward to use.
> > You are concluding that one OS may never want to evolve their kernel AP=
Is.
>=20
> They might. That takes many years too.
>
By that time legacy may not be even a use case for them.
If an OS vendor evolves slowly compare to other two OS, such OS may have to=
 change their process, not the virtio-spec.

> > So, when a 2nd OS vendor cannot use IPR scheme that they have, and they
> MUST have everything through ONLY VF, to support them, a HW vendor will
> build PCI device with VF legacy access registers stay in the VF.
> > And spec update will be done.
> >
> > We really don't see this happening. So better to build a practical spec=
.
> >
> > And if this was important, I am still puzzled why you say "Just AQ is f=
ine" in v2
> and why you wait for next 2 weeks for v3 to show up to raise the concern =
now
> contradicting your ACK.
>=20
> Because this is just AQ. All I am asking is that the BAR refers to PF, sa=
me AQ
> command.

VF has BAR for driver notifications. This BAR is used for 1.x and legacy.
There is no need to ask vendors to build new HW to put driver notifications=
 on the PF BAR for VFs, when it already exists on the VF.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

