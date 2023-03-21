Return-Path: <virtio-dev-return-11684-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA5E8C6FD1D
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 20:54:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 354681CA24D
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 20:54:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 28C4198644E
	for <virtio-dev@archiver.kernel.org>; Tue, 21 Mar 2023 20:54:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1E65F98631B; Tue, 21 Mar 2023 20:54:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 099B998643D;
	Tue, 21 Mar 2023 20:54:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Es3TLj+QDNDSEO9dBb7ymARRKP2972McM/L2hVzTptQrd/P7aZ1PZp6heevFjDhzcpVw3CqrN4jI58985me70x6WFTLj/tLfMF0fLNgPSxl7Xo4a9UBIAKBFPW4QqG6+TwSTyy6UKlMyncPw76+qaQ3AOjzmiryfJ+bta3vbrtGAL9k07LXvDsMeIYHGQwf5o73Z4t9+I21/istq5yU27DnhSm/RiT2R0hxjSir3C39NkPzJvkHKjWZndb3ytYd/jbEgxgU9uUvdPkzOnbaMgx3RNH6MkZsttwK+YfQU34yjjSr3AP854SCD+PixfZb3zPZvfFPg8m0085JUoTLx8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XH8LkvdgomLFKj0ff50e8UfB/fdWe4IIOKHPHKFa/WM=;
 b=F4s0BJiMOq5t9hoYM1ykQjjq7chb3eGljBb4AsV6GzrcA1OKQ2eXHFm8ignhdHDmHximiAgP6D7ZAIv6a5tEX7KTYiJ3UoRkZuTT8TlD6eX1S5kI6tjYNlB3eHBbwV8kIphXfQgMIvKNwV54g3cm7XD7ZVWtfB32u0ZJf/IPSR86hjs2HSfY3ALhHGo1Fg8DCnCXgu+OOtmRzS0UBARAqMD4WSGnXhqTNt4ku6QYGFnYVL2v6fKOsAT86Z5zmuVSsvF3LUaFaY9dRLf7D1p8XujZKo+maWPftXzBCHKNwMJNPIel22uLlkxVFV1/74KscWJCkhWE0dZIiM3+MAEShw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v2 7/7] virtio-net: Describe RSS using receive queue
 handle
Thread-Index: AQHZW6srVZFr8uICDUm1o4jnp7AgIa8E7nUAgADGYaA=
Date: Tue, 21 Mar 2023 20:54:29 +0000
Message-ID:
 <PH0PR12MB548130EED53ADA3C384E5A1DDC819@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230321041036.201439-1-parav@nvidia.com>
 <20230321041036.201439-8-parav@nvidia.com>
 <20230321044737-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230321044737-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MN2PR12MB4520:EE_
