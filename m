Return-Path: <virtio-dev-return-13966-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD34FE7E627
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 11:37:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 383ADC610A
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 11:37:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2A2F1986675
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 11:37:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 1B857983DE3; Tue, 26 Sep 2023 11:37:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0300A98639D;
	Tue, 26 Sep 2023 11:37:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OiaDrGE3tWsE4TYzSKYrDD3GAeXsTIT/LObB7ekYK5g7koMcePqrzqSoJgl+RIrjuH7p7rlgIz4Y9tiNPXogkYcjh7sUwvT6tuaE2s+Yyyin2+YCPH4eqJ4DqBpvI1MADChSQvZMpe/A1+PslwpEyEFU0jdZXTJvXMmb4aLX/h2GubkeVbSgx5afPzJ9FmHkwvwPmGWnPwExS8OWd6z8d+LuVCNSQhwDkqBEekBb+qigJLNxsnmf454DAYLdrUsiHTIk9wBoEAU8ciLpsoer5k1DwpdK0I9amzqs5Vq4AtdMtRPGCRQSI3qTGEt3igAtpM/MWlBjrLZW/a5HmIA8MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvCPlnHd3KpBLIY7payeapDV2/KtTCq06hkBR2B6sGU=;
 b=PJvSh3jiFlrrYL8kZdlwf5/4AqG4F1GQ4DNqQi1NVIj9gDaWq/wn2Nj6Gwlos20YaOFBQDoXgolBHEeXElqJ01OxqT/dvArZpvudE3fd8P7cX5fmOtObGnUsnLs+S3LRRIEUCQLCaCX3G7dk5RvHQz2VwNoIt/GmlqoAIU9Sdw1aPQNDP9/w0xJPmMD5zjZI4ZsiLViB0bmSopTenNAdrl7pr+QXgQW+D8xvk2KCqQVnRw4Y8ZN2uPo+7OApjxv8W5FQaRqzThVJQnZGgMbMEjIGr1g5Eq7XyUBCLpH94DhHbD2Il5OuubnOWZVuy/IS+/jSoVJaa3Ou17RwaDs/NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>, Jason Wang <jasowang@redhat.com>
CC: Gerd Hoffmann <kraxel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, David Airlie <airlied@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
	=?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Robert
 Beckett <bob.beckett@collabora.com>, Mikhail Golubev-Ciuchea
	<Mikhail.Golubev-Ciuchea@opensynergy.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Stefano
 Stabellini <sstabellini@kernel.org>, =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?=
	<roger.pau@citrix.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
	"Koenig, Christian" <Christian.Koenig@amd.com>, "Hildebrand, Stewart"
	<Stewart.Hildebrand@amd.com>, Xenia Ragiadakou <burzalodowa@gmail.com>,
	"Huang, Honglei1" <Honglei1.Huang@amd.com>, "Zhang, Julia"
	<Julia.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Thread-Topic: [virtio-dev] Re: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add
 freeze_mode to virtio_pci_common_cfg
Thread-Index:
 AQHZ6u55wdLgYEJT5UeWhzYWiXOCmrAksLcAgAAjGACAAVz9gIAAUOOAgARfDgCAAYpigIAAB5eAgACIvgCAAAR0YA==
Date: Tue, 26 Sep 2023 11:37:37 +0000
Message-ID:
 <PH0PR12MB5481E765DA98E7AD3D1BED15DCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <CACGkMEuEXk2UzXU7sFUk-nHEeE7QoB3kbjnHgktY7KWuK71Xrg@mail.gmail.com>
 <BL1PR12MB58490A484087B2B2C37B6E43E7F8A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEtx-i_9dgdONFzEmmWYNRhaoJQZX7a5OmLfDvGoUaajPQ@mail.gmail.com>
 <BL1PR12MB5849E38DE89D80B8A4CB7128E7FFA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEv0d3frw9KJcC3qDs0p8ZeWg6dowNEHcAHsgaOTm4CAAQ@mail.gmail.com>
 <BL1PR12MB5849B427B23D1ED269808463E7C3A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <CACGkMEtuRwAig_AbMA1YFa9YVw2aBQJDhZ06ZiD_QugthPDROQ@mail.gmail.com>
 <BL1PR12MB584991A9503502EDCB6B9D0BE7C3A@BL1PR12MB5849.namprd12.prod.outlook.com>
