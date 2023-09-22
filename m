Return-Path: <virtio-dev-return-13936-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764D3CD4F30
	for <virtio-dev@archiver.kernel.org>; Fri, 22 Sep 2023 08:07:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C1DB12AC58
	for <virtio-dev@archiver.kernel.org>; Fri, 22 Sep 2023 08:07:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BDA439866B7
	for <virtio-dev@archiver.kernel.org>; Fri, 22 Sep 2023 08:07:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AF76398621E; Fri, 22 Sep 2023 08:07:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9D53098669D;
	Fri, 22 Sep 2023 08:07:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KSTp8SOyW2toLbk2nwSltHz4/Iv1A4VFo1JxtT6mePKIR442q5C6HVBCYiVLvq0aeh+Zcmyn3cqeAOVlSE7EXxZlkwvuRT8UT91Jr8eQncF+WlOteI637R1p6192gBR+7/IaDQQIUyUA7qCJpFkt1a/mpaac7nnWYirJaO1wS6u62tikT1pJT2bzSodLHnVntcUbEc/zENxlvzbv9Gbcj4N1zCONfbeRkZaXmCFiMw3bBPTluOI8QM3M+IvBxrEFduw33PfNRhO2zENPictwlvv+u/cLvqFwXwOCzpSDKm8pLTsHXCCAHERV4Ts0R0jNQIH19jKVht2mJHPwwvCbYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCs+eKwJq9FOkN0bT+waw4ERkMzD1Z1GDVkqYvoDF4k=;
 b=ImP7PdJQjwmYuTEQdtqdlAPormO5zdzazRc27VAQXQZAg7XaAB0eZQ8Y41fHHIVK4T6nuhKMHqcEwJ62RTn5X/v+6ODqyFgvRlMOS5w3K4sxnmpnUT3oyRzMqF8n3XwR6pOzPFk2fP7MWXcCsNZ4vIf/CiKUM8hiz3FVg4UmmAjd2+w7FVR85e2L/7KVR/Z51WbvFiTL0544UssxyCIpkS+RZIPDTncN1WRofJHdlpRdBaWr9PwnQeA7i09c4dJg99O/XkjqIo6WC8fmEBUBhbwZ/j2qHFLZubCnTlpxoG7w2Pw0kt4SYiOa2YI5hMN7EQcC/NPf9wwtbvre4miwQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
From: "Chen, Jiqian" <Jiqian.Chen@amd.com>
To: Jason Wang <jasowang@redhat.com>
CC: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, David Airlie <airlied@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
	=?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Robert
 Beckett <bob.beckett@collabora.com>, Mikhail Golubev-Ciuchea
	<Mikhail.Golubev-Ciuchea@opensynergy.com>, Parav Pandit <parav@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Stefano
 Stabellini <sstabellini@kernel.org>, =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?=
	<roger.pau@citrix.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Koenig, Christian" <Christian.Koenig@amd.com>, "Hildebrand, Stewart"
	<Stewart.Hildebrand@amd.com>, Xenia Ragiadakou <burzalodowa@gmail.com>,
	"Huang, Honglei1" <Honglei1.Huang@amd.com>, "Zhang, Julia"
	<Julia.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>, "Chen, Jiqian"
	<Jiqian.Chen@amd.com>
Thread-Topic: [virtio-dev] Re: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add
 freeze_mode to virtio_pci_common_cfg
Thread-Index: AQHZ6u53lm7slkvYHEmC01qhzu9Vn7AksLcAgACjFgCAANz/gIAAzyqA
Date: Fri, 22 Sep 2023 08:07:05 +0000
Message-ID:
 <BL1PR12MB5849E38DE89D80B8A4CB7128E7FFA@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <CACGkMEuEXk2UzXU7sFUk-nHEeE7QoB3kbjnHgktY7KWuK71Xrg@mail.gmail.com>
 <BL1PR12MB58490A484087B2B2C37B6E43E7F8A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEtx-i_9dgdONFzEmmWYNRhaoJQZX7a5OmLfDvGoUaajPQ@mail.gmail.com>
