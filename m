Return-Path: <virtio-dev-return-13843-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CED91CE79AD
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 06:08:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 427F642A7F
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 06:08:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1E80598666F
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 06:08:40 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 073EC986662; Wed, 20 Sep 2023 06:08:40 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EB31F986663
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Sep 2023 06:08:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9jLudBxXXP8pObkzuk24J93ziqJx88GvHocMwLOjb7FMsOHckli55nUFSWadKVjQu2tIT4GCDZl9a5VtMlobczjZe/Eq7rBVloec+0KnaErVyhrhFHDo3H8SnnqTS8i2Gvns1/E/Bv9qdgTo02No2Z6yyb6HI+Uu/FvWJClzcaWxaJ93Vpdrd2pyviqbJCFSBoUHZFgs1KQUgAG5EippvJFlZWct3zVppBAXut1m2GNzw2Dpd+aQrGOBPwtWMT2au/eK/FsZW/SDTd7Kmip89RDziyXUATAFpsVQlSmYmyidQKlSJw9rJXck/cqSJgACsQJfULLPdK+wwU1EKOi2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrBxFX105Mmmdh1OPUOZ69b7zJw++mmY+RiTG+x6Knw=;
 b=TF1SWr6OLyEG1j9g8V97vwha8i7FN1gKN6ANg8YqLlT17fXXOKSeXbohNkR4XQLeqpjm5TmmTnBoAVck9oSTIadW5XtFZJvhv2PU3yBSlHjBDWsMa0OtzwhwFz8GfqsL8ccZhmq9Q8g8/jHkgze3Qjzo89Jz0mfnEtsuROKR9lqUI21DGRsc+dA382IKsGTTIZeUxpH7oWT2f0TCSbsIxgqJBhLrV1neHJx8A2+Jk58cwF1OR2vKCHugEy2p5uCZfkmOtZLSC4rszTwJ0DnNhcbV5Xp+j61gDRCbKMfKoeuDOv867po1kn0W5LIXTUloD7w3h1yU7496Rg7h4MDaDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, "Michael S. Tsirkin"
	<mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jason
 Wang <jasowang@redhat.com>
Thread-Topic: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state
Thread-Index:
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAC3dgIAAl98QgAADDoCAAk+KgIAAAFWw
Date: Wed, 20 Sep 2023 06:08:36 +0000
Message-ID:
 <PH0PR12MB5481E94B590F6696F2A23028DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
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
 <20230918144312-mutt-send-email-mst@kernel.org>
 <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
