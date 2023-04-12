Return-Path: <virtio-dev-return-12197-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 738D6C77B6E
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 14:23:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 81DC72A898
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 14:23:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6C3F39865F8
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 14:23:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 608AD9865B5; Wed, 12 Apr 2023 14:23:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4A1209865B3;
	Wed, 12 Apr 2023 14:23:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YS14F9a0gVxG6g/pc66VQ4FEakmtS8IeJkadrPse6W5c2RPY9ai7MQE8Rk84/n871sCQZN/fTom9P6JVENVgkrmAaDxvY3sRGiJW7zQkRs8AMRHbOV891GnJOOZv5VlHroLNjfxlSolWEULjMVkQST0InjtbYm6O2PViYuI1G1m0V6pYwsZc8lZlvK/9NcfEvtU4Hcsok2eFluYrHSlLZFL+UTNAbo9jGDb9WyrH2/qBWeUFFfk3YnLcjH4BVJ45hsxK8dF1zp3lfYqvuZ1cVqHjy8yczVgZehVjlxuJBy8jUlXM8KNBZQrDxrvbF84CxG6re/kT1d3NAkcjhuEwrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=os78rw7PKa9jK3VdA4bEyQpN6VJpJ0P7kRTkt/wLaiA=;
 b=VnaQUd/oDG3mZ9TyGSIa856hI1UH1NKJU0uXuf7sOjREF6aIFkvLVrvf7ESEHPfmxYEjCXDvhcX4k9qs5Yq0AuQDzKXnmQetlzopbIv6EfobyMfb6fdSC97mYz4BJvYc79qey0Pl1oDiZtunQKB4cCD1hZ0f7gjXQH2cm4vqyZmqxC2ai2xAIOmTtT4Lm44a6F5r56PDkHUkl025HrikXRy+puWCkF7Vg0e3pg6lL3ApYZnr6UMW4g5KB0+UTI2KDpaQjj8/0OslRNsc9xtciLBXWw14kadayhY1URQ2KJd3ZZP1QzjUXYoZjQSovkmwMKRr49yphP6xuikBnBC2SA==
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
 AQHZY1tLAUtRpuZtUUOucQPGJlFfkK8flpUAgAQ7nwCAAE6hgIAAAXwAgAAFegCAAAt0AIAALl6AgAEOIwCAAFEgAIAAIPWAgAAcJ4CAASFtgIAABJ4AgAAKJYCAAACFsIAABgyAgAAAT3CAAAYpAIAAAJIAgAAJz4CAAILBcA==
Date: Wed, 12 Apr 2023 14:23:32 +0000
Message-ID:
 <PH0PR12MB5481F0CF5A555A6BB2CE856CDC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230410020906-mutt-send-email-mst@kernel.org>
 <CACGkMEtiROwuB+ECJqd13qdpMJSTMoDOzi1u_i85==42C0XSXw@mail.gmail.com>
 <20230410023715-mutt-send-email-mst@kernel.org>
 <CACGkMEs+E_OarQxP3NmLk3iSi7U0WgAn-m3b4eX7ULu1+v=sOw@mail.gmail.com>
 <20230410060417-mutt-send-email-mst@kernel.org>
 <CACGkMEuc47PdmQdC67Nz4AvX_+jy+XBgCkwZ1BHmM8VGb9gywA@mail.gmail.com>
 <20230411030056-mutt-send-email-mst@kernel.org>
 <CACGkMEt2QAfhCgpYjSRNzf3n4W_HJLrMfE9JHzocR_gPH_Zrtg@mail.gmail.com>
 <20230411063945-mutt-send-email-mst@kernel.org>
 <CACGkMEufWUXHKahg3GLOKfV5aptbiek_DKwy+7rCfMya2GPaTQ@mail.gmail.com>
 <20230412000802-mutt-send-email-mst@kernel.org>
 <CACGkMEshNydwBD=Q0JW-SDY6xyiJ4uVrLn+pxbUrinycBKwsrw@mail.gmail.com>
 <PH0PR12MB548118F57BB4B4A4F8DC9D7ADC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvYsz1fSPG+fKpRaZ05Ut7ffKwvMPvR8xbRBsXA_6vGQw@mail.gmail.com>
 <PH0PR12MB548137D7A25C99EAA42B4D12DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshW82qztmGw8YJWJ8=QCoRd6cPxQ+ySazxsO_o+U6c4Q@mail.gmail.com>
 <PH0PR12MB548147CF939CB9C2A0586310DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEu2B_GogDR9HUwB7mT8fkGh+Q_buPLz4nhwhK7h9k6BQQ@mail.gmail.com>
