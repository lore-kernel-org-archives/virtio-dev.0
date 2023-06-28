Return-Path: <virtio-dev-return-13123-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83E38EB64D7
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 15:06:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E4F987C675
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 15:06:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CE4DD98658B
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 15:06:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BE2BA986585; Wed, 28 Jun 2023 15:06:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A922D986587;
	Wed, 28 Jun 2023 15:06:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9SzooURnP03Xa8An91EzVbVd1aQNm5fre4HMRgJfO4/UmYALePhhLW2TEwV5QqOpkZieLOJBsdLAJfjCrOCrVxmVOGwd24xMhaRrgzrKcS0p06+2jCX+49InDu/Ex+wCm2LWMqLFMZLM9xCEpAAztffSENOlHX3xMTuS3PLj6rlOv8ZACYww94V3/ZZMfxO2E8tSzF29e0yZ8oOE4YeVxmZewxGQlb9s8YNA+TFi7LDD10A+Zhxd6pwxhpEwu4pkLfD6NUu3ezvsEZKNDkp+BacjWOhOj205eK5iyC4hIDYtGY0H2lcVv3DVcb6f5XN3SRuMXC4lYlNg6buwAncjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miLsIphD1Xh7OFZ6PSPSVy6MpY4pGy+Uvkno7LfhX6g=;
 b=Q/5rtuLMa60N9QiDQvZeE9Mmx4GD97/bjSjVpt68mK+nUa76gsvw0Yc7I5BJ+kF8sK63WEa/lIVSfgNQtDyC8z/e9vNQybW+dDooAhgbF/KvHRmB+7by3vQPzQWekXHWowIZX6qffbbPExg9A4ARRSjmN35Dq5vpg8fbXqH6mMVQiQXSmW0Tutj8IETwAHSgzDvQH7upvLzp8tYNjDgoUl1J6y8X9C9tbgw07QW20x0QsPV+oUClbdpjcZ7u9RPw0bstZl0inZcs5ERwyC3UbE9ANF2BcpuYmx82LIeg3m0cmAZeKBvMMUyfdoWb+HTfX7M9r2vhfyItuoNT8n/JRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Michael S. Tsirkin"
	<mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>, "Zhu, Lingshan" <lingshan.zhu@intel.com>
Thread-Topic: [virtio-comment] [RFC PATCH] admin-queue: bind the group member
 to the device
Thread-Index: AQHZp/aO4VG7c5VX5U2HGCV+HZ1m26+eUUOAgACAaoCAAKzGAIAA1Ksw
Date: Wed, 28 Jun 2023 15:06:03 +0000
Message-ID:
 <PH0PR12MB54814CC1CB1E5D2B5AEBFCD3DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230626062210.49020-1-xuanzhuo@linux.alibaba.com>
 <1687854185.3344731-3-xuanzhuo@linux.alibaba.com>
 <20230627115247-mutt-send-email-mst@kernel.org>
 <1687918864.3728812-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1687918864.3728812-2-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY5PR12MB6274:EE_
