Return-Path: <virtio-dev-return-13734-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5449CA0ED1
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:20:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 04434F3F52
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:20:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5C0CB98612D
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:20:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B8778986632; Wed, 13 Sep 2023 04:20:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 24E36986630;
	Wed, 13 Sep 2023 04:20:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsocZunGazpW77SD5wMdsD0aNBOyFbIDUcICN7fmRlqH/itprD2mE3fNo9xciXjujRDnC+iTgWebaO1AbFs9qdkcDGsoqEWOJIdpljcs9bwz4WPlqWUOvH4dLeNsVQHd36zVlJDaXzsgKnxtpgV0EaZf92unP0F/HVc0LaopU+bjMgUkJjeJ3dq6e0pk9fKf4MHGh23nkHgdka52ZdTA/wbCf8IZyHTNdbhX0+ByWK6ekZbShzv0PPcLfehcOF6LC0uqkPt/WnvlADoeQNu4hng7Dyv6pziZbbuEOXQNTunk0FX8HwWwkk8Lm5gHd+8CApVNaZk2pSM9s9meUR2JVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0DEZSExL8sKRkXK6j8qRmEQsFhkfEIEj9Gs9HMnMbY=;
 b=WUxKZ4fxsrXKwL+TvXmSFtLk+OXEYlYEPFg6ZBL3uAFig3ePh4sJp0gkrAV+K4NoeHyWuDD0uYa8Jjs0vq2EUayUKxeyH+9bZ+88VnoamS0d5bAGHq7qz1eu8ItipQgdu3Oo6iStXpzCjxQrBofdDkAsJWAddJQBOX0huQI39CK/h6JEPk00lUdooL5GypOhxu8bVGGQz+LbVMS/pwTvgSVx3zwihVidBBSvjLwKyuc90svu9uebQBJtlTae9FTMzIg9+2ZtctKdS/3xNWiS/mt+T4IkKaZ9wEV+BA7/Injw0GuY80/YahEU+xIkMSA+rQjA/HdaHKQtfUZ2pTpaxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "eperezma@redhat.com"
	<eperezma@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE
Thread-Index:
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAFrJICAAB38cIAACoIAgAAB5TCAAAzeAIAAAVowgAAud4CAAABSIIAAAeaAgAABfOCAACmSgIAABu0AgAD11YCAAAB9wA==
Date: Wed, 13 Sep 2023 04:19:56 +0000
Message-ID:
 <PH0PR12MB54817F7ED583FA9A03735CBCDCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <PH0PR12MB5481ED8DC23DC6D42665FB8EDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEt9ATuU_OwtE_9rF1XHKCd9GavWCHx6_dFXCZibMKzJjA@mail.gmail.com>
 <PH0PR12MB5481D538B4F3F76B393C5757DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <7cc22be6-f984-ba53-5979-0306a118a6df@intel.com>
 <PH0PR12MB5481961B5EA6DEE900CCF068DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5449424a-4872-0164-0c3f-caa34ad46388@intel.com>
 <PH0PR12MB5481CBCF7BEE5637D16BC179DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <4c4c2478-c90b-fb5b-cc06-bc74293862b9@intel.com>
 <PH0PR12MB54817178B8D5799FE74D4331DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <85b1670b-5094-cdb8-fde9-1a9c0906f094@intel.com>
 <PH0PR12MB54815711322F1CAC35189CEDDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <b0ae1197-f9e9-4596-f9bf-559f6112458f@intel.com>
 <PH0PR12MB5481E0C8D74DD3479331E0ACDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <7abce4d9-4762-dcad-6fdf-068588ebb3d9@intel.com>
