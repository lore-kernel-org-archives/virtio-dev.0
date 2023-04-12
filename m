Return-Path: <virtio-dev-return-12156-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0057C77B70
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 00:40:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D7FE542BC8
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 00:40:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CF362986617
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 00:40:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C42FC986514; Wed, 12 Apr 2023 00:40:58 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AD7DE9864B3;
	Wed, 12 Apr 2023 00:40:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTSs6Iq09G5fuhmrTqsXiTasKFFkka27NkFaLjSxa30Tcq+gcc2+TQepLm1v1ohssLpvFxuYfgyQgx/3Sf96fDrWO3Y//+MkQqY2OD8zzqaRJ2ku6M75CfpFDw4Il9xT1I9vXg58/ECfKhUSapW0Ny4pCgbLZ5mpynKlu4LCq2CUBWZ7/9npYetIp+oDGf3IVKEgUAak6Qc9Ud52DLrPzVHtNZmv2dyY9X2mArveOGbs8enEnQIGb/Oz5PH7aBrW4ElIdeNhd47tLCDaLvzOS+DL4eZ1/+2/E5X4nt3xxXfObNupP+A8CsZ57kGhJ3boT/O8jYe7WOBPNu2o5AnEWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=49aUzeoa4ewtBKFS5pZa8GNA8cWIyBd179kxIHZnjbg=;
 b=GupNQfLyXx54zDx6fl6F5qUyIR6n2fXU5n4jku220K2BvRLPLlJ0VcCewEgtkxnckp5geukRyxISagwagtYJQ2YvVBCIRwR4Kj2rOMlfQE31+R/QjTsqa0Jt+qw7bUq3K7LyepgmP/rGRot4Wzlxll+KolvOwyC24JOOV/ve47qYn12anlTpXB4nSMB/jDa/5G1YdtwKpmpEJ5qo3E/keCGyoDjLWbcDmDP66TWKBUGhR7CbtZjoHjAq7MC/4S5R4z7hsbsuonQlvhSSwohf4St7eU0eE0ZdE7t+xBV8/b/p0hQjC7qmCn2RydQj2qtxsf5aIcmPa4rd0Ysmu+trzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>, Satananda Burla <sburla@marvell.com>
Thread-Topic: [virtio-dev] [PATCH 08/11] transport-pci: Introduce virtio
 extended capability
Thread-Index:
 AQHZY1tK9bYi+VUlRk+f1PKXMn2Qra8j0vmAgAERMACAAKCVAIABAn+QgAAqMoCAADWlkA==
Date: Wed, 12 Apr 2023 00:40:53 +0000
Message-ID:
 <PH0PR12MB5481D2F7893E4FBA32837EFFDC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230330225834.506969-1-parav@nvidia.com>
 <20230330225834.506969-9-parav@nvidia.com>
 <CACGkMEtMOy4B-O-52ka+9P3OBQ_hs1KvdjWodNYg-XKLff+giw@mail.gmail.com>
 <307a9f8f-6184-0403-97ab-1b1c16d4fd3c@nvidia.com>
 <CACGkMEucOwwFDMqyWA+DgYV7X=9f5-P4Ba_AP=5kTsjna=n+7A@mail.gmail.com>
 <PH0PR12MB548194B46A3E32329C10D00EDC9A9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230411172207-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230411172207-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MN2PR12MB4272:EE_
