Return-Path: <virtio-dev-return-12319-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F86CC77B73
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 19:02:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8504E419BF
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 19:02:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7C82E986619
	for <virtio-dev@archiver.kernel.org>; Wed, 19 Apr 2023 19:02:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6C9E9986432; Wed, 19 Apr 2023 19:02:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 59C40986434;
	Wed, 19 Apr 2023 19:02:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SOoUNeu+dXTmjxwHDCoWO4389LuXhfpCq9J24qJGP2IFH4r7ZSJRJVpqlwGQjvLLfepI+mXZRYlikdLYODsBy3r2Vmlqh0fVklLf7kCOslv71EjApfgqZZqkQU00GD+8I26edHJMoqYsWm9YRvcxh043TiAMKpky4wrj7IPaAbjiz24JCNNqx6Sl6DK6q9ekwKxLm/Pc7sO2sfXrARNaSBFl9DTaurT9UY/cxpZH3vpsl1iDlfMF+pRmnQhTSnzUmG/mkyxk2L5eDogS9dTBIdZBsaqKrTEJn05EkJWvHclIxbwwrzmB9uXbF0NTsENq8/KdfGCQJdAMyL/Z5TzGBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yI10D6qyqBoU6P4IP/50Xg6m2ChifHdV53OXBpVDAM4=;
 b=JnbybpJIl8XKOP2wq0JGUHX3DvdSwsleKEsytYIw7YTFFuvmTsdew8a0EhxVeVI4rf861ad53k4Nkd3b7BIDBqnktjENTorTWuwPmtjlMJe39ao87BiQgxoFYZ8VYrEd6HOhuj92brKfa32BXXtNL5CbJy4khDilnhSPqBcb65ziTF6hwJcLzOvmbI7JS1AL2OU+yLG3v1ZthzuGU3JsN5vOex7N4PvnmyNBwMAAjCxKlrxZwKC3T0S55ifh6makwgsIyFK8+Mm7cb8JWwyXIBw2unxm2Wl0NQFVlNz3I33a0BbpbOg5HUf/1YCcjAEZ1uiQ8ry66vOfGMYZAkqjEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, "Zhu, Lingshan"
	<lingshan.zhu@intel.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Thread-Topic: [virtio-dev] Re: [PATCH 1/2] transport-pci: Improve config msix
 vector description
Thread-Index: AQHZbK3NHGJOICf/802HmruA7j0Qca8yQS2AgAAWZICAADLRAIAAfWNA
Date: Wed, 19 Apr 2023 19:02:18 +0000
Message-ID:
 <PH0PR12MB548171533C1FE1A4A21FCA42DC629@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230411194220.752355-1-parav@nvidia.com>
 <20230411194220.752355-2-parav@nvidia.com>
 <20230419030057-mutt-send-email-mst@kernel.org>
 <588b201f-8da7-dc6e-d66e-1489914ef051@intel.com>
 <20230419072522-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230419072522-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA1PR12MB8599:EE_
