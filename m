Return-Path: <virtio-dev-return-13276-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD86EB64DD
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 18:16:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 210E442C33
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 18:16:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0AEA998680C
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 18:16:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EDC6098672D; Thu,  6 Jul 2023 18:16:14 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D685798672E;
	Thu,  6 Jul 2023 18:16:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JtYkL9lXniqh1qDhkr/aM1lnxHaQTbOn0NQJNhM4PHYBk3U4C5eyXt22MW4ng7ZE0tHc1jc2CyBHWy6QNIyuX9eA95i1GgM2Aa9PqzlH+T0JO4itef+otWFrr7kDxW4u2u6Q3zb16LV/n136nySMz2RH7yZMVvTUt5sTGCooLVDE9XwS772UoE3VnoRJE+TiMf4RXocd1lecNVJ/CjNJu890frXiapcRa4KvYuN9ceyQH34SlhgtfqG6znkEfzLA1VL/Kzk/dzGq2H4OYyCfhllL1GOd+UN/oxhi09/JdRAFfso76mZYMpYA50YN3poGTHo5BM0PvdDpIlqwlRVMWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=so5+EpYOkigvjW2k4/jezp4JUVC3/aKipusmJ87pSLs=;
 b=XPr88XkySxuBmhzkUdnTlzGcoN0e1POlqhDagiQtNVoHd4Q6fGJj3ZHR5kuvOjAbGJwz/FGmFRI/p9UWywwafURKrHuHd/htB+MK/P+estk+/6ZcJ6yKBuU/01XUrW+RbA+Miat2xh7Lzrl9kGLN597HR9a8BEobAHcmfhLqXE2cQZXgCP9jLx/wHByEruRNdTD5DaxxjDOpWpHbdQ2qnj1XuRWjyjxQbPaNqbLJfqyDuT5JyDIXzU3v1oPw3uCXiBGpInj2GA9molXPQSKF6bhmt/0DNMHuG+vjT25Ug3nPoimp5WKmifgMdNxeBF++CrUJnLYos6fUD/47BtqB4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Cornelia Huck <cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [PATCH v10 4/4] transport-pci: Introduce group legacy group
 member config region access
Thread-Index:
 AQHZr8EFxUk4agfAiUezeNF66UoB2q+s7j+AgAAAMsCAAAOkgIAAA7AwgAAKzQCAAACqYIAACE2AgAAAimA=
Date: Thu, 6 Jul 2023 18:16:10 +0000
Message-ID:
 <PH0PR12MB5481B845ED0FDA919B822941DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230706041714.65600-1-parav@nvidia.com>
 <20230706041714.65600-5-parav@nvidia.com> <87r0pluhqy.fsf@redhat.com>
 <PH0PR12MB5481ED484C57428AD3D959C5DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706123954-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817D2E9B0D7C5FE9EA2B0EDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706132638-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54813564E839C71709DCBDEFDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230706135858-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230706135858-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB5793:EE_
