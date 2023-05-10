Return-Path: <virtio-dev-return-12638-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A6EC77B7D
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 21:48:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0C757728F
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 21:48:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0164D9865E0
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 21:48:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E98FA98631E; Wed, 10 May 2023 21:48:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CE9519865AB;
	Wed, 10 May 2023 21:48:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNM4spc/6M1qWa/Ou9AFr7iqjf8gTIOzSzqVY/7VFrXGKWbGM3PBxehKGqqjr3sZmUoMmCpUlwwG4Zc3C2Vk8kNYKg1aRsgxHHDCgX3AVciF6N01YcqHZmTBaCv/lrxqgT3ZdFld4c75AXFUJcmRR9r8NXAAuUZ7dlrLUbsFIvefdbP8FcaWShXWZafi4HwIslyGw+NnmKUB3eslIyrE+a05F7CKuKMRuuxp0BWHC3/QRxyEYf1SDNeAlPSnSgJC7cvUkp/gW7uWI52Vv/vcGh+6sQr1wiLXoiEE3I1G+UfKA007PFZKWZkW92rLL9aRPcvpgQRYFlkJfFuEOqftNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76m4X5Rybl3s0gOnM3WGof64C6gYu/b+Pm5UNGRUc0s=;
 b=KAAeCxwEIk0RbcmGyertCd6aNX+LC0R0EWUI8L/Nl20qpwd17QSOolz+nbM6CWiWx/i4SfyvllfMCLuPOCe3i9wf9r8JU58nUHkrDH+ItWcXm+HaMfkr/wESM/BvmmcbOhZ74e/JTEArIeCdpm2eGCRjdSLj1U+EN8WcB1IQl/Jq/hDRfy9RG/QxF9ng9WHycqeSkwIyXDNh6O9ZUmv/3KtYC44CwOdU5KHpRZh/8l+c7rbuc5yBa47xswRW96zrLHY8wqnKWQIFHyB0MMvDrUbVdGEjbbKvv1XlDNXOiJHSZEztVyp9UqaKWZNQuKtAsCvNubaw1ZOlko80CNaACQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>, Yishai Hadas <yishaih@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ
Thread-Index:
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9Mhl4AgAJOSwCAANQugIADYnEAgACpnQCAAAFGAIAAENkwgAA311CAAA/egIAAAXpw
Date: Wed, 10 May 2023 21:48:22 +0000
Message-ID:
 <PH0PR12MB5481E74D5108C1F78B1C9F4FDC779@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230506000135.628899-1-parav@nvidia.com>
 <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
 <43ec1c8d-7d11-2400-3649-1fe366b1e21b@nvidia.com>
 <20230510121417-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481F030A76141320F03956EDC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481CEB307F413E53B03D502DC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230510173301-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230510173301-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BY5PR12MB4067:EE_
