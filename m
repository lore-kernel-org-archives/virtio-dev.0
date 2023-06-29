Return-Path: <virtio-dev-return-13166-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377D2EB64D9
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 21:36:19 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9D4413F8EA
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 21:36:18 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 916319866F1
	for <virtio-dev@archiver.kernel.org>; Thu, 29 Jun 2023 21:36:18 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 85ADF98413B; Thu, 29 Jun 2023 21:36:18 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7003C986677;
	Thu, 29 Jun 2023 21:36:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HaBtxJ2OFu2mV0AdGjZsZnvHgzwc+i4/im1f1iGWkvTNABnRTGGAjmAPzDM8H1/Wl7wzvkhaNgQ3WgAEgbqAaj7Xi4ph0A3Bh8jmJBf7pipn5NYyb+qlJydspjN5NFHb6LZM3UF+X0tliez3ukL889cNzRulIZyzWtmw24ieBuN2+VZeF28Ikx4XhvFr1IBQXFN4N+5L7WKwxAUUtXNZ0QIPjlejMVgCYneLW5S3Wtobigzva32vvQiiv+P8Rjb8Va+Jg42nNMb7qAW002RvgyzglGhxxvBGCoc0swD2UK6gv2h6PRveEmryN7ZemykFbU4Kv6m8suNht9ZCL526zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCWR+atEHLLq58qjgX2YaKnAAVwrq1/koD9cSfTRffk=;
 b=U3BWWUImohEznxiq+XnEj4b2jINL2GFvfhoKmz1ps1Lu+plVqseus0BkwuxWN8YKktPxIl6J3W0SO0NsAPXdq7wGG4svFRB51nbuiE3LPVSkdT+58PhWXoJURVO2iXnohfrphb5xwfV4GCqhwBkmEguVFRGubiI4NVhP23zk8lSJiJ6vbw1cOyGjczf3saJs9AML6znyeunQc2+/NOdRuBUyElhpblYsMn5tAarJatCM+3iNmSFvyBt1gFBCZNZCSxoiTcZ+vj7kR+yPFTdIjTLYd/RSO+VQ1FS9QHdO1FAU7UpsQe6mg8s7qoIvJHOIfuCIFW4Uw9wRDsUT6xZf0Q==
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
Thread-Topic: [PATCH v7 0/4] admin: Introduce legacy registers access using AQ
Thread-Index: AQHZqTvq5aV3SrtNxUKKvKloelKxkq+iNXmAgAAa8oA=
Date: Thu, 29 Jun 2023 21:36:07 +0000
Message-ID:
 <PH0PR12MB548185898FA336710208B3EADC25A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230627211050.1527507-1-parav@nvidia.com>
 <20230629155403-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230629155403-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH3PR12MB8972:EE_
