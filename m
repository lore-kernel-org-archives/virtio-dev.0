Return-Path: <virtio-dev-return-12019-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BD3C7619A
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 13:03:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2CA5129FC9
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 13:03:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 274F09865C3
	for <virtio-dev@archiver.kernel.org>; Wed,  5 Apr 2023 13:03:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1AE229865A7; Wed,  5 Apr 2023 13:03:34 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 09D5E9865A8;
	Wed,  5 Apr 2023 13:03:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ky3cYeJWUoLLZmWSuQDZNvYSLcr7LC16aeBdrS8kQuJV/3HYujic8KM2oNizPSHMrPOz0ZEFstDFGMqeWjAoqnTeSVB8WUm8zXP9yyptFUowWJnvzXo+KsWzsPavJh/FDP8JIYK9d1uB6f/3TXpUaxjHibJkPlcuZsUYqA5chORAV26MCE99l7L4TvITk91VAr3a2GcTbTVflIm/vVVpbpnXj3bfTPLr1lumryfDNd6zFYufV6HkBRnV8bkwGclJiijQk7vIUQ7Yf9S9pcshU8MrrpM4msePhJg+1G2hkXRDo5QL5eG03eS5tUW/NbrmW5090ZyheVwH8mplrOY+Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4a/VzjzRgAyE3sXk9PiDuomNG+4t8d1Rqs5dYi+w6k=;
 b=PLfB1fEQNJbLyWX4xYEGLxpPKdFFhkgr5vTV6CciT+r4+fwysVY273H02cU7TO0dgTrZob33kH/9CldD1s6FhCj3uYHvDgHfnBDcyEfdzWuqT7qg4eu8nF6VEZIx/LLpZj+X67yINAte7/+0jd2tDoZcTXZBycHavtAqy2JQlBRJ8T8rj6wi0uITdBdWUrBaSQ6/G3H2GJTwBFoEZvc2MQStEhLyoLmEIfiTPbAzGOeb8yez4NiqgGT0BN5VmtV2r7TTHcXoND8qH13QCyqqmlVS3RyyVUcKz0qcHhzqq2G7PMuVSV0dqgzKLn5ZCJqFT6M8cAAijxROUYR5zWRizA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "sgarzare@redhat.com"
	<sgarzare@redhat.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v12 01/10] content: Add vq index text
Thread-Index: AQHZZ1r76yVHvMh3sUulmC5quinH068ccIWAgAA+kdA=
Date: Wed, 5 Apr 2023 13:03:29 +0000
Message-ID:
 <PH0PR12MB54810141129464569ECCC825DC909@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230405010657.612529-1-parav@nvidia.com>
 <20230405010657.612529-2-parav@nvidia.com>
 <20230405051801-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230405051801-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH3PR12MB7596:EE_
