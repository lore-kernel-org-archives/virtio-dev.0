Return-Path: <virtio-dev-return-12981-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 116E5EB64DA
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:45:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6179B4434C
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:45:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5A9E49863B0
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:45:27 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4C54A9863A6; Mon, 19 Jun 2023 17:45:27 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 339579863A9;
	Mon, 19 Jun 2023 17:45:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QY44W35m+qzuwslT+heI7UbedQAHIvN8jtjhDzsVxsrh6RF8RN+RA/g4p2P41N4DeIZA+eKIVlRFVxgGFTGnOmnT08D4dAE+GvoWsOKQKz9CYySbtubMoaYi5L7U/xR8VJzZp3mEPmJ9XNq/dE4rBQmhcD6/rIpW+FUtFfeU+CpJDF0Q5uvgyGnuwyva1geNeGXji5FGXKOXNGBMAaMQUBFxqfwrmfkyb3hwAMRsOOMpBvDza0QKG+vnkMIW0KCqZxslEp8zM7hjQhn0nb15pemh3vQJaAF64XTRWJJGPqebkcbj9UVu6wL6ZKVZI5YpF2gB4acxQv32HFQb8tamCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trGCBJ6WQiETk5vzvyp6JPyw5CdweXEoIlK1mTsXm1c=;
 b=AnsrGXkLW5k5TXk2SXFu1R5L8nMm/6YJvoq1h9zR663U1dtiS0zjwLGHI06s2k7L4J6dXAeJefsSpVup5mLK5n6ewsddsF982WRpzP2ZJOgbLgubfeMyvx32q2rzr/JRY20qwqlAFMtZgJaAwB0h6k+VELCDYtEbsIW1GzM3Lm1BXOXc06cWT0yv+LSW4Jmk8PKfRTtKcsHJ6wiicaouWvl5wzgNKhh4JqEOVMHMlKbOa6CHDJBA8BqF4NOUMfxX96x1DawXe63TArLqhKyk2/jYisTUVbD7qZkWivHZLbRPyViF0jc7DthJBAtswi5WyZEkJfmLO48Ghf+fF5thaQ==
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
Thread-Topic: [PATCH v6 4/4] transport-pci: Introduce group legacy group
 member config region access
Thread-Index:
 AQHZnhzOtKzAnSMZqEmlUO1lSJmuDq+SXH+AgAAALsCAAAuagIAAARvwgAAD4ICAAAFGkA==
Date: Mon, 19 Jun 2023 17:45:17 +0000
Message-ID:
 <PH0PR12MB5481E624E00FC403C9ECFA03DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <20230613173015.1244486-5-parav@nvidia.com>
 <20230619122836-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481758B8EE080750D6377C0DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619131115-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481D1836A5B9A7B345A20A8DC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230619133322-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230619133322-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB5264:EE_
