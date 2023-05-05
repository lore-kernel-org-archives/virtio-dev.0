Return-Path: <virtio-dev-return-12595-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5072C77B7C
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 16:39:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3557D3DF35
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 16:39:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 192849866D6
	for <virtio-dev@archiver.kernel.org>; Fri,  5 May 2023 16:39:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0642A9866C6; Fri,  5 May 2023 16:39:58 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E58279866C5;
	Fri,  5 May 2023 16:39:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVvKex0+cXhD2uMCG6YvA2mPZnRO9LpOVqtSwIGNyqkEcItQpoezpsgHSd8pQ1qE6wBBaMc1cqP0/XWi7ZXtvnoXnRUkAUjYYLBCIBUZm7kjsEqt8iasNcGA5+8GdHeJZ8lO5+w4HXcSN5Ypln44BQHjh9Asf618L9wa79bCAuA+SIuW32Mi4F7hrJYmvFlad/KijnoDV63MAmGXnnLzVgj8V3267YEOwN5C4HDGxA5UADajLfEK5YVZB7dCLswURCG6wWd0knMjFdEL1VKyT6pR8jVr2hIlqunXmabXvZ5NAdUiLCRjr2zWn/S2E00A81LKiY8C/DXjdjVYSzqyWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jB9Ff7xX4O8OU6GNrLfHtD6qdAQ0glcvG44RPCRoUBI=;
 b=HQrBbO9HgWOrUUw5k2kuSLDV72hHrNZTG0oDHdO7SbhdM6Ihrq6gALSBDt+Afizaw8XymNkjBsIi42gQaIf7kLMmeKs/BWNiktJjnXiPgcd1EP0WvnNfi82kd0Nj3HzSixuFgrMQh/fZPTlhQeKmiGNaHMrq2jsy2IfwrroFb4+8QgbD7+EqVsxT1S2SCX7oB1RPxzAc6lTykmHZlKLjv6icfymZriiVat9cbSWG3DC4slT7bsKI+Rg8c/ujJ8390fH6zLYYpEAIkO0ekaKEkz7HRtvDgRvEPuDExGbOdl8NXmLCn7ByrMBkIrVPeSkl4cpWX25e+z413o8BGjtoKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>, "nrupal.jani@intel.com"
	<nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>
CC: "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Jiri Pirko
	<jiri@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler
	<shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Thread-Topic: [virtio] Re: [PATCH v13 03/10] admin: introduce group
 administration commands
Thread-Index: AQHZf2f53uznla+6jEmgcDHJz4bMfa9L11UAgAAKRAA=
Date: Fri, 5 May 2023 16:39:49 +0000
Message-ID:
 <PH0PR12MB54810CBE2F6CD1D7647151ECDC729@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1683301091.git.mst@redhat.com>
 <dc246cd15fce198dabb47f2de9b34dcf16820744.1683301091.git.mst@redhat.com>
 <3a618d58-3b34-7919-446f-0e99d67d410b@nvidia.com>
