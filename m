Return-Path: <virtio-dev-return-12876-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E8AC7EE45
	for <virtio-dev@archiver.kernel.org>; Wed,  7 Jun 2023 03:05:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D5E9723D59
	for <virtio-dev@archiver.kernel.org>; Wed,  7 Jun 2023 03:05:53 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C0B1498664F
	for <virtio-dev@archiver.kernel.org>; Wed,  7 Jun 2023 03:05:53 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B133998381B; Wed,  7 Jun 2023 03:05:53 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9AC57986603;
	Wed,  7 Jun 2023 03:05:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hW+c09af0PKHztJHhms4r59U99VfMzVe4pgtWAZzYrliEL4YdChRLVTCH3tLZIYIYi/O7VubSN9Ee1RYpfGrs3NLkBR486AYO4zRf06NIlcZElZCpcxbFl5rsH5WOAl8b4ZEtxoF64sTCjL79BgwfXxbbZFqino8UX3k+uzTtg/bVkHMmZMBqFeLV2vprWPMhp0O+qBD6580nkyYVhDseeu72EV7H0AqaLRcUHSbQifH1zshXR3DKTBmj/fv2Kn10qLsnMKYQ65PoUmPWaRUzSXCM7F1ehWFavIQ8NSroTO8se4luZzn4y8MadNF6pkwNHTDec6Z/2u0caL/jxPN3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4GCneo6v0Ez8Ll4mNg2CNPcu+fnEEznKPn7dOZc2Sk=;
 b=VEVKwWlCr50qM3pFa3Kmh/D2vvsaeCXIU9YEuLhYBKHKioT6hjNqKVnpelrNSOavup5ytmDSBGDZTldGbaX7vcF8el9fdkRIWpmpk/FmEfdOD0k/BNMO03QOKOE3OF83ifQe+gl55IoCp0tA5ESkyELmqR/LgtorHWUBUaCgQxziUwW9qPMJ131vcRorJR0HwBsU6ldqw+s5ocQOjDtAvGXPmXIx9N4xAJPkmru/AO9cw66yKK5+OyiUUUPn6fV60IDEFxUssmv/uouKTQN4SuHHxGndjSPIJ75GKuIGlXcyYuFH7SCRIg9yjHOUAqmyD4NG4lJwSUeLUCFP01wNuQ==
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
Thread-Topic: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy
 registers access using AQ
Thread-Index:
 AQHZlZHqSKW+Shm580CRlUjcCTH7qK96p2iAgAAAjkCAAAV4gIAAAhyAgAAFe4CAAALHYIAABcIAgAAChLCAAHFxgIAAHa6ggABpWICAAHwV4IAACZWAgAAiwLCAAGU9gIAAAqIggADn3oCAAPNNAIAACTvQ
Date: Wed, 7 Jun 2023 03:05:41 +0000
Message-ID:
 <PH0PR12MB5481D80A48F3BD82D86B3DB0DC53A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230604105027-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B721C34D85D63FCC1F3DDC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230604174224-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481DABA25CA36A5460B13E5DC4CA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605014539-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481C14D65D5E10CD23A9F67DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605092859-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CEB3A34AAB49A282F2A8DC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230605174755-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548180E16376862A3C0DFF1DDC4DA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230606073544-mutt-send-email-mst@kernel.org>
 <CACGkMEv1so_KGwJZG3GnAf=JNky7+BMNK7N4NTtucDS+WyW5VA@mail.gmail.com>
In-Reply-To:
 <CACGkMEv1so_KGwJZG3GnAf=JNky7+BMNK7N4NTtucDS+WyW5VA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB8497:EE_
