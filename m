Return-Path: <virtio-dev-return-12773-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDEDCC77B7C
	for <virtio-dev@archiver.kernel.org>; Mon, 22 May 2023 02:46:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 27983F3F4E
	for <virtio-dev@archiver.kernel.org>; Mon, 22 May 2023 02:46:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 18B89986416
	for <virtio-dev@archiver.kernel.org>; Mon, 22 May 2023 02:46:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0C2EE9862FC; Mon, 22 May 2023 02:46:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EADD39862FE;
	Mon, 22 May 2023 02:46:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C6wHJANE5b49daX2VYT/gogmhFfTzk7fQv36d1CxhQEqS1XJk6iMRtBldQBEobXDjOFMl2gd+rwBS8RpFO2l70j/aeSdZGwFTCig5d0N+omQ3g2YEFG0jLpDoTHA0nRhx3T0WkV7KOJa08/iS/QEHskYqz4Zg+OmQMzGjGarYi7pwOnBDZuFtvV4wsIYoICnOEbSqvdyLll1/CBBR2APjWDIcFsC46X3AQLafPtGSJlD680HjU9lj92NWUNApEim2B+sqjqtqiQ4h8VRNKBLTeyfacgIVIOsylBwabzwvjnY7s53E3/vlx8sF/4qtxfw4Dhj96SNSgqR0VTpdtFnIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSRZLj0Z16Q0n0n+rYCbyI8Nk9XSzVBkMjw/8UVGF/c=;
 b=ahceqnEQGgVGklm7+ViHXJnQ8UzyhUpILy441zYrUMR6bQh6TqUzU4jzTbI7irEoslAmBu0sP9mtMnk1Fcd0vViTG8SSuVv5VHCgCjON7ylTbI1ChG44J+4IjdANxXged2+ywXqO5GLp5YqnM4eLVN5mramEOcRdbOM6h1Luu7b9j4W6GfKGAwRJe3UCFHRVbKADGfw8eKJmdyME/efQ/DsiVit3fyKDDVC36HWoeUek+IdSNxL6SuX6Ql4XZe8M8LE7aj2+wpKs5bAA0c30MmeVs7NHz5OjkqOS/nepvvXDqCBd75f7sj0ENPR3G3BJl0c8AdlVL2glGZESfcPLTg==
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
Thread-Topic: [virtio-comment] RE: [PATCH v2 1/2] transport-pci: Introduce
 legacy registers access commands
Thread-Index:
 AQHZf639R6aTQu3GsEiaqC7Dtr8vQa9eBfIAgADi2pCAAZmGAIAArnkAgACuQ0CAAqt6AIAAPtmwgAAZkYCAAK2wAIAAGpZw
Date: Mon, 22 May 2023 02:46:24 +0000
Message-ID:
 <PH0PR12MB5481C312418A20BA95A2CC3DDC439@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230506000135.628899-1-parav@nvidia.com>
 <20230506000135.628899-2-parav@nvidia.com>
 <20230517013839-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54817CBB98900B83C4F30164DC7E9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230518153640-mutt-send-email-mst@kernel.org>
 <20230519015520-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AABA8A22DC088B5D7CFDDC7C9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230521050829-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548161A2D28C387C9AF23B81DC429@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230521102050-mutt-send-email-mst@kernel.org>
 <CACGkMEtTa3angJZdrUW+Eeqi3vW1z7UDVAMaWowY1BRaJby0Kg@mail.gmail.com>
In-Reply-To:
 <CACGkMEtTa3angJZdrUW+Eeqi3vW1z7UDVAMaWowY1BRaJby0Kg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY8PR12MB7490:EE_
