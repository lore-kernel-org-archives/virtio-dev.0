Return-Path: <virtio-dev-return-12648-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09CD5C77B7C
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 13:02:40 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6BE98127CAA
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 13:02:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 62F2E9865F9
	for <virtio-dev@archiver.kernel.org>; Thu, 11 May 2023 13:02:39 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 55DB29865E3; Thu, 11 May 2023 13:02:39 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 415E89865DB;
	Thu, 11 May 2023 13:02:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9W/5Vj2yB9goUafAU2TwNrsowYkUpvyFTzzECzBrgR13B5rTd6Tzi+HqJyX3IpmBYyPNT5MdHdxI2BZD7URKwbQN4l9+bhmeNTSovzfP0yKwSYTp7c1Mj/9pi7yq7kzNytelbpFelbOWZa0f8epEdfEG7416DnahUvAL2aCewOLazYDkEvDhy2Ch5SGQ2awiumVXOzxIj8l6Z/zg29dkGgXj2DBFN6HbJn4cO4tOteOOI5BmEUziy3Dw90woqUkh8xUKoBNNXU4Ezaxc/BxF3z8K/p+YRXuow4EJhxN/s75+n3mKi3HTz9uJ9PSNz5fC803CdDalChJ9RblRmuj4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JYD+2WqNeRxQriWo93CEL4HscgLJs3ovxXsiHUgpMkA=;
 b=iJ+pbN+XXSPBHca7sVSSWChGFqrxit2ACIoM0sABPrNpl5ZU3nP4geWuHYA0aGnsiv6FPxp/C4zbDLynebFt7RZPgh1421xNDdxifwLnga7f2mCI+Bw7y4MpoZUfl8+aFxeAA6hTbFZPwSAMoaLBgQ4HkOC2b5UVZd2aomgOeB8dzHwDClREDiuBsvVSjQ4qTicGyOcW0HcedFBDjhnK+ml9LhSq3krWoE4UcmetqOVy+Qw40lLnwsJd0HBz1rKC1GPIXI18x/w8wf0XHE7aD3xPzj3blZquJYQ/DYciFvAmpFPvA6smKqiF2NPoVrlp1wZkOB+H0HwwB8eoGz8SIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "david.edmondson@oracle.com"
	<david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ
Thread-Index:
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9Mhl4AgAJOSwCAANQugIADYnEAgAAP1ICAAAu1gIABh4gAgABhyYCAAABooA==
Date: Thu, 11 May 2023 13:02:29 +0000
Message-ID:
 <PH0PR12MB54812F2EFEC7B6A235953A82DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230506000135.628899-1-parav@nvidia.com>
 <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
 <CACGkMEvTs9oMewgrQpYZu1v1wdUXtxsvjqB6CPRf+y4C8EN_KQ@mail.gmail.com>
 <20230510033812-mutt-send-email-mst@kernel.org>
 <CACGkMEsp0i7EyyBBp06wJzrVBLNbH7MP_TT-j7b5c_yavgAmqw@mail.gmail.com>
 <20230511085205-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230511085205-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW4PR12MB7166:EE_
