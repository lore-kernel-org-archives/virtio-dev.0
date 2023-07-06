Return-Path: <virtio-dev-return-13269-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FF1EB64DD
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:53:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 60CFD7AEDB
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:53:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 532B598680D
	for <virtio-dev@archiver.kernel.org>; Thu,  6 Jul 2023 16:53:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 422A698672A; Thu,  6 Jul 2023 16:53:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2D037986729;
	Thu,  6 Jul 2023 16:52:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgPa+GRuUnRb0lIJDfPR1Y2Kc8c8athounTfwJyFhxdFPN7Jc2rYjrubOVVGTw4ahhV9rOX2z2e7nKSSxx7GjaURmvB8Md0O88AzdVpviyvzm/YnaUeIrmIkQkGeh8UPiovZD9p0kcFbmW3nqE1jf7bFQl/NAWCjqybqLmVlF9bbMjGLJmbPAKBhewzyxJReeY5TRGhKCk+rR9QeO7WdKK2mBKygc5tEBksvDmZyluNurq9cwkhXufoFJhIYLsYI5vp0IZpTV0r21/m9WtCy70saysoSiOIzKr9G1ikxQlhUDKGflPzi9eNjcc/RAYeJfxhI7xXiHPa1TBjFajBtig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dkS+SQVbLNGNJemDVJbgJiw5sBANF6bMcf8CcnrqMo8=;
 b=aoX+Q0xQWBLfjvrPo4ptajgUBCZ1Ax/cUDdVz9mi38vY1Hit/ajBBC1GSIful07DnoBj8e/GqaOKcyI2kBSStS4wWdin2N1CiVnj1Y8sLT/uan0/Kqalr2csl66HugIULzfc51r7Fzjr0d3QfZHwWp8jjoEDv8tXfKX/ha3VoCdy7FLFsyHkopIxCwNGwfKA0qqkLEZWII02tCGXnTTMO2DAGLkDylivHqNqKQImbWiRNgDF8YtFuDkIyBSa8+5O6M0hIJb12Pcu1doTWBSlktvTUxOxkx5qwEC7jT1zf6DxEQnkEArFzuloLRfw9cMgS88ozrvsNcx4sDaDp2zfPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Cornelia Huck <cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"sburla@marvell.com" <sburla@marvell.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb
	<maorg@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v10 4/4] transport-pci: Introduce group legacy group
 member config region access
Thread-Index: AQHZr8EFxUk4agfAiUezeNF66UoB2q+s7j+AgAAAMsCAAAUmgIAAAETQ
Date: Thu, 6 Jul 2023 16:52:50 +0000
Message-ID:
 <PH0PR12MB54816EF40633A94A373EB33EDC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230706041714.65600-1-parav@nvidia.com>
 <20230706041714.65600-5-parav@nvidia.com> <87r0pluhqy.fsf@redhat.com>
 <PH0PR12MB5481ED484C57428AD3D959C5DC2CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87leftugv2.fsf@redhat.com>