x-ms-office365-filtering-correlation-id: ea8bdd69-7b59-4e0f-c490-08db5a6ebbd0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8dD1QavTgO05gxdoYTOUh7XrcN4CnxLXN5FdOYZnwaeXiWPn6JbXDZ8Ym9j6yTezDAKTG4GUhJP8RqBjjSC4SVma+/wNzQUV1howpN51dnNteRJmKLjj2r9c4+4S8WR3eb6nqJqRwwdGrHYUoV6S+DFamjGidgSJtsJf5qR1jizO1QYVFQ1qKxO+VG54PFiQhGsKz3YBn6bFoeqz7Q+T2hVJNxMI+n8C5L+k2XO3BLfPsvo4lDzNcjWom/pCnpXG5yfGdyM9vKpvpQT3rK3CiwgBNC1vOP4zH/cNuuw7LW8DmMhG9CBFev3EBm3122mpMny81OyQBoJAtCHMPKfcAOgt+Yf/9mzHj4/1xARdvdZn3Lt7fgLdHI+OqYo7TW3SfWMfbNXVtzHMoNTKh3BruWkOEWwlaf4Oqf+gGrvSfTxbVTbkvtag3yblrHYwX4fSSp7f258NyLYTHxZuiQ1Op0/hwQIFgtmxUdRvFPlRv1bpU2Nju2Vro3u8gQ3uMzkHnmX44C4Xlw0w53O+h1a17hvnJmceJJ4HpWhwAwOAegrmjYFWHswZEm8EXJee8xUozsJFRjmmoh9qJcEPWj703Dcd1LWWMqM+1m+k+H8oSCfv4v39kjQwCKglTOh66dLR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(451199021)(8676002)(8936002)(5660300002)(52536014)(186003)(83380400001)(26005)(6506007)(9686003)(86362001)(107886003)(122000001)(38100700002)(38070700005)(41300700001)(7696005)(33656002)(71200400001)(55016003)(76116006)(66446008)(66476007)(66556008)(66946007)(64756008)(316002)(4326008)(478600001)(110136005)(54906003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VlNOclZpMEpmcHFNSWl4TmxMT0ROSGlxazk0cHRMaS82TWxzd1ZnQjArcTB6?=
 =?utf-8?B?UzViVGVEdmpTdHlyWEZwdHZhblR5TmJNclY4QXRjbkNYMjRDQlhNOE51SHVr?=
 =?utf-8?B?SUNaTDhCUjY2clNqZm1WUlp0YUhwbURQL1dVaFl5Vmo2TWk0OVBGYnY0bXdP?=
 =?utf-8?B?QW1RUjBIZDJmNEx3TjFQWnZ3MGU0cWUrTmNxQnoyVUhJS1AwUmlydVRXMGN2?=
 =?utf-8?B?MmJaRGM1UW9jd20vL21nVWtWVWVBZzZla01EN2NBT3phVEQvMFZpbkJqRHM0?=
 =?utf-8?B?aUJrL1JBa2NJRkRqTUF4Vk9ONUNLdjFydzNLczJLNForcHRjdTlIUXBTdkx0?=
 =?utf-8?B?ZUdOMGwxOEdXbWQvN21tL0lMRythV1dySzhzOEoyUWdqVDZidFVKVmE5KzNa?=
 =?utf-8?B?bjM1MERaV0pxdnQ0SmhGRnU0bmhGRHhSby85ZXNBc3Y2amIrMVovNzhxNzk3?=
 =?utf-8?B?QVRDQklRd0NPRHhBNVRmblBHMEp5NEdpRnJ2NmFRVXo1OThpbDU5MEJqZGJ2?=
 =?utf-8?B?aVVYeSs4VWVDbFp6dVYzQUV2MGlUREF5ekR0U09ETWJ5NDN3S3hDNnlKOGU0?=
 =?utf-8?B?ZlE3Q2FJQ1pUREJqeWVlQ2IvWm1mTHV3dlo5eUFORTRrK1JRYit1ZW1LbkF3?=
 =?utf-8?B?R0lxd2FhUUpPZGtmNDEyREt0ZUgyZE52NG9DZXVYYmFMdjJzZmd3dzVGTW0z?=
 =?utf-8?B?N1BEeWxEbGJPV1o1aHhPN2JKeHlTcnE1Z0Z3Ky8yR1g3NnRackM5SEUyOVhV?=
 =?utf-8?B?NHhLNGhtYmw0SnFzbG1ZNUN3ZzVUVWttVEQ1dDZaMGl4dEtCcHZ0NlVCTGhk?=
 =?utf-8?B?alJRQWk1ZkhEZktISlRqY1dvK2E0aFdCbHlocTFkYUN1cENKTHRCMytscTda?=
 =?utf-8?B?SVVpaXRSVkF4WjhLbEx2a2MxVVhCU3J1dzlOM3k1bmZuekVrMjZTWnN2T1dN?=
 =?utf-8?B?Vk92ZkM5c3JDV1VmM0M4NTZKVjBzUnF0Y3dzVDFkNkJZVnRLY2VYOVhKWVQ5?=
 =?utf-8?B?QXEvTjRFK09rbWF3cFZsZ1VhbnlXODd6ekIwa0ZJTWNvbkZqd0JNUU1kOTVs?=
 =?utf-8?B?ZGduRDVDZzNnNFU4Ny9ueXhQaXh0dWRiLzJtb3dwWHNNZ1E0YTljUkxBZWpn?=
 =?utf-8?B?L25FYkJITklPYk5VZjl5dXc3dFhnRnN2NzBQNDZzVXNkV2M5TFhRUW1KaWZm?=
 =?utf-8?B?N1N4T0ZQb0tlRkhEVktPMmlzK0duN0piaDBEYnBtdHhITzRFaEJidDNUWjJy?=
 =?utf-8?B?WW5HbitoaEhlY1g5L3IzYmxRYjZaNWc1V28zNjJmUmdxVDQrMGNDQnhnUzNr?=
 =?utf-8?B?TlpiSWRQUUNwM1diSnIxVkZVamNGQVRkUEM4bU13MzgwNmRiS2UyYmkrZUhx?=
 =?utf-8?B?RXM5dXV0NHI3T3JRdHpLVkRycGxmTmtlaFNkemlLZDNVbFk3T0F1VTc2aGt5?=
 =?utf-8?B?Ly9tTXFWaVB6WUtMZjYvdWhRWnh2eUUxcDZUYW1KbXNEZStaZmsyMnFQS0R2?=
 =?utf-8?B?WkJEK1czTzJnWFdPOXBOSDRHamNLb1lkTUQ0SWZnMnAyNndEQW8wNndzN1d1?=
 =?utf-8?B?cEJwTmNFNHNnNCt6UEM3cHZCVGhrZkFMMDVOeWtLMDUzVERVVlVQNmVBRm5y?=
 =?utf-8?B?Wkg2dlBWUnhhQTQ5ZE1FUDg3VmR1bGFka0czTlFQbEkzWjlaV3hlc2dSRlpK?=
 =?utf-8?B?WVhyVmZoUHFPUlpVT3NQeFZFTFlITXMzNzVOZ2x0WmlmU3JOSDVhRXo3a0ZI?=
 =?utf-8?B?SUZWOWdjT2tNUmx1Rk5rME9jbElyOU40R01MVHdURS9FY3FjUXN0ZTFEL2pO?=
 =?utf-8?B?RDEraUlnUkkrRUlvc3ZDZUVmU25ablBCWXBWR3RVdWZIMlgxNUh6c3hmM2J6?=
 =?utf-8?B?MENiUm9HYWlJWDRlVVFRRVJ6dHJXRDRFdW1oS1djSEd5clhvcEw2bnluNXFE?=
 =?utf-8?B?MmtQQ1k5MVpleUpUdHdSUmIrdUVnQnUzcjJRNnBNZEhwSHRzWnpQdlBXM1V4?=
 =?utf-8?B?OTJCYVhwY09XZmp1UnNhQXVFZXFOK0M1dWFFUmJnU1FxZ0o3RnVEekQrWVhL?=
 =?utf-8?B?MTVEWThrZ0d4WHpGdm5CZ1Z0TUVub0FTZmlXQkcrM01NMHI1MkpoYURRUnFu?=
 =?utf-8?Q?314k=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8bdd69-7b59-4e0f-c490-08db5a6ebbd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2023 02:46:24.6447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UWweJG56zkuwLh2BwI+K+/M3iuNcyU0TCsu8wKIz/z2EoA3osOh3yP9hgNyWCiSPx+1xI5Z85zZ5ZAD1F0fZpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7490
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v2 1/2] transport-pci: Introduce
 legacy registers access commands

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFN1bmRh
eSwgTWF5IDIxLCAyMDIzIDg6NTUgUE0NCj4gDQo+IFRoaW5rIGluIGEgZGlmZmVyZW50IHdheSwg
aWYgd2UgZG9uJ3QgY2FyZSBhYm91dCB0aGUgc3BlZWQgb2YgdGhvc2Ugc2xvdw0KPiByZWdpc3Rl
cnMuIEZvciB0aGUgbWV0aG9kIHRoYXQgYWNjZXNzZXMgdGhlIGNvbmZpZ3VyYXRpb24gc3RydWN0
dXJlLCBjb3VsZCB3ZQ0KPiBzaW1wbHkgZXh0ZW5kIFZJUlRJT19QQ0lfQ0FQX1BDSV9DRkcgY2Fw
YWJpbGl0eT8NCg0KSSBhbSBmYW1pbGlhciB3aXRoIHRoaXMgbWV0aG9kIHdoaWNoIGlzIHdoYXQg
d2UgaGFkIGluIHYwLg0KSXQgd2FzIGEgcmVnaXN0ZXIgaW50ZXJmYWNlIGFzIE1NSU8gYXJlYSB3
aGljaCB3YXMganVzdCBmaW5lLg0KSXQgaGFzIHByb2JsZW0gd2l0aCB0aGUgcmVzZXQsIHdoaWNo
IGFsc28gY2FuIHdvcmsgaWYgd2UgbWFrZSB0aGUgcmVzZXQgcmVnaXN0ZXIgdG8gYmVoYXZlIGlu
IHNhbmUgd2F5IGluIHRoaXMgTU1JTyByZWdpb24uDQooc2xpZ2h0IGRpZmZlcmVudCB0aGFuIHdo
YXQgMC45LjUgaGFkKS4NClNhbmUgd2F5ID0gZGV2aWNlIG11c3QgdGVsbCB0aGF0IHJlc2V0IGlz
IGNvbXBsZXRlIChyYXRoZXIgdGhhbiBkcml2ZXIgYXNzdW1pbmcpDQoNClRoaXMgd2FzIGJ1cmRl
bnNvbWUgZm9yIHRoZSBkZXZpY2UsIHNwZWNpYWxseSB3aGVuIHRoZSBBUSBleGlzdCB0byBhY2Nl
c3MgdGhlc2Ugc2xvdyByZWdpc3RlcnMuDQpUaGlzIGlzIGxpZ2h0IHdlaWdodCBtZWNoYW5pc20g
Zm9yIGRldmljZSB0byBpbXBsZW1lbnQgY29tcGFyZWQgdG8gTU1JTyBvciBjb25maWcgY2FwIHJl
Z2lzdGVycy4NCg0KU28gd2UgbmVlZCB0byBkZWNpZGUgYW5kIGFncmVlIG9uZSB3YXkgb3Igb3Ro
ZXIsIHRvIHByb2dyZXNzLg0KVGhpcyBoYXMgYmVlbiBsaW5nZXJpbmcgZm9yIGEgd2hpbGUgbm93
LiBMZXQncyBjbG9zZSBvbiBpdC4NCg0KMS4gbGVnYWN5IHJlZ2lzdGVyIGFjY2VzcyB2aWEgQVEg
KHYxKQ0KUHJvczoNCmEuIExpZ2h0IHdlaWdodCBmb3IgaHlwZXJ2aXNvciBhbmQgZGV2aWNlcyAo
bWFpbmx5IFBDSSkgdG8gaW1wbGVtZW50Lg0KYi4gRW5hYmxlcyBzdyB0byBjb2FsZXNjZSBzb21l
IGRldmljZSBzcGVjaWZpYyByZWdpc3RlcnMuIA0KQ29uczoNCmEuIE5vdCBzZWxmLWNvbnRhaW5l
ZCwgcmVxdWlyZXMgUEYncyBBUSB3aGljaCBpcyBhbnl3YXkgZGVzaWduZWQgZm9yIHN1Y2ggcHVy
cG9zZS4NCg0KMi4gTGVnYWN5IHJlZ2lzdGVycyBhY2Nlc3MgdmlhIG5ldyBNTUlPIHJlZ2lvbiAo
djAgKyBzYW5lIHJlc2V0KQ0KUHJvczoNCmEuIHNtYWxsZXIgY29kZSBpbiBzbG93IHJlZ2lzdGVy
IGFjY2VzcyB0aGFuIEFRDQpiLiBTdyBjYW5ub3QgY29hbGVzY2Ugc29tZSBkZXZpY2Ugc3BlY2lm
aWMgcmVnaXN0ZXJzLg0KYy4gU2VsZi1jb250YWluZWQgaW4gdGhlIFZGLCANCg0KQ29uczoNCmEu
IFJlbGF0aXZlbHkgYnVyZGVuc29tZSBmb3IgdGhlIGRldmljZSBhcyBpdCByZXF1aXJlcyBtb3Jl
IFJXIHJlZ2lzdGVycyBhdCBzY2FsZS4NCg0KMy4gbGVnYWN5IHJlZ2lzdGVycyB0dW5uZWxpbmcg
d2l0aCBhZGRpdGlvbmFsIGluZGlyZWN0aW9uIHZpYSBQQ0kgY2FwYWJpbGl0eQ0KQ29uczoNCmEu
IHRyYW5zcG9ydCBzcGVjaWZpYyAoYnV0IG5vdCBiaWcgY29uY2VybiB0byBtZSkNCmIuIFR3aWNl
IHRoZSBzbG93IGFzIGl0IHJlcXVpcmVzIFJXIGNhcC4NCmMuIEluZmVyaW9yIHRoYW4gIzIsIHN0
aWxsIHJlcXVpcmVzIHNhbmUgcmVzZXQgYXMgIzINCg==

