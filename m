Return-Path: <virtio-dev-return-12885-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FC7C7EE23
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 14:26:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7870714E690
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 14:26:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 726C898668D
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 14:26:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 68B2198666D; Thu,  8 Jun 2023 14:26:58 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 544DF98666B;
	Thu,  8 Jun 2023 14:26:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyET2XYsNLyEj1ERi3Stgb+CrR8ai8AsaOMd36ixBXxp6eWjwpdgBgufoNurs8hkujrRaM+zvPoxbx6VxZv0WevC7NjsH66FjbK9ThRoHepINx6NomAzjupx9zO2YhsupYVvd3JeAGsbk01gM2y1noA1puMdEZ7tW0zG3bYY9WjTxHSx8mbJX+1LEVjCiaqACKOz6OpBUS6zBryZzbgqLrIaghTOc50CRuPTn7qejeXiFaOHqPUDfZ285ehcK9rIGW53As0m6xEW1dif2lePje+ntP+6Xnb0Dtl+nlYD+gMUDcsbpTTAKOwKgh/BRnyCvwQDX5RaxrmIsxzem6We0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uAP45dOlvX27XPUkbqlg5fXGEhJ3MMVfdshGbH2BR2M=;
 b=WbZeGfjK80tZYW/QsgvukObz/Ln7lzm7jxRh5u6zfVbr/Qbq8hI4LWlFAK7i3DstC92eDbJ/zAjeIPOZRuyNKJyJCq4gj+yDpAzdINWVIrMTVtKXzHKFZUxNUGySTFtg0J+jxw9CIJNdEAFbVJOCkz70/u/SJzhm3kNgbb8Ln31KFAX9BrKH970nqgZqyPAhIyiFKYeZ7dUN4fmng9PKnLx8aNxz0ZRGOBUTQOZyTJLzWCEgsHgxtOpaqctc7nyGzC/ct86lId0dsjEwEL5OVBQWy/9PvVYeHGUvmoK3I8XpRZjjh8rhg2Lac7maZmeQCeXGFq0qLGgJMb/nbTFi2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Heng Qi <hengqi@linux.alibaba.com>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-dev] RE: [PATCH v15] virtio-net: support inner header
 hash
Thread-Index: AQHZl32d41AbT091pUmTjH3klOy5k69/wSJggAC4LQCAAIGH8A==
Date: Thu, 8 Jun 2023 14:26:51 +0000
Message-ID:
 <PH0PR12MB548119AC6E8CF4A5EBCBA4D3DC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230605071608.73016-1-hengqi@linux.alibaba.com>
 <DM8PR12MB54805C0A8E0E617EE2149851DC53A@DM8PR12MB5480.namprd12.prod.outlook.com>
 <20230608064042.GC28580@h68b04307.sqa.eu95>
