Return-Path: <virtio-dev-return-11297-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A65DFC7EE23
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 00:29:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B9EBA2A892
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 00:29:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AAE099864DB
	for <virtio-dev@archiver.kernel.org>; Mon, 27 Feb 2023 00:29:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 985E09863ED; Mon, 27 Feb 2023 00:29:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7F50E9863DD;
	Mon, 27 Feb 2023 00:29:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6JH7B1+3LkgOjo2pJyTzfmcvp+izibUHlptVpZyYMM7m/6NmMpL4S1XOybzBAkIaIBSStBo8yf1BCrUqJ8fM6zdmDv4pzqr0zzTAfS1FIhMgwGqgKFhMDqRL8kGD0DWJwxhdc4CeXuboH1NB9jY9pzZHzNscvvLY1JdSLKSGm2FUg0nZdL5/0nFY6PlCJ3rtjVC32gHAydFLPy3rGONv/2Txp9JDdYuW6NyZIH528iZ4pmwFEQxcHzMSfG171R0kG/nEmCOoVKBWfNOmRVMmsuXhVJuhlp0FOITWkxi7XO62VdITor+9VHTAYQKYtecKIiiRaXHcNSm7pFeYLZ8xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/f08VPpz6O4agoJF4cKYewp5Lq4QCthLbgGnZpppnU=;
 b=oJltuqQhAbE5TivoxkvA2hoy7jRNyUwZD7r/tlDOSBuzgtKonumiZAEIV7Az4DTa8d+hmht8vetQkgXZYfV0AhkZLF4Tq23f1wgP+Qm4kBu/lPmQ19m+9ViSWx0d3CchwKHM6IRclVJaYunGvo/mHJhtfqNuUt8VOKIR2frtKTsPIsi893pXy3A3LZzLCkynqZlCflD16YBqeZpendYDxEq6NfuiuJ0mfoAgD9Cab6yCdkfbNLrGMe05svTGk7CIdHZpC+XT1rLuhGOcG17jQaR0BX8bkF7XogoLA9qrlrp+gD9YH2Zn9MkqP6NRxH+nCAMhFUuBE6yuc8M7j8rFmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yuri
 Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "ailan@redhat.com" <ailan@redhat.com>
Thread-Topic: [PATCH v9] virtio-net: support inner header hash
Thread-Index: AQHZQ6aVfNkXRc7j7kigng6qS2Ruia7cigWAgAAUfDCAASnrgIAEK7lQ
Date: Mon, 27 Feb 2023 00:29:33 +0000
Message-ID: <PH0PR12MB54819632C955C5D087117416DCAF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
 <20230223080358-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481FD1A82D37157AFCFC541DCAB9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230224030725-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230224030725-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB5673:EE_
