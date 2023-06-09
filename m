Return-Path: <virtio-dev-return-12913-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C8AC7EE29
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 02:53:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0025A2AC74
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 02:53:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E97EB9867EE
	for <virtio-dev@archiver.kernel.org>; Fri,  9 Jun 2023 02:53:10 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DD08C9866AB; Fri,  9 Jun 2023 02:53:10 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C0C0D98668E;
	Fri,  9 Jun 2023 02:53:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgcZ+KE4E6JQLrm+7XwXrNk1+S/Mzt+xqsgW+2gNWVmpFSiwOUVPHd8qYXsxZJgaHcJz2ZRdeUnTjU4w8cpg36JIUbdBfj2nSCGRl+H/ZVtIknYSVGieGCYkmbX6K+W/cUh5gMUU3FFlpXzFPNy75aFVQe8+PDAnfyio0b6+cGoeKHCACok0uE87lsP2LEw20rts/N7VZ+4aJ6OP9yEolmZSUOssYv3+b7dkTZpCgWSlwjoZB/c1n4Z+OXJkNgPzirnJ++6YEzZDp1uM1FGZBczDOC6ri62xpJxO/WbgGcaesTnQImKt/CggpJ5tsCAhSesZ4WMxKtuvdZv1V1ydXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iFrJCZPkJ8ydqMjaTu4RAkep4GNHpZw5YqtluAk23g=;
 b=OflNYRrTGw87MrvYC9dzp2pmwdkC1vCONE4OI4cV/6TG0TnDEtyho+ZgQ4gJEpYg8jSriFHsI+M3tnTLODsUERlfQqOPiLE+brMYSyPGs7ux+xKz09Ba9z3Nd3RVn6O/Gw2TLjyTxB4TJxBiaEbHCy0452HlZuWvzX79xN9trqotaOC4+1p5NjjN+pS2k6xWv+qf0R5ck8cwGilEol3uvCA7hdcfkvyJvCn3iM5lCvxSE2nIq5VJL8LV07zf3rN6QkSGpXx/4YQagaVU5wsClaiq0KxnUTceC1dcWL4U0HnjDOAubgCzAMEiZ2NF9NdX6dO9T56jFamlpY2J+IqAyQ==
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
 AQHZlZHqSKW+Shm580CRlUjcCTH7qK96p2iAgAAAjkCAAAV4gIAAAhyAgAAFe4CAAALHYIAABcIAgAAChLCAAHFxgIAAHa6ggABpWICAAHwV4IAACZWAgAAiwLCAAGU9gIAAAqIggADn3oCAAPNNAIAACTvQgABBawCAAhKfIIAAwayAgAAF5ECAAAQjAIAAAcxg
Date: Fri, 9 Jun 2023 02:53:06 +0000
Message-ID:
 <PH0PR12MB54817C027CB2B7BB74BD35EDDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
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
 <PH0PR12MB54810313CA6DD1995F52745DDC50A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsy=pG=LT0hOT-PO3HTkk3NOAu6qA_GaZpKwqq8B996cA@mail.gmail.com>
 <PH0PR12MB5481B197049376E7C4D0112EDC51A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEsPjwgx=atOC1ww+RnfJcrg7m2CmMXWQCCoreCwsWVpLg@mail.gmail.com>
In-Reply-To:
 <CACGkMEsPjwgx=atOC1ww+RnfJcrg7m2CmMXWQCCoreCwsWVpLg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ0PR12MB5610:EE_