x-ms-office365-filtering-correlation-id: e1b76550-85f1-40dc-39a9-08db70ecf1e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YRQulIoGl7IYvLAXIfZxHL18fXy0MJ8hl05LypH5iQfwHkHgb7HFK2PaYWvNo+LmA1QC0DOgGXhWQxIhz5l19vIestGDB+5VKTkFJ6HlQ6ci2fwBD2bATiJoTo8UAfRzHV/qIDmRDdtHFZn2oMmnwqsOCTizQ539YM7yrRfiWjISEMs5h+2pYzfqcaJY1CP6t/D6acdKyxYqGhJKB/Zs2k4/NpkcIkEtFXBLU9x8fFPCo3/SkLxQKndfWz49YLaXPBOEOaQ1gxwoWTXi3DV9j/bYthN+mnncVtTT5N8JYXrNlLNYrq6WmbUa/RruV/RL+cuol+Ck255djzmASW/uLE1pCH5du4pr6kemATlG/E0nN64KK+GbxxLMvhPjiN6fgGFM12OiVuPhD0bJMJKUENE4IP8Z7gD7odnuZN25pJzAvccXYEVl/QIWJbkeg6VlHsfdn655EF8F+6LEi/QvxPR3BZck0LgiAuRFdoHeQl089hHTdEsDTj91ALn94Yn4Q4q+AzGD4qXdlOVD6zGAi2P1gBzORAxBepOdZ9sO75ghG1ya7Os1gfxZkI6LVjMXMhJvOyaFyvtnk5z8Z6vQqSPzpxkW05k9FFz0CW58v9avbPBjuIQ5lZRlV032Bq+V
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199021)(478600001)(52536014)(66946007)(76116006)(66446008)(64756008)(66556008)(66476007)(6916009)(8676002)(4326008)(41300700001)(55016003)(33656002)(83380400001)(38100700002)(122000001)(86362001)(7696005)(2906002)(71200400001)(5660300002)(54906003)(8936002)(316002)(6506007)(26005)(9686003)(38070700005)(186003)(107886003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HIZLw+czKMJWUw7o3MiyJBU9g4jggL9K7C9UpjZipXLwNbHbqn4vHkUBUZbz?=
 =?us-ascii?Q?LQ+1ilsN6BDOH0p9+2LAhwhP4Lfuzf86KVCc0zHJRFF0KAYKSk8FhW/glrPZ?=
 =?us-ascii?Q?5+SpjMmK/D4Xb1jP55HREz/NzkHjoTOCz5UkK3lHI9FjX1M/3mjfW9hfBpmT?=
 =?us-ascii?Q?qYzDSw575ZR4aYB/qjwqK3jnCWHsi6iM+qSSmcC+/Olr/difOySFYewoLTsO?=
 =?us-ascii?Q?B15gWPCD8hoTq1vtZwJY5H6WH2V+iNd3QD7vyNF9kcGv6BcKzdJSel62a1hO?=
 =?us-ascii?Q?YCpCorBZiPuo8+yqb85O9eymqdsGisCSb6N/Pl/sUFa2GG5h+2jnJ2mg32oL?=
 =?us-ascii?Q?xj6ShuI6JisFwTp9u+N/wJavndx8DpZ8YeqGX0Bm5JlBhGPiXO+t3k/nli/C?=
 =?us-ascii?Q?mFXfoQaS2n/5TIq9LNYIpxYyvOxikh+8uGiRFey8LEf0pbwA/2laMd3Frv0g?=
 =?us-ascii?Q?L85sQNF+0p7FqU99naICQ3+H7sXByfeizYd6ciflCZLQPr2SDxeumbUnm3z3?=
 =?us-ascii?Q?3hefMqEAiPDSKqtZ5FtijVvDI4zih3bEsdbHkQwm2eQt8dGtvfygS9AOJw/c?=
 =?us-ascii?Q?YhuzT7Cb6eQ0muSj0O9n1bp2fHKZnkIe1WFpPMFpxcc1WgdJOfn5uNrvJNX/?=
 =?us-ascii?Q?76ybbfLJkhGvWcxaBIHhi2k7e9dqvCpv710eAopNmbzVEwuqqG6Q9yUGOVcD?=
 =?us-ascii?Q?/cPOU3ypQxLtHj38sJb1vf6iQKjdxOJSdNwrDdm0PCiRpHPy/DoowfpX289X?=
 =?us-ascii?Q?dHXWSk7JNMwze1QHDWWxzbSmg+dmgfyCYQE66ZqQ+89IOHnxz1qDdABLoAv5?=
 =?us-ascii?Q?q8xErgLk8pl4cGsxXktUhyI3aBGV3b0BD0MUn/dD4N/sfUuKcgI6jHWedG1I?=
 =?us-ascii?Q?i+ylfZQnOcLza5Dx+o+LvW5jZ+IbcAzaLIynslL98iePWNFJU0L9oHN0WTlK?=
 =?us-ascii?Q?Luj6NOfl3c31JqZVtTdrVEpm+Bvn2eoiEtneJ2TsbTy56JXLpqw+63Ifg2ZT?=
 =?us-ascii?Q?VNy8g4ARne97tCbWLd6koewvXTnF6EgO98PQuQi1/0xCPvC2Ps2Rcpu5Jgns?=
 =?us-ascii?Q?ZsvMIPdC+G247QzSajYQSBjj8TWeRntlTGN5ufv1YForZfr9+vFhY+gK6Mcf?=
 =?us-ascii?Q?B8IJuWFB177GFpBxFv3I4y59zNYELqQSbvic1zlc+YRx9Nka4I8lom9VcT1R?=
 =?us-ascii?Q?74RO2IRh7PeLGPlj4Bf3gukW0YpMFHQhXfxlm2dZBcDhsgAL43cMLm0lhZIa?=
 =?us-ascii?Q?95FrxXd+WWmqdAhgu1cVWnhlwRoa+mbBs+q61K4L1i8aII+4LAeJLuP5fWKn?=
 =?us-ascii?Q?ZPaSZe354hvPUwVrKg6irQM1uMVy2WGukBuUY9MIptzBIPd/dqW0B2zIbvmp?=
 =?us-ascii?Q?HvXmEAsRUW0xt4PB0fXK34rHA/d8/diURXDNut5lUxg2NFtnGmV1HGlVvx4R?=
 =?us-ascii?Q?HBJrQDtZyIP+Nt/hwydlYapqPX37d3+CaZg20KQxHlE4TZqojcdXEUc/KFW8?=
 =?us-ascii?Q?0v/y43CumP/2eDh3kOnNnxSS2nNVxPzUsNKSgYkiSpdTVSwt1svfMNeRJ9Fr?=
 =?us-ascii?Q?2QM9sNRLNxMGktebBIo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b76550-85f1-40dc-39a9-08db70ecf1e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2023 17:45:17.5323
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5iHq9FjvVhhdo/xZ10/Ytb1vcXywJHnRiAXJQIxxgg4hnoBZAj7SDmneTmHw6jfwXV77JcGP6ZVjC4VhXzhmaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5264
Subject: [virtio-dev] RE: [PATCH v6 4/4] transport-pci: Introduce group legacy group member
 config region access



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Monday, June 19, 2023 1:38 PM

> > > If we can't just make it come for free then maybe
> > > VIRTIO_PCI_CAP_LEGACY_NOTIFY_CFG is better, we can just list the
> > > number in the common section and then link to the description in the =
new
> section.
> > >
> > How is it better? It requires burning more bytes.
> > Is it better because it is self contained?
>=20
> Mostly yes. But it also adds a bit more flexibility, right?
> I thought avoiding touching transport-pci is worth less flexibility but i=
f we can't
> avoid that...
>
That flexibility is better gained via AQ instead of introducing new extende=
d capability on the VF.
=20
>=20
> > > I also feel we want ability to have such a capability in the owner to=
o.
> > > Would prefer including it now though I guess we can add it as an exte=
nsion.
> >
> > Re-opening the past discussion.. amazing. :)
>=20
> OK fair enough.. I guess both of us are not 100% happy but it's a comprom=
ize
> for now. And maybe we'll add one of AQ and / or PF cap down the road.
>=20
> > Why? How is it different and better than querying over AQ?
>=20
> Wait a second let me clarify. I am talking about notification in the PCI =
BAR of the
> PF. *Not* offset in PF capability but in the VF BAR.
>=20
Ok. question remains the same, why not discover such notification capabilit=
y it over the AQ command?
AQ command on the PF is self-contained and extendible without baking things=
 in very low level hw centric pci capabilities, which are hard to get rid o=
f it.

>=20
> > I see the AQ is better than group owner and group member specific cap.
>=20


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

