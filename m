Return-Path: <virtio-dev-return-11512-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97DC7C64EC4
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 12:03:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BA51C2AC4D
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 12:03:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B3CA798670D
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 12:03:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A6EC39866ED; Wed,  8 Mar 2023 12:03:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8DD3B9866EE;
	Wed,  8 Mar 2023 12:02:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgnenxVtrC4pK0MDevHMcpd/tITHk9p9RGTrkBbRyBk6nQtKtThtqqOzMcQ4grvGNRqnLm1nb38HqRydz3hp+P49IThyvW5iarEAiv1O9J8LBucKtnhp76cgHPemRWj+Hj2OA6WhMtRkZtNINWS6Z5W6JlcHWMwvJGY0Pww8YV37AQHmbKvrKselVwDOZ1K3Y4HAk7OfXILx+jMll0Mq9gt1DoAc2CRQDZGhTjX7vgNi50f0SQTT1ybekiiVl6javL1COwKYY4yu5ixLzWasH3fWurGE/47f8rmjpjvitmczdCGPuyPva/p7PSvMRSFuIhUVx/yFtwd5ntvdQkiZpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A34uDIuO8cLPpR5vyWBMDcH681KpKMRgJuFYDZOWmso=;
 b=iV+lEPbmrhIQTY5vamO7VxCd8P29VW01d5MTDPR+gVPD8s7DBMyViXdwsjOQxTN61kkqQh2W4q+A0FXhzD6JiEFoCDnSh6fNf9pNHB5LlJo/o+mfTTUFqJdRNkFDHT4mGH1yetegraEax4HjOntriroB9h2YMQhdv7aCiP4l70XNmnHFFDIx2Ql9vyiSMAc4gcRzaA8HtZplnR7FzU+VBYnUQ9rRdd1rqXl9pMqbwJGRClFiVvNUQBpRTYR2jhrHPcICpivps4WM7vgfneHQc42Olyrcz1NpCjRTjISd1IxnJep7DaQK4iWS9mPvzb5uIz2aYX+jX1/YZ2MgKGS3Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Jiri Pirko <jiri@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "sgarzare@redhat.com"
	<sgarzare@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>,
	"nrupal.jani@intel.com" <nrupal.jani@intel.com>, "Piotr.Uminski@intel.com"
	<Piotr.Uminski@intel.com>, "hang.yuan@intel.com" <hang.yuan@intel.com>,
	"virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan
	<lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf
 Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Thread-Topic: [virtio-comment] [PATCH v10 00/10] Introduce device group and
 device management
Thread-Index:
 AQHZTQeXLBm9R+Y8XE6rxgHYaBOlxa7ttIkAgACusoCAAI2yAIAApx+AgAAgzaCAAKYPAIAAcaqA
Date: Wed, 8 Mar 2023 12:02:52 +0000
Message-ID:
 <PH0PR12MB5481D9E60BAF797EC3B29C79DCB49@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1677761896.git.mst@redhat.com>
 <ZAXcqqdwfoLokT2l@nanopsycho> <20230306175020-mutt-send-email-mst@kernel.org>
 <ZAbmEmwsMMxKJqeB@nanopsycho> <20230307121529-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EEF6CD4B946233EE311FDCB79@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtxRWguwC0SgZ5wDDpcyw08r3GAD2=BP=Y88yMXZQ-FNQ@mail.gmail.com>
In-Reply-To:
 <CACGkMEtxRWguwC0SgZ5wDDpcyw08r3GAD2=BP=Y88yMXZQ-FNQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA1PR12MB6776:EE_
