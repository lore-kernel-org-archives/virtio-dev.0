Return-Path: <virtio-dev-return-12654-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA5D3C7EE22
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 14:31:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 19A4F15B668
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 14:31:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 09DD99866B1
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 14:31:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id F1A2D9865DB; Thu, 11 May 2023 14:31:52 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DAEAD9865E0;
	Thu, 11 May 2023 14:31:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bHJqkIk2HQAPDeKk8E7VLsj2CTakZ7nPgiN1WvgylQ8w0vorcOYsou9LZSXgCK7+la3vkb7e3BBYRMoo3A9Lv90nuk8DXzrCmBaIfWzdpyRGFLvPWaKOLpX4i/cnPaqu2lzEkAEdo03/qj7idagVxCo58930kJFEECwY5Hp8wizhxkKGZrcj/5ZiGT3dvIpvwJ5uWxljzxYhsRqVHDGLPTmLkwFCihqgqFNpPUCF0PHq+2r4Xj6tu9FM9goBww4vp35C32RotOUdRbaRvJJUx4ci6FwEMh8W/OyaIItI6P73Yj0e3npP696q0hUxX5P0+ylw3L/WPqWwXoMRq0oUFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kNXi+nKvCQxi9vYvcDIErdJ5fpbOnYdsQNXJfE/Uuvc=;
 b=kWyX3UY/6EhcGV9TI5qa4VDmXKggo26knXVl8EG2MxBuXf2bQKpy66A4vpTLHDZeiFJzbpwbEEyppxVatzRw7m6IsHenYpqq04gh/Kw3FDi1Xzkr1X4eQZqpwh0lB40cNe1jc+5T05doXl7+fhW1aW07w1XPednsrfYNMNUaFuQxglLrJd10bHE0ds2gujglpQeLaegr2GAQNk3FrMsBv36KrD19kJQ2AqQx8bq7vqJap2eCvOoUwz9KLvgHulDq1aouckju/ezB0mzjH1985yZEn4kqvvf7wnXrsOMxwk6wBLTX9+KJCyL9Y6AmrqXU+QmdJhp9VijpketCo+sdHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>, Yishai Hadas <yishaih@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ
Thread-Index:
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9Mhl4AgAJOSwCAANQugIAA9w4AgACx3QCAAADx0IABk3UAgADMjwCAAP8YgIAAZ+fQ
Date: Thu, 11 May 2023 14:31:38 +0000
Message-ID:
 <PH0PR12MB54819321E95065EBFF7D714CDC749@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230506000135.628899-1-parav@nvidia.com>
 <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <b33fe999-8491-30b4-5021-589a2fe87398@nvidia.com>
 <CACGkMEsSJVG8mzuo3BH1xQzz5TyNbO+o3GcYwoXchcYVOczTTg@mail.gmail.com>
 <PH0PR12MB5481AC52CCAE9636E17C7565DC769@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu1oU0wzygicS0bApoWuRaWkWsPivKRiq-ghezB=hg+Fw@mail.gmail.com>
 <d79a83db-46eb-7f7e-da8e-f39b58b1bc0f@nvidia.com>
 <CACGkMEsR1bJGWjn7TTrvMZV3=fCqggWXjXRXK179YiTUxVTc6g@mail.gmail.com>
In-Reply-To:
 <CACGkMEsR1bJGWjn7TTrvMZV3=fCqggWXjXRXK179YiTUxVTc6g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|LV2PR12MB5941:EE_
