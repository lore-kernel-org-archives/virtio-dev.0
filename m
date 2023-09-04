Return-Path: <virtio-dev-return-13613-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFBCCC71153
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Sep 2023 12:21:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 078B066DCC
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Sep 2023 12:21:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0030E9865B2
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Sep 2023 12:21:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E59B9986412; Mon,  4 Sep 2023 12:21:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CDEF79863BC;
	Mon,  4 Sep 2023 12:21:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jqfJhgCJvZjThTD1aDnbPx2EUtowPHhGKHMloKuYfT5kzk2sF/cOekFxFU4UqYWTcHO1VN03vehdCVkCZZ2DyiFzic/hvo2UKmu571MGey1SQDY14TDjSoPdXYY4jxN8KJ0HYc4+/EnpGBpz1eIQsECf+TcgFU7hS42WqLqt1QfHlNyPCH4vwrCJF/WQu/gKhQ/vX0uCy6rmAOv5cmfCcfP/opvpXd2Nq/gEF8ZbFtfn6hRgkm9n++JYuBsihBWG9jeDQQYDDDb6zEB8psidGVSpvFB0yfmAaCybhGYJ/JhfkkqkgA31f94lQoB0JP9tdy4L11hbOYKTRIPRNvSBjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pe9Tk2MxOCchv6i7ZGHMq/OBdZb7+0wzdrYVHjOgJ38=;
 b=RsVYUeMuUSXuQe8bR0XvB/7ksMVspqS00bDgXo79WhsBl0DGVpks02/2HQ8lJwOy/6r7WPf0NST7vEZ1mbcXHrJARJWVnsQpwLiga48y+hFVICHo3h8W1xMPaVJZFl87N8N7fwISRYMh2ugUxhhI2EsNwU4LGesJniL9SEwrXA/la6u6KXNcBB/yv391yzkB3ee9NNnw9Y7GMP2Gql4gapgysIW1iVYnqv9P3WE4AUTrC627vR1MwINpS8CPeqcSrPhNVg1SuypC/TPz3B56edlIrfhyEp5igcotZMipquzkXw3XJ+PafiTc/Nj4xlo59efQJuJ6BrFUZhax/3dUew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Heng Qi <hengqi@linux.alibaba.com>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, David Edmondson <david.edmondson@oracle.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Xuan
 Zhuo <xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-dev] RE: RE: RE: RE: [PATCH v16] virtio-net: support
 device stats
Thread-Index:
 AQHZ2wYzX/zNUNI4wUOZcBP1oGnfKbAF9gaAgARYMQCAAASwYIAAA0cAgAABWeCAAAy/gIAAGFyQgAAOWYCAABFEUA==
Date: Mon, 4 Sep 2023 12:21:48 +0000
Message-ID:
 <PH0PR12MB54813CB40389462B1667184ADCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230830055239.10680-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54819EB466305284A8C9F649DCE4A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693812824.959417-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481859AEB22FDDFCDA9D57FDCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693814534.4663684-3-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB548167EDE78C3B7C00014D2CDCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693817561.0941262-4-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54812E119F4F042F78B95150DCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <526c4582-3521-45ad-afae-8d7e281b5f38@linux.alibaba.com>
