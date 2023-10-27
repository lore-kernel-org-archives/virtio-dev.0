Return-Path: <virtio-dev-return-14026-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67670C25B6B
	for <virtio-dev@archiver.kernel.org>; Fri, 27 Oct 2023 03:03:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BDAF333585
	for <virtio-dev@archiver.kernel.org>; Fri, 27 Oct 2023 03:03:35 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AA8C6986A91
	for <virtio-dev@archiver.kernel.org>; Fri, 27 Oct 2023 03:03:35 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9C17A986A81; Fri, 27 Oct 2023 03:03:35 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 85CE9986A82;
	Fri, 27 Oct 2023 03:03:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsPbzp1hL+DfGSGdUcxWBOVdhwRD8OBzmN63mWFt4CZWU3cFIcNA/z6X+pVQDcWzO7WFLslT+TF/kwDImYzFT6gONIvLtRRuh/i/nTa4FEqQ8pQQH7rRkqcDS5KDEZPZxxct7YbB+L6Hhn+8LPa6vlYF/gH5iS39nO8CEawz4VcpdVMiDRGxN9UNj5J8KlLtWFdjRq6yfUJWzt+NgGMcfdZq4JE34FjNNqwSzyDQMlygnkzGFLZ5mSthsERSsKp0/f5uNlpelGI3vOl/oh/wThX8ktVQ+u/bF9RxYA5MON/V5KC7dX+ufiALl2sD31EEBmskwTtN8BMz3E+qn2nA2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiWlLM15eLlOmMbiMIfmtthcWYkYzNXP3miypxmQj/s=;
 b=fFtFuaklWbf4eHo+UuSYUdUcqvWe/6wE7ysSCaiBGBelrbYWsNckZAEmA56okCCL8eKpZoouKdmxZSKmzI5TlQQONSTO7WGTPVZ3XoeNUlqNVIfjBHnaAeQEy/2LMSXZ3GenvD7QjRb3nKjfACDdMGP8D2a9SO3OW89SVNyf/3BIWd+dzJd12sqWY0atN0BXIaR/eokv/lLe4FNjzVEQ8h6J70VSG6mHv/P6SKW2YAEF8zWS/HdQUkwivTPJiMdufqdLXyzWE/ZI9YPsZtTe9HO8+CThPq7XihnKSLV6t9JFAnl7cyrsucshEhuPr+pxvFN6mJt/npTyiRxRAX1VyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
CC: Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan
 Zhuo <xuanzhuo@linux.alibaba.com>, David Airlie <airlied@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
	=?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Robert
 Beckett <bob.beckett@collabora.com>, Mikhail Golubev-Ciuchea
	<Mikhail.Golubev-Ciuchea@opensynergy.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Huang,
 Honglei1" <Honglei1.Huang@amd.com>, "Zhang, Julia" <Julia.Zhang@amd.com>,
	"Huang, Ray" <Ray.Huang@amd.com>, "Chen, Jiqian" <Jiqian.Chen@amd.com>
Thread-Topic: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES
Thread-Index:
 AQHaA9HvmHelxVzMEkK9DIiJvUqDjbBW5OUAgAC5UoD//8WsgIAB4oYA//+CG4CAAI+hgIAAjVeAgAJwQAD//5FqAAAzXyGA
Date: Fri, 27 Oct 2023 03:03:21 +0000
Message-ID:
 <BL1PR12MB5849D7936DD77FECD1FE971EE7DCA@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20231021035111.650248-1-Jiqian.Chen@amd.com>
 <20231021035111.650248-2-Jiqian.Chen@amd.com>
 <PH0PR12MB548182FF345FE7D1DE0D89C1DCD8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584997339FBFF8E8DF007755E7D8A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481DBD22233808AA9497ADBDCD8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584959DE2A88F4968ECC6740E7DFA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481BAA4566F77FBEA8B712CDCDFA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584921B4DFE8A074107904EEE7DFA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481A43D8E5A0F580B785E1EDCDEA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB58498946F163AFE8AFE7DF94E7DDA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <20231026062805-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231026062805-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: BL1PR12MB5849.namprd12.prod.outlook.com
 (15.20.6933.019)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|CH3PR12MB8259:EE_