In-Reply-To: <3a618d58-3b34-7919-446f-0e99d67d410b@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM6PR12MB4249:EE_
x-ms-office365-filtering-correlation-id: 73410e59-773d-4e49-6b9c-08db4d8757de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Wt0wdMu99WCXbwsMcFO2Lv32Lo04tH+jtQAU3vVGrKYmxhQ39obkB4qNRi1yn0At89+eTA9uFjrf168YjqO0wVeZZ06WhSpRcmSxDRB2kUkr4aOw6ze33fusLDFPmpXg6nzU3uNHR3oPuhm9iQztTFNCrmFSv2JerwJzumHRnNff4ezfzyOoCsqzfFeRQpN3zjbFnYNxYGjnwItP8pGPhfKzaiwaWiVccs46sZ7N7dySrhr0CnwrcfpHhyU6ur8appNemBPkkjlT463SFty+BD+AMDQaYUVQjfbTgAu/XkTrLsSVnE3hpNknpBoDDXNzh6NSCrtW4eiAXi3K14qZ+82YRSAw2Ll8K2NyjNdJxO0tA7KHG9Oe6Lqi6af8kKVw0JA+b6xBBE0gu6vyR3UVq9+0Y42Tn665A9C1Yscafk5tKOPe5319lX5vxHaJ+VlPvifF8zx7aCVM5PXc/o8qUflW25pneha5yDpM3IGK5XxArDP1mFnpkzkTWv5sJjx5Efbyr9bvXjCA53bBog5kAZYwFOVDAATfa7Yt4xkP3/q3LKVRbdEiHiLgnQVLK3Q+tRNSgHHQjQny/WZrOOedIepASNsWT9B8pWAx76lxk0VhCTSHKgR7+30K5CTffIAZdkx65r+CJ0Dk40rUp0BmMwzuQgSCw/VNHKHsna/44cJULMQb561IP1bOe8GblX7pOxo4FwebXjk799qntwrnqQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(366004)(376002)(451199021)(7416002)(478600001)(921005)(966005)(38100700002)(55016003)(122000001)(52536014)(8676002)(8936002)(5660300002)(110136005)(9686003)(86362001)(66556008)(66446008)(66946007)(64756008)(76116006)(4326008)(6506007)(7696005)(107886003)(66476007)(26005)(2906002)(186003)(71200400001)(41300700001)(33656002)(4744005)(38070700005)(316002)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aTZ1akVRN2Z1RXd1dHByVXdLVndDcFVyTnlZN2srQklaWTE0M3VHcG9laml1?=
 =?utf-8?B?Y3NGcG5Ob3pYUE8zeWw3MGpJQjVnSC9zWE14ellXQUFNdlNhbWhMbVpnSkFB?=
 =?utf-8?B?dzlzcndiVkJiN3ZkOWZtOXFMOE1QajJwdFY4VVl4aTlsTzJxb0pOYVRPbVJS?=
 =?utf-8?B?aU5zd2lQV2d3QmhIeTcyNG50Zmxkb3FncXZ3YWRaVXFXMlV1YlRsKy95ZUJ5?=
 =?utf-8?B?VVp1eE56ejJ0T2RXZS9WenQzeVN2aFliREVRYWxmbFBJbk5qajF2ck9xYWNz?=
 =?utf-8?B?emh2VFBLeTBBZ3d2a2hVRXJyd1NXWURwMDBuUkdtOE1jaGFLa2hBdCszZGRw?=
 =?utf-8?B?TC9kNjFDODlzRHdpZElvWGNjWnhPbitrSnJjWHA5YzBBZ0pKUnVWN2cyU3Mr?=
 =?utf-8?B?TWorUmZDNU9FTUlqclFRVXRwL0NpTFc1a1Q2ck5tKzVodldEQmpzZi9wOTZj?=
 =?utf-8?B?UzdLTnN5NjNRTlBTcGFNaHpPWjlYaHdpNllEczFJWEk5dklnZnJnVDd6eWgx?=
 =?utf-8?B?cUE5ZFRyWk9MMnZXQy9ZdmdnUlcwZXIrMTlFOWtmYmtFOE8yek1iaUxXWEFI?=
 =?utf-8?B?dXV0dFhqc05SdXJJNUJBcjBYSk12elkvSUwwNk9CQnBGQWVzaDI0UlNwWnNi?=
 =?utf-8?B?R0wzVjRTWHVPZ21hSnJSSzRkaDlXQ1IvYjBISXljcEw4dE5LVWZock5nZ2Iy?=
 =?utf-8?B?cWxvMVVHdFY5czZMNmRCckViejBCMTcwV3k4MUJaTXFFTlovUDlxeE9PWit4?=
 =?utf-8?B?Z21ER2R6c0gxSUg3ZTBxYXpodUhqRHhmYXBDekJYWTRuaGhjN2c4ckxhd01C?=
 =?utf-8?B?Mmx0cGJBVzlSaDBuSnF0WUgweEhMN0grMExTR1dLanRwenI2ZGFDZ1JLNEpa?=
 =?utf-8?B?QittV2c3L09OMVNsVUVhSVpybkVCc29jdHR6UGlhY2t6YU5pUnBkYXBRSDY5?=
 =?utf-8?B?REk2akJTa2lJU1RBbFFVVEpwWlAzYzhJNjZCMjVRaitWb2NwQnpiMEh2MXRG?=
 =?utf-8?B?cjV3cHVtWlZucTQ4alM5eGJIQVU2SXpadkJLblpjMURBWTB2eU1TNFhrelBa?=
 =?utf-8?B?UEdJZHZncnRGTjJMNytUS1BFSGI2SVgwblJTWmd5RXFzMFE0amlpVm1RK2hT?=
 =?utf-8?B?L2FWcDM3K1d3U1NJUW93UytWRmgvbnBCRkhJRVBBYy93NEFaaVYxT1ZCdEpT?=
 =?utf-8?B?ZHBBSi9seU9tOUJ4dUVkV2hEVzZKVVc2NGRUeUtWdmdSSEU2Q1FaS3B2RjIr?=
 =?utf-8?B?RDJxSldTK2NEUk9SdFJOK2dWYUZuM1JVSGY0SEVMaVk0SE9qbWN2THVHRFdP?=
 =?utf-8?B?dllwTWNHQk9PQWlZYTNWNnp3cndGQkRMSmJaSmUzY2FmcG96N1A1aXNibENM?=
 =?utf-8?B?TUhFdkU0ZlVzL2tKU01nQ2RKRm9WdnFBZHF3Y05GVmVnd3oxemZCV2EzQVhK?=
 =?utf-8?B?UjhSMzZSQTUvK1JrMXp0UFVFSmRwNzRCQmtqUUw2VnlLWDZ1K3B5bXM5a1l5?=
 =?utf-8?B?c0JWb0lMWDYyUzZxaFdzbU1aTkRtZGJDMytjSjEycUxaOEQ1WmtDRGFNM0Zn?=
 =?utf-8?B?Z2Z5ckVDby9ZVEIrTTI1SW5xMkRIU1JScWxMd3RlRUlLZDdJVUU4dWtKRUVj?=
 =?utf-8?B?OUljV3BTR0dBWlczZURVUlRYTzNobngzSzNURVg0YStYblRsQ245MWk3N1pr?=
 =?utf-8?B?VlpDTHAyb1c0akV2Z0EwUDdMcHlmanpOVG9ORmRaTWIrRUJmTkUyaEZMdXNk?=
 =?utf-8?B?d2lwUHcrYmJTQUJqSGUwQnFjNGQyaGZoa2ZLclk1cE9RVG9NWk5rK2gyM3Jk?=
 =?utf-8?B?Q2d5V3I0Tk9GbXZCSHp0VlVvSXFXUlViOFFhY3lRbkRnQ01YTTU0cmdJbVp3?=
 =?utf-8?B?VmpiTzhYeXN2cVZ4ZUxSWmVIT2FYRHk2OWV1aXk5MUI4ekh5SWZITlRNMUVC?=
 =?utf-8?B?RVpySjdWUStuREM3aFZiMWJHTVZ6MmVqN3ZjMkVnWEtUZnIzUGlPV3BCUGtL?=
 =?utf-8?B?d0hVSlkxREE3WC9TN0x6WFRKMmNkbWhjS2YzeElVVGpncHNsODczaVNsQUN6?=
 =?utf-8?B?SEV6VnMzaU5VaENvd21LeUFkczh2MFpsWTJJLytEVVpmZ0EybnorN3Z6NlF1?=
 =?utf-8?Q?Tee8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73410e59-773d-4e49-6b9c-08db4d8757de
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 May 2023 16:39:49.2772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CEo/oZA4gZDh/doSIvPi+Yn4HJteAg07BJEJpzxQPK71Sw9SDyT9blDRTe7SFG4KL8uLC7ZPY82FT/F3R0/mLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4249
Subject: [virtio-dev] RE: [virtio] Re: [PATCH v13 03/10] admin: introduce group
 administration commands

