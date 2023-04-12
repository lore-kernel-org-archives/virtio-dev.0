Return-Path: <virtio-dev-return-12189-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48A2C77B6E
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:30:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4C2512A892
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:30:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 444FA9865B3
	for <virtio-dev@archiver.kernel.org>; Wed, 12 Apr 2023 05:30:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 39617986509; Wed, 12 Apr 2023 05:30:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2677698650E;
	Wed, 12 Apr 2023 05:30:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNrGkqzG1bt8PRFu5H0pw5+UEAA+ElhE+YbPAgCeNcXRxnLiz1uznVvO3rMlqaz5Isl+Jrg7Rg8pEcYZHLjDBXzOKa1brFIiiF3YzErOkZ5DWlevg2Wf8DrKCwYfoL7O55qKLfDD9fOE49KvcaPcmDp5pq7cB63uTyTHVgF8Bevvb66e9khWO/nAWwUnv9Xqu8+8rAttxFVDSeknGF7UbWBhF6kt7HInrRQe5dyC8hwl+d0G9KWyoqCJDnuJSeGALmPXh77GcW+scvZNjRG2NIIOgSEtgwBFIhmUkIZJBUCgOSAQZ3D2ZX1lhtB3JIEHpUWLh/8Dv1S4rEcfyn7NRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V61jbMdIeMn2IUBBlM2HyLNOS3fj/4kmL+3u1f8+OkE=;
 b=K2bMg9jwzSoi2w2Qlfhwk1cl2ifXrwXams2bw8EHo1VlCsL9wogq4lhy7yREjI7gouaAJujFX3mFbMU63Gc73wB0YBxLDhet/ryv3zgkIH7gP/V3GQlufIbB0ojMrjakJ1qnZKhVCk9C9bKWexh2XxyU4qAz6O7c7KyBnHsideKqQn4Xv20MDHCb0I8Crkbp9EwQf534sozKIPFhACkACeecPk49FKDnv/WbsHDIAm+5jZTlInEhYbGyHj/V2xhQr33qJrav1vzDlbADLO49+KS17dxMa2UXdGPWpfXM+oZCobKq3IGw8yGG4dV7vuVGO5iRq5wUbfVM8mfefxIEfQ==
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
 AQHZY1tLAUtRpuZtUUOucQPGJlFfkK8flpUAgAQ7nwCAAE6hgIAAAXwAgAAFegCAAAt0AIAALl6AgAEOIwCAAFEgAIAAIPWAgAAcJ4CAASFtgIAABJ4AgAAKJYCAAACFsIAABgyAgAAAT3A=
Date: Wed, 12 Apr 2023 05:30:46 +0000
Message-ID:
 <PH0PR12MB548137D7A25C99EAA42B4D12DC9B9@PH0PR12MB5481.namprd12.prod.outlook.com>
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
In-Reply-To:
 <CACGkMEvYsz1fSPG+fKpRaZ05Ut7ffKwvMPvR8xbRBsXA_6vGQw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB7590:EE_
