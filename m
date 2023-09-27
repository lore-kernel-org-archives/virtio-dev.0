Return-Path: <virtio-dev-return-13974-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F453E810C3
	for <virtio-dev@archiver.kernel.org>; Wed, 27 Sep 2023 10:39:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 578357A093
	for <virtio-dev@archiver.kernel.org>; Wed, 27 Sep 2023 10:39:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4640A9866C4
	for <virtio-dev@archiver.kernel.org>; Wed, 27 Sep 2023 10:39:51 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 34569986420; Wed, 27 Sep 2023 10:39:51 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 200D4986413;
	Wed, 27 Sep 2023 10:39:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UD4NrX6drF6V2R+FMbhUqIKyO/JvafLOcpw6nyhoT0Bk/diMMmNdtEYL6Vohq0MYDfsyKJbHAeqgXhSQBhkLnjQ+ptgBIa86OHUhC3ZnaPt/tdzjGVGnIiqZbrUOOeH1i89wE1HaiVkOW/QtbZsVpw1pzHGhQys16WiA8F3ueSoUck/L7QrWWDv6gtJIWpmkQP8jqq9x6EQ9eIpkMXz4reqLRsODEq1nGAoZpk4z+Ag3SpP3qsyKZsOQAdH1QSJOOpSYzpNjyl0DSU+c28FWsCnP6ux+vliMdtjcRbNX6Ob+QDgM9kg74bgiZQrXszM+dXg4UymNY9WxkR+ug3G7yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rryV/T7OpBis2YfjuJKEGY+QzKdyDEO2DFzcHPSHW4=;
 b=jtGpT6JfsSA5x6Ypjf2FuXlT7mbnENXWN1BCvu3TE84OC1rZpjRI9+TwPTAjY4mhKFu+/Sv8FmzpdXf6jkC6OuZn0mVrR1w7SvRZdJpcvuy75YLxp+XOjgqTb3VHSuDu9UYiErldZXXv/2zNPk7NbaKjkXoY5dWD7zp4BojGB/26ccMQPbv6IJLmhsghjKExcLrEIxUxxTEtWl6L4b/EFIr7QK6D/Z8Pva3NPiLBo/wJWgwhZdQoDXdMO1RVN1NpVVnxVv+dZFNrOwsZOQYtErLNxxD9CPeoMh1lklPzBeyknQy6/QOWZUuFDB8mVuV0Bs36cSxzo1IKvZnb8kMUEg==
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
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAC3dgIAAl98QgAADDoCAAk+KgIAAS2wAgAEX5ACAAAnDsIAABJcAgAAA3ECAAYB3gIAFKIMAgAEae4CAAAfOcIAAKAeAgAADn6CAADxKAIAAF0QAgAFot4CAACROoA==
Date: Wed, 27 Sep 2023 10:39:42 +0000
Message-ID:
 <PH0PR12MB54816B064AD08754C7D86AD8DCC2A@PH0PR12MB5481.namprd12.prod.outlook.com>
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
In-Reply-To: <305d9907-9668-d362-1ff2-49a5e9f90e42@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL3PR12MB6569:EE_
x-ms-office365-filtering-correlation-id: be064b23-40f3-4d11-28e6-08dbbf460f42
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 V8HfKirDxjmVClmCRDfhoxHJFDfQ4jj+XTjPtGGl1TGOlKxMvwiOPZrg2ztuZFiLUeHqFCZAzl+UdUlzEEVFDx8c4ltPeFVxl0EB7OaCDe70iYRF+WzSuZF5+j0GEuPAOlIFekm3edwhoNfwE85h7u9/ZBhTJrVudpVIIzezCm84oHndR2KY048QnCwa1OafKDqLywce8jX5HxbxdjToJLbF5qeVkTTzLRQBBaFb+AQWLiwPisJ6QzAseNdnseohG5R8Be3JyEC5gyqBKTLFW7EJDhhwCN2LGU5wneylKiRjWM8HE9AL/u9ErABAsMcEy62tkBFzjasoTdXlRSDUFURvP9Rle5Ol5nIlgwPoEUN5IZ7Ov18A77zu+NwlUCOdO8RCfQP3kbxZSvm4cqRMVxITMN1q5mcza0CbmHFjDQJs0XqSJM7RO7g9ISGC0Kn4zo1/SjiEwib8dfnAfGSMIanehR7fv6ul8SKDwtjFO6/3/fn2AU9FpFIdkuymgcKiFmm6BGi+PRVQuf4Z6w/hGAXAUUAGbTug3FoaQF3F3JOjZEhd4d3uYN1fnAbDWlN2kAYKmGs5Gj1mI2t/wxtpgXVP9z5Rv91EslEryC37P83B3PGxjnwyoTU9IYg3pLHL
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(376002)(366004)(136003)(230922051799003)(1800799009)(451199024)(186009)(110136005)(38070700005)(71200400001)(38100700002)(86362001)(66446008)(41300700001)(66946007)(9686003)(316002)(54906003)(6506007)(76116006)(478600001)(66476007)(64756008)(7696005)(122000001)(66556008)(33656002)(8936002)(8676002)(4326008)(26005)(52536014)(5660300002)(15650500001)(55016003)(2906002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T214bEcwUlhMSGVjaCtlSldUNDlJU2w5MllvN3ZhcnNtUlJaS3JZcmNQY2tj?=
 =?utf-8?B?V1QwbUYrRGF6d3piaG1OVGY4NXVpaWpnc0VPS1NCWGcyN3hNa0MvU01hT1hl?=
 =?utf-8?B?dGpLOGk2cys2VW93Qy9iTUZtblpiVWJkZ1FlQXB2QUJERGZhWDhXWUVkNVNq?=
 =?utf-8?B?QnhvNHl6elRoR1VBK1hZTGtJc2QrUTVpUG9TeTM1WlkzakZqQ3dkNlVyOWNL?=
 =?utf-8?B?Vlk2Z1d5a2ZhcUgyWStWdVFJMUlRZTlWcEEzcHZuZHIzcTVUUTBVNjJJbFNN?=
 =?utf-8?B?OEQwUnNPR0Y5WWdGYkF2ZDhsV3l4QWZDWmh5YlgvNXpHd3dTdXk4K1ZIc1VR?=
 =?utf-8?B?QW9MSEQxOFRZOXBoV05TdlNEenNZU3VETWkwYzkvMFl4dEhFNG1LeDN4U3dk?=
 =?utf-8?B?LytabmxiR2I0aytsakNGV0pBN1RIYytjS1JqNUJ4NFZlTjI3TU5HWEpaaXpC?=
 =?utf-8?B?MHNKWnE3RTN5T29BRGdxVS90Zmh1dEYvUHZqVzF2ZzNlNGFnY3ZnZ05nVGpN?=
 =?utf-8?B?c0pTUG1NQTN5MzJoR3pGL25KQUhJTGJRK1NLbXZRL3dUR2cvaXFMUjd5dnJJ?=
 =?utf-8?B?MWJ1ZlhkM1QwUnNxNnpOWXdLVlRxRWFEN1BLZnlPUUo1SXlNWU1SUmZ1eTFm?=
 =?utf-8?B?emgwK0JDOXp4SDhhN0Q1UDFjRFgvN1ZLVlFteFpsQnljWTF5ZWhDZ3RYVndU?=
 =?utf-8?B?MHMxblVsV1lQTS8wbXIzNVo1aVAraFg5K2NJamllN3hlcFNDV013d3J2dnh6?=
 =?utf-8?B?bklYZk54WHBRL3crYjZjWTVyRER0aVQvSWtud3V5dzQ3alR3QUluNnlPYzZv?=
 =?utf-8?B?alpkdFU0TWFIYjRVWm5McEJ3Y0dpS1RnQ0lnT1F1L3FBc2NOS2hSbTlKVzZG?=
 =?utf-8?B?bkFINjVZVzRqa2RMalVEdDdWaWVjOEZYQlhnTzBiZVJ5MWxOazNaL2Fia3ZE?=
 =?utf-8?B?cUI1LzMxd1NNRkF3QmFlN3F5Tk9FaENEM3Fxam4xeVJNa3hGQ2JjVEtCMUps?=
 =?utf-8?B?YS9BWEpETmJ2Zi9xYkY5WGE0OWIrRkNkRkQ4SklkNXNCRDNXYk9TeHNYWHBz?=
 =?utf-8?B?SzE5VFBBNXN1bEhjM0tmTVoya2VMVkVZRG5HbHF2YU45dXpOUVlUM3o3WUQx?=
 =?utf-8?B?OG14dnY4NmRMNkdBV09pMk0wZkpyOFZ1T0UvTllhWit1SFMxeEFqQ0lIMktR?=
 =?utf-8?B?TDFrWGx3TGxETVFEVzRYR0hHdHJ1dHREaGsvU1Nab0VHek9vMGpEWUhlWG9o?=
 =?utf-8?B?YW0wZ3krczVISVJkSFQ0UXF3K2JrNVpFdlZyVzdIZmNlb1RjUkJ1ZE10aTBi?=
 =?utf-8?B?ZHMyMzR2UFJqM0lBVWhkY2JtT0U1Z3lsaWtIS2d0U2VuLys1eHIrdWxySG8w?=
 =?utf-8?B?WVVXVlhXOThpNm02K2UrMGdKVzVsTHJ4b2lZRHdTNzliVFpXZTl0QkRudWhY?=
 =?utf-8?B?TnRBamU1TXQ3eklIell2REt3R0U5cGpMV1hrc2hFWTVpTmNNK3RuM01JUU1M?=
 =?utf-8?B?eEtaTmJodUtRVG5jUFpUTTZucG0zbVYvcld6YlIwekYzcHJOZDFhQi9BdlpR?=
 =?utf-8?B?a01Fd1NEQjVNckI4c3A0bkZqdzFKa0pLTC9hN2d3Nkx0Z3pRQ2tZMW81TTJs?=
 =?utf-8?B?V3pTMy8yM1Mxam05UGJYV1RkcjFGa1BkYm1WQUVLVXFwOUVrMTQzMkdhSzlx?=
 =?utf-8?B?SmNxaUs0YktqMlpyaVA1dXhselFOVTBPWkF6YklmWWhIdi83bmZrSlhHSVNY?=
 =?utf-8?B?UlNOeUNWeUxXdk5Sd3ZJTVgzNWJWYlljTzcrQk85SmVoRjRqVnVoRHYwL3ha?=
 =?utf-8?B?dmdNWlJUR1ZKWEYySXcya3hSZmU5VHdGand4V2dMK2VQYlk4OGlqKzZtUzFF?=
 =?utf-8?B?Rjd5dWIwa2dmeWpBbnVJemVnQzRjUEdoeWgwMkw2ZTlldTZvNmRoeW9uWlI5?=
 =?utf-8?B?VVBUQ29vRmFUM1pHblhkZ0UyVGpNNVFCNkFudjJ3cjJVbjJkMWNPMmQ5ODdW?=
 =?utf-8?B?eEIrK3ZwQmt0ZmFmSTlkZm9ITDlNbmVCT2Y1QTlpR0pNeStoVlQ2SUxZZnBM?=
 =?utf-8?B?aHFvRUZrRURnTS9mT2s5bFBnSzROcncwcnJwcFNQTjV4L0JURy8vUVhHLzMr?=
 =?utf-8?Q?/WLY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be064b23-40f3-4d11-28e6-08dbbf460f42
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 10:39:42.7389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8SqmPhX6qXullPoXUs3paq97v3MqKZ/5xM+R8X35UAXV2HjZBApdUldRkzphzOeqitTaDE7Xo4WhHg9HydXanQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6569
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state

DQoNCj4gRnJvbTogWmh1LCBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4NCj4gU2Vu
dDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMjcsIDIwMjMgMTo1MCBQTQ0KDQo+IEkgc2VlIGhpcyBw
cm9wb3NhbCBjYW46DQo+IDEpIG1lZXQgc29tZSBjdXN0b21lcnMgcmVxdWlyZW1lbnRzIHdpdGhv
dXQgbmVzdGVkIGFuZCBiYXJlLW1ldGFsDQo+IDIpIGFsaWduIHdpdGggTnZpZGlhIHByb2R1Y3Rp
b24NClNsaWdodGx5IGluYWNjdXJhdGUuDQpUaGUgd29yayBwcm9kdWNlZCBpcyBmb3IgdGhlIHZp
cnRpbyBzcGVjIHVwZGF0ZSBmb3IgdGhlIHVzZXJzLg0KDQpJIGhhdmUgbWlzc2VkIGFkZGluZyBv
dGhlciBjb250cmlidXRvcnMgU2lnbi1vZmYgd2hvIGFsc28gc2hhcmUgc2ltaWxhciB1c2UgY2Fz
ZXMsIHdoaWNoIEkgd2lsbCBhZGQgaW4gdjEuDQoNCj4gMykgZWFzaWVyIHRvIGVtdWxhdGUgYnkg
b25ib2FyZCBTT0MNCj4gDQo+IFRoZSBnZW5lcmFsIHB1cnBvc2Ugb2YgaGlzIHByb3Bvc2FsIGFu
ZCBtaW5lIGFyZSBhbGlnbmVkOiBtaWdyYXRlIHZpcnRpbwkNCj4gZGV2aWNlcy4NCj4gDQpHcmVh
dC4NCg0KPiBKYXNvbiBoYXMgZXZlciBwcm9wb3NlZCB0byBjb2xsYWJvcmF0ZSwgcGxlYXNlIGFs
bG93IG1lIHF1b3RlIGhpcyBwcm9wb3NhbDoNCj4gDQo+ICINCj4gTGV0IG1lIHJlcGVhdCBvbmNl
IGFnYWluIGhlcmUgZm9yIHRoZSBwb3NzaWJsZSBzdGVwcyB0byBjb2xsYWJvcmF0aW9uOg0KPiAN
Cj4gMSkgZGVmaW5lIHZpcnRxdWV1ZSBzdGF0ZSwgaW5mbGlnaHQgZGVzY3JpcHRvcnMgaW4gdGhl
IHNlY3Rpb24gb2YNCj4gYmFzaWMgZmFjaWxpdHkgYnV0IG5vdCB1bmRlciB0aGUgYWRtaW4gY29t
bWFuZHMNCj4gMikgZGVmaW5lIHRoZSBkaXJ0eSBwYWdlIHRyYWNraW5nLCBkZXZpY2UgY29udGV4
dC9zdGF0ZXMgaW4gdGhlDQo+IHNlY3Rpb24gb2YgYmFzaWMgZmFjaWxpdHkgYnV0IG5vdCB1bmRl
ciB0aGUgYWRtaW4gY29tbWFuZHMNCj4gMykgZGVmaW5lIHRyYW5zcG9ydCBzcGVjaWZpYyBpbnRl
cmZhY2VzIG9yIGFkbWluIGNvbW1hbmRzIHRvIGFjY2VzcyB0aGVtDQo+ICINCj4gDQo+IEkgdG90
YWxseSBhZ3JlZSB3aXRoIGhpcyBwcm9wb3NhbC4NCg0KV2Ugc3RhcnRlZCBkaXNjdXNzaW5nIHNv
bWUgb2YgdGhlIGl0Lg0KSWYgSSBkcmF3IHBhcmFsbGVscywgb25lIHNob3VsZCBub3Qgc2F5ICJk
ZXRhY2ggZGVzY3JpcHRvcnMgZnJvbSB2aXJ0cXVldWUiIGZvciB0aGUgaW5mcmFzdHJ1Y3R1cmUg
dGhhdCBleGlzdHMgaW4gdGhlIGJhc2ljIGZhY2lsaXRpZXMuDQpJZiBzbywgb25lIHNob3VsZCBl
eHBsYWluIHRoZSB0ZWNobmljYWwgZGVzaWduIHJlYXNvbiBhbmQgaXQgd291bGQgbWFrZSBzZW5z
ZS4NCg0KU28gbGV0J3MgZGlzY3VzcyBpdC4NCkkgbGlrZSB0byBiZXR0ZXIgdW5kZXJzdGFuZCB0
aGUgX3JlYWxfIHRlY2huaWNhbCByZWFzb24gZm9yIGRldGFjaGluZyBpdC4NCg==

