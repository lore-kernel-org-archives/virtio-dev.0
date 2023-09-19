Return-Path: <virtio-dev-return-13827-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74835CD54AB
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 09:06:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A758271005
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 09:06:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7BF27986555
	for <virtio-dev@archiver.kernel.org>; Tue, 19 Sep 2023 09:06:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 61CE7983E25; Tue, 19 Sep 2023 09:06:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5186A9864C2
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Sep 2023 09:06:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dhplUFGfO+EaGQSHQEgiaYqhSir0hEmmKM3aldtCG23RFPgyeO4QCCnyVvqgY931DlV9pMjxQfPqbHSrPuO8sr8fsLXXfp7CGCRl34FobdZbAwAa4m/2B+xvXCTrYZ5RRT/gG/70OMditOltO0Y/zxixL/o8TvnTA4+js9f9dYIn9SI9x2PkFB+oL/Scd4as5FllXtXXgevjVaa8Dieepz9v86dKr5bKxDL08ztcZ9HH+sVXaaXJQBWWmkM+RegTxYu0NqcFz847Mws7+rGhZqsEiGSYwxKatBbqlQL9SVTph7IRBQEF824AD/8mYwnbM9bMT7+gM6woUUjBmJArOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5ghYN6LakJHfC0Agch/Y9dUu+iDMNTQTkSGZBKA2d8=;
 b=Mqt5fE8TeUgSsBnzRCjttZMYVnMGaqd0qhBqzrVqHOOvYYLvigHy0TiPD0V/RZGUD3/zApexrEHlbdapMJge+rY5So0UzXzZQy1C+TV7qOZB3gsTq/K6auTjISEpas+KXcSvShECnlYlACd9q2Qk83BJ3f0tDaAKm5DxF+fJAPNC0N6VBXSowbPkb7wL31R/VW6RlRssauahxYbNkGkBZFkyFc3LAoOypvoZgX+iDEH6B08T/9n2bKRPbYCOd5Z/jejXGnZhcoeOGKIbj3WmQNGhI5H/DVmnZyRJumGoFoPf6FtyB5uD+JzLU4Das6bU1pEkauS+2jIva/EyCjfg3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Michael
 S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Thread-Topic: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state
Thread-Index:
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAC3dgIAAl98QgADghoCAABCh0A==
Date: Tue, 19 Sep 2023 09:06:41 +0000
Message-ID:
 <PH0PR12MB54810692ACC61C50A911ADE8DCFAA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230914070911-mutt-send-email-mst@kernel.org>
 <559c0875-24b8-0709-712e-24ffe7830022@intel.com>
 <PH0PR12MB548159C982509436C6499279DCF4A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <09045654-d69c-845d-ee26-636fa08f68b4@intel.com>
 <PH0PR12MB5481C41D4F32DA26D5831471DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <67680965-b115-32c7-dfdf-c56ab37bdd81@intel.com>
 <213a0f94-cee2-d8c5-3c5d-d2d7fc920e75@intel.com>
 <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com>
 <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <c1361497-4c46-d00d-58e7-520d5f81b90a@intel.com>
