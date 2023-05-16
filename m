Return-Path: <virtio-dev-return-12726-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6786AC77B7F
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 19:35:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A21AFFD56A
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 19:35:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 95DB99865D1
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 19:35:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 899E2986549; Tue, 16 May 2023 19:35:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 702E8986579;
	Tue, 16 May 2023 19:35:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JC85zsSHI5Ap89OB6VP9KV7oYTV/u9KbdjhiAHDN1nHMdMW+ZniW9B6QYkPTlm1+kjlu8/umeuQXL98pHTzk2xIieIx/IIffmdVlQ0YM5aphPjb1K/1hb69ttOwJoMctDEsi5m4GKZO3DglKUehUpPuXifRinDdE+8YtlBkNNATWKOg5FJYPnXYrcdOCeYsGtNCqZxJUu0iBdfUAMvXGuysnlX4uKwmNpYTsjQJWQfTlbOMb1/aURwtugJm9jA71GkL6u4sr7u5+tv4QnfFksYYffYsjJ3DAsqMbLyvYhGPXHCi9q3W0w2CP0WNAyS6mpXsPiGDHTbvKEvcXPtqmPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzXGUw3OZDvuxE62ueOzSleviyIjJaG4vmTi+wYza34=;
 b=QzJULOxsIxn+rv56My1onrQnekXwKyzDUIscwZuwL6v1hcjAQMrkA0jBzLuyMOO5KxKxFpjrlQMZIVTSIcr5zdJLcMYUwVjJIvyPjQhH8ZMRoztZLSUOUSOexWYXAULh8OD4Yg2x1IucdUeHBOz4jccxMAvXBc9qTw4oK/8MiGs8FYDM2UHAioi0t62OyZYq5jzjBa5AueMl345L3ff1GF4in7KCxFE4SqaLQzdiErkb3W8aSYICRSg7caTUvLcboyLtyDna89aWO7PbmBd9BFMvtb8kg8oLlEtC4v9Lmg2GA2/uZKa9GEy+0vR6iZSD+YupxUVJVt1sChnNeBpf4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-comment] Re: [PATCH v2 0/2] transport-pci: Introduce
 legacy registers access using AQ
Thread-Index:
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9Mhl4AgAJOSwCAANQugIADYnEAgAAP1ICAAAu1gIABh4gAgABl1qCAB0C7gIABBZQQ
Date: Tue, 16 May 2023 19:35:20 +0000
Message-ID:
 <PH0PR12MB54815633F6C88A1EFFB24500DC799@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230506000135.628899-1-parav@nvidia.com>
 <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
 <CACGkMEvTs9oMewgrQpYZu1v1wdUXtxsvjqB6CPRf+y4C8EN_KQ@mail.gmail.com>
 <20230510033812-mutt-send-email-mst@kernel.org>
 <CACGkMEsp0i7EyyBBp06wJzrVBLNbH7MP_TT-j7b5c_yavgAmqw@mail.gmail.com>
 <PH0PR12MB5481BCA4D8F6546B3300DD29DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <83603339-e3fa-fe56-d447-813e73eb1961@redhat.com>
