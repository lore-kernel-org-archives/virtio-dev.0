Return-Path: <virtio-dev-return-13164-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8678EEB64D9
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 21:28:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EE89E88E07
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 21:28:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E55AA986724
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 21:28:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D72D69866EA; Thu, 29 Jun 2023 21:28:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C4B88986677;
	Thu, 29 Jun 2023 21:28:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3cscwQ6SDopXi6VdFR757ww/fXfsVjuPTOUQCjtAOjAbSBEfbH7Fe4GuU4Ogot+XQ7te1+KNPt/YBvYpC3wB5SP13Jkj3usrHqG3kcsyTz28xs2SkHlUgjd+sl9TivfKv0mWsoY6qXbav3K1gc2G/vUaw5B+QOzHWlaa2RL8e9kcAkymqDj+dNSUVtReCGb8xKFBud6Fau8igVainOzc7KGYtlVS3CUE98eTJw9mxoUTmo10zgJg5VW6OjnuzXDqACe7ySS1Hpx7F2PtLJvtbXAcrg2ikjZhBUJox8ITqc9aZz+JVe8SvXjgOPm3IP9kq5O9A4GVyzVGkJr1r7Dpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xX3FWCoU+7FnS+fzkW7/0DxA0OetXVL/sdmGaIWqhEo=;
 b=UUzxm5g1HZ9SFH1yiW+v45c8M0qsd27zHYsvrz9AvSHyjHXz4oTKWs4oj3rftXEi4Lhb1D1sgc1pNM3QHsOAq7vgTFaip/I39EOpFkDBKnABeG/nAVlaNq4plIr6P6Dxqwhlx7ZRYJLfMRgN4QbvWRsKPDMUU/kGo9tWwWWFeV4X4/CKsl3swjt8VUYpSyLFc776G+Gb8wg2QGyhB4yIZrDqc3kxnUy6cA7lMmpRUIClUhUe3MlvYvPcXguXS3ELCrAq8/N+yTrz1f+oDYuCX2gzBjtRxxjgp1K/YwPaalQhRhZUMS+HYYqkFCwNm5U7rZ/Yl67AeyoT8s2GbjZXdQ==
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
Thread-Topic: [PATCH v7 4/4] transport-pci: Introduce group legacy group
 member config region access
Thread-Index: AQHZqTvss7QOWMrqzk+6ekRzXD35Ma+iMXsAgAAdJ4A=
Date: Thu, 29 Jun 2023 21:28:22 +0000
Message-ID:
 <PH0PR12MB54818BDA97368DA042CC0C06DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230627211050.1527507-1-parav@nvidia.com>
 <20230627211050.1527507-5-parav@nvidia.com>
 <20230629154134-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230629154134-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MN6PR12MB8567:EE_