x-ms-office365-filtering-correlation-id: 3118b70b-e485-4d59-9334-08db6894a68f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YPhnbOIhHk/SWXbT9GP/YVKjvqzcezirpObHA1XX5IwYtJ0Uv3RTq+3YpzlkeEJKNLdhfx7hGd5ZHjmv262drrALkbZ9fl+CDKJwNk4GikvKAsTgSlJdGFA+RVAvVrSWShboZ2Cdu4W33D+14TdnqXYXaaCR3z1+90tuk5MLSja7J1Jn1ul8dsfScFbbvzs4UPjO0e4DrAJE7aifpnLliCBAwDrw1tKnMsKHDR8sBFP+n+WOoDzJbIGOLFxyj2JqxMY3y8JqQ64mVYsKnahJ0/BNTLeEPXNpFcPRidufARA3Npf0kb86r2xpvfeSzNY+sCdVLFOGJDqPVgSd74M9g3swwHbbbVHPaX2HSZCid4Jn7ovLYCCV3LN396Kp6kOrawOoYlwkEtQmcIToIH8qX9QEJT0pX+taICludCbsRbeE3Lg9ofDibBIdBaSzPLIHgmAucHNj1wMIDEVfDS9aStdIW79D6NLr2QP5QFpWXSpnAyw1l3GbsW21LKK18wop6gTzonXjpuEIU68FYfjso0DTuA6YyYoXIFgnpVMeE33fBoJXu/B3DaTVVq08DQhUx56bauh5lP+OPPeO7DXL46tWS7F6aCIxWqO83Yb6NiYLt63LmRZrnMU8cjjkXi23
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199021)(54906003)(71200400001)(478600001)(52536014)(122000001)(5660300002)(8676002)(4326008)(2906002)(8936002)(33656002)(38070700005)(86362001)(76116006)(66476007)(66446008)(66556008)(55016003)(66946007)(6916009)(316002)(64756008)(6506007)(38100700002)(107886003)(41300700001)(9686003)(186003)(26005)(83380400001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TWc5bE9wV1VUNlhFS0RPVzJFdnRtSFFnSTJRRUNwcHovbjRwa1NjQXQ4TUZT?=
 =?utf-8?B?QVB1R2NrT3BWRHFZZ3FGaXZpcXV4b0hMQUpIc2J2Skt1OVRMRmwrMitHSVA5?=
 =?utf-8?B?UnFaWkZ1ZDZ0WW1YUFE4U29FNnBXODJ6czlnOW1qRUl2MmVhbDFtTnpsR2ZC?=
 =?utf-8?B?cVd5WXlBc01FUTBSN0g1MkdWYys0OUxFTit0N283R3dzclI3Wmp4cmpGQlBp?=
 =?utf-8?B?bHJRRzBpa1NHS0d2ZnZmNFV1TTJOZm41aVNMMVZZR2w0ODVMaDZENDFEdU9F?=
 =?utf-8?B?cEFjUkVEanBDNGtqU1YweVh2d0doTEtNMkNmdDRDaDhsdkx5aXpVWUtyQ3VX?=
 =?utf-8?B?MWlMQm02RWFlMXFUUzlLaVlCdVN1UkRzTFFPVE9leWRtazdwZ3p3UHVaOGN6?=
 =?utf-8?B?NnJxVk9TOWl4ZDQ5SlI3TXlEUy9vWjFjcitQajdKbGUxd2xmZHhiWmp4elpE?=
 =?utf-8?B?L3dxQS9XN29LNzRMaHdkWDNWTVErcHBTZlVKcStqNHgyMHhEc052SjExRXYx?=
 =?utf-8?B?WFc3LzlzcFVkYU1ob0pqbWlPdCs1RE4vdjBuNWljZFdBZUlGVU1pazVLWHVO?=
 =?utf-8?B?T1ZFb3FZN0dSZnBuK2xCdHR2VTE3STJaM2NRZFNMek5VYlI2alJEd3IwcDFw?=
 =?utf-8?B?SXBiM283U2J5N1puM0c2c081N3U4NW1yUmRoWjZXY0Z0dHZOZEYwaE10alBT?=
 =?utf-8?B?bG9qMEl1SjBoWXRoODRSVldtekF5Y28zM1ZPUGx5MHhzZlVSNStMM0NxY1Bv?=
 =?utf-8?B?MEhiOXQ1dFA2Vy91ZmlPL09tM0syWGdDTEFkUENJTmk2cnRaWXA3MUxHaENS?=
 =?utf-8?B?dHNZVnljTzFsenVINjE4dE5Wc3hDaGNIcDA4SGdDZlR2dGRTbWUvOGJCbkVp?=
 =?utf-8?B?WnR4L0VMODg5ZG9PaG5vVk9lQS9aeVE1THpNUmNpSm96VTZCRGRML1NCNWNM?=
 =?utf-8?B?N1dWUzRkazIrYmk0aEY4andUTmFxd2Q3bDF4ZTh4ck5RZFZ2STZmdmxWMDFq?=
 =?utf-8?B?SXNPQUdqR2pJUVA4RGFTY1RFeTVuejdDWlpUdXF5VlFTUkZlN0RndGx1N0RX?=
 =?utf-8?B?eDdIcUZhUjlVeW5MalBhMzdJdHo0b3dvK1Zhb3FIZ1RjWE54M3E5QnJVTWZN?=
 =?utf-8?B?MjFacTJIRXBZeDNBRVRzT25rSDhDakpCb052a0tDZ0dMa3QrcFFlOE1qRjBt?=
 =?utf-8?B?eG1iZVJEWWIwS09LZXBQWXE2SnoxUXVGQTZXMmJRTmR1NE5RT01RakFDNjFx?=
 =?utf-8?B?MlBnS3lMWDJpa2pGYmhDSXJ6ZUtMQ2k1SGtHeWZ2UmJaWHF5Wjh1VWZZVXVS?=
 =?utf-8?B?WU5WMXZnSllxVGt1TTdWTVM2K1ZjYjVZS2piT3JLWjJ3MnhNU3RyQUpnMUZv?=
 =?utf-8?B?L3llUkJ3Rm9oMlNFb3ZxQktwcFN5eDdqSWtVTFpNT1FMdWRuNDlZS2ZHa0Z0?=
 =?utf-8?B?K1J6MVZSVjc1dU0zVW9rVEY2NHNEVlM5NXR1cjV1T2MwQ2xEclFBMjZmanlo?=
 =?utf-8?B?Q1VUbEsyTWdxckZKazBjTVhRTVRROEw0WmFWbmlHc25Xd0NvTTJhUjRGOU1X?=
 =?utf-8?B?djFhWForZEJLd1FVa0R5Z0tYbSs2UEU3NkVJRnpSb1ZIajVQZGNXcGhMWHBn?=
 =?utf-8?B?QUdURzNISFRNSkNxUlF5b1lnTTNoYjh1enkzUENsdTRoN3BRck5nTURPWk5F?=
 =?utf-8?B?SmtmbitndnlpZFpWREx0Vi96cDJ0VTNXd1IwVXZycHNxY1p6NTlVTGE2R05S?=
 =?utf-8?B?Mi9jaytYZ2cxd0xlaVMzNzdMR1VGTlZDckI3eDJyU2tCR24wS1ZtRS9yT1Zl?=
 =?utf-8?B?dDBzMmp6bFgyUjNKdWlDbDBab04yRE1xM2VlT0FTaXpoSjUvTkpGTncvMTBO?=
 =?utf-8?B?cG85bFV0WWFGUzVuRjRrclJVdUlNRXpuYXV1eWVEa3BGRzlGRmxzMDlpcXNV?=
 =?utf-8?B?N2JRcVBaWlhlcng0OU5hVFhsRGVmYlN4dUJCaGt5WnZkYTFnMlZFMnl0Q01u?=
 =?utf-8?B?VWo5cG1iQVdzWTB3UU5uSFBwdVdkcTFtenFZNXBDcU5hSlc1SjYrTlVHM1J1?=
 =?utf-8?B?TXdKY1VpWWtxN0U0K1BXQzVPNXh4Ui9SR1BHNEJLSEoxWE5pWDkzSEpibzRn?=
 =?utf-8?Q?pGOM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3118b70b-e485-4d59-9334-08db6894a68f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 02:53:06.1596
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ddSEYOyij0F3ODcQx0VRvgkwOtt1BhPcCIZuIbkID8h3dkBpwZPyeiC22xB+SBhq766xSOxgC+m33EAgrztnBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5610
Subject: RE: [virtio-dev] Re: [PATCH v3 0/3] transport-pci: Introduce legacy
 registers access using AQ

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFRodXJz
ZGF5LCBKdW5lIDgsIDIwMjMgMTA6NDMgUE0NCg0KPiA+IEl0IGlzIHBhc3N0aHJvdWdoIGRldmlj
ZSwgbm9uZSBvZiB0aGUgMS54IG9iamVjdHMgYXJlIGFjY2Vzc2libGUgb3IgbWVkaWF0ZWQgYnkN
Cj4gdGhlIGh5cGVydmlzb3IuDQo+IA0KPiBMZXQgbWUgcXVvdGUgbXkgcmVwbHkgb25jZSBhZ2Fp
bjoNCj4gDQo+ICINCj4gSHlwZXJ2aXNvciBqdXN0IG5lZWQgdG8gcHJlcGFyZQ0KPiANCj4gMSkg
bGVnYWN5IEJBUiB3aXRoIGxlZ2FjeSBjb25maWcgYW5kIGRldmljZSBjb25maWd1cmF0aW9uIHNw
YWNlDQo+IDIpIG1vZGVybiBCQVIgd2l0aCBtb2Rlcm4gY2FwYWJpbGl0aWVzIChjb21tb24gY2Zn
IGFuZCBkZXZpY2UgY2ZnKQ0KPiANClRoaXMgaXMgd2hhdCBpcyBkb25lIGluIHY1Lg0KDQo+IEZv
ciAyKSBpdCBjb3VsZCBiZSBtYXBwZWQgZGlyZWN0bHkgdG8gZ3Vlc3Qgd2l0aG91dCBhbnkgbWVk
aWF0aW9uIEZvcg0KPiAxKSBoeXBlcnZpc29yIG5lZWRzIHRvIG1lZGlhdGUNCj4gIg0KPiANCj4g
VGhlcmUncyB6ZXJvIG1lZGlhdGlvbiBmb3IgMS54IG9iamVjdHMgYXQgYWxsLiBObz8NCj4gDQoN
Cj4gRm9yIGFjY2Vzc2luZyAxLnggb2JqZWN0cyBieSBoeXBlcnZpc29yLCB3aGF0J3Mgd3Jvbmcg
d2l0aCB0aGF0IGVzcGVjaWFsbHkNCj4gY29uc2lkZXJpbmcgaXQgaXMgdXNlZCBmb3IgbGVnYWN5
IG1lZGlhdGlvbiBvbmx5IGJ1dCBub3QgbW9kZXJuPyANCkkgZGlkbuKAmXQgZm9sbG93IHRoZSBx
dWVzdGlvbi4NCg0KPiAoQnR3LCBob3cgZG8NCj4geW91IGRlZmluZSAxLnggb2JqZWN0cywgaXNu
J3QgYW55IGZhY2lsaXR5IHZpYSBhZG1pbnEgYW4gMS54IG9iamVjdD8pDQo+IA0KMS54IG9iamVj
dHMgb2YgdGhlIHBhc3N0aHJvdWdoIFZGIGRldmljZS4NCg0KPiBJbiBvcmRlciB0byBjb252ZXJn
ZSB0aGUgZGlzY3Vzc2lvbiwgbWF5YmUgeW91IGNhbiBleHBsYWluIHdoaWNoIG9uZSBvZiB5b3Vy
IDMNCj4gdXNlIGNhc2VzIGFuZCB3aHkgY2FuJ3Qgd29yayB3aXRoIF9GX0xFR0FDWV9IRUFERVIg
KyBfRl9MRUdBQ1lfTUFDLg0KSHlwZXJ2aXNvciBkb2VzIG5vdCBpbnZvbHZlIGluIGZlYXR1cmUg
bmVnb3RpYXRpb24gYW5kIGRldmljZSBsaWZlIGN5Y2xlIHBoYXNlIHNvIGl0IGNhbm5vdCBuZWdv
dGlhdGUgaXQuDQo=

