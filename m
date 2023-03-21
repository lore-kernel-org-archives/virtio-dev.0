Return-Path: <virtio-dev-return-11686-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FC64C6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 21:15:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C2DE28748A
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 21:15:09 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BB0D3986460
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 21:15:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AF51F98631B; Tue, 21 Mar 2023 21:15:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9430498643D;
	Tue, 21 Mar 2023 21:15:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SX2Wp+ik0naGNdFXwzfdvqjBbsEodCR4L78lWlpdTqntCsxdaLLVHSrMYyMMxDYfDJCVSOmE62df/pFnGGl8W3ZCcI8GfP/JPaRoNzMj1L+pX/pIG9iZz6bwTYuzcuY8Ywq8u+9g5zAx9D6cf0IzdXMTRhaWtH0pDJAkC/WBXUM++A8NaCAcLlFzDxFNP5DlLrnDGFUVz5fZhlgjrZjEYiVBU9161GdijKWAsudAJe3CZMr8tM/luHLmzk5OkaXR3q0IGhw1dfm5l3BC6KKfBt7obVXT2pEhOcXNakwOhJIxFBnU3BWKJX9gXGMD6pPme+zKnfmMzsLPtaVlUqrBSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIjtXyQpQ+cmJn7boH5T6vISO47cgs71ITrIOmXbdCw=;
 b=T0nPoJt1TU3QJtW+JnGNcjHTFLKxroyFu8Zx3vbyYjDI5NHH0iyX39zOszXPPwCDxeEYr2mLl86xCxz4LY99aKPQIUppwdXh0Vz7Bes7DT+bBHxf2yT1Vkz+ERq4Y/vNQUtJtDZoQkQTfhUX0HKTYzc23GmLyRgDQFdBUXt0ADaDhZy8JLvQj8BX36DJ3rn2n35dLrJ1Rkawtppf6b1qELYdnJZIAfsd91RTRoIvrxC4eo+EK5UZj+6BYv/Z3SXSBJtJ5gZ9c9HqavAVDzrcyuzdxXCM07YvAuNgady6LyAXC40bJiDEkAdf+7sHQ+AyFTWORQ40ScAeXaXXCPFxdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v2 7/7] virtio-net: Describe RSS using receive queue
 handle
Thread-Index: AQHZW6srVZFr8uICDUm1o4jnp7AgIa8E7nUAgADGYaCAAAe80A==
Date: Tue, 21 Mar 2023 21:15:00 +0000
Message-ID:
 <PH0PR12MB548122E08C57CFF8C793BC61DC819@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230321041036.201439-1-parav@nvidia.com>
 <20230321041036.201439-8-parav@nvidia.com>
 <20230321044737-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548130EED53ADA3C384E5A1DDC819@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To:
 <PH0PR12MB548130EED53ADA3C384E5A1DDC819@PH0PR12MB5481.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BN9PR12MB5066:EE_
