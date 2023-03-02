Return-Path: <virtio-dev-return-11384-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 006BCC678D4
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 18:39:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4801926A36
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 18:39:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 433CA9866AC
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 18:39:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3640198669F; Thu,  2 Mar 2023 18:39:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1FC5D98669D;
	Thu,  2 Mar 2023 18:39:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cl4Cm3oNGpt2cAdfMA2fI8BILRc3n2ZWK2E8wN2KiUnt+3U5DUNqvqrsw6Y9y/dO2gV2D2L0x5lQDSoAygSLWXXnrg5rwFPUPCY2JZjlL7NzL7cmvKJgst17t22ilKZnPxaDuijnKxIJBa0RzHFOLS2jgFKLXw5GjpWtVpyXe13zxAytTugaouOSCOQ0NH/UYD9Zkwra9D8+4b8/5ck7O2ClzuUjKvz+R5WSU4YSXtOUHffVDOzzGZyi2+8g7SXnKzRQEUM1d+vPFnswdgQugnWX0W90LYOUTA9lkR+5LiEEUvrcEcoeL8KnNhCcNgj5krgfqq6pQfwHOhZZ5aceyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89G730Je09fTCzrBownalUMru9Gext66RcWntxaEW6s=;
 b=MJNizr11O//yt0qIztQMSjz5vpucIYWxWjew1zKoQQyZUQwyoZgJVlEphf9+kGmCj0tkjH8DlNFNvNtkQla5takJ/wPLAzeqlFtDn0fTsZ83/SKBdHbI9GC2/XszODLxXuWwjE+zgdqLIUjlezTG3180giHbOyjiUQFjNk1BaQRdrDy1obx2U1qPTgDHqQHGOqKZJ5ra1+A1Gzj4DKjDSrMPYsgZrL3eWFmWiRvn/vjrVev02M8J5piGOyvvn2kfdPyEetZ0XEe13YI/x8fTeSuHz/WDgFNsfqa4VAEbBYmlSYluR8+g5rK3KhDvuS4meK7riUIRCPfRyB10UMnnEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com"
	<nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>
CC: "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan
	<lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf
 Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Thread-Topic: [PATCH v10 00/10] Introduce device group and device management
Thread-Index: AQHZTQeXLBm9R+Y8XE6rxgHYaBOlxa7nwVFg
Date: Thu, 2 Mar 2023 18:39:17 +0000
Message-ID:
 <PH0PR12MB54819D9239C3CD327B817DECDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1677761896.git.mst@redhat.com>
