Return-Path: <virtio-dev-return-13781-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5018BCD37B3
	for <virtio-dev@archiver.kernel.org>; Sun, 17 Sep 2023 05:32:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B647E2AC52
	for <virtio-dev@archiver.kernel.org>; Sun, 17 Sep 2023 05:32:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8F1F49863A4
	for <virtio-dev@archiver.kernel.org>; Sun, 17 Sep 2023 05:32:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 74D5A983EB8; Sun, 17 Sep 2023 05:32:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 64D039843C1
	for <virtio-dev@lists.oasis-open.org>; Sun, 17 Sep 2023 05:32:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0AiHsE1NGL6ZocJdcuaiJJv9+wy8RWFr8BVrG3MXT2bIgW/8Dh6Rq9kKbWzvZN6sWHT5GZxGHDemuvB8liu9CRTiOThvNZZa/na1Q0ygKn70p1DjVz/Uij764tlLVJcwVn/6WrADBRgJ/UPs8Nwbk1vXPnMyrYc0pNJSzNMh8JH6d+t3jfIrZISJpOF9JAmWRRaZCKysJoOQCAGrx3S8TeLxJEeCduCNMFMmCYULQOZ4IQcRwX3/xBR/VEzMj0P5nDrl1ldl0+mpz+g2QEUSWPM6Fwt49emGYBOI7oWTBuk5iwHcpEJ7KcLwpcTh3hv7o5PFvWpjFu9NSpdWXvxSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=libFrT+R+NPsCaznlU9PTsx0a+uRPDZi2QqZRlYBa3s=;
 b=X5v3+pW4LI8uuvYFEjpOf8pPVL0Ywkj5dEAr1CZbl6eiaAwwyj/szT3Rjz11b6rHDet/DKQRKtLoGLfU+21hJ/nu5tyPXT5tpexrERA4+libXUw2IopJfetkVVph56dKGdutl4JiYxMb7xP40N3vBHUkb3pccvaw5mHDX+VBgPr2wqW8GVEUiBKxirDskmCx9VaCVDONRzTWWr5B04JNjqZrJBI2fXPX4dRVCb6bii6smt7wtBdGFyfXxssnD1hvGh01V4KfOC1ptv5NPrQ3Gx2yiZN7PNu/xnmKANsFtnK4QusBKAs7pCzt5CIgKDJxRKW81U7btIml41jUFSYqPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state
Thread-Index: AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUw
Date: Sun, 17 Sep 2023 05:32:25 +0000
Message-ID:
 <PH0PR12MB548159C982509436C6499279DCF4A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230914070911-mutt-send-email-mst@kernel.org>
 <559c0875-24b8-0709-712e-24ffe7830022@intel.com>