x-ms-office365-filtering-correlation-id: 5bfebd3b-99d5-46f0-2b1e-08db521ff9c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 L96BJkVmxHtrf8TbTFi0kQHGfv9864a4po760H8WVK8VfVxPxUujEYw2JqMBtm7o7y8vRYauXI3bY3aYXs7pAvvyspPslqsGrfW6y43+XJzAlQgRTv75CXcBrSGncQuLWUx+GklvBqoiR008E2Uz94rISCeSM8Dm+QBYarPoYXNLu59vB+12jyYkd8iN7/mGTL2sB0a3uJt8BuKtK+mDx7y2Lk+5hQelOqYz9eQOpFJHqUHq7zd/Bq/10j9+jR0Fq5JKL/GRC7lQbMniRQ1TyZWbBikmqUtdaySEwQ+MGYrQPywfC2QVlk2cL8I8gDM8KTD/hSzZ+Ce0EjvMBbHt4R4G5KH30YS7Kcc4o0bD59Fona30FJ5p99+OleGJNv99Lby3Eeokfl9XVOSZP+itXQuR68qIeAisFtxtFLOIgYcs4ieY5SoRaLBBg+nSUAYlF55PhZxUMJndOqtelsQo8d36OXSRHsmhL5z5E04KmXJ8c6zUkDShVhe1gIbuIzcTXYO0qVu2RNhASGYnEfFyS3iXWOcWLKVz1UUiTuj4MBuvEKzxvIA1ycH1p+f/vMOYXtFnr0keBpasLk9Y8ASk7ZBXl6qxhueniPPNQUpfJ14osNALMoiesFsoQr2C9pEr
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39860400002)(136003)(396003)(451199021)(122000001)(83380400001)(110136005)(5660300002)(66446008)(66476007)(64756008)(66556008)(66946007)(76116006)(55016003)(54906003)(4326008)(8936002)(86362001)(478600001)(52536014)(316002)(38070700005)(71200400001)(26005)(107886003)(6506007)(7696005)(33656002)(9686003)(8676002)(41300700001)(38100700002)(2906002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c2lXODkxNzkyem9uUXMyamZVbzJkZ3RDZGtsMEVEQVhWMVVoeVhqOExhbnZH?=
 =?utf-8?B?enRieU9nYlRPWXduNFZ0eEpFME1vdGd5Y0RXQVR5THZNY0FuMDdWeGtIcmox?=
 =?utf-8?B?Q0RqSnBBMWU0YmR2a1E2enBMLzErUlFCdEdEeEg1THZOU3lWbkUrdkVGNGcv?=
 =?utf-8?B?NmF3ZEJwOHltSzB5Zm5wSlpQRU9UQk55SENnL2J1QTJnU3duR1JjeEd3ZHRM?=
 =?utf-8?B?bnBpemVWUjUvcmdTdFhVNDlEdnZwM09iTG9Ta2I5YkRwUEJ4YzFqNzk0NHRH?=
 =?utf-8?B?anRTZGs5bENITGlMVFM3aG9kTjdWSDZpM2NrNEdZQzZ3WE12N3JqbkhvQ1hG?=
 =?utf-8?B?OUgyK0J2MDE1bCtQRDN6Z2NWak0yLzZQTUd3N09TS1dNbjVVT3BUNE9IbEds?=
 =?utf-8?B?dkdoZG56N05TY0pEbmwreTc3NkhiNDNNbVltcnBrOTBKSk1uWmN5Rm9xdzNF?=
 =?utf-8?B?R0phRHpEMjVvVlh3aGVXSno5aHhsUk1QY3AwRG1wVmJ5SFpNWW1QVFZkVEE0?=
 =?utf-8?B?WWMrRk9YZDBSS1hFb0N0K29uc1JoS1FUODA4bnNTeWhqaEJVdU52b0Zjc05h?=
 =?utf-8?B?Mlg3NkUrcFNydEdEVFg3RzlzMzg4NjhZZW9CZkxDWlpQbU1ycE5yd2pxL0Nj?=
 =?utf-8?B?a1BNVG1yVlpQS083L0JaWUZiYVhweWJyUTduKzUrMzFrbWtRMGt6SThRc3Fl?=
 =?utf-8?B?NCtVY1FyQ21QTlkzWVdLcTYxeGRCdGxUb2pKWkxxZ0ZXd2l3dzlHaVhtVk5M?=
 =?utf-8?B?T1J2YVlFMDJPZnJpSlBRNk5uZXZYdzNZd3MyV3hzNkFTY29LMUkzTnBjajBD?=
 =?utf-8?B?Y2d2dDY1UGdOQkhYS3NOaGltWkVSQ1RPUnZ5TGVJazhjdXVaS3A2bjg5cXdB?=
 =?utf-8?B?Vk5ScVphWTl6dEdZaEV1WmNYdFhSQTRFUUZRcXJSeEd3dUtIQkNISWQ1MmhH?=
 =?utf-8?B?eTk3bzE2bGFDbHNXM0ZhNVNESVF6Zmo5ZDAwWUx3VDhCSkxSZHJQL3k1N1hU?=
 =?utf-8?B?Qm5lUEYwRDlZRFhsYlM2MkFMRDhrVzNaV2NHamhudEVXdGQ4UWtNSWpHUXV5?=
 =?utf-8?B?T044MEFWczNsQkpZYTRkNE91Z2RaTW02UjFDdUw3QjdtM1R6UWx2WnhDMGcv?=
 =?utf-8?B?TlN6ZEtvRFhjcWpWR3hRdzl1bWpUOFg1NjR3SFp2QlMwYXB2QW8vdzMrODhF?=
 =?utf-8?B?TklvTTMwMCtWTVNyeG1ZZWJMT0d1Y2h4Y2dlRExMRklkSVRneHFQQVZLeHJL?=
 =?utf-8?B?V2NwNVRucWUzZnRDaXp0RExzWFQ4aTFpRlpsTTdKNjFMRlJ5UDhwZkl0Ukor?=
 =?utf-8?B?cGh0Y0Y0d00ySjh1Tnk3bTNjWGFtWlpBeEFUSm5uWHZDYzZZeDludjVseGlS?=
 =?utf-8?B?eXBVU2ZCU3MwWFoxdEJuR1ZmL0xoTmVmOHRNSlBYV0tod0RNKzNlZWZja2Nr?=
 =?utf-8?B?WFhqTGF1Qy80ZmhVSEcrUmhyTkVUcFE0S0JSaVQ2NXJjQ3Z6eTN0VHhWWkRF?=
 =?utf-8?B?cEorOUQwbDBMTjVlN3BNM3VhUGhXK09LWXJaMGpsZlRXcXdaczlqL1FPazA4?=
 =?utf-8?B?dHVDK0dRWERxcnptZGcxNDF5Z0dvL0dER0dVbFd2eDRjVDdPc0g3SkdPV0hX?=
 =?utf-8?B?M05RT0dUTnViQnAya0FDM0ovLy9OTFV5R2Q3ZFFqM2svelkzSnpRQUVIcW5C?=
 =?utf-8?B?SEI2c1JsbXRLY0xWdkhyMFl0Y1BHMTFZSS90cktQcVNrMXlySGN4dVhSWXg5?=
 =?utf-8?B?OVBxVkF2RTlhWE1oZEdCMmlvQk5WZ1hMVFpLTU1lT2VnNkZVNGFSUWpFUnVU?=
 =?utf-8?B?eGo4QnhDWURNTnhySU85bVJuWTYrUlFIcGVNQnl5N1VaQkpkN1k1ZEIwZ2dN?=
 =?utf-8?B?SVkzNGt6eGowcFhqYzJHOUttb1VmdWIzdEc2UGVOZFRoczkwazM3NWd5RGYx?=
 =?utf-8?B?MWkwQnVsaUo1Qmt4TklhL3BEdEFaWGZJYWcxTDMzenY3UGttSUVFQ2kreUxw?=
 =?utf-8?B?b1JBRmo4VHhYbjdtUHhRY3psL1FCM29tZHZLOWdvM1U4eHl4ZXdDTUhmVk5I?=
 =?utf-8?B?c2dKSFNrdlIzV1dINkxPQXVCNG1vRWphUDdvSHNrTHNKajRkL3JCRXFuTHdh?=
 =?utf-8?Q?cPuM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bfebd3b-99d5-46f0-2b1e-08db521ff9c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2023 13:02:29.0442
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JX+/lzLqzQXZxdalUG2Kt4QZ1zZuFg+lcB7SyU3cndb0aiZ78iuNQ/tMheiS7iTKp1b3HmBknq+qkMOEYgQ+JQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7166
Subject: [virtio-dev] RE: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

DQoNCj4gRnJvbTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4NCj4gU2VudDog
VGh1cnNkYXksIE1heSAxMSwgMjAyMyA4OjU1IEFNDQoNCj4gPiAxKSBkZXZpY2UgZmVhdHVyZXMN
Cj4gPiAyKSBkcml2ZXIgZmVhdHVyZXMNCj4gPiAzKSBxdWV1ZSBhZGRyZXNzDQo+ID4gNCkgcXVl
dWUgc2l6ZQ0KPiA+IDUpIHF1ZXVlIHNlbGVjdA0KPiA+IDYpIHF1ZXVlIG5vdGlmeQ0KPiA+IDcp
IGRldmljZSBzdGF0dXMNCj4gPiA4KSBJU1Igc3RhdHVzDQo+ID4gOSkgY29uZmlnIG1zaXgNCj4g
PiAxMCkgcXVldWUgbXNpeA0KPiA+IDExKSBkZXZpY2UgY29uZmlndXJhdGlvbiBzcGFjZQ0KPiA+
DQojOSBtYXkgbm90IGV2ZW4gZ28gdG8gdGhlIGdyb3VwIG93bmVyIGRldmljZS4NCldoYXQgZG8g
d2UgZ2FpbiBmcm9tIGJpc2VjdGluZyBpdD8NCkV2ZXJ5IG5ldyBhZGRpdGlvbmFsIG5lZWRzIGlu
dm9sdmVtZW50IG9mIHRoZSBoeXBlcnZpc29yIGFzIE1pY2hhZWwgbm90ZWQgYmVsb3cgb24gImVm
Zm9ydCIgcG9pbnQuDQoNClRoZSByZWdpc3RlciBvZmZzZXQgYW5kIHJlYWQvd3JpdGUgaXMgZmFy
IHNpbXBsZXIgaW50ZXJmYWNlIGZvciBoeXBlcnZpc29yLg0KDQpOb3QgdG8gZG8gY3Jvc3MgcmVn
aXN0ZXIgYWNjZXNzIGlzIHdoYXQgd2UgbmVlZCB0byBkZWZpbmUgaW4gdGhlIHNwZWMgZm9yIDEu
eCBvciBmdXR1cmUgdGhpbmdzLg0KDQo+ID4gSXQgZm9jdXNlcyBvbiB0aGUgZmFjaWxpdGllcyBp
bnN0ZWFkIG9mIHRyYW5zcG9ydCBzcGVjaWZpYyBkZXRhaWxzDQo+ID4gbGlrZSByZWdpc3RlcnMg
KHdlIGRvbid0IGV2ZW4gbmVlZCBsZWdhY3kgcmVnaXN0ZXJzIGluIHRoaXMgY2FzZSksIEkNCj4g
PiBnaXZlcyBtb3JlIGRldGVybWluaXN0aWMgYmVoYXZpb3Igc28gd2UgZG9uJ3QgbmVlZCB0byBj
YXJlIGFib3V0IHRoZQ0KPiA+IGNyb3NzIHJlZ2lzdGVycyByZWFkL3dyaXRlLg0KPiANCj4gVGhp
cyBuZWVkcyB0aG91Z2h0LCBpdCBpcyBkZWZpbml0ZWx5IG1vcmUgd29yay4gIEVmZm9ydCB0aGF0
IGNvdWxkIGJlIG1heWJlIHNwZW50DQo+IG9uIG5ldyBmZWF0dXJlcy4gIFdoYXQgaXMgdGhlIG1v
dGl2YXRpb24gaGVyZT8gc3VwcG9ydGluZyBsZWdhY3kgbW1pbyBndWVzdHM/DQo=