In-Reply-To: <cover.1677761896.git.mst@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL1PR12MB5254:EE_
x-ms-office365-filtering-correlation-id: 6fbeef87-649f-453f-082a-08db1b4d6e1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 U6QZdAY2kLN16ZWNMM6tHaYByaD8vWW0fPJqCyHeAh1t1Sy5sgxqKV5YzjlHmYaK7v4VNkWV17Up1l3zzeSBG/40ifhsKOTpRPKkxm991VncX/c08jmAyLR4TPvkGnHxfAWlj1Yn3kU+zEfimj0bUQ9/JtCfAhTwG3czs0WBGIM4IRb1ayb0YjyJ8uobGK0XGuIL37bZ6M8hj4ByApherpOdGoMBmiF8A36g4DEjArM5KulLWzvzQQM+9RnFxwJkS3N0vpiBbq+1+Atx8Sa4E7cH6D6JA8FW74jnAioaNbTtaDAjS83ulBYI1Ucy8pqGdY+N6huz/6nOu3WZDtoTyZhtaCGJ9U/chrl1kToPaWky8yA5CfVc9460FgcvA1GcVAZDS2Drr5EoDZe1W0M83atkGi18IP9mvBVWSzm2nt+rTelfrrZCHJ0kaxnKSB3w6SqCuQPwFklo/OG7wQ833DDfGDCwx+yMAsZGpQHzKyvDFahyTORO/vwLwc5+3yhoV6p7/GugeE7YRyFiY3SzbTVAtIsUWTPJRpaOgauHjbAnFyvEt46BB6Jo3hge1YkVR+VEfbJYKyu5mJB79P7oNWKMfOcE4fej9e3WB/sELVkljcOPJA+Q9auf0QOKSLzzD1+Ge1eJqsaIdIEGGG7cz25WqESrCOm8TTBKkeU9eElmsttTjJagsVOLKcBvmdePJPIwit+W38FRsSGDYvcI61Vlm2FDSr5q6F3maPZTeGK1UW7GUGpmbgL12vuklkhg
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(451199018)(41300700001)(66556008)(316002)(8676002)(66446008)(64756008)(110136005)(54906003)(4326008)(55016003)(66476007)(76116006)(66946007)(2906002)(52536014)(38100700002)(107886003)(122000001)(921005)(38070700005)(6506007)(26005)(33656002)(478600001)(71200400001)(7696005)(966005)(186003)(9686003)(86362001)(4744005)(7416002)(5660300002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KmsaqJBaJAHkuMG3bZb4JKzDHDS6pbRpa72KPIrTin4v4CA9axuppcPOogjF?=
 =?us-ascii?Q?q3ViILvUedEItTVv1nsSl/47C+HmOKPAjfuHwbHxUgzDOIU/lZ6qaCNDcJLe?=
 =?us-ascii?Q?qFOJq4+bImm79LtOMSEqdz9Ki74DWGHzkz+fekB529oR36bg9QXdLJNIuDgG?=
 =?us-ascii?Q?AcAYpHEcuH/EQAYtY2eNGn+1Gb75IYzlG5O4DDMrZ1rBtSVicY4+WwCNjWOC?=
 =?us-ascii?Q?ESqFP3KxzoGjSi7piP+jr2PwPSCaNiHBghifaoHOgiP28W8FQBNX6QNFv7p5?=
 =?us-ascii?Q?lTYeTS8VJXcS/P96Om3H2+Uz4oFMAYydG7YRvh7TXVt1l2BOJAs/CV+cOG+H?=
 =?us-ascii?Q?busQMRMUagn5vCxBw32C8FBtByfvypxLsKd1PzKyMI766Ql2JUJA09vxAkaL?=
 =?us-ascii?Q?IXzd+NtCn6Rj0Gv/mKGixA6wxglxxX+1RrdIYB/6ulkGVzVxEUClIQFeg9VI?=
 =?us-ascii?Q?+x24pISmVsk8iiMeUYxYq+qlCXIHpb6iwdUj30EBmGc3S+r8ellzz4Dc9Ntf?=
 =?us-ascii?Q?/wwFpCcwBpTSl0PJfzfkPYeuKoYTvC+4xIsYKAP+ef7WztZ88Mckw5aOfAcC?=
 =?us-ascii?Q?5BfT8aJORjdJtg3/HRrl2FpexzU28hz0/Qc9sAUhxa1tTv0PU77HsZuN6qrG?=
 =?us-ascii?Q?N0I+O3dnppR3eNpX9+6DowrIOV7hgju/pDMcVGTcieaUHSwgTZ+gM0FqO4NJ?=
 =?us-ascii?Q?Pcj52S7qLzLV6ngvc4RkH2COSw2GlKzypBCXIFaY5xteUvB/TDav0npAgoAY?=
 =?us-ascii?Q?thwNJBHSeZdBvbwAmXtuNCya0YPcz/anBnnIP1kJ4L1mVAsDQHoN+Q/xNvGR?=
 =?us-ascii?Q?pUJu7y93Z3AYJhjdB/B+tnyZUpZv4Mw5n1bZrTJHDDN/Ag4GPxgXleaH3zoO?=
 =?us-ascii?Q?DTFQeaFQY0sP6Sgjll88VXv2fyupThcml7+5b4JPvSRihkWZGtzy0wVKglDj?=
 =?us-ascii?Q?d6odCFRiM4ScrX5fHLOYWCdOXd8YxsguvP1ktoUa1EHVzHfTukksovvV2HdF?=
 =?us-ascii?Q?Y8nHB6cUVEnx+YAvwIXE7G9jYV7EB9vuzerLAKc5G5upzzyBVAwKq75r6NAL?=
 =?us-ascii?Q?YyqFQLTnl+T43tpf5npZJbd53GIbEOZEjpqHVgJP/pAzjTDGbpfuamimjDa9?=
 =?us-ascii?Q?1Wv/kwC1VShMIWD/OcrYjHKo5ODhMrJ/n8BRGzzS1y4W/zNQb9vMjETvTgT4?=
 =?us-ascii?Q?0juww/tjwzukGnMVOekQaxOZrXjR8vOSdaL+b2IbjV2cQCM+XZWsLoXCCtiS?=
 =?us-ascii?Q?xSKOUzuCHiDFyvx+Xg/tT6fqjkBwHErIbJBlGLK8MEKzsJ+xulk92lqTF9fY?=
 =?us-ascii?Q?ZekiFZu9h6ujAjvpYit5jyb1iR3FvrvCYfNhLO1NiqTNHUE0ac4ooqEf7B0T?=
 =?us-ascii?Q?rNto89tQyBRd+R1HkKXWZgjCP8w8dEf6Tk5pGdJ0qqtUL4yB+e0crufGV9ST?=
 =?us-ascii?Q?G5NcONAZTHqSQg6YkRUXQBG7XiQ4h3xit/FChI7pVreiJEKKeN5pmYUZgpjx?=
 =?us-ascii?Q?QxHqacMEbarP8/MQLsaFt7ao5Z24PTITZKPemDfsPPWJCtPvUYKNWcJB1lt2?=
 =?us-ascii?Q?wxLDlbgxsXcCkqiLRzg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fbeef87-649f-453f-082a-08db1b4d6e1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2023 18:39:17.6702
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uq9ZZ17Vn+1MGCW3Dd3i6SqF37geKFCD99HdTJv4SUtwVfdNGFeV2YKu61TZJig8LNse8LO+7CvNRPGQM6ceJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5254
Subject: [virtio-dev] RE: [PATCH v10 00/10] Introduce device group and device management


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, March 2, 2023 8:05 AM
=20
> My intent is to try and support both SR-IOV and SIOV usecases with the sa=
me
> structure and maybe even the same VQ.
>=20
> For example, it might make sense to split creating/destroying SIOV device=
s
> from the transport passing data from the guest - the driver would then no=
t
> negotiate VIRTIO_F_SR_IOV (which then means auto-provisioning).
>=20
> This is out of RFC, since we have two commands which are useful to discov=
er
> supported group types (ATM can be none or SR-IOV).

I guess you missed expanding the cover letter for our discussion on [1] to =
list use cases a little more tangible.
So let us have them here.
Some I can think of are good starting points are:

1. virtio VF features query and configuration space provisioning
2. virtio VF resource (queues, msix vectors count) provisioning

I plan to post the follow-up patch for #1 as the actual use of AQ.

[1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00246.html

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

