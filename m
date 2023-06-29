Return-Path: <virtio-dev-return-13168-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF60EB64DD
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 21:50:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A8BC12A892
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 21:50:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 945D69866F1
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 21:50:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 829AA986677; Thu, 29 Jun 2023 21:50:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6D26598667F;
	Thu, 29 Jun 2023 21:50:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H7/4jTK7hsY7iejkKYmpeKh4ZtsoaVOPuqIfMBFCfcKgKpTU9pyv5FxHcmLTGxbY93Nwnig20sc279CtWY+CnG3jU9HRKjZtlDuUOl+pds3xGiPnhtY5lisBmGnbKs8fu7289c+TSAkzP0URSqSRqdJFjIsakPKBGm8qIWqOoEw91+uHNAYxeVq53Xy2CY0Lws8aoNZU/hShtqDvLe8jV6wvAi5BI4BzhN4EY/HCNDbZyxzwihOBIj/vI4Os/dNN5THmK8YrogKbNkra9OIKYIS3zXOLbxq877YjttbAY4ctICIwSTFOc16dn+97gaIPp+Wzpi+9DUWWa7P5FlmCXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hzx8FT82U73NeMGIpbLrKl2WPHb4qmoiOnYXIf0nTO8=;
 b=h9q5WrpWzGS7KP0BBAwyd9Bz05aM+jbzdQ2eWLU5aHsu2pMUIJ6WtbaCb33PbcZqio5arVUcxb0NiI1kFRAqRm3fnTlFQePYhEXhQUOwCChVojqSpnP/F56nYnHO3dfK/wHxrQmZfPRa6tQe47nJkgMYOm/0xBc+77+IYSYJHZY4IMROBhfRzy358RwXnSWDSZgCFh12b443GdMh4qORdVr2X39Y9bCCxp49VPo5T6TWTXIdy1rvS/RqOvhAstovx6co/PJYNppovPSMPNP3l0ugsN+Z9hEuhcvxkGmbmInupmfxMUOWIWByBmG+kL/J8YimSqY5rWzR95eBLBuYpQ==
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
Thread-Topic: [PATCH v7 3/4] admin: Add group member legacy register access
 commands
Thread-Index: AQHZqTvrGu2WS2SUoUu7prURQx0ADa+iM1gAgAAbrdCAAASiAIAAAHOg
Date: Thu, 29 Jun 2023 21:50:45 +0000
Message-ID:
 <PH0PR12MB548102851D796A39FEC61275DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230627211050.1527507-1-parav@nvidia.com>
 <20230627211050.1527507-4-parav@nvidia.com>
 <20230629154634-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481E7610F4941C615617CA0DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230629174443-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230629174443-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL1PR12MB5897:EE_
