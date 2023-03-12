Return-Path: <virtio-dev-return-11608-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392E4C74A4B
	for <virtio-dev@archiver.kernel.org>; Sun, 12 Mar 2023 13:22:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 54EC123D45
	for <virtio-dev@archiver.kernel.org>; Sun, 12 Mar 2023 13:22:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4B4C19861F9
	for <virtio-dev@archiver.kernel.org>; Sun, 12 Mar 2023 13:22:20 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 412DB9860AD; Sun, 12 Mar 2023 13:22:20 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 29E729860BE;
	Sun, 12 Mar 2023 13:22:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SH8i4fAK0FZjalMIz6Ye6YyddawnjuHt/UzY6L3rhs3kU0tJ0YfLD+4dKljbrwYSVuy1k/1jWtmOL2bmE1i4iMkkmeX/ePRxV/7z0iY+vIYino/Zj5v5gn8CYIhDsvDeRP8SSQEqHYv1L09MIH18leW8C9bSwPF979P1qhFE170jUS+uBVKYc3aIwzyFfsPQQXsHTcYyac+qaJui2FHtOFzsnxVlrhqacCBOeQGVKuq4PyRv4aFYQK5b3SNdFRu8IQMY6Kvzg+Pw64016BEzJ87rxgQCmuw7JBrE3Px/wXeX0LUTvnPcp6A/okiu30skqu41BT8xC/BRfYY5v6DkUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yruz7/whWvEtiFClWbpQKxvTZHGEWZdr/sj5jMnEARE=;
 b=Hr17VcEeJRhEE96exOT9NAYupAv98DY+3/nfdVWKjEecsKxiMZLVp65iqkDMMnKkcYBNU/JkBTTnNDhuIwrNqq7HPJeUddqE4kksRP2FpdST36DnqDWcXJFUulYVwOIqlp6oj6VCs1suyVMyfgMvB2f8Dk57etkYljFVFItQzGxcmmByf1HKUQSPY7n8dH2Z36UmjHeb7Jyc2yibySXKl31njZMTOLj6myKBBnxMXMFdgkAR7fOO9eS5irOB1Iugyt+wo6/8cbV0gr9x6CY+XlgU+Wbcyj2jQXzQ8QqchYn5p05s5GrtV/7repfa4mI0mzMkChDSi1C2CxbjbH9y8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Thread-Topic: [virtio-comment] [PATCH] virtio-blk: Define dev cfg layout
 before its fields
Thread-Index: AQHZR44SBM2m5bVfBEeSkO5d+VQF6a7dAKGAgBo7NtA=
Date: Sun, 12 Mar 2023 13:22:02 +0000
Message-ID:
 <PH0PR12MB54812629987A9530712C0649DCB89@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230223135205.175949-1-parav@nvidia.com>
 <Y/fQl7ImbYGHEtVY@fedora>
