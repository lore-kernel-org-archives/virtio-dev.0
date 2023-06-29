Return-Path: <virtio-dev-return-13137-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB76EB64D7
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 01:56:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 43121157EEB
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 01:56:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 35DAC9866FB
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 01:56:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2701C986588; Thu, 29 Jun 2023 01:56:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0638698658B;
	Thu, 29 Jun 2023 01:56:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CF+EWJRzhqc2fl3ieKG/zUVC7pg+SNCKT0GRUO1jKh8f75cazLpWZXczfORxxQ6RKl71N3gycO2sj70RjGvw84Mgbw0FjfbXgxSdGURCCuiOeCdWrAbEJAASEGJLcwEM19oReLS7wen7vtIscxC9ubMzE2fPVeogXxNo9kkl2KJf/sBGCdqhmwJ6kE6q6zAtN8Oul/BnTba7InU/y2QonOP/fKjjfoflDyQezVOuDMA9lhAnRD86I7WHUAJ7wrfSDMhOqTQxLwVRqX/9r33jTrED1Eap/7h2iJLHL4DoBIT6+L8eM4g7Pu/fWCPPEnhM4vjgZG7vk8Rqq2wBv9Yhrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nMd8JKJca1YgBMp4vPuwXBlcxzagdoJSzv8/6GhSLrU=;
 b=WY5Izyjt5/e/asBzXvUSgL0rGC2WtWx9bB0V/g4X+7BnI+q7wMoYPOWi2S8GV/F3YZSiaeu+hTcl0l1unCc/Xszt2kP4UcDm1HxaBVptLMM7Nx10iVq78VLKrXHEgCDQQGAGjra1v/vC6GzqZwBVFOcGisjKvgm7XMxE3HX4D3ckHp5z8Mj+ko1dmaMP1RPnbOexM1qnDddJ6aQ714r2xH1dOqEeIuKS8bCRhbQY++jhtFhfrtPSqpmBxwmkZDV+W5yj2j6KBtMuowlduE+Gt5nWn0PueH8ftwPRvNW7j8c5ItuFnQihbhvSonprl8y6pyh6eMoN5frwuvfBfz4fWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Yuri
 Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-comment] RE: [PATCH v19] virtio-net: support inner
 header hash
Thread-Index:
 AQHZqRVyfixvgxNlsUC5ASNdYCAGYa+flAoAgAAIhiCAAGduAIAAXkuggAALg4CAAAFYEIAACUwAgAACI2CAACUrgIAAZing
Date: Thu, 29 Jun 2023 01:56:34 +0000
Message-ID:
 <PH0PR12MB5481EAD97F6163C52DF4FF53DC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230627163549.40028-1-hengqi@linux.alibaba.com>
 <CACGkMEvFmAiWDp8w=ytin21Oi+PcTb1X3Eve7Kt2NVr_RkhgmA@mail.gmail.com>
 <PH0PR12MB54811123CFCDEFE3B48D4381DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628061257-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481ED6C94DE8CC414C3369BDC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628123131-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481BA1CDA0942170186CB59DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628132122-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814D42786A6981467D3FADDC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230628152125-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230628152125-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA0PR12MB7773:EE_