In-Reply-To:
 <CACGkMEu2B_GogDR9HUwB7mT8fkGh+Q_buPLz4nhwhK7h9k6BQQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW4PR12MB6850:EE_
x-ms-office365-filtering-correlation-id: f7e153b7-33b5-47e8-6015-08db3b617e79
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9CP5RgDtX9L4ZCQgDzmvudb7MdmkJoR6dSJ9jXxnEWpPcGYqITrjmHb5vQscQRKNIdv+eLPMCr+XzBPnSQXDDOf3/IO7mTUNtJcdSYKnE519R5Kj6NqmIdxTruYwsteVEB0C8CB8x+osSCc97/Oq7CeJMyIi3wLsfXSN5iIq93TLesHP2Tn0SHDRMH/rjwWG8uLt3kd6m6HWI9sOhj5VWKh4Pm7grQthnQ74cfPJEXySSOhYlgvU0FuXeqLTR7PIJOs8v3Lx+kZw7WbxWYtdu02QejDJw/frfmhmHX2WvRD0L/rxJx0CHRy4qyad6r2VL77N3TcxbJSFFxNZRGvGOlz7LGfb/0oiTsvAeoEpLRmwvRGJplBr0wz+JFOXHBpE0ErwRimdzP/UWOhWhvfB0PDbQHhuBc2+Y9zLvTknSoC0Amglv+97L3WepA0k8T4dkkkT1FDSjFxKaYfqJDjBncQiwiCKvLwmP68MamrO7Q43CJO1YWcSeYAT+CYTq6UfB0mIwbDoWsW7osRh0hFKSrpSttWRySaarJoPljiit/ZbJrwpOgEaigKShO+qPdmwxyzgoaz4Q2u/e5QWxNN3jfk+DkI/Xd4F4wLVQ+ikzA+w/ERdJHCsq1ryDep/G/Ku
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(451199021)(8936002)(33656002)(38070700005)(86362001)(2906002)(66899021)(54906003)(55016003)(71200400001)(6506007)(83380400001)(53546011)(26005)(7696005)(186003)(9686003)(76116006)(66946007)(66556008)(6916009)(478600001)(8676002)(64756008)(41300700001)(66446008)(122000001)(38100700002)(52536014)(4326008)(316002)(5660300002)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WDJUWXNvS210VXY0S0RsSUJHck1KUkpiTDlSU0ptZUE0NHZDQXJxWkNXZjRG?=
 =?utf-8?B?ZXNwZFJ1ZzZkVFQ0ZGdyZ1NHb3h3eVFWNS92ZEdmMnk1cVp6bFJpVzkxVUho?=
 =?utf-8?B?TWVQVVN2QTNNblJMcjR5VmM0NDFRVDAxNEVZSy9pZDdEVklKN1NjUUJ2cXZS?=
 =?utf-8?B?ajRyT04yczkwTVl5aE0xUnQ2N1htbFhMWlMyT3IrRmU3RU5iR3RzUnh2dEty?=
 =?utf-8?B?eTA2UEFoYXRCOERvMDdCTS8ySjhJWGd5dmxCYW1hN0ZuN2RHT3ZsVmtFemR6?=
 =?utf-8?B?RlZjRG1reEx2K25EWkNPVi9KNExZYXdFTWxqcWVmVWxpdEUxMjU2RzIyeTRL?=
 =?utf-8?B?T3dNQ245Sy8wVWI3N0NCSUcvTmFlb285aGtGNXpoY1pBbzB6azFnYmhLZkdK?=
 =?utf-8?B?N3NSdU16N3dEQW8rN09hekZLWGx2RVU3ZzhSYWJMKzd5S1VTd0NKTXJQU2RV?=
 =?utf-8?B?TGFUS1J2aW8zazhqTkdBNkJCY3JVNEc1K0lhcG1EY1lDeWZtODI2MGUvVVBF?=
 =?utf-8?B?OEN2ZkJKTTd1aHlqMEpTVFY3ZGU3eEs2dUdUZDY4ZklqWi9oV1l2SWNwVXd2?=
 =?utf-8?B?ZC84R0N1YVRHN21JaGU1VUhDV3hSVStPRTVLd282VHpPU0o2WFBBOFlmb3JT?=
 =?utf-8?B?b1E5akdrV0Uyc1J0clFNWWFxbXd6QkxrYjQrMlE4blZqbmJDVG5aMFdqS25G?=
 =?utf-8?B?aXlmMUpiRHNGUXBjazd0VHlZL0NRc09SbHNHZnpPWHViQ0QrbGdpdUowT09x?=
 =?utf-8?B?Y0hTVmFLWThqN2JKK3lpQzlSQ0xTeVpRL3czUkZlRE9McGF2bzVuWXpSR0xK?=
 =?utf-8?B?c09jV1RvcUVtT0wzaG12a2gvanJvT2RsTHJ5RHFrdDlkenpMcDlMR0pnZTRt?=
 =?utf-8?B?ZFovR085bng5ODZWb0piNWVzUHRTclRVWkhuNXBmd2lMOVZ3R0VSUmFRZzBx?=
 =?utf-8?B?UjRZNjB5YktjS3J3SDNMQVhVbW1kK3d4ZVZkMk1vUjV0dlJiYkNhNVpqeXVw?=
 =?utf-8?B?Vk1iTnh4NVFUNWc0aldUVldGTG92S1hpaEFuMUFlcjdSQTRzdVhTbW41SnBE?=
 =?utf-8?B?c2V3YVAydUFxVTNia0dsdGdWeGtUSXhNYXU3MDg3ZE1WRkp2MEJScHU4eEZj?=
 =?utf-8?B?dHZVZmZxT1NRSkgyWGpjRXBjR3o1MkV6bUQzYkV3ZDU1dmlkU2pBb2k2UzFj?=
 =?utf-8?B?ampSSkg2dHltNktvWU04dFNHQ0FrdG5vczE1K0Y0WUhReFdHVjJZM08vd3Yx?=
 =?utf-8?B?THVHaEhDVStyRlpybjFJclJhTFIrTTMyS2dDcEZrZGNLNi9RU2pkUXl1c2Jp?=
 =?utf-8?B?Z1cvR2lHTWNxdUhva0hDbVBVUUtBVEptZnNIejVsR2RtYzkvVlVVdldHeXdW?=
 =?utf-8?B?YVFVR0NzZG9kWTdxWEZkVjhoYXEzWHZkVVZVR3RGYkdzekFCT0JkKys3TlRO?=
 =?utf-8?B?UEZjRmpyd0dBeExUREZlOW83bVF6ME5FY3RVQkpEOVAwRCtYbkRMaHQxdkdY?=
 =?utf-8?B?YitYY3B1em1PbmJ3UjNpaXpteVkrYSs4bk1Cbkl6cUpNZGdlYU12YWIxejJL?=
 =?utf-8?B?dkxpSU84bDh4TjNlOXdRSHRZaWlLNEpnQ1dxekpnZXA3MXBzQVVKVERZN244?=
 =?utf-8?B?dnBsVUd4TGdhWFg1d1UzS1ZwemV4RzRCR1lkM2VtZk9lRkQ5di9Zc2FJNjBI?=
 =?utf-8?B?WDA3elhNS3JvYytRSDdXSThCUldkVXBKRS9TMTJ4aUNTZVNFZXNKZ0s5L3Yr?=
 =?utf-8?B?TDFPcmgvWkJpT1hsSkdhenBpM1dIRHFqQ1RSa242T2Y3TlhvZFJtTVg3MlR2?=
 =?utf-8?B?THYyRGMwcE4rcElRZ3duYmFnSFA2U1pBWEZQOUI2K3VQNGRBR3JOMzY1cmFS?=
 =?utf-8?B?T1l5VFhhaUJ4RWRITFpCUTVMamVWdS83VW9STldZYnJpMStQUk5HN0U5dnpp?=
 =?utf-8?B?bG0zTk1pSHVkUmtpT09zbnpYcDY4TFpHZmpLSVEvWEZOWndSNllVVk8vRHJG?=
 =?utf-8?B?K2VyM3FYNDRmdFlzMGt0bEdFZDZwTzZwMHkzbk1TMjVGcVRlMTBSRzRDZ3hw?=
 =?utf-8?B?Q1Mzb1ZTN1Fscys2MFVFeVFnRzIwa3pSSjQ1QllpZHk5dnlMZ2NMblcrSEhI?=
 =?utf-8?Q?cT+g=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7e153b7-33b5-47e8-6015-08db3b617e79
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 14:23:32.2437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mItb0vKsMX1iA2aO7oK32AuwXGxZcuFOpdIoPW3eY4VzF5aUk7qqwHiwiAuGA7FLC/GtR85Q2USviUO75ZU6cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6850
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogV2Vk
bmVzZGF5LCBBcHJpbCAxMiwgMjAyMyAyOjE1IEFNDQo+IA0KPiBPbiBXZWQsIEFwciAxMiwgMjAy
MyBhdCAxOjU14oCvUE0gUGFyYXYgUGFuZGl0IDxwYXJhdkBudmlkaWEuY29tPiB3cm90ZToNCj4g
Pg0KPiA+DQo+ID4NCj4gPiA+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
DQo+ID4gPiBTZW50OiBXZWRuZXNkYXksIEFwcmlsIDEyLCAyMDIzIDE6MzggQU0NCj4gPg0KPiA+
ID4gPiBNb2Rlcm4gZGV2aWNlIHNheXMgRkVBRVRVUkVfMSBtdXN0IGJlIG9mZmVyZWQgYW5kIG11
c3QgYmUNCj4gPiA+ID4gbmVnb3RpYXRlZCBieQ0KPiA+ID4gZHJpdmVyLg0KPiA+ID4gPiBMZWdh
Y3kgaGFzIE1hYyBhcyBSVyBhcmVhLiAoaHlwZXJ2aXNvciBjYW4gZG8gaXQpLg0KPiA+ID4gPiBS
ZXNldCBmbG93IGlzIGRpZmZlcmVuY2UgYmV0d2VlbiB0aGUgbGVnYWN5IGFuZCBtb2Rlcm4uDQo+
ID4gPg0KPiA+ID4gSnVzdCB0byBtYWtlIHN1cmUgd2UncmUgYXQgdGhlIHNhbWUgcGFnZS4gV2Un
cmUgdGFsa2luZyBpbiB0aGUNCj4gPiA+IGNvbnRleHQgb2YgbWVkaWF0aW9uLiBXaXRob3V0IG1l
ZGlhdGlvbiwgeW91ciBwcm9wb3NhbCBjYW4ndCB3b3JrLg0KPiA+ID4NCj4gPiBSaWdodC4NCj4g
Pg0KPiA+ID4gU28gaW4gdGhpcyBjYXNlLCB0aGUgZ3Vlc3QgZHJpdmVyIGlzIG5vdCB0YWxraW5n
IHdpdGggdGhlIGRldmljZQ0KPiA+ID4gZGlyZWN0bHkuIFFlbXUgbmVlZHMgdG8gdHJhcHMgd2hh
dGV2ZXIgaXQgd2FudHMgdG8gYWNoaWV2ZSB0aGUNCj4gPiA+IG1lZGlhdGlvbjoNCj4gPiA+DQo+
ID4gSSBwcmVmZXIgdG8gYXZvaWQgcGlja2luZyBzcGVjaWZpYyBzdyBjb21wb25lbnQgaGVyZSwg
YnV0IHllcy4gUUVNVSBjYW4gdHJhcC4NCj4gPg0KPiA+ID4gMSkgSXQncyBwZXJmZWN0bHkgZmlu
ZSB0aGF0IFFlbXUgbmVnb3RpYXRlZCBWRVJTSU9OXzEgYnV0IHByZXNlbnRlZA0KPiA+ID4gYSBt
ZWRpYXRlZCBsZWdhY3kgZGV2aWNlIHRvIGd1ZXN0cy4NCj4gPiBSaWdodCBidXQgaWYgVkVSU0lP
Tl8xIGlzIG5lZ290aWF0ZWQsIGRldmljZSB3aWxsIHdvcmsgYXMgVl8xIHdpdGggMTJCDQo+IHZp
cnRpb19uZXRfaGRyLg0KPiANCj4gU2hhZG93IHZpcnRxdWV1ZSBjb3VsZCBiZSB1c2VkIGhlcmUu
IEFuZCB3ZSBoYXZlIG11Y2ggbW9yZSBpc3N1ZXMgd2l0aG91dA0KPiBzaGFkb3cgdmlydHF1ZXVl
LCBtb3JlIGJlbG93Lg0KPiANCj4gPg0KPiA+ID4gMikgRm9yIE1BQyBhbmQgUmVzZXQsIFFlbXUg
Y2FuIHRyYXAgYW5kIGRvIGFueXRoaW5nIGl0IHdhbnRzLg0KPiA+ID4NCj4gPiBUaGUgaWRlYSBp
cyBub3QgdG8gcG9rZSBpbiB0aGUgZmllbGRzIGV2ZW4gdGhvdWdoIHN1Y2ggc3cgY2FuLg0KPiA+
IE1BQyBpcyBSVyBpbiBsZWdhY3kuDQo+ID4gTWFjIGlhIFJPIGluIDEueC4NCj4gPg0KPiA+IFNv
IFFFTVUgY2Fubm90IG1ha2UgUk8gcmVnaXN0ZXIgaW50byBSVy4NCj4gDQo+IEl0IGNhbiBiZSBk
b25lIHZpYSB1c2luZyB0aGUgY29udHJvbCB2cS4gVHJhcCB0aGUgTUFDIHdyaXRlIGFuZCBmb3J3
YXJkIGl0IHZpYQ0KPiBjb250cm9sIHZpcnRxdWV1ZS4NCj4NClRoaXMgcHJvcG9zYWwgSXMgbm90
IGltcGxlbWVudGluZyBhYm91dCB2ZHBhIG1lZGlhdG9yIHRoYXQgcmVxdWlyZXMgZmFyIGhpZ2hl
ciB1bmRlcnN0YW5kaW5nIGluIGh5cGVydmlzb3IuDQpTdWNoIG1lZGlhdGlvbiB3b3JrcyBmaW5l
IGZvciB2ZHBhIGFuZCBpdCBpcyB1cHRvIHZkcGEgbGF5ZXIgdG8gZG8uIE5vdCByZWxldmFudCBo
ZXJlLg0KIA0KPiA+DQo+ID4gVGhlIHByb3Bvc2VkIHNvbHV0aW9uIGluIHRoaXMgc2VyaWVzIGVu
YWJsZXMgaXQgYW5kIGF2b2lkIHBlciBmaWVsZCBzdw0KPiBpbnRlcnByZXRhdGlvbiBhbmQgbWVk
aWF0aW9uIGluIHBhcnNpbmcgdmFsdWVzIGV0Yy4NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgaXQncyBw
b3NzaWJsZS4gU2VlIHRoZSBkaXNjdXNzaW9uIGFib3V0IE9SREVSX1BMQVRGT1JNIGFuZA0KPiBB
Q0NFU1NfUExBVEZPUk0gaW4gcHJldmlvdXMgdGhyZWFkcy4NCj4gDQpJIGhhdmUgcmVhZCB0aGUg
cHJldmlvdXMgdGhyZWFkLg0KSHlwZXJ2aXNvciB3aWxsIGJlIGxpbWl0aW5nIHRvIHRob3NlIHBs
YXRmb3JtcyB3aGVyZSBPUkRFUl9QTEFURk9STSBpcyBub3QgbmVlZGVkLg0KQW5kIHRoaXMgaXMg
YSBwY2kgdHJhbnNpdGlvbmFsIGRldmljZSB0aGF0IHVzZXMgdGhlIHN0YW5kYXJkIHBsYXRmb3Jt
IGRtYSBhbnl3YXkgc28gQUNDRVNTX1BMQVRGT1JNIGlzIG5vdCByZWxhdGVkLg0KDQo+ID4NCj4g
PiBXaGF0IGlzIHByb3Bvc2VkIGhlcmUsIHRoYXQNCj4gPiBhLiBsZWdhY3kgcmVnaXN0ZXJzIGFy
ZSBlbXVsYXRlZCBhcyBNTUlPIGluIGEgQkFSLg0KPiA+IGIuIFRoaXMgY2FuIGJlIGVpdGhlciBi
ZSBCQVIwIG9yIHNvbWUgb3RoZXIgQkFSDQo+ID4NCj4gPiBZb3VyIHF1ZXN0aW9uIHdhcyB3aHkg
dGhpcyBmbGV4aWJpbGl0eT8NCj4gDQo+IFllcy4NCj4gDQo+ID4NCj4gPiBUaGUgcmVhc29uIGlz
Og0KPiA+IGEuIGlmIGRldmljZSBwcmVmZXJzIHRvIGltcGxlbWVudCBvbmx5IHR3byBCQVJzLCBp
dCBjYW4gZG8gc28gYW5kIGhhdmUgd2luZG93DQo+IGZvciB0aGlzIDYwKyBjb25maWcgcmVnaXN0
ZXJzIGluIGFuIGV4aXN0aW5nIEJBUi4NCj4gPiBiLiBpZiBkZXZpY2UgcHJlZmVycyB0byBpbXBs
ZW1lbnQgYSBuZXcgQkFSIGRlZGljYXRlZCBmb3IgbGVnYWN5IHJlZ2lzdGVycw0KPiBlbXVsYXRp
b24sIGl0IGlzIGZpbmUgdG9vLg0KPiA+DQo+ID4gQSBtZWRpYXRpbmcgc3cgd2lsbCBiZSBhYmxl
IHRvIGZvcndhcmQgdGhlbSByZWdhcmRsZXNzLg0KPiANCj4gSSdtIG5vdCBzdXJlIEkgZnVsbHkg
dW5kZXJzdGFuZCB0aGlzLiBUaGUgb25seSBkaWZmZXJlbmNlIGlzIHRoYXQgZm9yIGIsIGl0IGNh
biBvbmx5DQo+IHVzZSBCQVIwLiANCldoeSBkbyBzYXkgaXQgY2FuIHVzZSBvbmx5IEJBUiAwPw0K
DQpGb3IgZXhhbXBsZSwgYSBkZXZpY2UgbWF5IGhhdmUgaW1wbGVtZW50ZWQgc2F5IG9ubHkgQkFS
MiwgYW5kIHNtYWxsIHBvcnRpb24gb2YgdGhlIEJBUjIgaXMgcG9pbnRpbmcgdG8gbGVnYWN5IE1N
SU8gY29uZmlnIHJlZ2lzdGVycy4NCkEgbWVkaWF0b3IgaHlwZXJ2aXNvciBzdyB3aWxsIGJlIGFi
bGUgdG8gcmVhZC93cml0ZSB0byBpdCB3aGVuIEJBUjAgaXMgZXhwb3NlZCB0b3dhcmRzIHRoZSBn
dWVzdCBWTSBhcyBJT0JBUiAwLg0KDQo+IFVubGVzcyB0aGVyZSdzIGEgbmV3IGZlYXR1cmUgdGhh
dCBtYW5kYXRlcw0KPiBCQVIwICh3aGljaCBJIHRoaW5rIGlzIGltcG9zc2libGUgc2luY2UgYWxs
IHRoZSBmZWF0dXJlcyBhcmUgYWR2ZXJ0aXNlZCB2aWENCj4gY2FwYWJpbGl0aWVzIG5vdykuIFdl
J3JlIGZpbmUuDQo+DQpObyBuZXcgZmVhdHVyZS4gTGVnYWN5IEJBUiBlbXVsYXRpb24gaXMgZXhw
b3NlZCB2aWEgdGhlIGV4dGVuZGVkIGNhcGFiaWxpdHkgd2UgZGlzY3Vzc2VkIHByb3ZpZGluZyB0
aGUgbG9jYXRpb24uDQogDQo+ID4NCj4gPiA+ID4gUmlnaHQsIGl0IGRvZXNu4oCZdC4gQnV0IHNw
ZWMgc2hvdWxkbuKAmXQgd3JpdGUgQkFSMCBpcyBvbmx5IGZvcg0KPiA+ID4gPiBsZWdhY3kgTU1J
Tw0KPiA+ID4gZW11bGF0aW9uLCB0aGF0IHdvdWxkIHByZXZlbnQgQkFSMCB1c2FnZS4NCj4gPiA+
DQo+ID4gPiBIb3cgY2FuIGl0IGJlIHByZXZlbnRlZD8gQ2FuIHlvdSBnaXZlIG1lIGFuIGV4YW1w
bGU/DQo+ID4NCj4gPiBJIG1lYW4gdG8gc2F5LCB0aGF0IHNheSBpZiB3ZSB3cml0ZSBhIHNwZWMg
bGlrZSBiZWxvdywNCj4gPg0KPiA+IEEgZGV2aWNlIGV4cG9zZXMgQkFSIDAgb2Ygc2l6ZSBYIGJ5
dGVzIGZvciBzdXBwb3J0aW5nIGxlZ2FjeSBjb25maWd1cmF0aW9uDQo+IGFuZCBkZXZpY2Ugc3Bl
Y2lmaWMgcmVnaXN0ZXJzIGFzIG1lbW9yeSBtYXBwZWQgcmVnaW9uLg0KPiA+DQo+IA0KPiBPaywg
aXQgbG9va3MganVzdCBhIG1hdHRlciBvZiBob3cgdGhlIHNwZWMgaXMgd3JpdHRlbi4gVGhlIHBy
b2JsZW1hdGljIHBhcnQgaXMgdGhhdA0KPiBpdCB0cmllcyB0byBlbmZvcmNlIGEgc2l6ZSB3aGlj
aCBpcyBzdWJvcHRpbWFsLg0KPiANCj4gV2hhdCdzIGhhcyBiZWVuIGRvbmUgaXM6DQo+IA0KPiAi
DQo+IFRyYW5zaXRpb25hbCBkZXZpY2VzIE1VU1QgZXhwb3NlIHRoZSBMZWdhY3kgSW50ZXJmYWNl
IGluIEkvTyBzcGFjZSBpbiBCQVIwLg0KPiAiDQo+IA0KPiBXaXRob3V0IG1lbnRpb25pbmcgdGhl
IHNpemUuDQoNCkZvciBuZXcgbGVnYWN5IE1NSU8gcmVnaXN0ZXJzIGNhbiBiZSBpbXBsZW1lbnRl
ZCBhcyBCQVIwIHdpdGggc2FtZSBzaXplLiBCdXQgYmV0dGVyIHRvIG5vdCBwbGFjZSBzdWNoIHJl
c3RyaWN0aW9uIGxpa2UgYWJvdmUgd29yZGluZy4NCg==

