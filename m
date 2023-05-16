Return-Path: <virtio-dev-return-12724-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82386C77B7A
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 19:11:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D5CB8339B8
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 19:11:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D1733986602
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 19:11:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C599E986520; Tue, 16 May 2023 19:11:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B0F4A986549;
	Tue, 16 May 2023 19:11:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmoeiYX25rmP867PhTj6URLZ+78ksq0xNDQmHxpHde4D4fEwrQ6vKmFF7Aqe042Zhmi0wFr4Ao2F1tUDPIXoVnDNuYL86uyDxcwsJ/fVC5HSJ1vigoKb1iR5j84Q0bhWraGB+xkPMB0W3R5gAklQmfm5+iQgaaFXJuPL7d2wNKW0BKcVCwbn57YE4ScT2pyoEM9RCm+IC0sFvBM//sU5XcJvKj9SwaRrB6tgSHd6KkpqMhU/ojMXmhkJckSFk8bIchXJvC8DLV4cw2hP3i1RanxzimxzvzngTGVECJrGVm5PaKL1+mQEH2i3j2nKFuAqaOJpc8kURJ8lY2aQZUM6lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZO49a1dWYbBk8vW3wUUvq7DnOxKg5c9PHkD+FHj4ws=;
 b=KTpsetBLQWk80ppwHoAwt/O8B+br/zBCbjyHk2t0UzFl80FQk8tNuLtZlwvIlDyvg2wTUuFLIp/YFnZ9xNnNCIEe/rNj2z27pcJiOWLrA8Z20/1s5+Zqmz6F71uMIOFv3/rFXZdNNUHSNOqcBocokWJNFONVufVnXaZBPDps+NkG62zWjNAvJA/HjqCFIlsZAcC27Qpm+9ZPfa16BqHeUNzV8fnSCDAHoX7NRnpTMDZKiK6XFeC5nHWa2yfALWnzG80yVTZkNPhUvuYPmea5SiS3+9C6SeumosCkTexSxHmDnJ9pVnbiZP6bVkO9XitjiZVOrcjvd0fBMXBrxvt6jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>, Yishai Hadas <yishaih@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ
Thread-Index:
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9Mhl4AgAJOSwCAANQugIADYnEAgAAP1ICAAAu1gIABh4gAgABhyYCAAABooIAF7m6AgACLkzCAAPN2gIAA1fCg
Date: Tue, 16 May 2023 19:11:36 +0000
Message-ID:
 <PH0PR12MB54816BF1E277820C594A6344DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
 <CACGkMEvTs9oMewgrQpYZu1v1wdUXtxsvjqB6CPRf+y4C8EN_KQ@mail.gmail.com>
 <20230510033812-mutt-send-email-mst@kernel.org>
 <CACGkMEsp0i7EyyBBp06wJzrVBLNbH7MP_TT-j7b5c_yavgAmqw@mail.gmail.com>
 <20230511085205-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812F2EFEC7B6A235953A82DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <0f75a142-71e9-676a-11ae-a54e6dbb472d@redhat.com>
 <PH0PR12MB548136C3582B9DE232AEFDE5DC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230516021401-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230516021401-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ2PR12MB9244:EE_