x-ms-office365-filtering-correlation-id: fbb8c7c4-c55f-4d56-a1ec-08db2a4e7727
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 MbgeENPeXhdBKolYcf7gap8IxkeXodnqrkQHyHDYMyt+6QIdvICAyCEnocWcdK+jXR11jw7/HllbLDfPSxQe2FQL/sGi+5VINYnfR8EkTRdWq5Y89rvUTfQyRgIAC8ovP6XfEwQT4jL8Ak/hgH07NMhaeZuGftCmtCeYHWbqHcq4SR1bHXORdKMJMSsPnugbi5p2OZj2G+5efFNFp2wUgTszLhojeXX7JsjVZa3WwGDYt5ZidV3caB6i3TjQexwv4nfysbdteHAfrG7BrCOR/U9YICds3dfjiDTkZ4jDF8Xc/qtri/mvEC1BB/2C6YHDfL5mO0QKn00BwOIm9DIaIZSKMHQBqyVkzT/iNQQ0arw7Rc2VtsW+fNBG4p4fGpp7Rw0R4kIQHHyUJKSYFNWyuAzqcET2eKKLYq0flQEtCCtM+xJRR+bi36/3yd2XxxnOyljcDd1lV3jnVbLjpGLIfIqoeWCbaD7s4jm22CRjkdfYVQeapc0PWoX4M+neGAtKomHf2kLXYQYLUgR0ESnQOV2lG2QcrbUOWJ+D26+KyjwEBMQ0HNS8IMe1+IM1v2/8xod7LkVD/7qxDxaSRc5hfeClYUNxjTH4wR1gAweB+4deJ/LVTibbpZhAAjAorcNbkcSMFgjVfVq4ibhg8p/2MOYR4vhL3UMZ5BfE/EWdhoxqqYOTGIkadCsbkvYPuOCXu5jE2rbdjrngmr/EZBpqOw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199018)(7696005)(71200400001)(186003)(4326008)(107886003)(478600001)(64756008)(316002)(66556008)(76116006)(6916009)(66476007)(66446008)(66946007)(54906003)(6506007)(26005)(9686003)(8676002)(41300700001)(52536014)(5660300002)(122000001)(38100700002)(2906002)(55016003)(86362001)(38070700005)(33656002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AZkGCqU0/9PbMxCOe0uQ0TYbR2ABRwHZ+6DBigDmqcJfZ3km5iL9SMrAUS1V?=
 =?us-ascii?Q?ngwaGO4MIlJRYDioiFUJo0DAGEPyGgC9r/e7REEbA7HvjmdXJGhbdJ3Z9ETx?=
 =?us-ascii?Q?vJ2B0kFdm2XrhUMUbVYopCPu1bFsS0AS4vZIT52lUirtcKThY58576lIvy2J?=
 =?us-ascii?Q?2ih4s/tqqxs+FjL4ln+mPceu2DzmU9BkH3hH3SsyBjH+MLvczoPDRShNasQb?=
 =?us-ascii?Q?UFkxlkt9CdLT6a9isP+g5Yt7R92aYlPJQ/oLU3t33gohbiCMLmNL7miFZa1R?=
 =?us-ascii?Q?U3hQ8PGKjUnL46nRv09Hk9cXzE8osq1tOzNNIqOikZX976L3CyYGhDl3I/3f?=
 =?us-ascii?Q?5xSofSDIr8SwQklpZ4lXjaRhz8BP/1j5DSOk6XZqVlSlNsWKgXiXpTZfK+Jj?=
 =?us-ascii?Q?enb2xge36wUYYHiaw/TKq8aSSeRGhTsozKBJQLmgdwVrI8gBKa531VBYBKUu?=
 =?us-ascii?Q?B5Bokj6P2hP7uQHFHPmcCPQzQmMWznnabAYd+2gpOaOK6QkYh5i1EatGoUAT?=
 =?us-ascii?Q?ML5F1c2tX4gA0TXUQBJCKyorG2ExNO5m//xJv7jdMsvq9iso2+fWOrtCoqXV?=
 =?us-ascii?Q?2K0ivxX5jEY6/tkz84XhrIAcEdDFy63UFifmJtC71XGwWPQNCM4757FEr7mp?=
 =?us-ascii?Q?AENRCRGp+RPuIw0g9+DOsZ9sy06Bh+mlRWoJe9KbzAcE0F/petQwEnk6ozLK?=
 =?us-ascii?Q?MtKL9bsIrznLAuVe+wcom8Hc0q4154t7GSsxdAbsbmp89pulWvYrErxgNhnh?=
 =?us-ascii?Q?2rN5Do+Xv5QeZAHQX/ibQ+l/q60eTExqKhgbMboCJjzJDznBhfOiuF3x5uYj?=
 =?us-ascii?Q?JEaRNK8kfZjaP7KxSvFsUWABi/ztzzAeak5VdCFo5X9mWdcsY1c8ik11u6Pc?=
 =?us-ascii?Q?wvZdv4lU2D2abOGWRYuTt+X/7qFcnhCH9C3F37JrOmw4UkKPY7ejjNFbNzAl?=
 =?us-ascii?Q?4OntJSq3vFLjxASZEm12saaBLm3mPqOedlqAus3prZkoUVfAyTDDrMcRij3G?=
 =?us-ascii?Q?rSA/MQK/HXfdKJ3sa2GDUXt7YxHAMjCc5oxM20iF7sM3b7QWTBXLKvJYeJJV?=
 =?us-ascii?Q?RqioKgE4b9QzhVSbgvWXcYr08DSs9IOD+NRyGzKeEDE5z+kvLA32dzd4bPWR?=
 =?us-ascii?Q?StMcza3Aq20Kq9D9YGU7/oALOH/TPnPBrW4xQdviR57m6+X+c5RYpmiEE/sq?=
 =?us-ascii?Q?vDT8G9x19cE/KYNnbuT8KqM1vigjSCgOlusLYlBYVWKSBtlRyhaGCjFyP/Sg?=
 =?us-ascii?Q?jkQMsTMTC9ZqJIUeIwmfCcKAqNeoRuC195Uw/AstQ6KxgWCwd4Jc27mJ+khV?=
 =?us-ascii?Q?rh9lwMPC/+6IbkgKDIkkoC8TmBrb/LERWpGnloIdA1jyA36KVTpNZ5Fbo9Pl?=
 =?us-ascii?Q?rrgfbfhudpTND4/r9bRbqF34XBKSS+fv3ImVVmX5DLe72UZ3GcY+4Ykvxii/?=
 =?us-ascii?Q?uKx+cQeTTNrSMsHCQlzfFsrTf/RbvnrW8vniCB40EoA0XIOdaa8M/T+N2NWi?=
 =?us-ascii?Q?/fxPEmZF60MFahNxwmCeIVLVoFcRprhd1AOVpyprE222bP0iUeHLDAdXtg35?=
 =?us-ascii?Q?qwHWhTigPf4hiazufWk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb8c7c4-c55f-4d56-a1ec-08db2a4e7727
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2023 20:54:29.7802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qpUWJYcLMyLF5xfj4ax2Cm3g0/oNG4/lSiJvE+oJZQIa7QYsoxQYNFqWsg89Szb3iSS15xeOAfoIzQ7al7RRqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4520
Subject: [virtio-dev] RE: [PATCH v2 7/7] virtio-net: Describe RSS using receive queue
 handle



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, March 21, 2023 4:56 AM

[..]
> \field{indirection_table} array.
> >  Number of entries in \field{indirection_table} is
> (\field{indirection_table_mask} + 1).
> >
> > -Field \field{unclassified_queue} contains the 0-based index of -the
> > receive virtqueue to place unclassified packets in. Index 0 corresponds=
 to
> receiveq1.
> > +Field \field{unclassified_queue} contains the receive queue handle
> > +\field{rq_handle} described below.
> >
> > -Field \field{indirection_table} contains an array of 0-based indices o=
f receive
> virtqueues. Index 0 corresponds to receiveq1.
> > +Field \field{indirection_table} contains an array of receive queue
> > +handles described below in \field{rq_handle}.
>=20
>=20
> This is only used once, here.  I understand that we need a name for this =
but it
> need not be so generic, I feel it's just confusing.
> I propose "indirection table entry".
>=20
Unclassified_queue field also refers to it.
Need to duplicate the below description there too.
So using rq_handle simplified it.
May be it can be duplicated as=20
Unclassified_queue consists of vq number value divided by two.

And avoid rq_handle definition.

> Thus:
> 	Field \field{indirection_table} contains an array of
> 	indirection table entries. Each indirection table entry consists of a
> 	vq number value divided by 2. Thus, an entry value of 3 maps to
> virtqueue number 6
> 	which corresponds to receiveq4
>=20
>=20
>=20
> > For example at
> > +array index 0,
>=20
> why mention array index here?
>=20
Since we are mentioning an indirection table array, referring to an array e=
ntry without referring to the array index was little odd.
After reading your above example, it doesn't look that odd.

> > a value of 3 maps to virtqueue number 6
> > +which corresponds to receiveq4.
>=20
> It's a good idea to first describe a concept then provide an example.
>=20
True, but it was not too far with pointer to describe below.
>=20
> >  A driver sets \field{max_tx_vq} to inform a device how many transmit
> virtqueues it may use (transmitq1\ldots transmitq \field{max_tx_vq}).
> >
> >  Fields \field{hash_key_length} and \field{hash_key_data} define the ke=
y to be
> used in hash calculation.
> >
> > +\begin{lstlisting}
> > +le16 rq_handle;
> > +\end{lstlisting}
> > +
> > +\field{rq_handle} is a receive virtqueue handle. It is calculated as
> > +virtqueue number divided by 2. For example a receive virtqueue handle
> > +value of 3 corresponds to virtqueue number 6 maps to receiveq4.
> > +
>=20
> it's a bit disconnected from the rest of the description. why not adjacen=
t to it?
>=20
Sure it can move up before max_tx_vq or before introducing unclassified_que=
ue.

But I guess we can describe by duplicating the text and avoiding rq_handle =
as you suggest.
Will simplify this in v3.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

