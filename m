Return-Path: <virtio-dev-return-11481-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C811CC678D4
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 15:20:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 09B7E2B026
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 15:20:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 03D679866D9
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 15:20:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id ECE649866C5; Tue,  7 Mar 2023 15:20:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D86499866C3;
	Tue,  7 Mar 2023 15:20:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4h/v9cXcapGjd521HMulibeQa5pQhi1oRkfzliwq2xmi4ohUh3+L05KN+qM2kOuoYVx9zpBYtj0gHtymgIyqA7PUdEyqtEZmGfIG60oRo8yzTV564ZiLRt7eOPDoujqz3gouSAZJ16TAO5qY+eAIPpsBblzqUhadPwE2nxKv1Qu7n8PEyjOacIH/cByuKlZ1fxmypLXua3gEqhWAMMCRv6j8KnZkhdZ4YkbEmP6CtFGYfu3cd/fMUilnJ3Xp18/qyJF2Sxm8tpgEye8aZAXrm6Pzd5SEKytDhmOG+BIMa2ATVMiGswufbm3GCbJDQgvKDnf0jP5P6zLfpi0Z+ltZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dl2GUsWZF+dUhmETuk3+MpJy9/AciZOE17kGHOu/4VM=;
 b=GJlFsVs9r9Jq0R3ONMve+yeOKCXqwQKBse5lralFk1Wnbzto6VdTKyvvTVrMgCv5VnKNl9SrI3Q9peahLysEXAEdwHleLgAYBNSuSZNwm8ys2HeHzij1TVifBBjgYtPKUgfDOcwjxEKBIXAF1arvImhAuBxN3p0h/fqziiVUe8I8rtyGTQdkt2Bh1UfeTGSJDaOy6SqtGWHlOn+SjM6HkRK70WFFKuZ9XC/YGbVVAy27ooBfh0CjwbOsz7LaH3PSRxOIWqzWlZuWBdg7zHje7GHV7s2t15b3Lr858PJUTS1Qt46lljdPPkkYqKxB1COgdJzDY11Agn8HmCRQ73xgCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Halil Pasic <pasic@linux.ibm.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Yuri Benditovich
	<yuri.benditovich@daynix.com>
Thread-Topic: [virtio-comment] Re: [PATCH 0/3] Rename queue index to queue
 number
Thread-Index: AQHZR0pAxGvxqZYuNUuHEK6ngQ2mvq7jFlqAgASY/gCAAAOdUIAAfrIAgAdO3gA=
Date: Tue, 7 Mar 2023 15:20:21 +0000
Message-ID:
 <PH0PR12MB548196ECC20CC6BC4274F0A0DCB79@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230223054624.168042-1-parav@nvidia.com>
 <20230227123751-mutt-send-email-mst@kernel.org>
 <20230302165216.1293d066.pasic@linux.ibm.com>
 <PH0PR12MB54810632DAE7C0D8BEABC9E9DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230302183736-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230302183736-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW4PR12MB7438:EE_