In-Reply-To: <87leftugv2.fsf@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB6633:EE_
x-ms-office365-filtering-correlation-id: 93092786-2bdd-4d6a-9984-08db7e416f26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 bVF4w97FZfesNOfmdcd/fTBy2utXHbKimEk8DWI8D+ZjL4ga0w+3B66PsXFNaejN1G+6PZdFgKSBqLVuehFSoHTMN4Dy/+9BMlpOH4qkU4Rdx2VVh3DdCd5K/CVWvg+hpk1s0x65nAavE8montRJBF0VTze/ao7w9R2POEM6WSbFzPX1Eko7BfvvZi2LzE/d3NKC+EQ+03Hdn4wM0HmPYH2BvFo1KhMUwNMwfAIOoD5VAmU45ESeSH4Ckw6Giigkkr3WJiZAg9jdWjm94Z0f6bTtfYIbIs/2kh2fV8DdfNdULxPy+trogHaAYa+hF21LtLIITYpi4sGHU2e86DvObC5AthrUYzxUQ8ajYM3b8LoFy6h3PNPpTNHcybefq95ok/aD1ARmHQexvGDm/lc51QF7YjBoH9Y9bU3lQs23XX4aGSUpMGWPV+DKWyBqjn0bUuno8UVmCZyAOeuJ6vvi/VEWIz9WPBxvv/RY8Yj4OLsiPMCFVVNfZzKNu4b0I5bj5Rq01K+3/5ku4wT/WY/bLAtLgUlnAFNFfQqhthK/SrhDfzh/UkrDTZZ1P2ncTwGk2QqgFiQIW36LPoPoteK2MsKL3gJ4nRy72ZToTWklFQOQYmhM54J2CiXbeVnZv4C4
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199021)(9686003)(5660300002)(8936002)(478600001)(52536014)(8676002)(41300700001)(66946007)(66556008)(66476007)(76116006)(316002)(66446008)(4326008)(64756008)(2906002)(54906003)(110136005)(71200400001)(7696005)(107886003)(6506007)(186003)(122000001)(83380400001)(33656002)(38070700005)(55016003)(86362001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4AgLIXX+JtQUC9/yEpwXAIGWB7o3rFS6FZhKymbAa+cmkKQtRNVvF581mZdb?=
 =?us-ascii?Q?huzCWgagu3JCsI7gVVsjY6gGR/qt/psmYtd3T8hDgCYEJgzXD56kvqsDUQKw?=
 =?us-ascii?Q?POPgwmlLcYcUIWPWvnj525tPAb1sdueAiQixF4NcuOzPHcq0VeGtdXbggWoW?=
 =?us-ascii?Q?TU0C0w90LsnJxOkSw9S4BI4d8vUvAK+33/y0ixarLie1BEBOxFJRdhoxxWdN?=
 =?us-ascii?Q?xWHVmxXW8XSBp4tQLSLcPOmNnCg6M8ojg8cPERSbYPOcdu4mDe4gchvpX57i?=
 =?us-ascii?Q?/mzWjKWjGYI7ZQIf/xYYYpXPQ0yAjkTeYp4X9kdf2cXi0EPEQndzJO3ADjkZ?=
 =?us-ascii?Q?ewmnU249UQiYK2j6CdmdqtEouy2KWTO6leSmwh5/86CWlRV8N8BNJytgthiC?=
 =?us-ascii?Q?jRXqrkBGqPKCxgP284WU/LDUm6OI2Pb5teroxITR5NXyRJiw0q496MxxEOOE?=
 =?us-ascii?Q?LslHezet9EcKMsdrJLSSbdVO2v8zT1JtNo28BYMCzRndNbE59TyF1NYBzPfn?=
 =?us-ascii?Q?RN3VmahB7UxC2Rb3g+IpA9YMNs5mBGzWqyqEo//sH2dS4v8uzJWTkAIgc3Zg?=
 =?us-ascii?Q?b6YPob9C/tAhi9xwVVOpad/75piuOi0+karXO/ItPjvio/pHAT6BG88z8dHW?=
 =?us-ascii?Q?CeTJqQQSIquIx69VBpuznf/8HMI8YApzq8NVg078xKlmYYfvcxT5B8LPx6in?=
 =?us-ascii?Q?1LFJOxivh9l0CSF7Fccjwgb7HioFYikNEhF1Jjwlawi6ZP3cnhUNT9PKnsNr?=
 =?us-ascii?Q?NlVMtijp0V9Tr5vl9Bt5RDYRBWiVakSd4IGNx9HnT9sXZdJyQZfnDckvjCST?=
 =?us-ascii?Q?pHDdBiwWz9mGC5IF5YTVuBKx/N3cgcQGFG9uZ0C+XTQmIN9UB/SceR64LqJm?=
 =?us-ascii?Q?ydmROo04TU3ohukz5z4EXn3v0LBIhJEKb9B6TYCJj5cB2hTQV1fEk3CjeHaD?=
 =?us-ascii?Q?KFbCmwWxCp0TPLv7OSPHXxVJvMbhnmgCZHG9E9ecGSudaONLJiGbHrraZBCz?=
 =?us-ascii?Q?wOhkSHH1mZn0e0OnUzkpM5b/wUdtOilueAB55kBL/qO5foOYmnTcmsxcMJgz?=
 =?us-ascii?Q?Lh1eyVjp9WQF5tCWdgfsVvRUNGRXWski2mwX/ft4ZVhhv/wWnRDIdRA1Pkqw?=
 =?us-ascii?Q?uXKKk7y6jZ0C8MvL1rIIK45zLh5OxeJdAFDwApSpU39N8VTRC8zkcsY7BUb5?=
 =?us-ascii?Q?0KuFGC+OyePhshmc0I03aIHhgockDJFauQjWFOW8Q9yBpYGBmR3OQSyO/JPd?=
 =?us-ascii?Q?SfVl7Hz9C3KJa4XyO8d879wtyH/sjrTdJeb0hntKvojwVrAd1g6jS6wh8rJw?=
 =?us-ascii?Q?WI9qroOenhkQN7V7/Dpthl1pBH+dFnB+J3MXMG3T7OIixo6+ILSqaYpyccPx?=
 =?us-ascii?Q?XCs/NBHb9Yli6ckKKmpujiX0xnKXF4UUroMuWoTL1qs+Zg5w3l1EuQ99TpuX?=
 =?us-ascii?Q?ukj/WhAvLegk5szNQrLb8KVP4UfYfMd0vnYGk811dd3w20IKvLF0aslYnRlx?=
 =?us-ascii?Q?6qAF1QDErgvoNYgENwOSff3LOouYD0TmcwTTafY8Oj50bqXbBxmu3JVasDCn?=
 =?us-ascii?Q?/Pkvi7uqxC5U3LwYQZymTjMc0M4ukQks8Y1BUDx1ElaKIa084JcI5IGuGoFe?=
 =?us-ascii?Q?Jt4yEsIhF1pVe21W7//E0uE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93092786-2bdd-4d6a-9984-08db7e416f26
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2023 16:52:50.5498
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GQdNxOVx+9vipatC2Aq6hwcdz7hQLbt3aEsqB9oqzBsDN9PZrj3RMB/zH4cgu05TU4JR8cWCQHGKVlpONRN0Fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6633
Subject: [virtio-dev] RE: [PATCH v10 4/4] transport-pci: Introduce group legacy group
 member config region access



> From: Cornelia Huck <cohuck@redhat.com>
> Sent: Thursday, July 6, 2023 12:47 PM
>=20
> On Thu, Jul 06 2023, Parav Pandit <parav@nvidia.com> wrote:
>=20
> >> From: Cornelia Huck <cohuck@redhat.com>
> >> Sent: Thursday, July 6, 2023 12:28 PM
> >>
> >> On Thu, Jul 06 2023, Parav Pandit <parav@nvidia.com> wrote:
> >>
> >> > diff --git a/transport-pci-legacy-regs.tex
> >> > b/transport-pci-legacy-regs.tex new file mode 100644 index
> >> > 0000000..ceea28c
> >> > --- /dev/null
> >> > +++ b/transport-pci-legacy-regs.tex
> >> > @@ -0,0 +1,42 @@
> >> > +\subsection{Legacy Interface: Group member device Configuration
> >> > +Region Access}\label{sec:Virtio Transport Options / Virtio Over
> >> > +PCI Bus / Legacy Interface: Group Member Device Configuration
> >> > +Region Access}
> >> > +
> >> > +The PCI owner device or the member device or both support driver
> >> > +notifications using
> >>
> >> What about
> >>
> >> "The PCI owner device, the member device, or both can choose to
> support..." ?
> >>
> > Fine too.
> > Any thing wrong in having or as above, so I don't write it next time?
> > Or that in current form reads better to me.
>=20
> Just a bare "support" does not really tell the reader if this is somethin=
g that is
> required or optional. Dropping the first "or" makes it read better for me=
.
>

Since this is not normative,  Iwill write it as,

The PCI owner device or the member device or both can support

=20
> >
> >> > +a notification region defined in \field{struct
> >> virtio_pci_legacy_notify_region}.
>=20
> (...)
>=20
> >> > +The group owner device or the group member device or both MAY
> >> > +support driver notifications region.
> >>
> >> Make this "a driver notification region"?
> >>
> > Notifications are generally more than one and spec has the section "dri=
ver
> notifications", so...
>=20
> I'd parse this as "a region for the purpose of notification" (and "notifi=
cation
> region" is used above)... but in any case, we need the article here, I th=
ink.
Ah ok. I was missing the article, I was thinking to write "driver notificat=
ions" vs "driver notification".
Will change to "a driver notifications region" as the article applies to re=
gion.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

