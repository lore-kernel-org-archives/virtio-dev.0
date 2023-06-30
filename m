Return-Path: <virtio-dev-return-13174-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E97AEB64D9
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 01:36:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9E5CF26A37
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 01:36:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 923E49866FE
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 01:36:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 865DD9866EE; Fri, 30 Jun 2023 01:36:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 71CB99866E7;
	Fri, 30 Jun 2023 01:36:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P95wQlm9BLMggYKixvBWx3fyd4qSf00sPT4e4IqBpGGuixDqPWzU2DsgqVD4HPFJj2qwXL1GHeirLEK6L7kdIJ7ODFWSqVyF80cGK25+mJimRWnytB5fA3ZYVcHHSw3VAlyEhv+OeIpurN5tuH6J2BhV1F/j8EYTgTRVHlSh9sJwrlJ1DRT7ezKcQctt9BGSGO/0f+aPUSVKibtZe5TJJFayxg6l1HXkqW3cS5jg83LntFjLVkuiVhYL1mTP9GruiGzM+jRU0xbjx9zYZg5M6mcTbf6nS0gjQPv51E5BeJCgCy7Zid0ncYlp+BsIRufuqrAALtoqZbyurvVuTVVGqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WsdK1bdgQ53oGqDH3GStRYbJL1y+KfOnFreHV34tAU4=;
 b=XXE5dYXPce6nRSdKELDMDVZp5gStU8ecAKVk/BcMmAUicRheKR9SjCSYaHjPn0xFOC2/9ZVcny+sBLSTzNMs28MLvHr9IHwtDSKtB9lHd1TDJtZZbB6b5yZtXXb7qUmmG61DEdO/yppXpHsM+LoyFS45X10BNlzsMZRA3OEhqiAFlyUmX1G3qyUCTJep02l2BEH7LlUgvnYDDsxTAqzqbwSmtwYSrlZezzRG0P6hpvC+itCPYsJ1Wg90OELDoADEV6756LFBfrYOnCZ1EFAcHbMR24WTwppuLD1cVb89PoyUptaT3CLUDwoOqPwufygzrHdWYiF8zYxSYqcJ2v4kCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Heng Qi <hengqi@linux.alibaba.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, Yuri Benditovich
	<yuri.benditovich@daynix.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason
 Wang <jasowang@redhat.com>
Thread-Topic: [virtio-dev] RE: [virtio-comment] RE: [PATCH v19] virtio-net:
 support inner header hash
Thread-Index:
 AQHZqRVyfixvgxNlsUC5ASNdYCAGYa+flAoAgAAIhiCAAGduAIAAXkuggAALg4CAAAFYEIAACUwAgAACI2CAACUrgIAAZinggAAEMICAAKLeAIAAVsQQgACE6gCAAAsIcA==
Date: Fri, 30 Jun 2023 01:36:33 +0000
Message-ID:
 <PH0PR12MB54816F7B067539DF4B09C2BFDC2AA@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <PH0PR12MB5481ED6C94DE8CC414C3369BDC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628123131-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BA1CDA0942170186CB59DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628132122-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814D42786A6981467D3FADDC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628152125-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EAD97F6163C52DF4FF53DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <4132affe-9b97-a81f-ad57-50ed4341678b@linux.alibaba.com>
 <20230629074627-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548127F715FC8B9FB14B5614DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230630005420.GC77232@h68b04307.sqa.eu95>
