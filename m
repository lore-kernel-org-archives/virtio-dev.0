Return-Path: <virtio-dev-return-13863-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0D7CE79AC
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 07:56:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8792A866AC
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 07:56:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 78754986680
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 07:56:26 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6C01598666B; Wed, 20 Sep 2023 07:56:26 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5C791986669;
	Wed, 20 Sep 2023 07:56:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0J1SAgNcu1mYsVQmKv4Kt6sXpKqytHk89oW+r954hVAWJwq3OgxZnloSl5/t0q1izOkERhZSNL+YnmGn6mBVnuEkmYXd1ZGEO4lxoLYo/2WaNYnyMxEocKNV5EgwFYqEWks6U8da7+YfifnlLNzG+/r4+15FoTVKIe5fcXiqcnu8wWXMkKvpgjQyZxr25CndnH43es0dd3ujO4aMrQHz5xFuijPcibFja4CbAK5KhOFEvinilztCNy8AMaE8MWow1cwug5yFhBM9Y0HLnECsBItLqzHCByLsU9xmlafMLN2rBW1qau2j3eA6XbtPCKTRkA6WIbm5EWING2rgapAtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PbgpuwhUKwYyFLYOqa1Go9tL+sW+kUTUqMrgKgh5Bk=;
 b=nRynO2YOJeaXM4/SkGruqufuzvz2M72SexeMEoUGhc5Cbku69eSj0dFkrtksaa1SooBsJ64FOUkOnrXkYVposDTzQmCczrLtB+2jGDi1JzitV4fU3tYdqSRYA5toN7GJLFlkZsNzI2QFuMIsDZlvrIWlLgoH/HZCJPjwNN9wgHiZ1SF4rb4deZGbNkQtyhIf5SXATqfIxvEfaZ3IHt4g+uYRO+ez2zc9MzzrbShGVqbsq6Itr/hMmtcVMKYwprMPL2uo2pm/svIPHeC/idElyLlgENixAJ4m5K2t90vCk3s45hQ80aguusNszHwY998vyUAxSNzhWQWcP/GJjhcc6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>, "Zhu, Lingshan"
	<lingshan.zhu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan
 Zhuo <xuanzhuo@linux.alibaba.com>, David Airlie <airlied@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
	=?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Robert
 Beckett <bob.beckett@collabora.com>, Mikhail Golubev-Ciuchea
	<Mikhail.Golubev-Ciuchea@opensynergy.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stefano
 Stabellini <sstabellini@kernel.org>, =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?=
	<roger.pau@citrix.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Koenig, Christian" <Christian.Koenig@amd.com>, "Hildebrand, Stewart"
	<Stewart.Hildebrand@amd.com>, Xenia Ragiadakou <burzalodowa@gmail.com>,
	"Huang, Honglei1" <Honglei1.Huang@amd.com>, "Zhang, Julia"
	<Julia.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Thread-Topic: [virtio-dev] Re: [virtio-comment] Re: [VIRTIO PCI PATCH v5 1/1]
 transport-pci: Add freeze_mode to virtio_pci_common_cfg
Thread-Index:
 AQHZ6u55wdLgYEJT5UeWhzYWiXOCmrAiFHuAgAEk1ACAAAlvAIAABTWAgAAEKYCAAATtgIAAAbEAgAAAlkCAAAQ8gIAAAa+AgAAAM2A=
Date: Wed, 20 Sep 2023 07:56:18 +0000
Message-ID:
 <PH0PR12MB5481B25861A98F040705B60ADCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <20230919082802-mutt-send-email-mst@kernel.org>
 <cd8d306b-6acc-34be-516c-b89c23ac108d@intel.com>
 <BL1PR12MB5849E32A76165F1307492185E7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481D2CBCFBF7BCBF427EE1EDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <701bb67c-c52d-4eb3-a6ed-f73bd5d0ff33@intel.com>
 <BL1PR12MB5849A542AA93F6ED9FEEAAF0E7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <a636b841-1bfc-925a-406e-6c4469e7e4c6@intel.com>
 <PH0PR12MB54817E116B756914B3FC1860DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <40765650-ba6e-357a-cf73-ff6a0288c0e8@intel.com>
 <BL1PR12MB5849B98B7D8498F02598691AE7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
In-Reply-To:
 <BL1PR12MB5849B98B7D8498F02598691AE7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB7640:EE_