x-ms-office365-filtering-correlation-id: a57fc565-668b-4d1b-8214-08db56415e91
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 PfypKJ32OxqH/S/KZGbMadP7AG9xGtLT0ibj3FxmzCFzdpVQx5Vr5O/dvfgjQxIssxCaJ09bwzA3JlmPEUiPyvSeJTfnDwVGr+WiRTnwvoAcOFM8XHBHzN6khpFaM/i9eXkBspNbs/WAEDik9hI91sUIAM/WhCAXo1SDgPKpOxsAIlg3RGnSwUXXaG+ar2eu1Qo4NLz88L/fLibRhTp5HTZ6BOY2r1V75YY1l01zGCLRlXrG9Dy1fuISA3soIPlZamYjjSF45i3BkscA1NHqXBe02u8zTKSOiiHiVF9S7pR4FCyYhr4L2o3yHpsgFxBTFvdhpnyMzPXNrMy20YmEWaeePMY/zQTD2xYm1OP9wrl+zQzLm/f5evzHar6NNX+QlXnCjjeaejXfohPpvJkgDEhiS6gmtX0VAyVhg8jlm0GpKyWON4EP6Y19NG9FWV42h32O5WCFF4Ikg+uPx0zMQ4mdNar01/nZFRe/tN2lfFO6GkzCnasliNjeVoKAgOBt1254NFZ7P+FvCDlACT5UkrfFN+q7uI707KAgrHYDUm8EInx4DYhgn7CzDBNwTAhFBrX1EVbAAH1cNijqx+xoTQ9WMovxEurLK1mM5ToW3irob/ewLWlplAxlQMZ5njqx
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(451199021)(83380400001)(5660300002)(33656002)(8936002)(52536014)(8676002)(122000001)(316002)(86362001)(38070700005)(2906002)(54906003)(186003)(107886003)(6506007)(66946007)(9686003)(478600001)(26005)(66899021)(55016003)(6916009)(66446008)(66476007)(76116006)(41300700001)(66556008)(64756008)(38100700002)(4326008)(7696005)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VHNySWQrVHFxMUxLd2VERjdmODFTRGkvODg0TmtjeVZ2YVVOZzVFbTU4YWRB?=
 =?utf-8?B?aFh3by9GZTZ1THdYZm9JWXJTcCtFcnB6bFFtSDdFajd5dHNnS3hsSFVMZlIr?=
 =?utf-8?B?TDlXRW1ST001c1lnUW1zOVpRLzR3dmdCakdOYThra0tNZkVrQWZEUDh1Vmhy?=
 =?utf-8?B?UzJ1a1F1ZkVzdXpscU1qUUIrcmZPejhUN3V3RnFHajByWVhBN2RKLzRiSk5J?=
 =?utf-8?B?RkxCQm5YTWdhMGNiVGtWdGZ2bXlhVWpCcEJ2QXlaaHBycytaaGtrVkgvS01y?=
 =?utf-8?B?KytQdFlYRUNIRjAzZjZCcm53ZktSY2dsNFNNQnljaEV3Uks3R1VvbVF6S0p3?=
 =?utf-8?B?bm94alB3aGQrcitoK2s2RThkVWhIMGlEcTBZaDkwQzZUczFSNTRHWTZvN0dq?=
 =?utf-8?B?Sm5TbjROblBnL2EyK1lFaTZlNEYyUkd0Y3pqN3ZBT1hnU1Y0WkljZFBjeEVi?=
 =?utf-8?B?dTlGWGRVMlY3VEMvVXZVeGova2dEYzFMYm5Nb1V3ZTdWeEtIaEI5SHhGeTdk?=
 =?utf-8?B?NTYzQTloaW5CY2VjSU4yQUxTY0VSRkRIak5EQnU0RHJEc01jdGVtOGo1MGZO?=
 =?utf-8?B?aXBaQ3JPZmhoRmdVWVU4MkRsc1k3dUdJSUh1WElnMWhuUGxuZEZQQUNNUkow?=
 =?utf-8?B?TVo2MXJ3Tm82UmNLeEdlYVRNc1RHOU5JNVZiNlBUM21Pc29HWVNzcGlTMHcv?=
 =?utf-8?B?TVlGYUs2QXo1ZXAwY3l1MUtZay9Pa09pLzdORnJ0YTVlTi9Ya1Z1R0x5QmtP?=
 =?utf-8?B?R2t6MUJlaVc0REpKVG94MzRtYVBjQWZ1THFmQ0F2NjhDTlRROWtWWldxbTRU?=
 =?utf-8?B?d3pSRUwrM1J6Ui9MQ0hvckQ5eFd4bjJaQlo3UE83T2pQWjZZdUE2Q3N1bmph?=
 =?utf-8?B?NFErRDY2SnpUYlZySHFTUkFKc0lhcm5yWG5lcjdGb3hDVEdPdEV5Tkk1OEtJ?=
 =?utf-8?B?TWlkMjA2c0FjSGxGMnBvQngyUUlqVHBDYS82YWVMTkxZNjVqNWkrYnVZM2Jl?=
 =?utf-8?B?WGd3WDM3R290YnI2d3BqYTRzRGhlR3BYVVlYenZEUjA0emxkRjUrbDE0OFlW?=
 =?utf-8?B?VHVubGF5YUJVWngvUCsxQllBQ3pHRjkwTWxSV0U3QnpEWk9tMElkcjM4SnI3?=
 =?utf-8?B?Ynp3VXBUcGJabkN2bWh3VkVsakVnMXBKVGRYVWhrSnhGM0tyUys3emdteXcv?=
 =?utf-8?B?dWNoeEsrbVpad3Q5NlZOeGdLRTE5Mk1BbkRVNmJ0ZmUyUmp1QlNlRHRzSU1n?=
 =?utf-8?B?SER1aXAxdHVWOGFsaWFIbDBCWWtWeDRmNlVTb3F4Y1lsNitGTkdBZDNwYTMr?=
 =?utf-8?B?Zlh5T3FLaS9kNzFHZWNpeTIzMWV6ZzVnODZ0MXc0b0kyN2tEY1RmQnYwd0x4?=
 =?utf-8?B?NUR5RVkzSkJURnM4MGRIT1VmV2QvaDBPdFJIU3VWWW16Y2pveU5GUFMyRDla?=
 =?utf-8?B?SXBVVHlpc1dQckFQam9abUlmQllBbnJ2d3NmUnk2WmdjS2FFSm1EWmFwNW54?=
 =?utf-8?B?UHUrZlk1WUl4TWZFMzBER2hYOWdjYm9IY2FobDh1WW0wYmZhdEpiVVhRbjJK?=
 =?utf-8?B?MnRVczRzTmZQU0d0blYwOEFLRUhScnpYeEt0Qmk4RDdvSldlY3BnYXVSa0s0?=
 =?utf-8?B?U2NmeFV4Y2NmdXlqL3pKOGJEdVVkZWJBT04vNjYwdHJnRjdyaUFpc3I4V1cx?=
 =?utf-8?B?UVVEUjZ1RjVPNE0zT0hPOTlPRk42bUltcXpOMjlhMjMxWW1VTTFNR2l2K0pO?=
 =?utf-8?B?RUYvV2lneXl0NzZtRG1aN216TlBibmt1bm9mdFZUcGxqeGQwNnh1TUpuTWYv?=
 =?utf-8?B?YmJJK29qcXc4SE5LU0RQNTF3enk2elk1bS9ld2VvR2xvWHh0VDAwZ2xJcEZn?=
 =?utf-8?B?V0NQTllXc3F2V1VHaEFMZ3pMWHZzMVFJV0o2azZXSmdnMG50WUR2R2RwNUQ0?=
 =?utf-8?B?b0hMRndDaWltUHQ5aTk4TFJmODV6dVlFeWt5SlZLdnRuQ0dhbDYxTVVWL2FG?=
 =?utf-8?B?VUVSZVJ0WDM1cTlZbVU5NXVjZXZoMkltZEYxaHkybmhpcmJGNGJmYmFwZ09N?=
 =?utf-8?B?c3Eva0FUYkNuVllSb3VrODVtVzZrQnh2cEZtQzk0b2lteEREZDlkNHMwZm0y?=
 =?utf-8?Q?xMyA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a57fc565-668b-4d1b-8214-08db56415e91
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 19:11:36.2178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M4drzwatJMEFmvmavlXFPQiIxt7e0kLmdQTMrUXD1TWDTYihDArWWu2IbfGFFty8seZ7pBZSOk/2DLTg7EDgVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9244
Subject: [virtio-dev] RE: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