x-ms-office365-filtering-correlation-id: f2ca00b3-65a6-40d1-536a-08db670413db
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 0YMA8U3yk2jnAi7W4e+/4tJonQbwiYzDO22oDQIPavGwLVLHYj5pDg/o4/hCDPe6n2HqdGF5/euagqQ+KL1yj7cV7W7H8a1k26WogLFx0X+kb/pXEgVnmZAsWgpUVPSlIwPDRJN+FLxLi1GdBtDRkIrYaTktwX6LAwj3UgmK82GmaFvJxD2uKu3fp2vF69kyjSMaqIhcS9Ch6Foje70CmZoi12uWB7juYJd2Rt6uEreN1z5O7r6zbFsoj9Njbkx6eghENQ8p1UoEJ3EkuzVJduI8taaYHCEsb0TCA2qyu23RTF4uQ1My5OQCg+VV5ynbS7Anyz51cuX5Zja1v+jkadjfaDZzxwcPFNFY2Dkq3cEviP4xGyjhx1h4DrQP1rH2zAf5YNKZlOaLdAbqkVTDgLrxQXuOFIGqWikyE9Ln3SZMAuPvAiq9M0ShOSYTSkl1cgESEUdXLHpa4xWAGpWo9pTE+lzVTW8WyYrlCG3Ch06Ysy+3uXyMryej9p+1DQz1tzlUhu5nmquTzB+r5L+cSAqz9EcN1FEMD09xQl4A6RYdK6ClQU3A8dpv5EMkE52c/GMH1UEhnDhUw/lUPzVOAvd6LcSywUlmvNPA9SPmWcTLP2xoqDE7JEZhY9jN6MJHx+XOIDiuFDYwPBKHEx98uHM6uQbShY7B5jsN8dzz9dk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(396003)(39860400002)(136003)(366004)(451199021)(71200400001)(966005)(7696005)(83380400001)(55016003)(33656002)(86362001)(38070700005)(122000001)(38100700002)(6506007)(9686003)(26005)(107886003)(186003)(8936002)(5660300002)(8676002)(41300700001)(316002)(52536014)(2906002)(4744005)(110136005)(54906003)(478600001)(66946007)(76116006)(64756008)(4326008)(66446008)(66476007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cUhzUXFFWjVFNjh0ZXo5LzZlYXJoZnVteVdaUnBpY3RETFJyWlV0OUpjU2NU?=
 =?utf-8?B?VWV6UVJlL05DY2ZLR2hiWnFuem95OEtBZmpCNG85Z2JXZmdYRFUvbFpFeHFX?=
 =?utf-8?B?TXQrWWM5K29Oc3Rhb3lTNldhNm1USkNKM2dCUEI2bXVIVjcyMUxhZ21nelZk?=
 =?utf-8?B?dm5QWGR0MUlGUERUZVJFZWdTc3M2MkdPaTN3emRWQlozWnd0WXAybmpPSjJx?=
 =?utf-8?B?Y0lsWmZPY09ZZ0lCekMvLzQycUl0cXI0S3pjbER5b1VIQzlCOVBwZ1hib2VG?=
 =?utf-8?B?QmI4SjlDc0hzRzlEZGd5TDgzcnJJUWhIOVZ4dGhmNDBpeFpuU0VLS1d1RE82?=
 =?utf-8?B?OFZleGlvRkY4WC8xa1dUa1p5ZXI1WUFKMGdXMGxhTVF2c3Q4L2FEUkplTS9P?=
 =?utf-8?B?MmNvSkdFVk1pclJTTklDZW9ybFBtLzVVUmtYR0xsS1l0dkZlTEJ1cC95d0FZ?=
 =?utf-8?B?cU9JcUN4b1BlaVdXTWxlKzFKclN3ZjF3VG9uekNPWGhFWjB0aDQ3QXU3M3dM?=
 =?utf-8?B?Nnl0cDVyVEZZaDBleGF4eEZZT1VHN0FKWWhEeENjc0tkNUZrUStzVW5mbkFy?=
 =?utf-8?B?anNtSk1hZE5leEFOdzFxM2FGSkJoc1liN1pCNmtCQkE0TTc0cnFKcnljNFVq?=
 =?utf-8?B?VTRNMzhDQjErbWZlcEhmRDZRVjZmUW9yMjNicm56a0l2V3FBekFhZDdIU2M3?=
 =?utf-8?B?TW5UTkhsbEhnU1hiSEcrZGhUN0RuY3ZSVUZWY1ZiWVRKQzRHZXhUdUU3RmtB?=
 =?utf-8?B?OWxhaXVFN3FwbTE1TXpBYkovZWZ4R1IwUTdRdldHaUhNUDk2QnpMdllkOVVU?=
 =?utf-8?B?OEFJUFNaN0JiU2R6VzNmbTFYdjgyUm5xTTFDWENDOEFkL0FoYkRoalYyS2hX?=
 =?utf-8?B?U1N3eE5sUDBacTJWTUNTYXdTV0pKNEZrbTdLbGl4K1ZvaVFSMWpTOUVMdXEx?=
 =?utf-8?B?K3g3OElrcVpIS3R2cWwyNW9CTFdlSGhUOHI1SHVoNk9JUEtmTU9LWWV5ZFRI?=
 =?utf-8?B?cmVvV1hEWCtmNmd3RmhtN3V3U2ZDTDNONjFRNlBmSG03YWVQakxxY1NwNlA1?=
 =?utf-8?B?emxKNkR6QjUyYXlsY2x4N3huOElRYzYxVVhMS2x0TXZzQVlabnMrSnoyMlQ3?=
 =?utf-8?B?djRVa08xenAvQnNXNDhjS0R3Z0ZodC9KblZjWmNUWmFaRVB6SC9qaS9TRmN0?=
 =?utf-8?B?dFpjQkRkc3pzNzJ5QjVKTGhJUGZUTElEOFdWaDhVbXZZcENJbVU0cXBNYzNq?=
 =?utf-8?B?QUcrYVhEaEpsemFIOHRUdWNPNVVnZmZpYWNnc0JrS1NVLzNiRk1KVStCVGg5?=
 =?utf-8?B?WDdDdExUcnh4ZUN4aTE4Tm15UlRIbXhLNWtmVDdaYmZYTVRXdEJqQWgwa3ls?=
 =?utf-8?B?TDNJdU40dkNuazZJWHVrS3dRQUNPZkkzYVRtZ25WRERUUEZpeXNCWDNSUDhw?=
 =?utf-8?B?ZGJDYVB5WkNLUjVkaVlvTEJ2b3J3cEh0RDhjaW1WM21JSktTOHdSb2Z5WlpR?=
 =?utf-8?B?UWJnNHNUc3hUcUs3UjI5VHhXcEgrbm04aitzd3M3UW9NdEQ0S1hNUitLRldK?=
 =?utf-8?B?MllUbVRUM2RNZzhlVENvRnltNlRXQkM0MTBzV0NLeWpHOWoyK3pTM2RuRXZN?=
 =?utf-8?B?d3Y4Z1pyTE9RN3UremJ0SFBiWHhrYUN1ZHo1WXJodlBzVlNHUjdNVmJ2SVdJ?=
 =?utf-8?B?b2RydTVSUkNsbU9JeE9UUkRha1ExS2hLUzZMb2h2U0xFaGVLa05iaDk4bkhE?=
 =?utf-8?B?UVdxemNJNWw5UnZDVDF0RjlkN3VoSVQxUlA1UVFneDV4M0lQNUk5REh1aC9l?=
 =?utf-8?B?c2U3YVZIL3Yva1V3aXJGM2RHSlF5M1pCNGk2UWlQY0RMS2JrRUVIRkNSa3kw?=
 =?utf-8?B?OGNrTGxMaE9qSG9wZk1BQlFLR09ENkQrSFdEYnQxZnMxYXRDTTBYV1NScGNJ?=
 =?utf-8?B?QnFsUUhvaWVsVG5LRFo1TVZybFQ2Nm9RRWlMd0l4bjlIZUtQWmtoMm1ra2dU?=
 =?utf-8?B?OTB4ZkN0YU9uakRRQUVYZXBpQkVDRzFmenplcmVPeVRpdmEvZUhLdDhuQmNN?=
 =?utf-8?B?Q2NBZ1A2R1JOMUI1N3JScStGRFJqeTlCbjJleFdMZEhOaGpTRmpmS0EzV3Ba?=
 =?utf-8?Q?t10s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2ca00b3-65a6-40d1-536a-08db670413db
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2023 03:05:41.3179
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lFCNApDee+EcfrYYQQQNtcnBfGGDdP1yRWj1VNtgCXDtTlv9U75NVsirAEpaL5zbmp1B8/V0lcu79aU3qPMHNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8497
Subject: RE: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy
 registers access using AQ

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogVHVl
c2RheSwgSnVuZSA2LCAyMDIzIDEwOjI3IFBNDQo+IA0KPiBJIGNhbid0IHNheSBJIGxpa2UgdGhp
cy4gSSBwcmVmZXIgdG8gZG8gbWVkaXRhdGlvbiBvbiB0b3Agb2YgYSBtb2Rlcm4gZGV2aWNlIHdp
dGgNCj4gc29tZSBsaWdodHdlaWdodCBmZWF0dXJlcyBsaWtlIF9GX0xFQUdDWV9IRUFERVIuIEkg
ZG9uJ3Qgc2VlIGFueSBhZHZhbnRhZ2VzDQo+IG9mIGEgbmV3IGxlZ2FjeSBBQkkgb3ZlciBfRl9M
RUdBQ1lfSEVBREVSLiBJIGRvbid0IHdhbnQgdG8gcmVwZWF0IGJ1dCBJIGRvbid0DQo+IGdldCBh
bnkgcmVzcG9uc2UgaGVyZQ0KPiANCkl0IGlzIG5ldCBvbmx5IGFuZCBub3QgZ2VuZXJpYy4gTm90
IGEgYmlnIGJsb2NrZXIuDQpJdCBkb2VzbnQgc3RvcCBhdCBfRl9MRUFHQ1lfSEVBREVSLg0KDQo+
IEFueXRoaW5nIHRoYXQgcHJldmVudHMgeW91IGZyb20gYWRkaW5nIHRoaW5ncyBsaWtlIFZJUlRJ
T19ORVRfRl9MRUdBQ1lfSEVBREVSPw0KSXQgcmVxdWlyZXMgaHlwZXJ2aXNvciB0byBtZWRpYXRl
IDEueCBjb25maWcgcmVnaW9uIGFuZCBpbnRlcmNlcHQgZmVhdHVyZSBuZWdvdGlhdGlvbiBpbmNs
dWRpbmcgcSBjb25maWcgYW5kIG1vcmUuDQoNCkFkZGl0aW9uYWxseSwgMS54IGRldmljZSBzYXlz
IHRoZSBtYWMgYWRkcmVzcyBpcyByZWFkIG9ubHksIHdoaWxlIGxlZ2FjeSBpcyBSVy4NCkFuZCB0
aGF0IHJlcXVpcmVzIHlldCBhbm90aGVyIGZlYXR1cmUgYml0IG5lZ290aWF0aW9uLg0KDQpUaGUg
bWFpbiBkZXNpZ24gZ29hbCBpcyB0byBub3QgbWVkaWF0ZSAxLnggc3BlY2lmaWMgcmVnaW9uIGFu
ZCBub3QgbW9kaWZ5IDEueCByZWdpb24gZGVmaW5pdGlvbnMuDQpXaGljaCBpcyB3aHkgd2Ugc3Rl
cCBmb3J3YXJkIHdpdGggdGhlIEFRLg0KDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3ZpcnRp
by0NCj4gZGV2L0NBQ0drTUV1aXhzQmliU3FfcEVRdmNLT0gwV0JRV250YTRRMmMyOFNWOHFUUzhn
YVZjQUBtYWlsLmcNCj4gbWFpbC5jb20vI3QNCg==

