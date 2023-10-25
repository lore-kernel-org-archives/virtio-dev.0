Return-Path: <virtio-dev-return-14023-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF03CC07545
	for <virtio-dev@archiver.kernel.org>; Wed, 25 Oct 2023 03:51:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 188F52AC57
	for <virtio-dev@archiver.kernel.org>; Wed, 25 Oct 2023 03:51:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 08BC29869F1
	for <virtio-dev@archiver.kernel.org>; Wed, 25 Oct 2023 03:51:52 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id F078D9869D6; Wed, 25 Oct 2023 03:51:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DA9EB9869D7;
	Wed, 25 Oct 2023 03:51:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z4P9htu1WTTpzsdQL8l5h8Yy+ut6pCYwKx8VuBANRF6WfKy+W0vOyx0NEs8PIrbph8/MAvC0HfbrvziR/XSIc/Tn0YYZ1c1eKh0JsvqEuszC3M+pAdQZccoYBpwhacCslQn6lDiHXBtICb64pxIIWQHBnEdQmIfc5MFn3KOHZqChNZNsfIvqWhiJQkYvbRJq69bx4FrhFlqEO7sSkZr6drsA2JhoPU/QZ5/x0QE8R5uDORwI7iHkVeN3tCqPNm7hilGyTTcbQdBMfglH4ctgFWd0ZSkh4TBo7q/CbIh0Hl9DbeHyE9/oYiyjZytTPksFsPLCmJVh7jgDUF34VUHuug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nzitWXmhiiXKSASiKQXoO24DsWi5TfmpPfJWss5NaX4=;
 b=QwQyIn2CwkhxzezBFihYM+u5iVqjybR+ON1RkBNd+7UF+r2G8QZ7v6bcK/tEz1tHoj3t+nUSsmL/zwqO/yh9qBKUFTksZOqiIFq3ZK2zCucW5Oyz4uSmUE/H//81tZhyxGrE64AUwOOX1e94lXxMKj/GUuroXaxvAfQErjMgUT0YHFM/auD+X9JVnOnZZIGjDOBDJnwu65toaNV0TwjOpDqhgO0goR90uD9lqDBS4n3Fqg5vYSvz98TzFJBBzEgOrOmKaqNYjxA7L2H4cIhCO+gI1XICF8l20unHro//dxtwrqWYlmUZsfNPqiwiEfPbuYrTZ+jtcAjdC1I3pRZWZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	David Airlie <airlied@redhat.com>, Gurchetan Singh
	<gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
	=?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Robert
 Beckett <bob.beckett@collabora.com>, Mikhail Golubev-Ciuchea
	<Mikhail.Golubev-Ciuchea@opensynergy.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Huang,
 Honglei1" <Honglei1.Huang@amd.com>, "Zhang, Julia" <Julia.Zhang@amd.com>,
	"Huang, Ray" <Ray.Huang@amd.com>
Thread-Topic: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES
Thread-Index:
 AQHaA9H0ua9xMq0gbkqU60djCdCUsrBW4XZQgABREYCAAC/xEIABYZmAgAADs4CAABezgIABBRDQ
Date: Wed, 25 Oct 2023 03:51:41 +0000
Message-ID:
 <PH0PR12MB5481A43D8E5A0F580B785E1EDCDEA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20231021035111.650248-1-Jiqian.Chen@amd.com>
 <20231021035111.650248-2-Jiqian.Chen@amd.com>
 <PH0PR12MB548182FF345FE7D1DE0D89C1DCD8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584997339FBFF8E8DF007755E7D8A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481DBD22233808AA9497ADBDCD8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584959DE2A88F4968ECC6740E7DFA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481BAA4566F77FBEA8B712CDCDFA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584921B4DFE8A074107904EEE7DFA@BL1PR12MB5849.namprd12.prod.outlook.com>
In-Reply-To:
 <BL1PR12MB584921B4DFE8A074107904EEE7DFA@BL1PR12MB5849.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SN7PR12MB8145:EE_