In-Reply-To: <526c4582-3521-45ad-afae-8d7e281b5f38@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB6328:EE_
x-ms-office365-filtering-correlation-id: 41500ea1-5797-4d23-7f35-08dbad41833f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xmkF9eVSvW3E5l3ylFN9D9mOYNoe8+tWW+CuNR7fCNctuQ4eomSvh8KgQClDRGPnknJrLI7W9HHBiVkiN9Jb7KMmVBb5HuBSPIhSUxY2QYUj/vY96alx3nVPrKtp1XWeYwhiy/NcaEw9bwchMudFEzGAImcwaMiZNyoXYmFzodXRJk6Dn7jUvp0yKc1irHazXGK2BGbgqv6q0EKWEpKWSAmDGdXFidkNOGHbtB0wyTjfLZxvVG25NIQP2k8UgDz1f9jaF7K1vRyM/7r+7EqVebqMMRHoy0kug5KtjIUt50rIvWSJ/Y8/3BEfnz6/PJEr+GOo9eXdcoR7edkbMFXgYoj7Zv/hI5KGnqLQ6LfLKdScAZH71J68P3ll5Bifu15AsB5WG6mguCkv9S5+vkLuGk6drN1jExMPwatz1CqEGznwnCm599yni7o1v75Odr7NChR0W8gB12hdrnTBQgcb0IFeXvSH9V8/iWWhUYl5HwyqVugLo/xCCroS3CZyEeik9MhZ7Wuq4ieaijI0bX/+2Zt2puxQLBpHoUk+FlM9aP7ThI2VHnG4rfeII84wb0ORRA0G1IHD0s+3NjJRKr4u2vNHO1C/q5qdOKunKhhW80WAmbrJ94Jo8/bUaTG8qc58
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(396003)(376002)(366004)(186009)(1800799009)(451199024)(41300700001)(66899024)(122000001)(38100700002)(38070700005)(71200400001)(33656002)(86362001)(478600001)(83380400001)(26005)(9686003)(55236004)(7696005)(6506007)(55016003)(66946007)(76116006)(54906003)(66476007)(64756008)(66446008)(2906002)(316002)(6916009)(66556008)(8676002)(5660300002)(8936002)(4326008)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d0VJN0dON3dma0Jpa1FLWEdjdlpTOXlUeEJ6QmZZTWVaMmJWaWdGZE82ZUJH?=
 =?utf-8?B?NXR6UmtvSWxhTytCc1NjNXNVUzJPdnVzeXRlV2xFUEpFekZmcjdZT3RxRzJF?=
 =?utf-8?B?U0tBRjZOc2RCRmJKT1JpbDFvVTlPSDQzRGgzb2w5S1Q2RDRKeDRjVzgyc3VD?=
 =?utf-8?B?WG1YTnVEODFVdUVsR0hyQ3dJakhZYUM1V1NIVHQ2Qk5ZWGgxSnM5bU5ZSFB5?=
 =?utf-8?B?dDk4dlhzc2tkTTFQYlA5MDYzZnBCbVgrUGJETml0RVo0MHRIaWdORkNtRTF1?=
 =?utf-8?B?bWtmL0hoTm9yUXV6ZFl4WXQvNFI1R01meXViaUtLajI1OUcrWG5qQXhoU2o2?=
 =?utf-8?B?UDVBTnhmMjBPZWI2akllNXBnVVVFUDlQUGo2UlRtd3NmT0xCY1VzdlRTZDQ3?=
 =?utf-8?B?VUNJclZ6WjY5UDNuOGVwNUZmVHBuRWsrN3BuaTE3eHcyb0Z5eFIrRDFrc1JF?=
 =?utf-8?B?alZSVFNYTW9ZY3VZVHc0aXp2R3l0MWNUUmxoUFIxS2JjaEE5Vk5sZzd6VVlX?=
 =?utf-8?B?NXRNRm5OU2ltc0c2dVgrelBSa3BVQjkxYUJzSUUxSnV0NWJZY1dCMUVIMlVy?=
 =?utf-8?B?R0kyY0FZUnU4ZUpFNmN4NnFRRHMrRnVtSHJQL3pnZ2NXQW9tK2JteFg4YmVE?=
 =?utf-8?B?NzZ1Ums0aC9ZT2FTVml0OTRyMWNEV1BoR1JlemxKK0N5Y1dRZm96NW9UNks1?=
 =?utf-8?B?eloycCt6L21jdnMzeHQxWTczcUpSMFJmb3Q1dGQyRDZQaGFmK3BtQ2RsNkZ5?=
 =?utf-8?B?dFNmSVo4TmVMSUdpVjkxVnp3SUswN1ZQb2JNV2dnR3NXeEtIWmUvWmxWMU03?=
 =?utf-8?B?anhNVWNXV25BSXhOLzdlVm5wVk9mQUhENmN1N0VtRnF6M3pncll5SVhpM29s?=
 =?utf-8?B?TEl6cnBPNlRsbGw3M1lqZ3V6YTViM2dCZWRjTnd4elY0TlNMOFVDNHJyMTZS?=
 =?utf-8?B?a2dpK2VtQ0J0bTJERzJLUEcra1I1bVNqdDFIQlpXU0xVVjdLT0pDMWM5VVNh?=
 =?utf-8?B?ZHJHNWhzeURBb0NJV0hZUGs1VWs3ZFdJNmgycVd6ajAyQ1NVM0lIWXpuZmh0?=
 =?utf-8?B?Ti8ycVcxU0ZzR3dRZUZ6ZG50NmRVcEhDTStnMEtjcXJlWGo0ZldTaExMZ0FH?=
 =?utf-8?B?S1ArWjJXL1k5ZHVpeVcxUDNrNk04WU16dC9CVWFCWVprc2wyMjVleTFkSStU?=
 =?utf-8?B?TFlNQXp6K0NhSExrbXBnM05ROElZSVpuQVBBSHoyN25qRTBpM2U4UVczUXhG?=
 =?utf-8?B?QjlpakY2NUNURXpKajNCTlVlTFlaVFY2TEl6OUsybkJsc2JOaks2dTNZVVJm?=
 =?utf-8?B?VmRKSmFrcEVmUGk3MHJrUmRvTk9mREFvbXZmUmZGZXVBdmRKNHZ4N3NneWhk?=
 =?utf-8?B?UnY5b1lJdklQb09mVzRiaU9UdkxhdWc1RnBKSlRjVjZtaVZnQ1JuanhrOHg4?=
 =?utf-8?B?aGx6a01UdGNvd05ORGdKL0w1K2QzQ0ZrWHYyYnZsVktxZzRYdEFWQW5vM0Z0?=
 =?utf-8?B?SnJxWWNHd3FYZy82bTBsNXJPTjFvb2FCcXFnQmk4NWszZnNEdG90UVhwMURJ?=
 =?utf-8?B?OXFrVFcydm83VytqU3dMTXNualJYSERFdVhjcXZxOVE3V3cyQ0NBd0J4K012?=
 =?utf-8?B?cldudmUxMUxidlMyV0dVVkxoeDVJbEx3d2p0b1lVZFQyYW5lMDNSakxyK2t2?=
 =?utf-8?B?U0hJWmY5VEdOWTRUUzdzYVhCcnVmNUtpQnZnWnlqWlVkcGZielRDTUxRQURK?=
 =?utf-8?B?S05aWWR6dno5Q1NzUEI0MEZvdDVjaG1KTUZUNWlFbXlQN3g3UmxVeUw1UWlM?=
 =?utf-8?B?U2ZnaGdURU83WUxJYUo3ZmR3alRyU0ZjYkFNTmViV0xDY0V1TjlYS3lMalp5?=
 =?utf-8?B?S3dPNmE5emdmbUJWQkwwWklVVC9mNS80cEMwNXhNb3hpMldCRUhpeHZDYmxE?=
 =?utf-8?B?WE5KTDloTHl3a1I1Rm84c29qdjRlVkJTMjRReHBIdWk2SU1WeStZZ3BSNnoy?=
 =?utf-8?B?TmRrVnl0YzFmSVBvQ3hFSEcwbHNTaEFQOEpSeVpSQzFVTjBoaEd3ajhwenJT?=
 =?utf-8?B?M215WFJSUWNhWUZlajM1TGgrdFBuRGQwT0RJK1Y3OXJwVHl4WXNCYnJEKzlq?=
 =?utf-8?Q?Ngvk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41500ea1-5797-4d23-7f35-08dbad41833f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2023 12:21:48.9066
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VeQEhg3g0hlpJCk9vh8BN8Sxc6HSyKcLzgOSyl0xRatbAeNipK6gQOQyS1ACQzwsRFjhqJXLzzdgpD1CUfVmZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6328
Subject: RE: [virtio-dev] RE: RE: RE: RE: [PATCH v16] virtio-net: support
 device stats

