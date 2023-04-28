Return-Path: <virtio-dev-return-12480-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46AF7C77B60
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 08:55:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6A3FE2B03F
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 08:55:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4CD58986687
	for <virtio-dev@archiver.kernel.org>; Fri, 28 Apr 2023 08:55:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 37DA2986682; Fri, 28 Apr 2023 08:55:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 24DFC986686
	for <virtio-dev@lists.oasis-open.org>; Fri, 28 Apr 2023 08:55:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1682672100.714000
X-TM-MAIL-UUID: 0149fa0a-0c34-455a-809c-11f92751e4a8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9l+4/owIHSjcYMkYnvBFxaZKzANmG8PTDL25lY+1BiEUKjVfGZrA6qYDptopeiHkXPrifFuHOb/845jPhSqtw9VFRDTQo8kCKIGZQU8O2TG5QRVyk+KZDKbQFdWT5e2up3miXLuZ3ju0QWKouDHE90c2bC8vhfwYh3qGTiMEvhpDuChhc8J8XPx6toDioURWwCDFSBuZfEsAydigHiytatiSa7lyHco2Jop9vWdzq++vWl2lh6az11zT8tgnOjDceutjXhGlQIhN2U46N2bSvu3yQaS/n8T+2e3h3YbrfEG4AKro2iCasHXt63b6wrFVgazYkNQ9saytVi6PL9gkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8SdHQUP91Wsf5RI9lh57ao1aOdvzFnsHYjFKd7YTIQM=;
 b=MIKaRJnYsDJ5K2ZAdKewo9KOCCuwvz0XINFFgZBrz4BwmF4XL6nB7NewAhr0OHTGZ9EBPfh27ny421iwRfhEjY54T+sLGteOe43SA5z0JVFk+2+hSuj0rLMD4ieR87USa0/l1HSU9UJ9UQD4fQaxrz78mbmI7p8Kndhvzfxc2G16lJJxHYO7KaAECjBMbDh+kVp32GDdNPVT/ejwEY6m61icvcFjfqsD8q8O6wuhHMtklF5xP0jfQgZx5qoMhXZlwh6oQlwkX4Y6AUFOPRC1N6qXhWBBpqaJMPuCrIg/DgpOhZiURpKzNIvfIdeb1+e2DJbuyn3Z8utbUy8Z54L//w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <0f67a3ac-4995-154f-142f-d49d1684aa3c@opensynergy.com>
Date: Fri, 28 Apr 2023 10:54:56 +0200
Content-Language: en-US
To: Alexandre Courbot <acourbot@chromium.org>
Cc: Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org,
 Keiichi Watanabe <keiichiw@chromium.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Marcin Wojtas <mwojtas@google.com>, =?UTF-8?Q?Matti_M=c3=b6ll?=
 <Matti.Moell@opensynergy.com>,
 Andrew Gazizov <andrew.gazizov@opensynergy.com>,
 Enrico Granata <egranata@google.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Peter Griffin <peter.griffin@linaro.org>,
 =?UTF-8?Q?Bart=c5=82omiej_Grzesik?= <bag@semihalf.com>,
 Tomasz Figa <tfiga@chromium.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Enric Balletbo i Serra <eballetb@redhat.com>,
 Albert Esteve <aesteve@redhat.com>