x-ms-office365-filtering-correlation-id: e925ae2c-43cc-4fec-ca35-08db3aee929b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 REoWqGFi42Dnhy4+4LN4P6fiRE5NxR7VHjJ7lCfRcLW25orElHP0bWM+aIkN667xMzTnaoJNBFBukpGP4OYWyQvLNJlg2JzfgAft0Iu5tgEFKKl5YUKlzs0fkHDvCW8wwTHJWmpK9IyyXEHmdaiT8tHzvYAI6xoWGHi4WN0GuxqwGB3ZS95bWAoreNm98pGJz7cONMY/EaYyomeKhacG554v4KUqPz5Z4CEHp7E9qWSS2oMDZWwjjgnvEhszGCl2tpqAqvVHCbvoG5g78676Iqqiib4+8RLXJJ0NZJKrEn2etwrnwyIt4D8AhhW7whj8pBQeOuJ+IetFdrbQxmyuBhLP+UeNGQZIS3MS89KPWsdVmt1raIY1JG+XOyy9tnHAvTJKq4tzqA6Rz74NuLA7h9W43CUa4cEAwNGJIAMXrJjjVT2LoD7Gy/a7AHxvV94uRjYpx7F6oZcB+rWL5PINwoSyfyXl9iqqP03sUvlDxj2PUXJi2HBdW1Xb3hM0QHAaMgmhMDsfQhPX/SkAzQX5qK1ErLJwSWo5OUoD/Eg4n/umZThRXcNQektxjc2xgDbAx+VvRbmlSmD9cQr7FCNjWa4+D4hl8Q1W16KwCYoRZ5+SsF6yHKM0fbo42rQ2NXVf
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(451199021)(71200400001)(478600001)(7696005)(26005)(316002)(6506007)(186003)(5660300002)(54906003)(9686003)(2906002)(66446008)(66946007)(76116006)(4326008)(8676002)(6916009)(64756008)(66476007)(41300700001)(66556008)(52536014)(8936002)(122000001)(55016003)(86362001)(33656002)(83380400001)(38070700005)(38100700002)(66899021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UG1TSVZoUjBDcFhnTmptazE2TjVsUEFENXdRS1Jvd1N0V2l3U0hSNXN3TU8z?=
 =?utf-8?B?NGZFUjdDOXU5bG1rZ25SWmFCcHM4ZjdrVnhaWTB5WmY5b20xOFhxbmFxN2Ra?=
 =?utf-8?B?ZCtCbXlCTCt6cFYxajIvMmZRL0M5ditwdTI4Y3pVeFRmUllkdFBZRVlMWE9a?=
 =?utf-8?B?Yys5bmpjWXN6TUdueUFnZzQ4bC9IdDYrbE9odGNpQmx0a01pdVhkbHgxYWNx?=
 =?utf-8?B?WnJkM0RWTWdBdkxmR2UxT0lTaUFNeUIyTCtldkxlSnlVUS9RNUF4Y1lpQ3lY?=
 =?utf-8?B?c2Z4dURGa0FUaThkL1N6UlV1OHZKejE1M2dhSXhvU3kxTkVqeGpWTzJkUXF2?=
 =?utf-8?B?cG05czZ3Q1NNVWowcCtJUkN0aGxZWmU1TEREaW9VNHpWaloyeFU3R2F3eXdz?=
 =?utf-8?B?VytjMUc4eE5tUjh6MHp0NFovaTRpdWV0bU9RenVzV1ZYR3lhT0JIaHdFQkZL?=
 =?utf-8?B?dXNMQUhRR3FLUW14RktXQlVxSG5YWk5Fc3laOE5zSlNqZERtYldhZnNUTG9P?=
 =?utf-8?B?RkVBWFBlZlpyL0lTNFVZQWlycnBGR25SVnhwbXJkWVJWMWl2Zkc5VWRqMlhG?=
 =?utf-8?B?TkZQUmE0K09aWXlLWTRhcnpwYTkwUUZUM3B1UjNiaWF6Z0NOMTA0aEwxa0Ju?=
 =?utf-8?B?c2wrRnlRU0Q5OGFibnRqQUVxNVBudEcwUlhtMUZIWE9HNU1IaVN3THlOTkxt?=
 =?utf-8?B?N3J1dFhEYkYybWVCZXlBT2ptU05HK2JoQm5MYUtxZmJvWmtyaWYrSERMcFhC?=
 =?utf-8?B?Rm9qTFNzODc2Y3cvdkVybndreW5QUVVYMTZaWTJVTFJFNzBvWXFxZVVQT0dM?=
 =?utf-8?B?YVJXdTY2VGdWcWlrYll0SXVLckZlWnhNV3NibUU4SENsNXBpVzd4NEZMaHlz?=
 =?utf-8?B?Y1BLeHpsK3diSDN2QlR1M3hQeWRMakhOQ09WaXp1VExUbklHajBjeGR6QXZI?=
 =?utf-8?B?UVpxTlZaSmY0YlNhWGhBelU2SWxtWVFicTM0ZW5CbW5qYXNrRFVrQmNDdjhC?=
 =?utf-8?B?Yll4dWUvL2NsMW5VeFQ5Tjc3S2tSdVhOcDQzV0RSTHQ0emljL01jOFlScDE4?=
 =?utf-8?B?TzdFTXJ3eFo2dUtkc1VSdit1SDlvemdybmovT0VIN0lINHF3VEI4NmFuUlNN?=
 =?utf-8?B?N0hidDlEWm4vdTg1UCtaWU0wUktIdlNyQ29lbU5xSUlrRWlScHNQdkgxcnBz?=
 =?utf-8?B?RTRobmpUdEgvU1BpZURRbFlLaTZhZnhFQnQwZEpod0dDdysrcVhuMlN2cUR4?=
 =?utf-8?B?M2JjK3hablRDUUU1ZHNjUFlpNnU5d0JKNWt1blpLYWpNS1dIcjFobjZtbmQ5?=
 =?utf-8?B?VElwZlpUOWE2NndEMmJ5NWRGYlczc0lTR2VLc3h5L1VIMVN3T3ZZUVpIMkR0?=
 =?utf-8?B?a3BDYkpHR2UvdVl0UE9tZ2w1aFE1elM4WFp4c2tEK1BmK1AxaGNUclplMUdO?=
 =?utf-8?B?NXlkOThJOGo0aFh2ZlRPUEdZUUNiY08rdUcwM1l5b2pDcEtienFOc05WYWMw?=
 =?utf-8?B?a01SMDlRa0NIZFBVeU5KZ211b0ZXRUZNWnBOam44S3p2SkY4MGxNQys2eUo3?=
 =?utf-8?B?SFRlZ0JUckFkd0MxOXFnaVZJemJacHp5MVNNOGsrMUxudkVTOVFaZzdDeVNT?=
 =?utf-8?B?eHJ2MEtVUXJJbm5pL200VGNTZWJCSjkrT0hOdWRHQkF3dnhvZ1Fsc2FBNnQ3?=
 =?utf-8?B?Y04vblM3WWNmWlpRWTB1LzBTZjN1UnVJRVp5MS9td1UxeElzUitnZlZrMnhB?=
 =?utf-8?B?V1RIWWxTdmp0YzBXZUpFakx5bFBMZzNpQ2diVUREN0JSWVk1Y2t2SW10M0RN?=
 =?utf-8?B?Sktrem9GaFBSenFqMHBPMlN2eUZEaEdBc1N5QlNlbzY3UnR5SitFR2FodDBQ?=
 =?utf-8?B?YWo1MnFoL2IwYm1ydEtnaW9YVGJWUmNaRFN5NERCMnRhN0xhckJ1czBKOHIr?=
 =?utf-8?B?OHB2eGlXU1lZbVdyZnpBdGY0QlZrcktNUkFSUzM4TkNEZjBMZzc1U1p2eXQ1?=
 =?utf-8?B?S2Jnb1ZRYkJJRUVNVndxY2xWUmpnUjZ5YjJXQnJHUDRwbHlINTZSQktmVlUv?=
 =?utf-8?B?emZva1NDcERybitQM3JXSjhiamRIemd2dnA0NE1WSWZqOVVjUEJnZlpZNmgx?=
 =?utf-8?Q?FA7E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e925ae2c-43cc-4fec-ca35-08db3aee929b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 00:40:53.9019
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: owmX1eFxHh4yR6r0b9OwxOjP+R15hrOQW2GYhjMmkfGz/WSsq1rxVS3ujiNz8jwUrELLWgngLXjhZBB2D0FkHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4272
Subject: RE: [virtio-dev] [PATCH 08/11] transport-pci: Introduce virtio
 extended capability

PiBGcm9tOiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBBcHJpbCAxMSwgMjAyMyA1OjI1IFBNDQo+IA0KPiBPbiBUdWUsIEFwciAxMSwgMjAyMyBh
dCAwNzowMToxNlBNICswMDAwLCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+ID4NCj4gPiA+IEZyb206
IHZpcnRpby1kZXZAbGlzdHMub2FzaXMtb3Blbi5vcmcNCj4gPiA+IDx2aXJ0aW8tZGV2QGxpc3Rz
Lm9hc2lzLW9wZW4ub3JnPiBPbiBCZWhhbGYgT2YgSmFzb24gV2FuZw0KPiA+ID4gU2VudDogTW9u
ZGF5LCBBcHJpbCAxMCwgMjAyMyAxMToyOSBQTQ0KPiA+DQo+ID4gPiA+IEhvd2V2ZXIsIGl0IGlz
IG5vdCBiYWNrd2FyZCBjb21wYXRpYmxlLCBpZiB0aGUgZGV2aWNlIHBsYWNlIHRoZW0NCj4gPiA+
ID4gaW4gZXh0ZW5kZWQgY2FwYWJpbGl0eSwgaXQgd2lsbCBub3Qgd29yay4NCj4gPiA+ID4NCj4g
PiA+DQo+ID4gPiBJdCBpcyBraW5kIG9mIGludGVuZGVkIHNpbmNlIGl0IGlzIG9ubHkgdXNlZCBm
b3IgbmV3IFBDSS1FIGZlYXR1cmVzOg0KPiA+ID4NCj4gPiBOZXcgZmllbGRzIGluIG5ldyBleHRl
bmRlZCBwY2kgY2FwIGFyZWEgaXMgZmluZS4NCj4gPiBNaWdyYXRpbmcgb2xkIGZpZWxkcyB0byBi
ZSBwcmVzZW50IGluIHRoZSBuZXcgZXh0ZW5kZWQgcGNpIGNhcCwgaXMgbm90IHlvdXINCj4gaW50
ZW50aW9uLiBSaWdodD8NCj4gPg0KPiA+ID4gIg0KPiA+ID4gK1RoZSBsb2NhdGlvbiBvZiB0aGUg
dmlydGlvIHN0cnVjdHVyZXMgdGhhdCBkZXBlbmQgb24gdGhlIFBDSQ0KPiA+ID4gK0V4cHJlc3Mg
Y2FwYWJpbGl0eSBhcmUgc3BlY2lmaWVkIHVzaW5nIGEgdmVuZG9yLXNwZWNpZmljIGV4dGVuZGVk
DQo+ID4gPiArY2FwYWJpbGl0aWVzIG9uIHRoZSBleHRlbmRlZCBjYXBhYmlsaXRpZXMgbGlzdCBp
biBQQ0kgRXhwcmVzcw0KPiA+ID4gK2V4dGVuZGVkIGNvbmZpZ3VyYXRpb24gc3BhY2Ugb2YgdGhl
IGRldmljZS4NCj4gPiA+ICINCj4gPiA+DQo+ID4gPiA+IFRvIG1ha2UgaXQgYmFja3dhcmQgY29t
cGF0aWJsZSwgYSBkZXZpY2UgbmVlZHMgdG8gZXhwb3NlIGV4aXN0aW5nDQo+ID4gPiA+IHN0cnVj
dHVyZSBpbiBsZWdhY3kgYXJlYS4gQW5kIGV4dGVuZGVkIHN0cnVjdHVyZSBmb3Igc2FtZQ0KPiA+
ID4gPiBjYXBhYmlsaXR5IGluIGV4dGVuZGVkIHBjaSBjYXBhYmlsaXR5IHJlZ2lvbi4NCj4gPiA+
ID4NCj4gPiA+ID4gSW4gb3RoZXIgd29yZHMsIGl0IHdpbGwgaGF2ZSB0byBiZSBhIGJvdGggcGxh
Y2VzLg0KPiA+ID4NCj4gPiA+IFRoZW4gd2Ugd2lsbCBydW4gb3V0IG9mIGNvbmZpZyBzcGFjZSBh
Z2Fpbj8NCj4gPiBOby4NCj4gPiBPbmx5IGN1cnJlbnRseSBkZWZpbmVkIGNhcHMgdG8gYmUgcGxh
Y2VkIGluIHR3byBwbGFjZXMuDQo+ID4gTmV3IGZpZWxkcyBkb27igJl0IG5lZWQgdG8gYmUgcGxh
Y2VkIGluIFBDSSBjYXAsIGJlY2F1c2Ugbm8gZHJpdmVyIGlzIGxvb2tpbmcNCj4gdGhlcmUuDQo+
ID4NCj4gPiBXZSBwcm9iYWJseSBhbHJlYWR5IGRpc2N1c3NlZCB0aGlzIGluIHByZXZpb3VzIGVt
YWlsIGJ5IG5vdy4NCj4gPg0KPiA+ID4gT3RoZXJ3aXNlIHdlIG5lZWQgdG8gZGVhbCB3aXRoIHRo
ZQ0KPiA+ID4gY2FzZSB3aGVuIGV4aXN0aW5nIHN0cnVjdHVyZXMgd2VyZSBvbmx5IHBsYWNlZCBh
dCBleHRlbmRlZA0KPiA+ID4gY2FwYWJpbGl0eS4gTWljaGFlbCBzdWdnZXN0IHRvIGFkZCBhIG5l
dyBmZWF0dXJlLCBidXQgdGhlIGRyaXZlciBtYXkNCj4gPiA+IG5vdCBuZWdvdGlhdGUgdGhlIGZl
YXR1cmUgd2hpY2ggcmVxdWlyZXMgbW9yZSB0aG91Z2h0Lg0KPiA+ID4NCj4gPiBOb3Qgc3VyZSBJ
IHVuZGVyc3RhbmQgZmVhdHVyZSBiaXQuDQo+IA0KPiBUaGlzIGlzIGJlY2F1c2Ugd2UgaGF2ZSBh
IGNvbmNlcHQgb2YgZGVwZW5kZW5jeSBiZXR3ZWVuIGZlYXR1cmVzIGJ1dCBub3QgYQ0KPiBjb25j
ZXB0IG9mIGRlcGVuZGVuY3kgb2YgZmVhdHVyZSBvbiBjYXBhYmlsaXR5Lg0KPiANCkEgZmVhdHVy
ZSBiaXQgaXMgYWNjZXNzaWJsZSBhZnRlciB2aXJ0aW8gbGV2ZWwgaW5pdGlhbGl6YXRpb24gaXMg
Y29tcGxldGUuDQpWaXJ0aW8gbGV2ZWwgaW5pdGlhbGl6YXRpb24gZGVwZW5kcyBvbiB0aGUgUENJ
IGxheWVyIHRyYW5zcG9ydCBhdHRyaWJ1dGVzLg0KU28gcGNpIGxldmVsIGF0dHJpYnV0ZXMgc2hv
dWxkIGV4aXN0cyByZWdhcmRsZXNzIG9mIHVwcGVyIGxheWVyIGluaXRpYWxpemF0aW9uLg0KDQo+
ID4gUENJIHRyYW5zcG9ydCBmaWVsZHMgZXhpc3RlbmNlIGlzIHVzdWFsbHkgbm90IGRlcGVuZGVu
dCBvbiB1cHBlciBsYXllcg0KPiBwcm90b2NvbC4NCj4gPg0KPiA+ID4gPiBXZSBtYXkgbmVlZCBp
dCBldmVuIHNvb25lciB0aGFuIHRoaXMgYmVjYXVzZSB0aGUgQVEgcGF0Y2ggaXMNCj4gPiA+ID4g
ZXhwYW5kaW5nIHRoZSBzdHJ1Y3R1cmUgbG9jYXRlZCBpbiBsZWdhY3kgYXJlYS4NCj4gPiA+DQo+
ID4gPiBKdXN0IHRvIG1ha2Ugc3VyZSBJIHVuZGVyc3RhbmQgdGhpcywgYXNzdW1pbmcgd2UgaGF2
ZSBhZG1pbnEsIGFueQ0KPiA+ID4gcmVhc29uIGEgZGVkaWNhdGVkIHBjaWUgZXh0IGNhcCBpcyBy
ZXF1aXJlZD8NCj4gPiA+DQo+ID4gTm8uIGl0IHdhcyBteSBzaG9ydCBzaWdodC4gSSByZXNwb25k
ZWQgcmlnaHQgYWZ0ZXIgYWJvdmUgdGV4dCB0aGF0IEFRIGRvZXNu4oCZdA0KPiBuZWVkIGNhcCBl
eHRlbnNpb24uDQo+IA0KPiANCj4gDQo+IFlvdSBrbm93LCB0aGlua2luZyBhYm91dCB0aGlzLCBJ
IGJlZ2luIHRvIGZlZWwgdGhhdCB3ZSBzaG91bGQgcmVxdWlyZSB0aGF0IGlmIGF0DQo+IGxlYXN0
IG9uZSBleHRlbmRlZCBjb25maWcgZXhpc3RzIHRoZW4gYWxsIGNhcHMgcHJlc2VudCBpbiB0aGUg
cmVndWxhciBjb25maWcgYXJlDQo+ICphbHNvKiBtaXJyb3JlZCBpbiB0aGUgZXh0ZW5kZWQgY29u
ZmlnLiBJT1cgZXh0ZW5kZWQgPj0gcmVndWxhci4NCkZhaXIgYnV0IHdoeSBpcyB0aGlzIGEgcmVx
dWlyZW1lbnQgdG8gbWlycm9yPw0KSXMgdGhlIGJlbG93IG9uZSB0byBpbXByb3ZlIHRoZSBwZXJm
Pw0KSWYgc28sIGl0IGlzIGZpbmUsIGJ1dCBJIGd1ZXNzIGl0IGlzIG9wdGlvbmFsLg0KDQo+IFRo
ZSByZWFzb24gaXMgdGhhdCBleHRlbmRlZCBjb25maWcgY2FuIGJlIGVtdWxhdGVkIG1vcmUgZWZm
aWNpZW50bHkgKDJ4IGxlc3MNCj4gZXhpdHMpLg0KPiBXRFlUPw0KPiANCj4gDQo+IC0tDQo+IE1T
VA0KDQo=