x-ms-office365-filtering-correlation-id: 221566df-ae92-480c-8a8d-08db78e8d908
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 F2WVZ93TUTMrhGfbosufhraM3JHVMNSl6wQOZQuzuqK9tjLKsU9yoQ7qYbAqQMrHYvgVkH3Zt0YWpTpdkl8NSq0ZJ+9R8FbpJ40pkjmNfQkrDtbIS6b2jhsndBkkKGQEgVgCkiLdJ2PQNFfrrRmm067Knrx2dE+12F0IKYXEQg1tdNYk1TqINCbQGogk6T8CyJHteJTuAkh5wJdkFHPMq6Az0cC6CKm6CtNnv9QHPBFK0RIX0sYooYPyPWjlyjqnHXBdwZ0vyHZO4kGBiwZXgUPE6lfikke2LsxEHsdFwQ+QfuvvmDvZ4Mf/Bv+5abUpRcAyyRGUyvLbsN+yrjSVJRU/Qha0rmiBkilofiK8SimKRjDXthFgdNdW9A2FaONClGgqXpD5eLxskEwZm1rcirKzbU5soIGU42Y8+In80nUpn1NMDvQieFhVfecTbKWaXh5yR1J43hPR6gUvFLjC4Hb4g0AetCwIsTaKJMIlUDmtg5T9ruUyeS4ryyklwp1gEocRXoyFyoDgapEzyjqJgI0Pk23m+ULPUUtESyLMfLa4g9EC0/PKSom6V5knwn66y1doJMDvkbMAB9JIcWuLneq+vVNOy9ItTpT/2o9IwXWCcAJz4XRw56ca4qn42b0Y
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199021)(26005)(9686003)(186003)(6506007)(107886003)(7696005)(52536014)(5660300002)(71200400001)(122000001)(38100700002)(8676002)(8936002)(86362001)(54906003)(478600001)(76116006)(4326008)(38070700005)(4744005)(2906002)(316002)(41300700001)(55016003)(33656002)(66946007)(6916009)(66556008)(66476007)(64756008)(66446008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q3YyU2s2VTF1SWFRUmdlVDVDNjFjN3FlaDc2ancxRnVabEJubjBvZDN6Y1Zr?=
 =?utf-8?B?a1hzQ3cxSVJjN0RUNzB0OS9WaFlXS0Y3bmFYYUZBMmROdmJETmxlbVFLa3Fy?=
 =?utf-8?B?WTE3U3RDMm1BSGVBZ29YYVlMVE42ZURiVnViMDd4S3VpOXlMbjRYSmZKSEly?=
 =?utf-8?B?ZEQ5TnJVUm5TYXBEcUh6alk1ckNIT2M0bmFKVG9aNmltSVV6ZXF3OTVTZHNO?=
 =?utf-8?B?cThOOWtwbFB4cXVmZ3J4SDE3MGd0NUFlNTAyaEJyUFVOa2lWYktUNG1BL1M2?=
 =?utf-8?B?Qm5lMTJaVTBsTUhsSmpjcDZUdjZuaDI0RW9GM0ZheGtEZDZpcGhsTzhDbVJB?=
 =?utf-8?B?SVY5ckZNQ1VaZVlkRFBxOFMydkdtZndsdUVVYmRlN0RGTXdsaG5ReVp0UnpY?=
 =?utf-8?B?dHR3Umt0ME5SbHFRMDc1L3JYd1R3OTRHb21PUUU4THNCcDB3SkRsRlllVUVy?=
 =?utf-8?B?MmttbXFtbVY4bXdvNXphak93VzFoWHF4V3VaUktGcFFwVWI5aUQ4SW55VXJ0?=
 =?utf-8?B?QS8wVDR4ZkRLVWVHMW9lMXlxVWpsSzR2N0xIak0zdFlRMmQ1R2Q2UTJjY1FX?=
 =?utf-8?B?RVQ1TExKK0t6RlhLRDNoYWd6b3ZncUh3ZWpIdCtOQXV2Wm1hZGpIcHFOU2ho?=
 =?utf-8?B?MVFwUzljWFdzak5IeXM2L01qaXNOMnk1WFExUUZUUmh3bTg0bU9xRlNaWWVV?=
 =?utf-8?B?VjVrbXN5TThTKzVqNWJMWTlobmduY2xFTTFKUklFN2N6ZlI2Si9nUkdBdFNo?=
 =?utf-8?B?QkltRVZoMGNiQTBZZnVnbGJocFNMdWF2bEpaTzVhUkNvRmdwbjRkZWFFL2Uy?=
 =?utf-8?B?Ylc3YUh0ZHlyMzRwcjh2dHNpSnZwamNBb2l3Y1FMMWQzTi90NFEzMm9NVjc2?=
 =?utf-8?B?eDFyaVdNV014aURrSXlNcTlEV1R1Wkd2R09qZ1E4clNxTzh2NmpxVE9qZFR3?=
 =?utf-8?B?SHFSeVlQUEpJRG9JVGFyMEZ6RU5Rc1ExaG9oVWthNFI0NkZ3Q1h0OUtWNEpv?=
 =?utf-8?B?bTFiK0VwYXJDZU5tbURhRUk5OSswY05vdEp4QWg0T1g1ZExOanRlQzFtNTJB?=
 =?utf-8?B?N1lHVGtwM2RwVmlTS0JTaXRzaUZCODJZaUxKR0V3TmJQZlJ4R1BBSEgxS05R?=
 =?utf-8?B?RDN2NEVWeEd1b0J4V3hNcHQ4QUptNGRJdnlIdTliRTE0WFJNb1JwakVmTWZx?=
 =?utf-8?B?VTFiRDJXTHhONG8vZW5IV0I2YWhVWXdtbW5zV21qcCtTVUJZM1ZvZVRMM2Vs?=
 =?utf-8?B?dUlSUHcyandEbHlpeWZlZjRuMzhhMkcvTUJjTzRJRkM3S3BLdlczcW9oNWF1?=
 =?utf-8?B?WHY1OEx0NXJ5SlVTRXhRZEpwNUQ0QU9qTW9Td0IvUlVGMWp6ajJWVDJDUFVL?=
 =?utf-8?B?V3V6eVNtOWtJTEhQemVXdEp6d2dvUG1YbHlEUkVSU2N1U2Q3bDYvalAxeXI2?=
 =?utf-8?B?VnpVL1FLL1VxQ3B0T2dnVlVxMWgxemJiK0pvVElXL0JpTlF2enFza1JoQzho?=
 =?utf-8?B?aVR6cW4wemtvenlEK0RCb3cvNGdZaHZMRjVjMUxlWGFMMVpQMHZKZGFCVnd2?=
 =?utf-8?B?Zy9LUy9zeFVmRjB6aUtNUGN1QTlVd3d4NGMzUWN0amREOTJTMGkvQjlNSGpz?=
 =?utf-8?B?WFY4MmRJaWRhZU04RDJGNjlKeG9zczR3d1k2a2psazNQQlpUWlplc1EvUC82?=
 =?utf-8?B?cnZOcTJvYXhDMDNFWEhYVHk4eUJGSzJvNDV6cTBib2wyQm42cTNLYXRMSHdZ?=
 =?utf-8?B?d2ZmN2YwRExablNEQytmL0tDZytLVjJ2Mk81eHZuM1lPVEtUTHFhcGt1dVpy?=
 =?utf-8?B?a1YxYjVjWnpqNjhYYm1UNTJreHpMamh4bnZDVisybzc3eEg5RkFZdEMxM3NU?=
 =?utf-8?B?RC81RVVTd2FrMEdPYjRWSXdZeHNBNGxNL2VjSm9EdHNCbE01NHJueHpneE5I?=
 =?utf-8?B?WEpQK01tQWdCWFN4SWo4anAyQXlLNkx6dVovZGZYVzBaTjN6QTJyTFQ5dEdk?=
 =?utf-8?B?QjR2cTBmZ003UEhZVFY5Z1Avdy8vRzVTdDA2S3NSUTg1YStKdmNnVElxUVk1?=
 =?utf-8?B?aEs3TzdTclRsN2tHYlY1K08wNlFNSy9BYVp6M3k0MFloZDJJaDkycWJwQm5K?=
 =?utf-8?Q?RGdY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 221566df-ae92-480c-8a8d-08db78e8d908
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 21:36:07.1657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OUYPITvMh+dHrPTHW1zFbHr69/pjb8fAr32U2e+s7eVkd4u4aCLmYbDlJ6Bs22PJli914T7Mx+rX0uapeIlyHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8972
Subject: [virtio-dev] RE: [PATCH v7 0/4] admin: Introduce legacy registers access using AQ

DQoNCj4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gU2VudDog
VGh1cnNkYXksIEp1bmUgMjksIDIwMjMgMzo1OCBQTQ0KDQoNCj4gDQo+IE9LIEkgd2VudCBvdmVy
IGl0LiBTdGlsbCBzb21lIGNvbW1lbnRzIG9uIHRoZSBBQkkuDQo+IElmIHlvdSBjYW4gYWRkcmVz
cyB0aGF0IGJ5IG5leHQgd2VlaywgSSB3aWxsIHRyeSB0byBmaW5kIHRoZSB3YXkgdG8gZml4IHVw
IHRoZQ0KPiB3b3JkaW5nIG5leHQgd2Vlay4NCg0KU3VyZSwgd2lsbCBmaXggaXQuDQoNCj4gUHJv
YmxlbSBpcywgd2hlbiB0aGluZ3MgYXJlIGZpbmFsbHkgcmVhZHkgaXMgd2hlbiBwZW9wbGUgc3Rh
cnQgcmV2aWV3IGluIGVhcm5lc3QNCj4gYW5kIHdoaWxlIEkgaG9wZSBhdCBsZWFzdCBBQkkgd2lz
ZSB3ZSB3aWxsIG5vdCBuZWVkIHRvIG1ha2UgY2hhbmdlcyBpdCdzIGxpa2VseQ0KPiB0aGF0IHRo
ZXJlIHdpbGwgYmUgY29tbWVudHMgb24gd29yZGluZy4NCj4gDQo+IElmIHdlIGFyZSBzdXBlciBs
dWNreSB3ZSBjYW4gZmluaXNoIHVudGlsIGVuZCBvZiBuZXh0IHdlZWsgYnV0IG15IHByb2JsZW0g
aXMgSQ0KPiBjYW4ndCB3b3JrIG9uIHRoaXMgMTAwJSBvZiBteSB0aW1lLg0KPiANCkxldHMgdHJ5
LCBJIHNob3VsZCBiZSBhYmxlIHRvIGFkZHJlc3MgY29tbWVudHMgYW5kIHJvbGwgbmV4dCB2ZXJz
aW9uLg0K

