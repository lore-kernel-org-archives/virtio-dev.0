Return-Path: <virtio-dev-return-13329-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8301FEB64D9
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Jul 2023 13:05:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A2F772A830
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Jul 2023 13:05:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9D9EE986686
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Jul 2023 13:05:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8E9FA986491; Mon, 10 Jul 2023 13:05:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 77B2D986462;
	Mon, 10 Jul 2023 13:05:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EsXj4vhGHnJE2JFVrToHE95yZee8mBdIKspFNUGljfzqnLqbRWxZ+4nfAN5Yi/C4y5SbvDCOAGpl339g0ZXC+8gt2vDNtovvQXbWO5aZiZ6J1/pSaB9TgDEXM2I9R3eJbgAi1mSZF6S06A4b0DIjt+CSPYC3QBnEz55bk6B2LJR22tsXJS+F/0FIYzRsq1jtc/8fdzkc3tmqjBOTlsiafxRoll+p9uMD8SrMfrfTQ/jJYXIvebGxTr7Azx+ZdozluLECbwWrXL24eabIq1YejhkQbmmHBBmWpJmd4et0qCVypLEt4eenFKOiJawKIEaKx3ULksTIi6nTqbjPHUGRig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzxTCweW68j4/CRwieDhSv1Oyrw0k9iKdUlgp55FQ8s=;
 b=JROYbxf43QnuOQ7Yj59VUjLxDC6Y1q1PlSC3C/Bs6kG1q9s/Nu8nv3yFqbQPYoxG3n2ZYm/vifL1INpYCS0BgaFGrSNo0HJVE5HuDWXv4bm1BklZJLk4gEriBshO6ipK5qZt7b/9UR0qMViaFnFUJ/zCtB99ujdoXRiamJWu7YYtlrBIAp+gOr4Us6gNomHKQ8Ex/v1a4UHMjG8HWEtOcmF0pmvs8croKNDZJT51Pqs8Dx5Uopsj1vrKlauvJdUHdNiENNqrHS2nOxacbm/Dl5A1LRjyDxQzueDfUvl5P/fsiT0r0qf0BighqnHBAFpxdN5OH4a8IhEQENpvA7bnkQ==
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
Thread-Topic: [virtio-dev] [PATCH v13] admin: Add group member legacy register
 access commands
Thread-Index: AQHZsOgWDJbZS5QbLUum6ujYtKcWkq+xdcMAgAGGM8A=
Date: Mon, 10 Jul 2023 13:05:34 +0000
Message-ID:
 <PH0PR12MB54813BA69D6474462F413BD8DC30A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230707153019.147039-1-parav@nvidia.com>
 <20230709093550-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230709093550-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CH0PR12MB5075:EE_
