Return-Path: <virtio-dev-return-13615-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFB71C83F2C
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Sep 2023 13:41:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 22CC6F3F4A
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Sep 2023 13:41:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 15EB49865ED
	for <virtio-dev@archiver.kernel.org>; Mon,  4 Sep 2023 13:41:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 08017986478; Mon,  4 Sep 2023 13:41:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EBC849863BC;
	Mon,  4 Sep 2023 13:41:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D1QaEpqQK9ZDPP7HpM3TVM0DMoLKx1xFJmndVcqL+6IdQyLJziD8ZpAvikdDcVLphox5VW2ArtuxBh1iUl1kdhIavqzAWtLq0ufaSBb9USfRXrAUUQ8JfrU728rmCYcGtDSs8czwPacyfeVYUy3ofZuvXFdZtSLJhcVQOVkmj/IwuR7CWdmh1yWznkPDu/A3js3R/uCcZthHRMPjy2CDs2Az6vSG1hETmmDLjim1NIkpXK0pjQGAhM2n0e/YUHBZ34gUA7eS7s4Q7k4blHVe3NHgoRGVT3zGCoeJL/L7F6WokF5qcZzxrKWcAj6T5SzoEVuBC/HraeZCszb1hsOblQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttVmJ8ZM1gZnwF/twBZXCgxV0aBW4aJiRRRye7oWWgA=;
 b=gC2Xt3QWxHyU2f0XKIEAsXDre4xHexwSpmLsnoU3ZRcmKsP2t86rRsj2EX028NJEXG1fgLGPzOMjttEw13+rT+GSTd+GRnhg8giDjGjGsakCNXZXq4qF3/psXVOXRiE51ygzE8svreMHmuRyeEiQpGI/UqScZy9Jy0xvqxuxckj87q+CC8fzAya81+Adb8SMfGdaknQ956pUeTSBeQmGQo4CJoPqWzK9/Ls8z4Inq1WuxhBmCLgqHn4+0dO3nsmlOGrMc4euHsUSM+PQIQqTJtSOYdkN0jBwJOxAPYYx9BZGC3bw2YkiOWmQjKg9p016XND9Cjn1MXCVbzW6H94yMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Heng Qi <hengqi@linux.alibaba.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, David Edmondson <david.edmondson@oracle.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Xuan
 Zhuo <xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-dev] RE: RE: RE: RE: [PATCH v16] virtio-net: support
 device stats
Thread-Index:
 AQHZ2wYzX/zNUNI4wUOZcBP1oGnfKbAF9gaAgARYMQCAAASwYIAAA0cAgAABWeCAAAy/gIAAGFyQgAAOWYCAABFEUIAAFQ4AgAAC6YA=
Date: Mon, 4 Sep 2023 13:40:58 +0000
Message-ID:
 <PH0PR12MB54810AE11D1FBC23ED360548DCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230830055239.10680-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54819EB466305284A8C9F649DCE4A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693812824.959417-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481859AEB22FDDFCDA9D57FDCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693814534.4663684-3-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB548167EDE78C3B7C00014D2CDCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1693817561.0941262-4-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB54812E119F4F042F78B95150DCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <526c4582-3521-45ad-afae-8d7e281b5f38@linux.alibaba.com>
 <PH0PR12MB54813CB40389462B1667184ADCE9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230904092711-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230904092711-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS7PR12MB8322:EE_