In-Reply-To: <c1361497-4c46-d00d-58e7-520d5f81b90a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB7024:EE_
x-ms-office365-filtering-correlation-id: 615b3581-314c-4cf5-9493-08dbb8efbd0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4t8qXDNSDaYXwv7Ifa614WGl5/AOk2axJJVlwITtpAS84L9JwSI7PEkM8A9OI/r0uRcfgiwOUZ/+W4XZL4ZmnoeEyjesdZDs04spJrmY1ygh8EjZ1nXPuu6ZLS0aVYfFIfk0Bl23GTWM5FzpbhL8tpLecG7ecoBug/r162XCH8qx1PgHZmdXqxZ6IOeUgqH6taHnvT59jC1PiYbIuhoVGl8xjN0MlOgbwt5pcjyZdDF47p/luzCC/+fTYJ6S1YCFVksf1WFGSf9bceSTISKziDmwgmMiWXAFCFDshf/fwyV4N4AeEsz5mo7ReBzLasJElGF7Xz7HA4GDJLwSitKnd7HLLNrHURaAVFcqDJZ3DvJHGtPlZdsQI6/m62alCsALW+CFAjHvlhn8qKW3zykdSRMVJnmK/k7tM5/66gdPrDesVzNDuj2vUlwA5vyTLJ3s+yYvQ201PQmN46z4DJP60E4M/x0bgxXfgDz3jXpWIzNTKVS+1y8fprvAD0TgOD9UT3IwY8jhJHc5cEexw1jeMCKdHgUVJHXZpFVzRp9wgE6uP51Dy5jyECK5PhlrX4Yz1MaTQPejQjC/TqpHZX+OXkWT7jcr1otjAWnPMAQOvQEVayMs8YqX3EfKmMnr3r4X
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199024)(1800799009)(186009)(15650500001)(2906002)(5660300002)(52536014)(8676002)(8936002)(41300700001)(316002)(76116006)(66446008)(26005)(66946007)(110136005)(66556008)(66476007)(64756008)(478600001)(53546011)(55236004)(7696005)(71200400001)(9686003)(6506007)(83380400001)(55016003)(122000001)(33656002)(86362001)(38070700005)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NmRiLzdqN3JmelladWQzZThqaUV1S2RiVUozNnk3dEhoaUZzMU43bzhla3Nt?=
 =?utf-8?B?c01sMHhVZm9rdnM4VEh5c0xRV044bkVCSFNvVFk5QUY0T0FaU09KMnlHYmlu?=
 =?utf-8?B?dWZ4QWdrZ3pKdDd5RHdJb21qa3NGV2UxSDc3cHRhdXF0djJDWmF4S3dpc3hE?=
 =?utf-8?B?dWJiR00zeTZCSUFJeWowNDg3YzNUaEE5OWQ5ZUtCdTRLM2xxdGNGWjVERnVa?=
 =?utf-8?B?bjkrRU1BT21rRnpVSjh4YzhIMTFwMk1KbTlpQkVxT1haaXlMU2RXRW9aemNT?=
 =?utf-8?B?V09semhYQVZSQjI0ZWhwcDE0eFM2Uk84a1FpLzNsMW1JcjFNeXBZQk5NS3hp?=
 =?utf-8?B?YmxUVUE2RGNXMTZiMUdIdEZ6YkVLMVZ6d3p3SkNEcUxKYWc0TzZTSWsrR3ND?=
 =?utf-8?B?ajRmZ3ZQTkthTHlJZDdtRi9wdW42TERFajhsbHJPekpsNVByYmU0MXZTa2Rn?=
 =?utf-8?B?L1I1OFFjUitlR3NnSnFwZkdKSWFXNE41U3VjajhTbFJNUVpYZ0c5dTdTbGkx?=
 =?utf-8?B?c1dtczBST1J5amhhaUdYTUM5Rmx3eVFyb0JGNkczZ1FrZTVjV2Rnb1crVC96?=
 =?utf-8?B?ckdzbXVzbGZ2c2dJWU9GM1I1UmsyN3BWL3gxZHV3WFdiellIYjZ4UVYyWGsz?=
 =?utf-8?B?VWtadFFuOURSNTJnR1FPc0tSNlVzT1RQTzAvb0tZbFFXRUk4bzBhQllqbzVP?=
 =?utf-8?B?NVRGNWcxcEltcmNyUW95ZlR3V1V6MHUzM2dlK2pYNGUvdGs0YmxtZjRWS2V4?=
 =?utf-8?B?Nmp3SXBHbEt6NUZIMnZueG5raGhGVitsa1p5ZDRxc2oyeE05OFpvQ1M5bS9s?=
 =?utf-8?B?dWRIRytXL3dEMVpDaUIzcHZxMnI2akpXUzd2TkwycUt0NEJVUHEyRGFUWDBa?=
 =?utf-8?B?eXFMS2xrMWZaOVYzU0wyYXJtSkdtMkNYK3lyWFh6TDhId2g1L0lTSWNyVytt?=
 =?utf-8?B?SnNjVEZoWnh5VFppTm9CSElXNjJvSDZWSWJ3eTJaMVBBQWNMaUhIb2Zmcnpy?=
 =?utf-8?B?OFQwYjZlb1Eybi9tOUV5MTVnNGFoVERYTE1wc2Z1OWpQdnlWSGhEVUpPcFY2?=
 =?utf-8?B?bDEvSHpLQk9XaEdId2pNSkEza1o4OFRVVktWRE9XQllMNFdwaHhEcEV1K3dU?=
 =?utf-8?B?aWhBTVNWdGlrKzV3c3ZadDVtSVdwM1JwbUlyU3p3Sm1yYk5IRk5rOW1uSGFa?=
 =?utf-8?B?R3ZyYjNWdU01UXkweVZqbWlnWjk5ZmdndXcxVGpFcnNoNnkvRUZrRnFjRnBP?=
 =?utf-8?B?NGFaQ2U3S0FNUElUeFRBemVSTWgwSlAvNnVVVmFoU3JzdlFCVlRoK3ZJMk9l?=
 =?utf-8?B?Ny84SGZ1Ri9Pb0ZabmZBazhxUTUvSEROa3dieHZFRjU3UTQrL3NEZWpZUEx5?=
 =?utf-8?B?MTQrV0ZEcklseURyWjMxN004ajcyS0N2clFEdjhpSGZNY3BHa0NoR2l3Ymg3?=
 =?utf-8?B?Vk1vV05mbXd0SnlvYVV4TEMwMWVNMjIyOURRTVo3bGhySnlaUER4a1V1cE9q?=
 =?utf-8?B?RWRLY1BWY0lTQU9ZdHRFZjdOVWpUdlFhNHl5dTk0OGVOZmloVUlDUjQvWGZn?=
 =?utf-8?B?QUdjZmlvZ01JUWZxNkZUOXczNUdmbDdFd1pLYlpUWHdqNVFWam9jOTRzT2xv?=
 =?utf-8?B?eHltQnFHenZXQTdkT0pscTNseHEzbkVXRnZEVzkxU08rYUd5dkRBV3hDekRa?=
 =?utf-8?B?cjlwT1puQ3VnMDRNaWhrNHNNcHhwMFdudlRFN2RWVjNNa2ZoOEF0enYzWHRy?=
 =?utf-8?B?U05xbzlhU3RhYVBXTkllUFMzOVI1RDBJblp4YkZXWUM0NmZudDc0QTByNkpX?=
 =?utf-8?B?NHFmN0t3QjRsS2lzZHdURmNzUlU2RTBUbXVZTlZoZUNJQ3RKSWxKWVN2b0tQ?=
 =?utf-8?B?ZmRNNTREWEZYZUJ4dzlySWtBS29TK0gzSVRIbTJpZXNTb1pqSzZQbzRxNjk3?=
 =?utf-8?B?dE5VS0xlSVRZUGtBQlFRVUlnbUxqUENjYnZkKzBhcmY4dlBLOXRtcVNneldF?=
 =?utf-8?B?enRVV3ppMDExSXNtNkdKMExJa3NtdXRCSFVPcE9BL2JQNWoxUGc1TjBObHZZ?=
 =?utf-8?B?QWUwelVqTHZSeEh2VlNTVnZMRnoxWDRiRGlRbU5YT0pxbmdvL0RZTXE3UmlP?=
 =?utf-8?Q?I0xw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 615b3581-314c-4cf5-9493-08dbb8efbd0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2023 09:06:41.0870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OCKrCXDclaR4p9TuY0tFtTyXg+Ma5XcjACfdNyrDVLrWmUepU6c0F7EAcaEeUneODwKUK9dM4/h27TF3CAO5Uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7024
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state