x-ms-office365-filtering-correlation-id: 3c209d42-a6a3-43a3-9897-08db2a5154b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Yr578gIpMvaxL+UxOGv10K8DxVlBg2IqAuWdWxWuWvrAwPNx53e46QNa1FH8sdrjHLhuDuA0p9C2OdvUe02AU/zBlYcl7ETyAnbymqnAsbgapPI1YAl02bX6weogsOik6qs9xPL39cpm5jYs3lobovNzORPVTgCkEz2o0zNPtt43cPp7E41Z40+PqJx9tNLplc97p0MYV/JwDbIpH9yTj+3j7ZuZQ3LPUnOn0gx4x0hiABzmdqsnb6j3BytlG9ZKNcztXSHESxFYaBS20GN280b3ByPlcpLotzzaZUGPL1MPmTTl5Ux32jM+wfmsjdd0zSMoAEqVkzVVOGb9na9vUHHVVChw5TaDF5uZ2YR0wvFSiwE/xCGJQ4j+694cUuJ+ovCca4nvXYXgfuRmxfNlNLsfMkTAnuvLH9CiTplHja16LRC9nJT8jSXSXtTgAVo/iC/KwUwBPDeUgNZ8TJx/Rm6sI/wwy6D9v3yM8MzCQoqP7CtWLeRQ1jynpU7Y6GJu/4u7d6plEu/KYOWoo9lA1y6rZrGbOc0rGB6xKT5C/35F1iKQDtz+V6CmylrQhGcZLRpNmvPCpBZHVdDPDONDqSzG9xVzYVMlxDntpdZSn/4XlAui4S0USRtFtOi77PT0GH1jNKUP7IeEIbW+v3mNXiFxo9Hx2Ow325E8EJy+wULbXe81ZX05hO9obLVdHo+8eEI1GGl7jwfGA1r4N60NXg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199018)(478600001)(71200400001)(55016003)(54906003)(316002)(2940100002)(38100700002)(38070700005)(86362001)(41300700001)(122000001)(66476007)(64756008)(8676002)(66946007)(66556008)(8936002)(4744005)(76116006)(4326008)(52536014)(66446008)(9686003)(26005)(7696005)(2906002)(33656002)(6506007)(186003)(110136005)(5660300002)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UmODg7J30i4QBewCUdrwn5uVDeNEn8n8w8zyfycpoBD0rhH8VVYMdQ2/TBLL?=
 =?us-ascii?Q?pV2AQO2lJ/sh7oABUoC9PEVinAEj3a74/O4CuGOfsxFhz6ESAoxIeKiCc5YA?=
 =?us-ascii?Q?UOZrGRyibj4gEHNcOGsAksIF6whnZE7gdmuUhD6o5284x0KnHjMYxe3+Zumi?=
 =?us-ascii?Q?vHXyx9227oBPMPJZUdip4rxsYlooTiTqdmNV4rR+ZugcPzKLLBsWkq6sZ/DA?=
 =?us-ascii?Q?M7P2dGO2kELQ0K8Z8IwnMd6a2pb2EcaZ+IZFT2uI71BMJ9znAZPZG/ei7DW6?=
 =?us-ascii?Q?HTEwcXGOeOr24cxceeWMfEbWMz6IVcVKe4qKFn897WbpiKLrYSSqPSAxic9I?=
 =?us-ascii?Q?gRZGI3HqRvqV8ayXDnq3lztNa/KaVA51cYBwXJANOnEDWvYUatka18pTW5C5?=
 =?us-ascii?Q?dWI6k+YMxj8HssG+jXwn8PTlDqn4XL8gRmmxUFfaJQiM34caOL8hIFFx2IZ6?=
 =?us-ascii?Q?r9BZr/ckC1KHBuRULk1s5kpe4oOJWBWJ4vYNfCI37Mu2o1NfFLGyBVfRoSzt?=
 =?us-ascii?Q?Qrg3TWQPKv/uwKTZp9Zl5K0q3d8E78W1nt7fpD/Zpp1gwPv9a9NNaaqJh5KH?=
 =?us-ascii?Q?QU5NufwH3GWHZBBOrTBQjCQhoHZMh0rWOMI4Fib7CI+thGN/p0WH0tLMuUku?=
 =?us-ascii?Q?iuG+LDdacjbxFlNqT49CkCv79E2W6oiBY+bI5NT5iSp0WvvwiRkzLTQ2Yfdp?=
 =?us-ascii?Q?BndMpNux8oJm0mt8nxcCXH6zb7uqz0mugWaT6BJSD+JcLJatc8zmfIMN2Ki2?=
 =?us-ascii?Q?wkhHplEVlVkwN3bAQxcNxv2i0WxDNHcdsHsFuWsoIiBW3xc6Mj/ZCFMvlEDy?=
 =?us-ascii?Q?wgyfeXDyRSNLYEI6wdAoEtR1RzwhW2ExsliAQESo0ZLIXW+UefBWLavktQfQ?=
 =?us-ascii?Q?iftg2ba64rv/1zf+bDTlQ1EQFa9eyqUuWCKaAyuiYhsuVXVbSCyClobtX9lD?=
 =?us-ascii?Q?ehG4XBsw2M3aPakyW+Cl5ywvNSN+JKlE6HkJAUaWO+vE260kWFTATPNhYVyn?=
 =?us-ascii?Q?gM4f4Nbq+Wivx9Cgm5QqJL95BzlV8I1/4wTuEECO5lhau5ml1pdQcVFLSwyX?=
 =?us-ascii?Q?XIuk37L5M31bUVLRJBZmbkue0WkLLqTusi3qX3QbiMze+/67MiMqE3ooDhbp?=
 =?us-ascii?Q?XAi2rz+47W3DPMNo0lD76DOVsmvVuYXDjwqFWYHeYhy2eTq2KKfHVr9P8bmd?=
 =?us-ascii?Q?hHa0mb2c76cpevC34UQ8abv7oPTmZg3+bGir20470CBWnlrh08ACyajQYync?=
 =?us-ascii?Q?4sbdLQ5Ps56wAHX9A24RNc4VOrR6dQuwjxXhF/6yE2slBB9N/RPK7CcydsG8?=
 =?us-ascii?Q?uwoGChT17TKorzyO4Umpl6akZowC0fHp37Al0xO5dyn0fXyVQFkjPBqyA+Jt?=
 =?us-ascii?Q?upi5Yts7hSoZX2SYS97kSiBBMlvKyX0+IcSJ3TGeCtaXY5bqc4PAl9Ae+YmM?=
 =?us-ascii?Q?DaYsPrtrMqlf9NjBhJWx+mbrKsTtyopEQZ74rNkzJMsSq946dJdWsMtKOuSn?=
 =?us-ascii?Q?/SmRFPf3Lp+DWftOKfGbnCah8FeaEePRJoKnCHalVeBXtPxhTbfjodDbavc7?=
 =?us-ascii?Q?rWhPOS0sGJLFS/EA2Ws=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c209d42-a6a3-43a3-9897-08db2a5154b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 21:15:00.4715
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c/fa/F1LC2+xPMUmUwFJRizr2AKRu0I9c4HgO50f9IkvG3GvB7VsPjVdwCaINhNS0mufWHykLuSjv7mNHlsL0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5066
Subject: [virtio-dev] RE: [PATCH v2 7/7] virtio-net: Describe RSS using receive queue
 handle



> From: virtio-comment@lists.oasis-open.org <virtio-comment@lists.oasis-
> open.org> On Behalf Of Parav Pandit

> But I guess we can describe by duplicating the text and avoiding rq_handl=
e as
> you suggest.
> Will simplify this in v3.

Looking further, we refer to rq_handle in more than 2 places, at indirectio=
n_table_mask field too.
So I am keeping it, moving it ahead so that all 3 places can refer it.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