x-ms-office365-filtering-correlation-id: fca118d8-e836-4267-e3b4-08db814658f3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 DDHXGdI9IIXXGuwrMncox6mCDYLb2BRebRBqzPMo5KU+pdS7xp3+KRCVkIqVb1JDnlavKmtORZDmTPdMPt3eyjD+y0NfxPuMADZeOnfmL5tr+NGRmEv3+D/PM0rCmZr0ZXcAOB11SjARRhINkZdv3ufJeePJNuoYIxBnHwheesXaofcg7rEhtvw2t08rAgHstNoOhqlwhp4rN5jYQ9rrdH1YUWoHFjw0dkXNfaZXDzoRTfSJxg8oPjvC6Nc6Tt93bnIIvW8snMpiWHlogf0zPjowsUCnPWIDbEtdAjtZJ7aJcURCc4IQsKzFq+tpLfBw+BrbtyS7lQzgvxvLxv/nLzNoBK9JJjF4TIBMaC1siyBdFQK+902eRYIqnLofe2SP+LAGB/6fRiYTvfIBGjNIgpca7LLA981YkgiFMwmfq2nSQQhyecBAEJxIXFfJIeQ3D9I+SvuNLSmYqx7tUpfMZbVSjtFphjY1rAJX028Q4HjOvNqFAsn04UQSU/vg1J61TH7Q1J/xXaLNP44ySx4upQGSAfCmWWZFKdocu6UOBCywcPt8JIS1zUev1hiXBC/77BRbg/5dOzLYSTADltLwSKhB3yVvw5m6KJF0AUlhtAhCDLyOgxxTbPpSMm1NI2ET
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(451199021)(86362001)(38100700002)(38070700005)(33656002)(71200400001)(55016003)(7696005)(54906003)(76116006)(122000001)(107886003)(26005)(6506007)(9686003)(186003)(5660300002)(52536014)(2906002)(66556008)(316002)(478600001)(66946007)(8936002)(66476007)(8676002)(83380400001)(4326008)(6916009)(64756008)(66446008)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TXEvNFlMcXMxZlFtN1NnQW9iK3JLNDcyZ3ByZGxraDVlZkRUUWJJQlp5WjNp?=
 =?utf-8?B?TjFqRDhnWG96dkJIWGc3S0VVcll6WU1MOVcveE5ZNURQaHM3eEZZd1c5dzNF?=
 =?utf-8?B?YTVtMmZHMGxzaUQrcmZTazFYeUszVnY0Y1E0RnlLd29ZcERSMVJGMUl0dE5o?=
 =?utf-8?B?TlpQdDRXaVJzTzA0M0djYUYwVnVBTUJTMVdWc2F0OW1JbjludC9ZSGRsemk3?=
 =?utf-8?B?bld1SlNGbWp5anFCdXVSYldEaWZ1UlRnQS8yNGhEK2owVDA1OGdMYmo3cEFj?=
 =?utf-8?B?eWpEWVN0M1greDlRbGplQ3dKU05rZmFKRHlmakV4MEU3KzdzM2gyaC9zRXVG?=
 =?utf-8?B?SnArcVZZbk5KQ0dQMHRIQmJ2MnJCNDVnUEI5bGtqekhyWTlGUzNZZ3NKSVN1?=
 =?utf-8?B?VHpWblI3VVFSWmR3OWJaMlZ5SzNtRWFVSVEzZCtwUjZDaUlpdmdyNCtFUlhw?=
 =?utf-8?B?RUhybzlkR1JWNEpSQ1Z0UHJLZ08xSlNQQkp4b2RQSkdxZEFaTUFGcFFEYzRk?=
 =?utf-8?B?bzBlS3A5REk1UDZPeUxGcnFwRlFmUDRybkNBQ3YwYVZuQk50c0l2ZlJiS29X?=
 =?utf-8?B?b3l1T3FUT005L2h1QWszU1ppWFRweWdXQTNzemIxZlRKbWp0ZnV3djVYYWs3?=
 =?utf-8?B?am5zd0RCVlZGUHZoQmp2VkFaL2IvQzBaU3Q2Z0RwbFNreXVGYlZ1VGJYeUJp?=
 =?utf-8?B?TDVBczJjVUllQlZ4NytFZ203b2VpM3VxRENPVE1IeHJ2WHpnMjVSZWRoUUtp?=
 =?utf-8?B?UWpldUJPbWd4RGhXZkNCblRLVnZlTDVReE1NRFIvKzV3K2RnMmtLNWRrYTFO?=
 =?utf-8?B?S0dQbW5vNFFIejBqMGkvWXVJTWh2WFVZYXFGYVVaMWZRQVoySXBHRjRZRWlW?=
 =?utf-8?B?cm9SMW5sekordk9QWnkxZzRwbXlrOXlzRG9lb0RtU3EySzZQblRwRWErZ2dl?=
 =?utf-8?B?MS94N0c2L2NhM2dzLzVIRXQ1YlpmNldtZVFtYmc1U0RCeHNKWkliYXU4eE1p?=
 =?utf-8?B?WXNIU2pHSDRZdXR1anM1cFV4NWEycHp0dHVwWXNBdmdiQW5aKzhhMVU1VXZC?=
 =?utf-8?B?bjdtM2MwTnBLaXZtS1dRV1QwbFVRSmVEeDFOL0tNRG1ia0RlZXQxTzJ0YnEy?=
 =?utf-8?B?VmhVZm41ZDNhMzJ6cURjL0cvREw2OWVtNmdVSkp1QjVyRXV5L084UjJqdXNM?=
 =?utf-8?B?YzhtQWNZUHFQNDVkRXk5eEt0bWt3R24rSXp4TW1IcStEck0yY2R5R01Pc1Vw?=
 =?utf-8?B?VnFGWlk2OS9oZk9yKzJkVnM5VmVqU1VkY1haTXFFQWVaT25iOHNIak1XRDkz?=
 =?utf-8?B?bnJhK0xSQVNMcVZSQzJXTmFJa3A2UDFEcTdyazZYV0s2OGhyMmNVUzkrQ3Qy?=
 =?utf-8?B?Y1F3TTVaNms5NytKV3hGOWx1NWhnR25BUGJvZ3l3VElRaVVtaDMxL1FOMFVs?=
 =?utf-8?B?aUgwWkxFNHdWaXprOGYxYjNhajR0cnY0MkU1VWk3Mkx3dGtwZUVFdlE1U2NI?=
 =?utf-8?B?N2lxdlZMVk53dUZOQ2NTZEE1bzlvWHM0eUFkOTJDdDBGTjdQeXVGTVM1ZHUx?=
 =?utf-8?B?Z085WHRGM1dvREhWVGwyZWI2OHhkbUFIMXVaTEVtN2M3MzhuaXpnZjRSRUMw?=
 =?utf-8?B?cUF4OW1oQ0h3NWJjaFN0Uzd3Rjlid1RZcjA1d0xvYVdQYlRWeWFsQjFkcU0r?=
 =?utf-8?B?RUxhdzd5OVNpbm42L3pLVlBXUkJpcmZ6a3U1UEFsYVBOblA3cENqRU0rYU9w?=
 =?utf-8?B?ellFb201NmNFMkljRlh6SXdUQnRvS28zeTAvb09uVEFiZzE3UllFRkRqT2Fr?=
 =?utf-8?B?Ui9CbDY1RWdiZnN6VjRYZzhsZ1FtN0EvREt6RzZUbnhyNnlueFdsYU93ZUNN?=
 =?utf-8?B?eDNsVmtpelFJeVpLMVVlVSttWS9jWldTVVFqSTZ5dzlGTkhUMTRVVWswVTJ0?=
 =?utf-8?B?VzRzU1FNWHZMV0Z3cXdtRnU5VVdjQ0lsY0h1bjgxcktMenhsSkFnSWZnQ0ZC?=
 =?utf-8?B?QzFVNzYvSng4Wno2bnFyb0Zxdk14WTJHYllzdng2eDlvM1RDUENvOGcxZUI2?=
 =?utf-8?B?SW4rNHdGd1doUkZ6ZENaZmZDNnU1Tk5va1dCQ09vMTFxMjBrZ3BuZ1JtakM5?=
 =?utf-8?Q?T8D4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fca118d8-e836-4267-e3b4-08db814658f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2023 13:05:34.2752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 91gNU5VNCQWaIc+rvDZfPbUc5ZBGn6cU8AvlKmBn4ZY5PkEvsJW1zAvpfgI62E/xFO4odF2vJ6Jt037Tn2SGEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5075