x-ms-office365-filtering-correlation-id: 3e9c96ce-db79-4464-5804-08db77e930d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 z05OjwzqW/FlPjyG1qVVmKm1Odd8zT37OeLwSlPkgYxXoGgNPNz316/Pd1Y50TTLeJc6mBSt5KLh6OL85lli50yBYUe+5n0kN7OyfF15LILEJZfHZR9Y62fOXXqSISNk6In16P0uqTCrHnZKRi4uVELROmLUQXPCSDpvh1AKjeMLhsSzI4Hw9IswuDgZlOZCNUqtwnxHEqI3sGYmUpayxB5kuMVy4Mb7YFr1/tbJJdUAtjDSHgZetDYi+rdWUoRtTXgfoQB7bS4ZUtReZhDXkMetr+1l/d3+8aeOp0A5AgEeBGI5hz+TJ4eK50v71kV8ASrmSnmsnvI85tDyR2WhdN6UDKOYKn3nl+S5Es9ks1atYciJe8kkk0b8369wAKbUjq+WGBCSYCbQQ7zpMHgUZLQxN28v55sQSzaMYDEVPtn6UuaIQXJR1pO08Hlf47ThIbru5rz5MWa/354lQjl5EFIlgxLhe8RGfdiKscVZDnL6knkFSMKgm9w+Cc8NdhyQH5sWnTX5CvJoveFnvvt0YghUUiJzX4rwW1DRdTbRv8MXSWdDeOjHvu9J8bi8j3B+l4I9CajvsyNv77y5GDoyzgNbFBt+uF9tBxL8EVY8WHHqrPNI1mfqFCVwbNO0ZpqL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(366004)(396003)(376002)(451199021)(66446008)(38070700005)(26005)(66556008)(66476007)(122000001)(5660300002)(52536014)(86362001)(33656002)(8936002)(41300700001)(4326008)(316002)(8676002)(66946007)(55016003)(64756008)(76116006)(38100700002)(110136005)(6506007)(9686003)(186003)(2906002)(71200400001)(83380400001)(54906003)(7696005)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ndE1BzksNaAV0uisu2KdRdLxASUijfRnEJKg1dNPLzCEqx9+ClsXcew+HkCp?=
 =?us-ascii?Q?I98Xmt20knMsqlVqzcwmcXQj4TYNq6+vK7n1FMl1idvvKsHBSlkcX6tT4LgN?=
 =?us-ascii?Q?Qqd0NdOUUA2k9KZmULkfK/jA3HXUmivdepueUWZGd20m9fQWzIAEtSfklLms?=
 =?us-ascii?Q?diLBlACPHBt0cSF+YnyjVIQ5hRM5PKvO9Zt2ax5xdeXahXUlz2vQkBYH0B4S?=
 =?us-ascii?Q?11roUJUgBkXtmpEdT8hC8k6vWaybqnwlJahQnjmbriGuINsimCciCvp7F/Zb?=
 =?us-ascii?Q?YKo8ox+Zg8k5lApEnysX/DyahDGws5h240dH+3Azv+60jREAyNRD3zBderkX?=
 =?us-ascii?Q?g10s/CGzn1ksy0WXNaIWs9Ccauqf0NZIBQOPiYXjsHe/xcKZpGDEZt5o7Z1D?=
 =?us-ascii?Q?7pqGrjVtDyIc9nitg2sENMhjW7eBeGW01EgSCB2E856PvANmiIcv+nY+KfyX?=
 =?us-ascii?Q?0g0qOewoJDlnH8vdKyQUEi8TirH/9CFHcsyvEV+f8by6RmUIHGqx/JlMaK8g?=
 =?us-ascii?Q?pcB+Y17/J/qrLFEk3+b6bAdagJQaNOq04kdXmGtJf1kIrb1U8AL8AEljcCUD?=
 =?us-ascii?Q?/t5A37YOy4+NZ+Sc7qGvOXNcDsuMaW2/q3w6KrbpH/OSvBihkXGIrkrcPhZf?=
 =?us-ascii?Q?o2KsTDRo1ceLwTIWT+oPlieyJIJOJ2DIPP/rH8AB2MQRBL0Qi3gxHmYmmFOb?=
 =?us-ascii?Q?9MTX7gL+TudMn5FngUbv5ExXrij8ba9PKfRayVfzkM2OLLFjB71qUKBXA7fp?=
 =?us-ascii?Q?Ue4QtGADQDe30rw0pxGC76qMUGG+WWuWpxjAuEBSS2BqZdWtvOkn815n/vPz?=
 =?us-ascii?Q?73rq2fkO65Na7oUZbgUOLPKQh0SIqTPfALBFXTnTIIx9GoeO4uY3XLwnnwoy?=
 =?us-ascii?Q?Gw/vA7iCyCxON4nc4vD0lHxmwB51KVN0+7qJ+03LF+OVhBJiJl9Kh2yKn/GU?=
 =?us-ascii?Q?49Y2w/mM2royeiub805LguG/5H2we8q9N1a5Mr7sxpLx4xAXYJrK7oNDyeRn?=
 =?us-ascii?Q?hWsb313RDGp6+URJNIwlU686r9qX/Q2M1Egkfq/CI2HuO1JYnF6oJNj6qJ59?=
 =?us-ascii?Q?B/I6x2QstnhbGQRZyG6J54Jtjaw+0Vo7skV6TEJ91ogXHpQN0ZC4CUQuEmNs?=
 =?us-ascii?Q?zJjeaPNgwdEe6zlplMvXRVL3cXHWDsWLusRoIR8akOrTn1whaQn7WI2KLVE5?=
 =?us-ascii?Q?VPWwWT5CsYXEcNXZk0Bz00ctymevm6qr/4RXotCNF45BKvebfcD1Mz82Jw3j?=
 =?us-ascii?Q?j2FbYJkuq9rGvKKRKdfDJlNVVOgKgoHlD8VVbgEpgvEZYyZ+pTBmZBAgBIRr?=
 =?us-ascii?Q?mWRlsvP423Kj/OUljqJ4mAxoU8i/B9jbVjoSFm3emRTE/uGWXNgLzUxfMLw1?=
 =?us-ascii?Q?VuxU0ACJeoz/5ef9+eWl67CdFeeQ6PgyTT42ITiwuKbovHVl4oY1x00uJ6va?=
 =?us-ascii?Q?79t29GAvLYQvKoJ167PBos7k7Sr8VjNM/DrlNncLEnAN9Maf88QR1sIeuMDr?=
 =?us-ascii?Q?Gxga4Jr+hIYhoEFHQQgPvdi57q7ViYW5uD/TfBgvdXOMk0zIDY5SGAylis/S?=
 =?us-ascii?Q?FPpp4CapKa3rZtQJUAs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9c96ce-db79-4464-5804-08db77e930d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 15:06:03.3144
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t3nKGEoIpP1e4ZnX5jJe8u5LriWarazL/JN+RDQXZgCsBbTmso6YJcRNAJ5jFM7Sbf4Jm5d/DTbretEgWlKoLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6274
Subject: [virtio-dev] RE: [virtio-comment] [RFC PATCH] admin-queue: bind the group member
 to the device



> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Tuesday, June 27, 2023 10:21 PM

> > I can see this making sense as a feature bit that says VFs are not
> > initialized by default and must first be setup through an admin command=
.
> > This will likely need to be a feature bit because it's changing
> > behaviour outside of admin commands.
> >
> > Then, we can have:
> >
> > 	ADMIN_SETUP VF#
> > 	ADMIN_CLEANUP VF#
> >
> > I like this because this generalizes CREATE/DESTROY that SIOV guys prop=
osed.
>=20

What does this command actually do or expected do on the device?

> Great!!
>=20
> >
> >
> > Why do we need an id as a level of indirection though? What is wrong
> > with just using VF# directly?
>=20
> I think VF# is ok. I also need to use it. But we need an ID for virtio de=
vice not the
> transport(PF, VF).
>=20
> What I want to emphasize is that PCI(pf or vf) is a transport, it is only=
 used to
> connect the virtio driver and the virtio device. Right?
>=20
> The virtio device does not necessarily exist depending on PCI. For exampl=
e, a
> virtio device is migrated from another DPU, and it is not associated with=
 any PCI.
> What I have always wanted to say is that this device(not PCI) must have i=
ts own
> ID, which has nothing to do with the transport.
>=20
A virtio device can have the id visible to self and visible to group owner =
device.

> Now we want to use this migrated device and connect it to the correspondi=
ng
> vm (migrated from the same host). We can passthrough vf to this vm. But h=
ow
> do I tell our DPU to bind this migrated device with this vf?

When a virtio device state is set on a specific VF on the compute side (not=
 on the dpu side),
This directly indicates to the dpu side, which virtio device is attached to=
 which VF.

> We can specify the VF by the VF#, but how can we specify the virtio devic=
e?
> Maybe there are two migrated virtio device.
>
 virtio device state setting itself will contain the device identifier.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

