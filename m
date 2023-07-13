Return-Path: <virtio-dev-return-13380-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B300BC001B0
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Jul 2023 13:44:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1D39E157EF2
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Jul 2023 13:44:08 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1072E9867F0
	for <virtio-dev@archiver.kernel.org>; Thu, 13 Jul 2023 13:44:08 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id F3CD49867CD; Thu, 13 Jul 2023 13:44:07 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DE3C19867C3;
	Thu, 13 Jul 2023 13:44:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdgGPxrejtjeM6wP570R2jnolkl9iMflbGIfM+bV8Dor5rzRkQoAHiyHSVTdYCq92B8+59JkQFGjfaPJRZylum9yhY8vjwFTC16Clgl++x3Ds+Tms4Ag+XtAk3Mj8AzNK508ua7nA54W4GXUkpololKW5wD32xSBFWpFBhzNNfk0Zxco2/hkvNgpStiGRRWbRmkqb7U5iXpd1HAesnTNy/bfcmOPWLgRW+alyST5QVrAl+DrtKUIB6N4spf6Ynhq/ruF4m7g+2L6iOInwuJ0D66rAMaeWSR7r36RweFjRHCdyIeZZ+Omr+ZQL6o+4Euey74t5mw4hME9/wcud9m3pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vbtbPjTemjfZ/2KPBN8oRv7POFpNKzTXa+oHMORwGI=;
 b=kPfGzHwtq0TfFN1bHw0BU6AE7/Azg/v2qHssNkgT/AJPPbpwxUy0IZhGr3yvkjKAmPzkbJfTwBzdwIPR7kNl44nrx+TioWWjjznCeo9Qp5XRpQBNOZfO9gfE6cbJrSsMaqf2+SIqDqvWVGJBhWKLCjtxNFQZqwvN81CkOyw/tpgAfwwwkQC+tuqdAKa/RuTXIzfA84/QMWbnY8/q6prWsdV6/XSjlmWWrDlGljOuVBmi2lySuDyh/t5sBjfjkLW7rZMK0LS9WYVlGKUdag/pf74XKVUG3aNvwFsuM9qa3uemE1Ync4WecW53q1JKSmzqp3KYZMmfyfu1pFGuNwnqvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"sburla@marvell.com" <sburla@marvell.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb
	<maorg@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v15] admin: Add group member legacy register access
 commands
Thread-Index: AQHZtAishc61CLqjq06oop2Od1rEha+3togw
Date: Thu, 13 Jul 2023 13:44:01 +0000
Message-ID:
 <PH0PR12MB548114295F2A6A5747B8B626DC37A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230711150135.222793-1-parav@nvidia.com>