x-ms-office365-filtering-correlation-id: b07b51fc-1345-4550-99cb-08db1859b310
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Wxpmx8HwyuoPP7tUZZIERXgXqPc8ivTIJmaa6TIc6r/noHcV3X4Pt0oBC/omq6HtPKK8c8+oqZVatEMtKtylD7McRBvLKN6RFUepkmJXAPpWk8xMhTmVYbHOx/CgEvcE0I6lTcti/nbbsA9dNeVNREd+nzFUqtPOBXAYj+M73zXiOmg7q4rjkQMCBRxOAwN5Dfj+EJCRq99AkZAOTFudatvg5sCrrqwESOqQu3wV2DM19byDew3elEIeY02iRrgaP665S6Ts0DfvTwdMijLjp8eMCat7iRTRMTEWGU81H8xx+aFewvsHQ8T74nikfHI7nMnRH6pAXl+1Y/F7bkf2rzsI9rR76nzbVoKPHYYudLgZyGBFDhE2Lll9yZgAzo5D08ScsSLjAj7wslwh7znI4raaDWAH6a1cEgxwAqmOTxLr5688AO5/74iq9XFimuFiIEvBDSG289ZZl2fHpHPlLHmujf9xS0uh/hdlRY0gHlBq2ACYF3AKv9LTTIESasBs1yK6QZ+MEKZUnDUs4VocR5o2AUADGEi59ve582T0oTNbOOCUa+buW6b4vrjlwuaWpMFpINsgjyvSKb+as6oXF6fcD/xQV0Nj8gqQOtmhmxBfZNryAy2TMDn4GDEHUOuiD6HuJQ0o0R6Lrw1kQmeAtBX3+jZ4xUeCsUKaN9ZoHTcapBCPuA6EkZZokvn199gqZLyYZejzlReWTQoepbdX1nmnz3SCOz4mtUYmDz+O4f5e6sjZgmwGQgr/fC85+4Op
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199018)(83380400001)(33656002)(122000001)(6916009)(55016003)(38100700002)(38070700005)(52536014)(71200400001)(41300700001)(2906002)(9686003)(186003)(26005)(6506007)(5660300002)(8936002)(86362001)(66556008)(478600001)(54906003)(4326008)(316002)(7696005)(966005)(76116006)(66476007)(66946007)(66446008)(64756008)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xSAD5+EGoYrRN45xStobkMbKwjLo9TjENooTtxzKf/mOPbKKPyPm/zZbXQ72?=
 =?us-ascii?Q?LQAKJfuDUkGavBJvhNI9tis5yRvMVJpDegrNO59fQ0LOM63bRCSRnj1SSwRl?=
 =?us-ascii?Q?i9XwpdMWSL7d7lh9wQByFpT8WBKU4JdJkYOnN/Tha9lAGZM9buEzSb5E49RH?=
 =?us-ascii?Q?YGLaH16NnTOsQEG7DYCXvwsq5knyBzWlfcmR4i9H1bmaIrlTBAKhAMJXI73F?=
 =?us-ascii?Q?zpRRREUQQahh1/MUVqxKkjbJhUtw2y2d0ZxXbEJC6WB7dNNnM2ELz1RJQVJR?=
 =?us-ascii?Q?jqzoStNsNEPSaNfEWkXJJPQ0qeulKdzTansS3eOBC4NVXr3Ol9yusuU+9Bsc?=
 =?us-ascii?Q?FhzBVJ9ing4BphJtmXrMmZF7B16AfCLYNQ8aLo0rgQ8x2pj64FoJOa2e8e0B?=
 =?us-ascii?Q?UwCxDBrbB5DBhqGjP+KWEwWCDzPnwa1mo0QmQCN1Ak+jYIWCn9KYjHibkDmz?=
 =?us-ascii?Q?s26nYKkg/rc6gimNOeGnHA85cDw946uTMkZ7QQCb0hh1egsOdZ8qZeH4oZyv?=
 =?us-ascii?Q?y5PqpJXjAqZjevBn5icZZhfZgyJyJGWv2pw0JwfuGXoCYqpcRCho9wYjE7Ow?=
 =?us-ascii?Q?vyWwJYvBB47Q07/JOuXn1kGxGLRB2OFdDxMm9B2qTP7UxBOaLVXnoSxF0GXU?=
 =?us-ascii?Q?iLePwkBEmfWGhfp6pc3iaBtn4y5BRNsz6Wup3gu1uKZ7LVg6xxzXr11bOCTE?=
 =?us-ascii?Q?WTY4lUpolyQcqPcvJlLDeYJ/o4+DAZWhI1PXZrmlbZ1JaQjaUAzGnGinpNR4?=
 =?us-ascii?Q?NVqJ4GAw/bFAIBpE+OuzwhhIiMQ2GZawv/jmSQGRy7KcDgzlEmTNNZ2VuaPc?=
 =?us-ascii?Q?f6vppM4py9nWWGaIWGdrynu58SaLMR87gkuI0i13aPOvpy68/OYWUi8iksr/?=
 =?us-ascii?Q?LZ7AKVz9s1U+QFV23geXHNUpMw308LtCohiHSKtasfs7SOEC96AiZ0qJSl0N?=
 =?us-ascii?Q?zs3WSQ5W4wH8oSS9yvthy1NY8VbfunNF9KhIOi7uo8/hlrvABIwRo5HX2VDo?=
 =?us-ascii?Q?pWDGUZeX/EGEtwsO6TVJtuZvvZirZxuAksIFt0g6LTU2cH2oSAIJ6y1EYDnF?=
 =?us-ascii?Q?U6oaOMPSl5wwcyvk4fi6J2R5rLObRWSpRRJ098P746CYVXOurxUB/jBRsDVf?=
 =?us-ascii?Q?rsVXrvUvO+hjMDGJ4bP/9Qnc+rECzWaOIq+bi+GbQ82pAyM4PY0QNYxBnA6o?=
 =?us-ascii?Q?I2oDJi3vOBHKbQneclkQjCYHQEY3SBqSk8SDR0XcW0hz6JCfNclKaAe0sMCE?=
 =?us-ascii?Q?cNoIQOcOS7YL+ZzI2vIkoEfiKB9fhUMFC7dZFUAyHtp65GWC60j1yDfVEEi1?=
 =?us-ascii?Q?h4bsKTsKXVADuKBm/M7CBi5ENoozS0s0dqi+D7LK/yj+CJRzpNFnjc0pi28W?=
 =?us-ascii?Q?whrBTLqi7ocuxBdQsdzzN4KdQo+9/ZP4+MPY9Cwr5lcL+h67WDpgcpt4iNEA?=
 =?us-ascii?Q?AmttCVgBaDMcKcnHRcgopVU2l6SojH0UEn1rizIVU4ymAhpDA3yAR+TpGR5J?=
 =?us-ascii?Q?M61S/vo/8b/mWwq8LPf3FMizxcBbe7lLZpWDpwmVMThbmI1nkWlSXJPIu09y?=
 =?us-ascii?Q?YZG0YtshF6d8uTkZXUo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b07b51fc-1345-4550-99cb-08db1859b310
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 00:29:33.8266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pnVnfNHX5cMlopKVAlDlf/GQccpGGgo2Cn5f/fJwRK1Wy46e15VVGao47G8GowYcgec3MCkJu4jrC7314zxKzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673
Subject: [virtio-dev] RE: [PATCH v9] virtio-net: support inner header hash
Message-ID: <20230227002933.gaxSlKiffcugT3Jhyzb0zqyW9x_JUG_xbrzRA8D54Ho@z>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Friday, February 24, 2023 3:13 AM

