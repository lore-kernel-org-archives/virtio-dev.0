Return-Path: <virtio-dev-return-12406-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D7CC6FD18
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 13:28:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F19DB14568D
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 13:28:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E10E9986656
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 13:28:02 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D5B11986447; Tue, 25 Apr 2023 13:28:02 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BC4C5986449;
	Tue, 25 Apr 2023 13:27:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JAr5xmzh2uXxDjN3Utjq27X4wYSb3Lqbp0FVJIT7hmBenKZyv07z8LPSd0EfDGBM27uO8ZMaqhk+6CKtLzlJLvOKP7qLYRvrQYnr2FqfjyjygcRAWqcx2UCb7bpEj7uVP58yDgyiF1ZDUs4rg1WVhwqKApnWt1UCuo7dq276kZ5eaVWS72kYIlGdCJ0qiSnYqATR60CVF4q6r3NUqtzxRvQPiW32UnWKs4+V+X5WH+EdbnS/08BEjUoZfdIV0PU5AuwMRsL7xslDTzj417hXExEOKKipzPv51yobP7HAdZA7mL/tVYA8YjFJCCf2fJRnbA8lbEBjnuHqpuUKyUsSdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ha46D4Rpukv656jI7oj8xmUEo1zHg6kqTphqsV35mh8=;
 b=LdN4DeU6oQdmaIx32jRLbK2GjbaCtNo3iSvig2dwPQibsa5V7oML8IW4AlhgBhOIAEB755c1D7TvxqEOAUpTpoO6owrDVe1oVXDl+nUednVArE1Ytxe1FUH4hPjOhdYuN4OPdyBuOL6Q8RlA7d7Qn03mP/bqIpiuvfsBeCltoftRb6cwq+IclYdzblzaGvjN6zty8o8tHyyWjhBavHJo43KyAhrByBPUkePy2uU/8fXGxNWHzzaSzFdf8/6auWI+i9/dgzhvwynmlvy57nHKw5Vytj/n3bMUmJvXW5pA73DNL59yF4WPRFed++50bb1xLDzaBXqX63a2ZZ8lMEBjMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>, zhenwei pi <pizhenwei@bytedance.com>
CC: "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"helei.sig11@bytedance.com" <helei.sig11@bytedance.com>, "houp@yusur.tech"
	<houp@yusur.tech>
Thread-Topic: [virtio-comment] [PROPOSAL] Virtio Over Fabrics(TCP/RDMA)
Thread-Index: AQHZdzNBmtt9WVKT+0+UqhnowhY2Ka87kJ4AgABz7HA=
Date: Tue, 25 Apr 2023 13:27:56 +0000
Message-ID:
 <PH0PR12MB5481A4AE08FB6056A642FF82DC649@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <1ab0beff-8b18-7a94-1a68-6bf36bcd0394@bytedance.com>
 <CACGkMEvh+G2Tm=WDTOK3K2GO8c2dQ4y=UiKAk_kvsid2MGzbGg@mail.gmail.com>
 <8f65c9aa-c867-0929-151c-21bbe25a0693@bytedance.com>
 <4150bd72-a358-c854-0c64-b149621a1b8d@nvidia.com>
 <d1e62181-894c-25bb-3546-16a4f92beeb0@redhat.com>