x-ms-office365-filtering-correlation-id: 7a223ce0-a1a0-4a4a-0f66-08db78441178
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 fEhGOniamYjJ0lhtZee15VhbVrEXasG7ryzCp7P1sRbnguRUDTP2tiB82zT0tWsqw6eGATvYQLZj/tojfnfJYyIBvJemUzos5BDYYGWHSPC/m0if2rTtwOn3BJ3x8o+eZhrevwymvVeSWplPEr3HduRDBLyrr7R+giTVfr/qM1e1YgNC7Fad6dL8be3N7jF4Qz2axZe3Dx+8y+UNTvoH6FNGMR2YyK3t8JVNayMU2FIr96wjMtswUEbuUwmSnizwcEGko6/FUKnwdOg25UQpAlhQOLJweO1liCcF36Xz5xMbvpdcYFFsIHucZ7Iz522i7lxGgFdOqpjt+2VohM+ElIgkFduPEYqXn72gpVTJEgg+rGBZAtikce2c+hCW4KPZBbTrWnn6ssDFwGnHb3+Jqf5rSlbihJqGrM3pt3xS7r0A7wf2ww2YfBR6G44CrK5qZkeZWim6Ap2n7nSCjm2KjeIB0ILQ7ZDPZn1YcxOVE/4tN1M1KjbJt3X0Ht45evoMZ9oNP1KbLh1YeBQV3+1PDhW6cJrnFGCv6W5xFAY2i9dNXa9tEJrXBxBD0FYi2p+4bzYOGgTCl2lxkrkQAvO+gBbLlNzJ+UR9vBkaBH4EH3EGZm8OOLgvPEUliv2RFCmD
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(366004)(451199021)(66446008)(7696005)(54906003)(71200400001)(83380400001)(9686003)(2906002)(26005)(186003)(478600001)(6506007)(5660300002)(64756008)(33656002)(52536014)(38070700005)(4326008)(316002)(76116006)(55016003)(66946007)(38100700002)(8936002)(66556008)(8676002)(86362001)(66476007)(122000001)(41300700001)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vQXAJCCHgJwLkjD4iCkuQPlN9/XovuvbOmi3vrb5diQGdCP8BjVPFnI3zm72?=
 =?us-ascii?Q?8htYuekA8wVZQWf7sPhBYFAYWxXUyuBkYf7OI+0nAS4SaRm6Q+W0i5y4n8w1?=
 =?us-ascii?Q?xKg51kVMwVP1bJqFLp4c/Fn+xZRPiBww26yF88TpCmFIGjzD6bPUOPREO0YA?=
 =?us-ascii?Q?4+AOP0HqStwOgSuzJwkXEQFlNV/sLuf9dIN+cJbxs+PsnUx28SO4GWrGgG1F?=
 =?us-ascii?Q?z09qqvFNG08Smc0xqZXmmkZw2N6f52GeLjNDQdTpVSGUyDhH0Ix7JcBIujvp?=
 =?us-ascii?Q?1CTSHv8FUCXVzR4NtMwpwCs3tnLZfLL5rRnIzMrR/BrLyE/FRRrfdb4ZKDPJ?=
 =?us-ascii?Q?E2sQQ7TXzdXxfmZvVsw1u3e5mkuubrsTvxqOSegZiK4mLGoGBFgJXAKMAI3G?=
 =?us-ascii?Q?g4Qm3vP/VPA4N7TMkH9uLi6gEFBItMe9DgYZETVvRj1gNWFVr3rzaQl5ncqp?=
 =?us-ascii?Q?66JobMMvPQT8kwJnHZKWzpjXIQW3W7sJuVpOkF2Yb6PNCz6OEeawYsnjongO?=
 =?us-ascii?Q?YthznRBSyKEoP1TZDnZIOKyRUALucvYvPztndtB7nmvd9/AiEw+9iNKDue6M?=
 =?us-ascii?Q?LFlfwYAY7z8FLTH0sxKH77TZWj4pKl+UEo/HoY8T1gr9C9qVrw+Bog8naK2i?=
 =?us-ascii?Q?Dxn/RHrYKI0uN+wvScXoZXlsTPEEyfk1wwgdszP1lSpzQVO7iScFo3bidyqE?=
 =?us-ascii?Q?yaRBHtYV7z83ESbCwfzKS0wWi/9B6hrWKHr55muN3VE3jHPgVtEwQL/CLJrp?=
 =?us-ascii?Q?mbirniBV+KFaiBqb/I7qLDYxEpX2PsMwzk2n0Va8VrTGvO2g7JkXN2SKZYTW?=
 =?us-ascii?Q?iz5lij08wGwXR4ekJ87PJ8nsK3XZHOF2yCjQoGSHerhDeJumpxf/o3BUsh14?=
 =?us-ascii?Q?VdxHz8K6Bi7wb/iv/lZBbi6qOxEqsSaFtcZ6WeQJZuUfSjAd7NeLIkrCI1nW?=
 =?us-ascii?Q?KMyfxRunbT+DHXS5QLIfnAhVC9/xIujEIUN1rupFS/rVykTMWGQjm494oIpd?=
 =?us-ascii?Q?yNTGr3XLI/thiFmR89hSUKM+zn4WRyjWGt24G7napQ3Wzr0vqSi6LOPYUgwT?=
 =?us-ascii?Q?Reh+KDcD65RnUE1Tp5WTeX6Uo17IZx3RIZ2ovAUKyqDdJiJfkhpUtvhwQ/Yk?=
 =?us-ascii?Q?ytiMOqdHYIZGP8hyuCRmFz1paP3AvA/1UIt2WEfpCfAHqWNTDYNXW5uMTBMl?=
 =?us-ascii?Q?prvuJKFvNl/Ux8pO/o1X8yu4y8RRprOlHnAMwtqVCX9vsOiZtqzfErCPrCXt?=
 =?us-ascii?Q?6FRNCpMa2ylpGdpCkexY9qYMh3w0doTjvqH5orAv2CPwSXfJ3Mtq88qnQ9/j?=
 =?us-ascii?Q?8dNHdtOUMKtt1st+1Y0SxG8iX8zR4lfqW3UgD8iHtvRYYrmYCTG3gzTxl4IF?=
 =?us-ascii?Q?ha+KEIwrOfjyieOBLFU3b0yTpvLfa/Z95xkX1ZzTAvsb0GHfQ0unPz0c3dRO?=
 =?us-ascii?Q?8bLg1b6ax5GmptLU7mx5IiiVNueoskNkmf2mqhnXVxWz+clVeXqbTDfa8hYv?=
 =?us-ascii?Q?cZTXoZe5vHKYNDVXmQNRYGu5mTgf4VD8ygj58H8dF96xsLFVvkPOSfzaDP3I?=
 =?us-ascii?Q?jUSgFnaeg1QkCPDn4HM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a223ce0-a1a0-4a4a-0f66-08db78441178
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 01:56:34.9192
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uy8BOZJ5Aihi4XcVqtGpMf1mQeTEpCcOqJ1S6NG32rsdHr9w3ZoZaTzsT4zgdH/5WMoIJh2BsGDFbUKzjJVtCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7773
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v19] virtio-net: support inner header
 hash



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, June 28, 2023 3:45 PM
> > > Maybe I get it. You want to use the new features as a carrot to
> > > force drivers to implement DMA? You suspect they will ignore the
> > > spec requirement just because things seem to work?
> > >
> > Right because it is not a must normative.
>=20
> Well SHOULD also does not mean "ok to just ignore".
>=20
> 	This word, or the adjective "RECOMMENDED", mean that there
> 	   may exist valid reasons in particular circumstances to ignore a
> 	   particular item, but the full implications must be understood and
> 	   carefully weighed before choosing a different course.
>
RECOMMENDED and SHOULD forces the device to support MMIO, which is not good=
.
So rather a good design is device tells the starting offset for the extende=
d config space.
And extended config space MUST be accessed using a DMA.
With this sw can have infinite size MMIO and hw device forces DMA based on =
its implementation of where to start DMA from.
This also gives the ability to maintain current config as MMIO for backward=
 compatibility.