x-ms-office365-filtering-correlation-id: 61c5d1d8-63be-45d3-e5f3-08db1f1f77a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9Af/7PenmbtPwS/nOOUFI5f9EQTaesqxlSp3HQccP4qGeWZT85QV99Fs5rSRyp7HIeUcz/X6Une5SggZkZGnCMiVnxjs9fyLCo3lNEgwsFSCcoe1jYAeVIfspsMdMJs9a/9OCYFjcUsEdOg7SSyX4xJiQeNgnAUJUyQUmsb0+Xf9/hR18cZAVPb1m9N/N8875GH6EnwUGBq1Iog4bMHRlfE8QqIRic6w2eeS5hf17iGC/na8xG3qB5XvkaYYp5B0mE5oMzuNxNmezoaePx/M74/Uj4FpZI/RuavfGZRra0FwgpQL1aIHPoeASD91x49/I/X7sClQyELFvobTQlm7Roi7bVvqYEqOgBUFhPeu2GPzpj3e9VbsoNtK+R2j2OxLDVzy2FKhL02RbhiYgXZBXVR6VKBhiR1TenrzQ73O9N1NG6Q5cN4IqRvORNRRcuPh0ph2i85vw9QWc9o0Cnn0jY0FlQNmrU327yys1dQqQ5iVnL64XYH02gdoJlyN+hFchfnSFklCx0L7Bkf8YLyM8YXp2KkOl95tdfCwgL8rsuA6yp2BZ14dE2lsnOtiRi2I0QiHo3SUBZHJf360MR9YBBDxi7zVxg2JfcCxi9dPqwcgxRoDdRNWBbPtyVTjQ/rleSeRa3CoxWKvbL0QnVs3wqLczVeKCiOAQ+dyGkCjn6bt5W97PQ5cYDTgSm8WXsqJ+A5pPzmHHAMSKYGhR07Sfg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(451199018)(478600001)(55016003)(54906003)(316002)(122000001)(38100700002)(38070700005)(7696005)(5660300002)(71200400001)(41300700001)(9686003)(186003)(6506007)(66476007)(66446008)(6916009)(2906002)(64756008)(8936002)(76116006)(66556008)(4326008)(52536014)(33656002)(66946007)(8676002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?UZFC+xqzam49/Y1b/YbN19GDmVzdFEMU1jCxwfTWLkkMqlJz/wgJG/CVMb/u?=
 =?us-ascii?Q?Iw+i4gKwDFvjtX3XgyIjhnUCBc5UTziPokCM/JFeXOJegDbHuKMgNbr0nOrV?=
 =?us-ascii?Q?y5XL3icArojKOHIByMQDSgYqr2Wnhb6W2FKegVNJdLOf+2syNLsHzPmW5i9a?=
 =?us-ascii?Q?bBAVWFJV7d0r3B4Q8ll9+zrAxcpNUaWEzLNjmtBiRC65QAhoCB5T0eihHdDD?=
 =?us-ascii?Q?DbMEipDIF4Tg+4VB+HNnIy4MM+1mQNov6PG7d+jxygM34d7R9oFWlPeACAA5?=
 =?us-ascii?Q?p8Rx2RxdUeHdI9fG9J2qqlGQX6jXhGmNcuIuaHAxh4QzKi6BOGxYE3AxcKDV?=
 =?us-ascii?Q?iL6VpR5B+BAB+x8Y4oIYpfE4NTEvmpMHmDsm/2uKU8+5ongUoUJeEvqor8Vo?=
 =?us-ascii?Q?EhMAXJevJAQAp5sAlIo9rOJtHyei+PPX6j4Or5tNLMpkbiQ5tyy3h70v9jN1?=
 =?us-ascii?Q?ZHIBC12Lcv66Svibv7UGu1ac/8PEofcAkvJ3sFfexFXDXXMX9hOPdjgVANp6?=
 =?us-ascii?Q?r10ffzJ6CGjXGKdYlm5fYB08KvJcRTfD89fvNYkRciEhJQ9tvcQ65XgIFzmM?=
 =?us-ascii?Q?mT1lGKpXAO9BuFV/3ZK8RydexBm2Ly6EtXVWaZXoxk/KEdj2dHYG81IHVu30?=
 =?us-ascii?Q?8RUkk0RTAbApwCp5l2uynwEDf8Rjkuc/ibgovJDYPlrcBoxDlw7TaR45ecNL?=
 =?us-ascii?Q?TLIGam9WgTqApiF5HoO+BKWL53kvEOF9FVpF6hSWRhHdufCAuFWyxw/q5I76?=
 =?us-ascii?Q?Q/+AGH9af50UI/XeGTsMUSFSC9gz/OLZyjUk/qoCfhh5rXNpvVnxSUN7WCqB?=
 =?us-ascii?Q?8ND2CtnU/6erxpyU9g7/tHs8U9UUzLdye5kyeWKpLIvVZUYzWNMOBB5ZSqq7?=
 =?us-ascii?Q?ZTCcYVkEGAKbrn/fMVIuQDRlgu4X0O3jukghhVodKYpSjrs/agJLTLr0g7vz?=
 =?us-ascii?Q?1oKcemCRe/PdM6S9YOuvtXZuu7reoa804KPlF1tzV/RroPyNiwOVV/aenSL0?=
 =?us-ascii?Q?maeDdd+lrF5Co0paWZt1acuZckmomV6wGH45S/qX7b2n1MwYIHnRpX0h4fjF?=
 =?us-ascii?Q?GyPOBW28awk9gRXtYHZCJbpnzVnAR0oZhYkWlM0h6nc/XFaVMzvgsBUktv0p?=
 =?us-ascii?Q?UqX9Z/l8RURulNr22i6rWkU6EkPbuzjyb4WiIzf/YiG9l3BhJdMtyh4Xwq9c?=
 =?us-ascii?Q?PDboNQvlmFjtaJsu2TFbCLAAGAfpg1bKySFY5FzUE/RrJd0ME3cYOcjIM1cS?=
 =?us-ascii?Q?CkTdN/QysIfcD75gAjlttT5hIHJkfSBZ3pj9SHq/5rpYOxXVLp1+pG7F0by4?=
 =?us-ascii?Q?qp5ZrySaua5oH7y2hUqwk1WZOjcPSQZPYW5Aerq54BFzo2cIdLHrUhKpJ3It?=
 =?us-ascii?Q?zN/IVpzfXUGVIhmNRuxLiOZG4OXYwDxiMAwVXL/8yiJnTAsZDyNLAfxWVfHD?=
 =?us-ascii?Q?UfVewT/8FBNNguF9kyQLQM91l3HihQLzSRC00xFasdYdmV10zmJq5Sd6hcUm?=
 =?us-ascii?Q?QMGxa5HbOjMQNZc17yoPYSu2LqaofXRf7oD/OjEkSoBRCtSNjhIaloC8mRy+?=
 =?us-ascii?Q?rjW7NwS6OvIovmIHd0uneX/uXaEmxx+HSkJsNylQGQAWAqFC68stwxtOJsGg?=
 =?us-ascii?Q?pRc69mecQIRbbN3V8DSKyBI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61c5d1d8-63be-45d3-e5f3-08db1f1f77a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 15:20:21.4240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cYwNdUNIq2nn6guRlmwDtcHyzwc3ITvdPRe19sPnNc0QVEuDkEiSrO4KwBWAvzNOY7Dxkm1Xy5gxaoRHknugow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7438
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 0/3] Rename queue index to queue
 number



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, March 2, 2023 6:39 PM
> >
> > Similarly rss description can be simplified.
>=20
> Unfortunately this is not what it is. It's actually vqn / 2.
>=20
:(
I see it now.
It is vqn/2.

So yes, need to document it this way that it is vqn/2.

> > > Here follows the explanation.
> > >
> > > Disclaimer: For a brief math background see [1] and [2].
> > >
> > > Here the index set the set of natural numbers (which includes 0, the
> > > neutral element for the addition operation).
> > >
> > > The indexed set is the set of receive virtqueues, each member of
> > > that set is associated with an unique member of the index set.
> > >
> > > """
> > > \subsection{Virtqueues}\label{sec:Device Types / Network Device /
> > > Virtqueues}
> > >
> > > \begin{description}
> > > \item[0] receiveq1
> > > \item[1] transmitq1
> > > \item[\ldots]
> > > \item[2(N-1)] receiveqN
> > > \item[2(N-1)+1] transmitqN
> > > \item[2N] controlq
> > > \end{description}
> > > """
> > >
> > > But, as seen above, we happen to also use an other index set for the
> > > receive queues of an virtio-net device. I guess the intention is to
> > > use these as names, in any case the set is { "receiveq1", "receiveq2"=
, ... }
> (yes, I'm a little sloppy here).
> > >
> > > Thus we can say that:
> > > * the virtqueue index 2*(N-1)
> > > * the recieve virtqueue index N-1, and the
> > > * virtqueue name receiveqN
> > > refer to the very same virtqueue (for each N > 0)
> > >
> > Receiveq1 is a name to virtuque number (currently index) 0.
> > And naming this way doesn't seem to be a problem in the description.
> >
> > Section 5.1.2 is liste them already.
Bad auto-correction.
I was saying the existing section "Virtqueues" in Network device already li=
sts the mapping between vqn(vq index) and logical receive and transmit q.
An additional short line telling about this mapping is enough.

> > A short line tell about this mapping will suffice.
>=20
> can't parse this.

My point was, there isn't a lot of change needed around current examples wh=
ere receiveN is talked.
Better to see in the actual patch.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

