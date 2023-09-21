Return-Path: <virtio-dev-return-13900-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D24CCD494B
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 04:11:55 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B53FFF3F4B
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 04:11:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 97E95986688
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 04:11:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 825BD983D6F; Thu, 21 Sep 2023 04:11:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 736AF98667C
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2023 04:11:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OTMu2I/dYWLYElaqppmph1t7XQlLA45UkvRHGpipANuK2ykCChAMcv6J3vej0Bftw13ulDnjwYB5EVF9zu2uYrB6NgkWRqZfsozxuMOjauxWOPSp67t/faDqkUJVRfelqcmYJ8hMYZFypbz/kMhHMbdctTOE2N8UW4oNSI9GTnV5QfzKkjOKFT3nfVy8Tm6OE/JQpTKHLk4RtbtOM4Vkf2/Tzc0ae5/N45QAH6rqCl0yhzWFiTNje323f5XpX1Eh0kJpECgiXWOw1V7bbxOhOsfenWBAZafoD3IpcqkRRWeJqYvqCGvKo1xjRCws8qqwGPhVMrbTardF0dgRmjvhvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tnNl8+SvDQ02TwTbzbvPUYCJvmW6iWhhFkQtW7nX+S8=;
 b=bUvTzgWrJbvL25DNVfNLZexTEeXcAtj7bHTNtxoxOwSSs8gcb4TxpZgwDoUULeqjx1zOzehDyE6DkBFms43lYMtrXpdCXar8/tDuDzmxyKDp0Qt46MqHvIiLyrZzukDi/n7iJxnLhCscM6+50DxoPwYF8SsXihAUv96M9ekQJ8qZjHn1KiFSu/pJ365VW8Wjm6LIQpqlHnkgCzO2T7m6AeA3O/8kpyTOwRTIha5yUxWpKN6J146I49AwjmFLCmtLtAaBoSlWUGMuO1rM3frT0g1kY+Hxexg6N+eJ2NydUzhm19mX5HDeuA5kqXvJPthUFQ/Mdl7bIreD4Tb+nI1zYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "Zhu, Lingshan"
	<lingshan.zhu@intel.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state
Thread-Index:
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAC3dgIAAl98QgAADDoCAAk+KgIAAS2wAgAAM9QCAAAwSAIAAAu6AgAAG2oCAAPQiAIAACZXwgAADzICAAABeUA==
Date: Thu, 21 Sep 2023 04:11:51 +0000
Message-ID:
 <PH0PR12MB5481E3D047621B4C273AFC2EDCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com>
 <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org>
 <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org>
 <2f67fb85-2238-9c34-a265-b0f97b7ab7e1@intel.com>
 <20230920075243-mutt-send-email-mst@kernel.org>
 <ec70e1c7-ffc3-fb6e-0b0a-6f51d7d9d0a5@intel.com>
 <20230920083057-mutt-send-email-mst@kernel.org>
 <CACGkMEuAEOVvrw2SKhP2fpcDjvtVvYOv21BGoA7RU_3S+AFxYw@mail.gmail.com>
 <PH0PR12MB5481840951E19EA1AE843C69DCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEspOB_=Po=q+-SAyXG8TDhLVRg0=nC2hpw=7oFirbCN_w@mail.gmail.com>
In-Reply-To:
 <CACGkMEspOB_=Po=q+-SAyXG8TDhLVRg0=nC2hpw=7oFirbCN_w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW4PR12MB6684:EE_
