Return-Path: <virtio-dev-return-13443-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D111CC04A94
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 11:15:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4B3122ACA3
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 11:15:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 408FC9866DF
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 11:15:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 30E549866AE; Thu,  3 Aug 2023 11:15:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 164D29866B1;
	Thu,  3 Aug 2023 11:15:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVMcbw1PSMHzl42i/nHZ4YBvx8PCxIgo67PoqREQQ1P808eVQbVllumCSIh3h/ze9pcxV7uO2s9uRyaOuf3WnfG8xBlAOUb+/8wUGQSlXh3Se+qpPVVa5vlrtY0Gzb93TPIjGA/zoA4SAvfPqxXIUWCY9GDuroCpbM6GBS6PA/BPa2/2q7zGNdHmOAHxkCzRT5NaHZRBNNKFyA9XpNdAr8gi1U8g6Bka00Ks3ZY9zkrcHj6O+ckN7QcfLJtff6rWRaWXNPfzvw0DdGV/xd3XQLiQnhveeu5J25GnqeASXa/68WXZJUpp8HyLk8d5BcDuN1C5mA+UroR06BS4hEtAcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUPtO5Ml5FKOWj+qclAn/DO3naUVi+NNtOylszYU4VQ=;
 b=UyAkmnChhfi2Y8erpk+5xX5EitwdEY+/rxSSzZYesRSCFiyYIPzB4AOub3s8GWdz6PWe1xvR7aSxJzto2uTDfcGDw6K6HXrCdc2tVFTMZ1Z3YVZ1TR1uHfuFkPh7QHwnhDc/eE5od5So+EenKGJ78VIM2NeIWFTlymewedF2qOD3H7q32PNt5TXovvB4cDHZS0/N1MSmkC/+1VjZeSiXwoO+cDBwh2177PhYJ5P3SntMQxfhDfqGmtLqx/4kYTa4ORhOkSttxTD6OOS2EO9HxgpXDbrUllqqpeabRlSoAOUPLnjT0tEQXKqRLUG63OmW9YHkcslnnkYlAygO82wkwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Thread-Topic: RE: [RFC] virtio-net: support access and control the member
 devices
Thread-Index: AQHZxeT2Q5D2+syVdECqHrje6hzlHq/YUmCAgAAS74CAAAGPkIAAAc8AgAACoHA=
Date: Thu, 3 Aug 2023 11:15:34 +0000
Message-ID:
 <PH0PR12MB548191AE225B08BACFC0C350DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230803083150.46745-1-xuanzhuo@linux.alibaba.com>
 <20230803054333-mutt-send-email-mst@kernel.org>
 <1691059929.235804-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481B5B3C5366CCACB221083DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691060652.3764465-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1691060652.3764465-2-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB8147:EE_
