Return-Path: <virtio-dev-return-13126-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A2EEB64DA
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 15:59:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 255DD2ACA4
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 15:59:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1DAAD9865E1
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 15:59:24 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0FF0E986585; Wed, 28 Jun 2023 15:59:24 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EEB37986587;
	Wed, 28 Jun 2023 15:59:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b81HyfEIrgXIeodJtN3zAChUmf+9HpVDjX0ag1vM+OmTiYu+1iqST5F9gxf7sVwoaC97ZH5nl6ZmxhfpKre2slc4AUTKV9TPwZiSFfllQ5QTiP1HZ7RNqF6rg4avCmhATdy+WTN2U3bVhr/BDA7yvtRy80/sPjBS4iZRtXmjnCvlQvZAIWmADG8n1MWFkFOQwiT75OqpvNMI/gaIbWWYOGYLTLTG2k2sFT9Q5n+LRx8N/eAOBzGEvsWqv0k7dsFYNDM6XtltHM24vrOVkC+dOGfqzRxIjcBaDo0zLHUIIrqepaVvDb7rymx8sSGZH8TJBMmLPIgAcdVYv2K17GSoRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7iHq8KknAIgAGf4++DZEbu2L3G8GWJH3xwQD7J8Kpc=;
 b=R2CGkWCxWQoGU4Jk0S1QduFcBah5zN3YJc1l8te/BlwePSJjtOJwoH1SE2Xg/XRs2ts/xg2FYlL4aKcfVTF72Db/Ci5gK+HNoPkq02ozV8CBEUYum3huKrbxdQtwgwGOOsB2D5gzLghKboFmCkgw4+8P8ZVn1DnduHsGA+U33rw5j6y2NjJmUL5xDOJWYQVcBHqRCsc8g0LBi3SzPve4oWq23im11ktFa+0fHTEalsMsJ9bGgUzTajr8iKNWHl4RxpiNIULu2kbWCmBb6ws6CnlbopivbWHmLsyZFb20A2W6IkYp6gELK3qIaI9eWLw6uK3UVpx3gjx1BIxqhtjEmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "Michael S . Tsirkin" <mst@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>
Thread-Topic: [PATCH v19] virtio-net: support inner header hash
Thread-Index: AQHZqRVyfixvgxNlsUC5ASNdYCAGYa+flAoAgAAIhiCAABaNgIAAnu/A
Date: Wed, 28 Jun 2023 15:59:14 +0000
Message-ID:
 <PH0PR12MB548102A43104218F481B8679DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230627163549.40028-1-hengqi@linux.alibaba.com>
 <CACGkMEvFmAiWDp8w=ytin21Oi+PcTb1X3Eve7Kt2NVr_RkhgmA@mail.gmail.com>
 <PH0PR12MB54811123CFCDEFE3B48D4381DC24A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtgomh1EGNLqhXQssRW02nnHkamxT5rV5eZZ9BZFH=uJA@mail.gmail.com>
In-Reply-To:
 <CACGkMEtgomh1EGNLqhXQssRW02nnHkamxT5rV5eZZ9BZFH=uJA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH0PR12MB7094:EE_
