Return-Path: <virtio-dev-return-12650-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AA9C7EE22
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 13:16:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B0A1833565
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 13:16:45 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AC5C09866EF
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 13:16:45 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A068E9865E9; Thu, 11 May 2023 13:16:45 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8B02C9865DB;
	Thu, 11 May 2023 13:16:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyInbCdrULWgwHh7h4i5WkSth01fndge1NjJp35L8F8YBJR2C6sJTHdU6icNqsRGn+7KMdlmgYiCpIzQ/48ZUnV+dK+/qgJaURBUzukxvlbPdnA8MQLsZj10F0tn8h30VnOfhH1KNhGaKcIULwj0xPE4I5Z3Wz9LNx70X8hxM64SQFTzyd3scLhlza1cpZ+lDl2hNJ4qtYzzCGC812kiIVLrnNupGtUpT+KnOefrMFrZBqmfIOccbCq5bpZigEBHWLiM0gCf5drBgChIc8o4HruvuaaSvkmp299jV4oFZXlsgdYMBpIUyWAcu7QlXMD1KFwb53yVFhBW65Jrh0WiCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZsI1IadzoKxpqdJqEkDT8pmNLgVODrJWzofihn9Vfxo=;
 b=D7a6h6/Lm0+D4Hk7YXGdYLKLkVirod9tlX/erAjIp0Iyp4yyBO2f2ZueFaJ7kTDjNef9ozcHalBHcwQWTaS45o7O/VuI8FuwUQbJqDYRd2VA2LoD0INCpIqusFHCVoFEOkBEj9KDsvnba0/k+VygFt9fHxKbrw24AklaAwxRmVnWt+V/j+e0ho50hgpyACTuQ/IqIkQyNaRxSQQbzpv4Jh0lqxJQd/Jaw7ywLO2HjCcQQIvIl5BDXTaMMqpJy8JqVWcC38lUkXVbhnT/3yOty/vnYxxwvBjSFGzVF9ByW/NneBIBw9LOvU5oZ+rQDoETDwAhLwC6abGy8iCTVVzupA==
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
Thread-Topic: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ
Thread-Index:
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9Mhl4AgAJOSwCAANQugIADYnEAgAAP1ICAAAu1gIABh4gAgABl1qA=
Date: Thu, 11 May 2023 13:15:15 +0000
Message-ID:
 <PH0PR12MB5481BCA4D8F6546B3300DD29DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230506000135.628899-1-parav@nvidia.com>
 <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
 <CACGkMEvTs9oMewgrQpYZu1v1wdUXtxsvjqB6CPRf+y4C8EN_KQ@mail.gmail.com>
 <20230510033812-mutt-send-email-mst@kernel.org>
 <CACGkMEsp0i7EyyBBp06wJzrVBLNbH7MP_TT-j7b5c_yavgAmqw@mail.gmail.com>
In-Reply-To:
 <CACGkMEsp0i7EyyBBp06wJzrVBLNbH7MP_TT-j7b5c_yavgAmqw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ1PR12MB6363:EE_
