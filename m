Return-Path: <virtio-dev-return-11683-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90872C6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 20:43:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id CF1B671C8C
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 20:43:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C38B79864B2
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 20:43:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B6D0B986452; Tue, 21 Mar 2023 20:43:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9F9E898643D;
	Tue, 21 Mar 2023 20:43:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5R/BaLiSgskU44RlkBKQtU/5nyl8blBoBkRxzY3z4oHMN9ZrZmI1q5AOPGGUXp9Z1ErrWx67ZyZWjOlHiwkOeyFSiKZDIA4iFa6wSutYwPEonv5KlF6pC0szbtbU/hKqylu1joF2X0Co/L8PKW1qvazrpItMWD4e7rNy4HMFWZ2k+u6wxYukL7XjAh8RaBgjqlYa/062U4ziOvuTAxmbJuV0uGjohSX82ij88fYuGaOOhJ4EWlcumFw1MHqYaArrVzm2rMEhH1NNbx8tqiQnBx2BvC10eMGz5jT0kXxB20HKDWw7zdcFlgKNrZx4HOYS49iF+Rpp3qUINRafVc2Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ca9EUhXAZZD77Y0SMV44zHm7WXHt0PkBXqNnCYGQ+xE=;
 b=AFN+0hrz07kN0XIhUykUKUpcZeELfPswjVn+5MWOJ47TXiIGGXpf/4m0Jb4CHg3wYYInvCHZYXTtnVtyl47Pn7ghP1vVDjU79iDtqwlZD57gqfrxCEmRGQjrjInq+CvklGfEVCW6yWXSZV74oAHoieDW5TwNjukL27BDLvLP8sw65rWWRzBooNhtFAwmHQ5UVH0T1UG5olvpyxr3cI+vrH5Yc1xFvrz0qHbyEm3NycKqXDs9Me1imYxgXsRZh/Ndg3yN8TESVNW3whMe3APHpGgxR15jZNd4QngMMVYpjgWnKjp5ae85jkevUugw/T08mtWlVXw+QW+y3cCn8V3EnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>
Thread-Topic: [virtio-comment] [PATCH v2 1/7] transport-pci: Refer to the vq
 by its number
Thread-Index: AQHZW6sogY0LxCR/rkOT3Oozlyf9f68E8AmAgADBwTA=
Date: Tue, 21 Mar 2023 20:43:16 +0000
Message-ID:
 <PH0PR12MB548101408A0B0C096643FD3CDC819@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230321041036.201439-1-parav@nvidia.com>
 <20230321041036.201439-2-parav@nvidia.com>
 <20230321045804-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230321045804-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH8PR12MB7205:EE_