Subject: RE: [virtio-dev] [PATCH v13] admin: Add group member legacy register
 access commands

DQo+IEZyb206IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+IFNlbnQ6IFN1
bmRheSwgSnVseSA5LCAyMDIzIDk6NDcgQU0NCg0KDQo+ID4gK0lmIHdpdGhpbiBcZmllbGR7c3Ry
dWN0IHZpcnRpb19hZG1pbl9jbWRfbGVnYWN5X25vdGlmeV9pbmZvX3Jlc3VsdH0NCj4gPiArcmV0
dXJuZWQgYnkgVklSVElPX0FETUlOX0NNRF9MRUdBQ1lfTk9USUZZX0lORk8sIHRoZSBcZmllbGR7
ZmxhZ3N9DQo+ID4gK3ZhbHVlIGZvciBhIHNwZWNpZmljIFxmaWVsZHtzdHJ1Y3QgdmlydGlvX3Bj
aV9sZWdhY3lfbm90aWZ5X2luZm99DQo+ID4gK2VudHJ5IGlzIDB4MCwgdGhlIGRyaXZlciBNVVNU
IGlnbm9yZSB0aGlzIGVudHJ5IGFuZCBhbGwgdGhlIGZvbGxvd2luZw0KPiA+ICtcZmllbGR7ZW50
cmllc30uIA0KDQpQbGVhc2Ugc2VlIGFib3ZlLCBpdCBhcHBlYXJzIHRvIG1lIHRoYXQgaXQgY292
ZXJzIHdoYXQgeW91IGFza2VkIGZvciwgbm8/DQpXaGF0IGlzIG1pc3Npbmc/DQoNCj4gVGhlIGRy
aXZlciBNVVNUIGFkZGl0aW9uYWxseSB2YWxpZGF0ZSwgZm9yIGVhY2gNCj4gPiArZW50cnksIHRo
YXQgXGJlZ2lue2l0ZW1pemV9IFxpdGVtIHRoZSBcZmllbGR7ZmxhZ3N9IGlzIGVpdGhlciAweDAs
DQo+ID4gKzB4MSBvciAweDIgXGl0ZW0gdGhlIFxmaWVsZHtiYXJ9IGNvcnJlc3BvbmRzIHRvIGEg
dmFsaWQgQkFSIG9mIGVpdGhlcg0KPiA+ICt0aGUgb3duZXIgb3IgdGhlIG1lbWJlciBkZXZpY2Us
IGRlcGVuZGluZyBvbiB0aGUgXGZpZWxke2ZsYWdzfSBcaXRlbQ0KPiA+ICt0aGUgXGZpZWxke29m
ZnNldH0gaXMgMi1ieXRlIGFsaWduZWQgYW5kIGNvcnJlc3BvbmRzIHRvIGFuIGFkZHJlc3MNCj4g
PiArd2l0aGluIHRoZSBCQVIgc3BlY2lmaWVkIGJ5IHRoZSBcZmllbGR7YmFyfSBvbiBcZmllbGR7
ZmxhZ3N9DQo+ID4gK1xlbmR7aXRlbWl6ZX0sIGFueSBlbnRyeSB3aGljaCBkb2VzIG5vdCBtZWV0
IHRoZXNlIGNvbnN0cmFpbnRzIE1VU1QNCj4gPiArYmUgaWdub3JlZCBieSB0aGUgZHJpdmVyLg0K
PiANCj4gV2FpdCBhIHNlY29uZC4NCj4gLSBlbmQgb2YgbGlzdCBub3QgZG9jdW1lbnRlZCAtIHdl
IHdhbnQgY29uZm9ybWFuY2Ugc3RhdGVtZW50cw0KPiAtIGZvciBlbmQgb2YgbGlzdCBJIGFtIGd1
ZXNzaW5nIG90aGVyIGZpZWxkcyBkbyBub3QgbWF0dGVyDQo+IC0gZW50cmllcyBhZnRlciBlbmQg
b2YgbGlzdCBhbHNvIGRvIG5vdCBtYXR0ZXI/DQoNCkkgcmVyZWFkIHRoZSBhYm92ZSBkcml2ZXIg
Y29uZm9ybWFuY2Ugc3RhdGVtZW50Lg0KSXQgYWxyZWFkeSBpbmRpY2F0ZXMgd2hhdCB5b3UgYXNr
ZWQuDQo=

