Return-Path: <virtio-dev-return-12431-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD503C77B60
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 13:47:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 164853DF37
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 13:47:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 07E02986656
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 13:47:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id F0C3398663C; Wed, 26 Apr 2023 13:47:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D32BC98663F;
	Wed, 26 Apr 2023 13:47:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YwM/54bitwBArKLjE67edijBvAeit3RRJX0XdP7gUgaXm0SJUf4ex08j8NgeLIOwEIDjmmFEdtCHPP5q7E03/5egHcY8mLgtioxYj924TrNbRmjj78uk6n2W/Uj7ahVr58RuL3I3wzvFdNSvbwxPot4O8Qx4rHNsCyVzCED0LoZOPF7Ip2zZz+CDvq1dAPJfL11pSZxJr5f5Dt2AT7Vk90YyrBxc4jEY+wzRO+B+Bu7pJbVAzMppcow/OUfOrZjw8MkHk6gGcxlxEk1SoXLk83TMKj/MAtuL3ihM+CxG9orqlj0ZhW3KPEvvw+kYA3BmZn1y/ISZRryj3VOQGeR1Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVX1K7lUbDwNoUm+sqAtgrFu3G6KyvwmfNUwwMq9CXo=;
 b=WE6tSCAeX9CVSd5sQZlNulKBrQrnOCl4v2u8iSqaaF5RNGmoYKMnTtPDHrLBTWvlenaS4WR7LroyCywX4L5cm8EsAv/w0v94SOJgtEz6AmWOjqQ6KcyLHkYocgCbb98+TFuh6NBBfXlglvB73iU8y4jGY3ElYLELEBv/HxOuPzbXK400r3EgbTW6B8+TS/bE6Ad/pmqFQjuY0VupFdrMZhXBr1Mj9CpkWH3c8guVnUwLjECyCMEXIQIK9L3DLvMAwiZa+SWD7xE3U8b0xeL58n9u+GCleCCe3OpOuIe4lWCIFPUQ8Eb4x8Wt0IeT+M60TNM0uF+b3wRU3RWJp89lww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Heng Qi <hengqi@linux.alibaba.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>
Thread-Topic: [PATCH v13] virtio-net: support inner header hash
Thread-Index: AQHZdbY0vUbPhs5ETkuums+/PkRABq88fZaAgAEg8YCAAABEcA==
Date: Wed, 26 Apr 2023 13:47:28 +0000
Message-ID:
 <PH0PR12MB5481EA937633233A9A9E5E30DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230423073532.105636-1-hengqi@linux.alibaba.com>
 <f9221063-8419-9cb3-e59c-0b0393bdd501@nvidia.com>
 <ced8a6f0-7858-0b0a-55bb-26eea2a7ff5a@linux.alibaba.com>