x-ms-office365-filtering-correlation-id: b6dbb47c-4d1f-4568-adbe-08db9412f528
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 U33+uq2lnIGcKoQ5e5peKighGQYG7LWweREijuMwfcIFHFAjM9gGbdIBYem2gSJloraBpdRG1hIBExZiJEAHxEp5RtybkORXXn0AT6Nly2Ao3DVHGfwVefeNlL6oMZQgBxtTGCjWuIRMk106lw+i4NAK95dKLC/EDGrPz3qvRPthuQYPuRPyPOUF9VhV+CMdTepzBaH80x6kbvWEUXopLxOxfwTCITsB/friUv88UiUkDlGbHEOeV1GLVCTZC/y87vehJQ14398+lh+ymr0qzFpsDoh9zb8HAzTEsIugWBhidwkKW1vhuENDR0XctKhZ3XopBpzHpRa7G8dPtC3eXio1/zXSFtR5LKvj90JNnJJs3QrAlD68BWSb6Mse4b480GV3ftkZzC+zWB93TUZgAXCg9nDtBWRNgro6m6HFxBA7KeZbW04U1SFA70tfgXRy4F2Q1MSnLve/LhAg4RBEGm4xG7XHW+HWsWTWoS723wAa/xx1/SHGCpu87uZHgKGBQ0/p+sLWlPIO3yddz93SdbOfKBhLvaXkw0iFws52JKKL/Fol4h5Fg0iadJ49fFPm1COcUWvSAY8Sv5/l+sdBaNAElsmxxl4YjFz4E0sKxEMt2Pty/j7nV/dCbpnSAyS0
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(376002)(366004)(451199021)(41300700001)(66476007)(52536014)(66946007)(66556008)(6916009)(5660300002)(4326008)(76116006)(66446008)(64756008)(54906003)(38070700005)(4744005)(38100700002)(2906002)(33656002)(478600001)(86362001)(316002)(71200400001)(8676002)(8936002)(122000001)(9686003)(26005)(7696005)(6506007)(186003)(83380400001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HUsgr6bQdUHE+A1vC6ZguKPoXTKKfjAJQeiSrHyy+7mJEW0EgWMFOLAYTyOs?=
 =?us-ascii?Q?BmqJZPWgmifzE9tevasJBV1o6CLsQ5c7HlXrZZh/fQ88wXKWw5ZEnktG1Zta?=
 =?us-ascii?Q?vF6drVEkUHrQ4cU7oOAtrmdpnJi2nmB9GOxEOZKmjKjW1wgQafY/hkPIHTHv?=
 =?us-ascii?Q?3+V/v+ehUojC2MLX64w0Njfb61mc58XtHMtMBNVzHU9GeprF6yLhtHoR13Dc?=
 =?us-ascii?Q?aACwaO6j/coEszxF0rft9pWG26w5xEKfk84w7CUglhRYGO7AiH8D72U5IHDu?=
 =?us-ascii?Q?gRCEsXbbr35lx2jqsUSvzmmi3GwjZe2rJ0fQ3aBnB7fYev+nXTH6DHEtgVNM?=
 =?us-ascii?Q?kugbnEoKxaqYQVw+gg7yWVDGQyNtoodekPI5W5P/zZbu978Rc4j7YX5lLQsy?=
 =?us-ascii?Q?XUmDBW8RfMIQ3yKLemqwSw10teKPKBgBAOA8q75pGkaV10ph2Vh2I6tuV20f?=
 =?us-ascii?Q?y7ZPhZLMJLzEinSgH19h6YSGUU1oF2HgOxVPg4Vd4h3xNuAqEDeRpq8LxZQ6?=
 =?us-ascii?Q?cA2MHQBe9axvF9xMWh1xV2ZhmXMTjsNMiBAwm5pygtZQNwUQATJi1C5hZq34?=
 =?us-ascii?Q?Ta3Jpe8n8x+v5AIMhdlr+lewgmGSW0UsT10uE85DkSCl2ACKeCUDmWLpGDUD?=
 =?us-ascii?Q?NAi0vWn2CpHdzyoWhKRS3ngA7b7+UPO90wSByVvJgC/izZZ9VrufVdy2bw/4?=
 =?us-ascii?Q?O/wRPzB/Gp04gF4QW6yFY+sBWstVObaJ73ns9XNlzPV4b5mhtaPzbbifrQE0?=
 =?us-ascii?Q?f6jVsZQGaXkch6QwdMLceITLTPP0HMaZG8kc612tWXXzMwQnXPJjPPigJt62?=
 =?us-ascii?Q?FPmjiVZEssJyztF0c+m1YJOKQIjStL0kDTiUzQ0lLgbw6+WzFLnEITZ49aVh?=
 =?us-ascii?Q?IMtK96VBmO344gPCl03S9+7GiJw5E2+EJaGh/jMX50BFFhvCcgh2XaWpBqyP?=
 =?us-ascii?Q?ioOKJ0nCM0Slu3LqbYPoB4qdj97DcC1L9NreHPHAugUm82Z8ZvAw4Y26jawt?=
 =?us-ascii?Q?Ii8KyfJowSLCJ8XUEH2ZbV38QroF1MkWTnDigslnhB/BcZpJBjMiQazCIYc6?=
 =?us-ascii?Q?GOn95JQF6YhE49uIBFGC3cggx5H8b61BcV70gc/UjqQkUAdjKZm9DTsTeAB5?=
 =?us-ascii?Q?bMdVkmOffT6CwJA3O5nhSOVplJMkseL2KKrq1W9eub6euFbe6XeDokBvuKqR?=
 =?us-ascii?Q?QiXf04SYOH0V9qsq2UpNBgCddoO7QsnxsdkG7PAA5JtFpUfhSbTYOMtEzhKS?=
 =?us-ascii?Q?D8NQ7kPJXs83onHUWz5jOlht6BNza7K0SACYx9j6+lgVbNYdvR/xoaWA7d+T?=
 =?us-ascii?Q?mH7h4ZCthlavcCKhoHlR0+6Mv2mMGa1CFDwjR7NiY4t/ajrCCrYY4WT6VH7d?=
 =?us-ascii?Q?MiPur/fAbGZCuYJekpUIUKlt66nsD9zqGrflQcXk9FRS/Sj/cTnFPRSOSztY?=
 =?us-ascii?Q?T3PpEFbrMIhfMwPM7wqDP5hsC8KSVVG/ahBykwzZjYkTnKPpnGUyEm/QsgFD?=
 =?us-ascii?Q?O5JMdfAEPU0t4ZT/sQQpHyR01APiNwJFBR3DzmCWcT/N7SVj/rbbIooJeC0k?=
 =?us-ascii?Q?I/Jl9dAjOkrlnJhu0P0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6dbb47c-4d1f-4568-adbe-08db9412f528
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 11:15:34.6282
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y2R59EGO3wiHrIUjL2skMoBung58NiKXnSU8qStfcykrBXdKUGkSiJb31ZjQRLnRK/S3DsUC56VvneVLgYC02Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8147
Subject: [virtio-dev] RE: RE: [RFC] virtio-net: support access and control the member
 devices


> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Thursday, August 3, 2023 4:34 PM

> > One command that gives device context information in TLV (type length
> value) format.
> > One of field of the device context is device config space.
> > Device will return the information depending what device it is,
> net/blk/console each returns different info.
>=20
>=20
> Ok, I got.
>=20
> That is ok for me about the device context information.
>=20
> But how about the configuration of the mac? By admin queue?
>=20
In cloud env, we find them that increasingly users want to avoid such confi=
g from the compute side (PF).
But some users may find it useful from the PF admin command as well.
Dual thoughts.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