DQo+IEZyb206IHZpcnRpb0BsaXN0cy5vYXNpcy1vcGVuLm9yZyA8dmlydGlvQGxpc3RzLm9hc2lz
LW9wZW4ub3JnPiBPbiBCZWhhbGYgT2YNCj4gUGFyYXYgUGFuZGl0DQo+IFNlbnQ6IEZyaWRheSwg
TWF5IDUsIDIwMjMgMTI6MDMgUE0NCg0KDQo+IERpZCB5b3UgbWlzcyB0YWtpbmcgbXkgMyBjaGFu
Z2VzIGhlcmUgSSBwb3N0ZWQgYXQgWzFdPw0KPiBodHRwczovL2xpc3RzLm9hc2lzLW9wZW4ub3Jn
L2FyY2hpdmVzL3ZpcnRpby1jb21tZW50LzIwMjMwNC9tc2cwMDUzMi5odG1sDQo+IA0KPiBPciB5
b3Ugc2VudCBzb21lIG9sZGVyIHZlcnNpb24gYnkgbWlzdGFrZT8NCj4gDQo+IG9yIHRoZXkgZ290
IGZpeGVkIGluIHNvbWUgbGF0ZXIgaHVuayBpbiB0aGlzIHNlcmllcz8NCj4gDQo+IFdpdGhvdXQg
dGhpcyBjaGFuZ2VzIHBkZiBnZW5lcmF0aW9uIGlzIGJyb2tlbiBhbmQgbWFudWFsIGludGVydmVu
dGlvbiBvZg0KPiBzY3JpcHQgZ2VuZXJhdGVzIHBkZiB0YWJsZSB3aGljaCBpcyBtZXNzZWQgdXAu
DQo+IA0KPiBJdCBpcyBub3QgdG9vIGxhdGUsIHRvIGZpeCBhbmQgcmVzZW5kIHF1aWNrbHkuDQo+
IA0KPiBPciBwcm9iYWJseSBsaXN0IGRvd24gdGhlIGtub3duIGlzc3VlcyBhbmQgSSB3aWxsIGNy
ZWF0ZSB0aGUgZm9sbG93IHVwIHBhdGNoZXMNCj4gYXMgdGhlc2UgYXJlIG1hbmRhdG9yeSBub24g
Y29zbWV0aWMgZWRpdG9yaWFsIGNoYW5nZXMuDQo+IA0KPiBQbGVhc2UgbGV0IG1lIGtub3cgaG93
IHNoYWxsIHdlIHByb2NlZWQuDQoNCkkgc2VlIHlvdSBhbHJlYWR5IHN0YXJ0ZWQgdm90aW5nLiBP
ay4NCldlIGNhbiBkbyBiZWxvdyBlZGl0b3JpYWwgZm9sbG93IHVwIGNoYW5nZSBhcyBwb3N0ZWQg
WzJdLg0KDQpbMl0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvdmlydGlvLWNvbW1lbnQvMjAyMzA1
MDUxNjM3MTIuNTg5NDYwLTEtcGFyYXZAbnZpZGlhLmNvbS9ULyN1DQo=

