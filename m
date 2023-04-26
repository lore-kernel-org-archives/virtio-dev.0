Return-Path: <virtio-dev-return-12442-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671B1C7618E
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 22:12:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BB77E1EAEA
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 22:12:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AC522986672
	for <virtio-dev@archiver.kernel.org>; Wed, 26 Apr 2023 22:12:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9FFAF9862A9; Wed, 26 Apr 2023 22:12:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8907E986641;
	Wed, 26 Apr 2023 22:11:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=esEKY7NAMYQIMVJXclsj6tju/ahlkO+omdb/a2T5Nqr+v51B3WOc/rtmCitN+5xLhhBGaA9GEJtCiBl8LJvTLpN53pW19Tnvrfc6qr9W97PuSs1N0cAExugd6woKyyjf/RbWBtKvuuoVxhl5uNvanB4Mx3PtA08swkoNTNjZg45TPuDoKrC1RYpfY0dshxM5o3UfysllnAe6A6FeJi8f9epjM4828WVRaHaIxkYFiwVyliTXwZDGA+crYrxwvQ2+zqWftZIecuTbxXA8eVBiEOZxX+p66GZTx3ibNp6EvqMJtRnAVsDJlUXptOxOoNbbEos2FDQLj/wl7pzVPG6pJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C546hO9IWTdMC8R70t/ktUjRG13kFvlYpkguXBJeKlA=;
 b=NA6Ld0YYLkodXBJbyFStaxY5q/oYyOMvBalMIVMkFJ7aDB7LzrTA9Ptmh10gdVtmuOYhpU0MSzXa7efydFH/9evEQnUq/bELDfZl+1hyvBApi7pCNtTpnM5WQA+Xik6unIRkNoK+ial/Wo/EapEBXmm1kybsqGth5gWzbL9b+ocbIZfRbEcHW8EvcUGtV3NFkc7t7oErustDrQlP3vtW9VHc8a4RsmGdwJVR/KVUxOPGXvoHKoacEpjjIgUG0aOHMM3kpc8xWsX0BleSMKcjPE28gVCJzIae0hVHVWDB0ya8dYH33MzM7zzFaAtx8Nx9LIT4QhnuALzeQIY0KbuRCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>, "hang.yuan@intel.com"
	<hang.yuan@intel.com>
CC: "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Jiri Pirko
	<jiri@nvidia.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler
	<shahafs@nvidia.com>
Thread-Topic: [PATCH v12 05/10] pci: add admin vq registers to virtio over pci
Thread-Index: AQHZdswSyG/pcJpYf0OyhtV/kRPNfq87BFIAgAACO4CAAxNugIAADL9g
Date: Wed, 26 Apr 2023 22:11:53 +0000
Message-ID:
 <PH0PR12MB5481B60350D145531A43E567DC659@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <cover.1682354275.git.mst@redhat.com>
 <8a3435860747eeaa038ece4ff896c1cdd441c185.1682354275.git.mst@redhat.com>
 <5858e2e6-0b50-c155-85e9-eea6dfb533e1@nvidia.com>
 <a4b1596c-2132-714a-7557-fa5249a55945@nvidia.com>
 <5cb79b37-a066-283c-eee7-afd26146d988@nvidia.com>
