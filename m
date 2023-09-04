Return-Path: <virtio-dev-return-13609-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD8EC83F2C
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Sep 2023 08:09:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3A3D47B0DE
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Sep 2023 08:09:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2CAB79864AD
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Sep 2023 08:09:01 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1EEC2983E4F; Mon,  4 Sep 2023 08:09:01 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0DCD99863B7;
	Mon,  4 Sep 2023 08:09:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWxvXXYeo460IblJfCfWiiEav0KhpUnF5FbRzSCssmaY5Jb4Iz9nVpl95wE9qMlELeRgps7PESiGcQs8Lkw5rrvhFoC6pM205ZZewpGNRKcm/9pt94gkOegupN+lrTtTYUAUv3wO4xNWcXtlW7nzCFTjnPPvoqwf3kZffbpkWCUUAuLc8duI1NBgLxRzwbKUgxZV7wZX6CukAn06d/vS3TTKgYDvjCd+N3ZQaLrUggd1OiULYc6PgRj69OGwGmfOdkr8uQYX6oxv+QR/YovpUMP6ovVMv2tDYF135O+DPaZKMvEWiLsdTHuTPkPvIaoLD5atsaVo+6ARer+5YN9S8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FuxNNqPbkuw2QDqUL+mePxFk7HAnT+qpayjzV1CTXHE=;
 b=aPvZxX3R5/4v5vOpDiqX7Y/gXEgGsTtPKFeVRcbehJ0J3V8VI7Ipx9J5ONzvpIHkgDGQybYOypUjQNR5UPWOn/tfE0/GKOCozZkGajJPPpIs+AdzB8t7Zn1OnDw2ifZzdSvFLZ1+2m5NxaMa5RsFjnNrj9PaK5aQFNec4csHzTikcj/V4UTIrD98l0EglsuboSpnqmkJ+5DkydOQOUSC0PjyElcxBv5LKMEJqrmwzb090oOj18A9mLWZ059QcyIZs/LqGJQjg1Ynzh6zJffqqTEG0Qk2gKl9aUWzCYea8VGcOt2M0JolTD1spKQUaKNHGgRH7irGLIud5cKvEFFK7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, David Edmondson <david.edmondson@oracle.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Thread-Topic: RE: RE: [PATCH v16] virtio-net: support device stats
Thread-Index: AQHZ2wYzX/zNUNI4wUOZcBP1oGnfKbAF9gaAgARYMQCAAASwYIAAA0cAgAABWeA=
Date: Mon, 4 Sep 2023 08:08:57 +0000
Message-ID:
 <PH0PR12MB548167EDE78C3B7C00014D2CDCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230830055239.10680-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54819EB466305284A8C9F649DCE4A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693812824.959417-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481859AEB22FDDFCDA9D57FDCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693814534.4663684-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1693814534.4663684-3-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB5892:EE_
