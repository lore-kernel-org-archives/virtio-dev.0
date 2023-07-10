Return-Path: <virtio-dev-return-13335-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0360EB64DA
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Jul 2023 16:57:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 05C2B68481
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Jul 2023 16:57:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F3DAE986661
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Jul 2023 16:57:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E853C986491; Mon, 10 Jul 2023 16:57:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D28B598648C;
	Mon, 10 Jul 2023 16:57:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZI5IR9aIjBcnWN8HYSQDbYBoKdKqrl1E+OMcJUevFyQUGxGPmC1NWEDPN16AxudO/elOXgsKpzAf84oxUUA3Qo0Sg5AXTRcb+TSZ7SZtosEw63POsdFQcaqNAO0x1zZi6eq6hTL/3AHjIyAinHrKvUVLxJnGbP46d+v2a22iymWXq/Zfz6Ak46KSmyAqaVGt+lCU9TWSGDXOvJOZsy1g/DVLS8Lv/gvSPq9lk4531ZSLNWodhPDUSgMyjdZxJ0yo3A/5NejAU0nOejWsy8bq8Znk7m+HyNGv6MnKGE733wcuWxlfpnW/696+WUfkDfFiKq5do7/Syvo3JlPjk3uTqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNI7i75i69lOuc6MscGA/aXq0kOkwo2wg62wIqW0ePc=;
 b=Rd1kbRjBufPWQdPxREiLhVSAHyBwFFaU173wCz4/2sb/0lei2r3qkP0/Lds6D3EbcyvYr7VuX9we1RV3laGHcp8fbZDIG4SZQQiV5ABqdtLSXgEVdNH9k78OOSy7+d4AXoJ1U4mxwWLIfmW9C/FYB5/OvLR950TLb67+65ZsY5ecfokiECPBKABVhjHO0BCETGF70R9st+TsYB37TBuBfYEMGA7bsOpomjb5ZdEU0uRmC/RY1bOyrgyh60a5OQ2PYtaCuEdobx5SkO6xOsdZzsxd43hR4eFY+mvPj83tyr4IuLvsG1y2YRDNBhqVFUkOx4/NAc4xzcaOWfkVHnsHWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>, Yishai Hadas
	<yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [PATCH v14] admin: Add group member legacy register access
 commands
Thread-Index: AQHZs0ohnEJs6eqnNU6dA2mzKWRRUK+zMnQAgAAFSRA=
Date: Mon, 10 Jul 2023 16:57:31 +0000
Message-ID:
 <PH0PR12MB5481BEDB1A1DC7C5E04F48A0DC30A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230710161752.204248-1-parav@nvidia.com>
 <20230710122502-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230710122502-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB7937:EE_
