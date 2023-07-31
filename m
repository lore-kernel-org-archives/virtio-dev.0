Return-Path: <virtio-dev-return-13418-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0A7C001DF
	for <virtio-dev@archiver.kernel.org>; Mon, 31 Jul 2023 04:32:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DBBC27C6A9
	for <virtio-dev@archiver.kernel.org>; Mon, 31 Jul 2023 04:32:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D1F18986689
	for <virtio-dev@archiver.kernel.org>; Mon, 31 Jul 2023 04:32:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C3E7B98638D; Mon, 31 Jul 2023 04:32:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ABFCF986364;
	Mon, 31 Jul 2023 04:32:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4fsXVR7mFkFRsDm6NRD4VGLhZ19SVisFA8/D/2AxP9hH2FxxZEXstJDeq7T04NCBxk2TE5+FUHmj5fRTLR0xcZj7zarr6hr6R/IK2PuEJ1PkFfRcvtHk2ozqrT9rYYEvMxeh4tusjphZ4OnmNS8pSu99lAm4Q9wrK52oY6onarsUAdzDhaA7KLQvF2MtCJ3qoMxPdVJvO+/s2lFLrRr2necRbAvANZPCACIdDliTKvv0fwXmaPy5LcpjCiVLZ6QvRh1ld9AA4ELK5ayRg5LgnYLsh6LIROVwlFwro+JTKlVzzIa3FDX9m/2/5r+I9Dd56TBsx25hY0ytrjMsmG54w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcyehsIoK2tpcteNbe2QDklp04H8FGv3+AJ0tlTP5Wc=;
 b=IZsy7I/3Z9zNeVG3xV0KiYAilXl5Ep8hQMFLaa3pd9+TAQJJp6SzE+5hGa99y+DNRFoOHNx7rQdyRntvBVkYm2G7oVLYKLpE+ZpJT1IfCmj1M6JRtM5OmC06W7ruGry3xk4eC2nIudhrI+6P/1YH85GN6KVLjtnOJk/3g/sG2SpNsJbP2Ukwy4MLhG7LinJhp10jAZyUE8SPOy0WejgQ+pWj7bSHkX2JZGAFkKAil9Y4SltCUVhor1ntK4IjWIn7mnWb0LA72ze820ga0Fl24JymB6NyEU8ygZpWayKuefxcBb0wbnlotS0LXo6+y/H64R45KvSqOgV+s8Fr533YQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Michael S. Tsirkin"
	<mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
Thread-Topic: [PATCH v13] virtio-net: support device stats
Thread-Index: AQHZv5jvruUY/+MlM0y3MfS8bNE+OK/L5l8AgADzOgCABnXkwA==
Date: Mon, 31 Jul 2023 04:32:22 +0000
Message-ID:
 <PH0PR12MB548149ED4C687913EDA3EED9DC05A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230726081229.55947-1-xuanzhuo@linux.alibaba.com>
 <20230726070801-mutt-send-email-mst@kernel.org>
 <1690422490.8491526-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1690422490.8491526-1-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH3PR12MB7716:EE_