x-ms-office365-filtering-correlation-id: 4b07b8db-cb12-478b-455b-08db522c6e2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 S7gW9tjue+0mjWsXfKvvRNwbLOPgWzHoV45tran01wYayp6MzsMpg/W1+c89GKz57FxbSU74u+kM0xWsRIdbkn2osvJ4MG8b4Djw5/ZM2XVb3wVKF+QldDiix+W0yyFpYJaWT4Fe8ZQnye/7rDmVjL3Pi3KU3nEsYV4XiSi8fDCxMQKri43L1HaUdhAI80hCueYl2fQrWH6ISy1KEBDtpfQzmIIPABtz3smG/C0+zB+tBEGw9sLHtZAcCob9+m5cLHLm5aLYQcIkQZ75V5TDqF6NTxw7mdImcBzJ0UPhsDiRircGmWUZAeGuGChOuWCEpHbYlwIJRjudAdFvtd/+IDYIcX65EpX4ikDqYl8N7gJOTkNnBCd1ah+DX52qlubJTBBOIFSTt/UTw227g8iUwzteewNYMsSHpKzset5zBODkqgvU0ZTxp8t6DeSGCeYf0siw0JpGGFbF0G4BENa+LDFgYEEG593oYHpvLaHjihZanwSGsVIEIBzXnthnNmujY6KG16kvMimMQlajWXnfl2YbmEShnTBDXN0CalPQ2zxb5r6myLXsRMzaAQPje2m2/9tFGLHZBBOFsxlSzQrABPQQOH4XI6WaG7DQsrYEHfvyM0DYJ3TtO2KTACuh9JbK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(396003)(376002)(136003)(346002)(451199021)(122000001)(107886003)(38100700002)(9686003)(71200400001)(186003)(38070700005)(83380400001)(33656002)(26005)(6916009)(5660300002)(2906002)(6506007)(55016003)(41300700001)(8936002)(86362001)(76116006)(54906003)(7696005)(52536014)(478600001)(66946007)(66476007)(8676002)(4326008)(66446008)(316002)(64756008)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aEZ6TUJURUkrTmhGN3RSRDM2UHgxVm1XWTl6ajN3eXFjNXdkUWJ2R3BjdzZM?=
 =?utf-8?B?YitrVXI4T3JGTDVtOWtQa3RoajFUdGZMVzNuTXBlQlBsS040dElHbkQvY3JE?=
 =?utf-8?B?cC84bitkZmhsMFpPZXNPeERZVEJvN2pVbzdaVE5YT1M1VzNpYndoVUVwTVVa?=
 =?utf-8?B?L3FuMXVWUDc2OXBvVEdxRmw5Wmlib3hYaTF5RGM1aCtqUGVKaWtBMUl5WUNN?=
 =?utf-8?B?U3BYM0FKUFJjZzhIc0lwMUZaczREWUprNWF1V255eWh5YWFUYWZmdTdmTWpw?=
 =?utf-8?B?czJMZjVkTU4xcnhqVU0zNFo5dHVmUndRczY0dkdZalJNQkpKQ0cxOVNKam5W?=
 =?utf-8?B?WHhiVzR6eTFXRmtnT3lnQUFXaHhFcGMzK1JLRjRQQVdxQlNYV1l0U2RBcDEv?=
 =?utf-8?B?RzhEUXowMzByRGR1NEptL0pHRzZwL08xUERrQ3Jmbmpzek5qd1Zub3lYdDlk?=
 =?utf-8?B?dHU0aWNwYXltY1Q3TFR6cGtoUHFiMCtObXVsOWIvRFZOYnhycHA0NEVmVmFF?=
 =?utf-8?B?ak83YU9mRlZqTWxtbnI2NWRjbU9rdVRHV3k4S0JPM0dxTytSTGdjZ05kSTda?=
 =?utf-8?B?M0o0STB6Zm9SVGFnMXh3NG5xZEJjSU9MYUV6UEliczh1a1pzaGRnSlFFclU3?=
 =?utf-8?B?VDVqdnFESXlQQlNWeVlNVjVPQUdGZWh1ci8zaFhVb2wzQm9uVE9pbzZnSjRY?=
 =?utf-8?B?RFc4V3ZMNDZ2L0dQM25YL29adTZ1cWk5WnJsSE03ZkdiWVFsRjdOb3pJejgr?=
 =?utf-8?B?bjY1cHlsUkQ4OXFUZUUzTHI0NjFsNEdRcnc5VEtPSmtkcVBNR29NUmJWRGJ0?=
 =?utf-8?B?RWI2YnZKcDNubk5hQTBCUU5pc2YxY0ZONkdycTZ0RU9RUXM5bE9TQmxhK0FU?=
 =?utf-8?B?U0JnRWp0V2svbjhxRVBkRFMyS2pQRWFLL2pCbm8yaW5KYmZuNzdoTnMzcGNE?=
 =?utf-8?B?dUtqSkg0RjJYV3VzYnFnTVBEbEtJTmpPMmJnd1NnTHBQUTROZHRORlpqT2hI?=
 =?utf-8?B?MWsxMG5jY2ttUXgrdnI2ZmhOUmh6ZldqVXBiOU5rVko3bFU0TkMvK0dlK3Zj?=
 =?utf-8?B?dDBaL2lCZi9YNy9SMkZ6LzdhaWRDcGR3STkvNTV4SXJpOW1LNzdDY2xPM1ZX?=
 =?utf-8?B?OC9KRUZuS2xaZFNEZzYzZStxYlpwY0g3WHNnUnFqM3NaUUV4cUVNOUhMcWpG?=
 =?utf-8?B?dUhlSEptbnRIRCtabGkzWHc4U3o0Z1kyc0EvSkhjbDFHa2RUSFJudkt2VlBn?=
 =?utf-8?B?aGpuRllHYkpuVXJRaXdDaGJLV1VuVjlFNGVyUldSeU56KzV6cWkyd01FR0U3?=
 =?utf-8?B?cnY4TFgrVnlRd2V5QXd2MTFZZGc3TTFwOStSSXgwNnNTdnh1dWM2ckNpQzRh?=
 =?utf-8?B?bjQxRnJwNTFQeWlKRFJXWUNBN1pNMUNMeVV1WDZnb2JHN3FRRTZSOUxWSndY?=
 =?utf-8?B?NzRZeGt4aU9TR3VrY1RBYmR6bEcrVHoyUU1GZkVHTDdTZEl3S2k2ZzhscFkw?=
 =?utf-8?B?VW1uT2gwTnNmWjhEdUtHbzRhQkQxRzk0N3FZUFcyR3JXc2lQenhBekwvdTBR?=
 =?utf-8?B?RGVGVFU2RDdPTzlGdjJraXVvcTZhQ0JVeUtIQUpLbTNJSmtWUVhsNGhabDVS?=
 =?utf-8?B?Nkh3UFJPN0t5M3NLeTRFN2E4VzJMZ0tNVlJnZFYyT2tRMGlnM09jVTEvTS9Y?=
 =?utf-8?B?K1FHZVk3bmxjWENNc3F2VlVLNmNoaENHT3A2dmtrVGxEbCtoa0RZV2FqZXJI?=
 =?utf-8?B?SGVKQktXNXB5YTFmaXBPQW82dWZvWnhFQmtUa0NBb2ZlaWIzVm5DY1hTSFhW?=
 =?utf-8?B?SForYmF3NzhLZW1XNnNlNndJNnJNLzluSDNwMzh4NWZHSVN1eXhqMW5ZUGU4?=
 =?utf-8?B?NFVsOU1ES2RkVzRaVnlrNHZjWk1WQUsvOGhQem4zNVJ3T3FTSjl2dGVLR2Rz?=
 =?utf-8?B?c201NVlwY0ZpU3ZTSXdEOTZvazlqdkowdnBTeDE2QitXWUY0QWFXb0dxVTZv?=
 =?utf-8?B?OVBrQ2pxcTl4cjZ1Vk01YkdJWHBMWkNoY3NIQWFZMXVNMjRzalhrM09SdVZY?=
 =?utf-8?B?THA4N3pQbEx4QUxVTEpGdThLK0pQZmhZNnJuVFo2c3lPaDIzMXV0VDcyeWFh?=
 =?utf-8?Q?61SY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b07b8db-cb12-478b-455b-08db522c6e2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2023 14:31:38.3670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhEFCWJD8prJjUmcrihFSelmRQb6x2HefAmvlKKTYawnQbnYqvmp1MOE7GwrwIncFh+M7l7MRTIaXr7DbuOq0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5941