x-ms-office365-filtering-correlation-id: 7436e424-845a-448c-cae7-08dbb9af127a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 quJrl74ZulSbWDok9eOXgNRJaiqpFCiaOmPuviHs7mdP2pcGgVerIwIxdMxF4VLh1J+qnGOpcYggCTpBJ/3Y6gyrAE8IMJ9zzIxGx8dC5zUaUH6i/dAb/kt0xWcPRAtgkdkk00rAwraBV/yrSq3eM5wB5fjjGtwrEHwalQsbNKY4IgZhQnWzpujKKDSaJoSXNm1J08g1qG+EeqZzmNTaw9UNXLecGqrS2q/ft55Lb9enJk1GFSimpBIOoV9zXG0OFGd2MjZI/SW5hnjpT0NYjm/MCZsAYaGg1JJ3xRG3Ofv1MIkrCBlmd2pQ5YpStTad5F3PT4vllFpxJdeJVCCW9/+u+orQwvOVEIpAHBWQSKldZDEVt712j471ZCdPgGJzkicH5Yg/5SOCHAoELCw8w4ymxsIXM9jt+tStl+nhngZXkJcS0fQWmj8rV1EZoHJMkQBAexDGrS8V0FC9L41SGsbmrq6gSHvHze1kwQOHNZUgCF5CWW+9Yh5VzMAMGL7VC55n2ZntMoqsjXZajHJXyfG7DlY7q5BHElTE+pL4UeuB4Rkh54ymQs2zEDPUzGuCjZwgw2KDtn88ZUejxDxub6NEnitYUXOetFqVkt+TnRKdSFy7/KVLC0ibc2OB4XR6wOv15zpgpa9DTF4Ib9amnHcqARm5EM9ZPDeUd6WUNZU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199024)(186009)(1800799009)(86362001)(122000001)(55016003)(38070700005)(38100700002)(33656002)(110136005)(66476007)(2906002)(966005)(6506007)(478600001)(4744005)(76116006)(316002)(66556008)(7416002)(64756008)(66446008)(66946007)(9686003)(71200400001)(54906003)(5660300002)(8676002)(4326008)(8936002)(52536014)(41300700001)(7696005)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L1BVajNhNXd0dFdBZTduRjlQWEt2dUU2QVVEL2ZDWUZqRk1QbG5zQXg1OEl4?=
 =?utf-8?B?WVlWM0lrM2ZreEp3Q0JpR1pOOFRCUkxiNXgvVHdLcXBzQ1FpbzhqaXBkTFVj?=
 =?utf-8?B?UkpqNldFWDlpNHhjcmVBcFowU0JodGNFVmdORDd3clBtbWZYSWNPNHNKMGU2?=
 =?utf-8?B?NGcxK0kyVEhiOXRvK1o5S3UvRUh5Q3NQY2hnbXV1Y09HSTlDaXh0QW1hN2hm?=
 =?utf-8?B?ME1JTjJjVFJNS21kUUJzd2NzM1ZHVEFHMHpjbkhQVE5hOEE0eFVxTFp4anVS?=
 =?utf-8?B?SW1lSFFLSDR4djUwc3hiRnkySWFvM1hVN05GMFFCajFBU0ZJRm1hc2VnaExa?=
 =?utf-8?B?dXY4Uk9hLzBIOWcybm15cVJDUjVqN2lFQ2pPVDRjd3hVckUyOGFuMlorZ2g2?=
 =?utf-8?B?M2dETTYwTnlveHdUc1RFMnZNNkx4dVlUd2hvWEFwUnJleENQaHJTRTRQRU5p?=
 =?utf-8?B?VHlUUVpGL0QwNzNlbmlXWkg3MFlJbmtBRnVzRkphbDNJMzRDa3g2NEhnK2gr?=
 =?utf-8?B?Mks5aHdKZ3oxU0dvRmhMZm5YWkdDRnV2Y21wcjc4U292RzBBRFNBbUVUOXdC?=
 =?utf-8?B?RDRjeW1GQ3IzVW9EOFZnLzdHSXN0UE13V0pxOHhNQXlOenhOd28xSmVuR2F0?=
 =?utf-8?B?em05YVJ2NnNPWTJ5ZlFyMmo1d1UrZXNOUkRRZWhKVVRjd3lSNno0cGwrMkxQ?=
 =?utf-8?B?QUtocTYwR1RYTmpTbHltUDR1WlFzcURMUnpjaVZkWnVsd2RpSVRmS29NM3Fv?=
 =?utf-8?B?NFhtV1RpWlpzOEcvekR5SDhTay9kZnV0aUtzZGQzZ2kvQjh3WktOdm13RzQz?=
 =?utf-8?B?L2Z4QmRCWEh1aVBSeFF0V3Awc2MzSDR2V1d6Z055cys0THJFdFdYYkJIdVNz?=
 =?utf-8?B?MnQ1VE5BK2U5c0JwM1g1OXpZVTkwYVhnRUFCK1hJRnRVQTdvaU9wOGlOQ3A5?=
 =?utf-8?B?Q1BsMGlkeFdxdUVwbmhqRmJ4dzRZNnF4Uml5ZlMzMlFKazJvVGQ5czlSTkUv?=
 =?utf-8?B?Um95dlpKYkJ2cHozakNOSG5vbzE5V3RtODh3M25yMy9vdHluWlhUeWQzMkQ1?=
 =?utf-8?B?ak51dFhsd093VmoxeDczOUxEbC9pMXN0YzlhaFFwaitiMG1iSWxJNGRYamZj?=
 =?utf-8?B?REJOWWZZUVFwSGlsdVVCUE5CdkxHdmxtb0QwQ3c4cEhubHdCTHpLU0ZFMzFo?=
 =?utf-8?B?Z2w5bjJQUlEya1dGekVWRndMOXR3Tm1Gb210MFlpR1crcld6dVN4SEV0K1du?=
 =?utf-8?B?c3lVVzluWk4xLzRqSTlZeC8rNkJBSjNJMHhUU01mdzROUnkzNENXbmV3MkRj?=
 =?utf-8?B?NmVSdEZoNkY2RDJHTWlYMU1rTEJJOU4yVXZPdzN0Q0s2QmEvbi94VVE1Qk5z?=
 =?utf-8?B?VGFQczlHL3Q3b3F6UitDRXFxbnlYbSs3QUU4L2ovTWlTY1FzN0dTcDlYbms3?=
 =?utf-8?B?MHNOdzhma1FyektLK1A1ZVh5TVRFNkJUdjFmdkxqdkJxZU90ZEhiQU5JbzRr?=
 =?utf-8?B?elp5S2o4THpRaklYMHhacE55NmxqZmIxc2dKam9IUTJad2VsS3k5WnYxTlMy?=
 =?utf-8?B?bWpiSkF3SXQ1aDlQTTZsNjVEWTNjTFBtTkdOdEZlT1NaZmFNNkw4WXVjZFpD?=
 =?utf-8?B?RUVsYjRuNWlkYWZXd2krTGd6R0VIU0o3TC9LcEhkSmRsN2pWU3U1eE4yRDhm?=
 =?utf-8?B?OEgweGFtNWFnWkVxNEkrK0EvbTQ0TkZheDY2bnhRRTJ0b3ZWMWxkNWVVM3N1?=
 =?utf-8?B?M2ZaOWszUXdnMXlNVHNoVW11ZnJkOGNSOWpjMWZwRmNRd0FmNFVHU2pTTy9V?=
 =?utf-8?B?TU9EelhTRFhZdDJxN2NKbmdzV2U2TXhmYkxKYmJObUxCTGlnT0puOFJsNDFa?=
 =?utf-8?B?Q0wzRTRJYXllUEJ2VW1DVFZVNEtZWjJnWXNBd2pVV3JMSDl2NktJSkR5SXpr?=
 =?utf-8?B?M2hCdXJQRlVpUlgrMGNCU3h5ZHlDWDN1cEdrNHJRejZVdWpHc2x6SmdtNnE4?=
 =?utf-8?B?RU5XWFU2dDM5S1hBT3c1RStGVFpiR3kxS00zaHpvYnZmeGxWbUxJV3NVbnZD?=
 =?utf-8?B?YlRnZmRkdWZia21OdnpQRm02Y0RCUE1mRXNkR0lsNXhqeTAxb3R1M1E4dndY?=
 =?utf-8?Q?7mgk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7436e424-845a-448c-cae7-08dbb9af127a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 07:56:18.3244
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TsMfIM9ubYuqK07Qm+QoG7rM2H8LTPbV+Iy0zO7W95uaVaeQlwAZ8QdQmfPnWys0hcQq6BtJQPj5JzPDwpFfYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7640
Subject: RE: [virtio-dev] Re: [virtio-comment] Re: [VIRTIO PCI PATCH v5 1/1]
 transport-pci: Add freeze_mode to virtio_pci_common_cfg

