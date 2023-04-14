Return-Path: <virtio-dev-return-12226-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B0AC77B61
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 03:22:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 191C229FFE
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 03:22:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 07129986617
	for <virtio-dev@archiver.kernel.org>; Fri, 14 Apr 2023 03:22:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id ECDB4983D9C; Fri, 14 Apr 2023 03:22:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D971B986600;
	Fri, 14 Apr 2023 03:22:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMvpNrQrpnlrIzEQqIbb645YNZ2cJH1WvkJpfMJP05l4SWOfYKj9ljOIMPiIvR+SQlt26G+hgLsRU15TMEdG5oMK7HrLMi0UqPEmyX+lfWjHivkhRcRuUjk0lPFYTzFtHLIQz4Uevg2NSoZdmmw6SyGRkYE51MZiVsqL7H477E4nmEhKQrQGl2n60+QDvUkj84YRnOj0rrsd2TH8vdZzNgevsvvDqTHWPQVqaonAnVCMQpH7/Q4FNLoAPxBp2STMW7SU8vFJHwMR2fbLl8r+Nt15YbF18o1tc+3HAGIr7qy8CZTijJ3GDFGKstRXvu9TECAItIvv+/huQsKrIxWMDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VseNuDk42AAyeVXzC5WzC5Zcw7xBXGrNiacgbejP+cU=;
 b=FzW4oyacINnLWyej8G9glOAreepTzgTEqVv3Vb71DXAVSXP6Y1VGI0pG4GN+5krfZrS26+XjQsqRaQ0f0NV2n/hYeZG4sDw6kyFYAAkN3etAzabYboC0QVcCOE4ZwYozIAFE+cF7OZuEdVZHUlW2KVCR7pNDdCv2aOH/OpxUQ0CFqEtYOaXtWzGp6R4bF1buRgjKeklwXrjYYhUxi3HwRUIpe6GtPhbv25+L3iElfUa6acZedszYDMyTu9nqOiTP3tEUnyD+pQ1yhYEsK/vOJXML2Zzv1h4mH4/kKtlPJ6pF8pYFBhBIg7d7PdNV2qtWB2o3rQWRSlsk3Jzxvq6XZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>, Yan Vugenfirer <yan@daynix.com>
Thread-Topic: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers
Thread-Index:
 AQHZY1tLAUtRpuZtUUOucQPGJlFfkK8flpUAgAQ7nwCAAE6hgIAAAXwAgAAFegCAAAt0AIAALl6AgAEOIwCAAFEgAIAAIPWAgAAcJ4CAASFtgIAABJ4AgAAKJYCAAACFsIAABgyAgAAAT3CAAAYpAIAAAJIAgAAJz4CAAILBcIAAxPiAgAAc1wCAABy4gIAAzAAAgACjPgCAAADPkIAAAecAgAAAUWA=
Date: Fri, 14 Apr 2023 03:22:25 +0000
Message-ID:
 <PH0PR12MB5481EB1D036BCF7404CAA7FCDC999@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230410020906-mutt-send-email-mst@kernel.org>
 <CACGkMEufWUXHKahg3GLOKfV5aptbiek_DKwy+7rCfMya2GPaTQ@mail.gmail.com>
 <20230412000802-mutt-send-email-mst@kernel.org>
 <CACGkMEshNydwBD=Q0JW-SDY6xyiJ4uVrLn+pxbUrinycBKwsrw@mail.gmail.com>
 <PH0PR12MB548118F57BB4B4A4F8DC9D7ADC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvYsz1fSPG+fKpRaZ05Ut7ffKwvMPvR8xbRBsXA_6vGQw@mail.gmail.com>
 <PH0PR12MB548137D7A25C99EAA42B4D12DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshW82qztmGw8YJWJ8=QCoRd6cPxQ+ySazxsO_o+U6c4Q@mail.gmail.com>
 <PH0PR12MB548147CF939CB9C2A0586310DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu2B_GogDR9HUwB7mT8fkGh+Q_buPLz4nhwhK7h9k6BQQ@mail.gmail.com>
 <PH0PR12MB5481F0CF5A555A6BB2CE856CDC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuNOYOxvcSzrs0UFEyk+xOkGUpOfhK8rOy_Mebz5b5wdg@mail.gmail.com>
 <a74d3107-d38c-df15-e2ff-f848635f24bd@nvidia.com>
 <CACGkMEt+bGN7UYEopXPj0+deAnYm1VUNp05VvGHcJnkd8LzbGg@mail.gmail.com>
 <f9f01f9d-f6ec-0daa-a11d-c75589dcbe6c@nvidia.com>
 <CACGkMEskPJgNrBQV10ieSaKCg_kBbi2E0z1BEbdyiiaDdD1zJA@mail.gmail.com>
 <PH0PR12MB54815F0A67A14691CA64D2B4DC999@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsYYQTMdhPy2oVoP=2B9jcK+OJ_TPHqdEsip_pjZvyiOA@mail.gmail.com>