x-ms-office365-filtering-correlation-id: 02cd66df-4c0f-4a8f-b851-08db1fcd0b8a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1eJcXtLl3y6egzh9PhTuBxqCAtJN4zm08lFWoTO78ANX59ja4jrTuM7k5p6hlOk2k+3c7Kn3y8JKqUNWa2auhmEc88yaa872PK7AY79bd4GNz3LWYFP8HpqjB19O8WYGBL5Hgz118mPWb/JJ2G0yEORDPQ+6aVECPUFN1A0S7wG9j+cfDwIs5CMlkP9e43dHFDDUiYswqYLVS8MVZPLsZmX3004uZr9RL4h4oELoiLmo0ISyHd2cM8K3kjiuKyIZ8C80auR7QBNlMZ0va78oSiT7WKCVHTbT2EknpmSvp27WJe0iqc/RvibMJjJvmC68+BAlbb7xC1Nzyc+SZmg1LjHQDBuBSfCQlNWeysbOWGDaWg3lD/1VxCvJKpThJ+/4KVJZ32k4+MZA4miXkKzJo3rHZjwuiTIrCmftPtD0FKSeDZkw6RQKH+i1EMacI6I5JWAcD3CzZ0myUQ3boZkp+NpYxnIZKAMT/Nwm8DjN7+HJLMgXALnA8SuoCqWra7CZUJ+ZCsN0hIXrN7MTzbNg8BLr1TTERVsyDIibcWii81c2N0kLs8WOAKhRLozh/06PJRW+WbHYC5/QzUll3o55Jtths8BIyGZE0DpFcdD2BWq+hFk30JRKkm7JceO0SJ09+lP4Aw7Xy1EPkzT1je/LLfhQc0omF7bnGnseiuO9iId1YXZFP76Cz6VctI496gKRZYnxtXv3siZSkZGjUsDsHA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(451199018)(38100700002)(122000001)(33656002)(86362001)(64756008)(38070700005)(8936002)(66476007)(4326008)(7416002)(8676002)(5660300002)(2906002)(76116006)(41300700001)(6916009)(66446008)(66946007)(66556008)(52536014)(55016003)(186003)(26005)(9686003)(83380400001)(6506007)(107886003)(478600001)(54906003)(71200400001)(7696005)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UXMraWFoREg3N05Xd0ZaS2hZZWlLL09Ma2M5eU9xM0IxNXZ0aUNIN3lrenFO?=
 =?utf-8?B?RmczeVVpNjEwWG1UTjl2alFaU2FoZkUwbzQ2SllESDZ3Q0RxSll3Qkw3L1FD?=
 =?utf-8?B?QUUreUpYL2hKYnc3bnlwYVFPSDBWL1k0VlpaMmFWQW15a1pSLzNWTWNzSWQ0?=
 =?utf-8?B?c3FtZ2xEVnI5VjNKOWVwU1A4dGdMTG9wWWNvSFZ6VWdxUHFIODRlQVRSMDdh?=
 =?utf-8?B?SDFuN0t2cUhmSGlRcEZLZEYyMExLQUxndzdkYWwzMGVxdG9yNEJZaVlLa0Zz?=
 =?utf-8?B?SzhwdEFZdDJHZk1mMjk5cTN4akJJY1dKU2s0aDJKV00wY3RnMlJQQjRYVW5k?=
 =?utf-8?B?ZE9vemJCRmZTeStNcmQ1TFd0L1RyWEpGb09WQllwb1dXaTFpSzdBU3hmalZN?=
 =?utf-8?B?aCtQS0xaRkd6K1V4L3ZTaWVUdGdqcnZMVmduU0tzc3ZxZE1LR2lHWWlESEd3?=
 =?utf-8?B?VVRiVGlnSVNnS096TnRFVDQ0YzhoVDdLVUVJRDJwdXh0cy9WTS8vaWdKTjB1?=
 =?utf-8?B?aVI2enBJUXVNZC9pMkV6K2VmVmNoU0JIUTBmc3hwcUswME5NVEhOaW92RUpI?=
 =?utf-8?B?dkVQcHlhYzM5dkpvVC9KTkZNS0xVMTUwdHVwYnJjdmFEbTMzUHp5TCtoNGRD?=
 =?utf-8?B?a1JBVHkwM0x3SVArMmtUSlV0VlpRSTdKWGI4TE5uY3FyS24ya2NSSENXcFlY?=
 =?utf-8?B?a25vK24vQ1dXWUdwcGZXSFgxV0dwNkJSNytaUDBlVFhBNmJsMFFKbEU5NGtY?=
 =?utf-8?B?b1ZqYlNyMXhDUkR4N1BvYUpXN1NHeVJqNk5GNFl6dThMVnZsUzVLaHFoMDFz?=
 =?utf-8?B?M1FnaHI1TzJZOVFnR1pWYTJkWmoyS21Dei9UQjJVeE0ybUV1WEdrK1VGc3dT?=
 =?utf-8?B?eVcxNkkwd0hoSjFRcndrakFuRnBweGs2UTJKaU82UFpFU2N5eDI4bjRXTHNZ?=
 =?utf-8?B?T0dma1BNRWp4d2dvMGttZm9zdHBsaE8vSXhQcTc4ZXp0ZXlLUkJhUlZ0cCtG?=
 =?utf-8?B?V0NNZ1JnOFlkSjNQUUcrUExDNGJsOVVBK3V0b1lHNDl2T0dlaTNhb3ZrVnB5?=
 =?utf-8?B?MHMzKzFacjNrMGw3b3VmK1d1dXZVL1NwZEJRV1NlWUVpc0xlaEJVQmQ4N3NE?=
 =?utf-8?B?dXNFelRsZjRvVTlDbmtnSzhhS3ZkamZDOW5ubDlyNklLKzF3TnIzMjlDQndm?=
 =?utf-8?B?WHhyYnNtNDRNTmgwQjlIOTQ0dDQwYUlhKzIwQ1h4MnVBQ0lMTDV5VG5CdmMy?=
 =?utf-8?B?N1JEa3BteEhLMnJ1VmovZ3drZ0Q0ZDhXbFFUZ3BRTmJWNWJHMEJFR3lZZ3h2?=
 =?utf-8?B?akhwRDFudGxCdXJzNGl2eUc1M0ZkVXZQM0NwazgyaXJvei9rd3JacW00dGtz?=
 =?utf-8?B?R1M3ZUZ2RkEwQ1BrNzUraEFRWk5paXhFOHR0RzBzK1dqRnlMeXg2d0JqTkpM?=
 =?utf-8?B?MWxFV0FrN1VySkNrYTlJcnRpVUNpYWM3UXpXa2ZNbnhodVpmVGQreEtMdWRt?=
 =?utf-8?B?SGZIZk9jcCtLVGpLc3NmTVFScGtrbXVxajVFZVJDaFFEa2I0Y3JUSUxzblRX?=
 =?utf-8?B?MndVeUp6UU1oRmlGOXpaK2lpb3crMDdBSVlsYlFMQzY1WS8wWFNTclFqOUlF?=
 =?utf-8?B?OWtlTm1hTmNKUG5qb25HV1JTMzhCWUtNeUtzTUdrN2NaQkxIb1lVMVpHengz?=
 =?utf-8?B?UkpzNUhmak5vUkZXQnNORW9rOTR6MnJXRVNhanVDYWhFc2lwMXV3Q05mVzNp?=
 =?utf-8?B?SE9oU3h5OTNYSVMwTytkd2hKVDMyTzZ5NHRVRlpySlQyOFI4NUxZRnhzakdT?=
 =?utf-8?B?RFM4Y3ArcmVpUjBUNHc4VWtkTjN4NFo0NnF1WGkxVERSMUd5WHlwU0xwbjhz?=
 =?utf-8?B?SFZ3ekozSGhhdTNGQ1pBRFBmeVcxaDlTYVNlR1JsaElHOWt2WjBjdklYcjVi?=
 =?utf-8?B?c2Q3U0p0NlUrK0dOV2VlSXVWZ0VHZW9WZHdEVXFmcE1zNnc2TzhwTkZqL3cw?=
 =?utf-8?B?MkZGZGRWV3dHeE1Gd1hpY2FyRkVHMlV0QzBrUGc2QzFhcGtnMW8vbDJVRitj?=
 =?utf-8?B?SG1RRFJxUEdzQVdRampoU2Q0U0JGRVl0L1p5bkNvR0VrVGJSakRpbXhybVY5?=
 =?utf-8?Q?rn9k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02cd66df-4c0f-4a8f-b851-08db1fcd0b8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 12:02:52.5141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0X+jPwuvLR833vcEvCH8ru7soJdeTAFW42WiHZqwU37TWyD/93tdKoymzVQv1e34UNv72JAzcozaqQwyygFUJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6776