x-ms-office365-filtering-correlation-id: 2d85c26d-1ea2-4f3d-81e4-08dbd6994773
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 iKgGYRbDB9OyWttSiQ9NxBcjF8Pm4X8POwhRcdNMrk96LppkvkG2iF0SGetYU8d3HKu/WxHDrrPBa6LyR+aV8l7U0EBIQINJHlqTokv4+ebdj+ACBet0c2aTOxCeHAGS4HBKhhoDwr2MZSBXAzSabcojVQUf4rWy1gKzXHCZv40glr+SUxz+o5G1yw8Ls8vHlCQSaGoDistR89TGdjZwQNMe5pQuX8I1TWNjxtlHo6KP1H+WDiuJeRlrIiLXMwzy/Q/xXL6bnR7jhNJJKMGoH8MisOuNzl7V+qPJtqGcCienHi1cr9xfVhfa6GdJVlEInKESDdMev7idkfUQKLUZCplqCWGxBRSTbCOmInuT5XOdtPYmRcbL6QMgFTawbBrXJvA0bZWWPYq5HAdPTQ6VE5JULc+le+nnw41HKHNSqXhp7dWWjOfqBAs0nrOvC/gkZ4FpLHpGkBS6Gi/7sjzmOjIak9VqXj9et8/oFo6Z3LAPjaP7G9Hgtc3GRrJZWkLGKf7qu5dvXVlClnIIEBF+py+9oTnI0jtchhybw2VbqGY8bLpVExHYbhJ1AyFO+1wGpa0dtAFLUq/IR/US3a3XpH+QsVh+227ayWPEKab6QyZQDz8P0eiugMLtiWxb/wwC
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(136003)(376002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(38070700009)(26005)(38100700002)(2906002)(55016003)(33656002)(52536014)(7416002)(5660300002)(4326008)(8936002)(8676002)(110136005)(71200400001)(6506007)(53546011)(7696005)(122000001)(478600001)(54906003)(66446008)(66476007)(316002)(76116006)(66556008)(66946007)(83380400001)(9686003)(64756008)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U3BGYWdIbENxN0dqenkycDdKclZwRlFWZFJsVXAxc0t0ZTNZbDRtQkxzbVFO?=
 =?utf-8?B?RmdsUnhHRThTZjNmYWlhVEg4NW9jQStKSk1FTWF0NlZnWWQwMFBkZENqcTZR?=
 =?utf-8?B?VG9nN1ZZNkJYcGM2a2x6VklNVFhqakN0OHd6ekI3WTlWK1F0ZmNmelFhVUdC?=
 =?utf-8?B?R001YWtZUmpjNHhrQkg1RU5MYmppeGdtR2NtYlByYitCWU05SEhxcnUrR29z?=
 =?utf-8?B?azE1OEtVNzJqeXk0bXMvNERBdUZGZGozZ1N4bFlMMXR0RnhMM283SHhXMTRK?=
 =?utf-8?B?d0M5b3NGNXRqdzlhWFVrdVlYRmx2anljRVlkL2gwZlltcHFJWUJWK1IyQnNF?=
 =?utf-8?B?VmpOT1BhTkZFTkh4RXFoS1Uvb3IrZ3JVQ3pXQjB2WnkrSldTMFU0a1ZJTnNX?=
 =?utf-8?B?eVhmYlc2U3lXYzZ3NURBNDdVZ0EyUVdvM1BiOE1MWnhCeG9ZUm43d081SEZQ?=
 =?utf-8?B?aUN0c1RKd0tOc0dkRzMzRTFubjk4MTY5b2tlMTFBSzBNSVVyY2hHSUpxS3ha?=
 =?utf-8?B?bXNPa1RkaU1IaDlycHJRUW4ydGxTUTN6SHoxalRoVENwdVVFTFRnUDlPUXEr?=
 =?utf-8?B?K0NRZUlXcGxFbUd5bFl5UDluZVZtWGp1dkVockF0T2RHckNPYzY2MVphZUlq?=
 =?utf-8?B?bXBLYVJtVUVQU2NTV05KSFh3V1JQRjhLRTZ6dFVyVXVUVnFvWmsrd25hRS96?=
 =?utf-8?B?SGoxcEF2YjBDOFNoNWpYUndNb1VUdUJ1NkU3VzFLQnA3bjN5WkpIYnJmUzFw?=
 =?utf-8?B?a0NLV1pCanZGNDlyNDF5SzVOSjQyWHkwQVloWVBsR0FITXZKZGhWN0cvSXJN?=
 =?utf-8?B?SXlSUEZ1SUhkUnVaam1kRng2akliOTVnc2JhV1ljV3VKbUl2U0VYbVVpZGtx?=
 =?utf-8?B?SDhNN0F5c3puK3pHbXhIZ1R2dDhzRE4xMWpIYytETHZHMmdJSDhkSWFPWkJs?=
 =?utf-8?B?aGNaRHFYTmJBc05WRGpyd1NYUDNidnJyb3dlOTNUeTg2MEFvNU9vMWZlMnp0?=
 =?utf-8?B?azBoZXZZOFlLMHcvZWJrQ2FkZktiTG81L0tDUW9pODlaa2tqZHdRc2xrQTVL?=
 =?utf-8?B?M1MwWEhNL3VEUU5hSyt6ODRheEp4ZXMrU2VJelRoekVzL3lWaHNSNlRmTzJz?=
 =?utf-8?B?R2pzOENNam9GNXFYN2J3T3JUY09sWC96MnhOYUdqQ0tzTUJyai82RUNkcTFz?=
 =?utf-8?B?NTNpVmRjdU5Td1paV0QwMmM4MlQ5aDlDWmNTMWMwR2VWWFFNNUhRSmFKMjE0?=
 =?utf-8?B?UkpJc0VQZ1RMT0xvZkJ6NGpjbFBFd0xsd0xXNjJqZExuWlE5NFMwK3VzSEJR?=
 =?utf-8?B?Njlua0JtY251SitXZ056QitpbkMyTXpMbHVETUJ4K0FIZkZuUi91NTRKY2Rv?=
 =?utf-8?B?eTNKMUZUYWExMDlyM2xvUUsrSHVlUXVNb3B0MEcydHN4WUMvK3k3K3JiUlhT?=
 =?utf-8?B?NDBhanJmSUhFdzNOcjAzZTROc1lscU5neHVQS29HYVNjL1ZYMlpGUW14NXhu?=
 =?utf-8?B?NWNHd1VLMEt4RnJ1MzdGVjh3Si9ZOTJadlA1RGwveklleVoyTzNKQmx1MU9s?=
 =?utf-8?B?NXZOamlrSXFwSVN6eUVuN0M1Y1VWWmFYZ2ZjSmJIMk8veVgxRWZsd2JJSFo3?=
 =?utf-8?B?SmtUUWVac3lSMHhtSDlMeExSdDRZZnprWWF0Rnk1a0FobjdrUVMxOEx6SGJP?=
 =?utf-8?B?a2FDUGd6dDBEUFJSN08yZzZHK0RRKy9hUTVnb1NNQzJSV1Evd2JMaEJsS3NR?=
 =?utf-8?B?SDY4M0dLV3JCRmlvMno1UEpPTkcxeUhCMkU0aGV2SjAxR0hlcWVqamkxM1JF?=
 =?utf-8?B?QmtGcnU2TjZjK0kwTjZCSE5uY0V6RjZGelVGT0UzMFNzTHRKQmJKSXBudzVn?=
 =?utf-8?B?U3RVNlRuRHAzZEhvTWR6UlVzNlBBTHJIRGh6cXI1cGQ1dStGMVNTNW1wbUJo?=
 =?utf-8?B?UUo1QkFUcTc0QUllZVAxblp3M1ZhU0tORG1WRURIRGVRLytWMzM5b2NEUmZM?=
 =?utf-8?B?MHBuenBDQ2h6OFVUR2dPK1M2cXRqREh4QkRZOWdteVdESFIwZnIzTnl0YTE1?=
 =?utf-8?B?ektpSmJNZFBRRXlGVDRjMlZiT2pSQTlnTjZsK3REeDlSc0VZZ1BJWkIyTThO?=
 =?utf-8?Q?VIQo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <483D9F31D7A1AF46AC12C3790F91492D@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d85c26d-1ea2-4f3d-81e4-08dbd6994773
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 03:03:21.9580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 98Zo+QdmPnfErcrRUetrIsLetaS+6clXNTmDfpON8wev+6XWv+D4zR+y5f0QFvDjWY85RZSXJYeNCjvcoM/r7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8259
Subject: [virtio-dev] Re: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES

SGkgTWljaGFlbCBTLiBUc2lya2luIGFuZCBQYXJhdiBQYW5kaXQsDQpUaGFuayB5b3UgZm9yIHlv
dXIgZGV0YWlsZWQgZXhwbGFuYXRpb24uIEkgd2lsbCB0cnkgdG8gdXNlIFBNIGNhcCB0byBmaXgg
dGhpcyBpc3N1ZS4NCg0KT24gMjAyMy8xMC8yNiAxODozMCwgTWljaGFlbCBTLiBUc2lya2luIHdy
b3RlOg0KPiBPbiBUaHUsIE9jdCAyNiwgMjAyMyBhdCAxMDoyNDoyNkFNICswMDAwLCBDaGVuLCBK
aXFpYW4gd3JvdGU6DQo+Pg0KPj4gT24gMjAyMy8xMC8yNSAxMTo1MSwgUGFyYXYgUGFuZGl0IHdy
b3RlOg0KPj4+DQo+Pj4NCj4+Pj4gRnJvbTogQ2hlbiwgSmlxaWFuIDxKaXFpYW4uQ2hlbkBhbWQu
Y29tPg0KPj4+PiBTZW50OiBUdWVzZGF5LCBPY3RvYmVyIDI0LCAyMDIzIDU6NDQgUE0NCj4+Pj4N
Cj4+Pj4gT24gMjAyMy8xMC8yNCAxODo1MSwgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPj4+Pj4NCj4+
Pj4+PiBGcm9tOiBDaGVuLCBKaXFpYW4gPEppcWlhbi5DaGVuQGFtZC5jb20+DQo+Pj4+Pj4gU2Vu
dDogVHVlc2RheSwgT2N0b2JlciAyNCwgMjAyMyA0OjA2IFBNDQo+Pj4+Pj4NCj4+Pj4+PiBPbiAy
MDIzLzEwLzIzIDIxOjM1LCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+Pj4+Pj4+DQo+Pj4+Pj4+PiBG
cm9tOiBDaGVuLCBKaXFpYW4gPEppcWlhbi5DaGVuQGFtZC5jb20+DQo+Pj4+Pj4+PiBTZW50OiBN
b25kYXksIE9jdG9iZXIgMjMsIDIwMjMgNDowOSBQTQ0KPj4+Pj4+Pg0KPj4+Pj4+Pj4+IEkgdGhp
bmsgdGhpcyBjYW4gYmUgZG9uZSB3aXRob3V0IGludHJvZHVjaW5nIHRoZSBuZXcgcmVnaXN0ZXIu
DQo+Pj4+Pj4+Pj4gQ2FuIHlvdSBwbGVhc2UgY2hlY2sgaWYgdGhlIFBNIHJlZ2lzdGVyIGl0c2Vs
ZiBjYW4gc2VydmUgdGhlDQo+Pj4+Pj4+Pj4gcHVycG9zZSBpbnN0ZWFkDQo+Pj4+Pj4+PiBvZiBu
ZXcgdmlydGlvIGxldmVsIHJlZ2lzdGVyPw0KPj4+Pj4+Pj4gRG8geW91IG1lYW4gdGhlIHN5c3Rl
bSBQTSByZWdpc3Rlcj8NCj4+Pj4+Pj4gTm8sIHRoZSBkZXZpY2UncyBQTSByZWdpc3RlciBhdCB0
cmFuc3BvcnQgbGV2ZWwuDQo+Pj4+Pj4gSSB0cmllZCB0byBmaW5kIHRoaXMgcmVnaXN0ZXIocGNp
IGxldmVsIG9yIHZpcnRpbyBwY2kgbGV2ZWwgb3IgdmlydGlvDQo+Pj4+Pj4gZHJpdmVyIGxldmVs
KSwgYnV0IEkgZGlkbid0IGZpbmQgaXQgaW4gTGludXgga2VybmVsIG9yIFFlbXUgY29kZXMuDQo+
Pj4+Pj4gTWF5IEkga25vdyB3aGljaCByZWdpc3RlciB5b3UgYXJlIHJlZmVycmluZyB0byBzcGVj
aWZpY2FsbHk/IE9yIHdoaWNoDQo+Pj4+Pj4gUE0gc3RhdGUgYml0IHlvdSBtZW50aW9uZWQgYmVs
b3c/DQo+Pj4+Pj4NCj4+Pj4+IFBDSSBzcGVjJ3MgUENJIFBvd2VyIE1hbmFnZW1lbnQgQ2FwYWJp
bGl0eSBTdHJ1Y3R1cmUgaW4gc2VjdGlvbiA3LjUuMi4NCj4+Pj4gWWVzLCB3aGF0IHlvdSBwb2lu
dCB0byBpcyBQTSBjYXBhYmlsaXR5IGZvciBQQ0llIGRldmljZS4NCj4+Pj4gQnV0IHRoZSBwcm9i
bGVtIGlzIHN0aWxsIHRoYXQgaW4gUWVtdSBjb2RlLCBpdCB3aWxsIGNoZWNrIHRoZQ0KPj4+PiBj
b25kaXRpb24ocGNpX2J1c19pc19leHByZXNzIG9yIHBjaV9pc19leHByZXNzKSBvZiBhbGwgdmly
dGlvLXBjaSBkZXZpY2VzIGluDQo+Pj4+IGZ1bmN0aW9uIHZpcnRpb19wY2lfcmVhbGl6ZSgpLCBp
ZiB0aGUgdmlydGlvIGRldmljZXMgYXJlbid0IGEgUENJZSBkZXZpY2UsIGl0IHdpbGwgbm90DQo+
Pj4+IGFkZCBQTSBjYXBhYmlsaXR5IGZvciB0aGVtLg0KPj4+IFBDSSBQTSBjYXBhYmlsaXR5IGlz
IG11c3QgZm9yIFBDSWUgZGV2aWNlcy4gU28gbWF5IGJlIFFFTVUgY29kZSBoYXMgcHV0IGl0IG9u
bHkgdW5kZXIgaXNfcGNpZSBjaGVjay4NCj4+PiBCdXQgaXQgY2FuIGJlIGRvbmUgb3V0c2lkZSBv
ZiB0aGF0IGNoZWNrIGFzIHdlbGwgYmVjYXVzZSB0aGlzIGNhcGFiaWxpdHkgZXhpc3RzIG9uIFBD
SSB0b28gZm9yIGxvbmcgdGltZSBhbmQgaXQgaXMgYmFja3dhcmQgY29tcGF0aWJsZS4NCj4+IERv
IHlvdSBzdWdnZXN0IG1lIHRvIGltcGxlbWVudCBQTSBjYXBhYmlsaXR5IGZvciB2aXJ0aW8gZGV2
aWNlcyBpbg0KPj4gUWVtdSBmaXJzdGx5LCBhbmQgdGhlbiB0byB0cnkgaWYgdGhlIFBNIGNhcGFi
aWxpdHkgY2FuIHdvcmsgZm9yIHRoaXMNCj4+IHNjZW5hcmlvPw0KPiANCj4gdmlydGlvIGRldmlj
ZXMgaW4gcWVtdSBhbHJlYWR5IGhhdmUgYSBQTSBjYXBhYmlsaXR5Lg0KPiANCj4gDQo+PiBJZiBz
bywgd2Ugd2lsbCBjb21wbGljYXRlIGEgc2ltcGxlIHByb2JsZW0uIEJlY2F1c2UgdGhlcmUgYXJl
IG5vIG90aGVyIG5lZWRzIHRvIGFkZCBQTSBjYXBhYmlsaXR5IGZvciB2aXJ0aW8gZGV2aWNlcyBm
b3Igbm93LCBpZiB3ZSBhZGQgaXQganVzdCBmb3IgcHJlc2VydmluZyByZXNvdXJjZXMsIGl0IHNl
ZW1zIHVubmVjZXNzYXJ5IGFuZCB1bnJlYXNvbmFibGUuIEFuZCB3ZSBhcmUgbm90IHN1cmUgaWYg
dGhlcmUgYXJlIG90aGVyIHNjZW5hcmlvcyB0aGF0IGFyZSBub3QgZHVyaW5nIHRoZSBwcm9jZXNz
IG9mIFBNIHN0YXRlIGNoYW5naW5nIGFsc28gbmVlZCB0byBwcmVzZXJ2ZSByZXNvdXJjZXMsIGlm
IGhhdmUsIHRoZW4gdGhlIFBNIHJlZ2lzdGVyIGNhbid0IGNvdmVyLCBidXQgcHJlc2VydmVfcmVz
b3VyY2VzIHJlZ2lzdGVyIGNhbi4NCj4gDQo+IE9uZSBvZiB0aGUgc2VsbGluZyBwb2ludHMgb2Yg
dmlydGlvIGlzIHByZWNpc2VseSByZXVzaW5nIGV4aXN0aW5nDQo+IHBsYXRmb3JtIGNhcGFiaWxp
dGllcyBhcyBvcHBvc2VkIHRvIGNvbWluZyB1cCB3aXRoIG91ciBvd24uDQo+IFNlZSBhYnN0cmFj
dC50ZXgNCj4gDQo+IA0KPj4gQ2FuIEkgYWRkIHNvbWUgbm90ZXMgbGlrZSAiSWYgUE0gY2FwYWJp
bGl0eSBpcyBpbXBsZW1lbnRlZCBmb3IgdmlydGlvIGRldmljZXMsIGl0IG1heSBjb3ZlciB0aGlz
IHNjZW5hcmlvLCBhbmQgaWYgdGhlcmUgYXJlIG5vIG90aGVyIHNjZW5hcmlvcyB0aGF0IFBNIGNh
bid0IGNvdmVyLCB0aGVuIHdlIGNhbiByZW1vdmUgdGhpcyByZWdpc3RlciAiIGluIGNvbW1pdCBt
ZXNzYWdlIG9yIHNwZWMgZGVzY3JpcHRpb24gYW5kIGxldCB1cyBjb250aW51ZSB0byBhZGQgcHJl
c2VydmVfcmVzb3VyY2VzIHJlZ2lzdGVyPw0KPiANCj4gV2UgY2FuJ3QgcmVtb3ZlIHJlZ2lzdGVy
cy4NCj4gDQo+Pj4NCj4+Pj4gQW5kIGFub3RoZXIgcHJvYmxlbSBpcyBob3cgYWJvdXQgdGhlIE1N
SU8gdHJhbnNwb3J0IGRldmljZXM/IFNpbmNlDQo+Pj4+IHByZXNlcnZlIHJlc291cmNlcyBpcyBu
ZWVkIGZvciBhbGwgdHJhbnNwb3J0IHR5cGUgZGV2aWNlcy4NCj4+Pj4NCj4+PiBNTUlPIGxhY2tz
IHN1Y2ggcmljaCBQTSBkZWZpbml0aW9ucy4gSWYgaW4gZnV0dXJlIE1NSU8gd2FudHMgdG8gc3Vw
cG9ydCwgaXQgd2lsbCBiZSBleHRlbmRlZCB0byBtYXRjaCB0byBvdGhlciB0cmFuc3BvcnRzIGxp
a2UgUENJLg0KPj4+DQo+Pj4+Pj4+DQo+Pj4+Pj4+PiBJIHRoaW5rIGl0IGlzIHVucmVhc29uYWJs
ZSB0byBsZXQgdmlydGlvLSBkZXZpY2UgbGlzdGVuIHRoZSBQTQ0KPj4+Pj4+Pj4gc3RhdGUgb2Yg
R3Vlc3Qgc3lzdGVtLg0KPj4+Pj4+PiBHdWVzdCBkcml2ZXIgcGVyZm9ybXMgYW55IHdvcmsgb24g
dGhlIGd1ZXN0IHN5c3RlbXMgUE0gY2FsbGJhY2sNCj4+Pj4+Pj4gZXZlbnRzIGluDQo+Pj4+Pj4g
dGhlIHZpcnRpbyBkcml2ZXIuDQo+Pj4+Pj4gSSBkaWRuJ3QgZmluZCBhbnkgUE0gc3RhdGUgY2Fs
bGJhY2sgaW4gdGhlIHZpcnRpbyBkcml2ZXIuDQo+Pj4+Pj4NCj4+Pj4+IFRoZXJlIGFyZSB2aXJ0
aW9fc3VzcGVuZCBhbmQgdmlydGlvX3Jlc3VtZSBpbiBjYXNlIG9mIExpbnV4Lg0KPj4+PiBJIHRo
aW5rIHdoYXQgeW91IHNhaWQgdmlydGlvX3N1c3BlbmQvcmVzdW1lIGlzIGZyZWV6ZS9yZXN0b3Jl
IGNhbGxiYWNrIGZyb20NCj4+Pj4gInN0cnVjdCB2aXJ0aW9fZHJpdmVyIiBvciBzdXNwZW5kL3Jl
c3VtZSBjYWxsYmFjayBmcm9tICJzdGF0aWMgY29uc3Qgc3RydWN0DQo+Pj4+IGRldl9wbV9vcHMg
dmlydGlvX3BjaV9wbV9vcHMiLg0KPj4+PiBBbmQgeWVzLCBJIGFncmVlLCBpZiB2aXJ0aW8gZGV2
aWNlcyBoYXZlIFBNIGNhcGFiaWxpdHksIG1heWJlIHdlIGNhbiBzZXQgUE0gc3RhdGUNCj4+Pj4g
aW4gdGhvc2UgY2FsbGJhY2sgZnVuY3Rpb25zLg0KPj4+Pg0KPj4+Pj4NCj4+Pj4+Pj4NCj4+Pj4+
Pj4+IEl0J3MgbW9yZSBzdWl0YWJsZSB0aGF0IGVhY2ggZGV2aWNlIGdldHMgbm90aWZpY2F0aW9u
cyBmcm9tIGRyaXZlciwNCj4+Pj4+Pj4+IGFuZCB0aGVuIGRvIHByZXNlcnZpbmcgcmVzb3VyY2Vz
IG9wZXJhdGlvbi4NCj4+Pj4+Pj4gSSBhZ3JlZSB0aGF0IGVhY2ggZGV2aWNlIGdldHMgdGhlIG5v
dGlmaWNhdGlvbiBmcm9tIGRyaXZlci4NCj4+Pj4+Pj4gVGhlIHF1ZXN0aW9uIGlzLCBzaG91bGQg
aXQgYmUgdmlydGlvIGRyaXZlciwgb3IgZXhpc3RpbmcgcGNpIGRyaXZlcg0KPj4+Pj4+PiB3aGlj
aA0KPj4+Pj4+IHRyYW5zaXRpb25zIHRoZSBzdGF0ZSBmcm9tIGQwLT5kMyBhbmQgZDMtPmQwIGlz
IGVub3VnaC4NCj4+Pj4+PiBJdCBzZWVtcyB0aGVyZSBpc24ndCBleGlzdGluZyBwY2kgZHJpdmVy
IHRvIHRyYW5zaXRpb25zIGQwIG9yIGQzDQo+Pj4+Pj4gc3RhdGUuIENvdWxkIHlvdSBwbGVhc2Ug
dGVsbCBtZSB3aGljaCBvbmUgaXQgaXMgc3BlY2lmaWNhbGx5PyBJIGFtIHZlcnkgd2lsbGluZyB0
bw0KPj4+PiBnaXZlIGEgdHJ5Lg0KPj4+Pj4+DQo+Pj4+PiBWaXJ0aW8tcGNpIG1vZGVybiBkcml2
ZXIgb2YgTGludXggc2hvdWxkIGJlIGFibGUgdG8uDQo+Pj4+IFllcywgSSBrbm93LCBpdCBpcyB0
aGUgVklSVElPX1BDSV9GTEFHX0lOSVRfUE1fQklULiBCdXQgc3RpbGwgdGhlIHR3byBwcm9ibGVt
cyBJDQo+Pj4+IHNhaWQgYWJvdmUuDQo+Pj4+DQo+Pj4gQm90aCBjYW4gYmUgcmVzb2x2ZWQgd2l0
aG91dCBzd2l0Y2hpbmcgdG8gcGNpZS4NCj4+PiAgDQo+Pj4+Pg0KPj4+Pj4+PiBDYW4geW91IHBs
ZWFzZSBjaGVjayB0aGF0Pw0KPj4+Pj4+Pg0KPj4+Pj4+Pj4+PiAtLS0gYS90cmFuc3BvcnQtcGNp
LnRleA0KPj4+Pj4+Pj4+PiArKysgYi90cmFuc3BvcnQtcGNpLnRleA0KPj4+Pj4+Pj4+PiBAQCAt
MzI1LDYgKzMyNSw3IEBAIFxzdWJzdWJzZWN0aW9ue0NvbW1vbiBjb25maWd1cmF0aW9uDQo+Pj4+
IHN0cnVjdHVyZQ0KPj4+Pj4+Pj4+PiBsYXlvdXR9XGxhYmVse3NlYzpWaXJ0aW8gVHJhbnNwb3J0
DQo+Pj4+Pj4+Pj4+ICAgICAgICAgIC8qIEFib3V0IHRoZSBhZG1pbmlzdHJhdGlvbiB2aXJ0cXVl
dWUuICovDQo+Pj4+Pj4+Pj4+ICAgICAgICAgIGxlMTYgYWRtaW5fcXVldWVfaW5kZXg7ICAgICAg
ICAgLyogcmVhZC1vbmx5IGZvciBkcml2ZXIgKi8NCj4+Pj4+Pj4+Pj4gICAgICAgICAgbGUxNiBh
ZG1pbl9xdWV1ZV9udW07ICAgICAgICAgLyogcmVhZC1vbmx5IGZvciBkcml2ZXIgKi8NCj4+Pj4+
Pj4+Pj4gKyAgICAgICAgbGUxNiBwcmVzZXJ2ZV9yZXNvdXJjZXM7ICAgICAgICAvKiByZWFkLXdy
aXRlICovDQo+Pj4+Pj4+Pj4gUHJlc2VydmluZyB0aGVzZSByZXNvdXJjZXMgaW4gdGhlIGRldmlj
ZSBpbXBsZW1lbnRhdGlvbiB0YWtlcw0KPj4+Pj4+Pj4+IGZpbml0ZSBhbW91bnQNCj4+Pj4+Pj4+
IG9mIHRpbWUuDQo+Pj4+Pj4+Pj4gUG9zc2libHkgbW9yZSB0aGFuIDQwbnNlYyAodGltZSBvZiBQ
Q0llIHdyaXRlIFRMUCkuDQo+Pj4+Pj4+Pj4gSGVuY2UgdGhpcyByZWdpc3RlciBtdXN0IGJlIGEg
cG9sbGluZyByZWdpc3RlciB0byBpbmRpY2F0ZSB0aGF0DQo+Pj4+Pj4+PiBwcmVzZXJ2YXRpb25f
ZG9uZS4NCj4+Pj4+Pj4+PiBUaGlzIHdpbGwgdGVsbCB0aGUgZ3Vlc3Qgd2hlbiB0aGUgcHJlc2Vy
dmF0aW9uIGlzIGRvbmUsIGFuZCB3aGVuDQo+Pj4+Pj4+Pj4gcmVzdG9yYXRpb24gaXMNCj4+Pj4+
Pj4+IGRvbmUsIHNvIHRoYXQgaXQgY2FuIHJlc3VtZSB1cHBlciBsYXllcnMuDQo+Pj4+Pj4+Pj4N
Cj4+Pj4+Pj4+PiBQbGVhc2UgcmVmZXIgdG8gcXVldWVfcmVzZXQgZGVmaW5pdGlvbiB0byBsZWFy
biBtb3JlIGFib3V0IHN1Y2gNCj4+Pj4+Pj4+PiByZWdpc3Rlcg0KPj4+Pj4+Pj4gZGVmaW5pdGlv
bi4NCj4+Pj4+Pj4+IFRoYW5rcywgSSB3aWxsIHJlZmVyIHRvICJxdWV1ZV9yZXNldCIuIFNvLCBJ
IG5lZWQgdGhyZWUgdmFsdWVzLA0KPj4+Pj4+Pj4gZHJpdmVyIHdyaXRlIDEgdG8gbGV0IGRldmlj
ZSBkbyBwcmVzZXJ2aW5nIHJlc291cmNlcywgZHJpdmVyIHdyaXRlDQo+Pj4+Pj4+PiAyIHRvIGxl
dCBkZXZpY2UgZG8gcmVzdG9yaW5nIHJlc291cmNlcywgZGV2aWNlIHdyaXRlIDAgdG8gdGVsbA0K
Pj4+Pj4+Pj4gZHJpdmVyIHRoYXQgcHJlc2VydmluZyBvciByZXN0b3JpbmcgZG9uZSwgYW0gSSBy
aWdodD8NCj4+Pj4+Pj4+DQo+Pj4+Pj4+IFJpZ2h0Lg0KPj4+Pj4+Pg0KPj4+Pj4+PiBBbmQgaWYg
dGhlIGV4aXN0aW5nIHBjaWUgcG0gc3RhdGUgYml0cyBjYW4gZG8sIHdlIGNhbiBsZXZlcmFnZSB0
aGF0Lg0KPj4+Pj4+PiBJZiBpdCBjYW5ub3QgYmUgdXNlZCwgbGV0cyBhZGQgdGhhdCByZWFzb25p
bmcgaW4gdGhlIGNvbW1pdCBsb2cgdG8NCj4+Pj4+Pj4gZGVzY3JpYmUgdGhpcw0KPj4+Pj4+IHJl
Z2lzdGVyLg0KPj4+Pj4+Pg0KPj4+Pj4+Pj4+DQo+Pj4+Pj4+Pj4gTGV0cyBwbGVhc2UgbWFrZSBz
dXJlIHRoYXQgUENJZSBQTSBsZXZlbCByZWdpc3RlcnMgYXJlDQo+Pj4+Pj4+Pj4gc3VmZmljaWVu
dC9ub3Qtc3VmZmljaWVudA0KPj4+Pj4+Pj4gdG8gZGVjaWRlIHRoZSBhZGRpdGlvbiBvZiB0aGlz
IHJlZ2lzdGVyLg0KPj4+Pj4+Pj4gQnV0IGlmIHRoZSBkZXZpY2UgaXMgbm90IGEgUENJZSBkZXZp
Y2UsIGl0IGRvZXNuJ3QgaGF2ZSBQTQ0KPj4+Pj4+Pj4gY2FwYWJpbGl0eSwgdGhlbiB0aGlzIHdp
bGwgbm90IHdvcmsuIEFjdHVhbGx5IGluIG15IGxvY2FsDQo+Pj4+Pj4+PiBlbnZpcm9ubWVudCwg
cGNpX2lzX2V4cHJlc3MoKSByZXR1cm4gZmFsc2UgaW4gUWVtdSwgdGhleSBhcmUgbm90DQo+Pj4+
Pj4+PiBQQ0llDQo+Pj4+Pj4gZGV2aWNlLg0KPj4+Pj4+PiBJdCBpcyByZWFzb25hYmxlIHRvIGFz
ayB0byBwbHVnIGluIGFzIFBDSWUgZGV2aWNlIGluIDIwMjMgdG8gZ2V0IG5ldw0KPj4+Pj4+PiBm
dW5jdGlvbmFsaXR5IHRoYXQgdG9vIHlvdSBtZW50aW9uZWQgYSBncHUgZGV2aWNlLiDwn5iKDQo+
Pj4+Pj4+IFdoaWNoIGRvZXMgbm90IGhhdmUgdmVyeSBsb25nIGhpc3Rvcnkgb2YgYW55IGJhY2t3
YXJkIGNvbXBhdGliaWxpdHkuDQo+Pj4+Pj4gRG8geW91IHN1Z2dlc3QgbWUgdG8gYWRkIFBNIGNh
cGFiaWxpdHkgZm9yIHZpcnRpby1ncHUgb3IgY2hhbmdlDQo+Pj4+Pj4gdmlydGlvLWdwdSB0byBh
IFBDSWUgZGV2aWNlPw0KPj4+Pj4+DQo+Pj4+PiBQQ0kgUG93ZXIgTWFuYWdlbWVudCBDYXBhYmls
aXR5IFN0cnVjdHVyZSBkb2VzIG5vdCBzZWVtIHRvIGJlIGxpbWl0ZWQgdG8NCj4+Pj4gUENJZS4N
Cj4+Pj4gSSBhbSBub3Qgc3VyZSwgYnV0IGluIGN1cnJlbnQgUWVtdSBjb2RlLCBJIGNhbiBzZWUg
dGhlIGNoZWNrICJwY2lfaXNfZXhwcmVzcyINCj4+Pj4gZm9yIGFsbCB2aXJ0aW8tcGNpIGRldmlj
ZXMuIElmIHdlIHdhbnQgdG8gYWRkIFBNIGNhcGFiaWxpdHkgZm9yIHZpcnRpby1wY2kgZGV2aWNl
cywNCj4+Pj4gd2UgbmVlZCB0byBjaGFuZ2UgdGhlbSB0byBQQ0llIGRldmljZSBJIHRoaW5rLg0K
Pj4+Pg0KPj4+IFRoYXQgaXMgb25lIG9wdGlvbi4NCj4+PiBTZWNvbmQgb3B0aW9uIHRvIGV4dGVu
ZCBQQ0kgUE0gY2FwIGZvciBub24gcGNpIGRldmljZSBiZWNhdXNlIGl0IGlzIHN1cHBvcnRlZC4N
Cj4+Pg0KPj4+Pj4NCj4+Pj4NCj4+Pj4gLS0NCj4+Pj4gQmVzdCByZWdhcmRzLA0KPj4+PiBKaXFp
YW4gQ2hlbi4NCj4+DQo+PiAtLSANCj4+IEJlc3QgcmVnYXJkcywNCj4+IEppcWlhbiBDaGVuLg0K
PiANCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpKaXFpYW4gQ2hlbi4NCg==