In-Reply-To: <559c0875-24b8-0709-712e-24ffe7830022@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB6977:EE_
x-ms-office365-filtering-correlation-id: 5507678a-34eb-47ab-4fa7-08dbb73f79a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 V+L7QjnBO7H5XQGfOaX2/8l6bduasYfrGVQNS74VdV7KJzAK+ZJB5w94kKcxsTptYzDTvLEExMNS0pzwfhKh0Ss/Sd//XD7P8hFWxPGNR7GAbNCmuckgRwBdICWdi242COa2AMuTWmZf+S3MdRDEce5VJyTXevW6RU4TDbhvxb4Qn8YcAt0movrpEJOSEbeclteVC+9MLn1zh8TF/oBXji4B+k0uK3zo2VCc4JpwTC2h7Jb6rp0l3lkAiG9P4aRWFFicJzYhYdYbi38biNvswcN4Q8IB1nWCKrwkzkaI/pS+MCvFgqjmyZwhV+IuqMW3c4s3D6I/Rr/ZjPayULNTjM1uZquOkZUx0o183cXjVAEy6XDkxFdakN03zfvTg9bc6flipeTK2+5eI6rPsXNNN46fL09TSULvxDoTxOZ1em5XC35vBJOkhFa39wl8ig6L2xQ12FN3KiBEd2+HSSrhWQbPQEvzvnRa3kkIOKtLs9zVv4IDFJRVlg0Hid1fLKMUCYb3O9/3i2r7BWcClNfmKlmvdKHsOrs3+YsoAa6mO6ol9cfABRdZKgriSM6NnuRsX1SYuL07sEpc9NgpyMOvYIBbmBQsgGzArcriHucexjHgc2COU5y/sq/GomYp0KCX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(136003)(396003)(1800799009)(186009)(451199024)(26005)(52536014)(8936002)(8676002)(122000001)(15650500001)(83380400001)(33656002)(2906002)(55016003)(5660300002)(86362001)(53546011)(7696005)(6506007)(55236004)(478600001)(71200400001)(316002)(9686003)(76116006)(110136005)(66946007)(66446008)(64756008)(66476007)(38070700005)(66556008)(41300700001)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?clBQVlh3VHVqYnBJUituZmxBSUZTM1ljcHFvSmc1MTh3RVpyT011Mm1QeWNC?=
 =?utf-8?B?ZnR6dW1FWk1veGRLcC9Hd1hlK3ZCZ2hDMVNjUTQyVHRpZVg5dGFRVzdMMlQ3?=
 =?utf-8?B?TUdONzRSekFGaGdqRnpNTFJ1YlRrdVRPREV0YUNZU0ttM3l2MURyS1dTRGpM?=
 =?utf-8?B?VFhYLy9rOVRSUDFFV3pkb3krUmpTRzVTc1VUZkVCNmZFbk1OQlFLZ1ErMWxs?=
 =?utf-8?B?Qzh6WTRvaitaTHNZTkJ1b0dIbkROU3RiejVtM3p3cFR2L2NaOUxobG53RVVu?=
 =?utf-8?B?ejBLYnFSRFJUWmprTmRwNUVJTnpaaTIvTmtNbXgwNXZMZnk2RitEL3liczkr?=
 =?utf-8?B?YkZMdGZtaHdjaVVPaVlyNHp4V1FZRGUxbHBzSFdhRXhiMStLcXFGSFBxQnZh?=
 =?utf-8?B?RGJpZVNoa0QvUm9CbVBSczUyQ3dLRGdtOGd5RThxZG94bHE4bWovZnhGV3hX?=
 =?utf-8?B?dVJSVGViMGJiaEhGdTV4TW8yekFrekN3cmYwV0g1RTQ1bmh4SDJybWVNV29z?=
 =?utf-8?B?YTA5UEl1bGRIM25LSE9nUEE3emZ2QjN4ZUpKOEppeExod1N4aU5PVVZVLzBv?=
 =?utf-8?B?MlJIeTBLVEozeXV5c1F6TW5BZG5scldLb0Y4TUNCdFc4WHVvT29qTzFFeHN0?=
 =?utf-8?B?MXRRYmpzNlk4djFqQTVEdlJWTVdYZ0c1b1FXdy9mVC84ZlJZS0RnMXNoVzhJ?=
 =?utf-8?B?bzdPOFBObmhwa2xlc29XRHUyOWE1T1B0WXowc0dFMU05dTZPeTZsOTgrSVRa?=
 =?utf-8?B?RzczRkc2ZlRHNFNxcHVRUmpuMERNUTFwZURmRFZOSnhVZE1xQTZ1bjczQzkv?=
 =?utf-8?B?aG94TE1zL2dxZkhFcFBYMS9FV1JzY3RwVDZJcDdPYm84NVVLTk9PVzRpbi8w?=
 =?utf-8?B?Z3ZZQUMrcTliZ1dRdEE2akNvcDBIT0lta3pPcEg1SWkrNFpoVWFZd3EyYUZ0?=
 =?utf-8?B?STFhUTIvUE9mV1RYVGM0Q1M1QVpEZDk0WVBOUGFVK21pOWdjbWJJbE9zRmdU?=
 =?utf-8?B?SFZVejVzdnRrSXJuRVRmMDFKOU94ZzhYQUZPL2tQdklHMHg2WUQ1c2pKUkhy?=
 =?utf-8?B?N0hFZDVGbnBxa0V2LzUrdDRXeFE5VXFlcVZxZUZXSmc0eFFBdGg5aDlQTDJY?=
 =?utf-8?B?cFN1UWFIODdNT0Jidms0S01kbHpTdlQ3VWZvNEV3S3p2TUNFWGtXVFJYSU95?=
 =?utf-8?B?bXRXUmlkSlFzS0xFeWUxVlVBckJaQ2Z1WmNaN0o0ZEJqYnlGbGxURHVlc2V2?=
 =?utf-8?B?dHZ6U0tTOXlVY2xGR1BzbUdXcEpsdW9oOFd3d080aXEvMUFyb1FIbEtQQWN2?=
 =?utf-8?B?YWxlRm5WTVUvUTdjOU1ISnVESE1lWUllODNFRkdiV1MzL0M3MVRzdEpBeHlp?=
 =?utf-8?B?cWxoTmVLc1FWTTF3OUE2VUlmdEZzRmtNZ1M5cjIzeTBVY3N2YXlNbnBOd0l2?=
 =?utf-8?B?ZUJGeTJJSHlCV0JOR0dTdFEreTlCL1hiKzFOZmNSUmdtK2x1dkVUMEtUSXhs?=
 =?utf-8?B?ejNSVjBGT3MzZjNzajVCVk0wOGFyYlZQWDhrVDdsa0R6N2hNei90OGlzUXl6?=
 =?utf-8?B?QmdKN3lLcXZKYUsxbEdHNzBXMUx1QkY5YjdrVE1wam1IRVZOSTlUN1ZFZFY0?=
 =?utf-8?B?ZDBsMzdlR1RzL212MFN4Z0cvWW5TZzZySVlLUUhRKy9jc0pZMTJMTVhJQ3I0?=
 =?utf-8?B?RU4xcFZSVTc5dFI1T1d0SFhWZGo4bjh6Q01wZ0ttWXBIcUF6TjJhVHA1MVRN?=
 =?utf-8?B?Smw4S1hMNnFlbjZFb2ZwR3JYNnV5NndGZzlKanE3VU1Ya2VhMU0ydWpaZWlF?=
 =?utf-8?B?Z3d6dlNYSFAyQU83djhEQTBNY2NvZExUbG13OTM1eTBLQ1lDdTJ0enVLRDJC?=
 =?utf-8?B?L0ZRSG4wcldoRFRVWHpkRXNWaElGL244cHJkZnZCR1c4cXB3ZjM0Y1lneDVQ?=
 =?utf-8?B?VGk3RmlyOTR4dUszWjBabUlGWlRRNmJaTDFJUXZVbEdORkI4UG9uVHNpRElW?=
 =?utf-8?B?d1pDUVNyYTdpWjAyY2czT2JUMDZNcU1qRXNQa0JibU42VklkTlF0WXZPc0pZ?=
 =?utf-8?B?c3FrV2FDeWZtTDlDQVdrR21Vb1o2bTlKYjlPTThmMGw2dUlLUnhYKzNvYllz?=
 =?utf-8?Q?STi0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5507678a-34eb-47ab-4fa7-08dbb73f79a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2023 05:32:25.4006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ynMA+W6tXUVh298PqYhoDPin3PHzyUSqAwn26srGE2CkXDToRDDe0d6guNBmget2d/z5cvM3piWSuDJZjMB1sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6977
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state

