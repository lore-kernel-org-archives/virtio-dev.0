Return-Path: <virtio-dev-return-13991-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2018CE95A96
	for <virtio-dev@archiver.kernel.org>; Mon,  9 Oct 2023 10:08:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 86B222AEE2
	for <virtio-dev@archiver.kernel.org>; Mon,  9 Oct 2023 10:08:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6F317986549
	for <virtio-dev@archiver.kernel.org>; Mon,  9 Oct 2023 10:08:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 60DCC9864CE; Mon,  9 Oct 2023 10:08:14 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4C0D09864D3;
	Mon,  9 Oct 2023 10:08:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gG7203Uq3BHKyLQaAWLRNCUIBTOON6exQ5hHh5XF+v9odJ/Xp08NzR8sFUVejYUkVlkoSQ5DbYxw0xZhdQI5M1taf7fkhkmoGBZJuid1TXhQW0owkrDXznzSk0c5RW9/kpeRLzHoOXAHilQi9P2zTVkz7/uqYK14c7nWUYuxd5D4wwmrsEllRXbdcPKmNJOEzNbKfVzefS17UEPIlxELW/4gYjhTChM5eswl4hUtcJFQKvys4KY+ti/sc5DLJQDHren8VdljoJSU8wGUy8nLCEor9tUevXEIsEqR1I9mhW57aUXnQzMjFAsHyMyCqvpUIXahxLDD1hnczTKdOFanPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFSQN6QWi0FzddoWiDVRccZlujjZZNlOdcML7uqSFuc=;
 b=PKtcKR3OfHcrBIBLSHTahoL2tNOsFxW4uF4QeLB+PA7f/h2NHdP2shVgk1fyOsTIHKSqR0wrK/ROhAfQox3PMETS3j4FMwpWTlaohh2+pV/CRmSMomo8N9pAeebHP3/mp/4icNxtv8hufCQ/CfWEp5UtFeL+e0lKCL6Gji/X86YbV2Ipl97+HDDHTjl6dSmVf9qyIalE4fKDO+xgyRN4HcrNnLLpJTzdcfsWf5VYwaGLH6Ju/8nHLVCDeUloCDuQsfRuxQXbNiArip8g3iTr/VNdTXNhW+BwYWMW6YjZ4qqlEkFZn0Iu03lkL/hLHWU2APPfVq6/3n3e9HkT7k10gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, "eperezma@redhat.com"
	<eperezma@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state
Thread-Index:
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAC3dgIAAl98QgAADDoCAAk+KgIAAS2wAgAEX5ACAAAnDsIAABJcAgAAA3ECAAYB3gIAFKIMAgAEae4CAAAfOcIAAKAeAgAADn6CAADxKAIAAF0QAgAFot4CAACROoIAS1T8AgAAASoA=
Date: Mon, 9 Oct 2023 10:07:56 +0000
Message-ID:
 <DM8PR12MB5480708567861AD8DDEC0EC0DCCEA@DM8PR12MB5480.namprd12.prod.outlook.com>
References:
 <PH0PR12MB5481830365A80EF4583A3FFADCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEshxAU3Mjo7vczBNRb=P=FnenO4mPb9HJL0Ma3ZRbe-oA@mail.gmail.com>
 <PH0PR12MB548172996D62E37714A9776BDCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtW88zJkDQL58NqLzzudq=f+SmzJ8bha55Dd2fd=FRGBQ@mail.gmail.com>
 <PH0PR12MB5481573D6EE3BE03FB7C3D70DCFCA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEvOxraeVB-5g7dJ-KBN=63kpmDfDdqaiQVyDh8egDjsGw@mail.gmail.com>
 <PH0PR12MB5481C11F6D68A892A091E2AFDCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <e9c482d5-1441-fec5-b55b-f1ac6e81f85b@intel.com>
 <PH0PR12MB5481C57B255B0D5EA6FB109DDCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ddbd47c8-6985-2d08-bf98-0e7516f0c3c4@intel.com>
 <20230926064201-mutt-send-email-mst@kernel.org>
 <305d9907-9668-d362-1ff2-49a5e9f90e42@intel.com>
 <PH0PR12MB54816B064AD08754C7D86AD8DCC2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <3539f99f-2770-428f-2b44-b7ac5a1a0407@intel.com>