Subject: [virtio-dev] RE: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBNYXkgMTEsIDIwMjMgMzoxNyBBTQ0KDQo+ID4gYSBjb25maWdxL2NtZHEgZGlzY3Vzc2lv
biBpcyBmb3IgbmV3IGZlYXR1cmVzIGZvciBQRiwgVkYsIGFuZCBTRi9TSU9WDQo+ID4gZGV2aWNl
cyB0byB3b3JrIGluIF9ub25fIGJhY2t3YXJkIGNvbXBhdGlibGUgd2F5LCBiZWNhdXNlIGZvciBu
ZXcNCj4gPiBmZWF0dXJlcyB0aGVyZSBpcyBubyBzdWNoIHRoaW5nIGFzIGJhY2t3YXJkIGNvbXBh
dGliaWxpdHkgYmV0d2Vlbg0KPiA+IGd1ZXN0IGRyaXZlciBhbmQgdGhlIGRldmljZS4NCj4gDQo+
IE9rLCBzbyB3aGF0IGNvbW1hbmQgZGlkIGNvbmZpZ3EvY21kcSBoYXZlPyANCg0KPiBJIHRob3Vn
aHQgaXQgd2FzIHNpbWlsYXIgdG8gdHJhbnNwb3J0IHZpcnRxdWV1ZSwgYnV0IGl0IGxvb2tzIG1v
cmUgbGlrZSBhIGNvbnRyb2wgdmlydHF1ZXVlIGhlcmUuDQpZZXMsIGl0IGlzIG1vcmUgbGlrZSBh
IGN2cSB0byBkbyBkZXZpY2UgYXR0cmlidXRlcyBkaXNjb3ZlcnkgYW5kIGNvbmZpZ3VyYXRpb24u
DQpKdXN0IHRoYXQgaXRzIGdlbmVyaWMgZW5vdWdoLg0KRm9yIGV4YW1wbGUgDQpjcmVhdGluZyBW
USB0aGF0IHNwYW5zIG11bHRpcGxlIHBoeXNpY2FsIGFkZHJlc3Nlcy4NCkRpc2NvdmVyeSBhbmQg
ZW5hYmxpbmcgbmV3IGRldmljZSBhdHRyaWJ1dGVzIHdoaWNoIGFyZSByYXJlbHkgYWNjZXNzZWQg
b3IgYWNjZXNzZWQgZHVyaW5nIGRldmljZSBpbml0L2NsZWFudXAgdGltZS4NCg0KVGhlIGZ1bmRh
bWVudGFsIGRpZmZlcmVuY2UgYmV0d2VlbiBjZmd2cSB0byB0dnEgaXM6DQpDZmd2cSBpcyBiZXR3
ZWVuIHRoZSBtZW1iZXIgdmlydGlvIGRldmljZSBhbmQgaXRzIGRyaXZlci4NClR2cT1hcSBpcyBv
biBncm91cCBvd25lciBvZiB0aGUgdmlydGlvIGRldmljZS4NCg0KPiANCj4gPg0KPiA+ID4NCj4g
PiA+PiBDb21wYXRpYmlsaXR5IGlzIGNvbWluZyBhdCBhIGNvc3Qgd2hpY2ggaXMgbm90IHNjYWxp
bmcuDQo+ID4gPj4gSWYgeW91IGF0dGVtcHQgdG8gc2NhbGUsIGl0IGJyZWFrcyB0aGUgZnV0dXJl
IHBhdGggZm9yd2FyZCB0byBnbyB3aXRob3V0DQo+IG1lZGlhdGlvbi4NCj4gPiA+Pg0KPiA+ID4+
Pj4NCj4gPiA+Pj4+IFNvIGV2ZSBncm93aW5nIHRoZXNlIGZpZWxkcyBhbmQgb3B0aW9uYWxseSBw
bGFjZW1lbnQgb24gY29uZmlncQ0KPiA+ID4+Pj4gZG9lc24ndCByZWFsbHkgaGVscCBhbmQgZGV2
aWNlIGJ1aWxkZXIgdG8gYnVpbGQgaXQgZWZmaWNpZW50bHkNCj4gPiA+Pj4+ICh3aXRob3V0IG11
Y2ggcHJlZGljdGFiaWxpdHkpLg0KPiA+ID4+Pg0KPiA+ID4+PiBDb25maWcgcXVldWUgaXMgbm90
IHRoZSBvbmx5IGNob2ljZSwgd2UgaGF2ZSBhIGxvdCBvZiBvdGhlcg0KPiA+ID4+PiBjaG9pY2Vz
IChmb3IgZXhhbXBsZSBQQVNJRCBtYXkgaGVscCB0byByZWR1Y2UgdGhlIG9uLWNoaXAgcmVzb3Vy
Y2VzKS4NCj4gPiA+Pj4NCj4gPiA+PiBQQVNJRCBpcyBmb3IgcHJvY2VzcyBpc29sYXRpb24gc2Vj
dXJpdHkgY29uc3RydWN0LCBpdCBpcyBub3QgZm9yIHRyYW5zcG9ydGF0aW9uLg0KPiA+ID4NCj4g
PiA+IEkgbWVhbnQgd2l0aCBQQVNJRCB5b3UgZG9uJ3QgZXZlbiBuZWVkIGEgQkFSLg0KPiA+ID4N
Cj4gPiBOb3Qgc3VyZSBJIGZ1bGx5IHVuZGVyc3RhbmQsIGJ1dCBteSBndWVzcyBpcywgdGhpcyBp
cyBjb21pbmcgZnJvbQ0KPiA+IG1lZGlhdGlvbiB0aG91Z2h0IHByb2Nlc3MuDQo+IA0KPiBOb3Qg
YWN0dWFsbHkuIEkgbWVhbnQsIGZvciBleGFtcGxlIHdpdGhvdXQgUEFTSUQsIGZvciBtb2Rlcm4g
ZGV2aWNlcywgdGhlDQo+IGNvbW1vbiBjZmcgc3RydWN0dXJlIG11c3QgYmUgcGxhY2VkIG9uIGEg
QkFSIHRocm91Z2ggTU1JTy4NCj4gDQo+IEJ1dCB3aXRoIHRoZSBoZWxwIG9mIFBBU0lELCBpdCBj
b3VsZCBzdGF5IGluIHRoZSBtZW1vcnkgYW5kIHRoZSBkZXZpY2UgY2FuIGZldGNoDQo+IGl0IHZp
YSBETUEuIFRoZSBoZWxwIHRvIHJlZHVjZSB0aGUgcmVzb3VyY2VzIGZvciByZWdpc3RlcnMuDQo+
IA0KWWVzLCBpdCBjYW4gc3RheSBpbiBtZW1vcnkgYW5kIGRldmljZSBjYW4gZmV0Y2ggdmlhIERN
QSB1c2luZyBhIFZRIHVzaW5nIGl0cyBvd24gcSBmcm9tIGd1ZXN0IGRyaXZlci4NCldoeSBkb2Vz
IGl0IG5lZWQgUEFTSUQ/DQoNCj4gPg0KPiA+ID4+IFNhbWUsIFNJT1YgYW5kIFZGcyBkbyBub3Qg
cHJlZmVyIG1lZGlhdGlvbiBnb2luZyBmb3J3YXJkIGluIHRoZSB1c2UNCj4gY2FzZXMgd2UgY29t
ZSBhY3Jvc3MuDQo+ID4gPg0KPiA+ID4gVW5sZXNzIHlvdSBkb24ndCB3YW50IHRvIHByb3ZpZGUg
VkYgY29tcGF0aWJpbGl0eSBmb3IgU0lPVi4NCj4gPiBJIGRvIG5vdCB1bmRlcnN0YW5kIHdoYXQg
Y29tcGF0aWJpbGl0eSBpcyB0aGlzIGJldHdlZW4gd2hpY2ggdHdvIGVsZW1lbnRzPw0KPiA+IFZG
IGhhcyBpdHMgaWRlbnRpZnkgY3VycmVudGx5IGFuZCBTSU9WIHdpbGwgaGF2ZSBpdHMgb3duIGlk
ZW50aXR5IGluIGZ1dHVyZS4NCj4gDQo+IE9rLCBzbyBpdCByZWFsbHkgZGVwZW5kcyBvbiBob3cg
dG8gaW1wbGVtZW50IHRoZSB0cmFuc3BvcnQgZm9yIFNJT1YuIEkgZ3Vlc3MgaXQNCj4gd29uJ3Qg
dXNlIHJlZ2lzdGVycy9CQVIgYW55IG1vcmUuIElmIHRoaXMgaXMgdHJ1ZSwgaWYgd2Ugd2FudCB0
byBydW4gYSB2aXJ0aW8tcGNpDQo+IGRyaXZlciwgaXQgbmVlZHMgc29tZSBtZWRpYXRpb24uDQo+
IA0KPiBJdCB3b3JrcyBsaWtlIHdoYXQgeW91IHByb3Bvc2VkIGhlcmUuIFNvbWVkYXksIFNSLUlP
ViBvciBCQVIgdHJhbnNwb3J0IHdpbGwNCj4gYmVjb21lICJsZWdhY3kiLCBidXQgd2UgbmVlZCBh
IHdheSB0byBtYWtlIHRoZSAibGVnYWN5IHZpcnRpby1wY2kgZHJpdmVyIg0KPiB3b3JrLg0KDQo+
ID4NCj4gPiBMaXZlIG1pZ3JhdGlvbiBhdCBWRiBsZXZlbCBmb3IgdGhlIHBhc3N0aHJvdWdoIGRl
dmljZSBjYW4gYmUganVzdCBmaW5lDQo+ID4gd2l0aG91dCBhbnkgbWVkaWF0aW9uIGFzIGxvbmcg
YXMgYWxsIHRoZSBwYXJhbWV0ZXJzIG9uIHNyYyBhbmQgZHN0DQo+ID4gc2lkZSBtYXRjaC4NCj4g
PiBXZSBhbHJlYWR5IGRpc2N1c3NlZCBpbiB2MCwgc28gSSBwcmVmZXIgdG8gYXZvaWQgdGhpcyBh
Z2FpbiBhbmQgZm9jdXMNCj4gPiBvbiB0aGUgcGF0Y2ggaW4gZGlzY3Vzc2lvbi4NCj4gDQo+IEkg
YWdyZWUgd2UgYXJlIGZhciBmcm9tIHRoZSB0b3BpYyBvZiBsZWdhY3kgc3VwcG9ydC4gQnV0IG15
IHBvaW50IHN0YW5kcyBzdGlsbC4NCj4gV2UgY2FuIGRpc2N1c3Mgd2hlbiBsaXZlIG1pZ3JhdGlv
biBwYXRjaGVzIHdlcmUgcG9zdGVkIGJ5IHNvbWVib2R5Lg0KPiANCk9rLg0KDQo+ID4gWWV0IHdl
IGFyZSByZXBlYXRpbmcgYW5kIGRpdmVyZ2luZyBmcm9tIHRoZSBkaXNjdXNzaW9uLCB0aGF0IHdl
IHNob3VsZA0KPiA+IG5vdCBpbnRlcm1peDoNCj4gPiAxLiBIb3cgdG8gYWNjZXNzIGxlZ2FjeSBy
ZWdpc3RlcnMgb2YgdGhlIFZGDQo+IA0KPiBXaXRoIHdoYXQgeW91IHByb3Bvc2VkLCB3ZSBkb24n
dCBldmVuIG5lZWQgbGVnYWN5IHJlZ2lzdGVycyBmb3IgVkYuIFdlIGp1c3QNCj4gbmVlZCB0byBr
ZWVwIGl0cyBzZW1hbnRpYyB2aWEgdGhlIGFkbWluIHZpcnRxdWV1ZSBjb21tYW5kcy4NClllcywg
d2UgZG9u4oCZdCBoYXZlIElPQkFSIHJlZ2lzdGVycyBmb3IgdGhlIFBDSSBWRi4gSXQgaXMgdGhl
IDEueCBWRiBzbyB0aGVyZSBhcmUgbm8gbGVnYWN5IHJlZ2lzdGVycyBvbiBpdC4NCkFzIHByb3Bv
c2VkIGl0IGlzIGFjY2Vzc2VkIGFyZSB2aWEgYXEgY29tbWFuZHMgb2YgUEYuDQo=