PiBGcm9tOiBIZW5nIFFpIDxoZW5ncWlAbGludXguYWxpYmFiYS5jb20+DQo+IFNlbnQ6IE1vbmRh
eSwgU2VwdGVtYmVyIDQsIDIwMjMgNDo0MSBQTQ0KPiANCj4g5ZyoIDIwMjMvOS80IOS4i+WNiDY6
MjYsIFBhcmF2IFBhbmRpdCDlhpnpgZM6DQo+ID4+IEZyb206IFh1YW4gWmh1byA8eHVhbnpodW9A
bGludXguYWxpYmFiYS5jb20+DQo+ID4+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDQsIDIwMjMg
MjoyMyBQTQ0KPiA+DQo+ID4+PiAiVGhlIGRldmljZSBNVVNUIE5PVCBwYXNzIHJlY2VpdmVkIHBh
Y2tldHMgdGhhdCBleGNlZWQgbXR1IChwbHVzIGxvdw0KPiA+Pj4gbGV2ZWwgZXRoZXJuZXQgaGVh
ZGVyIGxlbmd0aCkgc2l6ZSB3aXRoIGdzb190eXBlIE5PTkUgb3IgRUNOIGFmdGVyDQo+ID4+IFZJ
UlRJT19ORVRfRl9NVFUgaGFzIGJlZW4gc3VjY2Vzc2Z1bGx5IG5lZ290aWF0ZWQuIg0KPiA+Pg0K
PiA+PiBOTy4NCj4gPj4NCj4gPj4gSWYgdGhlIG10dSBpcyAxNTAwLCB3ZSBjYW4gcGFzcyA2NGsg
cGFja2V0cyB0byB0aGUgZHJpdmVyIHdpdGgNCj4gPj4gZ3NvX3R5cGUgKG5vdCBOT05FKS4NCj4g
PiBBbnkgc3VwcG9ydGluZyBjaXRhdGlvbiB0byBzcGVjIGZvciBhYm92ZSBjb21tZW50Pw0KPiAN
Cj4gSSB0aGluayBpdCBjYW4gYmUgcmVmZXJyZWQgaGVyZToNCj4gIlRoZSBjb252ZXJzZSBmZWF0
dXJlcyBhcmUgYWxzbyBhdmFpbGFibGU6IGEgZHJpdmVyIGNhbiBzYXZlIHRoZSB2aXJ0dWFsIGRl
dmljZQ0KPiBzb21lIHdvcmsgYnkgbmVnb3RpYXRpbmcgdGhlc2UgZmVhdHVyZXMuIE5vdGU6IEZv
ciBleGFtcGxlLCBhIG5ldHdvcmsgcGFja2V0DQo+IHRyYW5zcG9ydGVkIGJldHdlZW4gdHdvIGd1
ZXN0cyBvbiB0aGUgc2FtZSBzeXN0ZW0gbWlnaHQgbm90IG5lZWQNCj4gY2hlY2tzdW1taW5nIGF0
IGFsbCwgbm9yIHNlZ21lbnRhdGlvbiwgaWYgYm90aCBndWVzdHMgYXJlIGFtZW5hYmxlLiINCj4g
DQpTdXJlLCBpdCBjYW4gYXZvaWQgc2VnbWVudGF0aW9uLCBidXQgbm90IGF0IHRoZSBjb3N0IG9m
IHNraXBwaW5nIG10dSBjaGVjay4NCkZvciBleGFtcGxlLCBzZW5kZXIgc2VuZHMgc2tiIHdpdGgg
Z3NvIHdpdGggZWFjaCBzZWdtZW50IG9mIDlLLCBhbmQgcmVjZWl2ZXIgaGFzIG10dSBvZiAxNTAw
LCBzYW1lIHNrYiB3aXRob3V0IHNlZ21lbnRhdGlvbiBpcyBub3QgZ29vZC4NCkJlY2F1c2UgZ3Nv
X3NpemUgc2hvdWxkIGJlIHNhbWUgYXMgMTUwMCB0byBtYXRjaCB0aGUgbXR1Lg0KT25lIGNhbiBz
YXkgd2l0aCB2aW9sYXRpb24gb2YgbGluZSAiIFRoZSBkZXZpY2UgTVVTVCBOT1QgcGFzcyByZWNl
aXZlZCBwYWNrZXRzLi4uIiB0aGluZ3Mgc3RpbGwgd29yayBmaW5lIGJlY2F1c2UgZ3Vlc3QgaXMg
YW1lbmFibGUuIDopDQoNClNvIGNvdW50ZXIgbG9va3Mgb2sgdG8gbWUgd2hlbiBWSVJUSU9fTkVU
X0ZfTVRVIGlzIG5vdCBuZWdvdGlhdGVkIG9yIHdoZW4gbXR1IG1hdGNoZXMuDQoNCj4gPg0KPiA+
IEVhY2ggcGFja2V0IG11c3QgYmUgMTUwMCBmb3IgdGhlIG10dSBub3JtYXRpdmUgYWJvdmUuDQo+
ID4gZ3NvX3NpemUgdG8gPD0gbXR1IChpbmdvcmluZyB0aGUgaGRyIG1hdGggZm9yIHNpbXBsaWNp
dHkgZm9yIG5vdykuDQo+ID4gd2hvbGUgR1NPIGNvbXBsZXRpb24gY2FuIGJlIGZvciA2NEsgdG8g
YmUgcmVwb3J0ZWQgaW4gdXNlZF9lbGVtLmxlbi4NCj4gPg0KPiA+IC0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+
IFRvIHVuc3Vic2NyaWJlLCBlLW1haWw6IHZpcnRpby1kZXYtdW5zdWJzY3JpYmVAbGlzdHMub2Fz
aXMtb3Blbi5vcmcNCj4gPiBGb3IgYWRkaXRpb25hbCBjb21tYW5kcywgZS1tYWlsOiB2aXJ0aW8t
ZGV2LWhlbHBAbGlzdHMub2FzaXMtb3Blbi5vcmcNCg0K