x-ms-office365-filtering-correlation-id: 4676a78c-caee-4c34-c6b7-08dbad4c91fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 VGx4CLVNDO6sKnk9dIK6CS80JysaqH69H8e5hpmnWzW9iF1zadESW2+3EZ82NJSJVB1H2PoZInCrl8jAdg9AzCcbHzE45vVoWP5NTVqErcuZ1nK+aiiNR410gaGFSW00lYe31iqkWS7lcDeOaAzCYqwa7NHPDQFoDweo3UEc3OMsFhtA+QEXbHmqrFggm/vmkNsYLchCzFtXmbejmZZDmMbbN6GQVqimGOIdCQ3IID0LqtstmG7VkFsVYt4mzaiWmk5l2/g1pbMgghoAFP7kB/VCn2rk3p6ioq1vJ6wZeQ+Rcct0WwyrpiZ/fx0Q+FS9cLvlWFbu4VVlz19yFGrOzqXawm3ATzhswPJqPyVDRNdfGuxaiqnPnAa5PmB1Fxnk6sP5V/HdnEVLKaprykQPyglHv2DPz4xNU7/+f1Sog6S9G396gjtccYYbg4w9HdBidilhKCicAc88xyGCpuN+GfJyu3g009vC9PD7gfj2QmilFQQJO47GBmIHnTsMPok7/uP6A9xWGKDkgbVJ5XsqH8Zn3/Cado+p4Fq3gBW+KDJldMhhDeD220NzEMHgItTdiIC7Q+hk1aKvNZ1yz31IA2K6dWVhUhkNGUI/JHLhOzzD1fjcZGSY9y6hsoa2PMy2
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(376002)(396003)(136003)(451199024)(1800799009)(186009)(4744005)(41300700001)(8936002)(55016003)(76116006)(478600001)(2906002)(71200400001)(66946007)(5660300002)(8676002)(64756008)(316002)(66446008)(6916009)(66476007)(52536014)(54906003)(66556008)(4326008)(9686003)(7696005)(26005)(6506007)(66899024)(38070700005)(122000001)(38100700002)(33656002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MGF4eXlIYUVaTzBLREZ6aGpqd2o3cHlFbFdERHlSQzJyWlJITjJCVWVnSldh?=
 =?utf-8?B?c0tSRGhDenkyL0p3NGFlV3U4Q1VqbW9tSHV4Y2E2QzVqNktLdE50alFKSTRJ?=
 =?utf-8?B?ejZZYlFqSFd5TGxDaG52S3Y5TTBpV01lVng4V2doRnByMC8xTTk4MmJwN3Zp?=
 =?utf-8?B?SjJwYnJnTTIwaVdzZGg5S0xqQjNjSTczRDMvRUtob3MwUmtLMDU1cEJ2WFZl?=
 =?utf-8?B?ejE2RjVjTktDZW5sc3A0OWZyZjVVdk4zZEd1OTc0aS9qeU0xUnRtVnQxekRx?=
 =?utf-8?B?SVU3eVNXaXY2V3V0T1BDV2N1Q3RPRHhnbU5qYSt2UXd0aXpJK1ZndlplU3Bq?=
 =?utf-8?B?SGVvSWNuaVZXQnMweDZGZDJDcEJmQXo0NzJveG1KVHhYVXBEMFREdDhaN2NS?=
 =?utf-8?B?bmJqTDVBVndTeFNDc0Z0cVgrK2w5WkZLZFlTeHlNRGNUNzlMWXJOSnBSNzRv?=
 =?utf-8?B?SGprQ016TDFTcjNFajZGTXM3ZUtaNUdvbVJKUmtHQ3hTTWRLN3JKZyswdFhz?=
 =?utf-8?B?NTZPUW1waXQyV0FjWUZEZWh2MCtVRWU4MkF5RDN0bCtmb2tDVlV6TWxEdkZ6?=
 =?utf-8?B?ejhHRm1lS0doNGNnb1Z4ZEMwU3MxeU5nazVIaitYYVpCejVlOGV1ZFVySnJ5?=
 =?utf-8?B?R1pPaSsrL2NnMzNlKzBISGNYTkFISXRVT0s1U2grQXlZelhFcFdmYzFCY3JX?=
 =?utf-8?B?V2dvdUdTampMaHc4UVoxd2ZWQ1NtaExzZ1lyWHBEZVNGUHRBcEdFV093R1hn?=
 =?utf-8?B?bE1oMmZINXBMNFdFRTJiZDNOb1ZMT3k1Ri9FOXQ0dzNKSEtmeHl1ZGZadFV5?=
 =?utf-8?B?OHlKU2JNb3lhZU9EWDRkS3JPclZpcmRxZ2diVXpmVDJnREFvdVZiQWprM0Y4?=
 =?utf-8?B?dFZZNW4yYzk4c0VJbXFmTkM2dUhNRU0wZkJwUFNGNnI4NGZoTWZpa2czRWhM?=
 =?utf-8?B?ZDlRcFQxZTFIYnl0aU40QnJ5ckE4Z1lFKzhqN3ZGb0IzVGlWd2lraG9QU2Jq?=
 =?utf-8?B?Qk9YaXFXQTZPOUVlNUVSUmR3eGRxRlJ0OUhqT2dOTk1sS0hZYUhFTVpaNUk2?=
 =?utf-8?B?dDhWMDUwY2VZbWxNYVBjbXErUWJaTEdCV3pXd2QxWEZDSGhpYjM3S1NYcld6?=
 =?utf-8?B?MytLZ28zUUJUWmtKSDdvUWpTOUMxN1BFMW4wZS9QY0hNMkduOGlRVVFRbE16?=
 =?utf-8?B?MGhoMWVqNUh3ak0rdUZpK1hneCtEMFdMUWZjbEJMNkVySXZxTlFCTDFkdzV3?=
 =?utf-8?B?SHVMcklEVDFBaml5RUI4a2M0NStVelg0QWZPYXdIVThaR2RDdC9kTm96c2Ex?=
 =?utf-8?B?R2FaQXc1dHBkeFY4OEVyTm9kd2Y1bFI0WHFreFJUd3gzMjEvUUlITklRTXRy?=
 =?utf-8?B?MDdwek9TbzlBYTZZa0g5MnIxeGxxUU8ydy9UcUxjQTBzQmNuMk9VS1RMU0lh?=
 =?utf-8?B?ZnVudk9jQUluN0NCbHlsWEVPNjBjcUhhRW82UGZGM09JOXJGTFJMc3JOOHY0?=
 =?utf-8?B?L1FzV1JYekhkbzMxcElybC9iRHZEblR4TmlSbkNxajFtN0tRNkkzSVowdEFk?=
 =?utf-8?B?TzJnc29NMG9qQWh3Rk9rUzVrRFRhUExzL05rVEViVWY2N1RSTXhsR053Q2ZY?=
 =?utf-8?B?MjdGOEF2M04vaThxcHNzNUpwNnBYS2djU1N3UXZSV2kydDhvNkFoV0E3ZStt?=
 =?utf-8?B?eVRrQUFvdWhESjB5M09waWJJbkgvZTNWKzdVTFhhbmY3MFVRcnNIVGh0eVkv?=
 =?utf-8?B?czR0M0xmNk9yVFF1S1FVT21TMS9ZQWtZaGpwWHhMVExkWk1NbEFzSW1VR0c1?=
 =?utf-8?B?dnRyc1dwMTYzcXlYUS9WWmxBNXJTSXNXL3lvWmlNcU5KUVZ4bWdGL2ZqOTFX?=
 =?utf-8?B?dWI2V2ExZW1GV0c3SGQ3U1A3R2RKR0t3dll0RG9LRkErV092QjQwY3hsU05V?=
 =?utf-8?B?QUdKQWRNRmZNdU9QeExnaitwU25lY29IZnR1TnBXSnpOVzdobmpqTHFkbUl2?=
 =?utf-8?B?TFpYVHBDVk1iYzJxQzlWb0ZWUDErclNqUE9jMkJ1bzNuVUtmWldNMEN0QUtH?=
 =?utf-8?B?eDUzR0QyU0RSWDRNVVU1YnJtWDVPMGcwMVI5eXRzSGRsUHp4SkNWakYvNWVC?=
 =?utf-8?Q?qPjg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4676a78c-caee-4c34-c6b7-08dbad4c91fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2023 13:40:58.0935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3s5X9Vt4A8A6GtAducF2NUIBhqS89EvDH76MYFSYgBi5ZLad5J/NVSGAnGdvOxSHkRq+VYLu2DhCdI+62gyNMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8322
Subject: RE: [virtio-dev] RE: RE: RE: RE: [PATCH v16] virtio-net: support
 device stats

DQoNCj4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gU2VudDog
TW9uZGF5LCBTZXB0ZW1iZXIgNCwgMjAyMyA2OjU4IFBNDQoNCj4gPiBTbyBjb3VudGVyIGxvb2tz
IG9rIHRvIG1lIHdoZW4gVklSVElPX05FVF9GX01UVSBpcyBub3QgbmVnb3RpYXRlZCBvcg0KPiA+
IHdoZW4gbXR1IG1hdGNoZXMuDQo+IA0KPiBJZiBzb21lb25lIG1pc2NvbmZpZ3VyZXMgdGhlIExB
TiB3aXRoIGRpZmZlcmVudCBkZXZpY2VzIHVzaW5nIGRpZmZlcmVudCBNVFUNCj4gdmFsdWVzIC4u
Li4gYWxsIGJldHMgYXJlIG9mZi4gT0sgd2UgY2FuIHB1dCBzb21ldGhpbmcgaW4gc3BlYyBlLmcu
IGZvciBkZWJ1Z2dpbmcNCj4gYnV0IHJlYWxseSBqdXN0IGRvbid0IGRvIHRoaXMuDQo+IA0KVHJ1
ZS4gV2hlbiBhbGwgdGhlIGVudGl0aWVzIGV4YWN0bHkga25vdyBldmVyeXRoaW5nLCBnc29fc2l6
ZSA8PSBtdHUgY2FuIGJlIG9taXR0ZWQuDQpXaGVuIHN1Y2ggdGhpbmdzIGFyZSB1bmtub3duIGl0
IGlzIG5lZWRlZC4NCg0KPiA+ID4gPg0KPiA+ID4gPiBFYWNoIHBhY2tldCBtdXN0IGJlIDE1MDAg
Zm9yIHRoZSBtdHUgbm9ybWF0aXZlIGFib3ZlLg0KPiA+ID4gPiBnc29fc2l6ZSB0byA8PSBtdHUg
KGluZ29yaW5nIHRoZSBoZHIgbWF0aCBmb3Igc2ltcGxpY2l0eSBmb3Igbm93KS4NCj4gPiA+ID4g
d2hvbGUgR1NPIGNvbXBsZXRpb24gY2FuIGJlIGZvciA2NEsgdG8gYmUgcmVwb3J0ZWQgaW4gdXNl
ZF9lbGVtLmxlbi4NCj4gPiA+ID4NCj4gPiA+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiA+IC0tLSBUbyB1
bnN1YnNjcmliZSwgZS1tYWlsOg0KPiA+ID4gPiB2aXJ0aW8tZGV2LXVuc3Vic2NyaWJlQGxpc3Rz
Lm9hc2lzLW9wZW4ub3JnDQo+ID4gPiA+IEZvciBhZGRpdGlvbmFsIGNvbW1hbmRzLCBlLW1haWw6
DQo+ID4gPiA+IHZpcnRpby1kZXYtaGVscEBsaXN0cy5vYXNpcy1vcGVuLm9yZw0KPiA+DQoNCg==