In-Reply-To: <20230630005420.GC77232@h68b04307.sqa.eu95>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB7475:EE_
x-ms-office365-filtering-correlation-id: eaf632ab-51b0-4295-f211-08db790a6fff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pY3bBz2W6nq/lbGfVKfXRO/HV+fl1JUFLPeiG+RTpXai8TqMF7MT43EM0FMM8yUjk5alqXZrzZKNFARlbAhopDpqYyd8ukxxJUdTVTYGi2t25ZyrnFzCM6p0sCvLmCGGeF4PcfcNhbvcSyAOinrm97FYQOnscmA1javcjIBrn7VjTr0iho/Itevbp8z5eibB1ImVD5mkV85auSMTYaH6c5/gD2VtSMalY6EZTJXpioCl962fylZS/p6GDaCFnc66jkSsLUIhUempJ1GEChLSvNa2TlxwjLc3YO4BzampF6QuyUbNrAgkJvn0U5miML5zYadkmlaWloZEdgz6VmddAzzJ+mwhz195HRHyR7kOF5folxKGM2X/oXyPoGz0zojUEFHeyQHlQ0xNONeeO061MUHBnMe3XYZwUtTetHfr83t42NEBDNf3r6ZhEW2OFx34wg3JyWQ322LaQz7gB2RFMpkn9HimO9GQHaj1ezhEGRxOtFVOu9Sl20b/AVNsiCoqaqJdEHCRKqh38t5mfR4/8Tk+1hblgjofDN0gEjzjmgPrQu2G9L5FHtRxBReno712uE+SLnIi+vk2HVGKdVcbaU1dMuUVy9iiVRitbnrDLPlHRLfzKH1HvGMLdynefbPHm+YTzL9saujMBgz1uxuTfNlNgIeLzJ+8MruGTq4xpqA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(346002)(396003)(376002)(136003)(366004)(451199021)(66946007)(33656002)(5660300002)(122000001)(86362001)(41300700001)(38100700002)(66476007)(8936002)(64756008)(66446008)(8676002)(38070700005)(316002)(4326008)(66556008)(55016003)(76116006)(110136005)(966005)(478600001)(52536014)(9686003)(71200400001)(186003)(2906002)(6506007)(7696005)(54906003)(83380400001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HLxUBBwRk7hC/f0KHSEuhHXBwF6RZuruEwXeRDPZi42CowO9dTDtviFIGtkM?=
 =?us-ascii?Q?JvL2MSdisfKrLEpJ07ZEcKErNrR2yrT/y7/ubDRPvXOC3axKKnBPXxUywWbN?=
 =?us-ascii?Q?tvs/0hpylIWhYwfi4QAN2NLXxregXIDhRg1swwJMKuSiTACYObo5v61yEJFR?=
 =?us-ascii?Q?X6NRaCdEpE1lBnBQftxXtKlstyNBE5n+7ApYKHQeeV5WTF4l8cErwuMF8kRX?=
 =?us-ascii?Q?TkUnZnp+epSWJ0bgq0GFc0+CRJ64vkRRK2UdSTxccu3qDmrX2ySRbW9255Yo?=
 =?us-ascii?Q?bwWcOD0i3nAU3rVVmxwXluI012nNzFoRPYj+WedA6mrgTuJ6IeD5IRZFcx6a?=
 =?us-ascii?Q?yryGX8SdenCrUUTThu+ctmvCFboFUGDAuoq3URLbD5OYVfXezBMQ9/mFx0XZ?=
 =?us-ascii?Q?CqrXc2OzcYj+6haSfQ+U7W9HXKReTl7so/xx/OCsbUldvX5vWnlCpSFPcrW9?=
 =?us-ascii?Q?FlfO+1N/YVx8Tzq7890dttG/l20g8PQW88PHd4s9Xm85k84F23Vuh6tgWdwy?=
 =?us-ascii?Q?pugoUMSo1cgSY61yvzVswFuoBRT66YgiijZrQTfbI7yhAY89gd47j+8p/qbX?=
 =?us-ascii?Q?CypsY6levbhKWu05sNqWzNBmFAEU3+crc5c4sHaMJ8IMS8iUHB24oqA9JgyS?=
 =?us-ascii?Q?rMK2CaU6Om92E/LBZBm26nYL/lU558mLUn9MzpQArirOPALYMu/cVMVdnC2I?=
 =?us-ascii?Q?UsndpFJf8RLo4KKw/fWF27omjG4A9mWVrSy1N6MFfFsNim+aHR5DVUAjSh9v?=
 =?us-ascii?Q?tNeFKa3shfubPu8gCqP9gPwOwzudAvkH8rmj0y2+0E52rJp6aAPwc4FEb8PX?=
 =?us-ascii?Q?RSpxY3bU2JLS5CpGPLEp9s97GWp4Zo4ruJx4NN24drCG2OC4NvhZEwuRW0Un?=
 =?us-ascii?Q?aoyBUVphrhQgylSXaYK7ikKbpWun9pHbK8S88Vmop5SrWtz20jO4Kj8IcQLj?=
 =?us-ascii?Q?qvzHBYtAkj6XcGiqw6/vUlc1z59iL99lZ4y4Ul2ogSZ8IR28yrqmL3aOJ7f7?=
 =?us-ascii?Q?CcjZfuMBa2flkIVlk+ENc23UtuSVSnKc/x10arKOko87MsW5k49mvWv9xG0i?=
 =?us-ascii?Q?xImCr10tW+i1thFdmSmSeI+ijdtvVFG86YKlzfE8tjFD7bF6a2u/+C55Id7q?=
 =?us-ascii?Q?049vu1/L5I1sOKhnxVyBpZ1npQofSRGNz0gh+EWbcmttxlRyCSFWNySPHokk?=
 =?us-ascii?Q?AvU8NPeTQlMLByG81qok3MyIHHDWZ4i1UQw7tYwanXTOw8Ks8LaH9m5QbX6o?=
 =?us-ascii?Q?VN5PfaAW3Dzkn73cH7zUvOsXVPnVQOoeUyfTFaxF+xLsyqJYptmED6DyFHQb?=
 =?us-ascii?Q?+ltWLpdg7jxDN7/G1FAkluGW0zqgUKsah2pMzd/2eYtBvpXMwxQOLm2aXjOi?=
 =?us-ascii?Q?D+ezvlbbQZj8ysg6gxAKS+aBo9WWqjHAf9wrdy6N6I0Dh6vZCihdoY0jthFZ?=
 =?us-ascii?Q?JjSqfw8sCNxNJLc5kVWagZrp4o0An1pjSjgdjL1hhmq23rw//V+iNf50o+G7?=
 =?us-ascii?Q?AJd5UoN4sHzwAyFcxYYZCEE7kcCFKMmZKC6gSJg4NKWyp57bznxvGP+tIIB7?=
 =?us-ascii?Q?A9MqT0L8Eq6jq9angCY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf632ab-51b0-4295-f211-08db790a6fff
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 01:36:33.8547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gFaO4YbCY8AJRN9qJUvPnAbeDXSuHf6gVky4XGvmfImbK7CDkioeXEW8PGxj6W8/PVHi0hiHWCbfkVBwh1nGWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7475
Subject: RE: [virtio-dev] RE: [virtio-comment] RE: [PATCH v19] virtio-net:
 support inner header hash



> From: Heng Qi <hengqi@linux.alibaba.com>
> Sent: Thursday, June 29, 2023 8:54 PM
>=20
> On Thu, Jun 29, 2023 at 04:59:28PM +0000, Parav Pandit wrote:
> >
> >
> > > From: Michael S. Tsirkin <mst@redhat.com>
> > > Sent: Thursday, June 29, 2023 7:48 AM
> >
> >
> > > > > struct virtio_net_hash_config reserved is fine.
> > > >
> > > > +1.
> > > >
> > > > Inner header hash is orthogonal to RSS, and it's fine to have its
> > > > own structure and commands.
> > > > There is no need to send additional RSS fields when we configure
> > > > inner header hash.
> > > >
> > > > Thanks.
> > >
> > > Not RSS, hash calculations. It's not critical, but I note that
> > > practically you said you will enable this with symmetric hash so it
> > > makes sense to me to send this in the same command with the key.
> > >
> >
> > In the v19, we have,
> >
> > +\item[VIRTIO_NET_F_HASH_TUNNEL] Requires VIRTIO_NET_F_CTRL_VQ
> along with VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT.
> >
> > So it is done along with rss, so in same struct as rss config is fine.
>=20
> Do you mean having both virtio_net_rss_config and virtio_net_hash_config
> have enabled_hash_types?
> Like this:
>=20
> struct virtio_net_rss_config {
>      le32 hash_types;
>      le16 indirection_table_mask;
>      struct rss_rq_id unclassified_queue;
>      struct rss_rq_id indirection_table[indirection_table_length];
>      le16 max_tx_vq;
>      u8 hash_key_length;
>      u8 hash_key_data[hash_key_length];
> +    le32 enabled_tunnel_types;
> };
>=20
> struct virtio_net_hash_config {
>      le32 hash_types;
> -    le16 reserved[4];
> +    le32 enabled_tunnel_types;
> +    le16 reserved[2];
>      u8 hash_key_length;
>      u8 hash_key_data[hash_key_length];
> };
>=20
>=20
> If yes, this should have been discussed in v10 [1] before, enabled_tunnel=
_types
> in virtio_net_rss_config will follow the variable length field and cause
> misalignment.
>=20
> If we let the inner header hash reuse the virtio_net_hash_config structur=
e, it
> can work, but the only disadvantage is that the configuration of the inne=
r
> header hash and *RSS*(not hash calculations) becomes somewhat coupled.
> Just imagine:
> If the driver and the device negotiated VIRTIO_NET_F_HASH_TUNNEL and
> VIRTIO_NET_F_RSS, but did not negotiate VIRTIO_NET_F_HASH_REPORT, 1.
> then if we only want to configure the inner header hash (such as
> enabled_tunnel_types), it is good for us to send virtio_net_hash_config a=
lone;
> 2. but then if we want to configure the inner header hash and RSS (such a=
s
> indirection table), we need to send all virtio_net_rss_config and
> virtio_net_hash_config once, because virtio_net_rss_config now does not c=
arry
> enabled_tunnel_types due to misalignment.
>=20
> So, I think the following structure will make it clearer to configure inn=
er header
> hash and RSS/hash calculation.
> But in any case, if we still propose to reuse virtio_net_hash_config prop=
osal, I
> am ok, no objection:
>=20
> 1. The supported_tunnel_types are placed in the device config space;
>
Yes. I forgot the variable length part.
=20
The second disadvantage I remember now is one need to resupply all the rss =
hash config parameter and device needs to compare and modify for this one f=
ield.

Given these two disadvantages, I also prefer independent SET command the wa=
y you have it.
=20
> 2.
> Reserve the following structure:
>=20
>       struct virtnet_hash_tunnel {
> le32 enabled_tunnel_types;
>       };
>=20
> 3. Reserve the SET command for enabled_tunnel_types and remove the GET
> command for enabled_tunnel_types.
>=20
> [1] https://lists.oasis-open.org/archives/virtio-dev/202303/msg00317.html
>=20
> Thanks a lot!

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