In-Reply-To:
 <CACGkMEsYYQTMdhPy2oVoP=2B9jcK+OJ_TPHqdEsip_pjZvyiOA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH7PR12MB6859:EE_
x-ms-office365-filtering-correlation-id: 7dd93a42-6b5f-402c-be83-08db3c977829
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 VlvgWCA2dJ4/lmeYNcV2egBm2Oxlne0kom7w+SA4ntxCObQbJXuis9ixzmEGvHbyfXzlbnLOPp02k+KM4EwnlSNWYaZbgMFqa254akrMX2mHrcyT4dZP+Lkj4TSrzPorvuYqoWZ6K+m0p3GG2lSKC3I2K8Y9OTQhQxwPeX2RTDSi1uR4z4doDkLjmmg6MWv8NPs+WYIZT1q4Dqx1kvHkgv9l1CHIvCu/NEgeXn/TFFdao9rbGBXHH3Uwld2yiFf08V/0p5cXvGX/1mf1MFTafaPh/Bjmok4G54vZdn1C6MXcFsXO7On/u9w6iht4lyT3vWLJhYjirwj04degZdVk5ZicUrYUzxOGbcjk0yw5b+6kPH7LBjS+asF6qu9TWFYpHCMA0PBwykEmupmC+V0nMB5LSniIHpX9+YpExwV3IdzxujzlWS3Z1KNe8cpVt4vkZPyoEJzAZQBBGXVNcS2eNF2TPW9r9ngOvMcLCmwFUxOgT+w1HNPyb+vyY7Mx0E8edaZ2E58wRPvw9/3pHQOtAAd1E3IVhEr2O2ULWR52BLyrm9yMGRVEY87eNSxKohlEumwfam1TJ1f5wpFMhF0j4fzsIOV7grrUo32HL0R0t8aDcdR2+gO3g6hSIFho3YMR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(366004)(39860400002)(396003)(376002)(346002)(451199021)(122000001)(4744005)(2906002)(38100700002)(5660300002)(8936002)(52536014)(8676002)(33656002)(86362001)(38070700005)(55016003)(7696005)(83380400001)(71200400001)(186003)(316002)(54906003)(478600001)(9686003)(6506007)(26005)(41300700001)(66946007)(66446008)(66476007)(76116006)(4326008)(6916009)(66556008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?alJsNUpXY013MTR2OG5WQUNvaDMxNi92bFZLRWtPNjBYd2p1WHdqRmJuY2pL?=
 =?utf-8?B?cmRxWXIrYjZZWjdoZXViL0hELzFoaXVrcEdDMUYwQ0VEUXAxaUVtRkJvS1Nm?=
 =?utf-8?B?RWRZSHBPYUFmdi96dU05NjlUM1VJN0lhSWc4dFVOd2prZ0ttdC93dUhhVzJK?=
 =?utf-8?B?d0Nsam9yZEJKeVRFeDA5TTNnTmV4MzluSlRjUHZXb3EyM1cwQ2NHN0hDell4?=
 =?utf-8?B?Ykh2WkNqWHNEUnBKdDJVa2toSHUweWlZSkxoSmtiNmFiL3lNR0dTSDByb0Zs?=
 =?utf-8?B?TzBJaWpyZUtzQ3REMVZuOFNHZktiRnAzQ3dRV1VQL0RDVTQrUlJrVys1N3hy?=
 =?utf-8?B?dUE2eEF5WVRzSGsvaHJJZnRQWnFuWmthQUJCMHZTT3RwcUltZUhrV1Z4WVFK?=
 =?utf-8?B?T3E3TUphM1IrYTcyUWRBVml5UDh4UG1xdWxoZWprN3N1d1ZOTzU1QU51YjVD?=
 =?utf-8?B?SFZTZE1QYVVpOVFiQzY5aFZwVGFlYjdTalNua2dQK1IvdHNCL1dTV3ZVQ3Ay?=
 =?utf-8?B?UWwrd25oN0NERjRVNVZJK2FrRE55UWpNQkZQVk5hS3ZFS3k1Nk4vTE45ZXpM?=
 =?utf-8?B?SWpGTW9jbXIvNmpVTTRMYXBYNWF0TlZpaURtSllzTGJZZVF0RFEyamwxbExW?=
 =?utf-8?B?Q2NFSjI0WlF1Y3gwaGxlWDBQQlN6Qlh3ZnE2SUNPQjhlZWFMYjBtSVAxTElH?=
 =?utf-8?B?ZHhlQ3hkb3lka2Z6MkFIbnByTG92VzJ5NGVHRFduRmROZTlrUFhnWFBGZDZy?=
 =?utf-8?B?TmtXc2VHM2o3M01mbUF6MlBKTDI3emRqT0QwRGlXY0hpdWZCeHhkRWJmVDNP?=
 =?utf-8?B?UzIwOUU0UTRrSXFkb0NRZHFoRW9jT1J2ZWxmVjZmaVlOQkpvdWVUeVA5dVlh?=
 =?utf-8?B?ZTlhRFA2VVBwaUtEMXNzTk9tNi9VY0orbnRyeXBQTHBKT2t4M045MWtPOW92?=
 =?utf-8?B?WDN5WGh0WHNNSkxCSEVwaklweG5DMnUrNnZsZEVMWlZlMVRvaEgzZGxVRlNv?=
 =?utf-8?B?MDR1b0RNV3FkcVg0UlFRcHluRWc2N3VabXZNK29ac0ZqYVFMRGJvcFZDSFc1?=
 =?utf-8?B?dVNjYzZwc09UWmFLZDZpbnBuVy9zWVRmSXc1K25JbFdkekFvSWdwcm80Z3Nm?=
 =?utf-8?B?SW1tTGVZN1hKTTRNejZjY3Y3WlI2U3Q3RXFOYnV1RVkwREt5ejd3UjBpblMr?=
 =?utf-8?B?a1p4QUNhSmZ2cU9mTHp6NjFCUWFXbytTRW1RZzhFazk4OFJlM1RhUmExbFly?=
 =?utf-8?B?OWVTYWpYdXd5WDlobzROdkpodXRXc0lDSURUL3N0bWRSK2VUMm5hK044eThi?=
 =?utf-8?B?Q3QwMkp5amErRHQzcko1aVFJdDFBTW5KWWtMbThDTVlBSm4vUnEvRDV4SDJp?=
 =?utf-8?B?RzhyT2hFM09QaWYwREhGNkRCT2xoL3lEcjhoK0ZXQms5TDMvWVhxUmJ4LzZU?=
 =?utf-8?B?OU1heEoxbnFvU1Y0SWczVzIzc2t6aTcwTkZZNW5UL2FWN3E3RWRyWThJN1FH?=
 =?utf-8?B?SEdIdmZJTGNPT0tRVnFuTU00ZFhzTDViTW15UEhKcURpYjErQXdkbTZ1UkFl?=
 =?utf-8?B?UEUvSmNQZkw0OUVMVERINVRmYXdrL2VUWEhyTnBKMHZROEFZZ3FrR0ZsYUw2?=
 =?utf-8?B?N0ZSUXZCK3FXd29WVm9zcWNOSkdNWkZSZTR4Vk1UZVN2V3c3WkZHSm9wNlhk?=
 =?utf-8?B?S3JaYjNvR01DdGRTZXc1WjR0OGd2UUdwTGFBbGV5NEQwelR4bzNrZ3B0b21r?=
 =?utf-8?B?b1pjaXFwQW9vNUlPNVFjZzZ0Y2FVYm9pTmNIdlpPL1hHaWIycmFwa1ZoVy9i?=
 =?utf-8?B?WTBxRFZpT3IzclliZ0Y5aWt3ck1sMTlYK3FleUlTZ0g5TzhIZFZxQm9tVjZz?=
 =?utf-8?B?UkVWcHcxZTRLWkxzdnFlSDdzSUU1b1M4a3VQOVNCbWpkRC9Ccmx0Z1Q2WEto?=
 =?utf-8?B?c2dNR3JlWWlUNElKdGhOU1ZtUEI3K2xCanlmcVdoMml2cXFGZWxZU2Q0c3Vy?=
 =?utf-8?B?ZGcydlF4TDlRRitUQXY4WVg5c1VhQnZMeG4wY3l6UThzSjV4SlcrTStXMk9r?=
 =?utf-8?B?TS9Fd251NGNXakJzN2xEQ3UyNEhDNytndWhFWWoyQWdQWGZtSytqWXEzVVh5?=
 =?utf-8?Q?apP4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dd93a42-6b5f-402c-be83-08db3c977829
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2023 03:22:25.6586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8ogbzKOZRGABAvdzt3xass1EZJhsoV/mu1iW+q23hehUf5f2EcXCsZwNpw7iG+s0TkSIJ4H3jnr524dkfX/m5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6859
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIEFwcmlsIDEzLCAyMDIzIDExOjE4IFBNDQoNCj4gPiA+DQo+ID4gPiBJdCdzIGEgbXVz
dCBmb3IgQUJJIGFuZCBtaWdyYXRpb24gY29tcGF0aWJpbGl0eToNCj4gPiA+DQo+ID4gPiAxKSBU
aGUgb2Zmc2V0IGlzIG5vdCBuZWNlc3NhcmlseSBhIHBhZ2UgYm91bmRhcnkNCj4gPiA+IDIpIFRo
ZSBsZW5ndGggaXMgbm90IG5lY2Vzc2FyaWx5IHRpbWVzIG9mIGEgUEFHRV9TSVpFDQo+ID4gPiAz
KSBQQUdFX1NJWkUgdmFyaWVzIGFtb25nIGRpZmZlcmVudCBhcmNocw0KPiA+ID4gNCkgVHdvIHZl
bmRvcnMgbWF5IGhhdmUgdHdvIGRpZmZlcmVudCBsYXlvdXQgZm9yIHRoZSBzdHJ1Y3R1cmUNCj4g
Pg0KPiA+IE1pZ3JhdGlvbiBjb21wYXRpYmlsaXR5IGNoZWNrIGFuZCBkZXZpY2UgY29tcG9zaXRp
b24gd29yayB3aWxsIHN0YXJ0IGZvcg0KPiByZWd1bGFyIFBDSSBWRiBpbiB2aXJ0aW8uDQo+ID4g
VHdvIHZlbmRvcnMgd2lsbCBoYWQgc29tZSBsZXZlbCBvZiBwcm9ncmFtbWFiaWxpdHkgYXMgd2Vs
bCB0byBtYWtlIHRoaXMNCj4gaGFwcGVuLg0KPiA+IEl0IGlzIG9ydGhvZ29uYWwgdG9waWMuDQo+
IA0KPiBBY3R1YWxseSBub3QsIGhhdmluZyBuZXcgYmxvY2tlcnMgZm9yIGxpdmUgbWlncmF0aW9u
IHdpbGwgY29tcGxpY2F0ZSB0aGUgc29sdXRpb24NCj4gaW4gdGhlIGZ1dHVyZS4NCj4gDQpJdCBp
cyBub3QgYSBibG9ja2VyLCBpdHMganVzdCBhbm90aGVyIGZsZXhpYmxlIGZpZWxkIHRoYXQgaHcg
dmVuZG9ycyB3aWxsIGFsaWduIHRvIGEgY29tbW9uIHdheSB0byBjb25maWd1cmUuDQoNCkp1c3Qg
dG8gbWFrZSBzdXJlIHRoaXMgaXMgdGhlIEJBUjAgc2l6ZSwgcmlnaHQ/DQoNCj4gQW5kIDEpIDIp
IDMpIGNhbiBoYXBwZW4gZXZlbiBpZiB3ZSBkb24ndCBjYXJlIGFib3V0IG1pZ3JhdGlvbiBjb21w
YXRpYmlsaXR5LA0KPiBubz8NCg0KSSBndWVzcyBvbmUgd2UgaGF2ZSBzcGVjIGRlZmluaXRpb24s
IGl0IHdvbnQgYmUgYSBwcm9ibGVtLg0K