In-Reply-To: <ced8a6f0-7858-0b0a-55bb-26eea2a7ff5a@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA1PR12MB6848:EE_
x-ms-office365-filtering-correlation-id: b28d99e7-e0cf-497f-dd25-08db465cc69d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3jWCY9POd5uWxlW1WGagN7YApLBa2UVufR1/gcpy2Lk89ZNSFX1EfCLYU+fPorU6GVKbW6bXuKZe7uYd6EfebhjAXnIIvZ7L9i7qLfTsJRNmExrzSHBU3ijT0P5+nA8doOa0nilu3b/o27HrqsQZpxCrai7lm7Z9os0if7jOJ3MQn3NV/Ht407pT5QU59kIGYuQKA+e+Ri5ToFNIRUY1rL7WWX7wfkxtid+uKf/pI0EvoOStZHzlFWlc9FEQIUlTxVI7nsYf05dj5fPLZdDWfZwR5l8Oy5Ab7nzi0RZXmXmURaXPbTwG70oosUC/3/umuESNzT+fDH8gAD406K3neqmhtwqcUrmu04mb7bsr+9rOVOq4mFYIQLOT6yUX4z24ubISyq2vF+WxSe2g/zEvWx5kiNrZ1PrYIQC/Pq8xtHljAfWU/IEUjMApDgqCBl/HBkl/HL7F+vt67sczHDsIMrotWCl0VziyB2XhN+9/8+vgfrJ04ufDRrdPVhdb+US3nyHstv7ggK2Uzn8T0eHncdpY4M3mrSeLy7nxMzJmgqg0fOQ7D1uxzOCGZiQB0jKASw88IzIQfgzBBxJryhZn9PqarIx3rAjtXJ89F4cY2+ecpzwhmeXRR0pIGJeaXlrf
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199021)(9686003)(6506007)(54906003)(52536014)(5660300002)(7696005)(186003)(26005)(41300700001)(122000001)(8936002)(86362001)(8676002)(33656002)(38100700002)(55016003)(316002)(76116006)(66946007)(66476007)(66556008)(110136005)(64756008)(66446008)(4326008)(71200400001)(38070700005)(83380400001)(2906002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WGdjWUxKSDdheUtJenBSOW1Hb2dsWUgxV1dBakRPbE8wN01uMDJyd2I1S1lQ?=
 =?utf-8?B?dFZURERVN0ZsRVNscHMrRDlPQVFzNDh0bXdYKzJ6bHlwN29nanRLMW1Fdldr?=
 =?utf-8?B?L2RJaVppNkh5Z1dyYmQrUEVXUE9XTVhkUDNVRzl1cG02ZDg2QVQ2cmJySjZq?=
 =?utf-8?B?Qk5ibURzUUZuOWlPMVQ0NWxGWmZGdUFRbm9TWVJqdTlGOTVLYXkxQ3hIY1g0?=
 =?utf-8?B?R01pK3kraUUxcmhVdE44T3RIQnR4d1JpQjB3QTVVSjNwUHVBdHRPeDlUanc1?=
 =?utf-8?B?cnVoaTdlc1krNlV4eTBpbHRac2NvR0NMcC96UnJuU2JwL3o5QUtCZnNiazlT?=
 =?utf-8?B?QTlXWUUxUTJIbXdRNHRtb09uM1lkMlVSeENOWXdYQ1ZvM0p2MmhSRCtRYm84?=
 =?utf-8?B?TzRFbkExSUV4V0owREZaa0NmZmUrcVdabkkxeUNjaTU0Vm0rem5WbkxQSElG?=
 =?utf-8?B?MmRMcGVNclMrMDdWbElSdUlETlB4SFBmd2t4SnlTWlF1eTFZV2NLUkhacWVS?=
 =?utf-8?B?TmVTTHQyYmYvOTFTVHR2Nll4NVZQZG9WOUVUcnZJeXN3eFhvelVyZlRIUk9z?=
 =?utf-8?B?NVlYTzlBRnlJeTU3d1c3dXg2M1V5S0RtYUFaejRaRlQ1TTlHTnNwd2xja05C?=
 =?utf-8?B?eGdrUWMzbVBpSHMwaXdCRWxvZTE2MjdjcUhPOU5ZWjRuOE9ZN0s3NFArbTFp?=
 =?utf-8?B?SWxVVGpkekJSZzI0MHQvNU1EdVFpdGFGSFZaNzEvbVRpL3psUnBBNEIvUUJo?=
 =?utf-8?B?K0VUTWtrUHJmdWlYUUt3cG5IZ0xheVl4YUVtZHJtSG1EM21MWHRJaC9KU2tT?=
 =?utf-8?B?c2sxMlA4bVRiditWS1lmeXZOdnFlaHBMTXJIbSsrcTNwdHRNR1UxM3VmTUJX?=
 =?utf-8?B?VDlFY3hXc0V2RkdUREVPQmoyUFhySDB2aTFyeEhXRE1EWEtYZWMySjdQMEpR?=
 =?utf-8?B?KzdYOTd2ZHV3RDhGRGZWcWtaYlJhV2RtUUdpT2JRaHdEczcrNUJTbk1kbVhE?=
 =?utf-8?B?NXNDRUFUdkk3V0VpdXY1dUpKY3g5bThaSHNQeXdRLzFLVTJlODQwNDlnbWps?=
 =?utf-8?B?Z3ZKMWtlOHZQUUx6L3ZvQktxcitDc2NpWCs4Y2Z3Yk04UE9PakRVZlZsT3ZH?=
 =?utf-8?B?R2ZMNWtMRGdpQkRrQ0ZCcTRJWmg0VVlSYmRUS2N2WGFzK3dGbU5MMDlpY1lr?=
 =?utf-8?B?dCt3RUd3MnFmU2dhZjAwMGVUOSs4ZnBIZlB6M3NoYlJqRmE2ZktjNUgrZHp0?=
 =?utf-8?B?clFvOEpPUldnTmlRQXlzVVZPOFFFUjdNekU1TXM1QWZqd0c0T2tzY1h4UkFy?=
 =?utf-8?B?cHhwWU5PVXR0bXpWVWNtcDZIc2ZNWFdFN3E0MzRGMXM2WXFCVzh2L01ZMkJ0?=
 =?utf-8?B?R29JelRrVi9MUUpXTTlVOTU2Wit4aWFSRUxpd0Q1TThUem55ZllKM0hta2tG?=
 =?utf-8?B?dlZMdDBYSWtCVkdmd1k3Yk1DUmxaN3lkeUdXUHgrdVA0UFE2c3k0Y2hTandt?=
 =?utf-8?B?elBqL0Zna0xBSjRSQVRRaFdMMEFXUFFMMU1kaFU4OW4xL3RIUk9NWWdIU3JB?=
 =?utf-8?B?bjd2MVVsbGdnVUxnODVTMUllMENxekxvNnphbUExMlVnYWVmUlZxOXhBSEV4?=
 =?utf-8?B?LzBuNFlxSlRqTjFEQ0hSdFBuNVpaTkdNQU5oYmllOEc0ZTlNZFB2RmMra0xZ?=
 =?utf-8?B?S2J2elc0bXg1eGk2THQ4b2JSdVhzK1Rqd2FsZElsYzF3NWJ4enIvS0FrVHd2?=
 =?utf-8?B?Sm9lV0Y2dmdnTGxpSHA5THlOdXBzeGtyZ0xsUTQ4bEM0WGtGTkF3eGI1MVhV?=
 =?utf-8?B?WXVwRURqUjdFQWpuTCtOREl1OVc0MWpYRUR5R1JFVjRoRTByWUNsdXRCajZp?=
 =?utf-8?B?NkNCdnNpa01DMS83ajIxTStPTU5EK1dDZVBkRFlPNGQ0SG8rK1ptcEFkZlNY?=
 =?utf-8?B?SmgyOUFTRDdDT0I3a0oyMkZEdElTekdHV2JITS96SWF5NUorS0RmYWF4VGsy?=
 =?utf-8?B?cGtCVXo1WnQrOVJaY093T041ZGNRSC9lZHg3ZDNCdlc1NkJrRHFkUDlMQTMw?=
 =?utf-8?B?NjJueDNxbVZSYzB1dDlZd2hpZFNXelZoSTA2NVdHbXJTbjUrSlRwWmcvcnNY?=
 =?utf-8?Q?aQBc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b28d99e7-e0cf-497f-dd25-08db465cc69d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 13:47:28.5991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 21F/vquyutinVnUfDkFF/P2Qrujyh3XDjn4fQHNfuyQM9qQQWYK2A8ITFg/buddCvo02/YK8GN9k5LL0KMUPKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6848
Subject: [virtio-dev] RE: [PATCH v13] virtio-net: support inner header hash

DQoNCj4gRnJvbTogSGVuZyBRaSA8aGVuZ3FpQGxpbnV4LmFsaWJhYmEuY29tPg0KPiBTZW50OiBX
ZWRuZXNkYXksIEFwcmlsIDI2LCAyMDIzIDk6NDMgQU0NCg0KPiA+ICJXaXRoIHRoYXQgbm8gbmVl
ZCB0byBkZWZpbmUgdHdvIGZpZWxkcyBhdCB0d28gZGlmZmVyZW50IHBsYWNlcyBpbg0KPiA+IGNv
bmZpZyBhcmVhIGFuZCBhbHNvIGluIGN2cS4iDQo+IA0KPiBJJ20gbm90IHN1cmUgaWYgdGhpcyBp
cyBzdWZmaWNpZW50bHkgbW90aXZhdGVkLCBSU1MgYWxzbyBoYXMgc3VwcG9ydHNfaGFzaF90eXBl
cw0KPiBpbiBjb25maWcgc3BhY2UuDQo+DQpUaGVyZSBhcmUgbWFueSBmaWVsZHMgZ3Jvd24gdG8g
TU1JTyBjb25maWcgc3BhY2UgYmVjYXVzZSAwLjkuNSBoYXMgY29uZmlnIHNwYWNlIHRoZXJlLg0K
VGhlc2UgYXJlIHVzdWFsbHkgb25lIHRpbWUgcmVhZCBvciByYXJlbHkgdXNlZDsgaGVuY2UgaXQg
ZG9lc27igJl0IG5lZWQgdG8gY29tZSBmcm9tIHRoaXMgYXJlYSBvZiB0aGUgZGV2aWNlIHRvIGJl
IF9hbHdheXNfIGF2YWlsYWJsZS4NCiANCj4gV2UgZG9uJ3QgYWN0dWFsbHkgbmVlZCBjdnEgYW5k
IGNvbmZpZyB0byBzeW5jIG9uDQo+IHN1cHBvcnRlZF90dW5uZWxfaGFzaF90eXBlcywgc2luY2Ug
aXQgZG9lc24ndCBuZWVkIHRvIGNoYW5nZSAobWVhbmluZw0KPiBzdXBwb3J0ZWRfdHVubmVsX2hh
c2hfdHlwZXMgZG9lc24ndCBzZW5kIGNvbmZpZ3VyYXRpb24gY2hhbmdlDQo+IG5vdGlmaWNhdGlv
bnMpLg0KPiANCkl0IGRvZXNu4oCZdCBidXQgZGV2aWNlIGlzIGV4cGVjdGVkIHRvIHB1Ymxpc2gg
dGhlIHZhbHVlIGF0IHR3byBwbGFjZXMuDQoNCj4gPj4gK0ZvciBzY2VuYXJpb3Mgd2l0aCBzdWZm
aWNpZW50IGV4dGVybmFsIGVudHJvcHkgb3Igbm8gaW50ZXJuYWwNCj4gPj4gaGFzaGluZyByZXF1
aXJlbWVudHMsIGlubmVyIGhlYWRlciBoYXNoIG1heSBub3QgYmUgbmVlZGVkOg0KPiA+PiArQSB0
dW5uZWwgaXMgb2Z0ZW4gZXhwZWN0ZWQgdG8gaXNvbGF0ZSB0aGUgZXh0ZXJuYWwgbmV0d29yayBm
cm9tIHRoZQ0KPiA+PiBpbnRlcm5hbCBvbmUuIEJ5IGNvbXBsZXRlbHkgaWdub3JpbmcgZW50cm9w
eQ0KPiA+PiAraW4gdGhlIGV4dGVybmFsIGhlYWRlciBhbmQgcmVwbGFjaW5nIGl0IHdpdGggZW50
cm9weSBmcm9tIHRoZQ0KPiA+PiBpbnRlcm5hbCBoZWFkZXIsIGZvciBoYXNoIGNhbGN1bGF0aW9u
cywgdGhpcyBleHBlY3RhdGlvbg0KPiA+IFlvdSB3YW50ZWQgdG8gc2F5IGlubmVyIGhlcmUgbGlr
ZSByZXN0IG9mIHRoZSBwbGFjZXMuDQo+ID4NCj4gPiBzL2ludGVybmFsIGhlYWRlci9pbm5lciBo
ZWFkZXINCj4gDQo+IEkgd2FudCB0byBtYWtlIHRoZSAnZXh0ZXJuYWwnIGFuZCAnaW50ZXJuYWwn
IGNvcnJlc3BvbmQsIGJ1dCBhdm9pZCB0aGUgaW50ZXJuYWwNCj4gaGVhZGVyLCBhbmQgdXNlIGEg
dW5pZmllZCAnaW5uZXIgaGVhZGVyJyBpcyBhbHNvIHJlYXNvbmFibGUuOikNCj4NClNpbmNlIGlu
IHJlc3Qgb2Ygb3RoZXIgZGVzY3JpcHRpb24sIHdlIHJlZmVyIHRvIGl0IGFzICJvdXRlciIsIGl0
IGlzIGJldHRlciB0byBrZWVwIGl0IGNvbnNpc3RlbnQgYXMgb3V0ZXIgaW5zdGVhZCBvZiBleHRl
cm5hbCBoZXJlLg0K