x-ms-office365-filtering-correlation-id: dcbb7ccf-139e-49da-9419-08db2a4ce613
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 RQy8Of0v2tCu/TYDzocwrDw1+47GVc7wVq1N5HyuIgnLXNAkdXxqgKdrxn8CgsZhqm2StjBUbLq9eEX5jByWd7uqaanOnHAeUKU0XbaTNezUGJ5t6m4/q1RCV2/fmNDe2Gzn+mVix+wSQHLJDq8ifZ4u3U5PXWeDfTJo5MrKndFEHtAROzzQnqxUaEXhMjTiFWkEDBLetOrWWv+XuDrVuGFOEVEMgT6AsWZMxcZqVR4ZNZqLeJUugA7bGCZwqaHZF8rc1FHyURBibEYfnmgU5lpJTx1g2UOVynFJsKlcutKHTFORfKxLzE+SzrTjPRSPy6qSU9TNdW5P44qfoRFKY0UGZbt0YY1bIgUx7SNuT7GjchDquJc4wFO3Bazd90LZYl/BE/L+ScXtci3VejYClOQzAKV33uG8aCnNzEnskDd64EWIY2hONgjXeXiyoFN1O1bpKJd53VjCdxfnw2BNmvgVoyyQNR6/Fd9SPNW/fbXnuTtI3nh1qwjbt17QJxJmeAXolR3enCBEfSZ5h9FXN1tPQMGfCvaCd7k9787s3YNvEGTxr1xWJUG7scmyA6tP7W61qnVQtgkO8zT48LJHCP5IJimesIGiAUJ832IDHnbvrK4P9OzqbsQyJ7yb8HoP/COFFrrCTXDcFfp8BLJrdXeyfrBJ+OrLL0DrwXuaPXoujd6IeOoBwJjGl0a+an4LEiQMCLDFHRTOkHeT/ANN8A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(396003)(39860400002)(366004)(136003)(346002)(451199018)(6506007)(9686003)(107886003)(4326008)(64756008)(83380400001)(54906003)(316002)(52536014)(66446008)(186003)(26005)(66476007)(66946007)(8676002)(478600001)(6916009)(4744005)(5660300002)(8936002)(122000001)(41300700001)(2906002)(76116006)(38100700002)(38070700005)(7696005)(71200400001)(86362001)(66556008)(55016003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5lv7uQK4umWj8Htfg1LDqWR9zJLyLrX1WiQdME6Ut9jWzJ1MqllU96lzo7Sj?=
 =?us-ascii?Q?0FOeosMVMZcDZBznuSFRyU5I9RJwqRASCXfi2OFAJ96QgNH99DYMoiFIPRmp?=
 =?us-ascii?Q?NV3dj9LveIjdhOEK7oqeRy0tF6mE4KlsOIv3cFFDd8T6TlpeL2SzKetZ/Yhb?=
 =?us-ascii?Q?lbA2jUEnUlzM0Rh+CpQuSaFw2Xy2l8Y968wzBcMGKCcB9Ax0BeilnoGft32T?=
 =?us-ascii?Q?j5IEzr7Euj90VJ5IFGSVuy7DJstuwixa9lhnSnxfWEW44EeC4Gg4/WujR6co?=
 =?us-ascii?Q?fl/qyCKGSaIhaXIk601EZ6aWDCWpG9qYsAqEisUw4tdnHxqp0unjgHJ/3cCH?=
 =?us-ascii?Q?BCKN0OnIqGDnEE1e9hNYbeYgsH1v9GPrKlkRtynTbPKgzglYZ6UQtF9jAHHH?=
 =?us-ascii?Q?I5BDWrF51NpoJxXvLc6KtXr2BAID0iYKIz28GaNv1z1OQIaHd29Sz82p0wTi?=
 =?us-ascii?Q?7zp3nLMs3CwgDArujlk3+G8CXNv4RJ2IOoQPv66MnubcTVfkaoRtxrVvq3y+?=
 =?us-ascii?Q?oJDM8hfgkURa5AfRvbRsQrQEhA1srcldlC0VG/82+gRFxN79WoSk+/+UhVvc?=
 =?us-ascii?Q?3adl3KTrLmduaImv2MzsLbGOPi2qlmvSu3C9t+emMCvZSg82s+HIXubbWmDX?=
 =?us-ascii?Q?LCktKJ1krQBDIr8yI2sOhwIT4B4eWej5YShxQWZb7XTl0hBKpBG3ppdET38T?=
 =?us-ascii?Q?DoqHqDWBurEblrNDpIh/fgwvU+9EoZrUS2tl+vWYbcF88fXVKnt4zPWo5l/Z?=
 =?us-ascii?Q?yAreUPZ1mou7Iw7SWSxaJpQRkL1S5bMJvYKeihT8cX+f4SYgpe4qLmXgHVWD?=
 =?us-ascii?Q?E6tRSUVuIuRtydRVFJWXaZ81XudNEC1N4KjVQvW4q571LrChb9Dl5t6xND8N?=
 =?us-ascii?Q?qedo3l5xcfTK6rL2FB0JlX1s2blCuCJ9eyw/7fawpnw/rVww2loJ+UsQCX7k?=
 =?us-ascii?Q?vnW0f7imn5bSlvtV6aPIqSwKDwx2u7gZ6zylamZKSwKLVcHPJy3FsR1V1uL0?=
 =?us-ascii?Q?Rf/aOFkbR83tGCXEqOiop7fzEer336JCIHwwTgwhbAU73sg12G411S3LaalL?=
 =?us-ascii?Q?2Qcy0ppa4n5pTd9l4/9pL4CtygsI/C7qb+khwrhp8rUZJWz3NWhFrPAtugiz?=
 =?us-ascii?Q?DjOMYoEZM+Sf8CswUwhDky4yqKg0LBBfWfKNesujFxpo3InsJSNgyTyhzFiL?=
 =?us-ascii?Q?yBa9NfQOUPScwq5YQaz56nij3vXJ+qNGBQzRZnR75pILA5dOaaEin0ZkrQ1B?=
 =?us-ascii?Q?c443yVrgndNhMVhfXA5X+anGo4YvD1NEZOX5aLDPgrGPiU45BhIui8hKXEZ2?=
 =?us-ascii?Q?3u6NP5WoB0EGd0eRA/W6xIVCo0rhQZggKsdUR915cm+sknYyRqTSpRKv29a9?=
 =?us-ascii?Q?+b348UZ0tkOJWCQ394DVf4ZVEaZJI+/RKs2wIs8cd+HmKAWOEvzGEvdf3hk5?=
 =?us-ascii?Q?76Ebq6szA36L1M/dZTE6ALQAqGHxaoNE9/lMjxTfw5mKu1ygLRp99VB6FOfp?=
 =?us-ascii?Q?0PcFKUTsraLRAj3ToIcJc+TZsxLkmcfNkcDAwMgjWqbWZ5kAHv8lL0bR2ckk?=
 =?us-ascii?Q?ZlS3fU8tbc9LldFm7d8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcbb7ccf-139e-49da-9419-08db2a4ce613
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 20:43:16.8824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yEvqCOObSKWVDglGllZS7CnGx32PFBF69D16Mbu/xHi5sgFNScNAU5Y+/Lv28S77wLVn8KJa+qyM6nzUbSf+/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7205
Subject: [virtio-dev] RE: [virtio-comment] [PATCH v2 1/7] transport-pci: Refer to the vq by
 its number



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, March 21, 2023 5:01 AM
>=20
> \item[\field{queue_notify_data}]
>         This field exists only if VIRTIO_F_NOTIF_CONFIG_DATA has been
> negotiated.
>         The driver will use this value to put it in the 'virtqueue number=
' field
>         in the available buffer notification structure.
>=20
> and I think it's actually \field{vqn} not 'virtqueue number':
> 	\item [vqn] VQ number to be notified.
>
Yes. will fix this in v3.
=20
> and it also says
>=20
>         In a trivial case the device can set \field{queue_notify_data}=3D=
vqn. Some
> devices
>         may benefit from providing another value, for example an internal
> virtqueue
>         identifier, or an internal offset related to the virtqueue number=
.
>=20
> and that's backwards since vqn is always queue_notify_data.
> What is meant is "set queue_notify_data to the virtqueue number'.

Yes this change too in v3.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