DQo+IEZyb206IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1
ZXNkYXksIE1heSAxNiwgMjAyMyAyOjIyIEFNDQo+IA0KPiBPbiBNb24sIE1heSAxNSwgMjAyMyBh
dCAwMzo1OTo0MVBNICswMDAwLCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+ID4NCj4gPiA+IEZyb206
IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+ID4gPiBTZW50OiBNb25kYXksIE1h
eSAxNSwgMjAyMyAzOjMxIEFNDQo+ID4NCj4gPiA+ID4gV2hhdCBkbyB3ZSBnYWluIGZyb20gYmlz
ZWN0aW5nIGl0Pw0KPiA+ID4NCj4gPiA+DQo+ID4gPiAxKSBObyBuZWVkIHRvIGRlYWwgd2l0aCB0
aGUgb2Zmc2V0IGluIHRoZSBoYXJkd2FyZQ0KPiA+ID4NCj4gPiBJbiBjb250ZXh0IG9mIGxlZ2Fj
eSBpcyBkb2VzbuKAmXQgbWF0dGVyIG11Y2ggZ2l2ZW4gdGhhdCBpdHMgb3ZlciBBUS4NCj4gDQo+
IExldCBtZSBnaXZlIHlvdSBhbiBleGFtcGxlLiBJIGZlZWwgdGhhdCBkZXZpY2Ugc3BlY2lmaWMg
Y29uZmlnIHNob3VsZCBhbGxvdw0KPiBhcmJpdHJhcnkgbGVuZ3RoIGFjY2Vzc2VzIHNvIHRoYXQg
ZS5nLg0KPiBtYWMgY2FuIGJlIHJlYWQgYW5kIHdyaXR0ZW4gYXRvbWljYWxseS4NCj4gDQo+IE9u
IHRoZSBvdGhlciBoYW5kLCB0aGlzIGlzIG5vdCB0aGUgY2FzZSBmb3IgY29tbW9uIGNvbmZpZy4N
Cj4gDQpXaHkgaXMgdGhpcyBub3QgdGhlIGNhc2Ugd2l0aCBjb21tb24gY29uZmlnPw0KU3BlYyBz
bmlwcGV0OiAiV2hlbiB1c2luZyB0aGUgbGVnYWN5IGludGVyZmFjZSB0aGUgZHJpdmVyIE1BWSBh
Y2Nlc3MgdGhlIGRldmljZS1zcGVjaWZpYyBjb25maWd1cmF0aW9uIHJlZ2lvbiB1c2luZyBhbnkN
CndpZHRoIGFjY2Vzc2VzIg0KDQo+IEkgZmVlbCB3ZSBkbyBub3QgbmVlZCB0byBhbGxvdyBlLmcu
IGFjY2VzcyB0byBib3RoIGNvbW1vbiBjb25maWcgYW5kIGRldmljZQ0KPiBzcGVjaWZpYyBvbmUg
aW4gYSBzaW5nbGUgb3BlcmF0aW9uLCB0aGF0IGlzIGp1c3QgbWVzc3kuIA0KSXQgaXMganVzdCBh
biBvZmZzZXQgYW5kIHZhbHVlLg0KV2hhdCBwYXJ0IGJvdGhlcnMgeW91Pw0KDQo+IE5vdyBzdXJl
LCB3ZSBjYW4gYWRkIHRleHQNCj4gd2l0aCBhbiBleHBsYW5hdGlvbiwgYnV0IGlmIGluc3RlYWQg
dGhlcmUncyBhIGZsYWcgc2F5aW5nICJ0aGlzIGlzIGNvbW1vbiBjZmciDQo+IG9yICJ0aGlzIGlz
IGRldmljZSBjZmciIHRoZW4gaXQgZmFsbCBvdXQgYXV0b21hdGljYWxseS4NCj4gDQo+IElzIHRo
aXMgYSBkZWFsIGJyZWFrZXI/IE5vLCBidXQgbm90ZSBob3cgbmVpdGhlciBJIG5vciBKYXNvbiBk
aWQgbm90IHRoaW5rIGFib3V0DQo+IHRoaXMgYWhlYWQgb2YgdGhlIHRpbWUgYW5kIHRoZSBjb3Jy
ZWN0IHVzYWdlIGp1c3QgZmFsbHMgb3V0IG9mIHRoZSBpbnRlcmZhY2UNCj4gYXV0b21hdGljYWxs
eS4gIFRoaXMgaXMgYSBtYXJrIG9mIGEgZ29vZCBpbnRlcmZhY2UgZGVzaWduLiBMb3RzIG9mIGNv
cm5lciBjYXNlcw0KPiB0aGF0IG9uZSBoYXMgdG8gYmUgY2FyZWZ1bCBhcm91bmQgaXMgbm90Lg0K
SXQganVzdCBtb3ZlcyBjb3JuZXIgY2FzZSBvbmUgbGF5ZXIgYWJvdmUgaW4gbXVsdGlwbGUgc29m
dHdhcmUgaHlwZXJ2aXNvcnMgYW5kIGh5cGVydmlzb3IgaXMgbm90IGZhaWxpbmcgaXQgZWl0aGVy
IG9uIGNmZyByZWFkL3dyaXRlcyBhcyBleHBlY3RlZCBieSB0aGUgZ3Vlc3QuDQpTbyBiaXNlY3Rp
bmcgaXMgbm90IGFkZGluZyBhbnl0aGluZyBleHRyYS4gVGhvc2UgZmFpbHVyZSBjaGVja3MgYXJl
IGdvaW5nIHRvIGJlIGlnbm9yZWQgaW4gaHlwZXJ2aXNvciBhbnl3YXkuDQo=