x-ms-office365-filtering-correlation-id: 49529dfb-484b-4ca6-2b04-08db51a0469c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 I7HeZFL5bguzv4fzhEBSIuUbHIsHa0eqzVh+PCWGj5gOwILmCm+1FT1P4+5IMdZuK8QSCruiYDVgJO1t8PAUw5E0f/qvZo7Dcaj9HfbU3RSmwUoFeBVQum9cWy1W4v6YdoXggQjcYzEKzlJ4mXhBk0pSGn0v6NaNDcQMFsWyyh6zTOdhzbKPyr2vAZRubCggWPZz8IRxE0Kta6dkz51VKQM1wdKw2UCTpo/gkWBzCMuidQZi5Iykj+PrtEwaUJ2KRt3lwMALloauKEb/Ib91ZxQR8ByPXM9ombPcRhZMnRo1JvhDpHdk105eJ+H8tniyoWtGuKH3aVdZ1Xn1nrDeWARDSqw0N16VzvF3dF3lWBrHtulwbkv2u7QntGsIHVkONoCZlWlXFyT9CmWNCOwUa6rUMM1208Ml7sOK6gMN4Jnzo9CH4JfQxhjFwKDNJOcmh9qfb5Ik4gZWVS/VKVXZLupgkCbxrzH9t6Jp7V84ojJcRBMZEJuw2otlDucPkyzUVsmhnHLa3vXmN0mrRu3a7IG4awyhBJD5bSkgz/GBb+CXK+4rwkKeiUP2eW3+unWa5h8MAu25xK7UwVvHGeBAU5K+lVK+rxg5IX4UAZX4RTuJKnpj1ITLR5sWLwViW5Cw
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(376002)(39860400002)(366004)(451199021)(6916009)(54906003)(86362001)(38070700005)(316002)(71200400001)(66556008)(7696005)(4326008)(66946007)(66446008)(66476007)(64756008)(41300700001)(76116006)(5660300002)(8936002)(8676002)(52536014)(478600001)(186003)(107886003)(38100700002)(6506007)(2906002)(33656002)(4744005)(9686003)(122000001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EnSibXTxyUjSL9X3iv6MVFb25s5GNnvOEvG1EAnK+1H7irt3peRsBBmHzv9d?=
 =?us-ascii?Q?ORmMpSeLL7tbn4mtlOJeXQsUM8trrAoMx+ggOJZe1UbOgwEGHwO2TRoKUQTp?=
 =?us-ascii?Q?bSVMO3WOxnwexLVe3kUek1DaQs3LpOQuHQ7A8uo5g44kygl75sv/lJ2mECT3?=
 =?us-ascii?Q?QLNeAG2jSKmoIXhjDPJEPvR9Wi8Fu+qPdbJDSpXMqqZyq+UGGAXI28A/9l+y?=
 =?us-ascii?Q?lpPF0Qqy58La80O3CTUUUnUaI2Q+REWoJxmeMIqYpvqbSjTf+UgVcYkpnFwA?=
 =?us-ascii?Q?hDFt8SoOQxAcDWOPvfef3Pa63w3K0CtF2spbiCAvrGs2behjLHF/m+LXM8sM?=
 =?us-ascii?Q?Nrf6O1MpVYhr4d6w7piuvzBk+WW00N6dwe39Slli94EatHcVOSqAGlcuS4L2?=
 =?us-ascii?Q?9C3DZ26AJOjZElQahbJwlF7DRAatT0oRxwOa1QVY0KOZuSAXEbrIcV+LFazy?=
 =?us-ascii?Q?WAGlQfqjeEU8dWtRzBXchoWtqvyFA9+ZqIJD5pq5QcAXcG5LZeYSZvFYNWkx?=
 =?us-ascii?Q?zMgacr5DfsbS1Jz7qr5tCZpvkMxMBLPZacoA2ogRCL5RZn5/P5TSSgIQaqc8?=
 =?us-ascii?Q?3VzxLQGkW1Ln6bG7NU2VD8nmeA+H9DLvbvVw2CaYn/uTF72+ih9iJgmrBnGe?=
 =?us-ascii?Q?rDt+DmmStg2d5ea/fhRZndCYbJOVvK+rOu/tZ1/DCcjLfVLuqhdwGzLTgN7U?=
 =?us-ascii?Q?gl4+j8k9+LfHunG6wNMPprvHHEzm8a7XIW/wmeWOBDOo0j3esRjB1h5Gq1el?=
 =?us-ascii?Q?u2N4O4OwpqlfaoHAh3ojnZ+/ZkN7VckVTVvHOeITn0DvLTjTYvHViOfTR/ko?=
 =?us-ascii?Q?qOOjE2t+x91fX2r5+t00f59LihXShUEdxU14X8iZvR1/boUJ64P7emu7JOfK?=
 =?us-ascii?Q?KS+TeFiEpjgD+nhWiGvK/FJGmH4ca9vsWkRxzC0sAUCbhGuCWQTb24XMKUEk?=
 =?us-ascii?Q?/MnHizdUcRsCybjSvryhvVfcTc1NgVfQqYkZgeMjqx2A99zUnfuwVyats5pZ?=
 =?us-ascii?Q?xj4nDvbvKNtz0ISLdyxuPD+7dgLR7Me9tDtNZzPQp6B6t8/Pzh6NGhRRj1sT?=
 =?us-ascii?Q?pTzc/+zlVyDdOBQo3/QO+3lUVap7eOe1M3f4o2ymV5Zy9ZrpMB4daFOA06VS?=
 =?us-ascii?Q?+hmVNLXyJvcQfV8f9LShaOu9ij2ROeqINZcJELmfJ8Czs1IRX87PXv3IYDdM?=
 =?us-ascii?Q?KZ1qOKKFQhwrIDqHDkBo/1dL3fTmLXLIDPwPWAyOSipABc5jKN+j4cvAAi4m?=
 =?us-ascii?Q?2annnl5CF57Vi+U534bDeUMZluWIu2MYIBJ+KnSy57qVnEupthYFo9SLCwYx?=
 =?us-ascii?Q?hqSJT38Z3CjnJZqwX4yGvbUE+ITHSuHhamW5OS/aRMiq+UVgikUaTFCqYTgj?=
 =?us-ascii?Q?A7lyVnHlN65EmLBFeP6HKOuA/1DHBtyA2KGJR3iBmDsRkQhZls1+/h0oEQTb?=
 =?us-ascii?Q?/VKapxpsmAPJQbcn7YGGbQvO4UITcRC1gAok1Pynx5Ud1IuYq2AjSduW5WrT?=
 =?us-ascii?Q?pa2SPCRakf0Gz1Q47rBHn2IqUCfpCv8l/ZaC37dxYLi4wa6rn8NnImjT2Gz4?=
 =?us-ascii?Q?CttE7eVVfU0kypaC5D0LOsTyCGDv6gAkQoRKACVEqFwUGjSp7furGq+jAnaS?=
 =?us-ascii?Q?TPQUgniQB3ncpPwLdTpyCxg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49529dfb-484b-4ca6-2b04-08db51a0469c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 21:48:22.4208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LeheAKKALOL9cOeWaErwsuTJ27glbwi56KPiuSQY5HsuYmf9Be8TYjSk5OGhx58sPhdUoZk5JNaDUJ/PYbA8pA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4067
Subject: [virtio-dev] RE: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, May 10, 2023 5:33 PM
>=20
> I think some kind of "enable" command for VFs might have value. No?

Unlike the SIOV devices, VFs life cycle is under PF control, not sure how t=
he enable command can help.
After SR-IOV is enabled, VF is short of enabled, it may not be ready, but t=
hat is guarded by the device reset flow.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