In-Reply-To: <83603339-e3fa-fe56-d447-813e73eb1961@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH0PR12MB7862:EE_
x-ms-office365-filtering-correlation-id: 982ebc9a-e578-40ce-748e-08db5644af36
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 mPDhW2yhTVWJekoeTXqsv0SYD58Dso1E0Vk/UAvmkNfk45K0wYruyt1hqVJHmP4brF03oRtZt2vLt7ln3Xsm+ucrNqnYwxf4EEemgMqO7lmxsTAdXrZP1CKA45X2tKLDWWmUYx9CfC3HxVyskuzXNxm3DMpTuOpdGXExQDgV+XnaDVxZb+0sFrZNxTfbhYnCqaKNzEFVIU39XWAggJpINGkv4bP0tcxGcHgvf5RWyZbwKobU/7QZegm11tCjrpvs+LoQr/1/x1eLDdLtT9GjK+XEJI7jUwJgr3RrAxFXRA8s5cqXXMoPt/2lK58/lWLzukzeeFOmDOt+/LPOuCt+mBkHkJB6ZlY/fDcS7i4uiGo9q9IgjOv1Klk6SUl4/+UmYXRuZzbtNvY3FX5tH29oENKOrbQaahBAnR01PqqBnH17HZwxoTwbytvhh2uNXjPNMiiIP1pqJY49CLPs/Xsc7r7N+7GJ8wcL6wbt1Rx8eFnEq4yt1h9ICr9GM/6blKJs/zZpAS7h/EH8vfosCz9H57+tkxUwigw0y36R11J8LdcOVPGCtUnhJZXtIdniVR2+IJJK4fZCdAcVF6LOim5Z95vkjnk7SgGp4839cbbyxNqf+CnDbLTCSbqR7lgIiZQt
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(346002)(396003)(451199021)(186003)(41300700001)(38100700002)(7696005)(71200400001)(107886003)(6506007)(9686003)(26005)(55016003)(478600001)(54906003)(110136005)(66556008)(4326008)(66476007)(64756008)(66446008)(76116006)(122000001)(66946007)(316002)(5660300002)(8936002)(8676002)(52536014)(86362001)(33656002)(2906002)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z1N5Wm8rRVpEMmZqRGlHODc4L1hIWjFaV1dWRGxkQ0FTdElKZXZPanIzREtt?=
 =?utf-8?B?M0I5bjNKUDJqaDRGdCtwSHgxTDlaVmh5ZWU4OEdLU0VDUThpMm4zV0kraWUz?=
 =?utf-8?B?bTF2UVhsY1Z4OXRNZ1lQVGpVWnpMUTBlQkRzUS9GTlJ4NFpnZWk2SWlQc3l6?=
 =?utf-8?B?UHVGbzRRcEJqczFIMU9Ka0h3T3JBNXFiU3ZoWTRlOXhYbkR0RjloUHJmZER1?=
 =?utf-8?B?ZVVhTUFuYWMzTzZPbm9uRm05Qk5wTlc4NlgvZ1NGR0x1UGp0aGxrK0pqVEhG?=
 =?utf-8?B?c2E5THdPVkYzSHFjd2tzcDJ3UURObDc5S01qNDFhSUpCNjg5bmhmNmRtamNL?=
 =?utf-8?B?TTRJRjA5RG9wcUU0VmwvdVNyOGw2dFRjZGpjNU5OdmV2MmF0U1I4eVNFL3Np?=
 =?utf-8?B?ZVNyWVFSSERzdGJaN0tMeTQzUWhpRzE5VlExdGo2OWZmQ041dDFLYzdMak9t?=
 =?utf-8?B?OTZJWjk5WHFUZ3FiR2RTNW51ejRJU1pqcmxmRVlvU2tPejZhaFB0TnZjSmlZ?=
 =?utf-8?B?aFpqNDVBSEtLRStXUkd3SGQrTEI5T2NwWDI0cE9jdWJYNk1KNjNkSlJmUlVN?=
 =?utf-8?B?L2hRUFh3NVpyYkJmSzNodTYzbFIvUUVrK1J0Y2tNbWJqN2x6UmJPMnZ3a0NM?=
 =?utf-8?B?d2d4T0wzOEpEYW9qb08vaUhZR3ZrdFV6ajRKdjF3aEVxUUhock5CNEJEVncx?=
 =?utf-8?B?M1VtVjRpS1hqd2kvVDBQdzcrTEppaDQwZ3ZHK0hHd3JqdWNESWIzMVlNR2Jm?=
 =?utf-8?B?S21PUXh1ZFFMbEtaOHEveWVEQ1FzUVRpV3IwV3JOaTRYcFlQZHlaeG1QZTBo?=
 =?utf-8?B?OFVXbGJxQXpLbDhpd2l4V29oRnBtVTNEYW5tckZsa2gxUVp5ODRJeDFYQkx3?=
 =?utf-8?B?MkZuOHpwRGx4QnkyZ2ZKZ2FwWUhveVA3UkhteUtsUkYrWlllZHpmaklPd0xY?=
 =?utf-8?B?dmFUZDQzdVh3RmRkSWhmRmJjTUQ4bjZ3RTFNR0RVUWxMWHAvbUNOYlA0dnZx?=
 =?utf-8?B?T2VqOGk3cEdpUXZlRUlWaG1tMUtzZjBENmZqTk8wUjV2STd4aWQ4ZGJSMG9J?=
 =?utf-8?B?VDRVZldIU3Y4K2hmbWFhNVo5VU9MWXNlTzhpYlZjeVRSb2xSandNL1hYUkpm?=
 =?utf-8?B?dXczcVI0MEpLcVBOYzE2dCtxV2tLUUhPb0dxcVJCaWRwdGYyYldWSTBrczk0?=
 =?utf-8?B?UEN0bGFRSnN3TWN5b3g0dzBmamR1MlFta3JadkoxTnpNLzJTSkRtYUxLRnVz?=
 =?utf-8?B?SDVaL1BFenBCRDJmcU50NHgyK3ltUmQyN0tPV3RPdzNHK2NGSk5nQUw2cnpt?=
 =?utf-8?B?R2psUS83WUk1bnJBNE5NUGRuQnkxN3NEbWZoTGZYSDl0K2tLaEQ4WTFNYzFI?=
 =?utf-8?B?QUJyNXd5bDBNdkduS0JkbmJBT2tQdEdOZ05kTEhRbklyZGwxblVrN3R6cE0v?=
 =?utf-8?B?WTh6RXJ1VDRnSnlUK3B3YVZxZVBZVmxiMDhCRlVUcjZtd0dSc2Uwbi9meEV4?=
 =?utf-8?B?bW91cWlERk1nYkNiSGxqRUFHQ2RjZDYyUG5BU1FLOTdnZExzd3dhNkRnVUxh?=
 =?utf-8?B?b01USDVoV0RBR3ZHT0ozNkRQbk00dUVnWnFuVXlqMHJFNExGdjA5amJrZjRC?=
 =?utf-8?B?TlhtdlZNakQ1L1YvVlJzajNta1ZxOVhQOHNQaGczRExRZXFnem5JSkRWQ2pE?=
 =?utf-8?B?d3Z6OGVjWXVKcUNCeXFwRUhRbWVleExhZzR3SVh5VlFtTWk3cWhpVWwwRWJO?=
 =?utf-8?B?NEt0bEdvVjduQXQ2eEk3ZjRJOG9vRXFHZUVUTFRzNk5qaUVLQ2hQN1Z6MjlF?=
 =?utf-8?B?K1lTZEk5TUhpVXA0cFIyejVCQkhqMVRvVjl2Q2pJVzlBVFhvRFhmRlRxNjFQ?=
 =?utf-8?B?UXA0b0ZuWURNZ2YwVHY3V0VtTW5WZVJBdUtHbXRTcVB6RWNCa1ZpMzZuRFZC?=
 =?utf-8?B?cWVDSDR4Mmxnd1VHK2p2eHFSRDJsSm5GcFNBSEVUaHdXajVXQ2FhZm1Ya1Z5?=
 =?utf-8?B?aTJtQlZoWnNVNG90UVNvSkRjSGFUS3JvcjA3d0ljRjBGV3gzSzVPRTJEa2JG?=
 =?utf-8?B?TkVBaVcxMVB0dnVuTnRYekJaY0tyMEV5N3lOTDZCczRrTTRESUF3eXRxdzdl?=
 =?utf-8?Q?oFqU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 982ebc9a-e578-40ce-748e-08db5644af36
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 19:35:20.0215
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1R26rquVu//krKRywBkeRgMyG20MM9/gtWFq3YpIYMNneQROKaRm/GWG8ABtIY6BukYPtzFUj4QS8NrzhHQHNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7862
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH v2 0/2] transport-pci: Introduce
 legacy registers access using AQ

