Return-Path: <virtio-dev-return-13790-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75DB4CD37B0
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 06:17:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C9AC622365
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 06:17:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C3D97986665
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 06:17:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B63BC98640C; Mon, 18 Sep 2023 06:17:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A3E1698638E;
	Mon, 18 Sep 2023 06:17:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpbqyvPfk478jnqaJTtx/nccIdgZ2xYo6GBJcm67phsWAPnrFBUgZmHsgUwlDJH5l5v2Wl+HqPoY56jMi5Ne6TtSuOdGCdap1XWB54EAIuTD4tdNJjxtCgo0p9TW/0y6c10hjInIkY7aM5RBF9KM9FNFn5UP2Kc2tRO4ZFRnPzXweBpIps2FlJgltJFslLCYMNqcVOp5mGz1CenawMmCdOME6CcCb98JHX0CyXShzCLjMh5nqOhfeXEEOQB7m3OacoAkHPjmOeqttIgEBqSlD2mRCCirGUpVxsOs1oefYxt3ubkLmWtV+TNfOAylC6Xh1Yl46aNgfr2uZVRTjp15Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=plbaMpOvM6gCSmF3dFd/tzu1HGAMv3qdGdtIt0+XwIk=;
 b=oe3APxoEYgEThM0MuP97gBsNRJSOIYtaXeBJbIUZDELClK/p5KI98Os+lG4vEO4HDz1jfr30bWg3HgeynKGGsnQNT05rdUojR0yw3gl1LrD2Lo/ASPeqCFmsxOCY0YsgkWsOG2awEifEs2kV9brR8WC5BKyxKR2Mqui2QfIaVhcGZlsAVMbkcj4hjwqHSzBeVOAlr+x4kKdQOEGuxzXgRnsFuWEewLL+Ip3I9dYC4jG63OveVFOJ2sn+7IHq8wGIc1Vd6vOIP8WbplstPruiB2X2YN2u5ocWZcp4HVvIhiBfxpaMTf3feVUxrxzFFLet/+hOIdoU+AGGM8QR9gTlfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, "Michael S. Tsirkin"
	<mst@redhat.com>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "eperezma@redhat.com"
	<eperezma@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-comment] Re: [PATCH 2/5] virtio: introduce SUSPEND bit
 in device status
Thread-Index: AQHZ54Brxw1ek7h0hUC1WdnFAMp2C7Abu4+AgAQs4gCAAB0UEIAACZoAgAAQp2A=
Date: Mon, 18 Sep 2023 06:17:17 +0000
Message-ID:
 <PH0PR12MB5481309462314E5E17B064A1DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-3-lingshan.zhu@intel.com>
 <20230914073023-mutt-send-email-mst@kernel.org>
 <258989c9-8c5f-c72e-c03d-aabf11f9823d@intel.com>
 <20230915070504-mutt-send-email-mst@kernel.org>
 <3ff7e79f-8fbb-4e3e-eb12-17ed8943fe6f@intel.com>
 <PH0PR12MB5481E091659FEA931DBC826EDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <90ffd64c-9997-3ebb-6d4b-6fdb8d1bdb4f@intel.com>