x-ms-office365-filtering-correlation-id: 86ad09bb-d896-4f36-5143-08dbad1e305d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 oMYmVd/+5i+yKfHzWMSlbf0yf7KzRx59KA2vW+zUXGEUbPRWlTf1TZniprqxa+vp5N1AK47VKMQPhSzzo9RDmy50LVrYsdENpKdUFythW+h4OOVuyBp4wb+eydwes0MFO8PDIDY653Khg8G4p+TmeK0j3MUFGOvMi8HdwFcX2Dq5Y6CpSA2Skf6+7nTLdT3vA53MmdU0elLb7jShjJgHjHRo2vCH5oyuXgI5IPFx2DGTewAzP1iifjN0nUrlQAqhF5B6jzrxjTi9glDAd9iKEpYz3WrpVW4tCsr/I+jeYyinEoBN3lyjbORMtOM5se8dnEYAFd8//AiqM0RjXMwC5xnWKtCp+ODpjWxsY8nkwpqTXnERN+C5x1byEoiqeshFWqK+fezkDUrZ+5ugeSNzw4Yq5AGOpdfVX8B6pNb8BFNCMSZXM7Y8n8i52z/Pa14hvpld+/MA/oox+b2M5AYasG9/C1Lx2sXqynFPY5AeIqTPzJwQn6NexZDn70UGUHnBpN3Fq81+FWS4P2ll8etayflcdcgImPD5u9jrBk+pfB68d7dCEG9mcq8hefSYw0RswJhQ6+Ns91IIFI/3uHyvwJXZAf7hIMU1sUrvZLbc5L41AKsO+pU62Z/f3svte+sL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199024)(186009)(1800799009)(55236004)(6506007)(7696005)(9686003)(4326008)(8936002)(8676002)(83380400001)(316002)(6916009)(64756008)(54906003)(66476007)(66446008)(66556008)(66946007)(71200400001)(76116006)(478600001)(41300700001)(5660300002)(55016003)(52536014)(33656002)(38070700005)(38100700002)(86362001)(26005)(4744005)(2906002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WlDl+ieRDlQcjPuv5fNpJ8KvnE/ospA+tzQbMHez4+a3poX/4sNHyT7A6bOD?=
 =?us-ascii?Q?ulyruE0shZkY55jBXyJv9N/oaJh3d71uYAWiNpmCiihXL5M66QOvg78eEYYq?=
 =?us-ascii?Q?7ckpRjjHw1JXbzt0Bci9F1RXb5eWpXiXHLkgk4nIk3alCIqvrdQsrICzJYed?=
 =?us-ascii?Q?QSgsCj5M2q17yAQ1LCYJrB+Eu3EQqge+fLw/ax13lZkpzwerWZKBZoCIPsxv?=
 =?us-ascii?Q?CyVbTb4rxE8wLPaf0WO8zqNG0GXzq0IQ4ufyxGL60CYayCsdw4L7NKvZFVzA?=
 =?us-ascii?Q?Ymc/s6ApjYmoPwGDUjlF7OzirYcjfB/5g1nzrsV4/OGcMERrBllDB+HaEq7a?=
 =?us-ascii?Q?z3SelKqFXyiP4P7+ODdtkTDLva5HO+CHcQTR2mp3UxLy2zL6mUgwErKjPTjK?=
 =?us-ascii?Q?NvAzPY8uQ00yE16F1LN5Cn9SAyNYN/5C/PpreD9eakEBv5CrOo9xShARjaLa?=
 =?us-ascii?Q?2eLGAAfRHRfU8sZE61n8tAzwEh4rVXrTMjZPUJj2M6RNb5MaS54p0tAnC/Bt?=
 =?us-ascii?Q?tV8Zduz8OUijecV7+y7/GHtfeW4A63cEDfS/GkgbADpTOsv34EC62Ju8HM7l?=
 =?us-ascii?Q?isYLRPEA7B8F9mQLNsmxv8hHjT9oFkKpKflaztkMJvtowFc/xQ0qkTCx5RhO?=
 =?us-ascii?Q?883N6M/8MbGkB5gTAUv2LLY+bpdQAUoCTa0GrraSEr/t73ry/XxwDpfVY9nC?=
 =?us-ascii?Q?tcqDt0KXnZipi2MKLasEsl5hJr8DkiPXY2hn2wBBjl/0vdRaYoVsPqLD1Pqk?=
 =?us-ascii?Q?VZBhGctG3fuvSZFppyfHLxHbDBiHPEbqK/PmVzwK62Yh7KxOFzOoOXpjSqMP?=
 =?us-ascii?Q?H5xcasvXJxuiFCHypItt7YGg0jOz2fiEKRt4dtnxaBnssmYY/M6hSMbDn7eR?=
 =?us-ascii?Q?bJveBnuTo3ws+VEKUIocLxr4odEIxHe7jvVzxGfOOc7oo9bp/gn4FJ4MGgt8?=
 =?us-ascii?Q?5HmtV/MbAdMVbzRAdAWIaK8zvOJhHWcwVRNWq66F34OljosUjsly9VDwyne7?=
 =?us-ascii?Q?k2mbaFt0NwlBODlzsppUU/tp+khAVX5J+np+avkSgv/DwPgytIWH4bNccZr0?=
 =?us-ascii?Q?mJCcupQtK0IBpUjy1tcuWFqs7+fqyZC6vnMCrlSu0E1Xs+4igA92BugJSiwe?=
 =?us-ascii?Q?xrfpBfBtLBpceVUPs+fFxLJe83KggoNINuke1u8C5dxB+7MULyRIMFJkcYqv?=
 =?us-ascii?Q?q95e0FjvAkwz1SSR/7q3g0ih/+NsRjGhZHcNuml396K8lGgLoMnWfu0XM6cn?=
 =?us-ascii?Q?KzIoUdmjawD3AKtQZ1au+I4h2C3bNJagK9wK9ZTVlC/R/M28u4OEA3xtCgBh?=
 =?us-ascii?Q?E2jPux3fxFHcgbRMJn+06KPqQVGM9o5a3eHPmZkULfZ/ZMldWmdzqeC1wtsr?=
 =?us-ascii?Q?lw2sxLnV2hpb12QxNLHfncfehpScd3VtZVW4Cwl9QwZ7Zaqiyg7xOccViYTw?=
 =?us-ascii?Q?0Ev0faEVMjgmznh1q34rIN/8H6ljycp3+sZB961l6UjR/e3nVLhvzV0SuTu1?=
 =?us-ascii?Q?ptYvOMxTv+Mj9vubuTShux2wxxl/JdOWu2SHgLB/5C3Q49hiwsztp5B999br?=
 =?us-ascii?Q?DZIwyFxfyd6px6jW4UU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86ad09bb-d896-4f36-5143-08dbad1e305d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2023 08:08:57.4577
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QI9aFOMJFSH8eOGRLpo0dUpBLsChbccI4EyBbNtg2wyS32QTbxiLegARehzQqPGsSe+mMArh6M8z/LQs2Bv/Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5892
Subject: [virtio-dev] RE: RE: RE: [PATCH v16] virtio-net: support device stats


> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Monday, September 4, 2023 1:32 PM
> > If so, how will the receive device can receive such large packet when t=
he
> posted buffer is not worth the 64KB size?
>=20
> The virtio-net merge mode.

that is only fine when the mtu is 64K or when mtu is not negotiated.
Because in spec we have=20

"The device MUST NOT pass received packets that exceed mtu (plus low level =
ethernet header length) size
with gso_type NONE or ECN after VIRTIO_NET_F_MTU has been successfully nego=
tiated."

We need to update the definition of those gso counter to indicate above two=
 conditions.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

