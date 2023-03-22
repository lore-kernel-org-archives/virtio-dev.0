Return-Path: <virtio-dev-return-11735-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 670B8C6FD1F
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 23:47:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 875BA42B70
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 23:47:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7AD229864A5
	for <virtio-dev@archiver.kernel.org>; Wed, 22 Mar 2023 23:47:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6FF63986458; Wed, 22 Mar 2023 23:47:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5C64B986455;
	Wed, 22 Mar 2023 23:47:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/MGzKAooyJvJMYwrilRTkHZ1zJVRLup6lVSrlR/f34f90/8pMpaIx6gkxt4DS/2mCwwcUjgLF6YcwXmBTQcbXizk7BqP+zDPUuT0exZj762dsV6EOrtq12bymB0E0PozkwFmLDxnuXvoy1nrAApv635O81LY4JF4XxHpswPeEOYTI7JWoYVzwfI433F8N1XCXJsMIZmgYlO34HCeeWWaAmWEJfisYj+V+o5nEKN8iTO8EpwBcdsqZoPSZ87LLbpHnoR8dVtt33YWUsB+/lt7X1/8XBalXn5IH+xyAlQroSeXVyw3nMsCpqbPYoK/mH1yaSrfdxmWTleS7TxIF3F7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A/Z/zRwI+8sPQ0QE3J1+6qeTQx+n1Uu4t6uLoobwE2o=;
 b=nehC4POF0vbx11SoQQeO6xfOCpQB61puF1vihUOXAgyRMdua1l8AJbKI/6A12UH91GF7wgiFfw8umIlJiz3C43qiTqnIP8Er+L3S8tENZnpkWWQdy6BkG5z7fOq8dnBEc2wJYVn5e3inoJNX4OrM1wvZXUuHS1UwCUCEplhKBcmwB7emj7WOknQXa8bxQLzZzs/zGn6ZXIctABMZCiwz9FS/aAvilCXCdmeWATlelxYjkis4UPkhgp0J02ZV5i0FtG87zf1+rLNHA8BGMniJ5KySrmPJQbTYAk1jpJulGDIwO0Ru1rfkZk6UDQRw6uBmcnQ9WxDy3eRelVVEp937Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v4 8/8] virtio-net: Describe RSS using receive queue
 handle
Thread-Index: AQHZXQiziW3EdNF4xkCgvpkFPVG/rK8HawYAgAAIVzA=
Date: Wed, 22 Mar 2023 23:47:47 +0000
Message-ID:
 <PH0PR12MB548113082F56CA62227A0CA1DC869@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230322215243.249524-1-parav@nvidia.com>
 <20230322215243.249524-9-parav@nvidia.com>
 <20230322184932-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230322184932-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS7PR12MB5791:EE_