DQoNCj4gRnJvbTogWmh1LCBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4NCj4gU2Vu
dDogVHVlc2RheSwgU2VwdGVtYmVyIDE5LCAyMDIzIDE6MzIgUE0NCj4gDQo+IE9uIDkvMTkvMjAy
MyAyOjQxIEFNLCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+ID4+IEZyb206IFpodSwgTGluZ3NoYW4g
PGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+ID4+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDE4
LCAyMDIzIDM6MDUgUE0NCj4gPj4NCj4gPj4gT24gOS8xOC8yMDIzIDI6NTQgUE0sIFBhcmF2IFBh
bmRpdCB3cm90ZToNCj4gPj4+PiBGcm9tOiBaaHUsIExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50
ZWwuY29tPg0KPiA+Pj4+IFNlbnQ6IE1vbmRheSwgU2VwdGVtYmVyIDE4LCAyMDIzIDEyOjE5IFBN
IHNvIGFkbWluIHZxIGJhc2VkIExNDQo+ID4+Pj4gc29sdXRpb24gY2FuIGJlIGEgc2lkZSBjaGFu
bmVsIGF0dGFja2luZyBzdXJmYWNlDQo+ID4+PiBJdCB3aWxsIGJlIHBhcnQgb2YgdGhlIERTTSB3
aGVuZXZlciBpdCB3aWxsIGJlIHVzZWQgaW4gZnV0dXJlLg0KPiA+Pj4gSGVuY2UsIGl0IGlzIG5v
dCBhdHRhY2sgc3VyZmFjZS4NCj4gPj4gSSBhbSBub3Qgc3VyZSwgd2h5IHdlIGhhdmUgdG8gdHJ1
c3QgdGhlIFBGPw0KPiA+PiBUaGlzIGlzIG91dCBvZiB2aXJ0aW8gc2NvcGUgYW55d2F5Lg0KPiA+
Pg0KPiA+PiBJIGhhdmUgZXhwbGFpbmVkIG1hbnkgdGltZXMgaG93IGl0IGNhbiBiZSBhIGF0dGFj
ayBzdXJmYWNlLCBhbmQgZXhhbXBsZXMuDQo+ID4+DQo+ID4gQW5kIG5vbmUgb2YgdGhhdCBtYWtl
IGFueSBzZW5zZSBhcyBmdW5kYW1lbnRhbGx5LCBoeXBlcnZpc29yIGlzIHRydXN0ZWQNCj4gcmVn
YXJkbGVzcyBvZiB0aGUgYXBwcm9hY2guDQo+IHRoaXMgaXMgbm90IGFib3V0IGh5cGVydmlzb3Jz
LCBJIGFtIHNheWluZyBhZG1pbiB2cSBiYXNlZCBMTSBzb2x1dGlvbiBjYW4gYmUgYQ0KPiBzaWRl
IGNoYW5uZWwgYXR0YWNraW5nIHN1cmZhY2UgUGxlYXNlIHJlZmVyIHRvIG15IHByZXZpb3VzbHkg
bGlzdGVkIGV4YW1wbGVzDQo+IGFuZCB0aGUgVERJU1Agc3BlYyBpcyBGWUkuDQo+ID4NCkluIHBy
ZXZpb3VzIGVtYWlsIHlvdSB3cm90ZSAiIEFzIEkgc2FpZCBiZWZvcmUsIENDIGFuZCBURElTUCBp
cyBvdXQgb2Ygc3BlYywgdGhhdCBtZWFucyB3ZSBzaG91bGQgaWdub3JlIHRoZW0gZm9yIG5vdy4i
DQpTbyBJIGFtIGlnbm9yaW5nIGl0IG5vdyBhbmQgaGVuY2UsIEkgYW0gaWdub3JpbmcgYWJvdmUg
Y29tbWVudC4NCkxldHMgcmVhY2ggdG8gYSBjb21tb24gZ3JvdW5kIGZvciBzaW1wbGlmaWVkIGNh
c2UgYW5kIHRoYW4gY29uc2lkZXIgbW9yZSBjb21wbGV4IGNhc2VzLg0KDQo+ID4+IFdoYXQgaGFw
cGVuIGlmIG1hbGljaW91cyBTVyBkdW1wIGd1ZXN0IG1lbW9yeSBieSBhZG1pbiB2cSBkaXJ0eSBw
YWdlDQo+ID4+IHRyYWNraW5nIGZlYXR1cmU/DQo+ID4gV2hhdD8/DQo+ID4gV2hlcmUgaXMgdGhp
cyBtYWxpY2lvdXMgU1cgaXMgbG9jYXRlZCwgaW4gZ3Vlc3QgVk0/DQo+IGhvc3QsIGluIHRoaXMg
YXR0YWNraW5nIG1vZGVsLg0KPiA+DQo+ID4+Pj4+Pj4+IEZvciB1bnRydXN0ZWQgaHlwZXJ2aXNv
ciwgc2FtZSBzZXQgb2YgYXR0YWNrIHN1cmZhY2UgaXMgcHJlc2VudA0KPiA+Pj4+Pj4+PiB3aXRo
DQo+ID4+Pj4+Pj4+IHRyYXArZW11bGF0aW9uLg0KPiA+Pj4+Pj4+PiBTbyBib3RoIG1ldGhvZCBz
Y29yZSBzYW1lLiBIZW5jZSBpdHMgbm90IHJlbGV2YW50IHBvaW50IGZvcg0KPiBkaXNjdXNzaW9u
Lg0KPiA+Pj4+Pj4+IHRoaXMgaXMgbm90IGh5cGVydmlzb3IsIERvIHlvdSBzZWUgYW55IG1vZGVy
biBoeXBlcnZpc29yIGhhdmUNCj4gPj4+Pj4+PiB0aGVzZSBpc3N1ZXM/DQo+ID4+Pj4+Pj4NCj4g
Pj4+Pj4+PiBUaGlzIGlzIGFkbWluIHZxIGZvciBMTSBjYW4gYmUgYSBzaWRlIGNoYW5uZWwgYXR0
YWNraW5nIHN1cmZhY2UuDQo+ID4+Pj4+IEl0IGlzIG5vdC4NCj4gPj4+Pj4gSHlwZXJ2aXNvciBp
cyB0cnVzdGVkIGVudGl0eS4NCj4gPj4+Pj4gRm9yIHVudHJ1c3RlZCBoeXBlcnZpc29yIHRoZSBU
RElTUCBpcyB1bmlmaWVkIHNvbHV0aW9uIGJ1aWxkIGJ5DQo+ID4+Pj4+IHRoZSB2YXJpb3VzDQo+
ID4+Pj4gaW5kdXN0cnkgYm9kaWVzIGluY2x1ZGluZyBETVRGLCBQQ0kgZm9yIGxhc3QgZmV3IHll
YXJzLg0KPiA+Pj4+PiBXZSB3YW50IHRvIHV0aWxpemUgdGhhdC4NCj4gPj4+PiBmaXJzdCwgVERJ
U1AgaXMgb3V0IG9mIHZpcnRpbyBzcGVjLg0KPiA+Pj4gU3VyZSwgaGVuY2UsIHVudHJ1c3RlZCBo
eXBlcnZpc29yIGFyZSBvdXQgb2Ygc2NvcGUuDQo+ID4+PiBPdGhlcndpc2UsIHRyYXArZW11bGF0
aW9uIGlzIGVxdWFsbHkgZGVhZCB3aGljaCByZWxpZXMgb24gdGhlDQo+ID4+PiBoeXBlcnZpc29y
IHRvDQo+ID4+IGRvIHRoaW5ncy4NCj4gPj4gc28gbGV0cyBmb2N1cyBvbiBMTSB0b3BpYywgb3Ro
ZXIgdGhhbiBjb25maWRlbnRpYWwgY29tcHV0aW5nLg0KPiA+IG9rLg0KPiA+DQo+ID4+PiBKdXN0
IGJlY2F1c2UgZGF0YSB0cmFuc2ZlciBpcyBub3QgZG9uZSwgaXQgZG9lcyBub3QgbWVhbiB0aGF0
DQo+ID4+PiB0aG91c2FuZHMgb2YNCj4gPj4gcG9sbGluZyByZWdpc3RlciB3cml0ZXMgY29tcGxl
dGUgaW4gc3RpcHVsYXRlZCB0aW1lLg0KPiA+PiAxKSBhZ2FpbiwgdGhleSBhcmUgcGVyLWRldmlj
ZSBmYWNpbGl0aWVzDQo+ID4gVGhhdCBkb2VzIG5vdCBzYXRpc2Z5IHRoYXQgaXQgY2FuIHNvbWVo
b3cgZG8gd29yayBpbiA8IHggdXNlYyB0aW1lLg0KPiB3aHk/IERvIHlvdSBtaW5kIHRha2UgZXhh
bXBsZXMgb2YgYmFzaWMgUENJIHZpcnRpbyBjb21tb24gY29uZmlnIHNwYWNlDQo+IHJlZ2lzdGVy
cz8NCj4gPj4gMikgd2UgdXNlIHZlcnkgZmV3IHJlZ2lzdGVycywgZXZlbiBzdGF0dXMgYnl0ZSBk
b2VzIG5vdCByZXF1aXJlDQo+ID4+IHBvbGxpbmcsIGp1c3QgcmUtIHJlYWQgd2l0aCBkZWxheS4N
Cj4gPj4NCj4gPj4gUGxlYXNlIHJlZmVyIHRvIHRoZSBjb2RlIGZvciBzZXR0aW5nIEZFQVRVUkVT
X09LLg0KPiA+IEl0IHdvbnQgd29yayB3aGVuIG9uZSBuZWVkcyB0byBzdXNwZW5kIHRoZSBkZXZp
Y2UuDQo+ID4gVGhlcmUgaXMgbm8gcG9pbnQgb2YgZG9pbmcgc3VjaCB3b3JrIG92ZXIgcmVnaXN0
ZXJzIGFzIGZ1bmRhbWVudGFsIGZyYW1ld29yaw0KPiBpcyBvdmVyIHRoZSBBUS4NCj4gd2h5IGl0
IGRvZXNuJ3Qgd29yaz8NCg0KRm9yIHR3byBmb2xsb3dpbmcgcmVhc29ucy4NCjEuIEFsbCB0aGUg
dGhpbmdzIG5lZWRlZCBjYW5ub3QgYmUgY29tbXVuaWNhdGVkIG92ZXIgcmVnaXN0ZXJzIGVmZmlj
aWVudGx5LCBzdWNoIGFzIChhKSBkZXZpY2UgY29udGV4dCwgKGIpIGRpcnR5IHBhZ2VzLg0KMi4g
c3luY2hyb25vdXMgcmVnaXN0ZXJzIG9uIHRoZSBWRiBjYW5ub3QgaW50ZXIgb3BlcmF0ZSB3aXRo
IEZMUiBhbmQgZGV2aWNlIHJlc2V0IGZsb3cuDQo=