In-Reply-To: <7abce4d9-4762-dcad-6fdf-068588ebb3d9@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM8PR12MB5416:EE_
x-ms-office365-filtering-correlation-id: ffc27f28-a38b-4995-66cf-08dbb410afd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Z41TReAShdi40LY0tutE/1VC2BwCoAITTPCWRMde9otaLYB7Gep8eeETJaQm8WfykRJUIgZv7yHKBb1rg4KOqRGVwCo3J5ntYs+Y2r7V9wBPjDfmUnyAum1wEHnjuXSp+NJME/q0CYvjsKhRkjCr9bP2b/0339FeLeC78aCeG8DBvtT4kmv5XTKqPYV+D7G1VH861dkGqop+OlZTkyPeYAjwNrzoqJpHz0EspF5cc/l5aXU0ze4/O+gWYk+eKklTTxdDsnESe7wgwaX4I9ZYpSpfUicxuoge8GQwvuVGZ8aEYyqmtV/JVqAx3z8xjH1s6+1ozQ2nse54ITLXQp5eTzUUI5pdqzC2z/u16nx79ASPTf760jK0lha5dHS+MbMh7PjNlEPO0uHiZtjamcMPfSrW9seKzsJF1fJh+clDsTZcl8oJ2TZbt10Gre2VYiHfgdhKeSbfV2jG7N1NbXU9Fn9D90rjmXpl4ULDoXnysfR47A8KRPof9JFPZHnkhVY/17E1o3sUEXSrtnEmPEK06hFSjE7ijL/l6tMLVA+u7+ZLULN27zKIjppIOl/UP/y+cZsyvfggvBYrofYalhC/QInQZaDxSqoXgCHr5m0C9xE4hoZwlN9syZ9d7Mz5kLQauh3Z2V2HvGYxquyal/DhS63p7Uvi2lhv21+5uLXeEeA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(366004)(39860400002)(396003)(346002)(1800799009)(186009)(451199024)(26005)(9686003)(83380400001)(316002)(110136005)(41300700001)(66946007)(76116006)(66476007)(66446008)(66556008)(8936002)(54906003)(4326008)(8676002)(71200400001)(52536014)(2906002)(53546011)(478600001)(6506007)(64756008)(5660300002)(966005)(7696005)(55016003)(86362001)(33656002)(38100700002)(122000001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Zy84OTc2Nm1MaDJZQVowcEdqU0x5SFdyVXV1L0ZuVVdkWHczRGJ4L2NDR0J2?=
 =?utf-8?B?OTkzSVhWc252R28ramRJbkUvM2VYQ1dScUJUQ1p3OGlEbmNGNWh0dEVOTmdq?=
 =?utf-8?B?OFJBYUsyNkNraWtSZ1dDSFZ6d3crR2FBc3VCSGRaT0g1bG1zSFlpUHV3UTVQ?=
 =?utf-8?B?WXhSMk5OaUkvWGZrVWwvNlVsMHBxcmI5NjlMLzRaRFpkM1ErbXBVMC84ZWIw?=
 =?utf-8?B?N0lZa3YxY1Z0Y1E0ZFhxRlM1K2gvdjBXeVNSQTlvYkppU2VWd3V5UzRwNlVl?=
 =?utf-8?B?NFY1Q1kydmNFeU80UHFNNHlOVld6aS8yajNGTFVLaC9uNnZ5R3FQRXV5Z1ZW?=
 =?utf-8?B?RWUvYW1kL1l5STA1M1FqQlFJdmE2WGhlYS9BMVBxK0pVVzdOOGVxU1pXeHY3?=
 =?utf-8?B?aUZ6Wlp6L1JrYmFHbUphQTQ4KzNPd2tIQzNUdHlBWXBhZmw3QW5NT2NjeEgz?=
 =?utf-8?B?VVp6S2Y5ZGZMZ3VxeEM2dmZnTHA1b2xkeFdXd2tJZWx4Y1kzMFQwd2o1UTYv?=
 =?utf-8?B?QjlVUzhZUGUxV1RCd2hiMyt5eUl0YndMZVU1SXUxbEd5bjhSZTZtc25zOS9z?=
 =?utf-8?B?eTA4cllVYURQMFhzTkh0ZmVVQVN2MzRjK2Ryd3dWZEJhWDNtM1VaV2p0VDRV?=
 =?utf-8?B?TmtYSGU3a2RkUmFYT3Y5MkRJVE9tdkNmNWl6M2dQbWYxMzVxK3MzVTFNSklm?=
 =?utf-8?B?MityMnRGQ3p1MjVpMHNqbWttS1BGRjlHcWJUN1BucklCQzIvVUo3ZHEvaGhE?=
 =?utf-8?B?cjZZMm1kSDF4TVdtZFZWM1ZtQndBRzk3YllpdGlmRWtHR2xyWlFUVGs5Yml2?=
 =?utf-8?B?czEzL1E0MXdYMlFDZHpqL25WK1ozT2FpSFJvUExMVUp1OHhLOTBlMktzKzZ0?=
 =?utf-8?B?czlrVTRvK0NSRk5jTXNBRzcyK01TL2k2THJtYkRTNlk4NTliblEzc01nWjBP?=
 =?utf-8?B?VlUrWDlrWXRScnllYnlYVHBWbVhObmZ3VVdYREM4Wlp1amxNRGhGVjc5am40?=
 =?utf-8?B?aUJvUUtrVk1pWElwSWFUNmg5VXpHekMzVGZGMlVNb2cwNVBSYWN3N1RlbnA2?=
 =?utf-8?B?bzM1NG5QSjF2bUV1cDl6NktiM3FwVGd5S0ZhWUd0RUJLMk5hVWQycmVUbDl0?=
 =?utf-8?B?bjlyUnpQbSttN1A2TW5nNW84K09yMEM1YTNBZUw1SmpzZDZYSkFDc0txbDNX?=
 =?utf-8?B?akYrSG5lUlltb01IRU1GU3hqQ0pBTTlCa3VTLytqQkFKUWMvdTNPSnlnYmJD?=
 =?utf-8?B?YldBOVRILzcyS3dBREhJR1lJajJMTGZUUTQxYVVDczh0Yk5IU0ZtOXBxdXdi?=
 =?utf-8?B?NWEvN0Vzd21LTmZpNHVOWDBSdG85L3Nqek9EYTI3UHgxc2ZyZ2JmRFNlNG1i?=
 =?utf-8?B?LzVsSmtDbzFpdXNjRUsvSzJHOGJ4eEw1VVhGaXpKZDhKazZvR2pwZDlERDRO?=
 =?utf-8?B?U3FMa25kMjdjbEpKYkkyQ2lVdVgvY3RUa3FrVU90YnFkUFNtcVlMMG1ua3l1?=
 =?utf-8?B?TDNiT1pJcnk0UEZXY29EN2hxZ3YyV1dOZXhHdGJPT1dpbWxydVhDb0x5ZE1D?=
 =?utf-8?B?S3djQkVaaFJKT0djVFY3NDBvd0JoZnRvVXNETjFKQ0d2NG45Q0dVa2tZcVdE?=
 =?utf-8?B?NkRheVdQYTNWVkVUTkV0TlM3RWhiaU9VVHNrR0IwZTFPQVBIRXhjZUlMd3k0?=
 =?utf-8?B?Ry9ya3F0ZzlSSncySmV5Y3VycXNBWUJNaXhSNC9VUlFQYU1GLzNPcDgwR0tG?=
 =?utf-8?B?M0lwc1RLSG5qZHYvZTBGMXRLdW5yRVAzL2wwckd0eEhOTUsyN2tvaVZoRmpt?=
 =?utf-8?B?SXZ0S1B5bng3R0s5R0ZXandRZFRkWjVxWWlQak5RVmJpVmU3ZFZFbW11dmpH?=
 =?utf-8?B?YkYxTkFGUGZ3YllNa25FVEk1eWlWKys0djZxY094dWJVbUhsSC9MWTJybkpB?=
 =?utf-8?B?TnVGa1dpbFhzemtFcG1RTk5mTlZDMXhNNWlicklabjdjNXFFV3VFY1FCYXor?=
 =?utf-8?B?dVpMaTF5SlRGNGFlUEFXZ2V5QmpZbS9VSFE3MDduS01sUVVoRVRhcGFyODJQ?=
 =?utf-8?B?bllpNlRIUGdEVnc0b0JJNDdDS2RreTdOSkJweXdodHQ2RjMvRVZlNDErUkJJ?=
 =?utf-8?Q?Ji8A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc27f28-a38b-4995-66cf-08dbb410afd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 04:19:56.4987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QQ7xuc7AWiy5tIeFcq1Gqz/nV3scgZz2xpCbhgqKViDnk0Fjr2uFf4C63+oVtkYraQ9+leYf7RKqztlb81kTlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5416
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQoNCj4gRnJvbTogWmh1LCBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4NCj4gU2Vu
dDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMTMsIDIwMjMgOTo0NCBBTQ0KPiANCj4gDQo+IE9uIDkv
MTIvMjAyMyA5OjM1IFBNLCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+ID4+IEZyb206IFpodSwgTGlu
Z3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIFNlcHRl
bWJlciAxMiwgMjAyMyA2OjM5IFBNDQo+ID4+DQo+ID4+IE9uIDkvMTIvMjAyMyA2OjQxIFBNLCBQ
YXJhdiBQYW5kaXQgd3JvdGU6DQo+ID4+Pj4gRnJvbTogWmh1LCBMaW5nc2hhbiA8bGluZ3NoYW4u
emh1QGludGVsLmNvbT4NCj4gPj4+PiBTZW50OiBUdWVzZGF5LCBTZXB0ZW1iZXIgMTIsIDIwMjMg
NDowNSBQTSBJIG1lYW4sIHdoeSBkbyB5b3UgdGhpbmsNCj4gPj4+PiBteSBzZXJpZXMgY2FuIG5v
dCB3b3JrIHdpdGggUDJQDQo+ID4+PiBCZWNhdXNlIGl0IG1pc3NlcyB0aGUgaW50ZXJtZWRpYXRl
IG1vZGUgU1RPUCB0aGF0IHdlIGhhdmUgaW4gc2VyaWVzIFsxXS4NCj4gPj4+DQo+ID4+PiBbMV0N
Cj4gPj4+IGh0dHBzOi8vbGlzdHMub2FzaXMtb3Blbi5vcmcvYXJjaGl2ZXMvdmlydGlvLWNvbW1l
bnQvMjAyMzA5L21zZzAwMDcxDQo+ID4+PiAuaA0KPiA+Pj4gdG1sDQo+ID4+IEFnYWluLCB3aGVu
IFNVU1BFTkQ6DQo+ID4+IDEpIHRoZSBkZXZpY2UgZnJlZXplcywgbWVhbnMgc3RvcCBvcGVyYXRp
b24gaW4gYm90aCBkYXRhLXBhdGggYW5kDQo+ID4+IGNvbnRyb2wtcGF0aCwgZXhjZXB0IHRoZSBk
ZXZpY2Ugc3RhdHVzDQo+ID4gRXhhY3RseSwgaW5jbHVkaW5nIHRoZSBSRVNFVF9WUSBjb21tYW5k
IGFsc28gY2Fubm90IGJlIHNlcnZlZCBiZWNhdXNlDQo+IGRldmljZSBpcyBmcm96ZW4uDQo+IHNl
ZSBiZWxvdw0KPiA+DQo+ID4+IDIpIGEgbmV3IGZlYXR1cmUgYml0IHdpbGwgYmUgaW50cm9kdWNl
ZCBpbiBWMiwgdG8gYWxsb3cgUkVTRVRfVlENCj4gPj4gYWZ0ZXIgU1VTUEVORA0KPiA+IFJFU0VU
X1ZRIGFmdGVyIHN1c3BlbmQgaXMgc2ltcGx5IHdyb25nLiBCZWNhdXNlIGRldmljZSBpcyBhbHJl
YWR5DQo+IHN1c3BlbmRlZCB0byBub3QgcmVzcG9uZCB0byBzb21lICBleHRyYSBSRVNFVF9WUSBj
b21tYW5kLg0KPiBObywgd2hlbiB0aGUgZGV2aWNlIHByZXNlbnRzIFNVU1BFTkQsIHRoYXQgbWVh
bnMgdGhlIGRldmljZSBjb25maWcgc3BhY2UgaXMNCj4gc3RhYmlsaXplZCBhdCB0aGF0IG1vbWVu
dCwgZnJvbSB0aGUgU1cgcGVyc3BlY3RpdmUgdGhlIGRldmljZSB3aWxsIG5vdCBtYWtlDQo+IGNo
YW5nZXMgdG8gY29uZmlnIHNwYWNlIHVudGlsICFTVVNQRU5ELg0KPiANCj4gSG93ZXZlciBhdCB0
aGF0IG1vbWVudCwgdGhlIGRyaXZlciBjYW4gc3RpbGwgbWFrZSBtb2RpZmljYXRpb24gdG8gdGhl
IGNvbmZpZw0KPiBzcGFjZSBhbmQgdGhlIGRyaXZlciBoYW5kbGVzIHRoZSBzeW5jaHJvbml6YXRp
b24oY2hlY2tzLCByZS1yZWFkLCBldGMpLCBzbyB0aGUNCj4gZHJpdmVyIGlzIHJlc3BvbnNpYmxl
IGZvciB3aGF0IGl0IHJlYWRzLg0KPg0KSXQgc2hvdWxkIGJlIG5hbWVkIGFzIFNVU1BFTkRfQ0ZH
X1NQQUNFLiENCkFsbCBvZiB0aGlzIGZyYW5rbHkgc2VlbXMgaW50cnVzaXZlIGVub3VnaCBhcyBN
aWNoYWVsIHBvaW50ZWQgb3V0Lg0KR29vZCBsdWNrLg0KIA0KPiBBcyB5b3UgY2FuIHNlZSwgdGhp
cyBpcyBub3QgcGVyZmVjdCwgc28gU2lXZWkgc3VnZ2VzdCB0byBpbXBsZW1lbnQgYSBuZXcgZmVh
dHVyZQ0KPiBiaXQgdG8gY29udHJvbCB0aGlzLCBhbmQgaXQgd2lsbCBiZSBpbXBsZW1lbnRlZCBp
biBWMi4NCj4gPg0KPiA+PiAzKSBpZiB0aGVyZSBpcyBhIGRldmljZSBkb2luZyBQMlAgYWdhaW5z
dCB0aGUgZGV2aWNlLg0KPiA+PiBUaGV5IHNob3VsZCBiZSBwYXNzLXRocm91Z2gtZWQgdG8gdGhl
IHNhbWUgZ3Vlc3QgYW5kIHNob3VsZCBiZQ0KPiA+PiBzdXNwZW5kZWQgYXMgd2VsbCBmb3IgTE0s
IG9yIGl0IGlzIGEgc2VjdXJpdHkgcHJvYmxlbS4NCj4gPiBUaGVyZSBpcyBubyBzZWN1cml0eSBw
cm9ibGVtLiBNdWx0aXBsZSBwYXNzdGhyb3VnaCBkZXZpY2VzIGFuZCBQMlAgaXMgYWxyZWFkeQ0K
PiB0aGVyZSBpbiBQQ0kgdXNpbmcgQUNTIGZvciBwcm9iYWJseSBhIGRlY2FkZSBub3cuDQo+IEFz
IHlvdSBhd2FyZSBvZiBBQ1MsIHRoYXQgbWVhbnMgeW91IGhhdmUgdG8gdHJ1c3QgdGhlbSBhbGws
IGZvciBleGFtcGxlIFAyUA0KPiBkZXZpY2VzIGhhcyB0byBiZSBwbGFjZWQgaW4gb25lIElPTU1V
IGdyb3VwLCBhbmQgYWxsIGRldmljZXMgaW4gdGhlIGdyb3VwDQo+IHNob3VsZCBiZSBwYXNzLXRo
cm91Z2gtZWQgdG8gYSBndWVzdA0KPiA+DQpTdWNoIHRoaW5ncyBhcmUgZG9uZSBieSB0aGUgaHlw
ZXJ2aXNvciBhbHJlYWR5LiBUaGVyZSBpcyBub3RoaW5nIHZpcnRpbyBzcGVjaWZpYyBoZXJlLg0K
VGhlcmUgaXMgbm8gc2VjdXJpdHkgcHJvYmxlbS4NCklmIHRoZXJlIGlzIG9uZSwgcGxlYXNlIGZp
bGUgQ1ZFIGZvciBnZW5lcmljIFAyUCBpbiB0aGUgcGNpLXNpZyBhbmQgd2Ugd2lsbCBoYW5kbGUg
dGhlbSB0aGlzIFRodSBtZWV0aW5nLg0KDQo=

