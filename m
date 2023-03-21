Return-Path: <virtio-dev-return-11682-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5950C76195
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 19:46:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 31C4A1318CD
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 19:46:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 256A59864AD
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 19:46:20 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 184A0986452; Tue, 21 Mar 2023 19:46:20 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 051A898643D;
	Tue, 21 Mar 2023 19:46:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sf+apy83bH7k5ST7co4clXktALPb63JSxeirVSWF7no+anlayFJhP0IjcaJR8EjU2GejXQyIg6RTbtWCq7za/X+moB6ZXtTCsIe5dycGCIUAxrkYorWs/2eMQZrrDU6yJBXPECUTVvGxvBkko5q9wIpUE5UFeST3SIQ0X+AuSkWPR7L7C5nY38k9iMZ/lJfWp550chrtsRS9UnuI6Ims//Bcgd97q/tEBr6JXpDI6waL4991Xz3KtY1Btm2K1NscfAVX/ZlIyCCx3uA8GS5dSW1X+vnVw4kXnMw7X2z9ikoD5v1I9zmlDqoY2pOBvDey1sAJjEWeaNkzKHk1lWiPow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1St5mn+hVxNY78MstjAhfzIQKWy7xuk9mdjNbL8Tl1A=;
 b=TRfzIAAWispvz9PIwWJVQhkkPh3fVPzskli/PJSUKyX7KB9V9fqhAIxYP0X+OmHpasRoiVlRIZJW0fv4aoP5TAJBpa8+5K35Q2VrFcYATsxJelHXdrBzLKNMJXl1shZMZfXIYDSxiCqWOCuRi/2+BJiiyiD3YcguTjmR0jAJW9G/rGWYGfyEXbp4+3auK26IDjJ4DL7ewQ0vHPyaI36hGJyS5eXvK8tu62gIEtKaNHiMfwOZoaLxUIO8bMRTInMXTnwDwpZFAgnDUWKr9Zn38NXh01oU7rFf8QYzLkvscN7Ra2q4B/ITIxgUoCUeXekR9kpwiZHBKuaVJMG3Phfcog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Heng Qi <hengqi@linux.alibaba.com>, Alvaro Karsz
	<alvaro.karsz@solid-run.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yuri
 Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-dev] Re: [PATCH v11] virtio-net: support inner header
 hash
Thread-Index: AQHZWx29SoEdHy2EykmUgaDSd+Xmwa8EEleAgACJlwCAAASCAIAAOTEAgAC7STA=
Date: Tue, 21 Mar 2023 19:46:14 +0000
Message-ID:
 <PH0PR12MB54815C3FF78C1702B714172CDC819@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230320111840.64039-1-hengqi@linux.alibaba.com>
 <20230320144625-mutt-send-email-mst@kernel.org>
 <3a1969e7-2c4d-b64e-33b2-57311d73fb45@linux.alibaba.com>
 <PH0PR12MB5481C6A8454381F508A30387DC819@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230321033449-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230321033449-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY5PR12MB6477:EE_