x-ms-office365-filtering-correlation-id: 4875ab9a-d46b-4d8c-03a4-08dbd50db2bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 A+KB4c89Poqt4Z3smne0sJDmQmGiRvY1kn0TnK8rbDjTS8KiU20L30Lmc5NxYhetZeOHchJ5tVZccH+dhGvhmtDHDM2kkB9qqkZzZglqgC205EyGXlYPQcyVdh6yzczdF77H2lVbDGjjetjn7VBhkEJ8/fMiooiaJ6BfFpwWPFL39Edd39WcwejxTvFMMf+MqN9VPI/Huu3RgHwjAUnaKSfP9jUvtaR6Rci3dR8vSPyRzoPu6eas821SNVtrJ0G/9oJC43dFvOzmYmwMYNNXcvEz9dkoYegm1ZxHIpKlZii30sGjkX/Pziu+3sJlA//NSO5i+MDR15kjY3bTqMeL/uOSEBOKp7Xvi+UdXinTK9TKh3qTTjVHAF3tv1IeTHpr533HxRWhqDDazrw5UR9RRcb8vtf3xfaq+nhgTN84HPrakFiYJJQs0JX+IIVwTPYlvRCt78eOY2i+XhCXsJHM+2XVHtYrtH/DLX0PJLr39QfhtW/4SNxXOSrRFLkrlJCVemaYF8o/DrjahC7VG/3ctjrkkp9uaJ/dpqucHeMfyvJmnZ8qW4yvL2EtgsbGuaGCn0Pw373bV8r1voaPmP2Yi1DHTNzZ9CRepXypl6CZ1VFHAdyJ+xDDB/MO1cUWQseC
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(55016003)(2906002)(38100700002)(6916009)(316002)(66446008)(66476007)(66556008)(64756008)(9686003)(478600001)(76116006)(6506007)(7696005)(54906003)(71200400001)(66946007)(26005)(53546011)(122000001)(83380400001)(41300700001)(7416002)(52536014)(5660300002)(86362001)(33656002)(8676002)(8936002)(4326008)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OUNNaE92MDZYVUY5azluTjJ3NkNmUmY2TElYa3JkQmFYYTBRN2U2aDdhK3Mv?=
 =?utf-8?B?OGh5YkhqNDd4Tk1pbHNyajVKYnQ3R0dpVzBRYkNMd0FoY3J5eGFZeWlPbzUv?=
 =?utf-8?B?U0o0NFNQNXE4enN6MVRMTHlTZVQ3cTM5VW9aM2x3YUZQUFZqWWVraUttUzdS?=
 =?utf-8?B?Q3NzSWRTN0RyVUkyUm0vMjBnZ1dDbWFWTGNqL3MwejBHNzF3cnZTaUtpVjV3?=
 =?utf-8?B?TDBzbjZWUVYxdzhYVnZsVXlBb1loNUlmRWY0aWNNSnduTUdOTEs4TG40Smts?=
 =?utf-8?B?a1hlU1A2U3U2Sm42NHdNNW5hTUFTbDZYR0pRdFFhT2lQRWhieENrUXBBYmNB?=
 =?utf-8?B?LzlZNStNVU9BVk1saGt0T1Q4QVlmV2hsdlF4b1VYSmwwc2l6bjgyVXJ2U2JC?=
 =?utf-8?B?WjBuUk1SdE9JQktHWmViQWQzTFlZek5hc3ZsakVwYjA3STVVSzMvUjNMMlo0?=
 =?utf-8?B?dkd1Um1QNFBaQ2dDd1VtNUN5OE0yMURiMzlWZEZqcUlNMUZmY3hQSGIxQk5D?=
 =?utf-8?B?NWhMKzBZNHJIaTJBN3RyMHQ5NWpmd3RYR0V1ai9CKy9tT05lek9xWXc1RGtB?=
 =?utf-8?B?MXZiTnFHSmd1bFVYUWd4Mi9ELyszTjhTOU5XdzltWHZ5OVcxK2RmYlhNakV1?=
 =?utf-8?B?dnNIc3RKQVo0UyszMDVISHJDcHlCWVVVeHJubVl6clJTZ0FHWm05Tmx2RWEv?=
 =?utf-8?B?dXdFcnFSeUYwcE9zYVFXS1dEZ3hpL3lMbHdEbUViZnRqcHowK2I5Nm1ES3Mr?=
 =?utf-8?B?RVZzR2hGWnROVGxucGNrU2JBOTlUSVBOWkhyendQM3ZFbitDWVpEc1BQWVRW?=
 =?utf-8?B?UmZIemdyR2tpZWNGWEYxWGY4NzRIV2doZHI4OFhPait3WithV1I1UG1mSnVK?=
 =?utf-8?B?aVp2Ny9EcmRmYU5IRzFTVWgwL2txaXYxOFpuVDNMT2o5dTBOUFFUb1ZmTVd5?=
 =?utf-8?B?T2FLeTk5SkgxWDlESXlnVXBUQ1ZZYmRxektvN1VBcnVieDd5ZGsrbzZOdlRq?=
 =?utf-8?B?ZlE2NXArbWFVd3VuVGNWVlo3VDlheXN4RkNoWSsyUVo0dW10ZHNFQyt2WG9x?=
 =?utf-8?B?V0ZBNktMUlBRZGl0S250d2lVY0x1bndMdUhuS25KTFBpcklzV1NxR2pHOE42?=
 =?utf-8?B?TUhGSW8wVTZhbnREOVlzVHpVdm9xZE9RMXp2Qm83Y3FJRHhranplcTA3QkNu?=
 =?utf-8?B?Q04wZHpSUEo3WSttcDBGQ1E5S1pIU2JkUjRwS0wva3pBelo3YmFUc3hMU2FY?=
 =?utf-8?B?WnVuUTYyYWVpY2JUQlMrTFY5V0ViQmZSa0FOUFdXZ3FtTnp6cW5ZeXZiZm9j?=
 =?utf-8?B?UDFzKythaHQwcjIxR200N3B4cHFTbVRGYXdFKzdsaStUL3VySzJ5eDg2RTVh?=
 =?utf-8?B?VFBnbTRHSjhqTEIrdk4wOGJKN29LbXlMbVlHdjNnZTk5ai8wTFhNczlTZTBZ?=
 =?utf-8?B?ZUhqLzIwZGxjUmF3K0l2ZURydzNIQXFyUm9VUG1YZnF2U0NkNmhvbHVMS1dx?=
 =?utf-8?B?TEFXNlpITVRlMjAyL2lJZ3pxZXArT1Fjc0xhaHkzUnhOb0R2czY5SUwycVJx?=
 =?utf-8?B?Ly8rTmU1OXRvQ3lGRDdPSmRvUGRSU0VGS09UVTBFSlEzZ1dJMVFtam05Y0s4?=
 =?utf-8?B?Q2hxeUR0RGxFb0pMRVYzS1BKSms1U2Z0L1lZSU5abCtEeEI3eW45NTJuUmVa?=
 =?utf-8?B?eVB0NWN3UmZnSCt6ejlPNGVTRVVtWTI2cjR1N0Y0ZWFIK3h5NTdycWhnbUhx?=
 =?utf-8?B?NnQ5a0IzQXhxZmdyWXJwc1pyOEttcnVVOWxiaXMvenJYcGJHQVFBcnNJMGky?=
 =?utf-8?B?YnNwNlh6TGtWY21xRmoyL1VUeDcvekNjWEM0TjUzTEpCYk91RGwrazlWRkVU?=
 =?utf-8?B?ZEdGcXFjdFk3V2gxcHpudVVsakRPaWQ0N0RtU25xWXkvUGR1SWo1ZFgwYXpK?=
 =?utf-8?B?T2krRTlNb05KNC9TZWZsQUJlRk9YN0JoYjZYbzEyVVJPUzJ0elJWWlZYTFFz?=
 =?utf-8?B?Z0ZtU2pFZkVUdW9pVDNIbkdtK1pVL09xODh0ak4vSGxkUlVDM0xUOVlRREtM?=
 =?utf-8?B?S1RoUVkwOGI2WVhka29KU0cxREhtUGpDVE41cmNlYjVzSk8vWVNWMDFkdG8r?=
 =?utf-8?Q?lEEU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4875ab9a-d46b-4d8c-03a4-08dbd50db2bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 03:51:41.2810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MD2mA3VJBqyZqWQuuCywAc0z1/L1gpDZm0A46pa1Jv8l2w5yLisyWfHvI3bxXnpO+yw2ymXsicrDn9eiLqz6QQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8145
