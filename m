Return-Path: <virtio-dev-return-11646-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68860C6FD1F
	for <virtio-dev@archiver.kernel.org>; Thu, 16 Mar 2023 18:45:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9EA672ACA8
	for <virtio-dev@archiver.kernel.org>; Thu, 16 Mar 2023 18:45:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 90CC59864A3
	for <virtio-dev@archiver.kernel.org>; Thu, 16 Mar 2023 18:45:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 836F798645C; Thu, 16 Mar 2023 18:45:45 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7118698641F;
	Thu, 16 Mar 2023 18:45:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DzBgG3/VbOTPVUAiNPzHG+FiHNN6vGVuChxfGTQrnPj4eIEtFjHMo+CQtwNFUFxjjmbnDfBlT/E33Heh0/Ya6gGZDvQ+swEwgb9CpMhlcWIF/q4xqULrko7FV9PUjFxLZphAuypmtz2X34wWFWmzqzDBhYujR4/MWHAvLEOtknVwZojzzFTGxadPEhbpgkoXeekGGwtDckG5PvwWvQ/YYE4gQ6kQj+iLM/CuhIeKZ7ayt5YIUhZI3RaU1x/o8MCglbpuVWoJ2zpkqmCueo3hohHZf8A85XIFdNzqKeBWQR5ezuKsunpHSC/tCoVEFAwf9eRLVD3YbyfEZFtIVSiOlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HP699IoH3k5TZFQ3oxn03WlPTsPSwuy+zcMttfDcmNY=;
 b=Cof2QPZgzxtpvu5dFl/9YnXwN/ES4UfG786j6Jv12BxOWp6p1xzNH0PumFSrkTfX2LoXHZsMoWof4GDU6CNRNDQVXaufK+U1ixJi7u66vN2FUwzvLVhTV6AImckipoIWrmvlRPhaK9a3soo0lBPcTTpNIS1jiroXeNZPdw87VJbaAZfQ8l6Kf9ukPT5OguzFEiDpcXZ1wFJd66RpQQSbX9tfkkxUNmTP7fibFD6gtYH6aQTs/FjP6o/+1SBSrxPwgJbWZ3+990t3L2nxF0JzE8/vY+RQZQuBJQHkXuckYig96pfBwhQaN4HQDxvKbDSzMJMZ9K7Vx3rcXRTp7nWTjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Heng Qi <hengqi@linux.alibaba.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yuri
 Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-comment] Re: [PATCH v10] virtio-net: support inner
 header hash
Thread-Index: AQHZUEMWOg/tmrA5m0KZeJICtD2pUq77Op6AgACTCoCAALyHgIAAiVQAgAC6oEA=
Date: Thu, 16 Mar 2023 18:45:39 +0000
Message-ID:
 <PH0PR12MB54810088B0A187DB419DC3E9DCBC9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230306154817.14115-1-hengqi@linux.alibaba.com>
 <c81de233-227c-73c8-a4bd-d43aa374dd86@nvidia.com>
 <20230315075954-mutt-send-email-mst@kernel.org>
 <11cce86e-8068-2e83-9fc5-e1b825adde29@nvidia.com>
 <20230316033526-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230316033526-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM8PR12MB5493:EE_