=20
>=20
>=20
> > > There's some logic here, for sure. you just might be right.
> > >
> > > However, surely we can discuss this small tweak in 1.4 timeframe?
> >
> > Sure, if we prefer the DMA approach I don't have a problem in adding
> temporary one field to config space.
> >
> > I propose to add a line to the spec " Device Configuration Space"
> > section, something like,
> >
> > Note: Any new device configuration space fields additional MUST conside=
r
> accessing such fields via a DMA interface.
> >
> > And this will guide the new patches of what to do instead of last momen=
t
> rush.
>=20
> Yea, except again I'd probably make it a SHOULD: e.g. I can see how switc=
hing to
> MMIO might be an option for qemu helping us debug DMA issues.
>
There are too many queues whose debugging is needed and MMIO likely not the=
 way to debug.
=20
> The time to discuss this detail would be around when proposal for the DMA
> access to config space is on list though: I feel this SHOULD vs MUST is a=
 small
> enough detail.
>
From implementation POV it is certainly critical and good step forward to o=
ptimize virtio interface.
=20
> Going back to inner hash. If we move supported_tunnels back to config spa=
ce,
> do you feel we still need GET or just drop it? I note we do not have GET =
for
> either hash or rss config.
>
For hash and rss config, debugging is missing. :)
Yes, we can drop the GET after switching supported_tunnels to struct virtio=
_net_hash_config.
=20
> And if we no longer have GET is there still a reason for a separate comma=
nd as
> opposed to a field in virtio_net_hash_config?
> I know this was done in v11 but there it was misaligned.
> We went with a command because we needed it for supported_tunnels but
> now that is no longer the case and there are reserved words in
> virtio_net_hash_config ...
>=20
> Let me know how you feel it about that, not critical for me.

struct virtio_net_hash_config reserved is fine.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