x-ms-office365-filtering-correlation-id: e41f86b6-9ef6-402f-cc5a-08db410898eb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EmfRttMF4MTeFH+wN6a+4/nNBZhxkRjV3ZkMgnA6PiSlVvSKL3aX8ICgVUI+7AierIIa3wCwCr3wS2EgY7YYBQaDqjlmWq5JrpjNVBmByKRF5+YMr6IX6eyKwRGgl66bYxxqsR2RzWIsAYhU4iepW/baQVJGNKJ6q0DLIJuWKV3hOI/w22MjiNOuy61aF76BRlsEhl+k/7zRQlVIi0w/jo/8soaqupsMhFHwODEK2+YzydKm+eeRiBlWDEqHJo0K8LBjAOxDA3/5Mo546wkve+0G+8KxmO4Ldi+WvtsvJo4Izsx0BEG16dTbVPgs38KVNSwiQ+3X0ZRJAyKSFiFMa4RWxyDmya/TysL/gFk7k6v2YjaXBmYA7XNbu26pKK7hNtt9B9Fv+rKzk5bRxtQeFrm3gqb4xj8V6qI0yWTHV3aLgFdYlRoqMl1qrnyzSNtZytqxKq1FrOaDKJrg+O2VcLLefcjJUx+GsHWbnR4y1F3UUa4bjT8cMm9wlsHIU5w6KzbgudZ4IJzm/htC5N8ibuwL1kt5K9raZbb2DfNuNcM5m50gIkRL3TBNeCapdfkttMsUc8ZH7bOgmUsmt8xL5mTQ7wSmLo8g+taAQ8atZeJGEcuikPfS6lPo1McoX/L6
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199021)(4326008)(66946007)(54906003)(316002)(110136005)(66476007)(66556008)(64756008)(66446008)(478600001)(76116006)(71200400001)(26005)(107886003)(2906002)(7696005)(5660300002)(8936002)(41300700001)(8676002)(38100700002)(122000001)(33656002)(4744005)(38070700005)(86362001)(9686003)(55016003)(83380400001)(186003)(6506007)(52536014)(66899021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TVc3WkxrWmVqM2NYb1oybWZnSUZxbmdab2J6KzNZY2poNGEwekxVWk9LeWNq?=
 =?utf-8?B?TGt2ekUweFVwSUNUemU2enIxd1I2Rjk1bnRoQ2N6dHNlMCtxbTIrbGdlS2l5?=
 =?utf-8?B?VFNMK3NrOU1Cd0NwdXYydDhDcVUwZ1pEUDBIakJoeVpZM3VNeDUwLzNyNENN?=
 =?utf-8?B?LzBORjJuZ3lQWHc5cjBHSit0d252bG9LS1A0Z29RV0VXMFdsZWRuVnpRYk1X?=
 =?utf-8?B?MkxCV2NYd1hrVDVpUTg0OG56R1BJUllZSjdrWk1OckZsWlQ1VGoxQjhOMTBv?=
 =?utf-8?B?UytFUWhoRGJrT1VkOWFuSWwyaGJVYi9xNkVXRWc2eCticWZza2l4YStmdzZw?=
 =?utf-8?B?WHBxdWNNVjVQTG5nWDlpdUVsNVhwckhWTm84ZVlnblNKTStXeEVjMERnQTho?=
 =?utf-8?B?UTJyRFU4VXR4bzQ4a29RL0t1M1ZKVE9hOHhsZjZKVjlIeXUweE9TTGR2RGVJ?=
 =?utf-8?B?enlRSENUUzJ5VnJIQ25EL0FJZDU0UVY4RzBOZDVsMzRjOGovMDVmaERTVlBu?=
 =?utf-8?B?N3c2MzVQUG9oZUFMOVI5ZlZiRG1UTG8ycnp0a1NYZEF2bFZVbG9nYUxLTVIy?=
 =?utf-8?B?ZkFNaWFDMVA1UjRiL25Ia1BrTEx3cXFLdFZpY3ZhdXpiTUROMVB0VWt3SWpp?=
 =?utf-8?B?WlRiV2wyL3R1U0NlZjJsV2lMYlNrQjJ2N0JLQnVoOTBZVHVmVmRzNlRmaGRn?=
 =?utf-8?B?ODZqR3ZFMjdnWnBSYStycWZybGdIU0Frdm5nWHZuemlkVzlvaVRxb0pzbTJt?=
 =?utf-8?B?RHZQRGtKSVU1RGF2Y0hqZ2ZKRkJsblJMcitscWZXZDUrQXhqUHBDL2pWUzFR?=
 =?utf-8?B?L3YxZ2lYTnlhR0sxeVpOWWZCRDY4L0ZMVzNoUllOclZDd3BPWW9SNnA3WnhD?=
 =?utf-8?B?dDNoMm5NMnBYTmhzY3pUYVBiVDEyTktLYUhYNjdWVEg2aGNQOUN3RElWNyt4?=
 =?utf-8?B?T2U1dE0wTVpjaTVjQnpxZjhWMHB6Slp0d1ZKbXdFQU10NTkwUmJGVy9rOXNU?=
 =?utf-8?B?UDFCYU9pck53ZGdUejNWVk9LUEdzZ1NMS3IycGJEcDMrOVNtNlFrbjBUVE8y?=
 =?utf-8?B?bXRLQXZ0Tnh5Z0Q3bGE0Mk9SNy9lc2wzVlZRNUNjYjNMUkdSbGhjV0FzNTda?=
 =?utf-8?B?WUYvUktodkxxWkgzS01OZWh4K0VaY3BoUXhISVhNN1crdmN1SmxrSVVvRHpK?=
 =?utf-8?B?M2JvTng2ZWgwUlR4SWdlVFJPRWMwVUVPSXNTMzRZaWlCMlN1NEpSdUFrSEFq?=
 =?utf-8?B?YllJVFFBbVVLL2ZEeUNEVHBCajgrZ014NzNsblRQY2JzT2YvRGJMYllwMHV5?=
 =?utf-8?B?a0x6cWZ1Z2Ntbk1telQyZHI3elNhdHB0RFpyN0ErYTBnaGNIdU0ydjU5L3ZB?=
 =?utf-8?B?NVNNK2dVdDJZbm81bGMweEhRMzFUY242U1VMbkZ2b3Jia0tLZGI2V2ZmNThl?=
 =?utf-8?B?MW1GR1g3ZjNNRmJjcmNyNXZBRHpFcXVOd3IyMXYzWHdpWkpTOFN6aFRVV1lo?=
 =?utf-8?B?dGtZT1NsYnVwSjNvSFlqRS9tOHBlcWpEYTgxUElRZkdCNkRybzZWTC9IMjVU?=
 =?utf-8?B?dHFZS2MweXBkLzMrSVhSRWJ2b3lkQUJiaXZTZ0s1UkxnMlY5ZWMwWFlSOVN2?=
 =?utf-8?B?Y1dzU2V1SzBHaXpLYlFtVEN0R1E5SzVpYWVlSDBCdDV3ZVA3VFJnVDhlTUlh?=
 =?utf-8?B?NXM1dUZpNkxGV1ZZVmhvUUxob2FIRm9zUWthWEZuTWVWb1dYQkdjNXdGQStX?=
 =?utf-8?B?cE1TV290dE9iRUtMTUJBOWREWUdpWC8wdkg2RTBBcFFHRjM5RDlXTG9RVERt?=
 =?utf-8?B?K1JscGhubS9wMXVvMDVKSG5mUFcrWlF6UC8rRkFwTmpGcW9lUjVFSWxaNWVZ?=
 =?utf-8?B?MlFRWFlXSDllY0dyb2xXQWsrKy9rd1JJN0xZTzB6eER1ai83c0Voakw0RmEy?=
 =?utf-8?B?VURyQXFTTzdkNlIzOWNTUjkvQ0lpRE95RmVMaFU4Q3ZZeFlLRTNxNlNLQms1?=
 =?utf-8?B?TEpVc0JnM2JleHRpZWR0SU9rRVVyS2w5QnhEMHp4SXVtM1ZjcnZDM1V0OGxM?=
 =?utf-8?B?YmhvQUlBVE5pYTM1RnpzM2ZKbEJ2OGx0VVhFSXJ1dTVVZWpJMkE0QTM2MG1N?=
 =?utf-8?Q?lOWw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e41f86b6-9ef6-402f-cc5a-08db410898eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2023 19:02:18.3772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fjPmqcOD+PYtZ/NBx5ijNYxEMu2mnXUHWkQObr01LwuwUsnQ8F9QF17rOBsupR+t+XW916iVx5Rsqc4ZuG8ZEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8599
Subject: RE: [virtio-dev] Re: [PATCH 1/2] transport-pci: Improve config msix
 vector description

DQoNCj4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gU2VudDog
V2VkbmVzZGF5LCBBcHJpbCAxOSwgMjAyMyA3OjI3IEFNDQo+IA0KPiBPbiBXZWQsIEFwciAxOSwg
MjAyMyBhdCAwNDoyNToxM1BNICswODAwLCBaaHUsIExpbmdzaGFuIHdyb3RlOg0KDQo+ID4gPiA+
ICsgICAgICAgIFRoZSBkcml2ZXIgd3JpdGVzIGFuIE1TSS1YIHZlY3RvciBudW1iZXIgaGVyZSBm
b3IgQ29uZmlndXJhdGlvbg0KPiBjaGFuZ2UNCj4gPiA+ID4gKyAgICAgICAgaW50ZXJydXB0cy4N
Cj4gPiA+IEhtbSBJIHRoaW5rIGl0J3MgInRoZSB2ZWN0b3IiLCBub3QgYW4uIEFuZCB0aGUgb3Jk
ZXIgb2Ygd29yZHMgaXMNCj4gPiA+IHVudXN1YWwuIFdlIGFsc28gZG9uJ3Qgbm9ybWFsbHkgdXNl
ICJ3cml0ZXMgaGVyZSIuIFdvdWxkDQo+ID4gPg0KPiA+ID4gCVVzZWQgYnkgdGhlIGRyaXZlciB0
byBzZXQgdGhlIE1TSS1YIHZlY3RvciBudW1iZXIgZm9yIENvbmZpZ3VyYXRpb24NCj4gY2hhbmdl
IGludGVycnVwdHMuDQo+ID4gPg0KDQpUbyBrZWVwIHRoZSB0ZXh0IGNvbnNpc3RlbnQgd2l0aCBy
ZXN0IG9mIHRoZSBmaWVsZHMgYW5kIHRvIGFkZHJlc3MgYmVsb3cgY29tbWVudCBhYm91dCBNU0kt
WCB0YWJsZSBlbnRyeSByZWZlcmVuY2UsDQoNCkFzOg0KVGhlIGRyaXZlciB3cml0ZXMgdGhlIE1T
SS1YIHRhYmxlIGVudHJ5IGluZGV4IGluIHRoaXMgZmllbGQgZm9yIENvbmZpZ3VyYXRpb24gY2hh
bmdlIG5vdGlmaWNhdGlvbiBpbnRlcnJ1cHRzLg0KDQpTaW1pbGFyIHRvLA0KVGhlIGRyaXZlciB3
cml0ZXMgdGhpcyB0byBhY2NlcHQgZmVhdHVyZSBiaXRzIG9mZmVyZWQgYnkgLi4uDQo=