x-ms-office365-filtering-correlation-id: da224315-c17d-470c-2135-08dbba58e1fb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lBm5Vwgj/UQVWs1G4YLZqArLcY+bidFUyDX/1+nwuNWvCOo3rV2tkvIGV8EYEw5Vf9J6WGvvaSLeNFe4MqXtWFxZNFqhqyvH21DMrIBOosgXu0FrEQ8yjm7I/HIbrNL7qmt89gAwMs2CDBK+u4UBwYaUj28IKhWLZV6O0SM1EiMERRv3tJDNbc+XzK8utXuE9TBzf9ALb/6WesfvWIthyEMV+1lLvkt8BQmexCfMsNF+pcfvieIWTgacgdIEX461SQFA7HKUncW3vH58nsOFr/FX6FZ9FAtbcfikXam11g7z2cyS4YzKiPiSVExZyQ+e5BtnTNHv2hb5g6fq3cb3eatoXKX+3IlEcey1jh3dU8eIJIeERgS6I772yp015tqtv4WM0nehENV+7f43qVL7KZzNUBUdD8KBG76Z15TvQknZZcCy3RD0ssStMkML8OPnuFZm3gQYgx8fIpuqoHlsA4+7iuuIPJEdR074AI8B4JaD1H0JgKEsB5f+/my+2ZCp+3ZG3aQk4My1I3iloRGdT2qvGsk04Ocg1EidZ27B+MOJ1ZqWQjOy/GdGUxPZevoXqq6NoBlgxrZHpRrID0pAFvP4sbYvpGS8p/OpixN76dLJRH/MClgD1qvPCQMub1aNDcmmVH+NymmcK/azGv9Npg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(396003)(376002)(39860400002)(186009)(1800799009)(451199024)(26005)(52536014)(8676002)(8936002)(122000001)(4326008)(83380400001)(33656002)(2906002)(5660300002)(55016003)(86362001)(6506007)(53546011)(7696005)(55236004)(966005)(71200400001)(6916009)(84970400001)(64756008)(9686003)(54906003)(66476007)(478600001)(66946007)(76116006)(66556008)(38070700005)(41300700001)(38100700002)(66446008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZmtzY0Y2TDJSZEpKOCtqU01tN3dNdTN0MHpma2VhNVNlbWd3aEkwbjRrY3dx?=
 =?utf-8?B?QlBJSEpZdzErUHJFNG1IK1o3OWc3bVNOajhqV251cDVlbmNqQkdIakgzZ2RV?=
 =?utf-8?B?YkJORWpYT1FMLzZFU2hCU1lUa3RaSUpTSy9lRFJYb1ltMExETHRCS2ZuSVhH?=
 =?utf-8?B?OE1ORlBWOUJoRW8vYjFPMFNPZ2lCOGVNYldYK0o1eTFPYlFXbmtCenpnS2F0?=
 =?utf-8?B?eTd4NnBTaXlsVDJjMjlTdW55QjBVb1dGQk1QemR1NTBlZ0dDMi9Bdm50MFFj?=
 =?utf-8?B?Q0dBc1cyQ0N3NFRUdEJoNkVHQW9VbUdENDBScXlsT2kwUzJqTWRaaWlQRi8v?=
 =?utf-8?B?SE5RSVZhTG94cGw2eGVOL0YySE9UZjZRRUxvOW9SbGtOMTNtRkdGSnl2RUhY?=
 =?utf-8?B?YjBYQkJ5MkVLQUR4SjVEbzUxWEZCMUVtVjlJU3lYNm0vWUlqd2ZLTjVCVkw3?=
 =?utf-8?B?b1N4UERQelFYd082SFRHM0xTZnA4azdvZWtHNzBSYzZDWkVWbElUL25KbDBq?=
 =?utf-8?B?R0daZDdqYVNCWjBIV1E1WnJuM2lETkJJbklEd2hKdU01MVlEMHoxM1pxRmFv?=
 =?utf-8?B?eU5jL1ZGMkJtMzl3eVdxb256QlFuZGJaSVMyeWRBZE1aNHlrbmd4YmQwcHVU?=
 =?utf-8?B?TFdoaWErbmxWYzl0NWJBWG9HNlE3ajVkZ2tkQXdZSk5WL2pzSCtGUVBpVEh3?=
 =?utf-8?B?c09ua3l3a3NFY2ZyN0gxYXg1bHFiNVk4UlJFNmNxN1dFemJTbEw4amlwampL?=
 =?utf-8?B?MC9SNkR5WThzQktEL1NQRXR0UFJRZTZHZlZhOFN1V1FHMVRIK0lNVHg4SW1J?=
 =?utf-8?B?SDV1VjFFNU9aZVRpVFlHMkFPb2lzdmVWeGhyVExxRGduc3JKZk9HMG5CcndJ?=
 =?utf-8?B?YmhOT0F1S0k3ckZnL1VFS2pIeWovYlNud0JyNFNNZjR2V3IwZXlhT1QwaGVs?=
 =?utf-8?B?V3RHbWl2YjZXZXZDbnRhTUpjenE3Tkpxc3lteE9PNUtSVlVmZDJCNFRONEZz?=
 =?utf-8?B?N0FYRE90VCs0NHkyR2txcjkzZHZ1NDFLcEJhd3B1eURmV1ZYeFFaaDNNV3dW?=
 =?utf-8?B?Ly80UDZVSjU1UndtOENkeGRxV29JQ2ZsNlVDZWdydHBhNHduc2hqak5PV1JK?=
 =?utf-8?B?UnJjbVZ4Yzk3L3NVZTVRa1A2Qm01cGpXSjRJQmVTSU45NHFZb2VUYURvRmdp?=
 =?utf-8?B?NzhGakErVjFkc0pUYThtVDZvWVpSUDJNbTI1TjdidDdVSW1Pc2xqV01VVS82?=
 =?utf-8?B?VmJKbVc2ZGxPSUdEZFJrUHhJOEVaaHAyT1dTV1hzT0FtSVlvc3BRdE15aG9i?=
 =?utf-8?B?ams0VCtyZXFNYWFnNWY3Q2pFOUxKcHB6QjQ1a0QxN1JpMytRWmhQS2VSSUJ4?=
 =?utf-8?B?WThCdWZsOFo0dGlCblRROWR2RnRDSVZPUmYyZFk0dk9vSTVMTHcxd3JtTWlC?=
 =?utf-8?B?eU01OEltcDAwVU1rMW9ZaEptQ3RZajlUdVRueTJkWmR6SXM5WEZyNVBGeCt1?=
 =?utf-8?B?SEJtc0FxV3RBaGJWSkFQbmlnSDJpMWdkRXlMRzBZTmNwaUhrVjBIQzFvQVdj?=
 =?utf-8?B?alJRSTdkYWsrQjdqeVM0eHd5SjQ3bExMNFhRQXVqQk5TalBjR3hzNHVmTEM4?=
 =?utf-8?B?aWcrRWdqSlNGbkJJb3F2WW1hYzZ2YWRaSmpXbFh1SFhzQXVsbzNKUXpucVJG?=
 =?utf-8?B?VVlzSElxUU9SUC9EU0VRRGNYdmk3QUsyZXQwTWZXaDRmNlpESmRCTGZ5aW1w?=
 =?utf-8?B?ZElVT0hrbHBjSEUvM2pRV2ZrSytPQUNKK1d4emIxd2p0YzM5N2twSjVmdWJn?=
 =?utf-8?B?YWR6bTRtTElna09RZkprMnJucWFCYlFQaWUxM3puQ0tDeFI5S0JXRHQzM3o2?=
 =?utf-8?B?N3dhWFJNUHBkWGFiU0pmWVh3eiszZW9iMDV5citSVE9PTFVGUmRJMXJFRUtt?=
 =?utf-8?B?OHZ2bVNqdlhSTVJmTXZoWGJENVVkTGpzSFFpOTkyZ01XTk15bmZVN0tjSDNN?=
 =?utf-8?B?bFhCWnlxeDFWR3FJa2ZpOXRzR3M1Ukhpb3owaUJVZlNjUitZNVZPQVh3b3Jw?=
 =?utf-8?B?azlHbTBBMCttSzdvazIrVmQ0V3V0YXJCL1FLNmRTS2NRQ3VJNGVPNVI2Z1Jt?=
 =?utf-8?Q?9hH0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da224315-c17d-470c-2135-08dbba58e1fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 04:11:51.3821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UEKIFF2akpNH1QECgPTkC1CwwNYQVRu9Q3AMTkP6UafI+H0WWIbS3WoJSS2fjC2MOs7VO4YN/JfUeWOk3C45Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6684
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIFNlcHRlbWJlciAyMSwgMjAyMyA5OjMyIEFNDQo+IA0KPiBPbiBUaHUsIFNlcCAyMSwg
MjAyMyBhdCAxMTo1MeKAr0FNIFBhcmF2IFBhbmRpdCA8cGFyYXZAbnZpZGlhLmNvbT4gd3JvdGU6
DQo+ID4NCj4gPg0KPiA+DQo+ID4gPiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPg0KPiA+ID4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJlciAyMSwgMjAyMyA4OjQ1IEFNIFRo
ZSBtYWluIGlzc3VlIEkgc2VlIHNvDQo+ID4gPiBmYXIgaXMgdGhhdCB5b3Ugd2FudCB0byBjb3Vw
bGUgbWlncmF0aW9uIHdpdGggYWRtaW4gY29tbWFuZHMgYnV0IEkNCj4gPiA+IGRvbid0IHNlZSBt
dWNoIGFkdmFudGFnZXMgdG8gZG9pbmcgdGhpcy4NCj4gPiA+DQo+ID4gVGhlIHdheSBJIHJlYWQg
YWJvdmUgY29tbWVudCBpcywgdG8gZHJhdyBhIHBhcmFsbGVsIGxpbmU6IGRlc2NyaXB0b3IgcG9z
dGluZyBpbg0KPiB2aXJ0aW8gc3BlYyBpcyB0aWVkIHRvIHZpcnRxdWV1ZXMuIFdoYXQgaXMgdGhl
IGFkdmFudGFnZSBvZiBpdD8NCj4gDQo+IEFyZSB5b3Ugc2F5aW5nIHZpcnRpbyBjYW4ndCBsaXZl
IHdpdGhvdXQgYWRtaW4gY29tbWFuZHM/IEFnYWluLCBsZXQncyBub3Qgc2hpZnQNCj4gY29uY2Vw
dHMuDQo+DQpObywgSSBkaWQgbm90IHNheSB0aGF0Lg0KSSBqdXN0IGRvbuKAmXQgc2VlIGhvdyBm
dW5jdGlvbmFsaXRpZXMgcHJvcG9zZWQgaW4gWzFdIGNhbiBiZSBkb25lIHdpdGhvdXQgYWRtaW4g
Y29tbWFuZHMgYnkgdGhlIF9kZXZpY2VfIGZvciBtZW1iZXIgZGV2aWNlIHBhc3N0aHJvdWdoIHJl
cXVpcmVtZW50Lg0KDQpZb3UgbWFkZSBwb2ludCBhcyAiZG9u4oCZdCBzZWUgbXVjaCBhZHZhbnRh
Z2Ugd2l0aCBtaWdyYXRpb24gZG9uZSB1c2luZyBhZG1pbiBjb21tYW5kcyIuDQpXaGF0IGlzIHRo
ZSBhZHZhbnRhZ2Ugb2YgZGVzY3JpcHRvciBwb3N0aW5nIHVzaW5nIHZpcnRxdWV1ZS4gSXQgaXMg
dGhlIHdheSBvZiB2aXJ0aW8gc3BlYy4uLg0KIA0KPiA+IFdlbGwsIGl0IGlzIG9uZSB3YXkgdG8g
YWNoaWV2ZSBpdC4NCj4gPiBUaGVyZSBtYXkgYmUgZGlmZmVyZW50IHdheSB0byBkbyBhbGwgYnVs
ayBkYXRhIHRyYW5zZmVyIHdpdGhvdXQgYWRtaW4NCj4gY29tbWFuZHMuDQo+IA0KPiBXaHkgaXMg
dmlydHF1ZXVlIHRoZSBvbmx5IHdheSB0byBkbyBidWxrIGRhdGEgdHJhbnNmZXJyaW5nPyBDYW4n
dCBETUEgYmUNCj4gaW5pdGlhdGVkIGJ5IG90aGVyLXdheT8NCj4NCg0KU3VyZSwgd2hhdCBpcyB0
aGUgZGlzYWR2YW50YWdlIG9mIGV4aXN0aW5nIG1lY2hhbmlzbSBvZiB2aXJ0cXVldWUgdGhhdCBj
YW4gZG8gZm9sbG93aW5nLg0KMS4gQWJpbGl0eSB0byBkbyBETUENCjIuIGFnbm9zdGljIG9mIHRo
ZSBETUEgd2hvIGRvIG5vdCB3YW50IHRvIGRvIERNQQ0KMy4gQWJpbGl0eSB0byBtdWx0aXBsZSBj
b21tYW5kIGV4ZWN1dGlvbnMgaW4gcGFyYWxsZWwNCjQuIE5vbiBibG9ja2luZyBpbnRlcmZhY2Ug
Zm9yIGRyaXZlciB0aGF0IGRvZXMgbm90IHJlcXVpcmUgYW55IGtpbmQgb2YgcG9sbGluZw0KDQpX
aHkgdG8gaW52ZW50IG5ldyBETUEgc2NoZW1lIHdoaWNoIGF0IGRvZXMgYWxsIHRoZSA0IHRhc2tz
Pw0KRmlyc3QgcGxlYXNlIGxpc3QgZG93biBkaXNhZHZhbnRhZ2VzIG9mIGFkbWluIHF1ZXVlICsg
c2hvdyBhbGwgNCB0aGluZ3MgYXJlIGFjaGlldmVkIHVzaW5nIG5ldyBETUEgaW50ZXJmYWNlLg0K
VGhhdCB3aWxsIGhlbHAgdG8gdW5kZXJzdGFuZCB3aHkgbmV3IGRtYSBpbnRlcmZhY2UgaXMgbmVl
ZGVkLg0KDQoNCiANCj4gVGhhbmtzDQo+IA0KPiA+IFdoYXQgaXQgdGhlIGFkdmFudGFnZSBvZiBp
dCwgcGxlYXNlIGxpc3QgZG93biB0aGVtIGluIFsxXSBmb3IgdGhlIGNvbW1hbmQNCj4gd2hlcmUg
eW91IGNhbiBmaW5kIGFsdGVybmF0aXZlLg0KPiA+DQo+ID4gWzFdDQo+ID4gaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvdmlydGlvLWNvbW1lbnQvMjAyMzA5MDkxNDI5MTEuNTI0NDA3LTctcGFyYXZA
bg0KPiA+IHZpZGlhLmNvbS9ULyNtZDlmY2ZhMWJhOTk3NDYzZGU4YzdmYjhjNmQxNzg2YjIyNGIw
YmVhZA0KDQo=