[..]
> > The inner hash is only needed for GRE, IPIP etc.
> > For VXLAN and NVGRE Linux kernel transmit side uses the entropy of the
> source port of the outer header.
> > It does that based on the inner header.
> > Refer to [1] as one example.
> >
> > [1]
> > https://elixir.bootlin.com/linux/latest/source/drivers/net/geneve.c#L9
> > 22
>=20
> But I think hash was requested for RSS with dpdk, no?
>=20
Yes, but if src inserts the entropy (dpdk or kernel), UDP based tunnel can =
live with outer header hash.
Ip over ip, gre tunnels needs benefit if queues do not overflow or the proc=
essing is fast enough as Heng explained.


> > > The lookup will work like this then:
> > >
> > > calculate outer hash
> > > if (rss[outer hash] & tunnel bit)
> > Tunnel bit, you mean tunneled packet, right?
>=20
> this idea stores a bit in the indirection table which signals which of th=
e hashes
> to use for rss
>=20
> > > then
> > > 	calculate inner hash
> > > 	return rss[inner hash] & ~tunnel bit
> > Why to end with a tunnel bit?
>=20
>=20
> this just clears the bit so we end up with a vq number.
>=20
> > > else
> > > 	return rss[outer hash]
> > >
> > >

Above scheme partitions the rss indirection table into two parts.
1. one for tunnel processing
2. second without it. (this one uses outer hash as today)

When #1 is done in your example, it is without hierarchy.
So inner hash can still result in collision, as before in same VQ.=20
Say VQ 0,1,2,3.
Indirection is setup so that 0,1 has tunnel bit set.
2,3 has tunnel bit cleared.
Rss of our hash finds it true and inner hash for two different tunnel is st=
ill maps to single VQ.

> > > this fixes the security issue returning us back to status quo :
> > > specific tunnels can be directed to separate queues.
> > >
> > The number of tunnels is far higher than the number of queues with para=
 virt
> driver doing decap.
>=20
> True. This seeks to get us back to where we are before the feature:
> driver can send specific outer hashes to specific queues.
> outer hash collisions remain a problem.
>=20
So far mlx5 device has done hash on inner header for non udp.

For steering packets to specific queues is done by flow programming to the =
specific RQs which supports for outer, and inner both.
Ethtool -config-nfc has it for long time too, such flow steering is due for=
 virtio net too.
It is orthogonal to RSS.

>=20
> > >
> > > This is for RSS.
> > >
> > >
> > > For hash reporting indirection table is not used.
> > > Maybe it is enough to signal to driver that inner hash was used.
> > > We do need that signalling though.
> > >
> > > My question would be whether it's practical to implement in hardware.
> >
> > In above example, hw calculating double hash is difficult without much =
gain.
> > Either calculating on one inner or outer makes sense.
> >
> > Signaling whether calculated on inner or outer is fine because hw exact=
ly tells
> what it did.
>=20
> This, in a sense, is what reporting hash tunnel type did.
> Do you now think we need it?

I don't see a consumer sw of it.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