In-Reply-To: <20230608064042.GC28580@h68b04307.sqa.eu95>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH3PR12MB7618:EE_
x-ms-office365-filtering-correlation-id: adca4d2e-17fb-421c-6e41-08db682c66b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2l8c581HeNqaOQA8AXODFuFb2/Ar86MQxvca1ntCNNCrePDSZNdXS8vcYUO7JtzploXAWWso85Mlv9ltEwKZLJnkh/8xrmKmgyxos1fIwVn+1o0h3TjDTOPTU3Z3FYYaEdxIz+UyyxS5EH0CJe/hvp0jX66jN5KrmPlKx7FJaohye/zbnMGbI9057dU/xuRTvwhs4y8QW9ETkD2d3WRONxyUeK8hYtKEnnTQINHaLn62uGF2fyWiqaEuigV3/L5hc4wqpdD/n0Kaw3cu23nqq8OEN6XP+39QboJvw68tai7g9dE3zh60yVGcdxSQars+2Pe9L1t46MrEGn0/U1nS9skZCEUj2B7xlmVHVUINJ6bXAeWbcy8eXfIF80r4PN9G+9tM8yCBBoMa8MzTA52XbMTbKX77PKhnmqRWtERGKv3evwQIqLD/HU6HS3WQQG+Ni8DuuQUKBdA3nchMHeiBPRxiFb3wB/G6CWwArOIYvpMtrzCxd7RTHIGWpJfEwfFUvDvMc+jgw66iPv0SkXlK2jApCneV25f3Dtsa968ms4vw2xBLHlkhSvYXu/+tH0ZSxX4cjFmF7vLm7aXkddIiaOlBK2e4oQcrKlZK6w2I6uRmGPCx2SqJn/hJct3kelI9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(366004)(396003)(39860400002)(376002)(451199021)(8676002)(8936002)(54906003)(7696005)(478600001)(55016003)(52536014)(5660300002)(41300700001)(316002)(26005)(186003)(76116006)(6506007)(64756008)(71200400001)(66556008)(6916009)(66946007)(66446008)(9686003)(4326008)(66476007)(2906002)(38100700002)(122000001)(38070700005)(33656002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?WueC9bHAk/tF5cKLJekMpZL2QZ7D+vJ2zVi/PwDiBBlFyOmoeJO4dKlkEL9J?=
 =?us-ascii?Q?AsiMzde4o78g/DUvMRGdV/1jEI8dYm4xRj5V1MJrIB6gyfJCIoUQRIvGUUVZ?=
 =?us-ascii?Q?JP24HopklNvmW3L0dSn0gK1KRvnhOyoO31OvbupI6GYCBdtNRqY9mLJCgIwa?=
 =?us-ascii?Q?KFsclEjtTPoKPVdYqU8fXBQN0RuhnPWa2KuUx2N2wrUxJsiHf6xJZqZebnGM?=
 =?us-ascii?Q?u/oCYZZYT9NYZIBJ/EDqPhrNNzPpiMJVB4NdWE2123aZX7t/J+d2TVx3QbHo?=
 =?us-ascii?Q?70nGmTYIrM8F4dY5Zhehq4Y4AZ2a+9WffH0+BBeaYV6XaZ3SLU8RwR6KDF8x?=
 =?us-ascii?Q?huit85f9lHcTyK6jYtTaFBMM7OTpVuKGOXfaBJswhSNIajnqwZ44+5KqCGYR?=
 =?us-ascii?Q?6trMK13seCHFCOY4dEQF73NYpCFrAumNmLvTGCW4p9zclsoPbtuk76VLkEW3?=
 =?us-ascii?Q?fMXgq+fBWvO+/VZatf2mgezd4Z0tD2XGLMTd0mIBGpNPdmeS1uWGp8PX+PNq?=
 =?us-ascii?Q?eh6bIXe0ItgAK64ETSy7Ny1TKX7dx4sPwmxAndNR9tK0j6PXuLUT5ags+7iO?=
 =?us-ascii?Q?EY3kaUAOX5bqJM8oVi703W7TDT+KOk+Z5ydyk9woUZoQPBrHJjNrrxtwfNw7?=
 =?us-ascii?Q?+WTJOIyM5fmJ5hQw63dCclzMfNkO/4m9XxBKQ8rjjJZ3oHJRH974gHzxQCIS?=
 =?us-ascii?Q?+VAVwckrgKNh+yQGTXSENNcZ5G9fxXZsElKA9xPH9uIiiwH0A/SmTv7uKbFS?=
 =?us-ascii?Q?Aye7YPMqqG56EVSTU1OoJbQIj//n0dBI/3gjWaktGXefv7jo9D5K4Cz9Olry?=
 =?us-ascii?Q?ACzhse55jFZzqrJSc9rOtfrNrcAN0k94qxP6Bj01+sWuvh57QBt7BM/tXxwS?=
 =?us-ascii?Q?ATnxnFQjTZTW1oRenNi1GyugN8ipn/7yDRPyVrMd9Y78YFBylUHYw+71zA39?=
 =?us-ascii?Q?PxRNsOlED8KVm66Q/JtxWRgPx6RQV6CDGlxZYg7x+0H1BtirID6D85YFZiB1?=
 =?us-ascii?Q?hhTYBgZmeqMlR8jScQr/7/LGiAzZGrS+wgVWLRkzyQxhVbBY9cmITr1Dr25r?=
 =?us-ascii?Q?OwJVM+3AJC36eTRyZ0CKvtpIBg54tNLt0nfWWCiRK/A8hg0M7tu1KhesAacG?=
 =?us-ascii?Q?i77IfMWddTWqFKT0LFPS/nY/o/24mPQl1287IjwZ0TdICcKYXhh+cOplEWJF?=
 =?us-ascii?Q?8CeghVKwUCsG8QnZ7XPiEiksRZPRB5KNkD6srfqHx6vYM7yBWAcnfNauMEw7?=
 =?us-ascii?Q?uzxIDlatN0wJ+lULWWs8fVoauprgrObcU+gFHYsHTI027YI7RZ2d0CXNVsgB?=
 =?us-ascii?Q?z3JmPCSdElHcT2m0dhgLNjAp4G3GHH+NvhQR2BgCwpiv2fVQgBC4FInVN0+O?=
 =?us-ascii?Q?rhyDLWCQ2nPcViqzlP3ycZWXhUfirCZtMZytKYN7dpmp0t5cPt476nB4Bl1s?=
 =?us-ascii?Q?SUymO7U7dsOzq5S7X8rs6afMN6aWObalDPkgwb+u+xFTximK3+PUtvud5r6R?=
 =?us-ascii?Q?sFiFgP8o+EYJOVau3SPds/CNy0aj0RTv6YtKj8FwCxBfcJby47UaMAH/BThB?=
 =?us-ascii?Q?aCcohB7munbyN/99YcU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: adca4d2e-17fb-421c-6e41-08db682c66b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 14:26:51.3291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HT/84MlY3DjSvdP2XIe11oLDjyR6I8nfShwyN01EC8zTLgtTvmSW4p6SPaDbJvbS92mFa3pzpiAzhOxgtw1OGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7618
Subject: RE: [virtio-dev] RE: [PATCH v15] virtio-net: support inner header
 hash


> From: Heng Qi <hengqi@linux.alibaba.com>
> Sent: Thursday, June 8, 2023 2:41 AM

[..]
> > > +The device MUST calculate the inner header hash for the configured
> > > \field{hash_tunnel_types} without the outer UDP header if
> > > \field{hash_option} is 1.
> > > +
> > This I think conflicts with the current RSS where if this override (hig=
her priority
> than RSS) or not.
>=20
> VIRTIO_NET_F_HASH_TUNNEL instructs the device to calculate an inner heade=
r
> hash for configured tunnel types.
> Then, which fields are used for the calculation of the inner header hash =
is
> determined by the RSS configuration.
>=20
> Therefore, if the inner header hash uses \field{hash_option} to indicate =
that the
> outer source UDP port is used to calculate the hash, it overrides the RSS
> configuration (higher priority than RSS). It now not only indicates for w=
hich
> tunnel types the inner hash should be calculated, but also indicates whic=
h fields
> participate in the RSS hash calculation.
>=20
> At this point, we can
> 1. continue to allow this behavior. That is, if \field{hash_option} is se=
t to 1, the
> hash value calculated based on the outer source port indicated by
> VIRTIO_NET_F_HASH_TUNNEL is provided to the indirection table to select t=
he
> rxq instead of the hash value provided by RSS.
>=20
> 2. hand over to RSS the ability to specify a hash based on the outer sour=
ce port.
> That is, we can add VIRTIO_NET_RSS_HASH_TUNNEL_SRC_PORT_UDP_{v4, v6,
> EX} in \field{supported_hash_types} to indicate that the hash should be
> calculated using the outer source port for all UDP tunneling protocols.
> This approach removes the need for \field{hash_option} and makes the line
> between VIRTIO_NET_F_HASH_TUNNEL and VIRTIO_NET_F_RSS clearer.
>=20
#2 is preferred.

But I must be missing something.
Without VIRTIO_NET_RSS_HASH_TUNNEL_SRC_PORT_UDP_X, today if one wants to do=
 RSS based on the outer UDP ports,
It is already supported by the RSS (even in presence of the inner header).

So why do have to introduce VIRTIO_NET_RSS_HASH_TUNNEL_SRC_PORT_UDP_X?

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