x-ms-office365-filtering-correlation-id: f71249ba-7fd2-4f32-0e44-08db77f09ee6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5RRD3fO2S0Iwzbq9/LqhIiS4cOhAxIJfGp+424tGlm+p9+CiPVzmHVKAVj7mA5dc9ShBM1Kb68oO5WVxxdE83tPk7UqA0P9iSrawDWrk0aEMRD5iMfq7COYKWQ7tMRD+xNN3OlvJ/a1e4OX81dj0wxheqgex6GKjozeSBTyXustoNtQB9mP1EWIgeu8h56NiTsmfqsrL6hxXdZYferLXxOCGWu2AG0HCWmu37foR6/z1tHvnLadaMMaNnr5+84KRP5anb6b43Yrztu40E8gWk9F51vvD9XcN8jS6KW2m10sZ9DIP1iBWpT1h/nkqH1q356exLWvjuMALoTNYPPR/AENTFKiHEDWQOLbmku+s0raJbci8ONnIbmjA25P+QvLObK+RAtVHQrrbL4R7z70B4OwGbNcyzVk+gaejB0JCf2C9L0T+NKs9NElmWLVaF8WR9kwS94wRgzAvnLh1CvVuHotN6q3TmN0gREXBUPAapIVkIrOc+JAawAu8g2ACwgK97kwUaX9QhZs9gLECgxZ6U1l1MCJ2yN/AS8hPv/6yAJ8DKEG5KDnfbRL+farIecqP5yFgG5xRDJbJ4DC8oyKKe5A2eUcwt0DCVuIGM/R1+hrIVRPXS5vKCC7dK9xW4/v3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199021)(6506007)(122000001)(52536014)(33656002)(66476007)(76116006)(64756008)(5660300002)(86362001)(316002)(6916009)(4326008)(55016003)(66446008)(66556008)(41300700001)(8936002)(38100700002)(38070700005)(66946007)(8676002)(2906002)(4744005)(9686003)(7696005)(186003)(26005)(71200400001)(478600001)(83380400001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UjB6QzYxUG9NcEcybnNXVysxdUk2V2F1L3N3NHI2YTJiZ2c3RUswSVpnUFM2?=
 =?utf-8?B?NnB4RXZvaGFqZGRxZE9RZ29XbUZtMWlFdzZJT2dJRGt5c1d4RXE5SVpOeUpw?=
 =?utf-8?B?dHY3aTZCaTJPTEp5YllmbHh5eCttZ3YzZC9FNzZsMjhwRzhpV0RJNWZacWIx?=
 =?utf-8?B?RFg2K3BDT2FPZ2lEV3dlNG1tampJSFF3R2lUbUdRVmlqWVEvNkpTY0wyQTNj?=
 =?utf-8?B?TEdjRXFrU0lhNFJFQUs5RTBUaTREcEsvS1hHUDhkbThjWURTQnJscU9rU052?=
 =?utf-8?B?STJUbjJrQmFyeTA0bGpFbEVzbVZ3TFJ0eVRTYkVOMWtTb3RWR1JBcEx3cFlu?=
 =?utf-8?B?aHpuZm9CWXlibUlFWDVNeDIxQWZRVTU5bmNVb2RZZjREZld3ampBYy9oc1pU?=
 =?utf-8?B?Yzh1OHducWM0blE1UE5rM2NMVDkxcTlpWnpvNHBuODB4TTJaN1NHc2M3Mmhm?=
 =?utf-8?B?dE9RMUpqNDFpQWVOYzc3dWJ2cU1vSHZLaEZpRGJwalh4MmNiZzN6NldmdkMx?=
 =?utf-8?B?YjdSeFdaK3B3b2FkOVU3Y3YrQWhXQXNxQnY4bXUxNFk3dDBldkVIUFZHT2Vz?=
 =?utf-8?B?eW0raUlKMmdSM29RaWEyZ1VJK0F6RlBkM0J4bGpCOEk2UHZGZnN6SkY2T21i?=
 =?utf-8?B?bGZveWx6MGptR2Q5d0REL3dGaEw3SklmNHRWNXJjU3RQQjlGV1hveEVOblQ0?=
 =?utf-8?B?ZExESjROZllRWXl6N1Jsb1B0QnViR1RxMTIralRweTN4TWNiYklVZnRZTzhv?=
 =?utf-8?B?cDVTMUM3K2ZNQ1VGc3E5NlhXclNKYmh1NDJjTWEyNFFYcGNNbWxpSjRMVVdz?=
 =?utf-8?B?c3VieTJxWkdXckZ3Ykg1bTVReXM4ZmFya2lHOUhnODQzZ293ZlBnUjFuVGIx?=
 =?utf-8?B?VUNSdkZSWElvbjdQVTRoTGxJdU93ditOTjRVV1djaFQ5UWRIemdjc3JrcXZM?=
 =?utf-8?B?ZGlrMFVwMmVKWTJwZkFZODJjOVE0Vzl3ZHNjeGFJSmJBV1RHRmdHeXhlaVBz?=
 =?utf-8?B?eE0rdlR4YWRLSGRsYy94cjZ1N0dTWHpLVHdFb0tuQktJb1B2VWE5dENDWVpq?=
 =?utf-8?B?bnBGd0thbjhoZElrQW9iSEdNa3R0NG04MXQydjE3M00wVmc5a0ZGNU5oVTRW?=
 =?utf-8?B?bmt2V2YxVUZWSGpteS9Nc1NHNGZ3S2lRdlVWRGsrR2U3TkV4NXpXWENnSzVZ?=
 =?utf-8?B?U0h1VXllOFFONlNqOGpsemZTUDEyR05JcFhuTlp2dUNtSXQxTHFuYVU5dnpv?=
 =?utf-8?B?NVJiRng0aEoweU1FVjVTUGdERlVnb08xdGF1djZ0VlZGZW5Db1MrSk9ENnZi?=
 =?utf-8?B?dHp5REhDUXlQamNxZHVIZnQvekQxNEMvTGpwVXQ4L252cittSHo5SnhlUHQ0?=
 =?utf-8?B?djRQeE12MjQ0VzBCUmpKMVpyalp0L2dGTFNmeFJzQmhUNVZTWXBlZWVDS3dh?=
 =?utf-8?B?ei9OTW5za3dVMWtOZUVYR2RMSGlZSG1VYzl6ZjVHd2M3MHRZRFVPQWhEcVNE?=
 =?utf-8?B?cVBIMG5VSUxXangweXJTMjNjQmdPYm9oeCtCd1dqVHVjU1l2dlg4Zy9hOERk?=
 =?utf-8?B?ZGdscWFZcitWUnMwV1NpTVd4L2ZlTFlkM0pOWURGUW5vdDRTV2dsdEtVSkhu?=
 =?utf-8?B?V3Q1cUxaL2I0Tk1xZlBkZ3cyRXhDb3prR0lZanF4elQ2dmtWUHNZc2RpVHJ5?=
 =?utf-8?B?M1g4enBQUVdrWU9ObktoUkM3VDdsd25KWU0vZkZkZDF0NkZHanpPUDhJeWtN?=
 =?utf-8?B?d2dzRVVmYVREaExVUGtVbTBlQ3hUbmE2dXJqOFhtbVoyc29nL0dEampLR01x?=
 =?utf-8?B?VDBMTWs1QXZGWS9hUEhVQ1Y0alFCY2R4aDczWVdSZGlhZENiTGswY1dZM3B3?=
 =?utf-8?B?VSs1b2dTVk5TajA0YjJ6R0FPV2dVMGpELzhmRG5BRlhxbW5yQWFpZ2l2cmVH?=
 =?utf-8?B?UFRpelBsWm1XOWdFeXE5aGZaWjVtUEdlU3QvbnR6aHdORHBHRWFUSkFyVXFt?=
 =?utf-8?B?amNzUEhFSkVRUTJieGNSUE5FaFVOblBWY2paK2R5NGpxeDZlNkRTNXdRei9V?=
 =?utf-8?B?UGxaUDI5eWxibkFOQ1lwR3ZKUjJFVzlxR0YzZjFVWHowNTJzKzRoeWxRcFdZ?=
 =?utf-8?Q?yYvw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f71249ba-7fd2-4f32-0e44-08db77f09ee6
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 15:59:14.4467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bj9d+PgAAitNE9K6VBFGPnPzkyzgLIbsRyIyaq7UzxOWaR41HLNw/TGRTeTlw7mrMJl2CkL4qiA9PjTcDYEGYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7094
Subject: [virtio-dev] RE: [PATCH v19] virtio-net: support inner header hash

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogV2Vk
bmVzZGF5LCBKdW5lIDI4LCAyMDIzIDE6MzggQU0NCg0KWy4uXQ0KPiA+IFByb3Zpc2lvbmluZyBp
cyBmYXIgc2ltcGxlciB0aGluZyB0byBkbyBpbiBkZXZpY2Ugc3BlY2lmaWMgd2F5IHRoYW4gYXNr
aW5nIGRldmljZQ0KPiB0byBzdG9yZSB0aGlzIHZhbHVlIGluIG9uY2hpcCBhcmVhIHdoaWNoIGlz
IHJhcmVseSBhY2Nlc3NlZC4NCj4gDQo+IEFyZSB5b3Ugc3VnZ2VzdGluZyB0byBub3QgcGxhY2Ug
YW55IG5ldyBmaWVsZHMgaW4gdGhlIGNvbmZpZyBzcGFjZT8NCj4gDQpZZXMuDQoNCj4gc3RydWN0
IHZpcnRpb19uZXRfY29uZmlnIHsNCj4gICAgICAgICB1OCBtYWNbNl07DQo+ICAgICAgICAgbGUx
NiBzdGF0dXM7DQo+ICAgICAgICAgbGUxNiBtYXhfdmlydHF1ZXVlX3BhaXJzOw0KPiAgICAgICAg
IGxlMTYgbXR1Ow0KPiAgICAgICAgIGxlMzIgc3BlZWQ7DQo+ICAgICAgICAgdTggZHVwbGV4Ow0K
PiAgICAgICAgIHU4IHJzc19tYXhfa2V5X3NpemU7DQo+ICAgICAgICAgbGUxNiByc3NfbWF4X2lu
ZGlyZWN0aW9uX3RhYmxlX2xlbmd0aDsNCj4gICAgICAgICBsZTMyIHN1cHBvcnRlZF9oYXNoX3R5
cGVzOw0KPiB9Ow0KPiANCj4gV2hpY2ggb2YgdGhlIGFib3ZlIGRvIHlvdSB0aGluayBjYW4gYmUg
YWNjZXNzZWQgZnJlcXVlbnRseSBhbmQgd2hpY2ggcGFydCBvZg0KPiB0aGUgc3BlYyBzYXlzIGl0
IG11c3QgYmUgc3RvcmVkIGluIHRoZSBvbmNoaXAgYXJlYT8NCj4gDQpNb3N0IGFyZSBub3QgYWNj
ZXNzZWQgZnJlcXVlbnRseS4NClRoZSBmYWN0IHRoYXQgdGhleSBhcmUgaW4gTU1JTyBhIGRldmlj
ZSBuZWVkcyB0byBwbGFjZSBpbiBhIG1lbW9yeSB3aXRoIHRpZ2h0IGxhdGVuY3kgYnVkZ2V0Lg0K
U3BlYyBpcyBub3QgZ29pbmcgdG8gdGFsayBvbiBvbmNoaXAgYXJlYSwgaXQgaXMgdGhlIHJlZmxl
Y3Rpb24gb2Ygc3BlYyB0aGF0IGZvcmNlcyBjZXJ0YWluIGluZWZmaWNpZW50IGltcGxlbWVudGF0
aW9uIC4NCg==