In-Reply-To: <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB6740:EE_
x-ms-office365-filtering-correlation-id: 7b5e959f-28d6-4773-a349-08dbb9a00726
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8QC59NOoI8HJeSb5JKXX7iSYVhd1H4u1HTJHph5iOsXu0qiPusrcLf4jj7pHWGGIkxnwQxb7VFP3amoAX2+0UVyr2JSt8Vsmg4MRQAFdaH7SgXgw927t/Zrb3OaiUqEI4mQghzPhnc0SZLXZIETejCbIwHWh/xxs1l8ny6awhAUAbDRUqSpLB3qmaDOf9SBhCY+n+7Cqy8OOipzn0uWmVFT8bzImtYNaWvIM5D7fhISbu3Id1PPoQxqjLRUPrYo8AUDZHld+waFcV1fYyvqwAKDFJiHPNCKX15bblo8n0OBZjHB/xaLEXRMBVPjc+e+lEQwlZm5c/Q97Swlw5fEllr1seMDzOoxcgXFbUlA0K1yY7npklXo70qp9qXQdSFs5xnCcZlTmQiKuosY7HGkgjL0XxS6dK0hfqLZWufyzM3AwZh23UryHZwD/ZyhWNHGJYzbS32U6EL3phiwjk/UvF0aTgu6c/1CbEKBFinMaXa2vYQI6IOOVZ/DHe32H/zGT9WyvHUx6QS40mg+np+Wt1Yq0yfg6X38YaeOv2WDu9y6q+eY+8wUbSihfVueo5VAVqKEV+B1InHavuVHVXOYPWfuhdY/Bkah30jJO+ku7tu6u9DeS8jdfJtbeNCA2Y72p
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(39860400002)(366004)(396003)(451199024)(186009)(1800799009)(316002)(76116006)(66946007)(110136005)(64756008)(66446008)(66556008)(54906003)(66476007)(55016003)(478600001)(71200400001)(122000001)(38070700005)(38100700002)(2906002)(33656002)(86362001)(15650500001)(41300700001)(5660300002)(8936002)(8676002)(4326008)(52536014)(26005)(83380400001)(9686003)(53546011)(7696005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N3NwYUdOY280T0lLT0RVNnpTcmlQdldRWnN3R2plazA5UC9jc0VJN3J0M0tN?=
 =?utf-8?B?ZzhkeWI0dHozZEI0KzZocS9wcVFlakpMRHNZVlJhcnpjc3FkSUQrdXdoK0RF?=
 =?utf-8?B?aytvZkFObXFaaFZ2V2dDdGdRZm51VlFWQVZoZGdMR0NLenBJUDRCeXhodDds?=
 =?utf-8?B?YkVkZUw4eDVYZjZCK0ZWWVo0YUFsK0doM3pqZXJEMDNPVy9Hem9pVFU2RytG?=
 =?utf-8?B?bC9BZS9PMlhvS0xiU2M2T2xmSGpiaEhQWmpEMTVwWE4veGVMM3VWODhINnNF?=
 =?utf-8?B?dUpueHVvNEd5SElEclVEdkUwU1g4L2xlUnZTZTZIZGhQb3haaERlcmFXWTc0?=
 =?utf-8?B?ajdsT3JsRFhRclZTTTRGSGVWbTIrSXVtS2YvdjhaTmZhbkM4NzBSc2xST3Vi?=
 =?utf-8?B?TDlKTFBmWEM0WVVkM2plS2VKTE5hNkE4VVNiUmlONXh0V3R1VnhkYXZXSG1V?=
 =?utf-8?B?UGVXb3k4dDV6b3BOZ3p4SHFESitWM0xGNGlxVUdyaWR4a0RueUdNditmc2Ez?=
 =?utf-8?B?Q3ZPbVFxV0VaRWlkWFhzWjJjSXB3VWk2VVh3UW9qcUdKM1ZmVDl2ZWQrY2ZO?=
 =?utf-8?B?R3V2SEpLM2VXTHFkZUMvQllXaTVJUmVOc0FFWUxYTzRZR09ZYjE4RjVMQWdt?=
 =?utf-8?B?R0Y0bmpaRmw1ekovazViWk5oeW1iTThxdkFubUx2aVJGRVVvd3lQejlLcXNv?=
 =?utf-8?B?YS9BaGZYbjJkL0w2QjhvbnNOdk9qSllpTCs3TEphWGw5VC9SN0YzOXhCejh6?=
 =?utf-8?B?YkNKUC8yd1lWUnREaHFNREx1Q1JvMnpUTkpSNC9qZndjeGhvK0JOc0xGdzlX?=
 =?utf-8?B?Vk1RYWNXcUwvWTY0d2g3RXY3R0pQcldaUzBtYTQrRTlnUEFJTkZnK01hanE3?=
 =?utf-8?B?bVZDQXNFS05PdXh5WS9MWUttbFZIOGErdGVkd3hzc1gxdVZ1RXhVbVNVc214?=
 =?utf-8?B?bFc4dHVwR29PWFhuK3pCODJBQ04yOVB0dW5xMEE3SDUxRVlpb09oZ291dXFo?=
 =?utf-8?B?ajRVSFg5cGIwQTlSSS92bGZ5U1RoZXQxWUdXWTNXZmtvQlA2TURFVlR5L2Ro?=
 =?utf-8?B?YjBHNENOSU1ZTkc2aTVVYk9sUXhvZ25HY3F4YXdLS1drSE8vazBhWmh1TTVH?=
 =?utf-8?B?ZG5ZSjhHTjJkUlVDaGR0Q3E3VVRBWjJVNGtFSnJrQ0NUMVZWUFA5VmFQbm1z?=
 =?utf-8?B?UjRKUkRVQ0RVNzIvUHpsRkZWZDlYOEtSRHZjM1FuVGpSRlFWRy9JOUVQS09Z?=
 =?utf-8?B?bUwxRFhLSWw0N21mYzZITHAzeUdmQ0Fnci9Ya01GTkwvSEthWGZkM21JS0pH?=
 =?utf-8?B?T1NLejNoRDRzejVQTFc5MFkwQTV6aitIV09WZmxydjR2cXY0elBrYXZmTjg1?=
 =?utf-8?B?RDE1UnF1TTdvTEY1bmtmMVFYN0lBV2xOcmQzeFdtd1ZXZEtpNkoyYXVKbXY5?=
 =?utf-8?B?SURmNHppL0t5S1dhcSsrZmRwcjVwSlB2djdXd0ZMVDJ2bE54bW5VclB0WHk0?=
 =?utf-8?B?WTZkYUIyTURRaTloVjM2Z1JxbXRBWmg1YU44RTExaFN3cnNSSW84blNlbUdM?=
 =?utf-8?B?Q1NSQndlbHpJMUtrcUc4Q0ROdUErcC9SLytWMlQ5MzFKdXBRN1d6cTFQRm1x?=
 =?utf-8?B?RDZ0UEhpa3E2VFRpdFlPajU2M3dDKzJyVk5aQ0l3SmVTV3Zka04yTjg4S04w?=
 =?utf-8?B?ZC84OVliaWtWMzV2ZFFldGwzS2JQTVNGYzdDNkxBb0RwbVRWb1dlQytic1lK?=
 =?utf-8?B?ZGFtdEczSUdaTEl0dWdrSlNMcFZGaVJhcHExSXN5OW9jenJhTDFVVExwUzJt?=
 =?utf-8?B?bUQxZmxrVDMxSVo5ZU96M0NBK1MzTUYxN2pPNk1COGY4RUtCZ29mUDI3OG00?=
 =?utf-8?B?OXEzVTFBWGlaRVNzRlAvT0o5TlVQZGJaRXVESlg5UDhOL3lPOG1nNmlwdXFB?=
 =?utf-8?B?am83OE1zNzVEeGhwM1RYZlNFc1Q0aHJ6dGF0L1UxOUxhVWVLeFZPMHJ1Qm92?=
 =?utf-8?B?SThwZHE1dW9Ka0ZMMWswZU5nOUxWTnlLVkhlUDNOTWlFOHJoOHZFcEJodXRy?=
 =?utf-8?B?dnBRb28rK2xLREdTRkVXZGdYbnVUZmluMGw5MVQ4TEY2UjJsbzE0aC9DMG5R?=
 =?utf-8?Q?P4ys=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b5e959f-28d6-4773-a349-08dbb9a00726
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 06:08:36.8918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cGYJY2/8Nv3xAErkpOesW9DJlAb22+yTXrpl0f1j7hNDK+QIplBW8IBIgmu2UImCgGKLV9DCo6FNIIBisaPtZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6740
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IFdlZG5lc2RheSwgU2VwdGVtYmVyIDIwLCAyMDIzIDExOjM2IEFNDQo+IA0KPiBPbiA5LzE5LzIw
MjMgMjo0OSBBTSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOg0KPiA+IE9uIE1vbiwgU2VwIDE4
LCAyMDIzIGF0IDA2OjQxOjU1UE0gKzAwMDAsIFBhcmF2IFBhbmRpdCB3cm90ZToNCj4gPj4+IFBs
ZWFzZSByZWZlciB0byB0aGUgY29kZSBmb3Igc2V0dGluZyBGRUFUVVJFU19PSy4NCj4gPj4gSXQg
d29udCB3b3JrIHdoZW4gb25lIG5lZWRzIHRvIHN1c3BlbmQgdGhlIGRldmljZS4NCj4gPj4gVGhl
cmUgaXMgbm8gcG9pbnQgb2YgZG9pbmcgc3VjaCB3b3JrIG92ZXIgcmVnaXN0ZXJzIGFzIGZ1bmRh
bWVudGFsDQo+IGZyYW1ld29yayBpcyBvdmVyIHRoZSBBUS4NCj4gPiBXZWxsIG5vdCByZWFsbHku
IEl0J3Mgb3ZlciBhZG1pbiBjb21tYW5kcy4gV2hlbiB0aGVzZSB3ZXJlIGJ1aWx0IHRoZQ0KPiA+
IGludGVudCBhbHdheXMgd2FzIHRoYXQgaXQncyBwb3NzaWJsZSB0byB1c2UgYWRtaW4gY29tbWFu
ZHMgdGhyb3VnaA0KPiA+IGFub3RoZXIgaW50ZXJmYWNlLCBvdGhlciB0aGFuIGFkbWluIHF1ZXVl
LiBJcyB0aGVyZSBhIHByb2JsZW0NCj4gPiBpbXBsZW1lbnRpbmcgYWRtaW4gY29tbWFuZHMgb3Zl
ciBhIG1lbW9yeSBCQVI/IEZvciBleGFtcGxlLCBJIGNhbiBzZWUNCj4gPiBhbiAiYWRtaW4gY29t
bWFuZCIgY2FwYWJpbGl0eSBwb2ludGluZyBhdCBhIEJBUiB3aGVyZSBjb21tYW5kcyBhcmUNCj4g
PiBzdXBwbGllZCwgYW5kIHVzaW5nIGEgbmV3IGdyb3VwIHR5cGUgcmVmZXJyaW5nIHRvIGRldmlj
ZSBpdHNlbGYuDQo+IEkgYW0gbm90IHN1cmUsIGlmIGEgYmFyIGNhcCB3b3VsZCBiZSBpbXBsZW1l
bnRlZCBhcyBhIHByb3h5IGZvciB0aGUgYWRtaW4gdnENCj4gYmFzZWQgbGl2ZSBtaWdyYXRpb24u
IHRoZW4gdGhlIHByb2JsZW1zIG9mIGFkbWluIHZxIExNIHRoYXQgd2UgaGF2ZSBkaXNjdXNzZWQN
Cj4gc3RpbGwgZXhpc3QuIHRoZSBiYXIgaXMgb25seSBhIHByb3h5LCBkb2Vzbid0IGZpeCBhbnl0
aGluZy4gYW5kIGV2ZW4gbGFyZ2VyIHNpZGUNCj4gY2hhbm5lbCBhdHRhY2tpbmcgc3VyZmFjZTog
dmYtLT5wZi0tPnZmDQoNCkFRIExNIHVzaW5nIFBGIGhhcyBubyBzaWRlIGNoYW5uZWwgYXR0YWNr
IGFzIGh5cGVydmlzb3IgYW5kIG93bmVyIGRldmljZSBpcyB0cnVzdGVkIGVudGl0eSBhcyBhbHJl
YWR5IGRpc2N1c3NlZC4NCg==

