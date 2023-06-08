Return-Path: <virtio-dev-return-12886-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CF70C7EE25
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 14:38:57 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7904A2AD4B
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 14:38:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 727B598668A
	for <virtio-dev@archiver.kernel.org>; Thu,  8 Jun 2023 14:38:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 64F6198666B; Thu,  8 Jun 2023 14:38:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 51EF198666C;
	Thu,  8 Jun 2023 14:38:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k11bPYl9Kgf3fssnikUYRdEyztbc7U/xHj3LHpTOd4NuyCU7xl8fOIWhzeRFTtgerlnhnQh6rcJ0ZA/ctWwgboP73JMmBFbLgey4tWBb5Inj+1NrKtLMGuFm5EjAZU95PQ2ua4t8a8RIb+stAy9XmPaQf2TMSQrEwNvCr2+HObir4V3Q0lZSrFaEHkZ0i2YvoWkoRfjjAyI9rMb4O+EiPOo713FpP0fB1B8op8uP3Ww3MZCQy6nD1mEi7HCNsQpvWFrRzrHfV/jQ3K1Zk3/Ei4u082GWujnr+54NbF+0PiYRPa4jrFCvZSMM6Ibttn7fFvVVv/4QliYcKnKydXBcag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kWyQoyJN9+bZU8bh3MSP2JPdbz3faJytR4VP5UC2xtA=;
 b=VN+dJ/175gpb9iM5LIcXSq7gXprDTk4+fKPx9svhsF7WD9zaJenkJ/UYo9RqdjdRXP6PAFKMboL90RZFjoA98MNVv1azcyuTtD6NqE/sVXp8Uiij9QV7nmalYNNU9vuA8ztjCzXrcF0AtaUoEbxpEKW9QR15j9D3HrpOaDIA1jjwL9N5+sqYjacuuBW6tMzCKrs3kPq9U3qOvOZPrKrBvIsAOP1gZrrHMTcJTYx8MslNpT46fsfrzfKlrlvt9H7zloPkAPSp77Kx49oA2+UYUFheKWp/gHG8kM6frCHi6m42OcxPfIytQCnzGoB3uhlyaPCjC/xzHp9P1fr5KqXdaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>, Yishai Hadas <yishaih@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy
 registers access using AQ
Thread-Index:
 AQHZlZHqSKW+Shm580CRlUjcCTH7qK96p2iAgAAAjkCAAAV4gIAAAhyAgAAFe4CAAALHYIAABcIAgAAChLCAAHFxgIAAHa6ggABpWICAAHwV4IAACZWAgAAiwLCAAGU9gIAAAqIggADn3oCAAPNNAIAACTvQgABBawCAAhKfIA==
Date: Thu, 8 Jun 2023 14:38:43 +0000
Message-ID:
 <PH0PR12MB54810313CA6DD1995F52745DDC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
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
 <PH0PR12MB5481D80A48F3BD82D86B3DB0DC53A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsVrqCGJJ2Q5OGbgPdtEJHTpvVt6nEKP_MzkSH_-cOa6w@mail.gmail.com>
In-Reply-To:
 <CACGkMEsVrqCGJJ2Q5OGbgPdtEJHTpvVt6nEKP_MzkSH_-cOa6w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB7495:EE_