In-Reply-To: <20230711150135.222793-1-parav@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL3PR12MB6449:EE_
x-ms-office365-filtering-correlation-id: 63477de7-326d-471e-3bba-08db83a73735
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 e66jTGV1HTdwSV6c31WYcQMtr5yYIYC/gFegd4fac4JexUqeP8Es14lKrkNxXzvog7RTsTOxRTSDFjZWVLHEoD4yqJw/tNpqHPma06FvgAIa6foqD7pHCe5jffFZwiwTcywju0c3HbIQAdr7X/R+uDI0rukkxUA7MKi+DzpsA1YnnV0sEF6KUCXpjyPbUimFAeC3sLEF89ZVhwlRC/pVoMhJMamY9tWP5kFJsRlBWpqxmYSP+baj0ax5T5ytYRpScYPDuNEkZriw0IW6xXsFgqPd7a4z/RoKZWrtFgvRx5XmKCpTOuzv3iwV9KQPyYfTrmBRQJiscW+mtTFwHe6IxF6r2sEqAznK1TuO7JEAesREoMkQwRmDoQYI95xDLHAjkI2gILzk1rbbunDjliQ0jrXjuzmTcjyvPtDiHPeeZUAopdLWe+QxUzWrHsk4L+5BcNiLZVcjXN9A38ZYpsrDlsD17lz97kvfYcrwY5WdIBKGhaz3G9Mmf1I63kM2R5QyAo4Bta5ychiL2YWgMo8oG3SZxYe1kpXBrubmF6P68YPNe/qC/SxMUEq3vXt6sGNBQ2FRcaqv+o7WElzOtalvXPBM1FxUIWRtAbRDQOMqAnJsW3KUTqEPlb6cEMOx9VN3dMkQwaf7xQ595XF62B/sNiUK/IBSc/1BLmjYZ31OZ5o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(396003)(39860400002)(366004)(451199021)(7696005)(9686003)(966005)(71200400001)(33656002)(186003)(6506007)(53546011)(83380400001)(38070700005)(86362001)(38100700002)(122000001)(107886003)(55016003)(26005)(4326008)(64756008)(66446008)(76116006)(66946007)(66556008)(66476007)(41300700001)(2906002)(316002)(52536014)(5660300002)(8676002)(8936002)(110136005)(54906003)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YWllYVBWSzNzQVgrRXZiMWhsOEpXRDE5c1RoZ05VWk91d09Ba0dha2RZZm81?=
 =?utf-8?B?ZzRLaDFSL2hiejE3eExrMFY2TVZUQzJ6Y2JkOGhzMEc5MlczVFpLc09DY0cz?=
 =?utf-8?B?ZmdkV0M0eVRicGV6ZnRXZGFtL2FueXd5aGg5WHRnbGVVN21QL055V2pqeEVT?=
 =?utf-8?B?d1RTbHZad2xreVl4YkRGUmtpWFIyalhzTWJ1b1lHUGhDKzVGNzdHKzNWbHNw?=
 =?utf-8?B?Y0o3endDWTZrOElVWWJWS1dRamMzVE5PTzJGdUM3M2c4a2Y3RGdiNDhmV09v?=
 =?utf-8?B?UUZLNVc5WmVwZGQ1akU2Z2pUaFZwVU5HcUJ0UWJzYmwwWEk3KzBMNEJZRlZp?=
 =?utf-8?B?SDM2aDB6NmxGQzVqakJLZVJJR2tBeUJtWEg0OU9XZ2RMbEZVdWVZdHozdUll?=
 =?utf-8?B?eGVLSkxSQVhGYUx4dlVOakhxL2c5QitNLzRPVUVHanRYTFNZVGIycVFlb3gy?=
 =?utf-8?B?bmY5Sm1VM1czNkROZHF3TlUyMFpWbG1KaE5aMnlRcGJiNzRtS3JGalRjRHFO?=
 =?utf-8?B?aXkvVzBwTjJ1SC8rdHZaQzlxUnUwTEc2aHFRdzRobnFMbWxmdlZoNFhId0xn?=
 =?utf-8?B?UHR2NVZsY2VCODVrZDNOQTNNaWhxeW1MbkNXaENncHBHTUVQbGhZS0p1Rkxs?=
 =?utf-8?B?SkpiN04rSnFvaW5SVnVrVjFoZm9jV1UzbnB0MzlvRERYMkxkVEE0MkRUZ3FW?=
 =?utf-8?B?eTJBbHFXSW1ycHVncHFPRTFnQ1EvZ0h2UGg0TlVnOHgyQU9Edzk5M0FzUFA2?=
 =?utf-8?B?RkIrblNmMHh0WWp4bWdSRHdWSTRNQlBmaVdHTVgwZkZPR1NTeThsSmpYTGh6?=
 =?utf-8?B?QnN2VndtY1YyUm1lcExOT1U2dkhmNDd5Wmo2SE1iVU5uYnY1UXl2Tnc5R1dr?=
 =?utf-8?B?QmxaRHM5SEZkVzNsQWlCMlZLUnVaYTJqUjFBMS9KQ1BuMmtwVkZidmE2YWFk?=
 =?utf-8?B?UjFPcWYwUTdVRDRJRWVIK2VPMHQ1Z01pU2pXWW5sTlA0Zi8yOXdzemFKczBy?=
 =?utf-8?B?VUJtMWY3MkpuZDdtYjhwcC82MWJZOWUra0NNNmxmNC9HRER1RkxWa3o0clYx?=
 =?utf-8?B?VW03ZDM2c0pIZGJtZDBpVFBNK09WbkU4aVg3RU5nY1htNTVEdkVVVWp1QTBk?=
 =?utf-8?B?THZxQzRVd01WWTYyNTlyRnhDWnRZdGlJT0wwV2h3a0tDOUliRE1CZlNtWXRj?=
 =?utf-8?B?VHkrazJwRXdvazdiRi9tcGdJUTFrK1o2VUdGa3pVRlRDdVoxU1FqOHBxY0wx?=
 =?utf-8?B?clZwVmFjWHdqZ1V2blQ5MHlJbjFvcWNuclJTTWwvejFGTU83eGdSdVAwT2Nz?=
 =?utf-8?B?ZGszVG5JUHpMVDVvOGEwMURHUnpmaWVsRGsyaG5ab1FBUUtIVW8zMnNTYzRi?=
 =?utf-8?B?OXlMUXp6R1Q2ZE1FYm8weEl5aGxCc0FiQTl2MVdaNDVMNjBaQ25sb3V2UjJW?=
 =?utf-8?B?UWcxUWlYVmY0VjNkWVV5TnFvZ21FazhLYUYvWS9kOGsyS1Rrb0d2bVNZZ3ZI?=
 =?utf-8?B?TUYyeUlUaXVsY2hTcTJzT2xpY2MyLzBtYlFOUGFhdzhDQ0dGWmxXc1FZeElr?=
 =?utf-8?B?UlZ1RW56VCt0Mm10VHdUT21EaThubE53U1BoWnpDckF0RVh2SWc3TlVqOUhl?=
 =?utf-8?B?NHpXY2phcERxL2JOdGV6ek82ai85UlBUL3h4MEFHam9ESDk3SkdjT21FQU5F?=
 =?utf-8?B?ai9NdkhOb1E5aXlkYzFLdzNpdmFtVU5XZjdHTmRveDlUS293djZGNDJEc0Iz?=
 =?utf-8?B?YXlBVzV6RXZBVEpPdFlRc2tNUUV2Q2VYSEMyenVjN04raWtyTEx2SVJsMzVS?=
 =?utf-8?B?U0JHU2xJaVFMczd6RGFqUUs1enkzbUdubGd4Tk5DbEd0VkZycjNCUGtySVFL?=
 =?utf-8?B?MEhCNzVFUFZrSDJWUVBqcWx3QWMwV2hTaXlJOVlPTHpzOWowNW5WMXZqTjAr?=
 =?utf-8?B?eXY2TWlpbUVodjZRZkl0MFNJbmdmQTN0bVE5UVVnemxqTjlheXJEdGxuMzls?=
 =?utf-8?B?aXlXS3NPMEEzQmttT01IQitVZWc0RytWaWxTWmVWdTNoRm9FTHA5aFZUUU5y?=
 =?utf-8?B?UUw0VWlhVmZBSEtBSXJJUmhCZGd5WXFxd2dsTWIycHp5akorenRhVjNacmRS?=
 =?utf-8?Q?4NXU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63477de7-326d-471e-3bba-08db83a73735
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 13:44:01.1706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tdde705ptTtXuCe7kF7RGJW+5oxr6lyTZpiqcFlKDQzlN0+R9X1XeWNTjXz1sVSjHvQo2s9dUdzUexWOC2RlZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6449
Subject: [virtio-dev] RE: [PATCH v15] admin: Add group member legacy register access
 commands