Subject: [virtio-dev] RE: [virtio-comment] [PATCH v10 00/10] Introduce device group and
 device management

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogV2Vk
bmVzZGF5LCBNYXJjaCA4LCAyMDIzIDEyOjEyIEFNDQo+ID4gSW4gb3RoZXIgd29yZHMsIGNhbiBB
USBjb21tYW5kIGJlIHVzZWZ1bCB0b21vcnJvdyBmb3IgZG9pbmcgU0lPViBkZXZpY2UNCg0KDQo+
IGFkZC9yZW1vdmUsIGFuZCBwcm92aXNpb25pbmcgZnJvbSBub24tb3duaW5nIFBGPw0KPiA+IFRo
ZSB3YXkgQVEgaXMgY3JhZnRlZCB0b2RheSBpcyBub3QgdGhlcmUgeWV0LCBidXQgaW4gdGhlIGZ1
dHVyZSwgaXQgY2FuIGJlDQo+IGV4dGVuZGVkLg0KPiANCj4gVGhlcmUncyBhbHJlYWR5IGEgcHJv
cG9zYWwgdG8gdXNlIHRoZSBxdWV1ZSBhcyBhIHRyYW5zcG9ydC4gQW55IGRldmljZSB0aGF0DQo+
IGNhbid0IHVzZSBhIHRyYW5zcG9ydCBzcGVjaWZpYyBjb25maWd1cmF0aW9uIG9yIHByb3Zpc2lv
bmluZyBjYW4gYmVuZWZpdCBmcm9tDQo+IHRoYXQuIFNJT1YgaXMgb25seSBvbmUgb2YgdGhlIHVz
ZXJzIGZvciB0aGF0Lg0KPg0Kby5rLiBCZXR0ZXIgdG8gaW5jbHVkZSB0aGF0IGxpbmsgaW4gdGhl
IGNvdmVyIGxldHRlci4NCiANCj4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+ID5UaGVyZSBpcyBpbnRl
cmVzdCBpbiB0aGUgY29tbXVuaXR5IHRvIGluY2x1ZGUgYW4gaW50ZXJmYWNlIHRvDQo+ID4gPiA+
ID5hbGxvdyB0aGlzIGluIHRoZSB2aXJ0aW8gc3BlYywgd2hlbiB0aGUgUEYgaXMgYSB2aXJ0aW8g
ZGV2aWNlLg0KPiA+ID4gPiA+VGhpcyBpcyB3aGF0IHRoaXMgcGF0Y2ggZG9lcy4NCj4gPiA+ID4N
Cj4gPiA+ID4gWWVhaCwgYnV0IHdoeT8gQXMgSSBhc2tlZCBiZWZvcmUsIHdoYXQgYXJlIHRoZSB1
c2VjYXNlcz8gVGhlIGZhY3QNCj4gPiA+ID4gdGhlcmUgaXMgaW50ZXJlc3QgaW4gdGhlIGNvbW11
bml0eSBkb2VzIG5vdCBtZWFuIGl0IG1ha2VzIHNlbnNlIHRvDQo+ID4gPiA+IGhhdmUgaXQgOikN
Cj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBJZiBwZW9wbGUgd2FudCB0byBidWlsZCBzdWNoIGhhcmR3
YXJlIGl0IHdpbGwgbmVlZCBzb21lIGludGVyZmFjZS4NCj4gPiA+IEZhciBiZXR0ZXIgdG8gaGF2
ZSBpdCBzdGFuZGFyZC4NCj4gPiA+DQo+ID4gPg0KPiA+ID4gQnV0IGdlbmVyYWxseSBlLmcuIGlu
dGVsIGFscmVhZHkgc2FpZCB0aGV5IHdpbGwgcmV1c2UgdGhpcyBzYW1lDQo+ID4gPiBzdHJ1Y3R1
cmUgd2l0aCBhIGRpZmZlcmVudCBncm91cCB0eXBlIGZvciBTSU9WIHN1cHBvcnQuDQo+ID4gPiBJ
J2xsIG1lbnRpb24gdGhpcyBpbiB0aGUgY292ZXIgbGV0dGVyLg0KPiA+ID4NCj4gPg0KPiA+IFdl
IGhhdmUgdGhlIGZvbGxvd2luZyBhbHJlYWR5IGlkZW50aWZpZWQgdXNlIGNhc2VzIG9mIGEgZGV2
aWNlIGFnbm9zdGljIFZRLg0KPiA+DQo+ID4gMS4gU1ItSU9WIFZGIGRldmljZSBwcm92aXNpb25p
bmcgYXQgdmlydGlvIGxheWVyIChmZWF0dXJlcyBhbmQgY29uZmlnKQ0KPiA+IDIuIFNSIElPViAo
U1ItUENJTSBpbnRlcmZhY2Ugb2YgdGhlIFBDSSBzcGVjKSBmb3IgVkYgcHJvdmlzaW9uaW5nLCBm
b3INCj4gPiBleGFtcGxlLCBNU0ktWCB2ZWN0b3JzDQo+ID4NCj4gDQo+IFRoZSB2aXJ0aW8gbGF5
ZXIgZGV2aWNlIHByb3Zpc2lvbmluZyBpcyB0cmFuc3BvcnQgaW5kZXBlbmRlbnQuIA0KWWVzLiBJ
IGxpc3RlZCBrbm93biB1c2UgY2FzZXMgYWJvdmUuIElmIHRoZXJlIGFyZSBtb3JlIHRoYXQgY2Fu
IHVzZSwgc3VyZS4NCg0KPiBJIGRvbid0IHNlZQ0KPiBhbnl0aGluZyB0aGF0IGlzIFBDSSBzcGVj
aWZpYyB0aGVyZS4gRXZlbiB0aGUgTVNJLVggY291bGQgYmUgcmV1c2VkIGJ5IG90aGVyDQo+IHRy
YW5zcG9ydC4NCj4NCk1heWJlIHllcy4NCkkganVzdCBkb27igJl0IGtub3cgd2hpY2ggb3RoZXIg
dHJhbnNwb3J0IG9mIHZpcnRpbyBoYXMgZGVmaW5lZCBNU0ktWC4NCklmIHRoZXJlIGlzLCBzdXJl
IHRoZXJlIGFyZSBtb3JlIHVzZXJzIG9mIEFRLg0KIA0KPiA+IDMuIFNSLUlPViBWRiBMaXZlIG1p
Z3JhdGlvbg0KPiANCj4gSSB0aGluayB3ZSBkb24ndCB3YW50IGEgcGFydGlhbCBzb2x1dGlvbiBm
b3IgbGl2ZSBtaWdyYXRpb24gdGhhdCBvbmx5IHdvcmtzIGZvciBQQ0kNCj4gVkYgZGV2aWNlcyBh
bmQgTDEuIEluc3RlYWQsIHRoZXJlIG5lZWRzIHRvIGJlIGEgZ2VuZXJhbCBkZXZpY2UgZmFjaWxp
dHkgc2VjdGlvbg0KPiBhbmQgdGhlIGFkbWluIHZpcnRxdWV1ZSBjb3VsZCBiZSBvbmUgb2YgdGhl
IGludGVyZmFjZXMgZm9yIHRoZSBkcml2ZXIgdG8gdXNlIHRoZQ0KPiBmYWNpbGl0eS4NCj4gDQpN
YXkgYmUgdGhlcmUgYXJlIG1vcmUgdXNlIGNhc2VzIG9mIEFRIHRoYW4gd2hhdCBJIGxpc3RlZC4N
Cg0KPiA+IDQuIEFib3ZlICMxIHRvICMzIGZvciBTSU9WIGRldmljZXMgaW5zdGVhZCBvZiBTUklP
ViBkZXZpY2VzDQo+IA0KPiBJZiB3ZSBtYWtlIHRoZSBhYm92ZSBhcyBhIGdlbmVyYWwgZmFjaWxp
dHksIGl0IHdvdWxkIG5vdCBiZSBoYXJkIHRvIHJlLXVzZSB0aGVtDQo+IGZvciB0cmFuc3BvcnQg
dmlydHF1ZXVlIG9yIFNJT1YuDQo+DQpPay4gdGhhbmtzLg0K