x-ms-office365-filtering-correlation-id: 84344403-57f1-48e8-23e8-08db2b2fd73d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fK/6vJgSxnoQFT870PTnJSvnRWEIjNiZJWD1Ot5KoZrX/zVDVfkJ3UYgIYJeWKCVorTn4+aKBuv66Z1zO2DJaTAOXHJx6BlC+wfcRU8gwDtSLv7uj+YcRJjSaXiuXNEodOnuyuQ0zmmac9SpHQntBalcFWfLz0pU1/eHNkAnzMnL+eslxA57LPEJTTAdaXVjR93GDdotNivGB4S4xcYPWrysg+Ah8lTAbwkKqvvwunk0pspxh68pFC+Q4V5yIO4Ap9ZYjLA/RbYsHOEMbpKv5e3x2AnXWecvcxydaJPCEzo8VtrUHuCM/jTUVU6HGOeF1jHKfmKgvp5De5/aFA46jv2N193ldzGjQgPRtZhBqFkvOFT0/GuUPGjYTn9BAxTKBSYbBM5KsrOb8ZJAEZY5evBzWR3082oqv0BycFceG85/aT9UvHLY8R8xFf+xbOJV+5DN6LErdssldwqCqDnIuesO8LrK2i0kXi+qjH/OMQdzeinAe4FW/kOKxr7n1gvmPO4U4e+Tqq89M2juPCY/CIqeAaSiIwc/GBEtOvGO+MWicQABfyXXUF4M6sfwupKq01zzgb+xZwehclzlvwIrkk16nk6YfhPe5mXFVSj6iZp0plnulkFZmi0OCbbfsvLLPMiu2Cym3rwid6uXyB8N/OA0JxQsL+CjUhnGJzB6HmS5NNdjBni+Qio0MGI+mjCnnGht2IHjlaQ1P2OwEO4ZYg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39860400002)(346002)(136003)(366004)(451199018)(38070700005)(33656002)(316002)(66556008)(8936002)(9686003)(86362001)(41300700001)(26005)(6506007)(2906002)(186003)(55016003)(76116006)(66946007)(6916009)(4326008)(8676002)(66476007)(64756008)(52536014)(66446008)(107886003)(7696005)(122000001)(71200400001)(38100700002)(54906003)(5660300002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ssYr/fGIYPJHo09xmf+uJH0T+jRhqS9xKXfrS34wJHf+TQ+qw7t+9yC+1TQf?=
 =?us-ascii?Q?H4I/j3qPyF4YaYox8SIxJaHi/whg6XJAJDp4M9AG8KNLuqYHMxmxJ4LPJHQW?=
 =?us-ascii?Q?i2z4tuQ+55TBSNv6//3i+curo6c34eerp5Fn9hER4UVOQFEnkYGOngIuTJPe?=
 =?us-ascii?Q?xgvm4k0TSyjnwEZjNbHVgBTrIBSQEp5bSCJL1S+NkBtkxPhTTST6wideMQNI?=
 =?us-ascii?Q?+CJO5HsK8/SEnOyPMuNjF4JEffSn//ZDAmwmTiKVsrgpEYqqEuHNJ00R5b4J?=
 =?us-ascii?Q?HcXGFSIfBgf0p4PNidvIy0qh0toJd1PqgtIQuwfSMSUntZdt74klU7Xh57Sz?=
 =?us-ascii?Q?V14DBA9xEEyTsGdBGwADQNzabqClv5RMSJusUC4p6I03l6YaBD/fnhfMdyEB?=
 =?us-ascii?Q?00NfhXZdgZNAj+2OFHtyF7UKNIDRwDZk47xao67rGqf6gqkLpM2xTgQHeG59?=
 =?us-ascii?Q?qRYWICfUNa1JmGG3K2dIdarouTYB49Vp1i8FgLa5Hwa/wB0WpXXMBrOgTGdI?=
 =?us-ascii?Q?1Y9QCnLagNhjPNz7jTp3JRA4ue7UooCfqC1p/Tirn1mXdq2hFaW7bodegBVk?=
 =?us-ascii?Q?43iMOAb0EdPEdcxJ32rUgTRFfICepSnlCPAB16Dzq3AaQtwetUuiKL/riqmO?=
 =?us-ascii?Q?HKWqHI2cx73KGGpSDt/Wfp6relLczPZSRRpA34p+QZFqeKEWSU6gww9OoreK?=
 =?us-ascii?Q?AvrV/R5NQoiJ4kVf4xACS2UJD+H1mfP55pSIirsjlKfFP8dPypSB0FpARkDH?=
 =?us-ascii?Q?lCFPg73fk7uEVQu3jvnxbZgIPXcDv0hn9of588Uhp/fX47dHleYvupzHdKg/?=
 =?us-ascii?Q?uPMN1DJYW6uXjdQOoAT5JPtPE/A/3xrriKt59UFBhhk3jHk67GjoCbm/v09s?=
 =?us-ascii?Q?hltRrQl0iPC7ijkVkjIdsA/F1R9FXW3/nUR4M6+BP4BwZ6umgOfTtWGosUiS?=
 =?us-ascii?Q?/MMejqz+UNLDirnyKQFuJQdxh9x8n/JFXgmU/EQw8/8XiaMRANkOKb2wApsZ?=
 =?us-ascii?Q?/zlHEz9YDPjIhGjOiOBXC8sexmPlLiOblJKIwUCtZSNAoJVJjDOuyi91pCMu?=
 =?us-ascii?Q?8LHe9NHWHebYWa/Y1W1ZfQaCzEt5kLz7eyDGq5o/NAuBHkoq+pn67w7iVm//?=
 =?us-ascii?Q?EWtctwlq7H/Qr8sHO2qJ+8aDTTqUMno7B0Mc5W+7lJ1KDBFWyXyu+7tdB2jm?=
 =?us-ascii?Q?2LjRo9V9OO/3rNNHeIm7C6mP3uFGKDd8Ew3o1QggZ1eLhSzTJgFApzaQmqCz?=
 =?us-ascii?Q?NlJq3PaUdfh5aTuCxNoHSgLiis9J8HtBT3tbVzrUJhOl7Av7/m84s7rs8vMT?=
 =?us-ascii?Q?63+t+X7QJUMUoQQ5yWS01n1Am2PCHFyala2r3cxtbV+3pTqCMFYd2V4pvTwe?=
 =?us-ascii?Q?7D+IejSqGAo0oFzn6Q/drHsIwyDyKf1jxi0pJGQEKzlWblNL2xdNKny12Z1V?=
 =?us-ascii?Q?qeiDhUMcw8Cxusgw5QJzkeQQWgBULMJCKI6VH3DrqblzAv+wkhsMABF0RLn1?=
 =?us-ascii?Q?Iba4CqK1nOrGgWNPtrMXRpjtR05mpICe/eV2ccxUwRCyvcH4WDXtbU4QhYvt?=
 =?us-ascii?Q?AW9XwzWFK3Ih5zFcx2w=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84344403-57f1-48e8-23e8-08db2b2fd73d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2023 23:47:47.7310
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lvMvuoJU6QR+vC4RT7TbtX96ffokA80jK8quxMe2L7Jw5/S9d5SCls9yq2ZlW1KlrEyF+c+umgBdL+h8fm14yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5791
Subject: [virtio-dev] RE: [PATCH v4 8/8] virtio-net: Describe RSS using receive queue
 handle


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, March 22, 2023 7:04 PM
>=20
> > -Field \field{unclassified_queue} contains the 0-based index of -the
> > receive virtqueue to place unclassified packets in. Index 0 corresponds=
 to
> receiveq1.
> > +\field{rss_rq_id} is a receive virtqueue id. \field{vqn_1_16}
>=20
> Looks like you keep removing the main thing which is *what is this field =
actually
> for*.
>=20
Ah my bad. Fixing it.

> More comments:
>=20
> id is actually abbreviation. Field is actually \field{unclassified_queue}=
 - rss_rq_id
> is just a name of struct has no meaning by itself.
> so either \field{struct rss_rq_id} or just don't mention this at all.
> Below example on how not to mention at all.
>
Structure defines the format of the vqn. I will keep the definition there o=
f what vqn_1_16 means.

=20
> Here's one way to put it:
>=20
> \field{unclassified_queue} identifies a receive virtqueue to place unclas=
sified
> packets in.=20

> Within \field{unclassified_queue}, \field{vqn_1_16}, consists of bits
> 1 to 16 of the receive virtqueue number For example, \field{vqn_1_16} val=
ue of
> 3 corresponds to virtqueue number 6 maps to receiveq4.
>=20
I will keep this example where rss_rq_is id structure is defined.
More below.

> > +consists of bits 1 to 16 of virtqueue number. For example,
> > +\field{vqn_1_16} value of 3 corresponds to virtqueue number 6 maps to
> receiveq4.
> > +
> > +Field \field{unclassified_queue} contains the receive virtqueue id
> > +\field{rss_rq_id} described above.
> >
> > -Field \field{indirection_table} contains an array of 0-based indices o=
f receive
> virtqueues. Index 0 corresponds to receiveq1.
> > +Field \field{indirection_table} is an array of receive queue ids
> > +described above in \field{rss_rq_id}.
>=20
> Field \field{indirection_table} is an array of receive queue identifiers,=
 using the
> same format as \field{unclassified_queue}.
>=20
Will refer to rss_rq_id and avoid with 2nd indirection in describing indire=
ction table.

>=20
> >
> >  A driver sets \field{max_tx_vq} to inform a device how many transmit
> virtqueues it may use (transmitq1\ldots transmitq \field{max_tx_vq}).
> >
> > @@ -1455,7 +1465,8 @@ \subsubsection{Control
> > Virtqueue}\label{sec:Device Types / Network Device / Devi
> >
> >  A driver MUST NOT send the VIRTIO_NET_CTRL_MQ_RSS_CONFIG command
> if the feature VIRTIO_NET_F_RSS has not been negotiated.
> >
> > -A driver MUST fill the \field{indirection_table} array only with indic=
es of
> enabled queues. Index 0 corresponds to receiveq1.
> > +A driver MUST fill the \field{indirection_table} array only with the
> > +\field{rss_rq_id} corresponding to the enabled receive virtqueues.
>
Will remove the reference to the field rss_rq_id here.
=20
> There's no field like this. Also not "the" virtqueues - we didn't discuss=
 them
> previously. Generally if you want to tweak grammar it's best to do it
> separately...
Will remove "the".

> > +\item Apply \field{indirection_table_mask} to the calculated hash and
> > +use the result as the index in the indirection table to get
> > +\field{rss_rq_id}.
>=20
> to get \field{vqn_1_16}
>=20
It is bit simpler with below rewrite without duplicating content of indirec=
tion table,

"use the result as the index in the indirection table to get receive queue =
entry."

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