In-Reply-To: <3539f99f-2770-428f-2b44-b7ac5a1a0407@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5480:EE_|MW6PR12MB8705:EE_
x-ms-office365-filtering-correlation-id: d4a1d3cb-ffb1-4155-a0d8-08dbc8af9bdc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 w+NZrZ7VX7bJQOb+Qfkaaf1xoXoEBjEqFwmLegIJ91UUKnoHl849kBjnnJ7RIivRzd85GIWriQDgMQjke/pA/4dxJPlkiHknSH+3KIvxyZbc6ps8mghGQvVlItqKGYBHPWJmXzukyxDiKnjynGMSsRDNEYTstOMk+r7Nps9cd/z2ZtFXgcnTfouf4jqmSO2UmsirIkDI5pSIk77bDstq86gP4a32L4ZyEUcBtV2O4w9f2FC1Inpkiin861c4dqQfasdRalDuudBLMjvW4SnEp4JGRdRnW0vL26aZT1gFNGz/ESKNkfjBMe00aXTrDcm/x2ASr8xIBejPs2pA6YvKjFyXAY0oz2xpnBqT0mK5q4GnJ+roajNq8GlBuILFk508ptjPIzb4VzMHYGn84rsAvohe+xUo5SjfGbQG50lzaf8lt1AcF3GUt41S0aVsJFrDsd99RfRCHq3YSyZ4FD9YM0HylszRqPBIUXF2JWoVds/HrJj3lNFQfO4FINWZbftG5GNrirZsFSKMBMzdDYFg+O1tgHLhmJVSgfZ0jS7q2XL0iBHyrm/QzVTZx9RHatf/xjCom53d6xOn0Xp3HpbCln3a7ysjEhHNh10eOiH25LMoiwcQbDxbOVuKMdwI1QJm
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5480.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6506007)(53546011)(7696005)(9686003)(55016003)(38070700005)(33656002)(86362001)(122000001)(38100700002)(26005)(83380400001)(2906002)(15650500001)(71200400001)(478600001)(41300700001)(8676002)(4326008)(52536014)(8936002)(316002)(66476007)(5660300002)(66446008)(110136005)(76116006)(66556008)(64756008)(66946007)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ait3eU5vcXd3Z0NQRlI1ZFRqUVI3eTFRRkt5OWVDZVNteHR6R1BHSkZFOGV6?=
 =?utf-8?B?cVVJOVVtbjd5dTBRWkpyZDlEV0x4SjdqMnpuK3FZNjlsL2phbjU4WjdGbTVQ?=
 =?utf-8?B?cEtxazh4dU1YR2F1UGRrRDVVY1h5Wm9yQ3lBMkNhR3Z0aUVVbUtYM2xuaGIv?=
 =?utf-8?B?RlFsTmpLdnRjemtuRUw3dGpCRUpTdjQvQUZCRysrazB3Z29DQ1ZNME4wajI5?=
 =?utf-8?B?SHRQenIrYTRoS1plRWI2M1h6OHozQ3gya1JMWnBQQ0o5Q0Z1SjN3bmVxcFpu?=
 =?utf-8?B?L1E4QUlVYlF2dk13b3cwWlVkK1BVRWIwTkNwV2FhS015cy9rNGgyRDNMU1F1?=
 =?utf-8?B?bFdWU2hJZ0Q2bUZieVVnVEg3ZGlDTHBDV0hkNzF5WTV1cmZRS2h4RFZnMjNP?=
 =?utf-8?B?VzhvRWRCdWErbHJ2MFlTcytwVi9KT2NRdTZlQjBnamtRd1NmSW8vSGZFbjBT?=
 =?utf-8?B?YkVOUlc0SVQxRTlQdkVOVjRUdFk2cTY0enczaTdoNUt2dXQ4ditJTmFvY0l6?=
 =?utf-8?B?SzBqeVk3WUE0bG9IRnlVVXNvK3poR0NOY3BCL1VVcDBvVDBMSkFsTVg1MVla?=
 =?utf-8?B?S3YzdXpETFpvZXNSOHhBeDQyaTR2dklFUUZTOHNDOEk0VWRVbVFxSjkxU3dU?=
 =?utf-8?B?cUtXSldVY1ZwZnJOZHlrbDFpQ1BWdzJNSGRTRDdneW8xTUNTTDVkN0syc2dw?=
 =?utf-8?B?MldsODNYRVpXZXl3R2Q5VTdRZkVkZU9pUXNWTkF6UnNWTkpPLy9BeVovWFAz?=
 =?utf-8?B?amx5cGIxRERtM1V4YzVVa3JZbU92aDNYanhQK2dmVjNwamZlc2RFeGVTclBX?=
 =?utf-8?B?Wi96aS9hTEd3NXlHK3dRQlpFem1XWFlYL0x6ck4rWHp3OXhkRlVyV2FRZG1L?=
 =?utf-8?B?Q3Nnc3FCaXRPdmU0M1FCOVBuclhMUHVUeEh1OVZtVXhaT2dLeWY5bkFBWG02?=
 =?utf-8?B?dFFtaWQ1NlhCL0xuMFMxR3h5Y0xwOFRBNWVSZ1RmRUJSdFNIVDZ4ME9FNnNh?=
 =?utf-8?B?bHQvRzhYb2M3dmFMYjJhY3JNN3dwKzBjRWJaME45Q3A5U3RObGhhZ0R2WUFJ?=
 =?utf-8?B?UHdpRnp0WXBicWd4L2hHa0tlZlVJSHNVUnBPa2gveUhZeGg0MVpZSlJwTkNX?=
 =?utf-8?B?VFRHYVMvZHJkMW9mZGw3c3hLbnRqejFYUlFzcnc0YjhTT1VUOEpsN0d1cmV5?=
 =?utf-8?B?M1EvU3RSUnpiRGJmU2d4ZjU4Z3p2YUtCREd6bjF0OHE4Rm95WlcyREdiK3J2?=
 =?utf-8?B?V0FRVzZkdFRDUFZwQklxRFZqQWZPbWJvbWZJUUtxcmNhL21kWXFraXp3aWVF?=
 =?utf-8?B?U1RJejg0WVZ5WWpyU3N0Y3REaXI2QjJOd2ZKRDdqc1M0UzJZSzg4eGRCMVdp?=
 =?utf-8?B?S1YxQ2t4b3NSN3haVVk1RGpTdHV6bkd4MjNoRk9pNzVacmNHejQ0K2JaWm1Q?=
 =?utf-8?B?YU0yR2s0cVpZSjRLbkdqa0hSbFRScHdhSXBDTkFCQVNqNFVpaFBEZjJ0alA0?=
 =?utf-8?B?QkRIUjJ2WkIva3UrNG9QdEpHUFdUTzkrZ1lRMEs4bVBrR1dkK05STEo3QTVX?=
 =?utf-8?B?UWo5UkRmNHFIVzRrL1YwQldqcGRpMy83NXNNZFB0Zmw4ZnEzc3R2V0R2dTNt?=
 =?utf-8?B?QUNmbXBnWDFtWUJ6NDNNUnpCbGs3TDFRYVA3bDFOUWFnais4anQ5S05WOFRB?=
 =?utf-8?B?YTRNS0MwekpqNlBQbERFR1Mvb2FlYXl3VTZWbmxpeGhzOUZIR29zazQ5MUpu?=
 =?utf-8?B?a05IaVRpdlo5ZTk1NkJkbXVhK09zR3d2d3IrcWZoOGxBWjBMSXh6Z3U3M2tx?=
 =?utf-8?B?N010bzRzaFZIdHdkQVE0VlhVaEl3MXhsaFVxRlpkZFY4dnJYWmh6ODFjT2kx?=
 =?utf-8?B?YkRXUkRLdHpBbTNFOUNUMXdIa1YzZ1dVR3A3eHVjYWlTVSt6d2hjVTJ1M3Uy?=
 =?utf-8?B?QUk1NEFSUnpGd0w4bmRhc2pMZkxUbitZem4zYkZ3MStYNkZRSGJYTXlkcE5W?=
 =?utf-8?B?QzU5R1pMYjNNWHY4Wjg1dmduVnJ0NXFXQU5kSTkrbXhaelJ3M1RIUG96dGFB?=
 =?utf-8?B?YzVmN1pxeXkvVTdvemVTMjVtQ21udEJwQWQ5akdEVSthUjhqL1JiNFNydThk?=
 =?utf-8?Q?XJMo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5480.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4a1d3cb-ffb1-4155-a0d8-08dbc8af9bdc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 10:07:56.2227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FBzcbE+v4K/Zz9QKyW6Umg0BHtGpTQx/4N/T1FFrV7c3fwCxrwiF4o8c8KuZ1Z+WAxW3tjl4MjSGXgmnQEEGOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8705
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IE1vbmRheSwgT2N0b2JlciA5LCAyMDIzIDM6MzYgUE0NCj4gDQo+IE9uIDkvMjcvMjAyMyA2OjM5
IFBNLCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+ID4NCj4gPj4gRnJvbTogWmh1LCBMaW5nc2hhbiA8
bGluZ3NoYW4uemh1QGludGVsLmNvbT4NCj4gPj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIg
MjcsIDIwMjMgMTo1MCBQTSBJIHNlZSBoaXMgcHJvcG9zYWwgY2FuOg0KPiA+PiAxKSBtZWV0IHNv
bWUgY3VzdG9tZXJzIHJlcXVpcmVtZW50cyB3aXRob3V0IG5lc3RlZCBhbmQgYmFyZS1tZXRhbA0K
PiA+PiAyKSBhbGlnbiB3aXRoIE52aWRpYSBwcm9kdWN0aW9uDQo+ID4gU2xpZ2h0bHkgaW5hY2N1
cmF0ZS4NCj4gPiBUaGUgd29yayBwcm9kdWNlZCBpcyBmb3IgdGhlIHZpcnRpbyBzcGVjIHVwZGF0
ZSBmb3IgdGhlIHVzZXJzLg0KPiA+DQo+ID4gSSBoYXZlIG1pc3NlZCBhZGRpbmcgb3RoZXIgY29u
dHJpYnV0b3JzIFNpZ24tb2ZmIHdobyBhbHNvIHNoYXJlIHNpbWlsYXIgdXNlDQo+IGNhc2VzLCB3
aGljaCBJIHdpbGwgYWRkIGluIHYxLg0KPiA+DQo+ID4+IDMpIGVhc2llciB0byBlbXVsYXRlIGJ5
IG9uYm9hcmQgU09DDQo+ID4+DQo+ID4+IFRoZSBnZW5lcmFsIHB1cnBvc2Ugb2YgaGlzIHByb3Bv
c2FsIGFuZCBtaW5lIGFyZSBhbGlnbmVkOiBtaWdyYXRlIHZpcnRpbw0KPiANCj4gPj4gZGV2aWNl
cy4NCj4gPj4NCj4gPiBHcmVhdC4NCj4gPg0KPiA+PiBKYXNvbiBoYXMgZXZlciBwcm9wb3NlZCB0
byBjb2xsYWJvcmF0ZSwgcGxlYXNlIGFsbG93IG1lIHF1b3RlIGhpcyBwcm9wb3NhbDoNCj4gPj4N
Cj4gPj4gIg0KPiA+PiBMZXQgbWUgcmVwZWF0IG9uY2UgYWdhaW4gaGVyZSBmb3IgdGhlIHBvc3Np
YmxlIHN0ZXBzIHRvIGNvbGxhYm9yYXRpb246DQo+ID4+DQo+ID4+IDEpIGRlZmluZSB2aXJ0cXVl
dWUgc3RhdGUsIGluZmxpZ2h0IGRlc2NyaXB0b3JzIGluIHRoZSBzZWN0aW9uIG9mDQo+ID4+IGJh
c2ljIGZhY2lsaXR5IGJ1dCBub3QgdW5kZXIgdGhlIGFkbWluIGNvbW1hbmRzDQo+ID4+IDIpIGRl
ZmluZSB0aGUgZGlydHkgcGFnZSB0cmFja2luZywgZGV2aWNlIGNvbnRleHQvc3RhdGVzIGluIHRo
ZQ0KPiA+PiBzZWN0aW9uIG9mIGJhc2ljIGZhY2lsaXR5IGJ1dCBub3QgdW5kZXIgdGhlIGFkbWlu
IGNvbW1hbmRzDQo+ID4+IDMpIGRlZmluZSB0cmFuc3BvcnQgc3BlY2lmaWMgaW50ZXJmYWNlcyBv
ciBhZG1pbiBjb21tYW5kcyB0byBhY2Nlc3MNCj4gPj4gdGhlbSAiDQo+ID4+DQo+ID4+IEkgdG90
YWxseSBhZ3JlZSB3aXRoIGhpcyBwcm9wb3NhbC4NCj4gPiBXZSBzdGFydGVkIGRpc2N1c3Npbmcg
c29tZSBvZiB0aGUgaXQuDQo+ID4gSWYgSSBkcmF3IHBhcmFsbGVscywgb25lIHNob3VsZCBub3Qg
c2F5ICJkZXRhY2ggZGVzY3JpcHRvcnMgZnJvbSB2aXJ0cXVldWUiIGZvcg0KPiB0aGUgaW5mcmFz
dHJ1Y3R1cmUgdGhhdCBleGlzdHMgaW4gdGhlIGJhc2ljIGZhY2lsaXRpZXMuDQo+ID4gSWYgc28s
IG9uZSBzaG91bGQgZXhwbGFpbiB0aGUgdGVjaG5pY2FsIGRlc2lnbiByZWFzb24gYW5kIGl0IHdv
dWxkIG1ha2Ugc2Vuc2UuDQo+IG5vdCBzdXJlIHdoYXQgaXPCoCAiZGV0YWNoIGRlc2NyaXB0b3Jz
IGZyb20gdmlydHF1ZXVlIiwgYnV0IGFkbWluIHZxIGNhcnJpZXMNCj4gY29tbWFuZHMgYW55d2F5
Lg0KPiA+DQo+ID4gU28gbGV0J3MgZGlzY3VzcyBpdC4NCj4gPiBJIGxpa2UgdG8gYmV0dGVyIHVu
ZGVyc3RhbmQgdGhlIF9yZWFsXyB0ZWNobmljYWwgcmVhc29uIGZvciBkZXRhY2hpbmcgaXQuDQo+
IHNvIHBsZWFzZSB0byBvciBjYyBtZSBpbiB5b3VyIHNlcmllcy4NClN1cmUsIHdpbGwgZG8gaXQg
aW4gdGhlIHYyLg0KSmFzb24gYWxyZWFkeSBhZGRlZCB5b3UgaW4gdGhlIHYxLg0KSXQgaXMgYWxy
ZWFkeSBpbiB0aGUgdmlydGlvLWNvbW1lbnQgbWFpbGluZyBsaXN0LCBzbyBmb3Igbm93IHlvdSBj
YW4gcmVzcG9uZCB0byB2MS4NCg==