x-ms-office365-filtering-correlation-id: 69388ff5-a65c-4505-e8ba-08db3b17111c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 93GxPHcoeZsy3UsSo/X/w5diaX+HPbsCyAvz+TjRsmvnvDKCR4gxiGEQskeTO3rGfjN+7EjkQ4i/hWmjrmnaSIevABlL45ozlAzlApEvdErsMkNId6Rzs4xYdO1cOf1pw6WbsA3WGlWrtQ14+mnGVVMsRePcWxgIMDQ1WSM5nejJlhaRLf70qzYFy+uLXiOIFW5mYa8sH5jfINVBhpW0AOMrl2Evi8H3052xOnY+w31ROvtnXcBrOE27k3hDg272TvA1l6+TmlNP1UZaMecNxLKkQ5FGfpA7w03JbL1YwJiw/VgExKLIh4+3JfaCmhhBINt5sLuRVslRJ7Tn+numb9VETRvohMwaKHGUDOarTkC5v22ghAuTvMVpgnUDInCF6DLKZR7cnlhPfurzmi7BQVCjXaEXqTp4/c53bqGC0eZUR85LTESexOrvrZvnHek1B9siONrfpp7zyT/f5mm81cLO32Xvj9Yeh+7+hw4hDGk6ailyp3AsOUQR5/3rstWJiW7JgiMdWnhAn6d84Hkw08WrjZSoxrR/pEi3Z9SM/6HfpFd1wsYRKOxMXGeiWtEgdyW/8KKBs7B0q+nWT+/AX2wG0ZoIIh9otiDZXstH7xtr8WqiYuAnnNIgi9eq+jsb
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(396003)(346002)(366004)(39860400002)(451199021)(55016003)(52536014)(8936002)(66899021)(7696005)(5660300002)(86362001)(6916009)(66446008)(66476007)(64756008)(66946007)(76116006)(8676002)(4326008)(66556008)(33656002)(478600001)(38100700002)(38070700005)(122000001)(54906003)(2906002)(71200400001)(83380400001)(6506007)(9686003)(186003)(41300700001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?S2dEaUxKWGdPeW92T2V5UzBHalNZb2J3QUw3Q3FUekVjNFVzbG9wYWVJbUdJ?=
 =?utf-8?B?emRQbVJndDZ5VTJacnllcndzSnNTeGpSdW9iYVYvTjU3Y2w4eXNGRjVhaEYv?=
 =?utf-8?B?NjQ1QmNHdGhtY1RRN3lSYVU1YmF4bUMvSm1yVkdwVTd2ZzdIKzNvUHdteHlM?=
 =?utf-8?B?L2VjdFhRY1ZoN1FuNllBd3drM2g4TXhlaUtkbTBUSTI1UkVGTnREaDFiNW5F?=
 =?utf-8?B?TCtiSUlpQ3JnSWs5ZjJVSVJBUlhON0lleDZ6aE96OUZORjNUWEVjUjBjVUtL?=
 =?utf-8?B?ODI0UXVUbkZwZHArSXdqdlF4ck1GUjhLdzh5aU5vWVNkcE1nOUxCdmlMWWdN?=
 =?utf-8?B?Z1pRYzRuY2lNRnNDZVJmdUxDSExwakpoSnFrVEh3VWJJWEJhT3pPMm8wMkxj?=
 =?utf-8?B?TlRwNkJnU3AyMS8vMS9TREJWMEdOaDd2aURNSzU3Y3d0ODdHYWVrMThIUGxm?=
 =?utf-8?B?R3oyUkJ0aGNmNjcwa2FnR2VTRXUyZnM3dXg5NXR0MS83R1F3NFRJVHg3VWRs?=
 =?utf-8?B?V29Bc21JTGl6UEVMbkg1dG1wUjJyRUdGZDNhVFJsY2U2VmpNaXFidHRVVi9E?=
 =?utf-8?B?aE51RzJVZUtQQkRXMWdhaDVNbG1OdFZleU1rZXlKU3l3MmF3WVB5Sk90Y0F3?=
 =?utf-8?B?N1JMb25oL1c5eWFnTzlGVHQ3ZHB6MHpKQ0N5VHFvOWNYdUI4WTFFZ3V2T3hM?=
 =?utf-8?B?UUoyOHozZEFpb25vNHRKYjEwaWxqRFBBKzZtaDZqcnVMSkxtVnU5MzkzS2hS?=
 =?utf-8?B?QjJkNE5ZY0tKOVcxaUEzeS80L2JOeVRwU1k4UXdOSzlEUFZQWXlEV3B5b0ZM?=
 =?utf-8?B?b2dNaGEvQ1U4UnZEUktlRjFOWk9zM244VlZPMmpZd1E1djZvRk9WZ09Ed1Mv?=
 =?utf-8?B?N0htYVk1TWlGakRTREgvZFlqc2ZZWlBSUVlFNmdrYkNEcXZLMWh4S3BySi9k?=
 =?utf-8?B?ZUUxMlpEeHN3ZXZYTXh4VUVuYU12MXFOYkRkTEFHMXhUNFVXVXBXT3pGRzda?=
 =?utf-8?B?R0o0eHNySmt1R3h3N0xGUjI1eng4NzZwSW1JUW9QSU9CV2pwUThyOTZkZXIv?=
 =?utf-8?B?cHo0MS9YRG1vYzhHVFE1U3cxZ25sWDNQS3lkZ2twTTlRZEEweGRxVGowMDVa?=
 =?utf-8?B?STV5SldPMnR6YTJaVTdDVlhUUXdGYVpxVjlkU1pVMzVOUDAvYUpiVFIwNkF0?=
 =?utf-8?B?UHk5SXRLM3BrS1Bud2kvcDJ2alMwZ0VNVmlBT1llVkcwclpTN2xYbXNsM0ts?=
 =?utf-8?B?LzJ1RVlsbWw3UFhEMkxxNVdJMGMxUXo2dGhlRmljWE9xYlFxSWpGUXhhMG10?=
 =?utf-8?B?WU56ZHNVQS9vcUpHNVRqc21PR3piY0NDVkVQQzAvRjdUV2c1OWs1TTNZRldW?=
 =?utf-8?B?WXh4QndoVFg5d0tTQitaVEU2Q0d1T1ZuV0ZaS2diV1A4VFpmUUFNaUdFempI?=
 =?utf-8?B?Z01LTXozWWtnYk1xS0lubk83ZUxBMzRmSzVDMWlsaGZqZDFLYzFkSWprZ0NG?=
 =?utf-8?B?VElib0pPbExpMXhRT2tIRng5QzhXVFNIWmJReWF0TzM5RkhEQXN0amhJZWpS?=
 =?utf-8?B?WFpSUDk4S3ViK1JNbFU4L2krRGdjRk5lbWJ4VXlYU0JaSkxNNmFwdTRsREg5?=
 =?utf-8?B?Yjl2dWM2bjhUYmpjTHByNW5GSVhpNWZGV1NMVjV4TEFzYXlmc3haeCtRb1Bh?=
 =?utf-8?B?WTFreUd6bUJSYis5dlo1T0swZGVFbVZ2UkdUVVNkNHg1TjBiV3pwNG1zdEtu?=
 =?utf-8?B?OHl6RUJRbFIzdEwyTHBGSzhIaDk4R0lDcHMzUGJQN1EyaFFITitQakZxTHFC?=
 =?utf-8?B?Sm9tekFQeWFIWEtiYkF6ZjZVYjRNb3IydnFicENNclZwcmRXMHpDTmxGaEUx?=
 =?utf-8?B?VTlSNnVDanRkVjBVTWRuUGFCUDZ5cXVUM3ErYjVXQWhSR3EwVGU4Nnl0RGsz?=
 =?utf-8?B?cE80Q2kxbU1EZHZqRU5ydEJFQU51YUJ4Wlc4ZkVQNi9xRDR0NyszUUtNSnBL?=
 =?utf-8?B?MGF5NGFvTUZpYnVPVnR0am9yNmhKYVZJZk4yQis4d1ZSa3d2RkZlQ0tTK3hH?=
 =?utf-8?B?WXVZRUw0eEhuVFNqNlhkWndienlRK3NLSHFCMXQvRTl1OGJndEJSNitrS0FL?=
 =?utf-8?B?aXBKOTE2ZWhBSEFnSW9Pc1hlMGQ0bk00NGVMbnRSZTVnZGxJcnVhQWtpamxQ?=
 =?utf-8?Q?e3xJesY/HbjfSTbCK0v2rtU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69388ff5-a65c-4505-e8ba-08db3b17111c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2023 05:30:46.0405
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TRxtA/2FFd9pLZ2pddfwxlXxRar37/M2PuNHE5aWNM1ISCf3120P9MKa2/Wd4/iwfmIlBjDNhxyYcSVmf7at5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7590
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 09/11] transport-pci: Describe PCI
 MMR dev config registers

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogV2Vk
bmVzZGF5LCBBcHJpbCAxMiwgMjAyMyAxOjE1IEFNDQoNCj4gPiBCZWNhdXNlIHRoZSBzcGVjIGZv
ciBtb2Rlcm4gZGV2aWNlIGRvIG5vdCBhbGxvdyBpdC4gRGlzY3Vzc2VkIGluIHRoZXNlDQo+IHRo
cmVhZHMuDQo+IA0KPiBDYW4geW91IHBsZWFzZSB0ZWxsIG1lIHdoaWNoIHBhcnQgb2YgdGhlIHNw
ZWMgZGlzYWxsb3dzIGl0PyBUaGVyZSdzIGEgbG9uZw0KPiBkaXNjdXNzaW9uIGluIHRoZSB2aXJ0
dWFsaXphdGlvbi1saXN0IGEgZmV3IG1vbnRocyBhZ28gYWJvdXQgbWVkaWF0aW5nIGxlZ2FjeQ0K
PiBkZXZpY2VzIG9uIHRvcCBvZiBtb2Rlcm4uIFdlIGRvbid0IHNlZSBhbnkgYmxvY2tlciBkbyB5
b3U/DQo+DQpNb2Rlcm4gZGV2aWNlIHNheXMgRkVBRVRVUkVfMSBtdXN0IGJlIG9mZmVyZWQgYW5k
IG11c3QgYmUgbmVnb3RpYXRlZCBieSBkcml2ZXIuDQpMZWdhY3kgaGFzIE1hYyBhcyBSVyBhcmVh
LiAoaHlwZXJ2aXNvciBjYW4gZG8gaXQpLg0KUmVzZXQgZmxvdyBpcyBkaWZmZXJlbmNlIGJldHdl
ZW4gdGhlIGxlZ2FjeSBhbmQgbW9kZXJuLg0KDQo+ID4NCj4gPiA+IDEpIGxlZ2FjeSBNTUlPIGJh
cjogc3BlYyBjaGFuZ2VzLCBoeXBlcnZpc29yIG1lZGlhdGlvbg0KPiA+ID4gMikgbW9kZXJuIGRl
dmljZTogbm8gc3BlYyBjaGFuZ2VzLCBoeXBlcnZpc29yIG1lZGlhdGlvbg0KPiA+ID4NCj4gPiBU
aGlzIHF1ZXN0aW9uIHJlcGVhdHMgdGhlIHNhbWUgZGlzY3Vzc2lvbiBvY2N1cnJlZCBpbiB0aGlz
IHBhdGNoIHNlcmllcy4NCj4gPiBZb3UgbWlnaHQgd2FudCB0byByZWZlciBpdCBhZ2FpbiB0byBh
dm9pZCByZXBlYXRpbmcgYWxsIG92ZXIgYWdhaW4uDQo+IA0KPiBObywgSSB0aGluayB5b3UgbWlz
cyB0aGUgcG9pbnQgdGhhdCBtb2Rlcm4gZGV2aWNlcyBjb3VsZCBiZSB1c2VkIGZvciBtZWRpYXRp
bmcNCj4gbGVnYWN5IGRldmljZXMuDQo+IA0KPiA+DQo+ID4gPiAxKSBpdCdzIGJldHRlciBub3Qg
aW52ZW50IGFueSBvZiBuZXcgZmFjaWxpdGllcyBmb3IgbGVnYWN5DQo+ID4gPiAyKSBpZiBsZWdh
Y3kgaXMgaW5zaXN0ZWQsIGFsbG93IE1NSU8gQkFSMCBpcyBtdWNoIHNpbXBsZXIgYW5kIGJldHRl
cg0KPiA+IFlvdSBoYXZlIG1pc3NlZCBmZXcgZW1haWxzLiA6KQ0KPiA+IE1NSU8gQkFSIGlzIHBy
b3Bvc2VkIGhlcmUgYW5kIGl0IGlzIG5vdCBsaW1pdGVkIHRvIEJBUiAwLg0KPiANCj4gSW4gdGhl
IGNvbnRleHQgb2YgbWVkaWF0aW9uLCB3aHkgZG8geW91IG5lZWQgdGhhdCBmbGV4aWJpbGl0eT8N
Cj4gDQpUaGUgUENJIGRldmljZSBleHBvc2VkIGlzIHRyYW5zaXRpb25hbCB0byB0aGUgZ3Vlc3Qg
Vk0sIHNvIGl0IGNhbiBkbyBsZWdhY3kgYXMgd2VsbCBhcyBuZXdlciBmZWF0dXJlcy4NCkFuZCBp
ZiBCQVIgMCBpcyBoYXJkIGNvZGVkLCBpdCBtYXkgbm90IGJlIGFibGUgdG8gc3VwcG9ydCBmZWF0
dXJlcyB0aGF0IG1heSBuZWVkIGFkZGl0aW9uYWwgQkFSLg0KDQo+ID4gSXQgaXMgbGVmdCBmb3Ig
dGhlIGRldmljZSB0byBlaXRoZXIgbWFwIHNvbWV0aGluZyBpbiBleGlzdGluZyBCQVIgb3IgdXNl
IEJBUiAwLg0KPiA+IEJlY2F1c2UgUENJIGhhcyBvbmx5IDMgQkFScy4NCj4gPiBBIGRldmljZSBt
YXkgd2FudCB0byBzdXBwb3J0IGxlZ2FjeSBhbmQgbm9uLWxlZ2FjeSBmdW5jdGlvbmFsaXR5IGJv
dGggYXQgdGhlDQo+IHNhbWUgdGltZS4NCj4gDQo+IFRoaXMgaXMgcGVyZmVjdGx5IGZpbmUsIHRo
aXMgaXMgaG93IFFlbXUgZGlkOg0KPiANCj4gICAgIC8qDQo+ICAgICAgKiB2aXJ0aW8gcGNpIGJh
ciBsYXlvdXQgdXNlZCBieSBkZWZhdWx0Lg0KPiAgICAgICogc3ViY2xhc3NlcyBjYW4gcmUtYXJy
YW5nZSB0aGluZ3MgaWYgbmVlZGVkLg0KPiAgICAgICoNCj4gICAgICAqICAgcmVnaW9uIDAgICAt
LSAgdmlydGlvIGxlZ2FjeSBpbyBiYXINCj4gICAgICAqICAgcmVnaW9uIDEgICAtLSAgbXNpLXgg
YmFyDQo+ICAgICAgKiAgIHJlZ2lvbiAyICAgLS0gIHZpcnRpbyBtb2Rlcm4gaW8gYmFyIChvZmYg
YnkgZGVmYXVsdCkNCj4gICAgICAqICAgcmVnaW9uIDQrNSAtLSAgdmlydGlvIG1vZGVybiBtZW1v
cnkgKDY0Yml0KSBiYXINCj4gICAgICAqDQo+ICAgICAgKi8NCj4gDQo+ID4gU28gYmV0dGVyIG5v
dCB0byBoYXJkIHdpcmUgZm9yIEJBUiAwLg0KPiANCj4gVXNpbmcgQkFSMCBkb2Vzbid0IHByZXZl
bnQgeW91IGZyb20gYWRkaW5nIG1vZGVybiBjYXBhYmlsaXRpZXMgaW4gQkFSMCwgbm8/DQo+DQpS
aWdodCwgaXQgZG9lc27igJl0LiBCdXQgc3BlYyBzaG91bGRu4oCZdCB3cml0ZSBCQVIwIGlzIG9u
bHkgZm9yIGxlZ2FjeSBNTUlPIGVtdWxhdGlvbiwgdGhhdCB3b3VsZCBwcmV2ZW50IEJBUjAgdXNh
Z2UuDQo=