x-ms-office365-filtering-correlation-id: 6f916cf3-cb7f-4ef8-f550-08db78e7c452
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 bLn0PvyDJ/uDF/Ru4sVecAfsPVYTzQb0XggiBnV+vvIeYjbdQaRtJDTgWmPXLWE63UCCykoQv77oFeAzzBfv/0X9fcEHHOJs1+NNZK2386h2nOAwvn6PqErvms8UeETUs2k1/DtnR0dnhd4dzV/com0ew98Gz19yGaDNEPCLYcqjG0jUNGA2u+9R4hk6mY4vVW9/mfZjuBKLkukigBC+c3HwQKADC3BZDqnclRFqKQ+M0fy8iSneE9dh727Opet8lEZW0otoUGfFLe6WB/kGm5KIgnXESQlUQpq89Hjtov2dWiizzY/STb61fvWwrPq9V7jjBiKrqoc1qlt/AOG0FWKMzM8n+bONfALUEgaB1iVWUPtIoaQK5pHK+bx8OGAOxxfm9rzPa/QeWCeFkETpnvimBNQpd3EY1c7Lg02mx5u52EdenkreRyLpuAk2g/kIrD11tQ+7jKO2amklm3wUEkwokzM8sSVFW2+hwvETd5KosXZi4k3esQUXjGxrUJeOIzsW9YM6xuahr9JP9twy67stbwC7sBNxKGvNing4VoaWcCWM4TnKH1AEzMwMiVWlrt1qiPh2fv9zMKuWJ9RTRwFy8QdRnGN6vPWlFTqCpuy1jgCTfVOKuqXPLsoNoMS5
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(366004)(396003)(451199021)(4326008)(66476007)(66556008)(38070700005)(107886003)(6506007)(478600001)(7696005)(54906003)(71200400001)(83380400001)(26005)(186003)(9686003)(2906002)(4744005)(66946007)(76116006)(5660300002)(52536014)(8676002)(55016003)(38100700002)(64756008)(33656002)(6916009)(86362001)(122000001)(8936002)(41300700001)(316002)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?10YWkAxxdKVEtStHf057SFqzcPjkAw+D1Cuc7RyZZ5W47I2v41pQwr6bcK1G?=
 =?us-ascii?Q?sbTL2Wn4Jn6qv+WK/dJoiCDmAlHL7PZ2hrvqDbQ0ZqSzObIjvDlJR5v58b9K?=
 =?us-ascii?Q?aML4kGGkQM888aBjh91FOC1LEPJaWg/cItGdFOB7pzRQ/llMiZnZls6iIrVo?=
 =?us-ascii?Q?fzW3tpzPiiSSqB6dYiPyL/JbYC6yvgTLJdSbZ+F13yQK+Vljitoy3N8xfUci?=
 =?us-ascii?Q?Yly7ZnW5oaUyxqSn9LEZ+Me5Xd85bdFgjsH8IJjG9C/o2QgPNQu1+XJjG32q?=
 =?us-ascii?Q?729cczwjSSz7mcuUtese8cFxMfholJvMLyFefk7U7csLHr0aK8VDtk1FoJF4?=
 =?us-ascii?Q?S3lkIETiYRN5oWYfE0tM8GXtbP6PYJgfwOufs+pkRRCfU8Ryb989McoAk0cq?=
 =?us-ascii?Q?nIXnyCG6e6IEtWKmeOBDZ4GWWKCELoHa988iTdQ0kpfTlaMtboN+cv29s3W1?=
 =?us-ascii?Q?Y7TPcl3fks3VAUWfFJttZgH7ycFFAsKeea6PnpoECKT3K2Je/4KPevL+2M8c?=
 =?us-ascii?Q?jnOSfYHOhDYlLzPJnokgpH6/nD7JVmalCzAT4Eu6vTPNf9jQ8QO7bmQezA5b?=
 =?us-ascii?Q?Dx25j0CxC/BcGDk0TCRINwn3UTXdn3Aa8b/TjNE+ld9QizdZ1bMYxCZ6zcyC?=
 =?us-ascii?Q?Q1xfx8xhQsUg/pHcwOsW/Z1Q3AA5A2ptsv103yza7nAzXGsohjD2SBWyv4/3?=
 =?us-ascii?Q?Gp1HNxxibHxwGmryc+zLiRLN8EMatcQjK1E1/6LQwjQTmwinolFXyGwHAeAa?=
 =?us-ascii?Q?0W4swsMhFkYsJ0HIEC57GInKuU4GtKzL5opHg5i1xe41nHhYo2ZsxID1tfiV?=
 =?us-ascii?Q?goP6gTtOjmrnCsqeg8TLCPJs3MvzPoGgc0rOKozJrRokFIdcjcrXoWHw4+HR?=
 =?us-ascii?Q?EXkLmndi+SPi0KQac6vMleAIVgKUDVekipAMY4ZvIJoyyPufVZoLcPJ3JIwq?=
 =?us-ascii?Q?eB5L7RKj5R/AdMFAULMkWGKYViPxqVh9nbxYkDPCEX8hiG915QqVo5cq0EXw?=
 =?us-ascii?Q?ZRSiRf5UN7ZyoH6cEk8Axh7UcRARgaGdX12p/N7xQkSXhG72NngUR2yKljZY?=
 =?us-ascii?Q?mrpV0BGcZfjoOTNG4t/zUnDqcwtIqJLhKH1KNmIvFuGDGECXOF8edT49Y2zk?=
 =?us-ascii?Q?eskyy+9wc+Wg2Q9UKyATYGf1BYqDP+Fw6x6wJgORvVOPHjiziGmbxfNID2bD?=
 =?us-ascii?Q?sLWpxOy87PZBB8Kvh/kriO6/um/8iHEvojpNAdoIKdAvtlsP6qKoY0Inu28d?=
 =?us-ascii?Q?QhAbHODO4WUsAgfPFZvnLKYvRpvPjxuAc25eaK0hoi1AuD+ylHf7+Bhe4ApT?=
 =?us-ascii?Q?Ma1rt3tFowL+lVgwtWC9P1ZbCHr7V71XtMvP5FG+EIwn+2XqF2T7+7OlVXwO?=
 =?us-ascii?Q?3UnKgoBUsPIXB7puOYEfd0txjYGpwImIF3TVABC5NViljxkj25M4LV+zrDHb?=
 =?us-ascii?Q?t+dEeTtelzU0RajT5jeOmm8S2Bh3ybD7N1s3VO5ZZEF3as5ac+h2f11OQkFV?=
 =?us-ascii?Q?tLaip/uP+dvkPxIYvSOBJyZHHaIUP3faJ6jOglTai0g8dlAQtvQWEXKC1WCO?=
 =?us-ascii?Q?AZV7jbThyLqB6CCXgoY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f916cf3-cb7f-4ef8-f550-08db78e7c452
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 21:28:22.9545
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yRqMTiCGIG1sMnmDlBeeX2Ri3cRU3IQfp4+fanyc0Ycs5h/Fl2N2Sn0gGaz5D3lbV77RGsPvPbQ31oZNQnR/MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567
Subject: [virtio-dev] RE: [PATCH v7 4/4] transport-pci: Introduce group legacy group member
 config region access



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, June 29, 2023 3:43 PM

> > +\begin{lstlisting}
> > +struct virtio_pci_notify_region {
> > +        u8 owner;    /* When set to 1, notification region of the owne=
r device */
> > +        u8 bar;    /* BAR of the member or owner device */
> > +        u8 padding[2];
> > +        le32 offset; /* Offset within bar. */
>=20
> Let's go for a 64 bit offset straight away.
>
Ack.
=20
> > +};
> > +\end{lstlisting}

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