SGkgSmlxdWlhbiwNCg0KPiBGcm9tOiBDaGVuLCBKaXFpYW4gPEppcWlhbi5DaGVuQGFtZC5jb20+
DQo+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDIwLCAyMDIzIDE6MjQgUE0NCj4gDQo+IEhp
IExpbmdzaGFuLA0KPiBQbGVhc2UgcmVwbHkgdG8geW91ciBvd24gZW1haWwgdGhyZWFkLCBiZWxv
dyBhcmUgbm90IHJlbGF0ZWQgdG8gbXkgcGF0Y2hlcy4NCj4gVGhhbmtzIGEgbG90Lg0KDQpUaGV5
IGFyZSByZWxhdGVkIHRvIHlvdXIgcGF0Y2guDQogQm90aCB0aGUgcGF0Y2hlcyBoYXZlIG92ZXJs
YXBwaW5nIGZ1bmN0aW9uYWxpdGllcy4NCg0KWW91IHByb2JhYmx5IG1pc3NlZCBteSBwcmV2aW91
cyByZXNwb25zZSBleHBsYWluaW5nIHRoZSBzYW1lIGF0IFsxXS4NCg0KWzFdIGh0dHBzOi8vbGlz
dHMub2FzaXMtb3Blbi5vcmcvYXJjaGl2ZXMvdmlydGlvLWNvbW1lbnQvMjAyMzA5L21zZzAwMjU1
Lmh0bWwNCg0K