References: <20221208072325.2259940-1-acourbot@chromium.org>
 <87cz6mnaqk.fsf@redhat.com>
 <CAPBb6MWNfPH+e8=4zUcq2dV-59OdzTYSuN04Cg2rRPWao-nseQ@mail.gmail.com>
 <877cwttw2x.fsf@redhat.com> <87a60kg9rh.fsf@redhat.com>
 <CAPBb6MX+R-bDgJzracbZq6DE7B0WO=rtqS6GE1QDugdrFLryXw@mail.gmail.com>
 <877cvog030.fsf@redhat.com>
 <CAPBb6MWyVoEuXJoKvJhP-5zp-x5WrDwVWe8mxbXbCwyzfgqW1g@mail.gmail.com>
 <ca84a8f5-71ed-aea8-5751-60403d167283@opensynergy.com>
 <CAPBb6MUDWVK87_kGFen36tDJQoR-Les6djcKVihjuTKQBjweEQ@mail.gmail.com>
 <b5c9d69a-fbec-8046-225f-bdb5850bbd54@opensynergy.com>
 <87o7nmk1rs.fsf@redhat.com>
 <96978ce8-0837-2e08-f5ca-66587807798b@opensynergy.com>
 <CAPBb6MUHXh0XYLH=8anWLNQaS+p6_VhMRki+qSqFQGeYQzBSSA@mail.gmail.com>
 <2d5df33a-c246-81ee-92e7-a44712600e62@opensynergy.com>
 <590378d1-83e0-b058-7eeb-2dbe5963670e@opensynergy.com>
 <87354okkx5.fsf@redhat.com>
 <c1658889-0a90-5681-6afb-7160cdf1bf77@opensynergy.com>
 <CAPBb6MXNUHJuq40-RQO-0aa6UU0R_ZOHvB48B_t_knpK4Uw0eQ@mail.gmail.com>
