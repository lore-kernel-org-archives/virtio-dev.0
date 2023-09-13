Return-Path: <virtio-dev-return-13728-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBB5EE49B7
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 02:23:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EF978F3F4E
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 02:23:13 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E25D5986662
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 02:23:13 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D5F5A986637; Wed, 13 Sep 2023 02:23:13 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C0EFF986630;
	Wed, 13 Sep 2023 02:23:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jp2AxD3qHNshoFr20nRoqJLauY/1iJVgOARLo2R+b/hxW6f9xEaZ1yHLuA53nLDLQktdbGMOJFWzt0w9qA/FIHN1bhfnApKJlKbZQjvQ+ZMFGJt9fya/sw5aiDx0tizg+vnUmT91COSKXlPLEyTHfJqHnUa5HLb69YYHtHx3/2NHyWf9pZ9UJ9D1ZMtc7XzVEsnRnXCtGI0fvd4qz/rO4auyw/xSxzETYuYLJh+mOPgHh+XDVckTW04DX6kqTla4igL+Fh4pKjlvBeNZ29HLwIfGK8LOLP7TjMPAjuTNH/m49xwTsS1mkCiW68CuiPmGaMjjFRasv6mRvAygejq6Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pgfJYZCPAve3NlmxBKcxsyo63dcNfYC50DGQXZieEnk=;
 b=UFAl7gUErSPk9jlkGUvRL/GSCRiP+njgZeWrGYKlYtUOpemLm64L+iTDU5PPGWLOWQWtil4vO1WPP0WZiUMRXcQXnEDbOnrnc3nH2gXxztUqeltjgv2vC3tGcP4+BJXupsJtCml9C6+PppgMGJSqdoXjwjVliVJCC95+otO/IsRSSO8HHKKzp/lY0SrWNcSxkCnBPXJNlJrhEVvnb1CfX9dEoQ+TVmMqsDhx3Kw45QcWP9/eDgdmcTjFafdMINVSvmdmSx2+sxeY+uaVCvcjHc3banKD70ul4nxAOlVZZVObIgWNwh8VUNwAEx0qMprWzttUpKUdafg2X7H5L7Dx8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "eperezma@redhat.com"
	<eperezma@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE
Thread-Index:
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAAFdACAAACHUIAABQ0AgAAAWWCAAArYgIAAAHNwgAANI4CAAABkAIAADHeAgAAlTICAAQzqAIAAIezQgAANVgCAAALLcIAAC5qAgAAEIzCAABbWAIAAAKAAgAAF4bCAAAyxAIABDe5g
Date: Wed, 13 Sep 2023 02:23:06 +0000
Message-ID:
 <PH0PR12MB5481EF64F3BA3D13C34D016EDCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <PH0PR12MB5481D11A7DF45292103D9290DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <88b8b14c-88d8-1f76-0e6e-7b5f334171f1@intel.com>
 <PH0PR12MB5481CBE0CDFF4ACD712F371CDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2b3e8da1-5cbb-f990-0c1d-c0e894a73486@intel.com>
 <PH0PR12MB5481E8114A659954251F17DCDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <17514b93-2da4-42b3-a5bf-b96358a7a875@intel.com>
 <PH0PR12MB5481F236858D5CD97EF55732DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <9fabd346-9b6f-a727-3de8-813ec3570772@intel.com>
 <PH0PR12MB5481468378DC1E5491A5427CDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2baee870-bf38-5d83-0543-1d0a68f8e651@intel.com>
 <PH0PR12MB5481A26B62962979C19280D2DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <8bd1c228-856a-9454-752d-750997c4f4db@intel.com>
 <4c195683-0eb8-5e92-d97a-217cfa8af760@intel.com>
 <PH0PR12MB5481860AEAD92C74A5BC19F6DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f132cd22-e2e1-971a-894a-d62aa7ca6334@intel.com>