Subject: [virtio-dev] RE: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES

DQoNCj4gRnJvbTogQ2hlbiwgSmlxaWFuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPg0KPiBTZW50OiBU
dWVzZGF5LCBPY3RvYmVyIDI0LCAyMDIzIDU6NDQgUE0NCj4gDQo+IE9uIDIwMjMvMTAvMjQgMTg6
NTEsIFBhcmF2IFBhbmRpdCB3cm90ZToNCj4gPg0KPiA+PiBGcm9tOiBDaGVuLCBKaXFpYW4gPEpp
cWlhbi5DaGVuQGFtZC5jb20+DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIE9jdG9iZXIgMjQsIDIwMjMg
NDowNiBQTQ0KPiA+Pg0KPiA+PiBPbiAyMDIzLzEwLzIzIDIxOjM1LCBQYXJhdiBQYW5kaXQgd3Jv
dGU6DQo+ID4+Pg0KPiA+Pj4+IEZyb206IENoZW4sIEppcWlhbiA8SmlxaWFuLkNoZW5AYW1kLmNv
bT4NCj4gPj4+PiBTZW50OiBNb25kYXksIE9jdG9iZXIgMjMsIDIwMjMgNDowOSBQTQ0KPiA+Pj4N
Cj4gPj4+Pj4gSSB0aGluayB0aGlzIGNhbiBiZSBkb25lIHdpdGhvdXQgaW50cm9kdWNpbmcgdGhl
IG5ldyByZWdpc3Rlci4NCj4gPj4+Pj4gQ2FuIHlvdSBwbGVhc2UgY2hlY2sgaWYgdGhlIFBNIHJl
Z2lzdGVyIGl0c2VsZiBjYW4gc2VydmUgdGhlDQo+ID4+Pj4+IHB1cnBvc2UgaW5zdGVhZA0KPiA+
Pj4+IG9mIG5ldyB2aXJ0aW8gbGV2ZWwgcmVnaXN0ZXI/DQo+ID4+Pj4gRG8geW91IG1lYW4gdGhl
IHN5c3RlbSBQTSByZWdpc3Rlcj8NCj4gPj4+IE5vLCB0aGUgZGV2aWNlJ3MgUE0gcmVnaXN0ZXIg
YXQgdHJhbnNwb3J0IGxldmVsLg0KPiA+PiBJIHRyaWVkIHRvIGZpbmQgdGhpcyByZWdpc3Rlcihw
Y2kgbGV2ZWwgb3IgdmlydGlvIHBjaSBsZXZlbCBvciB2aXJ0aW8NCj4gPj4gZHJpdmVyIGxldmVs
KSwgYnV0IEkgZGlkbid0IGZpbmQgaXQgaW4gTGludXgga2VybmVsIG9yIFFlbXUgY29kZXMuDQo+
ID4+IE1heSBJIGtub3cgd2hpY2ggcmVnaXN0ZXIgeW91IGFyZSByZWZlcnJpbmcgdG8gc3BlY2lm
aWNhbGx5PyBPciB3aGljaA0KPiA+PiBQTSBzdGF0ZSBiaXQgeW91IG1lbnRpb25lZCBiZWxvdz8N
Cj4gPj4NCj4gPiBQQ0kgc3BlYydzIFBDSSBQb3dlciBNYW5hZ2VtZW50IENhcGFiaWxpdHkgU3Ry
dWN0dXJlIGluIHNlY3Rpb24gNy41LjIuDQo+IFllcywgd2hhdCB5b3UgcG9pbnQgdG8gaXMgUE0g
Y2FwYWJpbGl0eSBmb3IgUENJZSBkZXZpY2UuDQo+IEJ1dCB0aGUgcHJvYmxlbSBpcyBzdGlsbCB0
aGF0IGluIFFlbXUgY29kZSwgaXQgd2lsbCBjaGVjayB0aGUNCj4gY29uZGl0aW9uKHBjaV9idXNf
aXNfZXhwcmVzcyBvciBwY2lfaXNfZXhwcmVzcykgb2YgYWxsIHZpcnRpby1wY2kgZGV2aWNlcyBp
bg0KPiBmdW5jdGlvbiB2aXJ0aW9fcGNpX3JlYWxpemUoKSwgaWYgdGhlIHZpcnRpbyBkZXZpY2Vz
IGFyZW4ndCBhIFBDSWUgZGV2aWNlLCBpdCB3aWxsIG5vdA0KPiBhZGQgUE0gY2FwYWJpbGl0eSBm
b3IgdGhlbS4NClBDSSBQTSBjYXBhYmlsaXR5IGlzIG11c3QgZm9yIFBDSWUgZGV2aWNlcy4gU28g
bWF5IGJlIFFFTVUgY29kZSBoYXMgcHV0IGl0IG9ubHkgdW5kZXIgaXNfcGNpZSBjaGVjay4NCkJ1
dCBpdCBjYW4gYmUgZG9uZSBvdXRzaWRlIG9mIHRoYXQgY2hlY2sgYXMgd2VsbCBiZWNhdXNlIHRo
aXMgY2FwYWJpbGl0eSBleGlzdHMgb24gUENJIHRvbyBmb3IgbG9uZyB0aW1lIGFuZCBpdCBpcyBi
YWNrd2FyZCBjb21wYXRpYmxlLg0KDQo+IEFuZCBhbm90aGVyIHByb2JsZW0gaXMgaG93IGFib3V0
IHRoZSBNTUlPIHRyYW5zcG9ydCBkZXZpY2VzPyBTaW5jZQ0KPiBwcmVzZXJ2ZSByZXNvdXJjZXMg
aXMgbmVlZCBmb3IgYWxsIHRyYW5zcG9ydCB0eXBlIGRldmljZXMuDQo+IA0KTU1JTyBsYWNrcyBz
dWNoIHJpY2ggUE0gZGVmaW5pdGlvbnMuIElmIGluIGZ1dHVyZSBNTUlPIHdhbnRzIHRvIHN1cHBv
cnQsIGl0IHdpbGwgYmUgZXh0ZW5kZWQgdG8gbWF0Y2ggdG8gb3RoZXIgdHJhbnNwb3J0cyBsaWtl
IFBDSS4NCg0KPiA+Pj4NCj4gPj4+PiBJIHRoaW5rIGl0IGlzIHVucmVhc29uYWJsZSB0byBsZXQg
dmlydGlvLSBkZXZpY2UgbGlzdGVuIHRoZSBQTQ0KPiA+Pj4+IHN0YXRlIG9mIEd1ZXN0IHN5c3Rl
bS4NCj4gPj4+IEd1ZXN0IGRyaXZlciBwZXJmb3JtcyBhbnkgd29yayBvbiB0aGUgZ3Vlc3Qgc3lz
dGVtcyBQTSBjYWxsYmFjaw0KPiA+Pj4gZXZlbnRzIGluDQo+ID4+IHRoZSB2aXJ0aW8gZHJpdmVy
Lg0KPiA+PiBJIGRpZG4ndCBmaW5kIGFueSBQTSBzdGF0ZSBjYWxsYmFjayBpbiB0aGUgdmlydGlv
IGRyaXZlci4NCj4gPj4NCj4gPiBUaGVyZSBhcmUgdmlydGlvX3N1c3BlbmQgYW5kIHZpcnRpb19y
ZXN1bWUgaW4gY2FzZSBvZiBMaW51eC4NCj4gSSB0aGluayB3aGF0IHlvdSBzYWlkIHZpcnRpb19z
dXNwZW5kL3Jlc3VtZSBpcyBmcmVlemUvcmVzdG9yZSBjYWxsYmFjayBmcm9tDQo+ICJzdHJ1Y3Qg
dmlydGlvX2RyaXZlciIgb3Igc3VzcGVuZC9yZXN1bWUgY2FsbGJhY2sgZnJvbSAic3RhdGljIGNv
bnN0IHN0cnVjdA0KPiBkZXZfcG1fb3BzIHZpcnRpb19wY2lfcG1fb3BzIi4NCj4gQW5kIHllcywg
SSBhZ3JlZSwgaWYgdmlydGlvIGRldmljZXMgaGF2ZSBQTSBjYXBhYmlsaXR5LCBtYXliZSB3ZSBj
YW4gc2V0IFBNIHN0YXRlDQo+IGluIHRob3NlIGNhbGxiYWNrIGZ1bmN0aW9ucy4NCj4gDQo+ID4N
Cj4gPj4+DQo+ID4+Pj4gSXQncyBtb3JlIHN1aXRhYmxlIHRoYXQgZWFjaCBkZXZpY2UgZ2V0cyBu
b3RpZmljYXRpb25zIGZyb20gZHJpdmVyLA0KPiA+Pj4+IGFuZCB0aGVuIGRvIHByZXNlcnZpbmcg
cmVzb3VyY2VzIG9wZXJhdGlvbi4NCj4gPj4+IEkgYWdyZWUgdGhhdCBlYWNoIGRldmljZSBnZXRz
IHRoZSBub3RpZmljYXRpb24gZnJvbSBkcml2ZXIuDQo+ID4+PiBUaGUgcXVlc3Rpb24gaXMsIHNo
b3VsZCBpdCBiZSB2aXJ0aW8gZHJpdmVyLCBvciBleGlzdGluZyBwY2kgZHJpdmVyDQo+ID4+PiB3
aGljaA0KPiA+PiB0cmFuc2l0aW9ucyB0aGUgc3RhdGUgZnJvbSBkMC0+ZDMgYW5kIGQzLT5kMCBp
cyBlbm91Z2guDQo+ID4+IEl0IHNlZW1zIHRoZXJlIGlzbid0IGV4aXN0aW5nIHBjaSBkcml2ZXIg
dG8gdHJhbnNpdGlvbnMgZDAgb3IgZDMNCj4gPj4gc3RhdGUuIENvdWxkIHlvdSBwbGVhc2UgdGVs
bCBtZSB3aGljaCBvbmUgaXQgaXMgc3BlY2lmaWNhbGx5PyBJIGFtIHZlcnkgd2lsbGluZyB0bw0K
PiBnaXZlIGEgdHJ5Lg0KPiA+Pg0KPiA+IFZpcnRpby1wY2kgbW9kZXJuIGRyaXZlciBvZiBMaW51
eCBzaG91bGQgYmUgYWJsZSB0by4NCj4gWWVzLCBJIGtub3csIGl0IGlzIHRoZSBWSVJUSU9fUENJ
X0ZMQUdfSU5JVF9QTV9CSVQuIEJ1dCBzdGlsbCB0aGUgdHdvIHByb2JsZW1zIEkNCj4gc2FpZCBh
Ym92ZS4NCj4NCkJvdGggY2FuIGJlIHJlc29sdmVkIHdpdGhvdXQgc3dpdGNoaW5nIHRvIHBjaWUu
DQogDQo+ID4NCj4gPj4+IENhbiB5b3UgcGxlYXNlIGNoZWNrIHRoYXQ/DQo+ID4+Pg0KPiA+Pj4+
Pj4gLS0tIGEvdHJhbnNwb3J0LXBjaS50ZXgNCj4gPj4+Pj4+ICsrKyBiL3RyYW5zcG9ydC1wY2ku
dGV4DQo+ID4+Pj4+PiBAQCAtMzI1LDYgKzMyNSw3IEBAIFxzdWJzdWJzZWN0aW9ue0NvbW1vbiBj
b25maWd1cmF0aW9uDQo+IHN0cnVjdHVyZQ0KPiA+Pj4+Pj4gbGF5b3V0fVxsYWJlbHtzZWM6Vmly
dGlvIFRyYW5zcG9ydA0KPiA+Pj4+Pj4gICAgICAgICAgLyogQWJvdXQgdGhlIGFkbWluaXN0cmF0
aW9uIHZpcnRxdWV1ZS4gKi8NCj4gPj4+Pj4+ICAgICAgICAgIGxlMTYgYWRtaW5fcXVldWVfaW5k
ZXg7ICAgICAgICAgLyogcmVhZC1vbmx5IGZvciBkcml2ZXIgKi8NCj4gPj4+Pj4+ICAgICAgICAg
IGxlMTYgYWRtaW5fcXVldWVfbnVtOyAgICAgICAgIC8qIHJlYWQtb25seSBmb3IgZHJpdmVyICov
DQo+ID4+Pj4+PiArICAgICAgICBsZTE2IHByZXNlcnZlX3Jlc291cmNlczsgICAgICAgIC8qIHJl
YWQtd3JpdGUgKi8NCj4gPj4+Pj4gUHJlc2VydmluZyB0aGVzZSByZXNvdXJjZXMgaW4gdGhlIGRl
dmljZSBpbXBsZW1lbnRhdGlvbiB0YWtlcw0KPiA+Pj4+PiBmaW5pdGUgYW1vdW50DQo+ID4+Pj4g
b2YgdGltZS4NCj4gPj4+Pj4gUG9zc2libHkgbW9yZSB0aGFuIDQwbnNlYyAodGltZSBvZiBQQ0ll
IHdyaXRlIFRMUCkuDQo+ID4+Pj4+IEhlbmNlIHRoaXMgcmVnaXN0ZXIgbXVzdCBiZSBhIHBvbGxp
bmcgcmVnaXN0ZXIgdG8gaW5kaWNhdGUgdGhhdA0KPiA+Pj4+IHByZXNlcnZhdGlvbl9kb25lLg0K
PiA+Pj4+PiBUaGlzIHdpbGwgdGVsbCB0aGUgZ3Vlc3Qgd2hlbiB0aGUgcHJlc2VydmF0aW9uIGlz
IGRvbmUsIGFuZCB3aGVuDQo+ID4+Pj4+IHJlc3RvcmF0aW9uIGlzDQo+ID4+Pj4gZG9uZSwgc28g
dGhhdCBpdCBjYW4gcmVzdW1lIHVwcGVyIGxheWVycy4NCj4gPj4+Pj4NCj4gPj4+Pj4gUGxlYXNl
IHJlZmVyIHRvIHF1ZXVlX3Jlc2V0IGRlZmluaXRpb24gdG8gbGVhcm4gbW9yZSBhYm91dCBzdWNo
DQo+ID4+Pj4+IHJlZ2lzdGVyDQo+ID4+Pj4gZGVmaW5pdGlvbi4NCj4gPj4+PiBUaGFua3MsIEkg
d2lsbCByZWZlciB0byAicXVldWVfcmVzZXQiLiBTbywgSSBuZWVkIHRocmVlIHZhbHVlcywNCj4g
Pj4+PiBkcml2ZXIgd3JpdGUgMSB0byBsZXQgZGV2aWNlIGRvIHByZXNlcnZpbmcgcmVzb3VyY2Vz
LCBkcml2ZXIgd3JpdGUNCj4gPj4+PiAyIHRvIGxldCBkZXZpY2UgZG8gcmVzdG9yaW5nIHJlc291
cmNlcywgZGV2aWNlIHdyaXRlIDAgdG8gdGVsbA0KPiA+Pj4+IGRyaXZlciB0aGF0IHByZXNlcnZp
bmcgb3IgcmVzdG9yaW5nIGRvbmUsIGFtIEkgcmlnaHQ/DQo+ID4+Pj4NCj4gPj4+IFJpZ2h0Lg0K
PiA+Pj4NCj4gPj4+IEFuZCBpZiB0aGUgZXhpc3RpbmcgcGNpZSBwbSBzdGF0ZSBiaXRzIGNhbiBk
bywgd2UgY2FuIGxldmVyYWdlIHRoYXQuDQo+ID4+PiBJZiBpdCBjYW5ub3QgYmUgdXNlZCwgbGV0
cyBhZGQgdGhhdCByZWFzb25pbmcgaW4gdGhlIGNvbW1pdCBsb2cgdG8NCj4gPj4+IGRlc2NyaWJl
IHRoaXMNCj4gPj4gcmVnaXN0ZXIuDQo+ID4+Pg0KPiA+Pj4+Pg0KPiA+Pj4+PiBMZXRzIHBsZWFz
ZSBtYWtlIHN1cmUgdGhhdCBQQ0llIFBNIGxldmVsIHJlZ2lzdGVycyBhcmUNCj4gPj4+Pj4gc3Vm
ZmljaWVudC9ub3Qtc3VmZmljaWVudA0KPiA+Pj4+IHRvIGRlY2lkZSB0aGUgYWRkaXRpb24gb2Yg
dGhpcyByZWdpc3Rlci4NCj4gPj4+PiBCdXQgaWYgdGhlIGRldmljZSBpcyBub3QgYSBQQ0llIGRl
dmljZSwgaXQgZG9lc24ndCBoYXZlIFBNDQo+ID4+Pj4gY2FwYWJpbGl0eSwgdGhlbiB0aGlzIHdp
bGwgbm90IHdvcmsuIEFjdHVhbGx5IGluIG15IGxvY2FsDQo+ID4+Pj4gZW52aXJvbm1lbnQsIHBj
aV9pc19leHByZXNzKCkgcmV0dXJuIGZhbHNlIGluIFFlbXUsIHRoZXkgYXJlIG5vdA0KPiA+Pj4+
IFBDSWUNCj4gPj4gZGV2aWNlLg0KPiA+Pj4gSXQgaXMgcmVhc29uYWJsZSB0byBhc2sgdG8gcGx1
ZyBpbiBhcyBQQ0llIGRldmljZSBpbiAyMDIzIHRvIGdldCBuZXcNCj4gPj4+IGZ1bmN0aW9uYWxp
dHkgdGhhdCB0b28geW91IG1lbnRpb25lZCBhIGdwdSBkZXZpY2UuIPCfmIoNCj4gPj4+IFdoaWNo
IGRvZXMgbm90IGhhdmUgdmVyeSBsb25nIGhpc3Rvcnkgb2YgYW55IGJhY2t3YXJkIGNvbXBhdGli
aWxpdHkuDQo+ID4+IERvIHlvdSBzdWdnZXN0IG1lIHRvIGFkZCBQTSBjYXBhYmlsaXR5IGZvciB2
aXJ0aW8tZ3B1IG9yIGNoYW5nZQ0KPiA+PiB2aXJ0aW8tZ3B1IHRvIGEgUENJZSBkZXZpY2U/DQo+
ID4+DQo+ID4gUENJIFBvd2VyIE1hbmFnZW1lbnQgQ2FwYWJpbGl0eSBTdHJ1Y3R1cmUgZG9lcyBu
b3Qgc2VlbSB0byBiZSBsaW1pdGVkIHRvDQo+IFBDSWUuDQo+IEkgYW0gbm90IHN1cmUsIGJ1dCBp
biBjdXJyZW50IFFlbXUgY29kZSwgSSBjYW4gc2VlIHRoZSBjaGVjayAicGNpX2lzX2V4cHJlc3Mi
DQo+IGZvciBhbGwgdmlydGlvLXBjaSBkZXZpY2VzLiBJZiB3ZSB3YW50IHRvIGFkZCBQTSBjYXBh
YmlsaXR5IGZvciB2aXJ0aW8tcGNpIGRldmljZXMsDQo+IHdlIG5lZWQgdG8gY2hhbmdlIHRoZW0g
dG8gUENJZSBkZXZpY2UgSSB0aGluay4NCj4gDQpUaGF0IGlzIG9uZSBvcHRpb24uDQpTZWNvbmQg
b3B0aW9uIHRvIGV4dGVuZCBQQ0kgUE0gY2FwIGZvciBub24gcGNpIGRldmljZSBiZWNhdXNlIGl0
IGlzIHN1cHBvcnRlZC4NCg0KPiA+DQo+IA0KPiAtLQ0KPiBCZXN0IHJlZ2FyZHMsDQo+IEppcWlh
biBDaGVuLg0K