From: Alexander Gordeev <alexander.gordeev@opensynergy.com>
In-Reply-To: <CAPBb6MXNUHJuq40-RQO-0aa6UU0R_ZOHvB48B_t_knpK4Uw0eQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BE1P281CA0404.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:83::29) To BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:4d::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB2663:EE_|FR3P281MB1486:EE_
X-MS-Office365-Filtering-Correlation-Id: 40bad3ad-1b4c-4c5b-3b1f-08db47c63f44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vNJdwZ2AQsV3nkD60BzdOe9K7HO12YSXzYCmCC0UT0kLc78e47K7jPXr6XZyf7a24e6ZsQM4ppi0sYvOXnWw/WotvS243yghZomc1ziOJNljthJr7zddWns+09g5ZanOM7uK4Dv4QpXS6HE05PO7nfeaTu9Fo7/gvGrXZhUzl3vaBMoZdZI+XBhftHYnGPBfG9aiN0xmhm878VDSo/aSgdyxnGmKu7wuRj3b+hxqIYHnci7UlSgl7MQxmajLXjRL6P6VSx30Qrifv8a6MphUNt6UytrrQUOtie3bYwm3muRQFZtfQT9mlxXuIwbN2nbyGOFnhCCW+T4ZYUcW9drv/Pg+nKsS20dZhLv5AN+QnAGre2oQ+zx2fS73TaB/YhsqUdJbf2JQ2a8DCRb53A8Z+jfXuIUYtAU2A1r1RPxF93lhGCJ7mMvSNIbvPB52zFRs11ayA23bUmKRaqAYClIrCrw6NJyhLBWfwbO2cX+yJch20lt/c6oT9AhfYG5arHSU6vdJ143uVH4T2hm2UNeuMv+f5dJg+NGlPB2D8RghMwE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230028)(136003)(39840400004)(376002)(346002)(366004)(396003)(451199021)(478600001)(66476007)(4326008)(66946007)(66556008)(6916009)(54906003)(7416002)(8676002)(44832011)(8936002)(316002)(5660300002)(41300700001)(42186006)(38100700002)(83380400001)(2616005)(186003)(53546011)(26005)(36756003)(15974865002)(86362001)(31696002)(2906002)(66574015)(66899021)(31686004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHR4bUFSejBvUk1OVkh1Vk5ua1NTSEVmUkRydU43dVlSSzB4RWV2T3kvYzI0?=
 =?utf-8?B?VlEyNWhpZmh0U0NKbGJRcmQ4MElOa0pGYUx1NW5nRDJKU2N6aXU4RlA1SFRD?=
 =?utf-8?B?N1VsUjNZdjdPL1BMM2pCaVdwby9pWWtBMi9kaGxGZ3R5YVFESDNhUVlPNG1H?=
 =?utf-8?B?TFUrd1pKNS9kR1lsNGx6RzFnMmwwcklmNFgvY281czJGYVNnTmJqNHhrWEkv?=
 =?utf-8?B?YXlZQk1iMXhGRFVIUllHaWl3WlFVZTBHS2FyMzhWTzIxT3RUcHVjbnRiZTZp?=
 =?utf-8?B?ZWUrSm5ZVE9XRGM4QzNlR0d1YVBiaWZJYTl5VmgwTzdsUmYwT2cva2hqWUZk?=
 =?utf-8?B?NFZDbkhHV05nT1dCdmtkcjBla2drR0luWWVLRXBORWhGdi9nQ0t4cjNqbEdN?=
 =?utf-8?B?WmpjakwwQ3p3NUZVbUEyU2ZJYUFlNzg0MC8wdzE1eGF6TDJGVlIrYXpTRG1i?=
 =?utf-8?B?OU44OFFiZFM0NWt5K1MxUit4T3d0UjUvbkEvYmtjZGFIUExXS3RxNmhhRUlp?=
 =?utf-8?B?TVphckEwMzd2bnZXM2JWOVVJc01xTnk5WGZFbERXRVZGRXZFQWNBTkJwRU5u?=
 =?utf-8?B?Wk15czN6WEs4dVU0UnB2NUsydjlrNG9HUWRvcXFqNFFiK3dkREVHK0x1TG5x?=
 =?utf-8?B?VFEwNEc5NWNZQVlMZ3JveEx1ZEl2M2FkcFhrT0E3dE1ZQlprd09uRHBzK0s4?=
 =?utf-8?B?bTZsUGZaNWsvSFpLNVpvQlYxV2l6Yjc4THNxNWJnbnQ1UjRoa05FNTBhQUxI?=
 =?utf-8?B?cS9JbUVPaDE4alVCRlJjWnY0Y1E0bUpmTGo5dHp5OHlwYkw1SmZwdlNXSjYx?=
 =?utf-8?B?NlltTWhDWnNwS0hzWHJRa05VTjlZbGJGeDgybkMrUUJWUUlqV2tlKzZteGFq?=
 =?utf-8?B?YTJDTUt2dWdCblZkL0puMXc1THlmWHEyT3hRL3BLc1RUWFArOFo4NXZNT0Y3?=
 =?utf-8?B?LzEraml4VkhXOU5vLzNCL3VpK2ZhV0s4NmZGREpQVlJPcEh0bFNyNmx0TFNi?=
 =?utf-8?B?aXRIM1ByaCtpanc1S24yZEpGWHFDMVpnY2JEdGF5Z0NHbkJMUVl4S0J4ZmFn?=
 =?utf-8?B?REF2cDBPVGl3emk1MExXY1dqcmVUSjdPTk41MDFPYm9TUkRSTU80dlczYlMy?=
 =?utf-8?B?YjdidG9mZE82YTNWUG9HcEgvVGJnblpxOW5UeS9xUmlvNFltQmRBZDRqWnJJ?=
 =?utf-8?B?VFQzTm5hQjJJUDBHK1lqb2dCeU4wMXBVVUVkU1MzRGQzWERDdEVCK2JCSjhR?=
 =?utf-8?B?aG9Ua2hQUHZ6NkE1T2RnSmhOWlFHMFZ5cGtDUElYbWltOWUwU2VHSDRLYnN1?=
 =?utf-8?B?NFNOTHBhTSszSnVOZ04xNjdmZ2traWtOMWV1dHUwSXk0ZkxvOU5tY09VRFA4?=
 =?utf-8?B?Zzk1OWsyd09tOWNGb3VRNkIza2RNN0k1aEd4dUVLRDltYUFPZTFIeUtaMnhG?=
 =?utf-8?B?aDBEdjd6eVo5MUdhckVQQkNzUUVKN3l0WkRMS1B5UERUUW9CaEx5U3pBekhL?=
 =?utf-8?B?NlBSTGFyeW1Fa01XSEtEZ1liU21hS2lyOEVDUkJydXZqSTloTndqamw5eUo4?=
 =?utf-8?B?bWVtVXZqU1NoMEJ1VkJ6aTlRcDNBcUg1MFdaNmVwWnpOVGo5YXg2M0V0RmtJ?=
 =?utf-8?B?K28zeFFjRGJHRlZNR2JhK2J0Q0FXSEpSaUtoUVpxRjUrT1U5aldzTTdMbEc5?=
 =?utf-8?B?REljSndCZUgxbDlMS3ZPTzJpV2h6b3ZpTEtFbVF2czQwandRWTVQSkY3VytZ?=
 =?utf-8?B?bEhxU2o4b3hZNkJ2amw2amFxOGJINUhjSVkvNXQ1SUpGN09Db20zTHAzMk1C?=
 =?utf-8?B?a2pibFA2TFJtTnl3MUw4OGhjazUzaTYya0wwdDZJU1h4MnM2U1pXNmlkaGVF?=
 =?utf-8?B?Sks1TnQzZUJyZld2a0lDTnQzSEQyTkhoSWpsa2FFc1Roai9ZcGJBc3RzQWFE?=
 =?utf-8?B?eHFwYVRDQkg2WWF5ZEdGRml1RUxYZ01sQk9vcDBsb1l2QWZGbzI4OHQ4bGoz?=
 =?utf-8?B?QVNCb0FGVFVvNFlqeTVKWm9BQUVHeWRJV1NZVTV4T2xyaC95MUpSK1NvVGEy?=
 =?utf-8?B?UU45d3pNUlg3N1VNbFpRRmR2cWxWT25ObmlpeXlNWU5IamgzNXExazU1VFls?=
 =?utf-8?Q?v2+pN56pF8GO45wel6ijrCuwj?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40bad3ad-1b4c-4c5b-3b1f-08db47c63f44
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2663.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2023 08:54:59.4666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +u27cIYYubuczR+I9Q+9CNm8QsiSc8OG11DmovEPyzPyMdBOWemuhmwqaWcKewWRS2Jnj5gLW/LMUqkWj6mIfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB1486
X-TM-AS-ERS: 104.47.7.174-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1007-27592.007
X-TMASE-Result: 10--22.206200-4.000000
X-TMASE-MatchedRID: 8HTFlOrbAtH/9O/B1c/Qy6n9fPsu8s0a9mojSc/N3QeqvcIF1TcLYG1A
	+PyfVi9VXnkEfGIdlzfErKZVJCtGzsEElERnDJHCshZoVNAELFPkzWxwXGSAYT+B/tp8itBTwmq
	SW0kcMLatVnlxd5OEdNwoJ74c3x8zKyefC7mVhWGIf3m0sUfx5za9tZoo+dDbPZx2ikiOs90Y20
	f1wrB11v6d3fiDekev53xirZipBfXPtIl/QS+CdZ2uXLKwL+3F+VJ6lZyB0s+NJ2ckLRg2UVYJk
	fu4u7x5RofMA/ie9N80I0ICjLnLEyUm8UPh6NieEVuC0eNRYvJReWnUUdhI9S4FeB/gIV0sb3rP
	IS7qVoECBvE1eIcYKkvQhHUGJX4NvyBUrJVp7YFruPKJRNQw6HRtdYJvaoYubsHtQ0J95tR56/J
	0VoTFPdBprpgAw9z2cMoE46W3zJ9V5K+cTQfBHGN5V59dR3bUIpqNt4sWOA5MotU/QFIFG9lvGs
	zx4amtkVyTXkTfaH/Di/VE0FdnW/y7FA6y/SLkWCjDJRYeAZ1FaX0GXRE81jGSeny2m+NuouhIs
	T8EDFkU6Ud0/D0Li1QWSly1K68BP6PXwr8HZOioxQNkk1aPuG0Zqaz0+DLCFLWvi0IBGTDuWsdt
	WdelAYpsmNGAE/ypQ7X/p3cU3x6+W0xUJ0fx/Z+Ln1yqKgD0odQJXaDex6eQYkZDE2p7wM65Qer
	n2w9CywMD+nV5RTgOpmVTrU4wTF8+dSqKgz8/dhkilCSjv7UNW4va9iqt3pC/BCs92qoiMVdfMs
	aGcAtjvTA71MypWv/EMEB+Cg47qJIiwhbq5S9+yskgwrfsC30tCKdnhB581B0Hk1Q1KyLUZxEAl
	FPo846HM5rqDwqtlExlQIQeRG0=
X-TMASE-XGENCLOUD: ed7c096e-951d-4e61-9827-1728854b9f51-0-0-200-0
X-TM-Deliver-Signature: 79350061A59EED964EE4D1425ED64B73
X-TM-Addin-Auth: 908/Wd3PN7/gR9YHiUFhUlDFSESE7bWcCR8L3T/SkXW93QCPhI5J2Alpg3a
	pRIbMhlQuB9LDcGJwq6UDXmm/wuZvP+PzVuNQ5QYrPJw1ulhb1k//OjHvLRPHyYpS2hgV0B4ZoX
	kjpaOI0HU7FMM6FFgQgpbUSLlyWTpZoNhZB9nOueXy8qczwSDmVyWPNbB+AVmTo/Bu8aOMBMdo4
	cKWIB4ixKsHtQdt5j7ssqZ/YpG4wpUp2jt7JlHk4243IyTn7a4UbB4cyRI2DL289p1ASX/kxsTE
	ubfqNcHzprFRAew=.sBiktF5c7H4PaZTbetBYGEEoaQrVv2y83vwiTqQPhMTawX3qFqFpa4EkdR
	HsdCebmFfCDzGtRem3nN01cg4hpxCJVhKNc4avYyfwdRKtdJh5xKfBih8gqTMsZggxQ20AThJmI
	Ess3Ar7yZtvooJ/tkkF26DQhjyYjJzvleoYjGdZ5P2RKfIXDvP4PvnRT2hASFmP7K4dR8IX6Y75
	bJ6uXKzJtj4RaOqb1jmSzidHQxuK+LmW85hFy7BWuo5BTAGlrYjEsT7xYmx//zqdivNiYq1FYAy
	C2PcreSFmcGVj6MfGYOSYTtC0nL5kWmqGzN29jPvoPjOa2kVNNZP5XeGsUA==
X-TM-Addin-ProductCode: EMS
Subject: Re: [virtio-dev] Re: [RFC PATCH v6] virtio-video: Add virtio video
 device specification

On 28.04.23 06:02, Alexandre Courbot wrote:
> This is going to be my last answer to this thread ; I don't think I
> have more technical arguments to give than I already have and the
> discussion is drifting into territory I am not interested in engaging.
> At the end of the day it's up to the virtio folks to make a decision
> about what the best course of action is. If we end up with
> fragmentation, so be it, it will still be better than the current
> situation anyway.

I agree with the summary. I think we have discussed all the things in
depth and even reached some understanding.
Could you please at least share your feedback on my proposal for the
QUEUE/DRAIN completion handling?

> On Thu, Apr 27, 2023 at 11:11=E2=80=AFPM Alexander Gordeev
> <alexander.gordeev@opensynergy.com> wrote:
>>
>> On 25.04.23 18:04, Cornelia Huck wrote:
>>>
>>> [I'm replying here, as that seems to be the last message in the thread,
>>> and my reply hopefully catches everyone interested here.]
>>>
>>> To do a very high level summary, we have (at least) two use cases for
>>> virtio-video, that unfortunately have quite different requirements. Bot=
h
>>> want to encode/decode video, but in different environments.
>>>
>>> - The "restricted" case: Priority is on security, and the attack surfac=
e
>>>     should be kept as small as possible, for example, by avoiding unned=
ed
>>>     complexity in the interface. Fancy allocations and management shoul=
d
>>>     be avoided. The required functionality is also quite clearly define=
d.
>>> - The "feature-rich" case: Priority is on enabling features, and being
>>>     able to re-use existing V4L2 support is considered a big plus. Both
>>>     device and driver implementations will be implemented in a full OS
>>>     environment, so all kind of helpers are already available.
>>>
>>> (This is not to say that one case does not care about functionality or
>>> security; it's mostly a case of different priorities and environments.)
>>
>> I'm thinking about the latter as more like a "compatibility" case, but
>> the "feature-rich" is also a good name.
>>
>>> I had been hoping that it would be possible to find kind of a common
>>> ground between the two cases, but reading the thread, I'm not quite as
>>> hopeful anymore... if we really don't manage to find an approach to mak=
e
>>> the different requirements co-exist, a separate virtio-v4l2 device migh=
t
>>> be the way to go -- but I've not totally given up hope yet.
>>
>>   From our side I can say, that moving from the current state even to a
>> well-defined subset of V4L2 would require a lot of work, bring literally
>> zero advantages for our use-case, while bringing some disadvantages. I
>> think we had a good progress so far, we don't want to give up the
>> achievements and now this is a great opportunity to do even better
>> because our priorities will not collide anymore.
>
> In other words, virtio-v4l2 does not bring you any direct benefit and
> switching would have a cost, acknowledged. But I don't think it's
> reasonable to split the standard just for one project.

I've acknowledged this in many emails already. But I wouldn't argue that
long if this is only about costs. I'm a developer after all. (I'm not
paying my salary myself.) I believe, that virtio-video is simply better
for a whole class of use-cases, including ours.

>> On the other side I don't think Alexandre and his team are really
>> interested in doing the extra work of clearly defining the subset of
>> V4L2, writing larger specifications, going through all the hassle with
>> making the guest pages sharing work (again) and supporting this case in
>> their driver for us for something that is planned to be a very simple
>> device and driver. Please correct me if I'm wrong here.
>
> You are wrong and stop making things up about what our intent is.
> Guest pages are a must-have for us, as I've already said. I also
> proposed in a former email to do just what you said I wouldn't
> (defining a valid subset of V4L2 for each device), and you ignored it.

Hmm, I haven't ignored it, I just didn't have time to answer, sorry. I
answered it a few minutes ago.
Are guest pages a must have because some of the user-space apps want to
use them? Or is the conversion of memory types in the driver also a must
have to you? As far as I can understand your use-case, the former is a
must have, but the latter is not. At the same time the latter is a must
have for us. We already have this implemented this in the virtio-video
spec and virtio-video driver. Also I believe the virtio-video spec is
much clearer and better defined, compared to V4L2 UAPI, so we'd like to
focus on improving the current state, not downgrading to V4L2 UAPI.

> I won't engage any more in this discussion as I don't think your
> position can be moved, and I have better things to do with my time
> than constantly repeat what I said earlier. Do your thing, I'll do
> mine, and at the end the virtio folks will decide what they want.

So be it.

--
Alexander Gordeev
Senior Software Engineer

OpenSynergy GmbH
Rotherstr. 20, 10245 Berlin

Phone: +49 30 60 98 54 0 - 88
Fax: +49 (30) 60 98 54 0 - 99
EMail: alexander.gordeev@opensynergy.com

www.opensynergy.com

Handelsregister/Commercial Registry: Amtsgericht Charlottenburg, HRB 108616=
B
Gesch=C3=A4ftsf=C3=BChrer/Managing Director: R=C3=A9gis Adjamah

Please mind our privacy notice<https://www.opensynergy.com/datenschutzerkla=
erung/privacy-notice-for-business-partners-pursuant-to-article-13-of-the-ge=
neral-data-protection-regulation-gdpr/> pursuant to Art. 13 GDPR. // Unsere=
 Hinweise zum Datenschutz gem. Art. 13 DSGVO finden Sie hier.<https://www.o=
pensynergy.com/de/datenschutzerklaerung/datenschutzhinweise-fuer-geschaefts=
partner-gem-art-13-dsgvo/>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