x-ms-office365-filtering-correlation-id: 297a3fe5-dea3-4a03-08ea-08db917f226b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 G63RmQwPvLmI7UL88UIzRmeHVwo2/cGV6TM/QCNwpNgu8s10TcvFgVDTXn5ZjEkwdFzClOscYsEsi/QjxK65YrXXMZt1m99TZ4zILDXENGH+SFBss8x5t9O4OCQwz6osmcR4ZJ39uEzbYfsrDqaXfEdGJLNdlBjilqFj5t/uSO7GNhYcPkqIbnhxmLkZpo5OWqnNOhOWl0iUVovu9VZlW09Wx0n2zPtWmKuhYNwQoAVOZ+z43cg66JoWYgfCFr04mVxprTDlWyJGhAF5tDlQd/D7491Xhh3N2rBKt6AVPAdp0X0Y+2G2ictFw4pvjJ0histsMlSR9Qcm0s9ek0gxbnb9wDuCctuhh7XR8PiavjYHoy6fiRt1QZoH0CX8ufcVwvrP5EVC3VWCeu4bX/QfccFx0/hJSnF1U9HfpCjSJwCmpCuiNGDQcR2WfWYvpoQX1v0GtRJrRkPD78Q7hHZfc9OSs1R/WHZrJzwBtEc0OzVabhMMcwAbkaj4hfY62P0x9yq95G4dmWawmifBCm6Da4jK05O2culFZ2OsE1dvgIeCqdhUqVkDhAFH6sxQVoH8hGoHMba1I9dq24aaU9CZebIU8s9AWP75jUwaorhDsM6gLUZkDpqKhT0aSX5P1VMO
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(366004)(396003)(39860400002)(451199021)(66946007)(66556008)(66476007)(66446008)(64756008)(122000001)(4326008)(76116006)(38070700005)(71200400001)(52536014)(5660300002)(478600001)(7696005)(9686003)(316002)(55016003)(110136005)(54906003)(38100700002)(86362001)(41300700001)(8676002)(8936002)(186003)(6506007)(33656002)(4744005)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AVt/5IpRsnCiobTlViimN+Pj0iL5bZI7d+CftMDahVpj1LDnsrT5JZR+A1ix?=
 =?us-ascii?Q?zOwau3VSpfm7O0Zd19FMQMkuWVRC3IJwbtRS29wpwdk6OrpzWh3vR7KgvH47?=
 =?us-ascii?Q?sRKEOBwfrrtIPyj5i6S3ew/trk0n73shgYXuZZuthklfVAmxckMBsIlzmnna?=
 =?us-ascii?Q?UovujMRcnaSQ/AfRbvzLw/scFzrTyl5yTpLgQzp0/eduKBZdUeTZb6PIKl+P?=
 =?us-ascii?Q?TxSr94dU2vzgVTYoDzGDMf+akEgzQNxs5GXActBTQQ5tzx7j3/eVR1PHCh5M?=
 =?us-ascii?Q?a2nD/uiANl7GYh3IBJc/2C1xG3UtvFjwaSxOGaOls88cUcpQJIrN0TU3DjX4?=
 =?us-ascii?Q?TSEm2ZpWiF3tYLQ568QCru1+ZPP5GLR876S7i3fm7S9Y2L2qLCmlf/TQCgmS?=
 =?us-ascii?Q?EAVeYW6KcPPkdfuKK9W1GH4UqyE2pU2sNTIPUAW1D9UXZlFdwSwE/M5rN41+?=
 =?us-ascii?Q?4tXltFIU0ZlVH5hgh5Wp48lGgPj87eAng3JpsAPytHBAsaLzL5GemGWUwvNi?=
 =?us-ascii?Q?m5L2K5AHpC4Yi8INNNvxkxqJQJDNvOFnhLqXfUheKzJchNDU4WZDbPGmA4he?=
 =?us-ascii?Q?UogcS8KV7z5wFudRyl6tnRd8UP+IKn1XBXUPUHSxpLhdiWsN5cwoxrrs+Vip?=
 =?us-ascii?Q?ROufYnSuN4ZE06So1HMkvq8k7gOrfxYoyGs6/ofOc6lVtsaPHssuwvGa9elr?=
 =?us-ascii?Q?IuXp24g96eE6ic0Q8Ti4PLbQjZbUsJU0tDWUKj3UQmGkyg0zshRsB+Q7f5bO?=
 =?us-ascii?Q?K4xgs+It1mm79m2Pj3dE30gBreTe3KKsghz7SCSn10i7FlGmjGNKPl0KRHUR?=
 =?us-ascii?Q?mZHOXdUqBwDTAXC013PvBq15Im9BapJ9d5hPd9sU+0WV2CFuP+hczaejBcwM?=
 =?us-ascii?Q?aOVdKKskUX+OlU6dqSbObQZX1CuKwPf25csWYqeibaXvN74Sl3/NL5L1TsLB?=
 =?us-ascii?Q?xJ44HHecEC1glHDX8yMSsOZC306Wj65Ns/j3i7F1ZLRXd44/gADwJZorghLJ?=
 =?us-ascii?Q?xiCh/dG+BQmvJJ+9f3bR7QLEKWTXrzfLF+ptTz+RkpM8vjt27UpCwom4uQgW?=
 =?us-ascii?Q?ueFw+q6WKzRBJCZc5OBCfsLCxGhNugbarOjeIaYr2Uf0mNYzD2AcS1ecYWV+?=
 =?us-ascii?Q?Q4NYUPIO4V+RTiidzqrDxhuW04b0Z3lzxntFRffw96hax1nYoJYL8dz8RVJt?=
 =?us-ascii?Q?MJmvtGM42Lt88+lLwnQOEGa3YKrrYlU60SVTpYWmJhzut8Q1vfmRM33uJ21H?=
 =?us-ascii?Q?EfCezaIita5vM6nfMbxkfeImhHFRhMgcDy8x00VLLg0TflER6V9qSqVstrvH?=
 =?us-ascii?Q?8QUqBEWMTvZSCTKCwkRE0zXxuo/sd4S2JBN+hs9HDwPV73vf2yK08xIV57KA?=
 =?us-ascii?Q?jLfLlq7G22H/FFizPYdvzDskU71WN5i3ou5rwGUl36DH+UpiAd45EQIUn/Nr?=
 =?us-ascii?Q?A0HfMFB2spIS8EJGvGVfW8NQsKuS/Va9sFBwBYoXehMkj4eWSXZdJ3OKeqKQ?=
 =?us-ascii?Q?eyQ9Uk0qLlaD2Xr4MX2XUHD1Kv3O45N5bYUxv/lgFRnJCKxLAiaLOrSWk8AA?=
 =?us-ascii?Q?qlN7LGp8fsvU2uQgEiqlXTrukW3xvWPTa/SmlYe+yHIOU8NvoqS6j3yqutwq?=
 =?us-ascii?Q?+5w86VvFWcaZxJKutLDec9m6HT2yHO7kblzqr3iW6579?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 297a3fe5-dea3-4a03-08ea-08db917f226b
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 04:32:22.6857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ilvY/+72eO/p95TGjV7ISaqRG8nvMqEKe0JXGrr0lJNIQqoL7Cg6MPh/RlXmzw3STTpDyYI5fQAkGH+qiLezdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7716
Subject: [virtio-dev] RE: [PATCH v13] virtio-net: support device stats


> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Thursday, July 27, 2023 7:18 AM

> > why don't we have a config space field for supported types?
> > more straight forward than complex rules...
>=20
> I am ok for adding a config space field.

During 1.3 we completed the discussion that any new config field addition m=
ust adhere to DMA interface and not a register.
Multiple capabilities need this.
So lets please work on that.

Counters needs to use the dma interface and it can wait one time to utilize=
 the modern interface.

I have two proposals to for the dma interface and we should discuss that in=
 separate thread to not mix the cvq parts of the stats.
I will start the thread shortly and put pointer to this requirement of coun=
ters + many others that we are discussing including ntuple.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