x-ms-office365-filtering-correlation-id: 37e96d9d-855a-4020-7c14-08db682e0f07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 wPDrr0viu4GXXACAe5ZuNyw0Te8ZfrkROUJs2fZn5j0T37vy7YxzYVPu6VAVp2e/cIlFsZ4l9DIS9yOBt2mYBc4zTbr7fizsAIOBV6h0gYL1/Xd5ok/mUDSnsesAeSUNl79dMDbnrfgjF7pmLknQHrrg5eisuvmslKDAMuzDKll1lBrKR088SxjhEMeVkPXypM7jz4FsaRn4UUDOM5CC3WIFh0xUCrosZM3nClS9xQin7pO1kYtBpAka24Tshla2EqdVXH1Wvkx4ZJoTMa1clvtbtWe3Ag15JnUa6rdC0h/xLyg7wtFWayes9DFNPOyg0WERYMChNe55v+dT4+HIcvTq+dnu0ZkJ5HxZpPnpELnYP3I+u5iiGYcvV5Vw4h34pzwZTbXE0ordPof7K0vXH+AYmfuBWsG5otThsDq584TPtGMBSywMPEYVyEqQtcFZheLd29JySpEcDEPkhrn/HgnJ+pOKw++a8zAiRG73dXczZHJ9yYCxrUwLHGpLfv7lLVy3tPQxe+HL6Yrg+cin/SScvHFQtRxwwEHQIfcAfQpipTZOg1BbUPzu9GjtjbpDeOBxVOqU7aotUhiWDedtaSg9giG69HDu1OusTZtifC9qqw2BBtLriPgObjsdIt/S
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(366004)(376002)(39860400002)(451199021)(55016003)(83380400001)(26005)(186003)(107886003)(41300700001)(52536014)(5660300002)(9686003)(6506007)(33656002)(4326008)(66446008)(64756008)(71200400001)(66946007)(66476007)(76116006)(66556008)(8676002)(478600001)(8936002)(54906003)(86362001)(6916009)(2906002)(4744005)(38070700005)(7696005)(316002)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ek5qbWZsdVRSY3g0cWIrSHltc010bFJwMnNKRUlLd0xka1dDNzR5Z25oajZk?=
 =?utf-8?B?YnJCN2hkenRmRG1ickxoYUQ4bzFMQzZnOWNDUXRJSno5dk9XZWlwdk56c3Ux?=
 =?utf-8?B?ODJFWUszMkRiV2JHYlRKNGo1dXNldFJEcmhHM0ZscGVkcTJlOTh6R1JzalNw?=
 =?utf-8?B?MHdsaWlNSmVITmR1bnYvUi9WZWIrOFRFZ29URGpCTVI2c2szWDdFN0x3NEtU?=
 =?utf-8?B?Y3FISEFOUnB3cVJRRUtCOEx3T2ZlaHI3djVUdU5JWjVaMDI1eGtoVkl0b3Ir?=
 =?utf-8?B?bDE0TDhRbm1FQkt6anVRSkV1clRGOEhITDl6STJOcmx1ZzIxZmYySUlnNFR2?=
 =?utf-8?B?aE1FSWwxOXlwNWd4V2F2Z0gwRjlwb2tIZnNEeG00YzJ4R2JaVXZzR1MrUGlB?=
 =?utf-8?B?NTFKZUI3bFR6T2thdmtvREUyU1JnY1gvQ0kxS0Vmb0pBajdRMWNJeWxuQlhu?=
 =?utf-8?B?aUVrN2oxS0tXUzAraE51OHZMSTl1MThueFhEa25adS9ZSVJwMXRRL1ZSUFFX?=
 =?utf-8?B?QUhxd2d2eFJDd1pIQUora1pvOXd6aVlQN2FYc2FuZXlXZElvQmJ0cFh5ZWdz?=
 =?utf-8?B?djZMSGNsSEZuNG5wMStqS213VGg3U0ZLRXg3cHpCSTN4cjlXQ3JSd0VYaW5O?=
 =?utf-8?B?NSs3VW1ISGE3MWpkMUNiUThiNXBpQkxhc0kwUkVlWVRUQ3dwcVJLN3kxaHRP?=
 =?utf-8?B?TG5qMjVOUjRtNUlobmVKWGJMZXNtYnRCNVY5OUdLZDFDNy9OWThZSXBJN1dn?=
 =?utf-8?B?STdDSjFSMjJoNC84Rkw4Y3laclFMaDJjSnkyc01SU0VvdGFhUkVwZjBQOFJU?=
 =?utf-8?B?K0hoY1ErR0RLbEtMVlVvTXA3UUNYZUtaaGJWZnEvcHBEeXFDcjJaVklXMWQx?=
 =?utf-8?B?UW0zaS95ai9nYTJoVmZlWmZSU3Q3cDVLOFBwa1B1NTA1YzdXVm1HdEJsNVdQ?=
 =?utf-8?B?WnpuK2NhYkwwSVhzajJWUEcyeldudm5naDYzVllvWTJaQ3YxQ0p2TDViYmE2?=
 =?utf-8?B?ajN3Rm9XSVlVS1Vtd3J4Y1IrTUNILzE2K2hwbVl3YXd6UVJHOXZnUTdkcHg4?=
 =?utf-8?B?T1hpd0RhQlo4QUZ1SGNtMWhNaTB1QjNqMUdTamdoMHhvbC9Lc3RqQ05sRWlB?=
 =?utf-8?B?VWhQQkdUK2hoOHV0NHpaeC96cFkrN2FGQm1KVjBpcnF6TDFLejBXMCt6R3M4?=
 =?utf-8?B?emM2aGlzSFF3WWtEUmoxSGJlRUFVVkVHeTdBLzI3UzVxZEtVMkJHMmIvY2RR?=
 =?utf-8?B?aEZTWWVZcmVneUVzM2VPdU1Jb1dCODZGSThuVkl1cUI2U3lnN291MnI5Sk9Q?=
 =?utf-8?B?NkhRL3RYYy9OOHB3bWJFTVJidjdGTjFlT3ZVTVFuckd4TzVsOVJsSU9zWW5k?=
 =?utf-8?B?ZUVxUzJmU2JEd1ZFVlRpUENIVUE1a1M0aHYvenIyVm96NG1KbzROck9iM29F?=
 =?utf-8?B?K0V2TXBjNTJhblArRll6RThweUowU3RlVWErck14eTM1d0IxZmpadjJ4M1Ev?=
 =?utf-8?B?bjBZeW9kRXlLVllFK1hWeVExUkpzelZ2ZmFqMGtvZmpFdjQrT2F1ZnZiNThz?=
 =?utf-8?B?a3FyV2xwaExtdGx6TFJVSGtkTC83RjBlUmcxY2EzUmg3TjVBSXVYTlBVS1Zk?=
 =?utf-8?B?WTF2Ly9qTkpzdGJZekc4RVRNa1BuZTB4bCt5RjZRa1VWNWFNTzhwY1NTUTdq?=
 =?utf-8?B?bWw5Sk9XcjVwMWhtdk8yeU56TXlXVkFoRVdFMTVPTFZuOUcwajY5bGhXbkNB?=
 =?utf-8?B?Wnp2bzJ1WjV6Tk0xNU1lOXVmUGd2VkxmWlV0TW5oTE5OTXBZTmdCeW9vWnhm?=
 =?utf-8?B?KzRpNnlsOHhyeCtvTnNaVlA5S2w3L1N5L1JVcUd6KzQwRDRoUmpOVnd1bjBM?=
 =?utf-8?B?aU9uYThQQXc5NElVeVVKdFNmVXBTYStLaVZBRFVTRmwxSEgweDFnUmF2d21S?=
 =?utf-8?B?ODNGNFNyOEdxTTkzTzlZejZzUlFyaWVRbUlUOEJGQ1FoQ253SkZnUTNXZ0xv?=
 =?utf-8?B?bmhod1cyN0R0dE9tQytHemlzeE5EVlBURXhpMFA3RXhYeTU1Tjd1WE1Uam1m?=
 =?utf-8?B?dit2ZHU1U1hWS3JLWEsvNHJ4dkdwYStvUWp3aWZweHh5MjlEN0pWMzJTNTNm?=
 =?utf-8?Q?x4PY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37e96d9d-855a-4020-7c14-08db682e0f07
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2023 14:38:43.2467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L3ySBwZFKtGtSN/u6o7224EpGdawbR4eD9LCMgPd/HMy+LIhFenRM3K4KGI6ROswg9SilWbZH/48UovytiQsmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7495
Subject: RE: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy
 registers access using AQ

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5l
c2RheSwgSnVuZSA3LCAyMDIzIDI6NTQgQU0NCg0KPiBIeXBlcnZpc29yIGNhbiB0cmFwIHRoZSBs
ZWdhY3kgZGV2aWNlIGNvbmZpZ3VyYXRpb24gc3BhY2Ugd3JpdGUgYW5kIGNvbnZlcnQgaXQNCj4g
dG8gY3ZxIGNvbW1hbmRzLg0KTWljaGFlbCBhbHJlYWR5IGFuc3dlcmVkIHRoYXQgY3ZxIGlzIG5v
dCB0cmFwcGVkOyB0aGlzIGlzIHRoZSBtYWluIGRlc2lnbiBnb2FsIHdlIHRhbGtlZCBzZXZlcmFs
IHRpbWVzIHRoYXQgaXQgaXMgcGFzc3Rocm91Z2ggZGV2aWNlLg0KDQpTbyBubyBwb2ludCBkaXNj
dXNzaW5nIHRoaXMgYWdhaW4uDQoNCklmIHlvdSBoYXZlIGFueSBjb21tZW50cyBvbiB2NCwgcGxl
YXNlIGxldCBtZSBrbm93Lg0KDQpCb3RoIHRoZSBkZXNpZ24gcG9pbnRzIGFyZSBhZGRyZXNzZWQg
aW4gdjQuDQoxLiBUbyBzcGxpdCB0byB0d28gY29tbWFuZHMgZm9yIGRldmljZSBhbmQgY29uZmln
IGFyZWENCjIuIFVzZSBwY2kgY2FwIHRvIGxlYXJuIGFib3V0IG5vdGlmaWNhdGlvbiByZWdpb24N
Cg0KU2luY2UgdGhpcyBBQkkgcmVmbGVjdHMgd2hhdCB3ZSBhZ3JlZSBvbiwNCkkgd291bGQgd2Fu
dCB0byByYWlzZSBmb3Igdm90ZSBpbiBjb21pbmcgZGF5cyB0byBiZSBwYXJ0IG9mIDEuMyBpbiBm
ZXcgZGF5cyBhcyB3ZSBoYXZlIG1vcmUgdGhhbiAzIHdlZWtzIHRvIHNvcnQgb3V0IG5vbi1BQkkg
bGFuZ3VhZ2UgcGFydC4NCg==