x-ms-office365-filtering-correlation-id: 12b1dd02-9965-4868-5539-08db2a44edef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Nz2NU7nzZZcd8Q92eGYfIw6Xubyn6g10+tsV2HFZ5wFIGwW3GpjR/Y+meEaryARXlQ7tOQ43W2uhYsnjuq5kEsQdaWxn+agpqZGDw+mh4F1Stuga3Qm2pSmDkH7SNC7mKKjNSxyRe8/VCpCwyIWHzCnrWaxUIs3jAUMNHgUMw0FVG+AC9T5bnZ94V9+rdT11Vw1JidOn+8pTYDWgfOReqJymWwIE2wJfnEbopEKFvxItHLfdpKTXWwWS1Jup4B3ofVX/29qgdxYv9N2RdAGKY9qno7SlDELyhISBgBIwasFOGupXhb7WXw4c10JGBX9tdQ0WU8fj6Z7u5YS2Es0ezUwk0W/m0YcnaAWMl8Xw5z+vgl5/ES5cJwM3zM9jxa+DBwRcKDeePH9XvfJJnrYCj8ntRC38U5L5BtRzWaDgz1CX7zyC+Raa+G3cJbKRamrpVYbi5pkO42JPypTgAuOj+V4UY0Vh9Y0QVDPUaizMhCjKFmQInqRRfxGxPcP/C7KvS4uQPJ/32jkUFLqZp+pPRI2Q4TTTq+8snxn51VQ5Sq0vKU2ejp5Gx4smEkXKXbS/Hh55KjVqY9ph0k0w9VUF8MqldyNGlo604Db2oCivXiREjuxmDaq2NoVs9pNFJaGNN36RrDHYQlzEUC5S1+aMzkOfPs8AENm2OvzpTuAg0jXiIkc4UOmfN5Dy4Ymmy0guuYFGRBMImYMMsdvAa7/VCQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199018)(86362001)(66556008)(33656002)(38100700002)(66946007)(122000001)(54906003)(41300700001)(6916009)(76116006)(38070700005)(64756008)(6506007)(66476007)(66446008)(8676002)(8936002)(4326008)(55016003)(26005)(7696005)(5660300002)(2906002)(186003)(316002)(52536014)(478600001)(9686003)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DK2C1G7dvPfp0L8roX1LtGr/WMgGiIZ7ge+2tVai1LKLfRLzwsMBIb+66wjI?=
 =?us-ascii?Q?5aEVZcFjYAvgFbDl0nHW/sXBBAm/ei0ZpSgNqX6c/a7pGtLJDPeWp0rJk59t?=
 =?us-ascii?Q?nJUGFPcJTn+SLW6l3nOgqXg1/wnlFbWpgTnTBu4WDX5yJLYeKM/U/ojKm17f?=
 =?us-ascii?Q?GGIWsxGFzlm9TmR/nMRel+E86qHy5KGRNi/QzIUug5qy+g22vLvhus3OToXt?=
 =?us-ascii?Q?Qn2hLRV0+OtZTIAuL75Or73ent9vTK01q7tQTIBBGP3qBRDVJiDsRJcENmT0?=
 =?us-ascii?Q?zC86dUQePPFaNb3+jR33qnaevJ/9Ysh1gseFVLrfZS+A2xQPAYJMee9GZwCv?=
 =?us-ascii?Q?L3/Xw+FRgjAY7Jgea0XRbxNapkeuPIXREYQQtUBimVbGOVN96Vr6oaabaHLJ?=
 =?us-ascii?Q?X7wuwCYD/69dENhCw1jkfzHINVylxtq9u0sA/4X+xMYfQvgpU/hMAq5DcYXb?=
 =?us-ascii?Q?8J5umDtEgbB7Vqvcc2NWiIGNeRqvzHVtkVNDDyIryIbltrzrgMSQQDaRGmrs?=
 =?us-ascii?Q?2996KoVn/KXFCky5xgmK5PRJsYU5dfSHgacMW35YcQ7d4/TlWaQ52StD7NJR?=
 =?us-ascii?Q?ZOS7YLzRNifsXguEu98tyV85EBel/e4kEqY1mDkVfBKq6zxopsgNXWQwW4gK?=
 =?us-ascii?Q?5jBrwgIXs5ZfX9Sy45BNuhEI+Xp7+++awJerDUeiavbR78d4Kq28dO/rnF0L?=
 =?us-ascii?Q?jMfN+7csFImxyRyV33WHtv70uiBuS2wUp7SX5vaKebT5jWKupUZdt04qS2qg?=
 =?us-ascii?Q?P6JaF+GGzMMpdDmPrH8yfij2BulrzX8/NxZ5ewic44N4dbi1GsyxPw+ZEWal?=
 =?us-ascii?Q?lKUVXZ9HwGj/g41d+tFSd3QBN4rB7tOKvSaCDdZaNYA1h60M2wC0YHtilsZQ?=
 =?us-ascii?Q?OFeXDerSzGMX1/tuMjpkB2oOAIoXpUjXlHxdkFPCmTXpUB/2/yB8wjl4hpmP?=
 =?us-ascii?Q?uqr5AWXCz2zUNaFHDk4Fo74U93aQnPaHS78zVwojGcI4SMPSTizGM3yitHA3?=
 =?us-ascii?Q?V24W0ycXE0eznWQM5JinkShZU2YVimFbNiKiNkJfco2olU3B3lVP6rvbPioK?=
 =?us-ascii?Q?WqaKzBBZ7HDtQIvZl45leH1X6hIoyF2hBFS0fkLW68TwhSxMq2TLkiKdReDU?=
 =?us-ascii?Q?ayfoB9ue8qXkwguRNZn4NmVwuy/19h+zMtEv9DpMb3A8U54QKRgDKOkHZki+?=
 =?us-ascii?Q?Srf6wAy+aBz8Q080V4TjPTJlBpek07IPqo/whqpL1DevcXHL7E13hmphcR4B?=
 =?us-ascii?Q?P8JQZdVVrl6ARRMaaNZJb5tHz/EQOt0KB6hqlxdAREPApGkOTc3KxCAiWLSX?=
 =?us-ascii?Q?pHJRMq8+maJsZcCtt83RD+RTaLHIWUFV3u1V0WPVTR4xe8j6/xsS3n+zFQGZ?=
 =?us-ascii?Q?+StMEHNE5LOe7bgJWDZceaFQDPOTqVP6BaCHzKv7jtSLcDSn5CpNAQ0hGVCS?=
 =?us-ascii?Q?8ES4x7rd+JAwhe6x2qt4p3+r/oMVHvKExjnCAJOvvaS0cIy03ASrovYYo1s5?=
 =?us-ascii?Q?rm1/a33m57VR1gOCrhxPFv9h1bM64aVzriMq9YgMLhGyz6yobx92WP8xAnpa?=
 =?us-ascii?Q?gUQ/zNF/ee53QdLIHjE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b1dd02-9965-4868-5539-08db2a44edef
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 19:46:14.0616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RIhFn/sQMWNvz/qZeL44LvgaBkchfI+c0Z1OSGlctdtAdbX//6wKEYaJ66sCmVL62lR6yX2uO1EMHUh+FH3PfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6477
Subject: RE: [virtio-dev] Re: [PATCH v11] virtio-net: support inner header
 hash


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, March 21, 2023 3:37 AM
>=20
> On Tue, Mar 21, 2023 at 04:19:17AM +0000, Parav Pandit wrote:
> > One (this proposal) is solving spread to different RSS queues.
>=20
> Spread is mostly ok with modern protocols though.=20
Yes.=20
> It seems to optimize for a specific monitoring solution.
>=20
Monitoring is a critical part of the infrastructure.
So, if a point solution is useful, at least I don't see a negative of it es=
pecially when there is a user of it.

> > Another one is finding out which exact packet to drop/pass when queue u=
sage
> is high. (ebpf/tc other ways to solve it).
> >
> > Ebpf sounds cooler than the real offload implementation in the hw devic=
e at
> the current level.
> > I remember Jason's good talk on the ebpf a few years back, which is pos=
sible
> when done in sw on the hypervisor.
>=20
> I was talking about classic bpf though. no state.
>=20
Packet processing logic requires to keep track of past tunnel data and coun=
ters across many queues for fairness.
This involves stateful ness of past/current data.

Even with outer header entropy, multiple tunnels can steer to a small set o=
f queues, because num_tunnel >=3D num_queues.
Hence, fairness is orthogonal.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

