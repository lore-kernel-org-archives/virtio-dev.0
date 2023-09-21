Return-Path: <virtio-dev-return-13896-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDD8CD4949
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 04:01:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8D0AA66DC9
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 04:01:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 71969986687
	for <virtio-dev@archiver.kernel.org>; Thu, 21 Sep 2023 04:01:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5895E983D6F; Thu, 21 Sep 2023 04:01:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 489B598667C
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Sep 2023 04:01:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQOwyJWQNxPXDYDBC3SKx2dhaa5giApLixL9oCwGRrH6QJXO2NqULDcjp7wc1Bg1XhSo9GWi2S5BxewFiOIcGTLPvdTPGHR++c7ZKZRH96tMXzBmCSljzjsjwpX2y3zsbIWhZnZpmLaZZs9ktYbeKa+Fz8gIBpQnRnS0O1Rh66uQzTB494z6ticxhTvxLHyi7k6QIzMJKtdhIEjiAuiPiCIXAAzX+PrVg+E7Z18YtgPnc6UXZp8b5cYtaWvvoih7cEPlFmhxB+PUlZ4SP6PBVDTkWWPXWnLbKVG+29Ue8spTtGg3+Js6TnsPBee8xOhb7Jm26WQyqYpOE37VoXQ4gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUTCCmdP+7lX85riwo+RMyv3jC+DXilYS+4PYRezjTQ=;
 b=NA3vH8c3eZcQCVxmKm0nPljqwBBc9NcrBfJJNTmP3L8BWXuNrp4Z1ZnT+8cS3vlOWJkqzmEXFEuBm4GSw9YMtFl1w+fO32O6p4n3njvZFyRHKd4ZMD0pQg/7xRGxR2S8RS3d6anqWvY2Ho4yDwY5bTsGzbxI2cubknxZt5x94PYQrG3IPSscfT+bE4hiOSCwDTrBL3CVAOP6iHcF+5nq/RcFpyHkmCnT9F81Pp57378ycp7dC+FO1lrsbf7yWxw/0O7cIpDIi4PwZT+LxLd39sIOQ7NGJ456e4/YSapTIiNQ8CiKOqM5ym6cMS1KDnWqRMH0M73oq9jyMFxcSkL0xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state
Thread-Index:
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAC3dgIAAl98QgAADDoCAAk+KgIAAS2wAgAEX5ACAAAnDsA==
Date: Thu, 21 Sep 2023 04:01:47 +0000
Message-ID:
 <PH0PR12MB5481830365A80EF4583A3FFADCF8A@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <PH0PR12MB5481C41D4F32DA26D5831471DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <67680965-b115-32c7-dfdf-c56ab37bdd81@intel.com>
 <213a0f94-cee2-d8c5-3c5d-d2d7fc920e75@intel.com>
 <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com>
 <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org>
 <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org>
 <CACGkMEsn+9AqgmurN8-GXkcu8UxAr62_woJn3XZN+oUkTQNPUg@mail.gmail.com>
In-Reply-To:
 <CACGkMEsn+9AqgmurN8-GXkcu8UxAr62_woJn3XZN+oUkTQNPUg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL0PR12MB5507:EE_