In-Reply-To: <f132cd22-e2e1-971a-894a-d62aa7ca6334@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY8PR12MB8338:EE_
x-ms-office365-filtering-correlation-id: c3a527d3-55fa-406f-f808-08dbb4005d50
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5YxIGZM5mn7TS2v1HV2qAjiBkp650ho4DD+vECLSoBkvQZUEfcLA5ZAZc6LLpdEfSIFTyGYvt0087/cU7+XjlPOZm4nU/67gd3+t2bDjXaUwWiYPiZlmECWqBs3jvdAN/mUJY+L29K+U8T8b9Wf0RZGE3ugzwOWvilQrva49swQ5A3xJYhveRDFI5E1KSx/k1VHvQqe9mae4raqiPCZaitDs+WUFF2wVQKOBceOtU34zkEllq7smxIiX7FDD2DYDBohS4EzND6GlxuRr+t5PXD0OETAZZkxkoQ+wTdBA1Hv/hsv3IwwPM/xMPoPfwTDd0+9OxW5IHgxipE+BK4YkvTTldKdOFuW/PygRBS3WCweDQehmvEZ/jk5haS//+S676+8Snd+1zZu/IUR5P7LhV4Ehhas+a842KbeNDKYAebDwANEaM1uxxQAs7JccO1LJt12X6+vIrPnV+eJ0OuiDYpV1qc74r6rwenTDOypJKLZIZn7n2P67KIDMnTX/jZuOrOyreodQiySvOAEMlQ2domjunlJJ1wZG1R5COTwT53Kn/XqtRpP1DxRIP4eatfV0KOLxRcDqRj5UlNbEhfkTfqSlr7PwLcWllsCHbYZGnktcAuRHPQr32ew8Ntnjj2dw3wTwEaVgz1pThRZYIedsUddnuXeHAkV58Fq6kQMMEn8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(376002)(136003)(346002)(1800799009)(451199024)(186009)(8676002)(41300700001)(8936002)(4326008)(110136005)(4744005)(54906003)(66556008)(52536014)(5660300002)(66476007)(76116006)(64756008)(66446008)(66946007)(316002)(2906002)(122000001)(38100700002)(83380400001)(38070700005)(55016003)(26005)(966005)(86362001)(478600001)(71200400001)(9686003)(7696005)(33656002)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K1FsdW9ldmg3ZHh6NEQyNmNXU21Kb21qOWpCZUI3U1lsYXdiei9CdmVsWlpL?=
 =?utf-8?B?VVczU2YreDYzaFpOS283aGVIa08zMUQ3K2pmU1QwU0p0eDhPaG9KaUdiaGNH?=
 =?utf-8?B?dzA0U0ZXNEVPWTFDZWJkc1c4ZmJSaGJCYkVyUlNFck1PMnEyVDMwODcwWFFY?=
 =?utf-8?B?UU9TM0t0MTNMWXlsRGRSckJvQkJEV1JSa1hPUEhBL3RLbzN1dXQ2dmhaYUNK?=
 =?utf-8?B?c1NFK01VVWd1UmJha2FzbWppK21oQjk4ZFdDcTZac1dCWmJBSUxxOW9VZzVp?=
 =?utf-8?B?SG9yVTdWRCtFendsSml2UFViZVpSclRtR0Rwb01tOU9wZjJENmE1Z01qUHp3?=
 =?utf-8?B?MHVBMVZJWW1wUWFwaTc3eUg1VzBHUVNFZjAzL2djMnp5QkZYVUVWcGFyNFJI?=
 =?utf-8?B?ekx3clBPZk9heWhoV2dCT1RuV21RZjE5MnN1ckphalZTbnJiL3FDZlpwdDJr?=
 =?utf-8?B?NHhtQmx3dDhSTzcyY0p6cDBTUmN6ZlBISzdtUnBPZWJnditUcXU0L1J6YjFk?=
 =?utf-8?B?WHdTcE9rcGlZSUhLK09NMDRpM2tFNmM2eW0rZGt2VEN4bXhKNSszYk1KQWt5?=
 =?utf-8?B?Q2dxVmJkODNYRDhCckpDQndTUlhoakhUV2dqNXdwM1Jxb3NPNHZkQytUdVQy?=
 =?utf-8?B?T1luVUFpTnhNNkdmcnRMVXZpKzBmMjQybWxueno2aUxBcU1EZkt5K2w4VFlJ?=
 =?utf-8?B?NXdzZXlwVUJCdDkxWlhyc1BZeDZ6NFR1WUVvME5uSEdSS3R0YUxCY09NUEFr?=
 =?utf-8?B?cWVBVlJKTDdQL0NFR0xOTVNLU1dUZVdoZXRwSi9WcnhXQVBNODRNWGswazlF?=
 =?utf-8?B?UStFOG5TZmh1aXlOWXpXZ3ZGVG1DamNaeTJQZktrK1ZwK09NL094WTVWQ1lR?=
 =?utf-8?B?clF0MG5YeXFFT2lRZ1pVU3FVYXRCUmR1VFVFSU1pejdud3F3ZlAzVXY3T05I?=
 =?utf-8?B?NHl4MXdDbWsvdzZSclBZOEM3bzYxV0p2WWF3Um8yOUpYZEh1dWxvU2tYYnN4?=
 =?utf-8?B?NmxPOWhpVndlMUtqU3V1SkoyTFhlaWtDUW5JdjMwaVVQQmRaaFJvY2RoUzQ0?=
 =?utf-8?B?SHBwTmIzdDdZTTJuR0I3NFNZTkNSZGkyeUU3dHVUVnJ4WWtZQlR2ZlhLclNi?=
 =?utf-8?B?S2tsUDNLdDlLYWZuM2RkRUtKOGZKYjNFVWVVWEk4SEtmb3BNVFpLTWN6VHFG?=
 =?utf-8?B?cy9Sdkg0U2hlaVVOdXFMOGN6SklaNDRTay92VHZpQXp2TjB6cUttbm5ucFVv?=
 =?utf-8?B?QURGdnlGV3hTTmVBTnI1dVc1T3BObjhzUkw2eXdLaVVUSkFESlJFT0FPc3R2?=
 =?utf-8?B?Q0EwZys3dG9lSzkxTFZEejdqQWRwVjlqWTJjNjZhYnFIcHdnZnJwN2NmR0dH?=
 =?utf-8?B?TFlpUjhwZ3Y4WkxMM1dEaTFsRGFHNHlDNUlnTWtleGc1L1BaNXBmOGp6S3Rh?=
 =?utf-8?B?amVJTUZFK1daK29jMzBFb3VYdmFqWkM4blRiblJORDlJdFpsR3RUMmUyUVEy?=
 =?utf-8?B?akp1WXhFenYyNkRRcWJzaldkZkFiSndVc0dsTGgxWHIyVzlFdzFWNDRwbHZt?=
 =?utf-8?B?WitMYU9Jb2ROZUtHRVJ0QzlNSk91M016bjdLMUFod3pabmRkdGlwOGFBODE5?=
 =?utf-8?B?UGsxTnF2Mnp2QTYzMTZnQitnNmpleEtWQ0xES0xRODNXN3ZHcnoyS3I5bExv?=
 =?utf-8?B?NGdNQ2VqWVNBTHlINWhFSmszWCtpeXlpNWYxdmNLekRMMGQ5ZTRubElvdDMy?=
 =?utf-8?B?dEhmV3FMUDI4bDZjMG13dDk4cC9kTzBaeHZPdmlFTjJISjBBOVlaYThVem1Z?=
 =?utf-8?B?a2ZUeUJENWo1RXRCRU9FK3U4bEk0bk1wckpCWCtWV0JYZVVJdG9KNFZBYlJr?=
 =?utf-8?B?cDRReFZYd3RPMnBRa3JNY2NYQXZGNHphcWpvVHZ1YlRyTkptUHU4eVZrc1RG?=
 =?utf-8?B?cjQ2V1pzeERvaVdCYmdFR21qWkJvTG5vdUU3citYVUYyY1NnMldqVkhtdXc5?=
 =?utf-8?B?dGFRSmhNSVE4NEt5NEhvWmQralFVanN4TDRCU3pEakIxMXpFelNzNG00a3Bm?=
 =?utf-8?B?dHltelRaNkp5MmtGVzdaTzZoOG1jOHhkMnhFNzJ5QUZDTW5Jc210dlRUbXJn?=
 =?utf-8?Q?ecqE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a527d3-55fa-406f-f808-08dbb4005d50
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 02:23:06.1040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zoacCknOwg5kWi7J8Kue22+ItN/BVJdDoCAvnA/qqpTmIXxUezb/HxavOJZGuEGengumNJU7PdBkq8G7WoIj4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8338
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IFR1ZXNkYXksIFNlcHRlbWJlciAxMiwgMjAyMyAzOjQ1IFBNDQoNCj4gPiBEbyB5b3UgZmluZCB0
aGUgYWRtaW5pc3RyYXRpb24gY29tbWFuZHMgd2UgcHJvcG9zZWQgaW4gWzFdIHVzZWZ1bCBmb3IN
Cj4gbmVzdGVkIGNhc2U/DQo+ID4gSWYgbm90LCBib3RoIHdpbGwgbGlrZWx5IGRpdmVyZ2UuDQo+
IE5vdCB0aWxsIG5vdy4NCg0KSSBkb27igJl0IHRoaW5rIHlvdSByZXZpZXdlZCBbMV0gZW5vdWdo
Lg0KRm9sbG93aW5nIGZ1bmN0aW9uYWxpdHkgdGhhdCB5b3Ugd2FudCB0byBwb3N0IGluIHYxIGlz
IGFscmVhZHkgY292ZXJlZC4NCldoeSBjYW5ub3QgeW91IHVzZSBpdCBmcm9tIFsxXT8NCg0KYS4g
RGlydHkgcGFnZSB0cmFja2luZyAod3JpdGUgcmVjb3JkaW5nIGluIFsxXSksIA0KYi4gZGV2aWNl
IHN1c3BlbmQvcmVzdW1lIChtb2RlIHNldHRpbmcpDQpjLiBpbmZsaWdodCBkZXNjcmlwdG9ycyAo
ZGV2aWNlIGNvbnRleHQpDQoNClsxXSBodHRwczovL2xpc3RzLm9hc2lzLW9wZW4ub3JnL2FyY2hp
dmVzL3ZpcnRpby1jb21tZW50LzIwMjMwOS9tc2cwMDA2MS5odG1sDQoNCg0K