SGkgTWljaGFlbCwgQ29ybmVsaWEsDQoNCj4gRnJvbTogUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlk
aWEuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBKdWx5IDExLCAyMDIzIDExOjAyIEFNDQo+IFRvOiB2
aXJ0aW8tY29tbWVudEBsaXN0cy5vYXNpcy1vcGVuLm9yZzsgbXN0QHJlZGhhdC5jb207DQo+IGNv
aHVja0ByZWRoYXQuY29tOyBkYXZpZC5lZG1vbmRzb25Ab3JhY2xlLmNvbQ0KDQpbLi5dDQoNCj4g
Rml4ZXM6IGh0dHBzOi8vZ2l0aHViLmNvbS9vYXNpcy10Y3MvdmlydGlvLXNwZWMvaXNzdWVzLzE2
Nw0KPiBTaWduZWQtb2ZmLWJ5OiBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRpYS5jb20+DQo+IFNp
Z25lZC1vZmYtYnk6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+IC0tLQ0K
PiBjaGFuZ2Vsb2c6DQo+IHYxNC0+djE1Og0KPiAtIGFkZHJlc3NlZCBiZWxvdyBlZGl0b3JpYWwg
Y29tbWVudHMgZnJvbSBNaWNoYWVsDQo+IC0gcmVwbGFjZWQgJ2lzJyB3aXRoICdhcmUnIGZvciBj
b21tYW5kIGRlc2NyaXB0aW9uDQo+IC0gc2ltcGxpZmllZCB3b3JkaW5nIGFyb3VuZCBpZ25vcmUg
YW5kIHNraXAgdG8ganVzdCB1c2UgaWdub3JlDQo+IC0gdG8gLT4gaW4gcHJlZmVyZW5jZSB0bw0K
PiAtIHNtYWxsIHJld29yZGluZyBmb3IgZmxhZ3MgZGVzY3JpcHRpb24NCj4gdjEzLT52MTQ6DQo+
IC0gYWRkcmVzc2VkIGJlbG93IGNvbW1lbnRzIGZyb20gTWljaGFlbA0KPiAtIHJld29yZGVkIEJB
UiAxIHRvIDUgdGV4dCBhc19pcyBzdWdnZXN0ZWQgYnkgTWljaGFlbA0KPiAtIGFkZGVkIHRleHQg
Zm9yIHNraXBwaW5nIGludmFsaWQgZW50cmllcw0KPiAtIHJlcGxhY2VkICdjb250YWlucycgd2l0
aCAnY29udGFpbicNCj4gLSByZW1vdmVkICdyZWxhdGVkIHRvIHRoZSBiYXNlIGFkZHJlc3MgYXNz
b2NpYXRlZCcNCj4gLSBhZGRyZXNzZWQgY29tbWVudHMgZnJvbSBDb3JuZWxpYQ0KPiAtIGFkZGVk
IGFydGljbGUgdGhlIGF0IG1hbnkgcGxhY2VzDQo+IC0gcmVwbGFjZWQgZG9lcyBub3QgdG8gZG8g
bm90DQo+IC0gcmV3b3JkZWQgdGhlIGRyaXZlciBub3JtYXRpdmUgZm9yIGZsYWdzIHBhcnNpbmcN
Cj4gdjEyLT52MTM6DQo+IC0gYWRkZWQgYXJ0aWNsZQ0KPiAtIGFkZCBoeXBoZW4gYmV0d2VlbiBs
aXR0bGUgYW5kIGVuZGlhbg0KPiAtIG1lbnRpb25lZCB2cSBpbmRleCBkZXB0aCBvZiAxNi1iaXQN
Cj4gLSByZXdyb3RlIGFsdGVybmF0aXZlIGFwcHJvYWNoIGxpbmUNCj4gLSBtZW50aW9uIHZxIGlu
ZGV4LCBsZW5ndGggYW5kIGVuZGlhbm5lc3MgaW4gbW1pbyBkZXNjcmlwdGlvbg0KPiAtIGZpeGVk
IHBhZGRpbmcgYnl0ZXMgc2l6ZSBmcm9tIDcgdG8gNiBieXRlcw0KPiAtIHJld3JvdGUgYmFyIGZp
ZWxkIGRlc2NyaXB0aW9uDQo+IC0gb2Zmc2V0IGFsaWdubWVudCB0ZXh0IGFkZGVkDQo+IC0gYWRk
ZWQgdGV4dCB0byBpZ25vcmUgcmVzZXJ2ZWQgbm90aWZpY2F0aW9uIGVudHJpZXMNCj4gLSBkZXZp
Y2UgYW5kIGRyaXZlciBjb25mb3JtYW5jZSBsaW5lcyBhZGRlZCBmb3Igbm90aWZpY2F0aW9uIGlu
Zm8gY29tbWFuZA0KPiBmaWVsZHMNCj4gLSBkcm9wcGVkIGdyb3VwIG1lbWJlciBwcmVmaXggdG8g
dGhlIGRyaXZlcg0KPiAtIHJld29yZGVkIHRleHQgZm9yIGZsYWdzIHJlcXVpcmVtZW50cw0KPiAt
IHJld29yZGVkIHRvIHNheSBhbGwgZHJpdmVyIG5vdGlmaWNhdGlvbnMgaW4gY29uZm9ybWFuY2UN
Cj4gLSBpdGVtaXplIGNvbmZvcm1hbmNlIHNlY3Rpb24gdW5kZXIgY29tbWFuZCB0byBlYXNlIHJl
YWRpbmcNCj4gdjExLT52MTI6DQo+IC0gYWRkZWQgbWlzc2luZyBhcnRpY2xlIHRoZSBhdCBmZXcg
cGxhY2VzDQo+IC0gcmV3cm90ZSBncm91cF9tZW1iZXJfaWQgc3RhdGVtZW50cyBsaWtlIG90aGVy
IGV4aXN0aW5nDQo+ICAgY29tbWFuZHMgd2hpY2ggaXMgY2xlYW5lciBhbmQgc2hvcnRlcg0KPiAt
IGFkZGVkIGxlbmd0aCBhbmQgYWxpZ25tZW50IGxpbmVzIHRvIG11bHRpcGxlIGNvbW1hbmRzDQo+
IC0gcmV3cm90ZSBmYXN0IHBhdGggdG8gc2VwYXJhdGUgZGVkaWNhdGVkIG1lY2hhbmlzbQ0KPiAt
IHJld3JvdGUgZXhhbXBsZSBhbmQgZGVzY3JpcHRpb24gcGFyYSBmb3IgbGVnYWN5IG5vdGlmaWNh
dGlvbiBjb21tYW5kDQo+IC0gbWFkZSBzZXBhcmF0ZSBwYXJhZ3JhcGggZm9yIHRoZSBub3RpZnkg
aW5mbyBjb21tYW5kDQo+IC0gZHJvcHBlZCBjaXRhdGlvbiB0byB2aXJ0aW8gcGNpIGNhcGFiaWxp
dGllcyBmb3IgbWVtYmVyIGRldmljZQ0KPiAtIG5vdGlmaWNhdGlvbiByZWdpb24gY2hhbmdlZCB0
byBub3RpZmljYXRpb24gYWRkcmVzcyB0aHJvdWdob3V0DQo+IC0gYWRkZWQgZGVzY3JpcHRpb24g
dG8gYWxsIHRoZSBmaWVsZHMgb2YgdGhlIGluZm8gc3RydWN0DQo+IC0gYXZvaWRlZCB1bmlvbiBp
biBzcGlyaXQgb2Yga2VlcGluZyBhbGwgZm9yIHBjaQ0KPiAtIHVzZWQgc2luZ2xlIGxpc3RpbmcN
Cj4gLSBtb3ZlZCBkZXNjcmlwdGlvbiB0byBlbmQgd2hpY2ggd2FzIGluIGJldHdlZW4gdHdvIHN0
cnVjdHMNCj4gLSBhZGRlZCA0IGVudHJ5IGFuZCBwcmVmZXJlbmNlIGRlc2NyaXB0aW9uDQo+IC0g
YWRkZWQgY29uZm9ybWFuY2UgbGluZSBmb3Igbm90aWZpY2F0aW9uIHZpYSBtbWlvIHdvcmtzIHNh
bWUgd2F5IGFzDQo+ICAgYWRtaW4gY29tbWFuZA0KPiB2MTAtPnYxMToNCj4gLSByZXBsYWNlZCB0
YWIgd2l0aCB3aGl0ZSBzcGFjZXMgaW4gcmVhZCBzdHJ1Y3R1cmUNCj4gLSBpbmNsdWRlZCBwY2kg
ZmllbGRzIGFsb25nIHNpZGUgb3RoZXIgZ2VuZXJpYyBmaWVsZHMgdG8gYXZvaWQNCj4gICBpbmRp
cmVjdGlvbg0KPiAtIG1lcmdlZCBwY2kgY29uZm9ybWFuY2Ugc2VjdGlvbg0KPiAtIGF2b2lkIHVz
aW5nIGRlZmluaXRlIGluIHN0YXJ0aW5nIGludHJvZHVjdGlvbg0KPiAtIHJlcGxhY2UgJ2FsbCBv
ZiB0aGUnIHdpdGggJ2FueSBvZiB0aGUnDQo+IC0gY2hhbmdlZCBkcml2ZXJzIG5vdGlmaWNhdGlv
biBub3JtYXRpdmUgdG8gaW5kaWNhdGUgdXNlIG9mDQo+ICAgTk9USUZZX0lORk8gY29tbWFuZA0K
PiAtIHJlbmFtZWQgTk9USUZZX1FVRVJZIHRvIE5PVElGWV9JTkZPIG5hbWUNCj4gLSBtZXJnZWQg
NHRoIHBhdGNoIHdpdGggM3JkDQo+IC0gYWRkZWQgbm9ybWF0aXZlIGxpbmUgZm9yIG5vdGlmeV9p
bmZvIGNvbW1hbmQNCj4gLSByZXdvcmRlZCBub3RpZmljYXRpb24gcmVnaW9uIGNvbW1hbmQgZGVz
Y3JpcHRpb24gdG8gYmUgbW9yZSB2ZXJib3NlDQo+IC0gbWVyZ2VkIGZsYWdzIGFuZCBvd25lciBm
aWVsZCB0byBpbmRpY2F0ZSBlbmQgb2YgbGlzdA0KDQpOb3cgdGhhdCBsYXN0IGZldyBpdGVyYXRp
b25zIGhhbmRsZWQgYWxsIHRoZSBzdWdnZXN0ZWQgZWRpdHMsDQpDYW4geW91IHBsZWFzZSBzdGFy
dCB0aGUgdm90aW5nIGZvciBpdD8NCg0KaHR0cHM6Ly9naXRodWIuY29tL29hc2lzLXRjcy92aXJ0
aW8tc3BlYy9pc3N1ZXMvMTY3DQo=