In-Reply-To: <Y/fQl7ImbYGHEtVY@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL1PR12MB5174:EE_
x-ms-office365-filtering-correlation-id: df40bbc4-c72e-438f-0308-08db22fcc4a6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 j10D2NJlWaiFnWu9TFNo3zrX/VRQI0+DzVDUdF0k3rGptcwlT7KwxuxVhdHINWUR3RAI/EMWM7Lv7xdAvtcwcHm+N0Lg0sEqvtJWYRDeFxUvl4givd+l8xhJt6UyQdLFieP/UfaCgF0WCUbklvXi4T7VXZYEmrHTa0tXPdJJINR9MtthfWY59dW1KQiu6yjOEc5tO9//nkecBpD0mImTVvQBWa6Zpd9ZIse6gSMvEu5HTASoB/xTbDWS9tUEHvxlZ2G4+qEWxMqIvjv6F1Qkt0Yms4AtyFZU2kTJHZrTTywlOJ+FMtS/3xwT/eHrJrh3rJPdGto6kzlVoR8Z420VFz/amPHq4PrHCYPSjUp3uY8eCHkqBfi/EDX+gkglU0JXONIlDLf/HS8YykKLbDPvF3TR0HG28wcjWyQC/TNZQxPLcpSp+77elHm6VX1DGa34EI8CENxO/20la0kZLayVS/QvpIb2miPPdvQEVKEO5Ns3DbKaTUU/zMEuuEImLiEoa7WgfYZj61EtHAy4reGAFpOrjvBuE9xYvKAtCB76kkHcA+8VAeIp3ycge0C1cKKfwuDZ5YwAc8/hNKVkPiuTgAfIxvNdl06XSug8l0vaVS9wvM/rKvvluFM5DJ3yDgbo10lD0LDOnuUsmWawej3vhvBRxz92leV1Tt4qKqtddYwiGVedt+6Yd5Vc/Np3JekalxUv9B//JGuMTKbmjwy6PQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199018)(107886003)(7696005)(316002)(38100700002)(122000001)(478600001)(54906003)(52536014)(33656002)(8936002)(55016003)(186003)(71200400001)(6506007)(9686003)(4744005)(5660300002)(4326008)(6916009)(8676002)(66446008)(66476007)(66556008)(66946007)(76116006)(64756008)(41300700001)(86362001)(38070700005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VbRsgVIIWbSx05Zhhr4C5Cfx40CK728rVOWxjcU7SOXwde7oHIM7ryo1wgoy?=
 =?us-ascii?Q?MtbHyysXO4kpa/o5rgxYRCWNRqFaqQQjbL9TME4w15+vSN5DG9pFU6Yiap3f?=
 =?us-ascii?Q?OdMjoZYJLWkPlPKmy1no+R/hft9+V3TaQq5ovXW41QBvnITBJBMp36Rtl4cw?=
 =?us-ascii?Q?A3EREZkuHmNDtF52TFF9vFIvhPHKkN5Zl4FSyEdNKpOn6DlweL1K2WgiM3y3?=
 =?us-ascii?Q?Txb3+moE+jzm+jV9uuL+K7BVWWEAQv9t51cNLAavLvsX0METkrl+M9eqSeHM?=
 =?us-ascii?Q?C0agmdrzr1coQ0at9E5Tap75Z0CZlN/5zkxk+EXL/qTYehAFPmjJq4EHaBoP?=
 =?us-ascii?Q?CNBtmRx7UnGPfUFFDKeCOzduA7HNQGbC5nEjx5N4rMT8hUcqKo/edvc6JrND?=
 =?us-ascii?Q?jEfdG17pRblw8XVd/dwP0OrTZpU/NxmrQ1ViHpKYGkLhQjPrnpzYWxdxHAgA?=
 =?us-ascii?Q?TO3/jrXsGpcUsX1iGl8LKGRvnb8zgH0I6MvVJtTMgNL7LvOYSVg9MplfEVqa?=
 =?us-ascii?Q?7qfMA54Mi+0zkZD8V1mhGhErB7o42TrJkScL/Dw1M2GoQJ3OUc7gStVKQ5QK?=
 =?us-ascii?Q?2Il3gp0UI5ur0gKTKCtVDEBB2+J9chl0iXl6V/4sc9yk19KM5aUlw3IBgI94?=
 =?us-ascii?Q?3ftOw93EaG+drjIT1+ZvMStEyD3xSPkptLMHWA37k7gj2/60apM6DznPoBVp?=
 =?us-ascii?Q?hvkwgvGdw8FKHJIxj7onTfmPQB3KyNa8+BqelUmqd51vxKmAPur1w4o6fR3Q?=
 =?us-ascii?Q?t6ZiN5AiuAMdS5p39AmV3xrJiFZBR5mF79dzUT74joJK4EaNyPBE94kfsA4G?=
 =?us-ascii?Q?pjINP62kPjhTIyN63D1k21HgKp9YhiFtPoO7Upmp00MOjpmndhWyRViWSnZQ?=
 =?us-ascii?Q?IJt70zN6agKxUcPhyVXFNRfcYCT0PmAMsuiqGZrAHBDUauldGmwIOkB3fZze?=
 =?us-ascii?Q?tDiILq4K0mok8W6g0vt/69kldLi3mBKi/aIYLz8q5LjZJdzYZwfaH6pdZ9c0?=
 =?us-ascii?Q?+KZ4hD7lA5QOMC+uxCeS0BTvF9N4fZoQTUK/JG5XDxyLh7f58ZoJz7F/UqHr?=
 =?us-ascii?Q?VH4Pg9oum3c4qBoXXkaQoCd9bByalEGi/gmh4Kg2+K+KPQkZByQaGAlptiGy?=
 =?us-ascii?Q?BSM1dI3CNoUyYF2gopxU5rCtfqvv/EEq6+r4KJYEHBkgoYjcSdkywb+7yuIm?=
 =?us-ascii?Q?XkSnJZrTuTKnWoM/R9ULpoQI1IDsXN+w0b4lvVccPWm8hOiLRiwyzZfnRvoz?=
 =?us-ascii?Q?n6/ijBivGryjsrNRWa4MJdZznebIvo4g+TTJ3XuNoEl4VRfvqERPrWV8gqEu?=
 =?us-ascii?Q?eyIwgih9J2WbgjQFGdYBMXhGLl9QRI0e3xGKdt457KDqqkhPcvb/YAm7IszK?=
 =?us-ascii?Q?ivDlzVpk4kCDshAP2gkiiJhcNVsPI7BaJglB8XRO2OslBZ6gXJllHjh0pPg/?=
 =?us-ascii?Q?sDdICecfBTr8WuR/sTnEdhi5akM8nGU/dCzY7koCaJwkic8xYiFB1vWAzkvJ?=
 =?us-ascii?Q?nJdjyqICUzbtRYw06LbSo1968R5WDI87I04T5ywFE6+ZkTB6DtxIbCaaWWbU?=
 =?us-ascii?Q?oGwVvhmlvtjHXM2HvU5wiP/+hi8UcF+uU8nhfFMz7YkS73GNzyRnGGvpb3V9?=
 =?us-ascii?Q?NqMR2WVjPnMpwb3dx1sclj8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df40bbc4-c72e-438f-0308-08db22fcc4a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2023 13:22:02.8748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gaMG4EjcDSOrpbHboeKXCVlU3upmtiU5pVpQRDxOqzomQt+rj9MNzTNedg0xTIkvYhQj/iOJmT5XZ+f7FvBcjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5174
Subject: [virtio-dev] RE: [virtio-comment] [PATCH] virtio-blk: Define dev cfg layout before
 its fields



> From: Stefan Hajnoczi <stefanha@redhat.com>
> Sent: Thursday, February 23, 2023 3:46 PM
>=20
> On Thu, Feb 23, 2023 at 03:52:05PM +0200, Parav Pandit wrote:
> > Define device configuration layout structure before describing its
> > individual fields.
> >
> > This is an editorial change.
> >
> > Suggested-by: Cornelia Huck <cohuck@redhat.com>
> > Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > ---
> >  device-types/blk/description.tex | 95

[..]

> Yes, please!
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Hi Cornelia,

Can you please merge this?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