DQo+IEZyb206IHZpcnRpby1kZXZAbGlzdHMub2FzaXMtb3Blbi5vcmcgPHZpcnRpby1kZXZAbGlz
dHMub2FzaXMtb3Blbi5vcmc+IE9uDQo+IEJlaGFsZiBPZiBaaHUsIExpbmdzaGFuDQo+IFNlbnQ6
IEZyaWRheSwgU2VwdGVtYmVyIDE1LCAyMDIzIDk6NTkgQU0NCj4gDQo+IE9uIDkvMTQvMjAyMyA3
OjE0IFBNLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6DQo+ID4gT24gV2VkLCBTZXAgMDYsIDIw
MjMgYXQgMDQ6MTY6MzJQTSArMDgwMCwgWmh1IExpbmdzaGFuIHdyb3RlOg0KPiA+PiBUaGlzIHNl
cmllcyBpbnRyb2R1Y2VzDQo+ID4+IDEpYSBuZXcgU1VTUEVORCBiaXQgaW4gdGhlIGRldmljZSBz
dGF0dXMgV2hpY2ggaXMgdXNlZCB0byBzdXNwZW5kIHRoZQ0KPiA+PiBkZXZpY2UsIHNvIHRoYXQg
dGhlIGRldmljZSBzdGF0ZXMgYW5kIHZpcnRxdWV1ZSBzdGF0ZXMgYXJlDQo+ID4+IHN0YWJpbGl6
ZWQuDQo+ID4+DQo+ID4+IDIpdmlydHF1ZXVlIHN0YXRlIGFuZCBpdHMgYWNjZXNzb3IsIHRvIGdl
dCBhbmQgc2V0IGxhc3RfYXZhaWxfaWR4IGFuZA0KPiA+PiBsYXN0X3VzZWRfaWR4IG9mIHZpcnRx
dWV1ZXMuDQo+ID4+DQo+ID4+IFRoZSBtYWluIHVzZWNhc2Ugb2YgdGhlc2UgbmV3IGZhY2lsaXRp
ZXMgaXMgTGl2ZSBNaWdyYXRpb24uDQo+ID4+DQo+ID4+IEZ1dHVyZSB3b3JrOiBkaXJ0eSBwYWdl
IHRyYWNraW5nIGFuZCBpbi1mbGlnaHQgZGVzY3JpcHRvcnMuDQo+ID4+IFRoaXMgc2VyaWVzIGFk
ZHJlc3NlcyBtYW55IGNvbW1lbnRzIGZyb20gSmFzb24sIFN0ZWZhbiBhbmQgRXVnZW5pbw0KPiA+
PiBmcm9tIFJGQyBzZXJpZXMuDQo+ID4gQ29tcGFyZWQgdG8gUGFyYXYncyBwYXRjaHNldCB0aGlz
IGlzIG11Y2ggbGVzcyBmdW5jdGlvbmFsLg0KPiB3ZSB3aWxsIGFkZCBkaXJ0eSBwYWdlIHRyYWNr
aW5nIGFuZCBpbi1mbGlnaHQgSU8gdHJhY2tlciBpbiBWMiwgdGhlbiBpdCB3aWxsIGJlIGENCj4g
ZnVsbCBmZWF0dXJlZCBMTSBzb2x1dGlvbi4NCj4gDQo+IFRoZXkgYXJlIG5vdCBpbiB0aGlzIHNl
cmllcyBiZWNhdXNlIHdlIHdhbnQgdGhpcyBzZXJpZXMgdG8gYmUgc21hbGwgYW5kIGZvY3VzLg0K
PiA+DQo+ID4gQXNzdW1pbmcgdGhhdCBvbmUgZ29lcyBpbiwgY2FuJ3Qgd2UgYWRkIGFiaWxpdHkg
dG8gc3VibWl0IGFkbWluDQo+ID4gY29tbWFuZHMgdGhyb3VnaCBNTUlPIG9uIHRoZSBkZXZpY2Ug
aXRzZWxmIGFuZCBiZSBkb25lIHdpdGggaXQ/DQo+IEkgYW0gbm90IHN1cmUsIElNSE8sIGlmIHdl
IHVzZSBhZG1pbiB2cSBhcyBiYWNrLWVuZHMgZm9yIE1NSU8gYmFzZWQgbGl2ZQ0KPiBtaWdyYXRp
b24sIHRoZW4gdGhlIGlzc3VlcyBpbiBhZG1pbiB2cSBzdGlsbCBleGlzdCwgZm9yIGV4YW1wbGU6
DQo+IDEpbmVzdGVkIHZpcnR1YWxpemF0aW9uDQo+IDIpYmFyZS1tZXRhbCBsaXZlIG1pZ3JhdGlv
bg0KPiAzKVFPUw0KPiA0KWludHJvZHVjZSBtb3JlIGF0dGFja2luZyBzdXJmYWNlcy4NCj4gDQoj
NCBpcyBqdXN0IHJhbmRvbSB3aXRob3V0Lg0KIzMgVGhlcmUgaXMgbm8gUW9TIGlzc3VlIHdpdGgg
YWRtaW4gY29tbWFuZHMgYW5kIHF1ZXVlcy4gSWYgeW91IGNsYWltIHRoYXQgdGhlbiB3aG9sZSB2
aXJ0aW8gc3BlYyBiYXNlZCBvbiB0aGUgdmlydHF1ZXVlcyBpcyBicm9rZW4uDQpBbmQgaXQgaXMg
Y2VydGFpbmx5IG5vdCB0aGUgY2FzZS4NCg0KPiBBbmQgd2hhdCdzIG1vcmUsIGlmIHdlIHdhbnRz
IHRvIGltcGxlbWVudGluZyBhIG5ldyBjYXBhYmlsaXR5IG9uYmVoYWxmIG9mDQo+IGFkbWluIHZx
LCBkb2VzIHRoZSBjYXBhYmlsaXR5IG5lZWQgdG8gc3RvcmUgYXQgbGVhc3Qgb25lIGRlc2NyaXB0
b3IgYnVmZmVyLCB0aGF0IGlzDQo+IHRoZSBjYXBhYmlsaXR5IGxlbmd0aCBzaG91bGQgYmUgYXQg
bGVhc3QgdGhlIG1heF9sZW5naF9vZl9idWZmZXI/DQo+IA0KPiBJZiB0aGF0IGlzIG5vdCBwb3Nz
aWJsZSwgZG8gd2UgbmVlZCB0byBpbXBsZW1lbnQgZXh0cmEgZmllbGRzIGxpa2UgbGVuZ3RoIGFu
ZA0KPiByZW1haW5pbmdfbGVuZ3RoLCB0aGVuIHRoZSBkZXZpY2UgcmVwZWF0aW5nIHVwZGF0ZSB0
aGUgY2FwIGRhdGEsIGFuZCB0aGUNCj4gZHJpdmVyIHJlcGVhdCByZWFkaW5nLCB3YXkgdG8gY29t
cGxleCBhbmQgaW50cm9kdWNlIHNpZ25pZmljYW50IGRvd250aW1lLg0KPiANCkF0IGxlYXN0IEkg
ZG8gbm90IHVuZGVyc3RhbmQuIE1heSBiZSB5b3UgY2FuIGV4cGxhaW4gbW9yZT8NCg0KV2Ugb2Jz
ZXJ2ZSBsZXNzIHRoYW4gMzAwIG1zZWMgZG93bnRpbWUgdXNpbmcgYWRtaW4gY29tbWFuZHMgb3Zl
ciBhZG1pbiBxdWV1ZSBpbiBpbnRlcm5hbCB0ZXN0cyBpbiB2aXJ0aW8gYXJlYS4NCg==