x-ms-office365-filtering-correlation-id: 650cb83a-a5e8-47c8-1754-08db78eae44e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IAM2S7GuZ5t2q50NkemhUjlZ1EBiOD5Mvrl+q/msp9qTBei2JlCg2Qt11o+m1HC/2nFXQqMJU1FxDVt9dpQMcHuEb/qKs5mKMKy9rbF4WQS2nzvslb7BuvhKTkaWa3KNvoH67ocOmOmBQccEs6FJlxNU/eltTtQPvcZa8FYM3n+NREWYtWCHdM/zhVcS2/Hjtw/zq5nKq6EOzPFjJZSjltxaSywLxT8wzQ6Sg/G6wA5Hc5a6sA+xKpSdQTk/AZhQXZ1MWMRTSCkN8objoKymF8Vsf9xP60YH4pNpGdNCiw1Jy1x0CcEe3Sjw7RMBGyYPnyvNsG4cLko3KhcKNrFWINRdIpsQpj1nbxsapsItTVKiNT8VevaDsAHVBXpkoD8DwYrqXHVXfvsoLAclDNcphXKqYhv0UfBhKTtqdLRlEJq+BiKbbqinEtZ4j2HRFLq/468daHd3kSxk1oh9hH/ks05xJ/xq0oe7yd4xsXS/TUapIHMCJiOAmQiFfqKQL05IYfZ0n71gnazuLmrPTXVRfWd44mySzbmtnAlC9YF5h1wEyUuhBMOk8TELkK0wLHT8iW3maoiBu6aMrGaJQSi3T3XxBfBdFbhAMjBq+Qwnha8UkgZU/I0peq8b/Gbri1RS
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(396003)(136003)(366004)(376002)(451199021)(41300700001)(4744005)(2906002)(7696005)(9686003)(71200400001)(38100700002)(107886003)(122000001)(6506007)(26005)(186003)(55016003)(86362001)(54906003)(38070700005)(478600001)(4326008)(316002)(66946007)(66446008)(33656002)(66556008)(66476007)(64756008)(76116006)(6916009)(8676002)(8936002)(52536014)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cc5Tkcq3QdCY/kvwaaTXctVJpvdBzpqGLSdQKB+NIHtxhNCzMCjrjwoLpTaD?=
 =?us-ascii?Q?Hl9eMBea0vujJZpgBUz3vF/BvxQWuJ/PWtnsAwn4pWPOIVSEzKkTiNgpFy65?=
 =?us-ascii?Q?hk2udnJBAOhytx8mN5kTQsL2SsWH5R7pieD2KHlft1dENlaz1MbHFZcb9qqk?=
 =?us-ascii?Q?2ER8Lbi4iiZb3T8E0Cjy7dlUZXF9zeg6gopZ0PV27ichpFaLgttTU1+I3GeX?=
 =?us-ascii?Q?d1iBSF1otv9+4qifwCd3+cQY+55wBD+VnMNv+NeMlDBYgDJOBEUSjkpRZ8YL?=
 =?us-ascii?Q?QwusIGnDpv/tqDn+vBmnSBmkbjeW3Kp8n3yDHkEFZZBsfqhFXZK1pjjqYXue?=
 =?us-ascii?Q?w7JCEMvEpaYeOetjl2GnDdypEhaqoMDVDTlaCTFyGZEvCyXVtm49/8Bf4/m6?=
 =?us-ascii?Q?LMIF1A1Qm4pVlcVPFDsZZvAZNTOX4q9xDyVdV1/1Orm/aPPAFX076v4hkXXL?=
 =?us-ascii?Q?FJEJpZQAB+qamzxruJ2XwtllMggQRvj341MVVcZbsSbrB7X9a4slyWatMf+m?=
 =?us-ascii?Q?QwtYGFOIXZkxonvb3OHSUXh4vJk4YnFa+r2U2xnbWhsrL0uRkmDbb9qKvV+A?=
 =?us-ascii?Q?RHgrKjJ2bfMNFUdU+4qIPT/huJFmatU7xcTVPS1NNqcpK6IpWxympv2U3I3i?=
 =?us-ascii?Q?Qh7zrn+tO08FlTY6asVLWVqbyAa1uUW54mcPTOoiPUn/9RLno/p2Fw3cSm6d?=
 =?us-ascii?Q?I0ybNpET0MUiwFvtT9yVaanPWF1aqCJn7iRG6BVqWZ0vszfyqc0sRkxiIwRT?=
 =?us-ascii?Q?N14ZVFJkg0yLIFvIvaKXIWQ/aNKYR9ydFEspUr1BVFYEvKcYLO632cG9j1hO?=
 =?us-ascii?Q?o9xuiS/M8LEI0Jo8bZsp21vI+LIWX3G/Yx9eF43TxKDaVrh1oFBpKqJFAhgb?=
 =?us-ascii?Q?n4c6DMswx+CEC1TVfwKMyf+7QdSI2IaGzGKEiv46w0mI0N5i3j+svJOVhRDy?=
 =?us-ascii?Q?vW+64T+VeSABRpRx8km5lxBcITUD7mHIKMdCH1JTFZ0crCLdj7rgLK0xssuq?=
 =?us-ascii?Q?ilD8m62alT93N+l8s8vTRSHNEV2xzy1vLzNkhCkU6godA2KJHtD3QlP/81bn?=
 =?us-ascii?Q?h0ddT8xVMcRR0uA8Dl/ZMduHBgmEjpTrISKH5d1wrZSyJ23x81/iIwYwSfbr?=
 =?us-ascii?Q?Cf1cNmzo4qQ0APV62R1Ww06OjgP2j1Xr8V119/DH1QJ1ynBzdgYDfTuDmNvR?=
 =?us-ascii?Q?bUVOst+4QcMOIpnGmM/8VfBR91AYtVQD/i2qbl1tbdAjItKLgOfx7qUi2j8w?=
 =?us-ascii?Q?sdCs090mrBrJp5ZdtAG+KrXQnLjsm8eSHoUckti4S6B1Fl8qz0PVH3sQ9Fib?=
 =?us-ascii?Q?qAkABD6p4iC9BgWk5F7rM2knTebkJlrlVbunIDYeo/r3HGETIi2xwZZMQZph?=
 =?us-ascii?Q?sJqLz/KtVxONeX+xonPzH/YeE/kCAjXGUX6Fsfei4FjIqeGAJOR6UlVM86RB?=
 =?us-ascii?Q?BxmzdIjPAxB9i8hxHRPIP66/nulst8WMwimDVDWUC0fv+r0auaXOjXLKM9bk?=
 =?us-ascii?Q?kU2nZfGV2aqVNJV3E7ECkhs6asJQLlUZzX6kQhMg7NK+aVQW0tV6R5tWBENU?=
 =?us-ascii?Q?NcAM4j6sZY+4tyCrRhY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 650cb83a-a5e8-47c8-1754-08db78eae44e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 21:50:45.0769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GHtBbtfpygYB+6Lq2Z/PF+dLBCTFD9QvK5M3EU0C/b2K0xQd6tEfar0xuqb3ET+Dj54CBwBoH2mKd+pf1EKNvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5897
Subject: [virtio-dev] RE: [PATCH v7 3/4] admin: Add group member legacy register access
 commands


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, June 29, 2023 5:46 PM

> > > Or preferably I would just include that tex right here to avoid the
> > > need to jump back and forth.
> > >
> > We have vq notify config data as generic and transport specific
> > listing,
>=20
> But note how that is included directly in multiple places - not a link. I=
n the
> resulting PDF it appears inline.

For notify data structure is not defined, so its little simpler.
Here for AQ command structure is defined in the generic section as just byt=
es.

I have mixed feelings; I think definition in transport and link in generic =
section is fine.
Are you ok with that?

>=20
> > So will improve this part of text with link.
>=20
> anyway, that's not part of ABI.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