In-Reply-To:
 <BL1PR12MB584991A9503502EDCB6B9D0BE7C3A@BL1PR12MB5849.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DM4PR12MB5070:EE_
x-ms-office365-filtering-correlation-id: 6b106c13-afbf-46bc-37f6-08dbbe84fbc7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WmcmgJiOtSAMuj/aas+vob5P8byE0pa7UYkkaghODn+q6BkjM2SfBIylThuvFG0Y/dQgfskz8LoKdD++Kaz2o/3jLp1e9jf4m9ND7G8jW/ydagJ+IJoKD8EcNY4Z42cWF6/PFGaMIxTtGyYQEys8GoDTUhgu8UIxtkBhw5XCTJwvl635ihY3M6/Ulv6IK76vFhnxZYRBFkDIm7KGL1bYXlCX4IoBiiKSu53A851zQW0y4M3o7Hr4pfN92YfWmFTbk0r5Qpz9QtQ7wF8dNQaqhtC3KH31cI65L7imSWm0D08E4UQI/t5P6kCw19NBB2BhjuCoen7T8KQDgjlLKHtGnvKjXK1mflgI3X6oWQcWiWClToo8Wyyj3sXrbFGHqpK57QydypSrmQRgw6xbPuldxF57782a7G35fDxp9y2wT5yGloHfd5GVTvV7/03/7v4YMxPGRPEz688q2YhvThs3S9zVl0r1M9QGUqvJigbD7xrUzooOEzp1IkcMWD5Q4F8PddXIGpXJav8KQQJLEIZSpi8fXnp4NHsmlcDUqdd3yi07P/SirnFDlPRKwU3dZ4DGGzaT0MfATQXhU/V/9OH7vWD9W8mfWeEMNtK1o85WZksoX40sjvrRIakuQheTuWV1kCzIKOxfDC+RupKqAJyhHVITQg3BAVIHfYZPHQ1X4lY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799009)(52536014)(7416002)(8676002)(8936002)(4326008)(316002)(41300700001)(66946007)(110136005)(76116006)(5660300002)(64756008)(66556008)(54906003)(66446008)(66476007)(2906002)(122000001)(55016003)(83380400001)(38100700002)(38070700005)(33656002)(9686003)(4744005)(66899024)(86362001)(6506007)(966005)(478600001)(71200400001)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z3NXbytRUVFmZmFFUnhpTm9IaUZ3TTlySTY3c29PWGdUUXRBWHRmL3JUempI?=
 =?utf-8?B?V3pKTlYzbHdGK3RMa3JoMlN5Vjl5Y082Y0pGaHY2cDdQd3FqT3hwb3JickUr?=
 =?utf-8?B?ZGV4WEpQYlZDRllxbW5kRXM2OE5rSnlOUC90OFNqNFp5UlUyOFR2M243cEw4?=
 =?utf-8?B?enRHUTgwbklFNE9oaC9RWXVNV1pZRFVrMzZITHF1WnllN1BDS1duYUprNCtq?=
 =?utf-8?B?M21paThoQXNFMmwrQXUwUGZhMDlQdi9Dd3Zqc1NrMCtRQnIvVWl0UHR2Ritv?=
 =?utf-8?B?QTJJZWN5RnpBVGNqU0o0SWNiYndTcjYvQkJpUXJQQS9OSWN6WHdOU0VKdVc2?=
 =?utf-8?B?aStBNktxT0loMENCL3NmeFh4QzFjL0ZiTWxiT1VxL29NdXA5eGtMeUhjT3Jz?=
 =?utf-8?B?a0ZhTjR2NnEvSlBYK2U3SmJOZFBKNDFrbmNwUnNmcHVzWU54clMzZEkxQ0hO?=
 =?utf-8?B?amN6Z0pCbmFGaXhWUEdrR2pFem5xUlNwRVAydEY2QmVDUkdaUFFuMVZxdWZ4?=
 =?utf-8?B?NUNWckRsd0FQblNBUlpLbnowNlJYR3R2R0JnTmRRZGtOYnpzTllXdXBHSHcx?=
 =?utf-8?B?enJnRjcyRlhiNkhoaE9jWkRkTjJXOGxzSVVickRIbjVRWHRuNkY4aTJUdGp0?=
 =?utf-8?B?VmV6WG43ZHV1WjhPcFJHMTVYMmRQOVdlL3JMTWVnWDVKZjB5VkFPUi8rNmIx?=
 =?utf-8?B?K0x5NG5uUVZZUDNUMFJjc2JEZVpHWkkvRHQ1MkNYT2hQaTQ5Vm9qUU5HdE01?=
 =?utf-8?B?WERyTk9lb1RTRjNhQkg3V2ZnZkRDZndJNTVQcVFkSmlWNUhJVzE5Y0tEUmNn?=
 =?utf-8?B?K00vdHN2YVhxZlVmM3VyN3dOeDlJTXlzM1BqTWQrQllMNk9lWFltZnR4QWpr?=
 =?utf-8?B?aFdoZVpKWERpbllvY0hqT2trenJQdzRibVlvU1VDcnRDWVB2N3hIK1FWYkFl?=
 =?utf-8?B?M3UwN2ZTSVJxN3ZJNGk5NVhGaGY0SU9ZYnpMTlhOT09mbXJJSndNaHVLcGlh?=
 =?utf-8?B?WnNiSVQya2dXOENlQi9JM1VPY21ZdkFycFFRWVpycFRnUDVhLzE5VjJlRzZ0?=
 =?utf-8?B?RGliZEpoWmNzNU1Ka0JJSm8xY0RWMU9GcU5tMnN4aDV4OS95aTFDMXdqTlNR?=
 =?utf-8?B?b2NxSmY5ZlVONC9FTTc4ck11dGdkdFlRRHlZbW4wNzRUM2ZOQ3ZPeFdsMiti?=
 =?utf-8?B?aXBlWVI5Y3l6YldvQ3N3dWc3d0kxSlhoQVRycWF3UjkzME9yeW9TVWYzNUk1?=
 =?utf-8?B?Wk5LT3ZqdFU3UEVIc2dEdEdPSytFclA5NmdtQi9QQkNhQmpEOCtRM09GcFEy?=
 =?utf-8?B?TDlQMVNZeUxxS2cwZFJtaGFGRWpzTzBZV3BLT3FBZjkvSFJPVHFCeWJpby9y?=
 =?utf-8?B?TithbDV0dU9iVWJHRk0rZngvQ3pMTVh2WXlsYThQcm5pVDB0NWsvRHBPL2pT?=
 =?utf-8?B?emw5M2RpZ2Z0bXNyajlEMlk5YlQzVHdBM2UyZWttRmpYUFhYMGlBOTZQQ0l6?=
 =?utf-8?B?T0RQa29rMnFWOWE5UHZlWU1EN2pONmFObGVUZjhzWklwaUthMjJNRVZXcU9x?=
 =?utf-8?B?Q3NHc1pxWEgwVjR4TkpDejV5R1J2cVZ4Q1c0VlNoT2hSRW9Ta25BcGlTYlhE?=
 =?utf-8?B?R1FQTmJTZUovQkVFR3BqQTU4bHl5Z2owcmRVdkw4Unp0bUNLZmJRRlZMZ29F?=
 =?utf-8?B?ZkUyYmdZMkZHeEJXL0pBSUwwSnB2MzZ1ampsOHRyUDlPY1Zqbm1wTitxNnE5?=
 =?utf-8?B?alNkK09vQ1NPS0QyWm5XVTdJdktwTXBIeEJDUnU4eld2d0dPN2ZaQmg4cURH?=
 =?utf-8?B?UlJtVmp4RXc3czFGWFNwTlUzUnd4dDFPaU1udWpXd3BFR3pEOFpOSEI1b3Zo?=
 =?utf-8?B?d2g5M012eE5PSDNoOW1XVTBQSTJ4RHRwTVFPMU9GQVpEcG1ITERrN2xKWmNq?=
 =?utf-8?B?ajVibVFaS0U2eEFzRWpNdDJoSXdGa2dqMS9TTGxaRDhmcmdWN2l4OU5DelBS?=
 =?utf-8?B?SUpwVUZ6eld4cWNSb3hyVS84MTBkeHNGUlM1anZMZkNsdDFVUzFjSjN2WkRl?=
 =?utf-8?B?WTU3aGJRTnl2SUtqTGhwR1pmS2hyNlZyeVJVUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b106c13-afbf-46bc-37f6-08dbbe84fbc7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 11:37:37.1934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0PATFlOcJB/ZniOhJPih8uIcbk3UPsTHjQufnPlnqQbe7dbOlrFy4V8T5sxa49QanLWJvU32i8QZpRGBGpBBrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5070