In-Reply-To: <5cb79b37-a066-283c-eee7-afd26146d988@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BY5PR12MB4997:EE_
x-ms-office365-filtering-correlation-id: de15e72b-c36e-41a1-b69a-08db46a33de8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Nm2FVpmUnpnpMCIEqCUsVip5ybt+U4ZwtkiLiVWxPCRcyc2ifJJoI3S5pTYkm0yv9E+3PPnxrFUzeORF2R7waYXmH9hJmT1qGHsRLR3+UX7SXxlSa1tppf9rHEu8K6fzJOW2QhtBcJYIGvso390uryfh+FaPdVnw3fgmNBwPza4JISq9wLYF+BBHkYH7lyxzk6DIP4kRU73orjiq4TPs2pNAOH90/QNFHiCqPTe50Gs7mH1ymvcEk0sRHtxZJnlY+hCRKf5pxquhu5HCdbs+Oti6X8Po2YurGypZi7QhswnE6rOpR7ubzh+o+unTuT1PaUOuP9ERI6zxQi/TJ8pbVbb8H3ljamYNs8b5WuM/0aJk/mWJYAiu5cG4YaaEJxvsHtg7mkq5yH/PUHvzL8piQBJxaiswmYrprqbWKdTpo1YQZo12klJrldjRvRXOHJw5f91qMm+4H/XeHvdqEKm4TwwyUkMzDEn74pZJkNVMNMS4nny0RwmCOOBsfOG1LuMV8jbZuCfvwn7got+zMucUumSnaZTtYmzQQ25+D814J62yjc9wNL4D/Dbv2IDZw9XpiZVluc37Vcrd3/J/MondXMT0vvSZHr3eZTaWLCJjhnUOXu5RI6ziEqMB+61tMuPbRw7PcNMopVuxfynOX9gAuw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199021)(478600001)(110136005)(54906003)(186003)(26005)(6506007)(71200400001)(53546011)(9686003)(107886003)(7696005)(316002)(2906002)(66446008)(8676002)(64756008)(76116006)(66946007)(66556008)(66476007)(7416002)(5660300002)(8936002)(52536014)(38100700002)(4326008)(122000001)(921005)(55016003)(41300700001)(33656002)(86362001)(38070700005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0hWWkQzMVhUbk1SNUN2MW54bEpaMVVJVkRldTNvRElxMWFFUCtDTkJRdFp2?=
 =?utf-8?B?c1ZLRlVVSkxRS0szQU5IbE9uRzJXaUhEdE5qZ2x3UzRpTTR3bHQ3VmhKUW9Q?=
 =?utf-8?B?WlVCUUJOUjhyaXZ3QzM5dVozMGZFdHhNbC9reWIwR3BhL0F4MUFTWThCTHAv?=
 =?utf-8?B?WE9uWHloQnpBcTFBOFdsdkh1WGU3SFJ4QkdCY1lWdmY5T0ZIa0dnay8vRzMz?=
 =?utf-8?B?SVZ2Q0grWGNJYWZqa3VyTGZFbHpxd0hsVkFsZ21TdVBGRFhiQWw4RnlEZ09k?=
 =?utf-8?B?WFFIV0NjcVdyVDY5anpHN0dwS0YwbXphSVN0Y3NPdHdtMWpPNTdnVXAzeTJG?=
 =?utf-8?B?dkVSblhibTRaRU93bU5TYUcxY2RXd1RzcFRxbTVlczk4dnhkMGRtTU9mZW8v?=
 =?utf-8?B?c2VHRjhCYzRwbXpid2pPSnl6Sy9zdXNXVmNkRFRncWRlTlEzTzlHOTNXN2Fo?=
 =?utf-8?B?UFRDR2pMekV3dHJScFhwa09lR1M5YVJkamlCYTVmMWIxOHV1N2NBV3llNDIr?=
 =?utf-8?B?WFI4WnNPdDI1RFR2ODM1UjRnWS9hY0pkNWVLTDg1NGJ2WUl4NjhxK254b1FQ?=
 =?utf-8?B?SmVyQm9nU2tPbW9IMTIwYU5SdXErNm1oZUFhbUJrUFhyNW1wY3Fid01VQXRR?=
 =?utf-8?B?L0hGL1NVOHVCY3VRcFhiMEpVTmJDRHA5L0RzQitlMVJzL09zdll1U2laYU55?=
 =?utf-8?B?QXNOZ3hMdVBoY01rSU91N1lhcFhuUTEyc21Tb2lnbTV1V0doTjk5MDdndDNx?=
 =?utf-8?B?WnVZOEw3NjVRY3B1bEFtY0NQT1VENnVzSDd4MEVEajlmcUFHb0V1VVh6enZl?=
 =?utf-8?B?bUk2TnlyYkxGaXFGUUlJeW5yVy8vTjZ4emtrZDhmMC9wajlibXZMVzNJdHBT?=
 =?utf-8?B?WnJ4OVRJSGRpSXVMVHpWZzYydnV2M0l4Q0hNa0J3L3hDbDZFM0cxMmlXdkFW?=
 =?utf-8?B?T1NwSyt0ZldpVTNoNW85VEM0SVFyR0tEMjFmUW1EWmhSU2dxdGlCcDhxUlJH?=
 =?utf-8?B?RCtpSFR6eE9CMk1ab2Q5SW9qc2s2N2laeC9yUmE3cEdBT1RUVEI3bVZ5WjRm?=
 =?utf-8?B?UkFCNUtSdm1NMDZWdUlwWGpJN0xDVnVnV21EMWl5MFdmcElsTjB4dEU3QjFT?=
 =?utf-8?B?dVpJM2hGNWVDNUdpaVJ6QTUzMWtGY3NZK0xSK3NUVFZKQXgvL0pJTXFhcFdi?=
 =?utf-8?B?bjBkcmJITzNoQmxmbGMrMGhRb1ZJVi96bkoxU09oNHFmaEVrZ2M3SWVoWGQx?=
 =?utf-8?B?UmJ3N3FvMm1oQUFrRHlFMnYzc2s3RTRFc3VYa3BNcDRlRjhGT2lXbTR1Mm5B?=
 =?utf-8?B?b0I1M1haSUg1ZVRkQnpwSmxkY1NLSVFxRTh3QU5KbnhhdWFyMVA0S2xvYXFE?=
 =?utf-8?B?ZW1GZlZzSFNjM0ZnTVVPMDdlV3VPWjdaVEpnZFlodzRPdU1mVE1Ua2V0VnB6?=
 =?utf-8?B?alMwOEpEdFFMcVZVTjUvVWpEMUlQTnljeGxWQU5aSElGNEI4NWJYdXdyZmt0?=
 =?utf-8?B?N1RzeEFrYVdYeENmY2dEVElzclM2Z1VDakpGbmovODB2KzFWM0oyUmJlNEdn?=
 =?utf-8?B?cHVtdUlTd0ZTNlZYcGJPcjFtNEUyZWFZbGNMcnpNWmJYQzBEalNJOStWeDBT?=
 =?utf-8?B?K1Fha0UwWlM2bGp4MkhZUU01ZFh0Smo4NTVJQk9BT01TdUJhY1ROcTRJT01H?=
 =?utf-8?B?QVU4bGxkUy9FZEtPQlZvamtoOFZuYlVQbHdtdFd4MkYweXVhbksxY2hUckdu?=
 =?utf-8?B?eDM4eTVtcmd5TEdvWnE1TkNwVnpxeFFiRXg5VFZYckN5amp6TDRrcW4rbHVq?=
 =?utf-8?B?eFBFWmlWNmczN2pQcU9rejN5akhNSk9raHhCNnZwQnVlVHZzblJ2cVdVRm1I?=
 =?utf-8?B?cXVKNU1saHhyT29XWUVNalpkSGJGNWxnYklMSURtano2anR0b3lod05BS2oy?=
 =?utf-8?B?ZlI1T1JQQWJtNnBGdXhHNUtrNVk4NXl1bExyZnJyKy9jZ1B6eElheHRLM2hY?=
 =?utf-8?B?c3hqdUhUVnpWaWF4SEpsKzRpWEt4OTQ1R0VQMmpsZWhwRTVkdW5hcFZ1Qlla?=
 =?utf-8?B?MVhIamFmMng3bGtNYUlwZFE2Wlpadys4Uk0wNUxFQXAzcUVheVA2TEdxZmxk?=
 =?utf-8?Q?xIBQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de15e72b-c36e-41a1-b69a-08db46a33de8
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 22:11:53.4731
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9LynRJ1sp1PizwzdqYBcZ5lEXiWUMSaI6hO0wVkjBDMGu/JT05bPSAC6WahnsCz19/ZX/71pDoYUrGvo3EAU/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4997
Subject: [virtio-dev] RE: [PATCH v12 05/10] pci: add admin vq registers to virtio over pci

DQo+IEZyb206IE1heCBHdXJ0b3ZveSA8bWd1cnRvdm95QG52aWRpYS5jb20+DQo+IFNlbnQ6IFdl
ZG5lc2RheSwgQXByaWwgMjYsIDIwMjMgNToxMiBQTQ0KPiANCj4gT24gMjUvMDQvMjAyMyAxOjE0
LCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+ID4NCj4gPg0KPiA+IE9uIDQvMjQvMjAyMyA2OjA2IFBN
LCBNYXggR3VydG92b3kgd3JvdGU6DQo+ID4NCj4gPj4+ICtJZiBWSVJUSU9fRl9BRE1JTl9WUSBo
YXMgYmVlbiBuZWdvdGlhdGVkLCBhbmQgaWYgdGhlIGRyaXZlcg0KPiA+Pj4gK2NvbmZpZ3VyZXMg
YW55IGFkbWluaXN0cmF0aW9uIHZpcnRxdWV1ZXMsIHRoZSBkcml2ZXIgTVVTVCBjb25maWd1cmUN
Cj4gPj4+ICt0aGUgYWRtaW5pc3RyYXRpb24gdmlydHF1ZXVlcyB1c2luZyB0aGUgaW5kZXggaW4g
dGhlIHJhbmdlDQo+ID4+PiArXGZpZWxke2FkbWluX3F1ZXVlX2luZGV4fSB0byBcZmllbGR7YWRt
aW5fcXVldWVfaW5kZXh9ICsNCj4gPj4+ICtcZmllbGR7YWRtaW5fcXVldWVfbnVtfSAtIDEgaW5j
bHVzaXZlLg0KPiA+Pj4gK1RoZSBkcml2ZXIgTUFZIGNvbmZpZ3VyZSBsZXNzIGFkbWluaXN0cmF0
aW9uIHZpcnRxdWV1ZXMgdGhhbg0KPiA+Pj4gK3N1cHBvcnRlZCBieSB0aGUgZGV2aWNlLg0KPiA+
Pg0KPiA+PiB3ZSBuZWVkIHRvIHNheSBzb21ldGhpbmcgYWJvdXQgb3RoZXIgdmlydHEncyBpbmRl
eGVzLg0KPiA+PiBGb3IgZXhhbXBsZSwgaWYgYXEgaW5kZXggPSAwIHRoZW4gZm9yIHRoZSB2Ymxr
IGRldmljZSB0aGUgcmVxdWVzdA0KPiA+PiBxdWV1ZXMgd291bGQgc3RhcnQgZnJvbSBpbmRleCA9
IDEuDQo+ID4+DQo+ID4+IGNhbiB3ZSBhZGRyZXNzIHRoaXMgPw0KPiA+DQo+ID4gSXQgbWF5IHNs
aWdodGx5IGNvbXBsaWNhdGUgdGhlIGRldmljZSBpbXBsZW1lbnRhdGlvbiB3aGVuIGRldmljZQ0K
PiA+IGR5bmFtaWNhbGx5IGNoYW5nZXMgdGhlIFZRIGluZGljZXMgYmFzZWQgb24gdGhlIG5lZ290
aWF0aW9uIG9mIHRoZQ0KPiA+IGZlYXR1cmUgYml0Lg0KPiA+IEFsc28gdGhlIGRyaXZlcnMgd2l0
aCBhbmQgd2l0aG91dCBuZWVkIGEgZGlmZmVyZW50IFZRIGluZGV4IGhhbmRsaW5nLg0KPiA+DQo+
ID4gSSBhbSB0aGlua2luZyB0aGF0IGFxIGluZGV4IHNob3VsZCBub3Qgb3ZlcmxhcCB3aXRoIHRo
ZSB2cSBpbmRleCBpbg0KPiA+IHJhbmdlIGV4cG9zZWQgYnkgbnVtX3F1ZXVlcyBmaWVsZC4NCj4g
Pg0KPiA+IFRoaXMgYWxzbyBhbGlnbnMgdG8gdGhlIGV4Y2x1c2lvbiBvZiBhcSBjb3VudCBmcm9t
IG51bV9xdWV1ZXMgZmllbGQuDQo+IA0KPiBUaGUgbmFtZXNwYWNlIG9mIHRoZSBhcSBhbmQgb3Ro
ZXIgdnEgaW5kZXggaXMgdGhlIHNhbWUuDQo+IEFuZCB0aGUgY29uZmlndXJhdGlvbiBpcyBkb25l
IHVzaW5nIHRoZSBzYW1lIHF1ZXVlX3NlbGVjdCBhbmQgb3RoZXIgcmVnaXN0ZXJzLg0KPiBUaHVz
LCB3ZSBuZWVkIHRvIGFkZHJlc3MgdGhlIGFib3ZlIGNvbW1lbnQgb3RoZXJ3aXNlIGFsbCB0aGUg
ZGV2aWNlDQo+IHZpcnRxdWV1ZXMgY2hhcHRlcnMgYXJlIHdyb25nLg0KDQpNaWNoYWVsIGhhcyBh
ZGRlZCBiZWxvdyBsaW5lIGluIHRoaXMgcGF0Y2ggaW4gbnVtX3F1ZXVlcyBkZXNjcmlwdGlvbiBz
byBpdCBjb3ZlcnMgdGhlIGV4Y2x1c2lvbiBwYXJ0Lg0KDQorICAgICAgICBUaGlzIGV4Y2x1ZGVz
IGFkbWluaXN0cmF0aW9uIHZpcnRxdWV1ZXMgaWYgYW55IGFyZSBzdXBwb3J0ZWQuDQoNCkkgaW5z
cGVjdGVkIGFsbCB0aGUgZGV2aWNlcy4NCkZvbGxvd2luZyBkZXZpY2VzIHdoaWNoIGhhcyBtdWx0
aSBxdWV1ZSBzdXBwb3J0cyBhcmUgZmluZSwgbmV0LCBjb25zb2xlLCBzY3NpIGhvc3QsIGdwdSwg
aW5wdXQsIGNyeXB0bywgc29ja2V0LCBycG1iLCBpb21tdSwgc291bmQsIHNjbWksIGdwaW8uIA0K
DQpGb2xsb3dpbmcgc2luZ2xlIHEgZGV2aWNlcyBhcmUgZmluZSB0b286IGVudHJvcHksIG1lbSBi
YWxsb24gZGV2LCBtZW0sIGkyYywgcG1lbS4NClNvIG1vc3RseSBhbGwgY2hhcHRlcnMgZG9u4oCZ
dCBsb29rIHdyb25nLg0KDQpCbG9jayBkZXZpY2UgbmVlZHMgYmVsb3cgY2hhbmdlLg0KV0RZVD8N
Cg0KRnJvbSAwNTkyZDE2NzQ1MTI4MGJjMjEyZGY3MzIyMDc3ZjRjOTRiMjhjOTE3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQ0KRnJvbTogUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPg0K
RGF0ZTogVGh1LCAyNyBBcHIgMjAyMyAwMTowMTo0MSArMDMwMA0KU3ViamVjdDogW1BBVENIXSB2
aXJ0aW8tYmxrOiBSZW5hbWUgbnVtX3F1ZXVlcyB0byBudW1fcmVxX3F1ZXVlcw0KDQpudW1fcXVl
dWVzIGZpZWxkIHJlcHJlc2VudHMgbnVtYmVyIG9mIGJsayBzcGVjaWZpYyByZXF1ZXN0IHF1ZXVl
cy4NCg0KUmVuYW1pbmcgaXQgdG8gbnVtX3JlcV9xdWV1ZXMgcmVmbGVjdCBpdHMgcHJlY2lzZSB1
c2FnZS4NCkl0IGFsc28gYXZvaWRzIGNvbmZ1c2lvbiB3aXRoIFBDSSB0cmFuc3BvcnQncyBnZW5l
cmljIG51bV9xdWV1ZXMgZmllbGQuDQoNClNpZ25lZC1vZmYtYnk6IFBhcmF2IFBhbmRpdCA8cGFy
YXZAbnZpZGlhLmNvbT4NCi0tLQ0KIGRldmljZS10eXBlcy9ibGsvZGVzY3JpcHRpb24udGV4IHwg
OCArKysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pDQoNCmRpZmYgLS1naXQgYS9kZXZpY2UtdHlwZXMvYmxrL2Rlc2NyaXB0aW9uLnRleCBiL2Rl
dmljZS10eXBlcy9ibGsvZGVzY3JpcHRpb24udGV4DQppbmRleCBmMDRjOTMyLi41YTI3Mzk5IDEw
MDY0NA0KLS0tIGEvZGV2aWNlLXR5cGVzL2Jsay9kZXNjcmlwdGlvbi50ZXgNCisrKyBiL2Rldmlj
ZS10eXBlcy9ibGsvZGVzY3JpcHRpb24udGV4DQpAQCAtMTYsNyArMTYsNyBAQCBcc3Vic2VjdGlv
bntWaXJ0cXVldWVzfVxsYWJlbHtzZWM6RGV2aWNlIFR5cGVzIC8gQmxvY2sgRGV2aWNlIC8gVmly
dHF1ZXVlc30NCiBcZW5ke2Rlc2NyaXB0aW9ufQ0KDQogIE49MSBpZiBWSVJUSU9fQkxLX0ZfTVEg
aXMgbm90IG5lZ290aWF0ZWQsIG90aGVyd2lzZSBOIGlzIHNldCBieQ0KLSBcZmllbGR7bnVtX3F1
ZXVlc30uDQorIFxmaWVsZHtudW1fcmVxX3F1ZXVlc30uDQoNCiBcc3Vic2VjdGlvbntGZWF0dXJl
IGJpdHN9XGxhYmVse3NlYzpEZXZpY2UgVHlwZXMgLyBCbG9jayBEZXZpY2UgLyBGZWF0dXJlIGJp
dHN9DQoNCkBAIC0xMDgsNyArMTA4LDcgQEAgXHN1YnNlY3Rpb257RGV2aWNlIGNvbmZpZ3VyYXRp
b24gbGF5b3V0fVxsYWJlbHtzZWM6RGV2aWNlIFR5cGVzIC8gQmxvY2sgRGV2aWNlIC8NCiAgICAg
ICAgIH0gdG9wb2xvZ3k7DQogICAgICAgICB1OCB3cml0ZWJhY2s7DQogICAgICAgICB1OCB1bnVz
ZWQwOw0KLSAgICAgICAgdTE2IG51bV9xdWV1ZXM7DQorICAgICAgICB1MTYgbnVtX3JlcV9xdWV1
ZXM7DQogICAgICAgICBsZTMyIG1heF9kaXNjYXJkX3NlY3RvcnM7DQogICAgICAgICBsZTMyIG1h
eF9kaXNjYXJkX3NlZzsNCiAgICAgICAgIGxlMzIgZGlzY2FyZF9zZWN0b3JfYWxpZ25tZW50Ow0K
QEAgLTEzNSw4ICsxMzUsOCBAQCBcc3Vic2VjdGlvbntEZXZpY2UgY29uZmlndXJhdGlvbiBsYXlv
dXR9XGxhYmVse3NlYzpEZXZpY2UgVHlwZXMgLyBCbG9jayBEZXZpY2UgLw0KIHByZXNlbnQuIFRo
ZSBhdmFpbGFiaWxpdHkgb2YgdGhlIG90aGVycyBhbGwgZGVwZW5kIG9uIHZhcmlvdXMgZmVhdHVy
ZQ0KIGJpdHMgYXMgaW5kaWNhdGVkIGFib3ZlLg0KDQotVGhlIGZpZWxkIFxmaWVsZHtudW1fcXVl
dWVzfSBvbmx5IGV4aXN0cyBpZiBWSVJUSU9fQkxLX0ZfTVEgaXMgc2V0LiBUaGlzIGZpZWxkIHNw
ZWNpZmllcw0KLXRoZSBudW1iZXIgb2YgcXVldWVzLg0KK1RoZSBmaWVsZCBcZmllbGR7bnVtX3Jl
cV9xdWV1ZXN9IG9ubHkgZXhpc3RzIGlmIFZJUlRJT19CTEtfRl9NUSBpcyBzZXQuIFRoaXMgZmll
bGQgc3BlY2lmaWVzDQordGhlIG51bWJlciBvZiByZXF1ZXN0IHF1ZXVlcy4NCg0KIFRoZSBwYXJh
bWV0ZXJzIGluIHRoZSBjb25maWd1cmF0aW9uIHNwYWNlIG9mIHRoZSBkZXZpY2UgXGZpZWxke21h
eF9kaXNjYXJkX3NlY3RvcnN9DQogXGZpZWxke2Rpc2NhcmRfc2VjdG9yX2FsaWdubWVudH0gYXJl
IGV4cHJlc3NlZCBpbiA1MTItYnl0ZSB1bml0cyBpZiB0aGUNCi0tDQoyLjI2LjINCg==