In-Reply-To: <d1e62181-894c-25bb-3546-16a4f92beeb0@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MN0PR12MB5956:EE_
x-ms-office365-filtering-correlation-id: 80d839df-16f5-40c9-6a3f-08db4590e186
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jv16z0NA9YnGXul6a8Ap23NEFBJOsKvl5IiiP1UEVRFWBnxrco3h8E+1PSDj0OIKBb7CjptZwjGB9CQHTwkOkxWISrtjkXj0FrH7nJHUnCwaxlzUbYsVwGdckbvSxNVtJX5IAfpqlKdnHsdqlcNAZPvZRzZcH7hbGzfhCFfRa6ZKehg4wcXAbxD92YsTMketupDjDe/p1W5qfBxKYbR+5eUBFKEH37xfOI+3wDrpUSdllDj5bcPI8xLKs5I7kt0BgcUAKgTaajPNY8uzEm2L89SRbn/fsltt+onhQP1T/CxIzAH5clJAvq89C7UBQqbMlF3uNcv3GnIjMkkp5gn6kY3QZ1AoTXbytiZrFZgqyvsurxz6j2VtmK+eNuI2Olc7GC2rvD9Fj+rZkmSmbwb3SH47X50Wxq0LuexlkgP0PVQnzyBjvOXqK1OrT2rsAHCCKyj7O0DfPaI4WdC72uem5wCubWA2p6XjxPX0h//2Wrp6NnNsSNMlfmPLNfAoeCdyZm0d0HiX4dFGj9eM8BYd9/K9Iyngp7nngLgrQtmgwTyQ5yBk3pZG6c6RuM3QCCGSGDV+98SOY1IX1u89RI50B65G50Fo9SE0ESp2N8k4Lp8vQgmCf6s450U59/2ZyinGeE94tJO21GUVO0ZZTpNBXg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(366004)(396003)(451199021)(38100700002)(122000001)(6506007)(9686003)(26005)(55016003)(186003)(83380400001)(8936002)(33656002)(2906002)(8676002)(52536014)(5660300002)(478600001)(54906003)(7696005)(38070700005)(110136005)(316002)(71200400001)(4326008)(66556008)(76116006)(64756008)(41300700001)(66446008)(66946007)(86362001)(66476007)(200143007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZGZjdGJZSjdlc3lwTCtFemlaSnpRczRYU0dCUWFCSzJLRFFZOUVLZ1VNSnh2?=
 =?utf-8?B?SzEvcWR0WHM0b1VZUG4wYW4rZVNLNjZ0aE9NWkkrTHV0K1NJZjFvZGQzNFFt?=
 =?utf-8?B?YWRTMkEyMVNYZlNvQTRQZ0plV1hsczFLVFBqK2xYM0lwZWlmeHY2dlMyb2tw?=
 =?utf-8?B?c0dzSDFlSXBiZ3lJNWxBYVJrOE0rZkd2U1FyZWRlbXI2SFpWY0ZaUGJsVy95?=
 =?utf-8?B?SFVnckhaZlF4RVg4T1daYzFoQUc5eW9XV0R0aGcxcEFCMlhFWlV0YkFOYkpI?=
 =?utf-8?B?M1FBditRK3JtV2tycWZTeWMvNFg5aVFGK05obEZaZytaclVkODBCVnhZdEZw?=
 =?utf-8?B?NmJZR2c0WGdzS29JMjltdVhncFlNV0MyTUpOVFdSbWEweVhDSHdZMkE3TU12?=
 =?utf-8?B?ZVJLdC9JY0lVdnJoVjBXTTVGWEJ4Z1RidmJkZFFZWjRIZ1ZhUkZDV29pMWVF?=
 =?utf-8?B?MkUwazI4bk83bytIM0lrNzRXNmtFOFk3QTVlVm51UlpFVXZrSnVFTkZVbWVN?=
 =?utf-8?B?akRzZjRyRHRiTU5uMVhyOE1ML2U1QjkzaUtOMktvQmFKbTk0K0FGVEhCd282?=
 =?utf-8?B?alAyUDU5Slo1VWhWNUZBdk9JdU1CWW04NytleFJ5L3Ntek9OanFPbXhESFZR?=
 =?utf-8?B?TE1SY09rQitlVnM5ZmpqcEdiNTFZOVlMZ1J0OHZlVG82TDRrRDd3SEJoNUxr?=
 =?utf-8?B?UzMrTFluTkI2Z3c1aGU5Z0pQNE5wSWxhWDhSemNqSGJ5NFF3NXZQMU9KQWpr?=
 =?utf-8?B?MEQzOUh4UG02RUpyZUlnb0hRb2pQckJmRko3TWJtVGNVbUo2K1g1aEdTS2xn?=
 =?utf-8?B?Vnc4VlU5dVd3SHlCZGliSHY1R0wyZTFrU0FYWVFNSkoyWHhYQVRtdTVXUkRa?=
 =?utf-8?B?SjZLMmpJanZXWUVvNGRDQVVJRlNwM3IvSHZuMGNEQmJQNDIzYVVBeWRJdklh?=
 =?utf-8?B?Vjg2WElmb2VBODd6NWV6dDNwMEs2Rk11SVZ1NkFqYmxzcXFQcW94ampXQVRN?=
 =?utf-8?B?Z0JOOE0vbUFPdkxCeUx4aDZ0Q1VjalFBRDFsTW5YSXhtU3dvQTRZY0cxQlFX?=
 =?utf-8?B?QWNvWmRudkNLdDVIZUJtYmhNdnIzaWMzUFVSeitrVGpNVFEzMTBqTUdnYkFu?=
 =?utf-8?B?MjBscnY0cTEyRlZaVVpkRmRlNk9VeUFJQjNYRmFVWlFhUEd0NU1CeXduT0VQ?=
 =?utf-8?B?WFZ0WWRNM0tVYTAvT0psQ2E0ZkgwS3o1SitDSHNtNVQwOXE3UC9jNkNaRGNJ?=
 =?utf-8?B?QVA5ZzVERnRBL29mVDZDbEJ0Q3ljWWphRi9oVUxyNmJDRDJmYkM3WXNxb0tL?=
 =?utf-8?B?QmRNWVVjdmNPd3ZGZXI3OGwzb1hoUkpPV1IxczI5bys1eCtmczUyOUNMZXZ1?=
 =?utf-8?B?WmFZWGMzTy9lQmFFb2wwWmtXN001TktSSm9iajRUVlpPNHdoWWZ3SWpieE8v?=
 =?utf-8?B?R1pETExmZzVtbTlFOUZwZHIwekp0bjA5aE1vWFJydHBSZUx6M21OSHc2MHc1?=
 =?utf-8?B?WEFRZFN2K1lZSnZLMFhqbWZKdFhKODcvTFovUmtzR0t6UWhualRvTWJvU1dv?=
 =?utf-8?B?YVQ5TnIxVStLUEhobk1mekNKbkF1YnYxYXdzYXRocTRlMmRSZWc0UWdYanJi?=
 =?utf-8?B?aHl6cERyY0toNXFOUHp1WkVlZkpBZlNSNGlocXA5UnVlTDdzSkpmbWhSVWVx?=
 =?utf-8?B?YkxScE03VCtUcGZLWEtHeDY0K3JwVFNTMTBaKzh3cHlzcFN5SWpqRUVSamJT?=
 =?utf-8?B?MUFZc0g5T3hZdzRMaG5OMFkxbGdBUnF0Y1FsOGU5QzhzOFFLUnc1c3Z5MndL?=
 =?utf-8?B?S0FsRWdkZUdpOVZJcVBkTUJXZ0ZSWDZ6enNZOE5MdlJCVXJFMkk4NFBLVzJU?=
 =?utf-8?B?ZmQ2MlM5K3o4bjJhQWR4V2xaNTBLMFRwYU9Dd0orcUhHMm9IUlBYaGsxZ1NY?=
 =?utf-8?B?cVdxeFNsUy9qN0FqTmkrV1dTYmJBVzZBckhsS0FkdlBPeDUrSy9JeU5pTXFJ?=
 =?utf-8?B?Z3ViajJWdE40TnB6dUdCeXFYSWVYVTVyQlJNNHdtSUV2QnRTN0xSdHdIRGVV?=
 =?utf-8?B?V2xoT05FR09NcEZSNEliUnhPOE1aWUkxcW00WGhTQlE5K29iMndDdkl4U21y?=
 =?utf-8?Q?Ko5I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80d839df-16f5-40c9-6a3f-08db4590e186
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 13:27:56.4209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vRJx/cnblJqxtWXBRzDULqoAfwsz5OmeJr3XiHmzscKhge4CqgKHtoSLSmYMYqssZ/c7sFtnVUJhsK+WqI81+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5956
Subject: [virtio-dev] RE: [virtio-comment] [PROPOSAL] Virtio Over Fabrics(TCP/RDMA)

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFR1ZXNk
YXksIEFwcmlsIDI1LCAyMDIzIDI6MzEgQU0NCg0KPiA+PiAyLCBUeXBpY2FsIHZpcnR1YWxpemF0
aW9uIGVudmlyb25tZW50LiBUaGUgd29ya2xvYWRzIHJ1biBpbiBhIGd1ZXN0LA0KPiA+PiBhbmQg
UUVNVSBoYW5kbGVzIHZpcnRpby1wY2kob3IgTU1JTyksIGFuZCBmb3J3YXJkcyByZXF1ZXN0cyB0
byB0YXJnZXQuDQo+ID4+IMKgwqDCoMKgwqDCoMKgwqAgKy0tLS0tLS0tLS0rwqDCoMKgICstLS0t
LS0tLS0tK8KgwqDCoMKgwqDCoCArLS0tLS0tLS0tLSsNCj4gPj4gwqDCoMKgwqDCoMKgwqDCoCB8
TWFwLVJlZHVjZXzCoMKgwqAgfMKgwqAgbmdpbnjCoCB8wqAgLi4uwqAgfCBwcm9jZXNzZXN8DQo+
ID4+IMKgwqDCoMKgwqDCoMKgwqAgKy0tLS0tLS0tLS0rwqDCoMKgICstLS0tLS0tLS0tK8KgwqDC
oMKgwqDCoCArLS0tLS0tLS0tLSsNCj4gPj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4+IEd1ZXN0wqDCoMKgwqDCoMKgwqAg
fMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfCBLZXJuZWzCoMKgICstLS0tLS0tKw0KPiA+PiArLS0tLS0tLSvCoMKgwqDCoMKg
wqDCoMKgwqAgKy0tLS0tLS0rDQo+ID4+IMKgwqDCoMKgwqDCoMKgwqDCoCB8IGV4dDTCoCB8wqDC
oMKgwqDCoMKgIHwgTEtDRsKgIHzCoMKgwqDCoMKgwqDCoMKgwqAgfCBIV1JORyB8DQo+ID4+IMKg
wqDCoMKgwqDCoMKgwqDCoCArLS0tLS0tLSvCoMKgwqDCoMKgwqAgKy0tLS0tLS0rwqDCoMKgwqDC
oMKgwqDCoMKgICstLS0tLS0tKw0KPiA+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCB8DQo+ID4+IMKgwqDCoMKgwqDCoMKgwqDCoCArLS0tLS0tLSvCoMKgwqDCoMKgwqAgKy0t
LS0tLS0rwqDCoMKgwqDCoMKgwqDCoMKgICstLS0tLS0tKw0KPiA+PiDCoMKgwqDCoMKgwqDCoMKg
wqAgfMKgIHZkeMKgIHzCoMKgwqDCoMKgwqAgfHZDcnlwdG98wqDCoMKgwqDCoMKgwqDCoMKgIHwg
dlJOR8KgIHwNCj4gPj4gwqDCoMKgwqDCoMKgwqDCoMKgICstLS0tLS0tK8KgwqDCoMKgwqDCoCAr
LS0tLS0tLSvCoMKgwqDCoMKgwqDCoMKgwqAgKy0tLS0tLS0rDQo+ID4+IMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgUENJDQo+ID4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfA0KPiA+PiBRRU1VwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKy0tLS0tLS0tLS0tLS0tKw0KPiA+PiDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfHZpcnRpbyBiYWNrZW5kfA0K
PiA+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKy0tLS0tLS0t
LS0tLS0tKw0KPiA+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHwNCj4gPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgKy0tLS0tLSsNCj4gPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfE5JQy9JQnwNCj4gPj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKy0tLS0tLSsNCj4gPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8ICst
LS0tLS0tLS0tLS0tKw0KPiA+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICstLS0tLS0tLS0tLS0tLS0tLS0tLS0+fHZpcnRpbyB0YXJn
ZXR8DQo+ID4+ICstLS0tLS0tLS0tLS0tKw0KPiA+Pg0KDQo+ID4gVXNlIGNhc2UgMSBhbmQgMiBj
YW4gYmUgYWNoaWV2ZWQgZGlyZWN0bHkgd2l0aG91dCBpbnZvbHZpbmcgYW55DQo+ID4gbWVkaWF0
aW9uIGxheWVyIG9yIGFueSBvdGhlciB0cmFuc2xhdGlvbiBsYXllciAoZm9yIGV4YW1wbGUgdmly
dGlvIHRvDQo+ID4gbmZzKS4NCj4gDQo+IA0KPiBOb3QgZm9yIGF0IGxlYXN0IHVzZSBjYXNlIDI/
IEl0IHNhaWQgaXQgaGFzIGEgdmlydGlvIGJhY2tlbmQgaW4gUWVtdS4gT3IgdGhlIG9ubHkNCj4g
cG9zc2libGUgd2F5IGlzIHRvIGhhdmUgdmlydGlvIG9mIGluIHRoZSBndWVzdC4NCj4NCkZyb250
IGVuZCBhbmQgYmFjayBlbmQgYm90aCBhcmUgdmlydGlvLiBTbyBUaGVyZSBpcyBzb21lIGxheWVy
IG9mIG1lZGlhdGlvbi90cmFuc2xhdGlvbiBmcm9tIFBDSSB0byBmYWJyaWMgY29tbWFuZHMuDQpC
dXQgbm90IGFzIHJhZGljYWwgYXMgdmlydGlvIGJsayB0byBuZnMgb3IgdmlydGlvIGJsayB0byBu
dm1lLg0KIA0KDQo=