Subject: RE: [virtio-dev] Re: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add
 freeze_mode to virtio_pci_common_cfg

SGkgSmlxaWFuLA0KDQo+IEZyb206IENoZW4sIEppcWlhbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4N
Cj4gU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDI2LCAyMDIzIDQ6MzAgUE0NCg0KPiBJdCBpcyBu
b3QgdG8gdHJpZ2dlciByZXN1bWUgYmVoYXZpb3IgdG8gZGV2aWNlIGJ5IHNldHRpbmcgdW5mcmVl
emUgaW4gbXkgc2NlbmFyaW8uDQo+IFlvdSBtYXkgbWlzdW5kZXJzdGFuZCBteSBpbnRlbnRpb24u
DQo+IEluIGN1cnJlbnQga2VybmVsIGFuZCBxZW11IGNvZGUsIGl0IHdpbGwgdHJpZ2dlciByZXNl
dCBkZXZpY2UgYmVoYXZpb3IgYnkgc2V0dGluZw0KPiBkZXZpY2Vfc3RhdHVzIHRvIDAgZHVyaW5n
IHJlc3VtaW5nLCBhbmQgSSBmb3VuZCBzb21lIG9wZXJhdGlvbnMgb2YgcmVzZXQgaXMgbm90DQo+
IHJlYXNvbmFibGUgZHVyaW5nIHJlc3VtaW5nLCBsaWtlIHZpcnRpb19ncHVfcmVzZXQsIGl0IHdp
bGwgZGVzdHJveSByZW5kZXINCj4gcmVzb3VyY2VzIGFuZCB0aGVuIGNhdXNlZCB0aGUgZGlzcGxh
eSBnb25lIGFmdGVyIGd1ZXN0IGZpbmlzaGluZyByZXVzbWluZy4NCg0KV2hlbiBzdXNwZW5kIGlz
IGRvbmUsIHJlc3VtZSBtdXN0IG5vdCBiZSBkb25lLg0KSSBkb27igJl0IHNlZSBhIG5lZWQgdG8g
bWl4IHRoZXNlIG9wZXJhdGlvbnMgZnJvbSBndWVzdCBzcGVjaWFsbHkgd2hlbiBzdXNwZW5kIGlz
IGRvbmUuDQoNCkRpZCBJIG1pc3MgeW91ciByZXNwb25zZSBmb3IgbXkgc3VnZ2VzdGlvbiBmZXcg
ZGF5cyBhZ28gaW4gWzFdIGZvciBub3QgbWl4aW5nIHJlc2V0IHdpdGggc3VzcGVuZD8NCg0KV2hl
biBuZXcgZmVhdHVyZSBiaXQgb2Ygc3VzcGVuZCBpcyBvZmZlcmVkLCBndWVzdCB3aWxsIF9ub3Rf
IGRvIHJlc2V0LCBoZW5jZSBubyBuZWVkIHRvIG1peCByZXNldCB3aXRoIHN1c3BlbmQuDQoNClsx
XSBodHRwczovL2xpc3RzLm9hc2lzLW9wZW4ub3JnL2FyY2hpdmVzL3ZpcnRpby1jb21tZW50LzIw
MjMwOS9tc2cwMDI2MC5odG1sDQo=