In-Reply-To:
 <CACGkMEtx-i_9dgdONFzEmmWYNRhaoJQZX7a5OmLfDvGoUaajPQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-imapappendstamp: BL1PR12MB5849.namprd12.prod.outlook.com
 (15.20.6813.014)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|BL1PR12MB5377:EE_
x-ms-office365-filtering-correlation-id: e2397068-8ef6-4f83-7d5d-08dbbb42e941
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6S+UTLhNT4uh4BrGIU2VCSouzXuL+hhBnYUD26EuHbfNln+F520X8R/QnONNJxh5R6gVvWufAdWzyL7xupQzcBphSo2/FqIv2uqNVfg8xg7OyKS9D+z6t3No1VrgDVE7fIGepYVGkSMBdF3QyULgsfwCDyawmXS1a16g6mNlM45699PgnFMQb8mhpRxzzbTJqNsmTq2bGWxX5BG5mtM/XaSUwkdJpJpqIpKWW98qUQiQlY9m5i+3bFNPOhG/dqEUlz8QiKg+HTl97zOUUz8qpjlaXpy3GdMBIp80CmQvMqUXW32jrimgs0R7Qbfcef/czeWQUFqgNJQSfElBpJVcSVFLEvz6s8HM/JBG3gSMNgPwRRY47M7LLxP4RxJj/G+zSYJtqSF/UB/1xfeNWNFlLC8fauc8xnSWm4QzHoZciTl+hGerqXSwzXoTEHrEw1GMbZ9qr+vAAaURZNu1fTH1qpoPzqvw0DrPXV0rrMFgSztquCDrwGlVxs2v9uv5fsblzKiYDownYz9eCPvzajlMDdU03QbGo3+NULRmxMElknYEryja5jNgL2gQqY8HnN3ER0l0cgQ2Dk0XtNrIic/v3kAaUcm3JfvLu4gzqfwremw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(366004)(39860400002)(186009)(1800799009)(451199024)(66899024)(6506007)(7696005)(53546011)(9686003)(26005)(71200400001)(33656002)(76116006)(966005)(66946007)(478600001)(122000001)(38100700002)(38070700005)(83380400001)(66446008)(66476007)(55016003)(66556008)(8676002)(8936002)(4326008)(52536014)(316002)(6916009)(54906003)(64756008)(5660300002)(41300700001)(2906002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Mko4MkVuRUp0VTZ3NjVJaTgvVWpwWlF4SVY4WEtVRXN3T21vL1h6TUhtamlz?=
 =?utf-8?B?YWdLYk43Q2hVdEQxUEFwM3N3WjVEaG1aZkN0UFBRR2VmUUUyWld6MTFtUlJP?=
 =?utf-8?B?a1hqbDVDREtXKzcwYnVSREpucVZZOGQ4TVNNZDBncVZkQUYvdmI3WHhUVTEz?=
 =?utf-8?B?R0t1eG1GTW1CWUlWUXRWbWpzY2lxVHVvZnNQM1ViQmc3KzNuSHdBZVNXZFkz?=
 =?utf-8?B?RFBEUlpZeXBabXdJVW5CTC9JaUVFSDZaK3E3VlQ3TXR0YWxjQ25ob3VyN281?=
 =?utf-8?B?bytmWXRRZFowZVlmbm1heXpub0pCa1ZOVGJ1L1VzaTcrZWxOeXVmczFDU1JM?=
 =?utf-8?B?aXlmR3NuZXpZYkY2K20xZFp1ckdteXZhWTdDc0RzTlR3KzVLVzJuVXRyc0hR?=
 =?utf-8?B?ZmdZaWFORkQxQnZ6R0ZYVFFJSkhTcmkxZDlwdC9qL1gydU5hb1F3dHg2c0x4?=
 =?utf-8?B?OTczOG9wS2RkSjcvY0F1YW1ua2VteS9sRzdGTmpBTWl4ZzNkTjRJdWlZc200?=
 =?utf-8?B?Zk4rcng5cHNjS3JpSkhMK0F4cjlORGk4Y09ZKzNaYjA2NnkxdFcvbUd3VzVK?=
 =?utf-8?B?ZEllRjFpRFhrKytzeHZRL1hQZFVwMXFxSlBrcStPOERueGdYVXRUWGMxMHpX?=
 =?utf-8?B?dnBtSGY0Wk96aHFQVjR6YkdISXJNbEtob2txR1UxcEZLcDh0Wk5SMFMyQ1o2?=
 =?utf-8?B?OUczR2FiZWFWeUF2VHRtZDZ3S2grK1JDZ085ZCtsc3NNUGRzektHMUl1eWNp?=
 =?utf-8?B?ZE4xUzR0L2lzNkZXL3BVUHI0aXM3aGgzN2EwdzQ0VTU0QVhJNkFHcDBwRDBV?=
 =?utf-8?B?U0llZGx3dnB2V0RVcmkzTHhKZGpUSHh0eDhqTUxBUS8vU3VsNmRHeFIrbmF1?=
 =?utf-8?B?Q09KUEJWSmoxand3KzhkZS9QVi9oUS9qS094NEd5VXU0UTlxckRnYlFoWnRC?=
 =?utf-8?B?RFl3dDhtTk9DMXlObVA5Wm5mYVlKbnBTbkpMMnFNdU4xQitPZFd3akYxam44?=
 =?utf-8?B?aGQxUTVZNlF2dm5KOHJ1ZlFmcXQxQzVMZks2dmRkb1ZaNVBWQmRqUjQrNzEz?=
 =?utf-8?B?UUJVaDRWemMxeXRiWlcrR2pXZ1ZIc1JXTWUrVlhjZkIzRStGZURtM0hkTmJ0?=
 =?utf-8?B?cS9oM3NFTVBXdzlWZ1MrbGZmRkF6QnZmNm04bHJUdE1LSG41WXdGUHdUM1VZ?=
 =?utf-8?B?aFpQaWxKcTh6dDhEMEJVYWJ5eElWZkdjd2VVYU4zV0RVcStsSU90dC9KZDR5?=
 =?utf-8?B?ZkxUZ0dhdnNjY0NBYXNxZjR2WGJ2aU1wUTUrWU0zc3VDWjBMUStVb25aZWpx?=
 =?utf-8?B?QVByNGxkZDZFbTZRYVVMQWFpcHBhTGFQa0ROM28zQ1BZWmpLQ0Y2cnM2MFJP?=
 =?utf-8?B?RzFrUzRuZFJuQWdFUnprQnUrWGxNRFBlVXMrbXpiaHVud09rZWZPMGtINHlZ?=
 =?utf-8?B?b2tBeXVxejVldlFCOUtCVDNUMGVrclh4ZW1rL0pveXBmb0VZUnVBT1B4M3NH?=
 =?utf-8?B?bEpjWnFudnkrdlhrNzNQNkxTQityKzNQTlNOS2dPVDhlN1Q4VkpsMnBjVzU5?=
 =?utf-8?B?Q0IvUktxdHJUTk53elZwRTd2RTIrd09QaHdhRkZPQWVRMFRid0IzT0VVTlo1?=
 =?utf-8?B?R0FpTHF4OG94eWFCaVJKVEJyNlFBMk56cFNVVmNOd3E2OVhNdm9ZQ2JzaExE?=
 =?utf-8?B?OUx0SGxmOVV2WEU0WGxDUmxhNHlta2YzdUFVV21pNS9pNm9mMHZ2akt4OC9o?=
 =?utf-8?B?ajZ3YXVNVWR2UHl3aWdhRkExTERyZkt2QmNPZGpwU2Zrd0hCZE5SK2VXVGtp?=
 =?utf-8?B?bzlOY3NieDc1RGkyd1owWWVBOWJBc2xndmxXWlBrZWhqUkNIdmZvVURpNzQz?=
 =?utf-8?B?ZnUwdTZYYUZUMDZwcFE0dDRnZ1J0cDlsMHp2WXNuVXQya2RDdjg0bG5LWXVi?=
 =?utf-8?B?UHdFclMwK2YxS0lPVUlXRU1VTWZGRjNCdlZ3dXo1cWQ2dEczUnNBMyt6RGRn?=
 =?utf-8?B?bHUrOXRSb0dtc1hjZ3UzRlNPdERLMXJUSCt3T213S3JVRFEvTnRia0JWZ2hv?=
 =?utf-8?B?eVdRSVVjVTJRTFc3MnpDNnZVVC9qclJRMHZRUE9zVVR6QjNNSlF4M3BUKzZt?=
 =?utf-8?Q?3lWk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7503DA2E58C64E498348D5FFAFE1D1FB@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2397068-8ef6-4f83-7d5d-08dbbb42e941
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 08:07:05.8231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h2MQrxG+y5+frECbn5aED3srzcHRK943QWqyVAHsd0TrVOhw4Ga40TGg0tM5roRKBYYJlLYyoQ+jNdUlV6eEwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5377
Subject: Re: [virtio-dev] Re: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add
 freeze_mode to virtio_pci_common_cfg

SGkgSmFzb24sDQoNCk9uIDIwMjMvOS8yMiAxMToxNywgSmFzb24gV2FuZyB3cm90ZToNCj4gT24g
VGh1LCBTZXAgMjEsIDIwMjMgYXQgMjoyOOKAr1BNIENoZW4sIEppcWlhbiA8SmlxaWFuLkNoZW5A
YW1kLmNvbT4gd3JvdGU6DQo+Pg0KPj4gSGkgSmFzb24sDQo+Pg0KPj4gT24gMjAyMy85LzIxIDEy
OjIyLCBKYXNvbiBXYW5nIHdyb3RlOg0KPj4+IE9uIFR1ZSwgU2VwIDE5LCAyMDIzIGF0IDc6NDPi
gK9QTSBKaXFpYW4gQ2hlbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4gd3JvdGU6DQo+Pj4+DQo+Pj4+
IFdoZW4gZ3Vlc3Qgdm0gZG9lcyBTMywgUWVtdSB3aWxsIHJlc2V0IGFuZCBjbGVhciBzb21lIHRo
aW5ncyBvZiB2aXJ0aW8NCj4+Pj4gZGV2aWNlcywgYnV0IGd1ZXN0IGNhbid0IGF3YXJlIHRoYXQs
IHNvIHRoYXQgbWF5IGNhdXNlIHNvbWUgcHJvYmxlbXMuDQo+Pj4+IEZvciBleGNhbXBsZSwgUWVt
dSBjYWxscyB2aXJ0aW9fcmVzZXQtPnZpcnRpb19ncHVfZ2xfcmVzZXQgd2hlbiBndWVzdA0KPj4+
PiByZXN1bWUsIHRoYXQgZnVuY3Rpb24gd2lsbCBkZXN0cm95IHJlbmRlciByZXNvdXJjZXMgb2Yg
dmlydGlvLWdwdS4gQXMNCj4+Pj4gYSByZXN1bHQsIGFmdGVyIGd1ZXN0IHJlc3VtZSwgdGhlIGRp
c3BsYXkgY2FuJ3QgY29tZSBiYWNrIGFuZCB3ZSBvbmx5DQo+Pj4+IHNhdyBhIGJsYWNrIHNjcmVl
bi4gRHVlIHRvIGd1ZXN0IGNhbid0IHJlLWNyZWF0ZSBhbGwgdGhlIHJlc291cmNlcywgc28NCj4+
Pj4gd2UgbmVlZCB0byBsZXQgUWVtdSBub3QgdG8gZGVzdHJveSB0aGVtIHdoZW4gUzMuDQo+Pj4+
DQo+Pj4+IEZvciBhYm92ZSBwdXJwb3NlLCB3ZSBuZWVkIGEgbWVjaGFuaXNtIHRoYXQgYWxsb3dz
IGd1ZXN0cyBhbmQgUUVNVSB0bw0KPj4+PiBuZWdvdGlhdGUgdGhlaXIgcmVzZXQgYmVoYXZpb3Iu
IFNvIHRoaXMgcGF0Y2ggYWRkIGEgbmV3IHBhcmFtZXRlcg0KPj4+PiBuYW1lZCBmcmVlemVfbW9k
ZSB0byBzdHJ1Y3QgdmlydGlvX3BjaV9jb21tb25fY2ZnLiBBbmQgd2hlbiBndWVzdA0KPj4+PiBz
dXNwZW5kcywgaXQgY2FuIHdyaXRlIGZyZWV6ZV9tb2RlIHRvIGJlIEZSRUVaRV9TMywgYW5kIHRo
ZW4gdmlydGlvDQo+Pj4+IGRldmljZXMgY2FuIGNoYW5nZSB0aGVpciByZXNldCBiZWhhdmlvciBv
biBRZW11IHNpZGUgYWNjb3JkaW5nIHRvDQo+Pj4+IGZyZWV6ZV9tb2RlLiBXaGF0J3MgbW9yZSwg
ZnJlZXplX21vZGUgY2FuIGJlIHVzZWQgZm9yIGFsbCB2aXJ0aW8NCj4+Pj4gZGV2aWNlcyB0byBh
ZmZlY3QgdGhlIGJlaGF2aW9yIG9mIFFlbXUsIG5vdCBqdXN0IHZpcnRpbyBncHUgZGV2aWNlLg0K
Pj4+DQo+Pj4gQSBzaW1wbGUgcXVlc3Rpb24sIHdoeSBpcyB0aGlzIGlzc3VlIHNwZWNpZmljIHRv
IHBjaT8NCj4+IEkgdGhvdWdodCB5b3UgcG9zc2libHkgbWlzc2VkIHRoZSBwcmV2aW91cyB2ZXJz
aW9uIHBhdGNoZXMuIEF0IHRoZSBiZWdpbm5pbmcsIEkganVzdCB3YW50ZWQgdG8gYWRkIGEgbmV3
IGZlYXR1cmUgZmxhZyBWSVJUSU9fR1BVX0ZfRlJFRVpFX1MzIGZvciB2aXJ0aW8tZ3B1IHNpbmNl
IEkgZW5jb3VudGVyZWQgdmlydGlvLWdwdSBpc3N1ZSBkdXJpbmcgZ3Vlc3QgUzMsIHNvIHRoYXQg
dGhlIGd1ZXN0IGFuZCBxZW11IGNhbiBuZWdvdGlhdGUgYW5kIGNoYW5nZSB0aGUgcmVzZXQgYmVo
YXZpb3IgZHVyaW5nIFMzLiBCdXQgUGFyYXYgYW5kIE1pa2hhaWwgaG9wZWQgbWUgY2FuIGltcHJv
dmUgdGhlIGZlYXR1cmUgdG8gYSBwY2kgbGV2ZWwsIHRoZW4gb3RoZXIgdmlydGlvIGRldmljZXMg
Y2FuIGFsc28gYmVuZWZpdCBmcm9tIGl0LiBBbHRob3VnaCBJIGFtIG5vdCBzdXJlIGlmIGV4cGFu
ZGluZyBpdHMgaW5mbHVlbmNlIGlzIGFwcHJvcHJpYXRlLCBJIGhhdmUgbm90IHJlY2VpdmVkIGFu
eSBmZWVkYmFjayBmcm9tIG90aGVycywgc28gSSBjaGFuZ2UgaXQgdG8gdGhlIHBjaSBsZXZlbCBh
bmQgbWFkZSB0aGlzIHZlcnNpb24uDQo+PiBJZiB5b3UgYXJlIGludGVyZXN0ZWQsIHBsZWFzZSBz
ZWUgdGhlIHByZXZpb3VzIHZlcnNpb246IGh0dHBzOi8vbGlzdHMub2FzaXMtb3Blbi5vcmcvYXJj
aGl2ZXMvdmlydGlvLWNvbW1lbnQvMjAyMzA3L21zZzAwMjA5Lmh0bWwsIHRoYW5rIHlvdS4NCj4g
DQo+IFRoaXMgaXMgbm90IGEgZ29vZCBhbnN3ZXIuIExldCBtZSBhc2sgeW91IGRpZmZlcmVudGx5
LCB3aHkgZG9uJ3QgeW91DQo+IHNlZSBpdCBpbiBvdGhlciBmb3JtcyBvZiB0cmFuc3BvcnQgbGlr
ZSB2aXJ0aW8tZ3B1LW1taW8/DQpTb3JyeSBmb3Igbm90IHVuZGVyc3RhbmRpbmcgeW91ciBxdWVz
dGlvbiBiZWZvcmUuIERpZCB5b3UgbWVhbiB3aHkgZGlkIEkgYWRkIGZyZWV6ZV9tb2RlIGZvciB2
aXJ0aW8tcGNpIHR5cGUgZGV2aWNlcyBpbnN0ZWFkIG9mIHZpcnRpby1tbWlvIHR5cGUgZGV2aWNl
cz8NCklmIHRoYXQncyB0aGUgY2FzZSwgaXQgaXNuJ3Qgd2VsbCB0aG91Z2h0IG91dCBieSBtZSwg
YmVjYXVzZSB0aGVyZSBpcyBvbmx5IHZpcnRpby1ncHUgd2l0aCBwY2kgc3VwcG9ydCBpbiBteSBl
bnZpcm9ubWVudCwgc28gSSwgYXMgYSBtYXR0ZXIgb2YgY291cnNlLCBpbXByb3ZlIGl0IGZyb20g
dmlydGlvLWdwdS1wY2kgdG8gYSB2aXJ0aW8tcGNpIGxldmVsIGluc3RlYWQgb2YgdmlydGlvLW1t
aW8uDQpEbyB5b3UgdGhpbmsgSSBuZWVkIHRvIGFkZCBmcmVlemVfbW9kZSBmb3IgdmlydGlvLW1t
aW8gdG9vPyBPciBpbXByb3ZlIGl0IHRvIGEgaGlnaGVyIGxldmVsLCBsaWtlIHZpcnRpby1idXM/
IEkgYW0gbG9va2luZyBmb3J3YXJkIHRvIGdldHRpbmcgeW91ciBzdWdnZXN0aW9ucywgdGhhbmtz
Lg0KDQo+IA0KPiBUaGFua3MNCj4gDQo+Pg0KPj4+DQo+Pj4gVGhhbmtzDQo+Pj4NCj4+Pg0KPj4+
Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBKaXFpYW4gQ2hlbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4N
Cj4+Pj4gLS0tDQo+Pj4+ICB0cmFuc3BvcnQtcGNpLnRleCB8IDcgKysrKysrKw0KPj4+PiAgMSBm
aWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPj4+Pg0KPj4+PiBkaWZmIC0tZ2l0IGEvdHJh
bnNwb3J0LXBjaS50ZXggYi90cmFuc3BvcnQtcGNpLnRleA0KPj4+PiBpbmRleCBhNWM2NzE5Li4y
NTQzNTM2IDEwMDY0NA0KPj4+PiAtLS0gYS90cmFuc3BvcnQtcGNpLnRleA0KPj4+PiArKysgYi90
cmFuc3BvcnQtcGNpLnRleA0KPj4+PiBAQCAtMzE5LDYgKzMxOSw3IEBAIFxzdWJzdWJzZWN0aW9u
e0NvbW1vbiBjb25maWd1cmF0aW9uIHN0cnVjdHVyZSBsYXlvdXR9XGxhYmVse3NlYzpWaXJ0aW8g
VHJhbnNwb3J0DQo+Pj4+ICAgICAgICAgIGxlNjQgcXVldWVfZGVzYzsgICAgICAgICAgICAgICAg
LyogcmVhZC13cml0ZSAqLw0KPj4+PiAgICAgICAgICBsZTY0IHF1ZXVlX2RyaXZlcjsgICAgICAg
ICAgICAgIC8qIHJlYWQtd3JpdGUgKi8NCj4+Pj4gICAgICAgICAgbGU2NCBxdWV1ZV9kZXZpY2U7
ICAgICAgICAgICAgICAvKiByZWFkLXdyaXRlICovDQo+Pj4+ICsgICAgICAgIGxlMTYgZnJlZXpl
X21vZGU7ICAgICAgICAgICAgICAgLyogcmVhZC13cml0ZSAqLw0KPj4+PiAgICAgICAgICBsZTE2
IHF1ZXVlX25vdGlmX2NvbmZpZ19kYXRhOyAgIC8qIHJlYWQtb25seSBmb3IgZHJpdmVyICovDQo+
Pj4+ICAgICAgICAgIGxlMTYgcXVldWVfcmVzZXQ7ICAgICAgICAgICAgICAgLyogcmVhZC13cml0
ZSAqLw0KPj4+Pg0KPj4+PiBAQCAtMzkzLDYgKzM5NCwxMiBAQCBcc3Vic3Vic2VjdGlvbntDb21t
b24gY29uZmlndXJhdGlvbiBzdHJ1Y3R1cmUgbGF5b3V0fVxsYWJlbHtzZWM6VmlydGlvIFRyYW5z
cG9ydA0KPj4+PiAgXGl0ZW1bXGZpZWxke3F1ZXVlX2RldmljZX1dDQo+Pj4+ICAgICAgICAgIFRo
ZSBkcml2ZXIgd3JpdGVzIHRoZSBwaHlzaWNhbCBhZGRyZXNzIG9mIERldmljZSBBcmVhIGhlcmUu
ICBTZWUgc2VjdGlvbiBccmVme3NlYzpCYXNpYyBGYWNpbGl0aWVzIG9mIGEgVmlydGlvIERldmlj
ZSAvIFZpcnRxdWV1ZXN9Lg0KPj4+Pg0KPj4+PiArXGl0ZW1bXGZpZWxke2ZyZWV6ZV9tb2RlfV0N
Cj4+Pj4gKyAgICAgICAgVGhlIGRyaXZlciB3cml0ZXMgdGhpcyB0byBzZXQgdGhlIGZyZWV6ZSBt
b2RlIG9mIHZpcnRpbyBwY2kuDQo+Pj4+ICsgICAgICAgIFZJUlRJT19QQ0lfRlJFRVpFX01PREVf
VU5GUkVFWkUgLSB2aXJ0aW8tcGNpIGlzIHJ1bm5pbmc7DQo+Pj4+ICsgICAgICAgIFZJUlRJT19Q
Q0lfRlJFRVpFX01PREVfRlJFRVpFX1MzIC0gZ3Vlc3Qgdm0gaXMgZG9pbmcgUzMsIGFuZCB2aXJ0
aW8tcGNpIGVudGVycyBTMyBzdXNwZW5zaW9uOw0KPj4+PiArICAgICAgICBPdGhlciB2YWx1ZXMg
YXJlIHJlc2VydmVkIGZvciBmdXR1cmUgdXNlLCBsaWtlIFM0LCBldGMuDQo+Pj4+ICsNCj4+Pj4g
IFxpdGVtW1xmaWVsZHtxdWV1ZV9ub3RpZl9jb25maWdfZGF0YX1dDQo+Pj4+ICAgICAgICAgIFRo
aXMgZmllbGQgZXhpc3RzIG9ubHkgaWYgVklSVElPX0ZfTk9USUZfQ09ORklHX0RBVEEgaGFzIGJl
ZW4gbmVnb3RpYXRlZC4NCj4+Pj4gICAgICAgICAgVGhlIGRyaXZlciB3aWxsIHVzZSB0aGlzIHZh
bHVlIHdoZW4gZHJpdmVyIHNlbmRzIGF2YWlsYWJsZSBidWZmZXINCj4+Pj4gLS0NCj4+Pj4gMi4z
NC4xDQo+Pj4+DQo+Pj4NCj4+Pg0KPj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4+IFRvIHVuc3Vic2NyaWJl
LCBlLW1haWw6IHZpcnRpby1kZXYtdW5zdWJzY3JpYmVAbGlzdHMub2FzaXMtb3Blbi5vcmcNCj4+
PiBGb3IgYWRkaXRpb25hbCBjb21tYW5kcywgZS1tYWlsOiB2aXJ0aW8tZGV2LWhlbHBAbGlzdHMu
b2FzaXMtb3Blbi5vcmcNCj4+Pg0KPj4NCj4+IC0tDQo+PiBCZXN0IHJlZ2FyZHMsDQo+PiBKaXFp
YW4gQ2hlbi4NCj4gDQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KSmlxaWFuIENoZW4uDQo=