x-ms-office365-filtering-correlation-id: af92d29e-9dd6-47fc-4272-08db8166c016
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6DUBuKlWZElQcGBm5omE3RoFGIOBFY+XIS1D8hSUd2Nqbq7Y74UFOWTFNloLDZDokCeEjh/p5u3A8fQ+gLrVUPKFzbdliJG+sjCs4ClvnxSeUgJveRORebDrhcoaia3r4twHkrSAvu/30YpKuuKqdH0pzctwJiL5G9yj/4YH2+/nu9YjS7E891q8prCCK6yoCj1xjpgsSyNF921b8nqlvgNhgY8UPidLv9rPINfldv5sX3Coo0Oy4asq4EVPtUHHTRE1j4E7D1FNGO9n8psjI9h+PrCtr5lHj4cLCtki4VkLX50fDgJFKm5ciKQS88HhP3xx0kN/wxHGOGQB5+if0Z70QjdSpkJM13m3G9/h9Yxe/4d7siGhWpXo1ushkNMuSAaAbSfyzYtbzTPxAN0keZMfRvSYKmA7ZwbbtXMURdSUNeU2acuXwxMjNct5yzma84zNtp/JKFKL7B9RkD27Sl/6DMk6GNWjncTJ84BxVtU2H0AEq6ffvUfbostQ6qeEFRUEFbsDOv1MZUKagFqMq+zObnWXjMjoPS7LXGDx3I/1mea0TzoY9z4n5jYQMMG/4rmL3B57G9Hu5tUfKwiJ18XGfkzaccP7fYwiyN5Sa1Yb+mBF6sBpwIe3uCK9jODE
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(451199021)(86362001)(38100700002)(38070700005)(33656002)(71200400001)(55016003)(7696005)(54906003)(76116006)(122000001)(107886003)(6506007)(26005)(186003)(9686003)(5660300002)(52536014)(2906002)(66556008)(316002)(478600001)(66946007)(8936002)(66476007)(8676002)(83380400001)(4326008)(6916009)(64756008)(66446008)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?azRhZVpJT2ZuNFFFVllvSnh0NTBjTld3VVFIaFhjbmJSTitNOWpTdEQ2Wk5L?=
 =?utf-8?B?S05ldGxqTEZXeWJFd0lBckgxYTZ4MXVILzlEakVKaktiekU1VkZRK2QxWmFC?=
 =?utf-8?B?SzR1aXJuOFRDRHdmVXdaTDZGYVF3cE1WOHJhNGNhb3lwWlh2U0hqVFNmSnE4?=
 =?utf-8?B?UEJwYzl3aTVtcW0wclB2ZmRDZHUvYkd0Ti9sZngwc1dnNzhTSXpnVTczZCtM?=
 =?utf-8?B?Vkg0a09na2Z3MTgwSkp0cTVlMGFNK1dxMzlOZlBVOUpFbUJoN1hHbmZVOUNa?=
 =?utf-8?B?anNWcGg4Q2p0emhjREVEVkQ0QVYyK2pyV3pFS1pWSUMvZUx5ZGJ4S0pjcUw3?=
 =?utf-8?B?RTJmdkgvQjVOemFmdjQ5cWpZKy9OSUk3cTRFWHRtaytFNEdjOXVhcnR6Rmky?=
 =?utf-8?B?c2I2MjJNd0NxakZydXlKdDY3eG9FVEpHTER2YStjbno5VGovYjNDckxoY0sz?=
 =?utf-8?B?a2tVVFhzSHYranF2Y1RUOXI2MVNvVkVBR01ocUV5WGtRVXNZUXNPRk1GQUFz?=
 =?utf-8?B?SDJINUxNc0VoQmRGR1lQZVljMlNaRTlHaEswWTNCeW0zNnNmZ0E5bkJwZmpC?=
 =?utf-8?B?RXhPellOdjk0alRtWktmeHZXT0RVWC9GR2M3Y29mZGZBTFBuWWRuWWN3SW0x?=
 =?utf-8?B?YW9wYXd1R1JkUjRhZy9EZklDT004ZGVsRzBBcjdXZzJhd3ZIUWo3VUxIRWxV?=
 =?utf-8?B?c1o3N2JaZUZaeFZsQlUvbEllRlZlMkREa05LL2RHQkRxSVRwNlc5RktobGxB?=
 =?utf-8?B?RzdsWHB0WEJTb0k5NGc0cGZKRFZFemtoMXdHNXN1bVVPK3JCT0tZc2FLSXlN?=
 =?utf-8?B?bHQ0aFZZcVNoZjB5dE5oUU53VEZ4TFpHZFA4WGR0Rk1jTlBDNlRHS0NIWEJh?=
 =?utf-8?B?ZjY1OFNZZzMyZ2VHbDllWTlsMVFOSWNITmN2bXpYdHRsNHpYblFMQzQ1UU9m?=
 =?utf-8?B?Ti9LV2hKUkEzR0lzdmZSd0s5eWZFM0tmSTNYc25nU0R3STk2WVRQVlVOenJU?=
 =?utf-8?B?bjl2K3RwdGcwVkdQellkQTJEdlZmc2JSNUd3QmlrR1VueG00QXZxQ2ptYTVs?=
 =?utf-8?B?Tk16Mm1PTitHS2dNakxWMmNJeFJRamhRUit6QXNzZlBTc1dLNVk3ZTlicTRN?=
 =?utf-8?B?OURKQys4SnNObXRiOWluY2FhYUttZ2RMSzBlR1J3MWRGc0g4d2FrU0p3UFhM?=
 =?utf-8?B?TTMyYkFmVjdyelFGbHRnVHVlRHp3NDFIZ0ZaMDRzQk5CNFIzK2RaSXVueTZP?=
 =?utf-8?B?MkZRbGNGenk2MjVmZDVmM05ZbFZ6TFprdCtsMjhKTnowZjBrenJ6MzE2amt6?=
 =?utf-8?B?S0ZEanJVLytPckRTUTVKQmxrd29lT3RZR1dHbU5ySVIvdlJjSTFWSk15dW5y?=
 =?utf-8?B?REJOdzRWeC9KMUEyNmM3UUhCc2lqaHVoMVpWQWVNOXZxeWtBN1p3SFRaYUEw?=
 =?utf-8?B?RUVwc2NLamNsa2ZFS2ZQNTN1QURkcUVlNUtuS2FKWnBMalZQTm1iVGVqdkdZ?=
 =?utf-8?B?a1RscDJibDljK0F2b0M0SXo0NFpvdEhQcWdJMWVMS2dKdi8wWExwZlpsY2FD?=
 =?utf-8?B?c0tzRXF2eEJ1U1Zhcm9VK2pPVXplZUZSMmJ6Y1V4cGlQT2xRTGRKRWZGaXJ1?=
 =?utf-8?B?cEJwZkJqTTNJMTREN3NDUU4xRmE1Z0Y4K3BjMzYvRzFvVEhCZGx0MVZ4QVJj?=
 =?utf-8?B?OTdKSy9Lei9NZHlSSEpSdENnRFJLMy8vbUdlaWkyM0pTMk9ESjJTbkRkWElJ?=
 =?utf-8?B?WjJrZ1NtNEVkWXV2OHlkc0ZzdGpYS3pwMEZmNXlXKzFzZHlNbnJlVXk1Ui9a?=
 =?utf-8?B?NkxrOVd2c3gyMHNLSlV6L3hTb1Rqa2lFS1V2Q1Y3L3FMVkNUbDZhTWZCT2Ex?=
 =?utf-8?B?MmRKc1haTjBjYktSZ2VCTnpqdFJVOWVJUkNUdS8xSUJlQzZzempKbkJjVU9o?=
 =?utf-8?B?RmRsSjluWHA3bW5BeGlyQ0lZbjdvdzRNL1p2bFpwVFZKdk5JWlN5UTlFbHZH?=
 =?utf-8?B?RmNDem1QU3JBeTg2Zy9HK3R2UmlpRi9oUlBDTlhVa2VLU3pLTlczT2kxQ3FU?=
 =?utf-8?B?dTgwMXhidXV2NWsyM0hMSkl6NTBrejYyNEw4L2gvbmtXL3NLeTlmM1lMd2VC?=
 =?utf-8?Q?h4hg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af92d29e-9dd6-47fc-4272-08db8166c016
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 16:57:31.2017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k41+kyCYEG2XKOxWv2XSXfEGeUqv4GvBWGe6op+TSHfTU6+3GVieNsqaIfqyzee601AtJeSYgJhBkf3Ex4hL2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7937
Subject: [virtio-dev] RE: [PATCH v14] admin: Add group member legacy register access
 commands