x-ms-office365-filtering-correlation-id: a5a50fa1-8f4e-4384-116d-08db35d626b4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pfdZKudTUzuJHMC8wRp8WWOjUEp7p/a/I6wWbtG3rosYsFnI+2DJR2wQNnMlO+JXQ7LpaPS+jKyxotD+rmZgy0//QTDnZObemLSAg/O3gRlvlzq0xp8Vq6S90N2qMvBilcVJ4zzZE2qZ1aWRFBTBuoeun5LDtO0fzn2/tPDH3B0XVH6FvT1YbwKDnSiI5reDlHh56fNC0EeZjsD0hC+6ts+vWKLDOB0ym8F66Mv8dvNzDHvjwbsr6ihvcsh7gz1mAoT0ywHlN64S7t5rH0gKJZW6hcrOyu0fQQtzg50bYkS0XiI2HelqSOpp/pDMOg8EzdbiVbhFMtlRLFlaXNW5DKuKXujGC/N9GHpWP5A7GHVIMqe4tA4i5xhpNbd5BX4szV7INEbNS59n7LOUdHlJDvgfFzJviETdHfoaVBTxRz8A2/Y+ilIYqyERZXcgcwRfZ3sdU5LStpEOo/JCoeGLMaC1tHnZXZTOPUkn+GmYvlMgGjjmKxo/d6NSEQGIu5s/zCuDvzMCSgv7szeAYI1BbxKO/ktFNIhxuRIMV0/YB8XcjGbSRKFb06XwnGNVbt7iNfrwSDqdCDS49VqfvzkLV50VOfGRlwyAJ5uj7Mq0M19T4EDPYsbn1JAHYGMYT3HZ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199021)(9686003)(55016003)(186003)(107886003)(52536014)(41300700001)(54906003)(76116006)(8676002)(66946007)(316002)(4326008)(6506007)(6916009)(66476007)(71200400001)(7696005)(38100700002)(64756008)(66446008)(2906002)(122000001)(33656002)(5660300002)(66556008)(38070700005)(558084003)(86362001)(478600001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2jUhi7M69CHMatJTWvPPBlqjcnAxYMQcPaTP46Tqe2Db/X6yf5TDjbiLgn7A?=
 =?us-ascii?Q?0qiP4Ak15RtpWDQHKp9E2FuCmQk65F+zOPbjaTTvmfsRuSDhXneP40DkD0XV?=
 =?us-ascii?Q?MWYODO9DZbkOnsV7iXrcLaG1kI0KzsIt/KVl0D880wDg/3EsXSokMhThx0FS?=
 =?us-ascii?Q?mT3ERbBNQSvAK6Y7pkjmshbmoKfMSxIlWhwYCqT5o6BGTGCsOv+s+mE1qCsS?=
 =?us-ascii?Q?8zsuP2dHCAbHiR4m3gg59XD52/BXm1M/+4hzEbBjEUN8AjSvcLK0WoPXzURy?=
 =?us-ascii?Q?4cG+SNf7gnTKIF9hI/wIuMwwMJ2h7CvlU7pIlNjwX+ymV3uvaRADjjBR4KQp?=
 =?us-ascii?Q?rElVhgcK2G0ooZ64EJUGuCVy5vTE2F8Rp74AEZIk2WxhjfsRuyZPcBK6G3ew?=
 =?us-ascii?Q?sdXOxNw3AqKtbOBJVSUX6mgA6KulmkdGnQUQebx+MoZm3rW9hQkEVugH4oIr?=
 =?us-ascii?Q?bbJW0voLTYqhlgVmrMucffSGy/sYJF8QolW1ihGYAl85VqPE1vr+aQYSDVPF?=
 =?us-ascii?Q?ysC7vKb76m59eOvAYaCnNLBzySKKizvG68pqe/oDwWiL4zJGmSAhRHgf9fun?=
 =?us-ascii?Q?phy0s6MDdidV5HTGYSznAj+BS1Aeh49X00IBHW8OUGqs1LOaVEaD0YF4OI/F?=
 =?us-ascii?Q?ZO/Bt7qKh8kOQi3i81bWg0fyyxrKPuH/0AA8RcEaWIxLWWreTBw3HFYivDg9?=
 =?us-ascii?Q?FBaSG3d0WTZ6Asl6d2ONB4x6Ah7Jfo8bemHkU1zObtdy4b0Ch3LEd72PmwlS?=
 =?us-ascii?Q?EXl+3ftFhWXBYTkAcPThC32BDoigJVNzJ5kkpc0R0wul+bWzhAuaKfyuHCDS?=
 =?us-ascii?Q?ki1l8Wkzkv9Cw1eZu35H1Ybz54OFr3nwz4P8rHyDWxdHJZq2xZYaSSvQTwFs?=
 =?us-ascii?Q?vpPL9xIvOnxApzUF5S6avznjucq6t/heL9VsC01Ip1qlBsHGV8gEWJaq02Er?=
 =?us-ascii?Q?kzOTmJ/kkdgh0Si4LGUc5DEiYm9Klcz6GL8xnn7MtdP+0dLaILIzHCBb5FmD?=
 =?us-ascii?Q?8oSPGK8D7XSbIce9uu+PLf7hOFvOg8FebGZ46nc7PnDKLK6EQ6Xq8afXVGCV?=
 =?us-ascii?Q?wW8C7+Q9X4IlqUkbBoIPOD5TdbmNXJPgnZfmw2kONZNnZQUZCFS4sVZ8hpqi?=
 =?us-ascii?Q?0EhPSshCzB9ZOzrJ+zGeC3+iAlGFXjYwx0yFaEhTNJO4qZE1vkNUfRNFG20W?=
 =?us-ascii?Q?fQrHa1hCsQ7/xdVUXeGfQJ1kdUrF8+E2dOQLsE6IvHuBCHUPMqF5F1jNevBm?=
 =?us-ascii?Q?tcfJ0VlhFba8R6Vt3BvfHNjba1hDNS8tqs8spbTrJyntrMvIpDqMFkTYbvcv?=
 =?us-ascii?Q?NRkPrAwx8aihcM+06tJLK1D+hZriaRsNL5z8wfX/d0GO2P1pkTtCv1ChBg2Z?=
 =?us-ascii?Q?4lkaGiwqbRGoioaJRlFkuIroyvqOEfnRfX91fnLZ0YbxClCDSlG3yg9Q0xXV?=
 =?us-ascii?Q?ctLm5l8EiwsyWplNoRi79vZBJ3KPxvzTCH2WglQ5S9ssZwqGGWv44SeWSH8n?=
 =?us-ascii?Q?QjWeTsp3UzAp4HJdJvFEzEwLpXPXeptr+Qx1c44r0YB+oowzsnImGbr3G1Pi?=
 =?us-ascii?Q?BQwzpMfh6BBGwdb3zDt8XGbASKahVSMeK2sfVG3Uw1HWBv6AYVw9MV5389o8?=
 =?us-ascii?Q?Lntpc9l+kAadkXzBwI+6nIk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5a50fa1-8f4e-4384-116d-08db35d626b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2023 13:03:29.1133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cw8XovZ0soP3wT6Tvu+SnERcuKzky/XzXIVUZaKhgMswVlLmOUrdJJs3r+2zLyY2HhbWRhL/a4TcboUfOBc6wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7596
Subject: [virtio-dev] RE: [PATCH v12 01/10] content: Add vq index text



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, April 5, 2023 5:19 AM
>=20
> In fact can we just say "virtqueue index" everywhere? The less slang read=
er has
> to learn, the better.

Wow, didn't know that "vq" is a slang. :)

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