x-ms-office365-filtering-correlation-id: d68dca70-b1eb-4d3d-0c79-08dbba5779e7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 vO6DZ5TsXRyAmkpaDx/sS6qj+P/uT40G1EWqgQFtYlBAUCr1ZmAotKWRsmwB/ADyZ3A3FvHE5lk4in99wKPmRUKWosdRCSkaUYkgt1OBgZWDnNB0mApQn4qsJgUr4xT0aOP9+Ua0eVpiXuefjRkocnFQcTWnxqEamhyigE9vurWu3mXbfG5fQ+WnK+Sko1w1Y/h6rTUv6IeYMupO0Xtth5k9TPeZqgLp8iupNteNoOgLhzn/GpjK2NlB21uSoevETfke9BIMMkfq/kSpuymAk9TYX8S6MUyHM/T4QIKRekwRprlnuEBCSMEo+HXbfyLnR6v/hPRat4XcIYl5GZQAnrkVajHIv8pFJQ1+djj6kwfXDy498+DozMG4qBJaVj6aw6fxFQkcCgwuYYE3l1f9yKJ/t/MVGsvNws/DmXjovI3L+izJT0anbCAi2r+8Ka+pZ6NnlyPkiZ6EB1IbJ6Knypq7T5NlInCjMeUFHgqJWK6nhGCE+YjEckc/KJ0mTUIRDQYpk+RfwcrxVS6ny0ns6CfjFQnN1ptnXZmnkSjfQAp2r0ErOM0UhxPn2nEPTDHyzC8Z26XK7+3VU1+vjbeHMfilN7oBEkVtZfzHcLfyT40podfUbhH0DEQ6NRwVcNVR+89FkhRytShUPGo/tJSoTJPdKbf6AS4J0B9RsiWI0m0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(39860400002)(376002)(346002)(451199024)(186009)(1800799009)(2906002)(15650500001)(5660300002)(52536014)(8676002)(4326008)(8936002)(41300700001)(110136005)(66446008)(54906003)(76116006)(66946007)(66556008)(66476007)(64756008)(26005)(316002)(966005)(478600001)(6506007)(9686003)(83380400001)(7696005)(71200400001)(55016003)(122000001)(86362001)(38100700002)(38070700005)(33656002)(55236004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VWcwa1B4dlVEVUZFTDNIdUhFdDJhS0tZYWNiVW5qSkE0WDJKaFJPSXpyY2FE?=
 =?utf-8?B?dkduQTZ1aWM4UVNNR1FySnhqTkhTNjU5b0Z2eEpSUkxJZmNid0x0WTdDemhV?=
 =?utf-8?B?c1hoTFEvZWNUL2E1K0haQW1leUVNMEN2NzJNZUplbjU3WjAvNjgrN2lxWGY4?=
 =?utf-8?B?QlJyK2I4cXNzLzFadmwza05aaG9jRDJ0N3NoQS9EUnNrMDNOY2R2SW9ySnVM?=
 =?utf-8?B?U0VKaXNndDgxTlpBbEhJbjlRcVZNazNVZzR4ZiszclhFV25SeHo5ZE91R01F?=
 =?utf-8?B?eE8vOVhaSk8xMHAreU9WWmJzNGc3aDR2NllUOFhNMWw4a1Nta29OSTVkekRi?=
 =?utf-8?B?elJnQmc2bnlmK2FIMlllVFNxa0lpNWZQZUdOVksyRGFneXRsUm51Z1BlaFQ5?=
 =?utf-8?B?ZFpDREJNRG42bldqWlNyd09BaU1CNU1PRVNEOVpZMnkwMVBxTUFsSnZKT0xl?=
 =?utf-8?B?NkJ6dy9MdjZjMHo0T3puM3ZaYjdubFdIOFBKVTkzRVFHTmlPRnVsWUtYRFov?=
 =?utf-8?B?WkpGS04wb3ZmZXFRbENveVJmUHljd1YwS1dhVTJVNU12enhyTHRSdVhaREhG?=
 =?utf-8?B?dWtUcE9PVWN1UDhGcXhmVkJQZ3VWeXJRSkNyeHRubnRRVUUxWTRqQktGWW5G?=
 =?utf-8?B?dkYrdjZaSHBIWFZCYzN1bFQ5Unl4eW5TdFdjT1JCaDlZQ3BoUjNxRGNGRnB2?=
 =?utf-8?B?ZmdyUTZ5aGMzeDRVWlRwaVhoeW5YbVNyZjFyQ0hsOG80RmlXSmpoRWJNRFlw?=
 =?utf-8?B?SHBLRHFyRmgybnJSS2ttWk80dU5LS2hTZnRXU244ckcrRGR6SHoxQStxWkU5?=
 =?utf-8?B?cldTK3Z4QVRuVGU4c1NmSkdSZ09KYjFvMU1OUmkwM0ZzSUZDZDVqcUxNZWJt?=
 =?utf-8?B?eFlXbGl1UzZYZFlVVXJUVHZsQ0hZbW1ZWkJSY2owa3o1eUlxdFhoNis2SmlZ?=
 =?utf-8?B?ZUdsYWRtdzJSc1ZVSU5GYkRwZWNvQVBFMFVIcDdYSUp6MFdWRkErU0psOUQx?=
 =?utf-8?B?Rk5LcXRSMmlHS2dOWWtDUWMxdlErSnY0TjVLN1dKc21Vd253L3pIeXpmZXlB?=
 =?utf-8?B?NnFCQzcraTNhOHQvZ0w3YjU2dS9ZMWdCVSswVnB6aVhmdU1GbUxwM1FxME1O?=
 =?utf-8?B?aWw0TmFMYjlzSG85WGUxQWVscnBReVZGTWJDRyswa1BaVUlLYnI4N0hQSjhN?=
 =?utf-8?B?WERYdDI5U0pjTFlOWDM5THNseGFRdkJnc05GR3ZxRU0xK01pUnIvTmFkR2Q1?=
 =?utf-8?B?eUF3cHFYeEJEbUZkYk43REFpVThBQlRxS0VuQ3loWjFQNGNuSmRKWkN0NG5Y?=
 =?utf-8?B?cnB3dzlSQW4zUGg2aTA0RE5MSGVmL1FJNmpqc2VjdW5zazhEVnRhUkNFSnZ3?=
 =?utf-8?B?MkpRMWtkUHB5Rk9UdC9vRFZ5SFlDVks2S3lnZTFUclpqUlVuRFhDT2paVzUw?=
 =?utf-8?B?RHlqTnVMbW50NVZ0Q0NsYXhkVGNucnlsQzNTQnI4Yy9XMDJNeDBWY0x2YXIy?=
 =?utf-8?B?NWxoSkZSREJxK2lJOWhiaTZEMkZOcHVpNWNZalMvVTFRY2g1Sk1UcHd6Zmhu?=
 =?utf-8?B?Z3EvTnJ2NkZVZ3MxaW5CWDFudExnWUFMS1h0azg4dzMxN3JLeEFCVHBGN3cr?=
 =?utf-8?B?bXMrSiszK1d4SUwrMU1ERHVqU2ZLOG9tdEJWNVoxZHJ6Znlld0FDR3dzOUpa?=
 =?utf-8?B?ZVdDL2lNTTdnMDhrMW1yemZqSmxmKzdmcDF5U2ZKYTBVRk02Uy8wbHM2M2xG?=
 =?utf-8?B?Q0ZNSW9kWEhTOFlTdjI2TVNJcm1aWEx0TUQzeFhNOFhQWFJCLythT2tEU2pi?=
 =?utf-8?B?NHlzWjYrSXVOWUpEcWhsY1hoQ0labkp0UHpONGF4L2ZWd0RzUzF3WjVoRVRn?=
 =?utf-8?B?YXJ6SGJQdEpvdnI4N0s5OU9oNlI5eTdLSXFtRWxmL1pqcjFFY3RSa3VQazJF?=
 =?utf-8?B?UTYydGx3WUs1SnArTi9yWTdzT1BtcHBZKzJ0TmZkYy8xdlpJSzJSMjR5eHlW?=
 =?utf-8?B?eEMvVmVmSUIzb0VObEZ3UmY3cXdFNDFvSVVBRCtpd0p4WkI2RzR0K3ZTallF?=
 =?utf-8?B?RzgyUFJjNkM5QnNGMXRaWFVCSlhMalhxMTAva0dYK2NRZmYwWEpNanFEcEsv?=
 =?utf-8?Q?4hfw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d68dca70-b1eb-4d3d-0c79-08dbba5779e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 04:01:47.2739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 54MPajLfejUOtQr9jiH+///TkUjpu8pUGBpLVo71Er4y5ju7axeCZr5zqp8TqdgncEA5rTy7FGUKn1bal5w9ug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5507
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state

DQoNCj4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4NCj4gU2VudDogVGh1
cnNkYXksIFNlcHRlbWJlciAyMSwgMjAyMyA4OjQ4IEFNDQoNCj4gQXMgcmVwbGllZCBpbiBhbm90
aGVyIHRocmVhZCwgdGhlIGlzc3VlcyBmb3IgQkFSIGFyZToNCj4gDQo+IDEpIE5vdCBzdXJlIGl0
IGNhbiBoYXZlIGFuIGVmZmljaWVudCBpbnRlcmZhY2UsIGl0IHdvdWxkIGJlIHNvbWV0aGluZyBs
aWtlDQo+IFZJUlRJT19QQ0lfQ0FQX1BDSV9DRkcgd2hpY2ggaXMgdmVyeSBzbG93IGNvbXBhcmVk
IHRvIHNpbmdsZSByZWdpc3Rlcg0KPiBhY2Nlc3NpbmcNCj4gMikgVGhlcmUncyBubyBvd25lci9n
cm91cC9tZW1iZXIgZm9yIE1NSU8sIG1vc3Qgb2YgdGhlIHRpbWUsIHdlIG9ubHkgbmVlZA0KPiBh
IHNpbmdsZSBNTUlPIGRldmljZS4gSWYgd2Ugd2FudCB0aGUgb3duZXIgdG8gbWFuYWdlIGl0c2Vs
ZiwgaXQgc2VlbXMNCj4gcmVkdW5kYW50IGFzIGlzIGltcGxpZWQgaW4gYWxsIHRoZSBleGlzdGlu
ZyB0cmFuc3BvcnRzICh3aXRob3V0IGFkbWluIGNvbW1hbmRzKS4NCj4gRXZlbiBpZiB3ZSBoYWQs
IGl0IG1pZ2h0IHN0aWxsIHN1ZmZlciBmcm9tIGJvb3RzdHJhcCBpc3N1ZXMuDQo+IDMpIEZvciBs
aXZlIG1pZ3JhdGlvbiwgaXQgbWVhbnMgdGhlIGFkbWluIGNvbW1hbmRzIG5lZWRzIHRvIHN0YXJ0
IGZyb20NCj4gZHVwbGljYXRpbmcgZXZlcnkgZXhpc3RpbmcgdHJhbnNwb3J0IHNwZWNpZmljIGlu
dGVyZmFjZSBpdCBjYW4gZ2l2ZSB1cy4gT25lDQo+IGV4YW1wbGUgaXMgdGhhdCB3ZSBtYXkgZW5k
IHVwIHdpdGggdHdvIGludGVyZmFjZXMgdG8gYWNjZXNzIHZpcnRxdWV1ZQ0KPiBhZGRyZXNzZXMg
ZXRjLiBUaGlzIHJlc3VsdHMgaW4gZXh0cmEgY29tcGxpY2l0eSBhbmQgaXQgaXMgYWN0dWFsbHkg
YSBmdWxsIHRyYW5zcG9ydA0KPiAoZHJpdmVyIGNhbiBqdXN0IHVzZSBhZG1pbiBjb21tYW5kcyB0
byBkcml2ZSB0aGUgZGV2aWNlKS4NCkluIFsxXSB0aGVyZSBpcyBubyBkdXBsaWNhdGlvbi4gVGhl
IGxpdmUgbWlncmF0aW9uIGRyaXZlciBuZXZlciBwYXJzZXMgdGhlIGRldmljZSBjb250ZXh0IGVp
dGhlciB3aGlsZSByZWFkaW5nIG9yIHdyaXRlLg0KSGVuY2Ugbm8gY29kZSBhbmQgbm8gY29tcGxl
eGl0eSBpbiBkcml2ZXIgYW5kIG5vIGR1cGxpY2F0ZSB3b3JrLg0KVGhlcmVmb3JlLCB0aG9zZSBh
ZG1pbiBjb21tYW5kcyBhcmUgbm90IHRvIGRyaXZlIHRoZSBndWVzdCBkZXZpY2UgZWl0aGVyLg0K
DQo+IDQpIEFkbWluIGNvbW1hbmRzIGl0c2VsZiBtYXkgbm90IGJlIGNhcGFibGUgb2YgZG9pbmcg
dGhpbmdzIGxpa2UgZGlydHkgcGFnZQ0KPiBsb2dnaW5nLCBpdCByZXF1aXJlcyB0aGUgYXNzaXN0
YW5jZSBmcm9tIHRoZSB0cmFuc3BvcnQNCj4NCkFkbWluIGNvbW1hbmQgaW4gWzFdIGlzIGNhcGFi
bGUgb2YgZGlydHkgcGFnZSBsb2dnaW5nLg0KIA0KPiAxKSBQYXJhdidzIHByb3Bvc2FsIGRvZXMg
c2V2ZXJhbCBjb3VwbGluZ3M6IGNvdXBsZSBiYXNpYyBidWlsZCBibG9ja3MgKHN1c3BlbmQsDQo+
IGRpcnR5IHBhZ2UgdHJhY2tpbmcpIHdpdGggbGl2ZSBtaWdyYXRpb24sIGNvdXBsZSBsaXZlIG1p
Z3JhdGlvbiB3aXRoIGFkbWluDQo+IGNvbW1hbmRzLiANCkluIHdoaWNoIHVzZSBjYXNlIHlvdSBm
aW5kIGRpcnR5IHBhZ2UgdHJhY2tpbmcgdXNlZnVsIHdpdGhvdXQgbWlncmF0aW9uIGZvciB3aGlj
aCB5b3UgbGlrZSB0byBzZWUgaXQgZGV0YWNoZWQgZnJvbSBkZXZpY2UgbWlncmF0aW9uIGZsb3c/
DQpPbmUgY2FuIGFsd2F5cyB1c2UgdGhlc2UgY29tbWFuZHMgaWYgdGhleSB3aXNoIHRvIGFzX2lz
Lg0KDQo+IDIpIEl0J3Mgc3RpbGwgbm90IGNsZWFyIHRoYXQgUGFyYXYncyBwcm9wb3NhbCBjYW4g
d29yaywgYSBsb3Qgb2YgY29ybmVyIGNhc2VzIG5lZWRzDQo+IHRvIGJlIGV4YW1pbmVkDQo+IA0K
UGxlYXNlIGxldCBtZSBrbm93IHdoaWNoIHBhcnQgY2FuIGJlIGltcHJvdmVkIGluIFsxXS4NCg0K
WzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3ZpcnRpby1jb21tZW50LzIwMjMwOTA5MTQyOTEx
LjUyNDQwNy03LXBhcmF2QG52aWRpYS5jb20vVC8jbWQ5ZmNmYTFiYTk5NzQ2M2RlOGM3ZmI4YzZk
MTc4NmIyMjRiMGJlYWQNCg0KDQo+ID4NCj4gPiA+IHRoZSBiYXIgaXMgb25seSBhIHByb3h5LCBk
b2Vzbid0IGZpeCBhbnl0aGluZy4gYW5kIGV2ZW4gbGFyZ2VyIHNpZGUNCj4gPiA+IGNoYW5uZWwg
YXR0YWNraW5nIHN1cmZhY2U6IHZmLS0+cGYtLT52Zg0KPiA+DQo+ID4gSW4gdGhpcyBtb2RlbCB0
aGVyZSdzIG5vIHBmLiBCQVIgYmVsb25ncyB0byB2ZiBpdHNlbGYgYW5kIHlvdSBzdWJtaXQNCj4g
PiBjb21tYW5kcyBmb3IgdGhlIFZGIHRocm91Z2ggaXRzIEJBUi4NCj4gPiBKdXN0IHNlcGFyYXRl
IGZyb20gdGhlIHBjaSBjb25maWcgc3BhY2UuDQo+ID4NCj4gPiBUaGUgd2hvbGUgYXR0YWNraW5n
IHN1cmZhY2UgZGlzY3Vzc2lvbiBpcyBhbHNvIHB1enpsaW5nLiAgV2UgZWl0aGVyDQo+ID4gYXJl
IG9yIGFyZSBub3QgZGlzY3Vzc2luZyBjb25maWRlbnRpYWwgY29tcHV0aW5nL1RESS4gIEkgY291
bGRuJ3QNCj4gPiBmaWd1cmUgaXQgb3V0LiBUaGlzIG5lZWRzIGEgc2VwYXJhdGUgdGhyZWFkIEkg
dGhpbmsuDQo+IA0KPiBBbnlob3csIGl0J3Mgbm90IGJhZCB0byB0YWtlIGl0IGludG8gY29uc2lk
ZXJhdGlvbi4gQnV0IHdlIGNhbiBkbyBpdCBlbHNld2hlcmUgZm9yDQo+IHN1cmUuDQpUaGFua3Mu
DQpQbGVhc2UgaGF2ZSBjb21tZW50cyBpbiBbMV0uDQoNClsxXSBodHRwczovL2xvcmUua2VybmVs
Lm9yZy92aXJ0aW8tY29tbWVudC8yMDIzMDkwOTE0MjkxMS41MjQ0MDctNy1wYXJhdkBudmlkaWEu
Y29tL1QvI21kOWZjZmExYmE5OTc0NjNkZThjN2ZiOGM2ZDE3ODZiMjI0YjBiZWFkDQoNCg==