DQo+IEZyb206IHZpcnRpby1jb21tZW50QGxpc3RzLm9hc2lzLW9wZW4ub3JnIDx2aXJ0aW8tY29t
bWVudEBsaXN0cy5vYXNpcy0NCj4gb3Blbi5vcmc+IE9uIEJlaGFsZiBPZiBKYXNvbiBXYW5nDQo+
IFNlbnQ6IE1vbmRheSwgTWF5IDE1LCAyMDIzIDExOjU1IFBNDQo+ID4gSSBkb27igJl0IHNlZSBo
b3cgdGhpcyBpcyBiZWluZyBhbnkgZGlmZmVyZW50IHRoYW4gcmVnaXN0ZXItb2Zmc2V0IGludGVy
ZmFjZS4NCg0KPiA+IEl0IGJpc2VjdHMgbW9yZSB0aGluZ3MgYXQgaHlwZXJ2aXNvciBsZXZlbCB0
aGF0IG1ha2VzIHRoaW5ncyBoYXJkIHRvIGFkZCAjMTJ0aA0KPiBlbnRyeS4NCj4gPg0KPiA+PiAx
KSBkZXZpY2UgZmVhdHVyZXMNCj4gPj4gMikgZHJpdmVyIGZlYXR1cmVzDQo+ID4+IDMpIHF1ZXVl
IGFkZHJlc3MNCj4gPj4gNCkgcXVldWUgc2l6ZQ0KPiA+PiA1KSBxdWV1ZSBzZWxlY3QNCj4gPj4g
NikgcXVldWUgbm90aWZ5DQo+ID4+IDcpIGRldmljZSBzdGF0dXMNCj4gPj4gOCkgSVNSIHN0YXR1
cw0KPiA+PiA5KSBjb25maWcgbXNpeA0KPiA+PiAxMCkgcXVldWUgbXNpeA0KPiA+PiAxMSkgZGV2
aWNlIGNvbmZpZ3VyYXRpb24gc3BhY2UNCj4gPj4NCj4gPj4gSXQgZm9jdXNlcyBvbiB0aGUgZmFj
aWxpdGllcyBpbnN0ZWFkIG9mIHRyYW5zcG9ydCBzcGVjaWZpYyBkZXRhaWxzIGxpa2UgcmVnaXN0
ZXJzDQo+ICh3ZQ0KPiA+PiBkb24ndCBldmVuIG5lZWQgbGVnYWN5IHJlZ2lzdGVycyBpbiB0aGlz
IGNhc2UpLCBJIGdpdmVzIG1vcmUgZGV0ZXJtaW5pc3RpYw0KPiA+PiBiZWhhdmlvciBzbyB3ZSBk
b24ndCBuZWVkIHRvIGNhcmUgYWJvdXQgdGhlIGNyb3NzIHJlZ2lzdGVycyByZWFkL3dyaXRlLg0K
PiA+Pg0KPiA+IDEueCBoYXMgdGhlc2UgcmVnaXN0ZXJzIGF0IHJhdyBsZXZlbCBhbmQgdGhhdCBz
ZWVtcyBmaW5lLg0KPiANCj4gDQo+IE5vdGUgdGhhdCAxLnggaGFzIG1vcmUsIHRoZSBhYm92ZSBp
cyBkdW1wZWQgZnJvbSB0aGUgc2VjdGlvbiBvZiAiTGVnYWN5DQo+IEludGVyZmFjZXM6IEEgTm90
ZSBvbiBQQ0kgRGV2aWNlIExheW91dCIuDQoNClllYWguDQpDdXJyZW50IHR3byBjb21tYW5kcyBw
cm9wb3NhbCBoYXMgb25lIGJveCB0byB0cmFuc3BvcnQgbGVnYWN5IHJlZ2lzdGVycyB0aGF0IGZv
bGxvd3MgdGhlIGxlZ2FjeSBzZW1hbnRpY3MuDQpBYm92ZSBjb21tYW5kcyBpbiBmdXR1cmUgd2l0
aCBsZWdhY3kgY29tbWFuZHMgb2YgdGhpcyB3b3JrIHdpbGwgYmUgYWJsZSB0byB3b3JrIHRvZ2V0
aGVyIGluIGZ1dHVyZSBhbnl3YXkuDQo=