x-ms-office365-filtering-correlation-id: a29bd65f-6e68-497d-69a2-08db7e4d1343
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EApANlE8TcKQs+3qdHK2g6onW7JtRtCiiq7OfRmDbm/ixvZodmJs+t2p0n5+rblCjZWBkHYOglj/z2DtPll2JW/WjqNn7U3svAEuJIMOoffCbLSJCaSWMCFADvik0KPRpw06wnHFGH8C4axHiC+jBaxWfqslZkgZuCNEQbRaWeSp5C4+T0DbEJbUqyIBQAw1U+4VXtwE3BS2UEmsLrifv3B34RnN923EgcvNc6DgIsOiwcJyYEvBPTtNkP5NpJSo/qaY0+k+JGkH6jCkX6iwa74rKdHjjkxbiW4K2QO7rJGYXuk0GU7Kf97wL9FTTS6qEH60y/oNiFtUJz7AnvaxrYeBpU6FJH5lUJXDsYGtSKMerEtnET9bbj0foMTVkIYX+pNL10aIL6qsN/Jrq4ayFfBXGZEXUGWEPw0yyM7rPcpIEnpjay/ls/LtBKu/sFoswv4osAAboZV2eWgI4wzDadyxc+g7NbHldebwi+ZH8gOV12voTsJ3mtdtgzr8SYjSHLKjEhhRFqZu6mqQvihNjop+H+6TTkeQV9gnCaJ+iL8qEe8w9a/8gObGuWLpZ5RwDS7b+2C72WCNooK+vIerSWyvDM/eqF4OaopUVlT7LuTg2Lc8x1TaJuKVgpFEPZnc
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(451199021)(4326008)(64756008)(66946007)(6916009)(66476007)(8676002)(66446008)(8936002)(478600001)(41300700001)(316002)(66556008)(54906003)(55016003)(71200400001)(83380400001)(52536014)(7696005)(5660300002)(2906002)(76116006)(9686003)(186003)(6506007)(107886003)(38100700002)(38070700005)(122000001)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?F2FMOF/P2zal7pQ1yurGI54GNwSQGtqQVc7DH310FP9GYRqX1R2dSNJ9gk6U?=
 =?us-ascii?Q?9NIB0EjJBsrxBXNrcISxqpr1JxcSt28RP+2bpyleJ/FisikFXzLkBAfQkRP6?=
 =?us-ascii?Q?LlujgbMfhxoukV2MOU2qlc57ULT+AiURuk4nEneNuiOBGTVPfyRj+awo5lt/?=
 =?us-ascii?Q?JwEQhE+Yt54vrIewsfr93jRAiHg11f6q7QGEDFtuxSfvPn+RBUNKfBMQ+dbT?=
 =?us-ascii?Q?l83UGLxSAS+eQMWnA+orTZLLIzOQAg6MHTK1XfDSpUdzS9i/bqrh4YI041Uh?=
 =?us-ascii?Q?jI7KvF0qOi40CTUPsb8gjH/c1HTFoCCHQBUv/jsWWbzxgZ8RHd0XA10UaMpa?=
 =?us-ascii?Q?1yowl9XDZjXt4e9iDrzX3wd0Xf5R6b4Bi6li4fx/hN8OtQ5/WtuXHEV0bBNZ?=
 =?us-ascii?Q?2Hctv3PbBTZF26khxz0grAqHOFImEbk6V+23ss4JJdVN3s6DaEKkVI1UJbdn?=
 =?us-ascii?Q?7v1MTVJfqpsI/lszvo1kZ77w911HTfUoGgh2Fb53KlHIC6PgDmp7gT/xxqeM?=
 =?us-ascii?Q?JRQtGgTCO1PsWaCQusrvgfYlnfMKUg8HGXsji4bEm6aEFbYOYVrOa1kEA/HH?=
 =?us-ascii?Q?JQm2/M3otDZhQmWo9qLxv3br0bzScjcZjPgshqHajiA4Zl7lf2Vj8YxPlTQT?=
 =?us-ascii?Q?NPyD+O5LB7kcr1m4qegc45Cl8vZkNYDRRzCPuf6lJ37VDvbHvxA+K3P8O0kY?=
 =?us-ascii?Q?BtK/e+73bytWKmf+eHIV1Y9hyGnU1KILoKkRZmD7jRjETVDBMjcvI++QD/5L?=
 =?us-ascii?Q?KQtsaV6qFbkrJyESmNMCFKTSX8LIZZrP6bUeEu9T1K0iDpWyTOeuNgNpOOvq?=
 =?us-ascii?Q?kclQoDj8Co7ISSSZNGjO7V6sdhBAQRQEN1YMBnHAAGilQiOzlnUNq2Ots7Px?=
 =?us-ascii?Q?dtHldwbbW8/RrSdo00kHZGKbMKG5z3daiarRTnWg2KtSSxpGHpLGcCzcw5WA?=
 =?us-ascii?Q?i5YPS1fOEFvOX83JOAARNyR1JMQ1iig3tv+qHTggHu0bpg26NDeQFQdW6W7t?=
 =?us-ascii?Q?dGUfnoHvAr0B4+mmUv7QQ/8SLN8aHykyIHybLHq5PC+cv3/XmQHRYBcTGFSa?=
 =?us-ascii?Q?YDv9xlMf6K/KJaszvwR8LbPNCVKKGIVDRPPQzUjEFmkGF56Lb4FLJn8JLGff?=
 =?us-ascii?Q?0I4D9P2+K2UnONKI9Qf6Bm97dmeDigGLqQJHRJ5+ifBXv8lBPRAZ32PIgBDG?=
 =?us-ascii?Q?Xf8yiXsprUjQZGgpg2m3ekNregrtcjolnBvZw4/0YK74XFWsCtvtOGG2I9Hx?=
 =?us-ascii?Q?ZdeHxcpP2ERf2VyFto9TD8oA7yIZM8l0Yno40tPbEou2nwpW890od98husYR?=
 =?us-ascii?Q?mtnTC02cJTaplibe/w6Dc8Tg8Y0vLVU23IIevgis0Yj4IW++JJflJrt4v416?=
 =?us-ascii?Q?84GE9tkILaeucUvZIqst+hAvGYzCcHVXTdX4B53J8ndqF/0d40CqkkJsaEZl?=
 =?us-ascii?Q?5L/3mMa3fI+Zar0MLZyJTP8cFMTxMt1zQfpwZ6hdH0bUmpvQSH4lr4xDdkEh?=
 =?us-ascii?Q?fwV80HiBUjXYZnvX8AUO+U2bsNEDJaYxF65x5SPqu+xDZKB27/u8quOamL+m?=
 =?us-ascii?Q?d3D3hmtawQL/mQV45c33CqJnC92CLhxe3YR7MxIrHBl9nTC4eXt9yhuURZAO?=
 =?us-ascii?Q?o6e4P2bUftuo7YlzIMr14RY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a29bd65f-6e68-497d-69a2-08db7e4d1343
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 18:16:10.3478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EK7miC5N5xWvvAG0erF50+gcWE3hp41tFlsnrWjL1IF4aA3VC3dtePs+gaLEnUY92TxHr1u5ZVMKVxhi6Ns38Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5793
Subject: [virtio-dev] RE: [PATCH v10 4/4] transport-pci: Introduce group legacy group
 member config region access


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, July 6, 2023 2:06 PM
>=20
> But again even if you add it there, you can not claim it's exactly the sa=
me as
> legacy because the address is different, the address type is different, t=
he driver
> is different (this is owner driver) and even the device is different.
>=20
You drafted below, that I included,

The driver of the owner device can send a driver notification to the member
device by executing VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE with the
\field{offset} matching \field{Queue Notify} and the \field{data} containin=
g
the virtqueue index to be notified.

We extend this further by saying Queue notify notifications is sent via MMI=
O as,

The driver of the owner device can send a driver notification to the member
device by executing VIRTIO_ADMIN_CMD_LEGACY_COMMON_CFG_WRITE with the
\field{offset} matching \field{Queue Notify} and the \field{data} containin=
g
the virtqueue index to be notified or by performing memory or I/O write in
the any of the notification region at offset 0 supplied by the device in=20
VIRTIO_ADMIN_CMD_LEGACY_NOTIFY_INFO result.

> Please also call out the unusual configuration where the type is "member"=
 and
> then you have the owner driver access the memory of the member device.
> People might be confused.
>=20
> I also think we should explain that order of entries is a hint to driver:=
 use the 1st
> entry that you can.

Driver really can choose any valid entry out of the 4 that driver likes.
I really don't see a need for overwriting this area as I fail to see why on=
e will expose multiple entries from the device side in reality.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