DQoNCj4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gU2VudDog
TW9uZGF5LCBKdWx5IDEwLCAyMDIzIDEyOjM1IFBNDQoNClsuLl0NCg0KPiA+ICtUaGUgXGZpZWxk
e2ZsYWdzfSB2YWx1ZSBvZiAweDEgaW5kaWNhdGVzIHRoYXQgdGhlIG5vdGlmaWNhdGlvbg0KPiA+
ICthZGRyZXNzIGlzIG9mIHRoZSBvd25lciBkZXZpY2UsIHZhbHVlIG9mIDB4MiBpbmRpY2F0ZXMg
dGhhdCB0aGUNCj4gPiArbm90aWZpY2F0aW9uIGFkZHJlc3MgaXMgb2YgdGhlIG1lbWJlciBkZXZp
Y2UsIHRoZSB2YWx1ZSBvZiAwDQo+ID4gK2luZGljYXRlcyB0aGF0IGFsbCB0aGUgZW50cmllcyBz
dGFydGluZyBmcm9tDQo+IA0KPiAsIHRoZSAtPiBhbmQgdmFsdWUgb2YgMHgwDQo+IA0KPiANCj4g
PiArdGhhdCBlbnRyeSBhcmUgaW52YWxpZCBlbnRyaWVzIGluIFxmaWVsZHtlbnRyaWVzfS4gQWxs
IG90aGVyIHZhbHVlcw0KPiA+ICtpbiBcZmllbGR7ZmxhZ3N9IGFyZSByZXNlcnZlZC4NCj4gPiAr
DQo+ID4gK1RoZSBcZmllbGR7YmFyfSB2YWx1ZXMgMHgxIHRvIDB4NSBzcGVjaWZ5IEJBUjEgdG8g
QkFSNSByZXNwZWN0aXZlbHk6DQo+ID4gK3doZW4gdGhlIFxmaWVsZHtmbGFnc30gaXMgMHgxIHRo
aXMgaXMgc3BlY2lmaWVkIGJ5IHRoZSBCYXNlIEFkZHJlc3MNCj4gPiArUmVnaXN0ZXJzIGluIHRo
ZSBQQ0kgaGVhZGVyIG9mIHRoZSBkZXZpY2UsIHdoZW4gdGhlIFxmaWVsZHtmbGFnc30gaXMNCj4g
PiArMHgyIHRoaXMgaXMgc3BlY2lmaWVkIGJ5IHRoZSBWRiBCQVJuIHJlZ2lzdGVycyBpbiB0aGUg
U1ItSU9WIEV4dGVuZGVkDQo+ID4gK0NhcGFiaWxpdHkgb2YgdGhlIGRldmljZS4NCj4gPiArDQo+
ID4gK1RoZSBcZmllbGR7b2Zmc2V0fSBpbmRpY2F0ZXMgdGhlIG5vdGlmaWNhdGlvbiBhZGRyZXNz
IHJlbGF0aXZlIHRvIEJBUg0KPiA+ICtpbmRpY2F0ZWQgaW4gXGZpZWxke2Jhcn0uIFRoaXMgdmFs
dWUgaXMgMi1ieXRlIGFsaWduZWQuDQo+ID4gKw0KPiA+ICtXaGVuIHRoZSBjb21tYW5kIGNvbXBs
ZXRlcyBzdWNjZXNzZnVsbHksDQo+ID4gK1xmaWVsZHtjb21tYW5kX3NwZWNpZmljX3Jlc3VsdH0g
aXMgaW4gdGhlIGZvcm1hdCBvZiBcZmllbGR7c3RydWN0DQo+IHZpcnRpb19hZG1pbl9jbWRfbGVn
YWN5X25vdGlmeV9pbmZvX3Jlc3VsdH0uDQo+IA0KPiANCj4gPiBUaGUNCj4gPiArZGV2aWNlIGNh
biBzdXBwbHkgdXAgdG8gNCBlbnRyaWVzIGVhY2ggd2l0aCBhIGRpZmZlcmVudCBub3RpZmljYXRp
b24NCj4gPiArYWRkcmVzcy4gSW4gdGhpcyBjYXNlLCBhbnkgb2YgdGhlIGVudHJpZXMgY2FuIGJl
IHVzZWQgYnkgdGhlIGRyaXZlci4NCj4gPiArVGhlIG9yZGVyIG9mIHRoZSBlbnRyaWVzIHNlcnZl
cyBhcyBhIHByZWZlcmVuY2UgaGludCB0byB0aGUgZHJpdmVyLg0KPiA+ICtUaGUgZHJpdmVyIGlz
IGV4cGVjdGVkIHRvIHV0aWxpemUgdGhlIGVudHJpZXMgcGxhY2VkIGVhcmxpZXIgaW4gdGhlIGFy
cmF5IHRvIHRoZQ0KPiBsYXRlciBvbmVzLg0KPiANCj4gdG8gLT4gaW4gcHJlZmVyZW5jZSB0bw0K
PiANCj4gPiBUaGUgZHJpdmVyIGlzDQo+ID4gK2Fsc28gZXhwZWN0ZWQgdG8gaWdub3JlIGFueSBy
ZXNlcnZlZCBlbnRyaWVzIGFuZCB0byBza2lwIGFsbCBpbnZhbGlkIGVudHJpZXMuDQo+IA0KPiBp
cyB0aGVyZSBhIGRpZmZlcmVuY2UgYmV0d2VlbiBpZ25vcmUgYW5kIHNraXA/DQo+IEFuZCB3aGF0
IGFyZSByZXNlcnZlZCBlbnRyaWVzPw0KPg0KUmVzZXJ2ZWQgZW50cmllcyBhcmUgdGhlIGVudHJp
ZXMgd2hpY2ggaGFzIHZhbHVlID4gMHgyIGZvciBmdXR1cmUuDQogDQo+IAlUaGUgZHJpdmVyIGlz
IGFsc28gZXhwZWN0ZWQgdG8gaWdub3JlIGFueSBpbnZhbGlkIGVudHJpZXMsIGFzIHdlbGwNCj4g
CWFzIHRoZSBlbmQgb2YgbGlzdCBlbnRyeSBpZiBwcmVzZW50IGFuZCBhbnkgZW50cmllcyBmb2xs
b3dpbmcNCj4gCXRoZSBlbmQgb2YgbGlzdC4NCj4gDQoNCglUaGUgZHJpdmVyIGlzIGFsc28gZXhw
ZWN0ZWQgdG8gaWdub3JlIGFueSBpbnZhbGlkIG9yIHJlc2VydmVkIGVudHJpZXMsIGFzIHdlbGwN
CglhcyB0aGUgZW5kIG9mIGxpc3QgZW50cnkgaWYgcHJlc2VudCBhbmQgYW55IGVudHJpZXMgZm9s
bG93aW5nDQoJdGhlIGVuZCBvZiBsaXN0Lg0KDQpQbGVhc2Ugc2VlIGFib3ZlIGlmIGFkZGl0aW9u
IG9mICJvciByZXNlcnZlZCIgbG9va3MgZmluZS4NCldpbGwgZml4IHJlc3Qgb2YgdGhlIGNvbW1l
bnRzIG5vdy4NCg0K