x-ms-office365-filtering-correlation-id: a5125d2c-a5ce-40a4-375e-08db264ea36a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 JkR0HeyNRsvLspPSKtHtZhOgdxgJXuINJmiboGUhls0O5sqrP99XsMvDjrMfo2cV1gfehmZ/BUrtxqTV2F774qpcWk40Cml5CVLrifSFgi99fjXHpcZUR++NX+41UxP/mEfD+0b17Azr/FA/rmK4kFM4b2+xpY0IJzTVAKAbHEZNgKo1jN+icw1jdg8sXTXWxz0FybwpjP22Rf7qaKQa5ruHJuxD9usY+KlR7U7Uz5YkKhnNQ6m3mTTlkxN/atGTAAwlnMtOvDfWcbVJe43OxqM2drX21CU6czPUM8Rb44fLn6ezV1Th2jKY/cxEaBkyAucOcfoSyOYr4/6RRGq1tb8XD6/zCK6K+e3hrXPAVuhFXG2VXB0+SkRg/+EjHE1z2Q5de3xWhOGNED0DgcDJ/dOEC2ZcTPRp8/p1P0i00GjJYd+Sk5ZC7VTzpYPnDjwR6WYBqjsXRTwZUNNsDX0oFkeJqUqffmEA3zhBpX5raWVjRGvhT0bRLEo3Kx1mYiLnqCop8x2yxO8C7BrYgo2+5zEQwtXDxMdmjOBoEmI0ZtfXAeqVWBfWdnmJXr/VDuLp6l+NE8P+L/ZhAMnDR4jWa5uWXMkqQz6D1ntr0LzEiuPXtvL3KKJ0l0eI9WYaelxS21yYv2NTct2+KEqtB0A9/uG2DSHPzDWp25IABQ5KgWd9D/SQ/N6MzVMN/uABHNyO4ELLDfA5eBWHG0xeHmpE2A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(451199018)(478600001)(8676002)(71200400001)(6506007)(54906003)(64756008)(316002)(7696005)(9686003)(186003)(66476007)(66946007)(66446008)(76116006)(66556008)(8936002)(41300700001)(52536014)(5660300002)(4744005)(4326008)(6916009)(122000001)(38100700002)(2906002)(55016003)(86362001)(38070700005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6rGlTRVoc3gF9os9F72DnWRozoRElEfM3V/q3W3lLcFE1lRP2Znb/Ncw3LMv?=
 =?us-ascii?Q?ThncOEV12W7OyUL760zf2JJeZ7uHIUWE2I3yFFAwHv684JrIi9QtlszfFaop?=
 =?us-ascii?Q?30Mu7Gm4Lq6q01oDYabjIC2gOyYXmKRVT6PGPK1sTglyFK1B+Y1HJKrDhY+y?=
 =?us-ascii?Q?zlDF0rKGkFqAet/0k+O99l735ogfACsEEgSN7tKzEuKwpq68roRmdP/OJRAO?=
 =?us-ascii?Q?H9H+euVFNi83Durl/IKSqjSyttgxa2Eeig1slPpjFF4lPxQRMylrCFN5onq2?=
 =?us-ascii?Q?qn3U2KTg89f4CzKT4EI21tWoUQ0amxphHtN2hRxC1j+KKVh3bbmORwTIN3zC?=
 =?us-ascii?Q?e0x8rbu4S1UjrhvO1Szyh/w9Chhr7Jaemj8TqtanQx0q+y2hSSjosjlscDox?=
 =?us-ascii?Q?btUd2zK5CQrfKX/NNcDqwFbaI94wmy+O34/8isWvg4+Q5QjQHIPvJI/ic0jM?=
 =?us-ascii?Q?ZEbkrv1eU3DbopT8t7lNqPBdYtQUkcCE6asGpz+Hrtoc1cNoYoPdb9HzC1KD?=
 =?us-ascii?Q?1V0JMYqrH27lOdG2KYmkDwxq/H1rL6KhgXLW7f/aK2gRdrspXEg4YTqDYxex?=
 =?us-ascii?Q?9KyNZrw1Qvet29zmZ8UmC6CwRDRPWxXoN/t6EN5CLxVfwqA2oLGZJu1Fo7E5?=
 =?us-ascii?Q?aNgoo+gPgEIdOv0l93U1RB1GtkTnypMy6A7+gf/o9RHb4V1SZ+oE36QjwsSL?=
 =?us-ascii?Q?jkvgRKGGY7UMBohMOSKJ+1KOMxOJOnLJQ5erfMMIDF/L4/mDqFgXMzzeQd+3?=
 =?us-ascii?Q?lMbArOgQmy/6ydwAUP0/oY/NbchhUoIqU3d1xoQWcLeYUg7ShuMvPUYpTfH8?=
 =?us-ascii?Q?JcNsMnFZm87GINoNPcVUs7AwWpw3uCl+GpiscNqSNAb4Yn8fPZR+T7u8dO5/?=
 =?us-ascii?Q?+21Xvb1zsrpP8FOJRxUxadgRm21n9mfoO9I1rRXGI5gpYvQxhTfSS3tbaMy1?=
 =?us-ascii?Q?V5jJTklY2+HeuG+SEkvhjveHB+XLBTfHkAj3LxwBav7DDRh4v0z2m+yhem06?=
 =?us-ascii?Q?G4a0ixf2Wni9L/EsuNOoLFPCYLjn/FtZDDj4Uyw3PSYsL/y6g7w/qHZyPnTg?=
 =?us-ascii?Q?ysV0NRbbi/UUJ6aYVSuIrAhJRdgQY9nI3/cLCQR3RDq97SFyi2JLRF7TwxJV?=
 =?us-ascii?Q?Il10IMBP3Y1Q5xMS9drG+AIOSAdCmXOZrKz3QrPduwTjc3arAagUMAMOSDSb?=
 =?us-ascii?Q?qfI6djNKsZ0RRYmML/bezZHY0nl0wsk83VzFcnXHSnIAbqmRO8N8Snv6KvYM?=
 =?us-ascii?Q?HHm6Mjb0p4lHopUW9zZkBq+hKxBD6utcmcGS0PIT1Mq+giLRxhWbXHnXq8QP?=
 =?us-ascii?Q?AVf5XTHxIhUsMfHJ5Crzv3WHgLQGwQwfRQHHdFMLivzfFDI5Nc4QBcQvbzjf?=
 =?us-ascii?Q?SQQMBavU0l4TbycUPbRpSyjNHpzhcnjJk1Y9Y1pjIyNQTQA+ifna3jdRT5id?=
 =?us-ascii?Q?US7W/h4hT7KwS0zQ6GXPlALu/jwwhfFosTHUkK17f1iOR9I/2c7jVaZgUHhF?=
 =?us-ascii?Q?8HWytMFEA5+9D9nT20I4vtCdT1YhBv+8oGbCJ7wBHeasJQMNRmGkQVlP1Wn7?=
 =?us-ascii?Q?TjlzCPe2KjGkaJJWs0uu9284nMzUBWnrzH0rv/8GcwJ1ebQUQzBRuYAfhorK?=
 =?us-ascii?Q?wqdMnYePErxVO9IPck8U8YU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5125d2c-a5ce-40a4-375e-08db264ea36a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2023 18:45:39.3384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CafKYBrlhtfhY1Cm7a8ZUTH9TwXB7GYor/gS6uggxX46hgEMzuUsDK2xcAEnq+2YGrzWTo2spdArZFiaUvSlFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5493
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH v10] virtio-net: support inner header
 hash


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, March 16, 2023 3:36 AM
>=20
> On Wed, Mar 15, 2023 at 07:24:57PM -0400, Parav Pandit wrote:
> > > So what's left, GRE?  GRE is actually different, in that it's not IP
> > > at all.
> > Sorry, I wrongly wrote nvegre above.
> >
> > IPoIP, GRE and NVGRE are left.
> >
> > vxlan and geneve has the udp src entropy.
> >
> > >
> > Not sure I understand "its not IP at all".
> >
>=20
> GRE header is distinct from IP header and has its own flow ID.

Yes. GRE is IP header + GRE header.
The latest one has the key in GRE header, the older one has only IP.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