In-Reply-To: <90ffd64c-9997-3ebb-6d4b-6fdb8d1bdb4f@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB6482:EE_
x-ms-office365-filtering-correlation-id: 5f785e4c-1f05-4303-9f98-08dbb80ee8b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8FrWZbzvCufGn5DYu6UQ/M2T1Dp6GKRHoyxdYv6xh7Jw1+ehemEE8kk+yx5wdXlBs3V2L4aEUegMFfugMVO58BwP3EQ2NEVB4nT8yGq6aGRtaBIiLix2Yj85NHe8/IEPUNu4brfu/nF5k872P/Hak2n+V0v9g8fx8J1ypnAmv8hLcLFyryGasIJSXEKTy0qrML/uU6mEu2YPxMHd9hxKakxgKrFf8NqTcvg9zq4XqKcE0MekfE1rFboGhVh9D+f39MQ5TEAuyRyrJh/4qFPsY6CQmL+7Z8zZ466rJ5K56hA5f/6hHaZl628pVrMTnvi4cxl3HlFLEvGO9I6mXl6FjO2Zl0UUreigVpiE+WbzrdoECslgHwKxb139m6mSUvEOt95sJDSyCZOb6kElw8Bp86nY6XNk4sqPdTaDZETuAXtXTNUl57ve62QrJWOXL5g7e+To9X8kPkNaF0GOh5dAbnOeKHWrVG9h7KnFvzyBdgY0U5nzxYng5i88lfgcWBZRq9GsYlKnG66pyd2LGO5mDSTaL1o2V6SuS0hV050lZD0vEWvPW/wXssm2EsP0gwrhjijD2wYonxQqu+xj7lnWvbSzOtc/MurlVr25JjeFjBil5Nu64pFnqUlnAcl8cHlu
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(39860400002)(136003)(451199024)(1800799009)(186009)(38100700002)(122000001)(86362001)(55016003)(33656002)(38070700005)(54906003)(2906002)(52536014)(7696005)(5660300002)(66556008)(76116006)(8936002)(66476007)(4326008)(66446008)(64756008)(66946007)(9686003)(71200400001)(83380400001)(316002)(8676002)(53546011)(4744005)(6506007)(15650500001)(41300700001)(26005)(478600001)(110136005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OU5mYURhdFJ2anVqWW5oVGIvcGZzcTA3WmdHaSsvbGplR2lxb1Y4anFXd2xT?=
 =?utf-8?B?QzFFV0Fka0tXS0hYc09KaGR2VFFMZVBvelNIUjc5N0VoU05BZFFlWm5EVGw4?=
 =?utf-8?B?eHRKTk9kUEJKS0VRNkRHelBFNElHUEM1cXdsSnA2UlJpYS9iSzlRQVFlVDZY?=
 =?utf-8?B?Y1JVaVo3ZmRJVElIdWt5cXBuZC9DNW1XYlp5RDBqT1dQcUpYUUdVaG9OVXhO?=
 =?utf-8?B?ZDh3MVBPVE0zY0lmMG11S29Ob3d1Vyt4V2xqWmFTNmVuVUpabExLTVQxQWh6?=
 =?utf-8?B?Y1ZMOTdlaWUweCs2blBsVnZacDJFbUVGMmNUWGNoWUpGa0d1RWtxZ0xtRmJp?=
 =?utf-8?B?Vkp6VXI0clhldmVwVHdjWVp4MUoxYlcvQllzSUh4eERnRUJ4Um1MVnpqMWN0?=
 =?utf-8?B?S1pHR3hHYUFacHNOd3J5SkZ0RXZKNG5vbHNoNlRtUStWQUFxY1RzRWtleVdJ?=
 =?utf-8?B?NC9SakFUZjA4TzRSdS9CZTNlZVUyeFF3enVJaUtYS1d2LzlFV2JneDFyc2or?=
 =?utf-8?B?ZEFRdXRTWnRaQVBkWmpadHZPNkZLY2diZHJOTmVCUlhSdEFINkVHU3pHRGR6?=
 =?utf-8?B?NGlrRGpsbVRiYkF2bnFnOW1HeS9pUjBWZENvOURoaDVSRmFPTkpyV2V4WVFO?=
 =?utf-8?B?c0dVMjZJdi9ZVktpOVowdWlVTUU5WmRZMFp6czZoM0RFSVdPOGNGQk9BdGRH?=
 =?utf-8?B?Vm1rMGNvVnJ2bVk2OWV4L3UxRFFyZzRCQjgvYnpOK0VENUg2Snd0ckF4cU93?=
 =?utf-8?B?b0FpTlQvMzJzdnJjYk15dmsxcXNSdmhpUmEvc1Z1d1BrZDJ4TmlCUUg5elMr?=
 =?utf-8?B?L1VFY29SZk0vOWQ2V1dxK21tSzc2THVkNG1oM2lpdHdYZmplYlNLNHNvVnhU?=
 =?utf-8?B?NDRuRHpKZTM2VmZQQVlJVWJSTE1tNVFSQm5RNGpzeTA1c1JwbFJxUWlxU2lt?=
 =?utf-8?B?cStNT0hHSHNDdkVYR0pkSHo4ZmM2UVBuaHd0ZTZFcjlZVTBESWlFZFNtVFlF?=
 =?utf-8?B?c1NQekRvRG5LRnNndGRaTXR5ajk0dnBkNDBLaE1XQjRXY2NpOUMvUFdCSlN4?=
 =?utf-8?B?TjhjM0NXVWRUYmR5bUF1VFlhcG1EYWExRGsyaHRBL3NFcXVHT3VyMDlWaW45?=
 =?utf-8?B?MEZjc1hjVmpVOHRoZFd0ODczZ25JN1JUREEwSTFkY003THc0TXlDVlNjUHYv?=
 =?utf-8?B?YXp1Nm11ZGtoMEtPa3VacVBzVDhzZzlRTU5scGU3cHdWTUJoRVNSL1NSbktP?=
 =?utf-8?B?endVZEU2TFJ0WStJMlVVcnlrSTB2YnFJbmRUV1B6TnJZL2NRcEdRTW9aWkRO?=
 =?utf-8?B?MGdFVERyeUVoNVJneXBIN2ZzU3BsdFhGdDNlZEV0Vk9IUlB6c1o1dmxFNXN1?=
 =?utf-8?B?S2laUjZoVWFmRU9oRTQ2RnZXZGZzNUtkSEl6Ky9qdHAzMVB3cWp4MTlUaFdW?=
 =?utf-8?B?ZGZWQ3p6bXlMRzQ3WFd5a2ZMWHl2eUhjSHEybStjU0hIUDhWRVZYV2M1cGVk?=
 =?utf-8?B?VDJiMWFieTBJQlVaYlk2RWV1d09vdjI0d0IwUHBNRC9hT3dBcXFjN2pXeHZF?=
 =?utf-8?B?Rk11bmZEV1VUTmtsM2hBUVZka1JBazkwbTZQcVFncm5HMnQ4UVNoeVZ2U1BY?=
 =?utf-8?B?WElGSldCcC81OWtMZlcxNzNRZ0lwOTJ2RVkxaElNbGhxS0ZrZTc0ZldOY25t?=
 =?utf-8?B?Vzl3UVU5YTRiNmVKb3l4Ky93ZU1idUxKUW00OHhoTWV3Ym5HUHlaWk0yR2dC?=
 =?utf-8?B?OXdubncramc0Ni8rN1RJSVRGZ2hmeVRQM1hKOVFCR2pRaHVTcVJ6dVZjRlA2?=
 =?utf-8?B?RWNMT1E4TXAzd3BXOTlZRXJ6WjhQbXppcVU4T3N5S0hBOFJzRE05MVZlMitT?=
 =?utf-8?B?dGRrYXY0N2JRRlAyL3VJRExsL21xeTJXSmxVaCtTQy9TaWx5Yms1SVVVdHlC?=
 =?utf-8?B?UGQ2MTRJL0k5ZEI0cGhGNStJSTJ0OVZ5NWhKNkxDR29GTkQ1cWtybkIvY0Fn?=
 =?utf-8?B?U2U5ZHprKzE4Vk9UMVB0VTlTbUUxVElFUHVoc0FqMFFOZGdQSzBGeVRyZXha?=
 =?utf-8?B?bmpuRVN0a2FuWHYxRTNRNTRWVEFBNXRYeGNOcnQxNEk1cmZHWFJLcHFaZDVs?=
 =?utf-8?Q?AJbk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f785e4c-1f05-4303-9f98-08dbb80ee8b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 06:17:17.6112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yVP6GSQqeEJa5affztDygpZkmixyhkJluOWhq6nPJe07TIEUhXCpyb8pqsXPWkaQGugf0auQqJoA2kvrg7nBfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6482
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 2/5] virtio: introduce SUSPEND bit in
 device status

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IE1vbmRheSwgU2VwdGVtYmVyIDE4LCAyMDIzIDEwOjQ1IEFNDQo+IA0KPiBPbiA5LzE4LzIwMjMg
MTI6NDIgUE0sIFBhcmF2IFBhbmRpdCB3cm90ZToNCj4gPj4gRnJvbTogdmlydGlvLWNvbW1lbnRA
bGlzdHMub2FzaXMtb3Blbi5vcmcNCj4gPj4gPHZpcnRpby1jb21tZW50QGxpc3RzLm9hc2lzLSBv
cGVuLm9yZz4gT24gQmVoYWxmIE9mIFpodSwgTGluZ3NoYW4NCj4gPj4gU2VudDogTW9uZGF5LCBT
ZXB0ZW1iZXIgMTgsIDIwMjMgODoyNyBBTQ0KPiA+DQo+ID4+IGEgbmV3IGZlYXR1cmUgYml0OiBW
SVJUSU9fRl9SSU5HX1NVU1BFTkRfUkVTRVQuIElmIHRoaXMgZmVhdHVyZSBiaXQNCj4gPj4gaGFz
IGJlZW4gbmVnb3RpYXRlZCB0aGVuIHRoZSBkZXZpY2UgYWxsb3cgcmVzZXQgYSB2cSBhZnRlciBT
VVNQRU5ELg0KPiA+IFRoaXMgaXMgc2ltcGx5IGEgd3Jvbmcgc2VtYW50aWNzIHRvIGJ1aWxkIHRv
IG9wZXJhdGUgaW5kaXZpZHVhbCBvYmplY3QgYWZ0ZXIgaXRzDQo+IHBhcmVudCBvYmplY3QgaXMg
c3VzcGVuZGVkLg0KPiBBIGRldmljZSBjYW4gY2hvb3NlIHRvIHJlc3BvbmQgdG8gYSBzZXQgb2Yg
c2lnbmFscyBhbmQgaWdub3JlIG90aGVycywgcmlnaHQ/DQo+IA0KPiBBbmQsIFRoaXMgaXMgbm90
IHlvdXIgYWRtaW4gdnEgYmFzZWQgTE0gc29sdXRpb24sIHRoZXJlZm9yZSB0aGVyZSBpcyBOTyBQ
QVJFTlQNCj4gb2JqZWN0cy4NClRoZXJlIGlzIHBhcmVudCBvYmplY3QuDQpUaGVyZSBpcyBWUSB3
aGljaCB5b3UgcHJvcG9zZSB0byBkbyBTVVNQRU5EX1JFU0VUIG9mIHRoZSBwYXJlbnQgdmlydGlv
IGRldmljZSB3aGljaCBpcyBhbHJlYWR5IFNVU1BFTkRFRC4NCg0KQWRtaW4gY29tbWFuZHMgYW5k
IHZxIGV4aXN0cyBpbiB0aGUgc3BlYyBiZWNhdXNlIHRvIGFkbWluIHdvcmsuDQpUaGUgYWRtaW4g
dnEgc2VyaWVzIGlzIHNwbGl0IGZyb20gaXRzIHVzZXJzIGJlY2F1c2UgaXQgaXMgaGFyZCB0byBk
byBldmVyeXRoaW5nIGluIG9uZSBnby4NCg==