x-ms-office365-filtering-correlation-id: 60fd9a4d-692a-4396-c5b1-08db5221c265
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 KNtFM/EqUYFfYs9gVEIRqyTIDKC5pUqxtUlLjTiHjX6DnSqNL9Yz8i9WrLp+yAoajId5r3+P3gD+R89b6aQWIm2xL2R2xUgEPSG7TqGdDjs7rRcqEET0lmxX7ToemmYqG+8B1ZaUnwcn9vbNA+QTOeboe2vtvNIj3ShsHWx5iQqkD360j5nLYwbRV1uZUOA3Mt0794p3RWu3a4fh9EZHOJyj82peWq/jpD5ppKXF8ggvdGtNkV0U1h9+umXRvBtMPLs5oxrURKjo87miNIghtOuhRBWZxA0NYaCzca73hQXqRirAHIMXxinmV8cqQAI5hizthiwYObS3JwgoA2uecXZdg5gV9w3GOd1k2Hc+5h0/J0iWA4Trt9A89Rx5zJrdNQLkCnyH1ujWzyOMRfat0ag2w1PEZ8GN7/xe06DI76LRHSIclQEFwcN5QrB4BEqhsdsv5dFuqifMNHxgRYewyIQKoeElXPxq5HVvW2/MOI75QS5EP7dOA563Op5nDdBjv5/wpm/ZERkmERFTyVQK6WpD1aBaqtDz/R7z3Koh3a9W4RUj+6oJZzYaAxDW0GapoFiCho7Z9gmu7zXrN8fru66jvLceO58z6O8q3ovo1lc2InON4DhKXm7iGhyHg9hnEZjHK+956qEQ5ZrE5BWz61HZVWDO0bFFRJatMnygMbs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199021)(33656002)(54906003)(38070700005)(7696005)(110136005)(478600001)(9686003)(86362001)(6506007)(107886003)(26005)(55016003)(186003)(71200400001)(122000001)(76116006)(8676002)(8936002)(41300700001)(316002)(83380400001)(52536014)(5660300002)(66476007)(66556008)(66446008)(66946007)(64756008)(4326008)(38100700002)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NjMxamNFcnRIZUpMdm5HakRYVDJBQU5nR1dCY1dnN2MybG1mcHB0dE4rK2tY?=
 =?utf-8?B?SXM1UFprY1F1YzlIN1VwQXJtdU9KSGJHbkJtKy9TT2NWdHYvQ1Jzd0ZBelo0?=
 =?utf-8?B?Uk94MXQwRXd3Y3ROa3FBSFMwV3lleTd6SjI1Yzh6c1FkZzBUaTB2ZjB2UUF0?=
 =?utf-8?B?OXJid3J3UEJzeGsvN1dXZkdSWWIrWlVuajVHNVdPeUsycmkrd05BaWdTQjkz?=
 =?utf-8?B?aXB4OTN5Vm1FZ3FBaVdYWWQ4RmFjd1MyZXhPc01oYUZWZFlENlhDdUdCZDA3?=
 =?utf-8?B?ajJyWm5aVzJLL25tRzEyTG9XOHhnWC9vczU5UzVrSHhMcmw0SHFNQyttYWMw?=
 =?utf-8?B?ZXNONk9LRDIxMGtBNmhRY1lFbWR5SHhkcTRPYVFHZFgweDFxTFREc0xWOG9r?=
 =?utf-8?B?NFlETkhXVGhXNU81NWhTeVJQT2pYaHUyd2lyTFYrRnJ1WDZ1SzREeFAzSDNR?=
 =?utf-8?B?SXlxYi9BWEgvT2E3ZkRaMEpNOHJCRW12bTlsakZubG9TMUJGcVl0RzgvQUxt?=
 =?utf-8?B?TjgvaU9TWTJ4NXBGUGZtaWtQRFFuKzZUd0lKMUxkVjl2NU56NWY2Mk5IZHpV?=
 =?utf-8?B?MGRpK0RtZXdFRUl2T2VnMUxiM1RUQVZoZnN0UTRWZ2dBOWJLekM4d2VVWk96?=
 =?utf-8?B?NWw2b090MU5wN29McHZmdlVuN1hMQSt1NFBBdzdDbU5MSVNnUnlVOGRkWG1h?=
 =?utf-8?B?SE03dE1md3Z0SWVsQ2d2alZSakV1eW0vOU5yQWsxMnZGeFN5b0Fud3dsWHQy?=
 =?utf-8?B?bTBieXl3RngwQ0tCTFpvUGJNOHlKUXlLa3dpR2RRcWttTFlLSXB6emhTaWdK?=
 =?utf-8?B?bitoMTRiTm5MWHVMekx0S0hOVDVXdWhNMVI3WmREbVBuYlNDQ2ZhS290WTRq?=
 =?utf-8?B?dHNONUVoZCtFYS9Gbi9NblNjUEExeGwwbzFqL0JZZWxwcENDRkF1WXJ1VXRS?=
 =?utf-8?B?c1RveW9VeU9UUWdzVk5RRy9zMGR5M2NFenl4SXhFK0NQRkYySXhJNUt0aERs?=
 =?utf-8?B?YldqSFFMTHpKZG14eDRRUThmRTJ6SzkvMmZRQkpvVUVDVHh1cVV2elMxbmx3?=
 =?utf-8?B?Q0JJYUNJRzFBRE9QVHM3ejBJc2ZGUnp1VkhCWEh0anBNbWJKZkk5QzRadTUw?=
 =?utf-8?B?QXRNS0dJaXJBTlF5WHJGaXNiYWMrakZ0OGRRUXhHOUVGajFISU5iVTBIWVdZ?=
 =?utf-8?B?WDk1enZobzVzYzlsVURYWEFUNFhoUzMyTHJvWXZjdVZ4OVBIbzlyZEFXSHhF?=
 =?utf-8?B?UUxIY3lIdlVjS0pNM2F4dVZYVkNQR0t4Z09sSy8wTVc1a2lUaElBTTlLTmRq?=
 =?utf-8?B?RHF6TlkrbHN1VkFZREVVNDMxak1iR2NnbkQ5akpBRWQzdUFXSDk1STI4eHQy?=
 =?utf-8?B?eUFaYzhObTZwcUhrVU5Sc3g0SGl5NlVzWXBOTkNiUDN0MXdqZElpcjV0QXhn?=
 =?utf-8?B?cWpHSnBCT1c2djBpZ2loM3ZVM2VUc0JIa0l5RFVRVjd0a2ZucTlySjJtaUpQ?=
 =?utf-8?B?RTlnSEZNTWdKY1IxMmxqS3NpRFFNUEtTc3JOdnp6d1ZURjArbldRTHBhOTdz?=
 =?utf-8?B?Smk4TUNYcDVFWUc0Uk56dll0eGJ3WEhicXQ3RUtXOTRKanRnb250S3p1cDFG?=
 =?utf-8?B?OVZ1ZWNrTGhpMHFKRFU2SWxxU1lCRU9KUFBTdjl4T3dDMHBZUmFncDREWnJN?=
 =?utf-8?B?VDlyTW8wMXhFYkdXM3VIVXplaFp3NFkrOEFnVldWWTZKclFWRzBZN3phK1dz?=
 =?utf-8?B?V1poZW16NTVEU3VuUTVBbWw5dTBHUlFtTjBEMlVTb1pWUzFkVGwvMDBMOUlB?=
 =?utf-8?B?S3dVSWNuMWxGclZqMWpvOE5FbUIzNng4NFNCaDFtQnBERFl0eGdPVzVDTndy?=
 =?utf-8?B?VzBjSmwzbTlkWXp3cEhRWFAvU1FDaEgwSStENVppMDZYbVpMOGt3SDJ2Mml0?=
 =?utf-8?B?Ry9xeEE1bVNMUHAvdmxmZDloMWczeWFsRzF0RE10WnFrSlZmc1daQ3hJUDhD?=
 =?utf-8?B?a01Hc3FEMzAzV0R5NXU2Q3NPdzkxWmZRMlRZaXJBbFZKdEVWamRnUVBQWmhm?=
 =?utf-8?B?UndNTEQ2ZFdPc2FTSzRUWHRJRlVMdDByZUR4L1QzSmI0OCtlN3BOSFk5Y2pi?=
 =?utf-8?Q?Yo10=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60fd9a4d-692a-4396-c5b1-08db5221c265
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2023 13:15:15.1899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q5FSFaMf3NmNvVwUZLmfyxqFpoD1yaOzHtBdkiM0MrPYNKAMAwTJxGAi+spvffD+ZgO5/SjJZHn/tHCJVh/osg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6363
Subject: [virtio-dev] RE: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBNYXkgMTEsIDIwMjMgMzowNSBBTQ0KPiBJZiB3ZSBkZWNpZGUgdG8gdXNlIHRoZSBhZG1p
biB2cSwgaXMgdGhlcmUgYW55IGdvb2QgcmVhc29uIHRvIHRpZSBpdCB0byBQQ0kgaWYgd2UNCj4g
ZG9uJ3Qgd2FudCB0byB0dW5uZWxpbmcgUENJIG92ZXIgYWRtaW5xPw0KVG8gdHJ1bHkgdHVubmVs
IFBDSSBvdmVyIGFkbWlucSwgcGxlYXNlIHR1bm5lbCBfYWxsXyBwY2kgdGhpbmdzIG92ZXIgQVEs
IG5vdCBqdXN0IGJlbG93IDEgdG8gMTEuDQpEb29yYmVsbHMsIGNhcGFiaWxpdGllcyBhbmQgbW9y
ZS4gVGhlbiBpdCBpcyBxdWFsaWZ5aW5nIGFzIGEgdHJhbnNwb3J0Lg0KT3RoZXJ3aXNlLCBpdCBp
cyBub3QgYSAidmlydGlvIHBjaSB0cmFuc3BvcnQgb3ZlciBhcSIuDQoNCkkgbmVpdGhlciBzZWUg
d2h5IG9uZSB3b3VsZCB0dW5uZWwgd2hvbGUgUENJIG92ZXIgc29tZSBxdWV1ZSwgd2hpY2ggd2Fz
IG5vdCB5b3VyIGludGVudGlvbiBlaXRoZXIgZnJvbSB0aGUgcGF0Y2hlcyBJIHNlZS4NClZRIG92
ZXIgZmFicmljcyBpcyBtdWNoIGNsZWFuZXIgZGVzaWduIHRvIHRyYW5zcG9ydCBWUSBvdmVyIG5v
bi1QQ0kuDQpQZW9wbGUgaGF2ZSB0cmllZCB0byB0dW5uZWwgcGNpIG92ZXIgc29tZSBvdGhlciB0
cmFuc3BvcnRzIGFuZCBpdCBvbmx5IGZpbmUgZm9yIG5vbi1wcm9kdWN0aW9uIHRveXMuDQoNCj4g
DQo+IFdoeSBub3Qgc2ltcGx5IGludmVudCBpbmRpdmlkdWFsIGNvbW1hbmRzIHRvIGFjY2VzcyBs
ZWdhY3kgZmFjaWxpdGllcyBsaWtlDQo+IGNvbW1hbmRzIHRvIGFjY2VzcyBsaWtlIHdoYXQgdHJh
bnNwb3J0IHZpcnRxdWV1ZSBkaWQgZm9yIG1vZGVybg0KPiBkZXZpY2U/Og0KPiANCkkgZG9u4oCZ
dCBzZWUgaG93IHRoaXMgaXMgYmVpbmcgYW55IGRpZmZlcmVudCB0aGFuIHJlZ2lzdGVyLW9mZnNl
dCBpbnRlcmZhY2UuDQpJdCBiaXNlY3RzIG1vcmUgdGhpbmdzIGF0IGh5cGVydmlzb3IgbGV2ZWwg
dGhhdCBtYWtlcyB0aGluZ3MgaGFyZCB0byBhZGQgIzEydGggZW50cnkuDQoNCj4gMSkgZGV2aWNl
IGZlYXR1cmVzDQo+IDIpIGRyaXZlciBmZWF0dXJlcw0KPiAzKSBxdWV1ZSBhZGRyZXNzDQo+IDQp
IHF1ZXVlIHNpemUNCj4gNSkgcXVldWUgc2VsZWN0DQo+IDYpIHF1ZXVlIG5vdGlmeQ0KPiA3KSBk
ZXZpY2Ugc3RhdHVzDQo+IDgpIElTUiBzdGF0dXMNCj4gOSkgY29uZmlnIG1zaXgNCj4gMTApIHF1
ZXVlIG1zaXgNCj4gMTEpIGRldmljZSBjb25maWd1cmF0aW9uIHNwYWNlDQo+IA0KPiBJdCBmb2N1
c2VzIG9uIHRoZSBmYWNpbGl0aWVzIGluc3RlYWQgb2YgdHJhbnNwb3J0IHNwZWNpZmljIGRldGFp
bHMgbGlrZSByZWdpc3RlcnMgKHdlDQo+IGRvbid0IGV2ZW4gbmVlZCBsZWdhY3kgcmVnaXN0ZXJz
IGluIHRoaXMgY2FzZSksIEkgZ2l2ZXMgbW9yZSBkZXRlcm1pbmlzdGljDQo+IGJlaGF2aW9yIHNv
IHdlIGRvbid0IG5lZWQgdG8gY2FyZSBhYm91dCB0aGUgY3Jvc3MgcmVnaXN0ZXJzIHJlYWQvd3Jp
dGUuDQo+IA0KMS54IGhhcyB0aGVzZSByZWdpc3RlcnMgYXQgcmF3IGxldmVsIGFuZCB0aGF0IHNl
ZW1zIGZpbmUuDQpBbnl0aGluZyBuZXcgd2lsbCBjb21lIG9uIHRoZSBjZmdxIGFuZCBoZW5jZSBu
byBiaXNlY3Rpb24gb3IgcmVnaXN0ZXJzIG5lZWRlZC4NCg==

