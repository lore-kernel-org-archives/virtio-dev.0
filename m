Return-Path: <virtio-dev-return-13746-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B791EEB596
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 06:06:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B98C92A82A
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 06:06:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B26D898663D
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 06:06:03 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A5874986634; Wed, 13 Sep 2023 06:06:03 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8B7C0986630;
	Wed, 13 Sep 2023 06:05:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kO9Zx1p6aLdgKyF47O6xx+6N/9MRSGAPaKB18CZPMCIhmfslM0PV2DG0vSNhyVhJhwy8GNme+v00XWk6mHi/L4zDxlMDG7TYLLvOcH5HeSrgut5FuscpB2L9kXFVXO2GWX/13abzKoxm9Cud0DXCKHFJlYWtd98TY7SBMAf1cinxyRvXEXBN8JN56KZ2KbtoMaZJnaKrI4HWyRMJ7ahjzCoT0WV+hDE8ZMWSmBbLekQvvLxLzbvVCZz2/8JNzW7sOLTS7VSw/iaGXMMYmOWUmJrhBdWAtOypUHR76ESAjTpyKu//EtVaATyhnpzoxUDQtgXb1lGzvlJyyJd1lfJYZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5w8Oq2g2sDjWePxTsXLi0g7H+EzXrBDb4CcbrF/b5LA=;
 b=jYHhH65ZOXUP9POCxYiAWutNzYW7HCGRRznK7oYzjLT1AhquCs8/XaKroyMopLqSBOy9c6RZpyclgw0u/NLezl6CV2uHnAXfVHZCD4YLsxvw7QyzVGAiVxIyQKLLB8hJgedymDhUPrK1H6UTLJeYQv9P+WJWK9hL62qzdVoKtAMZSF8gYsOBorLTYatTH6Trn2ZfrzXTes0tXYqu3igBoYZL9H9JIhO8WGrD4Chaw/3SluNpJKAXB2ZpcnhSrdPmHyefLCTexfs6I2pE2qvU3B2mzsnRs2KL8cNrkaS7tDoRFzCdL/+D9Bm9eIIoXw1YnNpNk9NMJ8pqa2d7iZ/wfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Zhu, Lingshan" <lingshan.zhu@intel.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE
Thread-Index:
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAAFdACAAACHUIAABQ0AgAAAWWCAAArYgIAAAHNwgAANI4CAAABkAIAADHeAgAAlTICAAQuGgIAAIkIQgAGA5YCAABK3oA==
Date: Wed, 13 Sep 2023 06:05:51 +0000
Message-ID:
 <PH0PR12MB5481169EDDE5B82D71BCCE95DCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-6-lingshan.zhu@intel.com>
 <20230906043016-mutt-send-email-mst@kernel.org>
 <CACGkMEu4R_nUFmpoNesmjJ-PtoE5brpWh8NLruWhEWycm2K4yg@mail.gmail.com>
 <PH0PR12MB5481A50B1B13CE1756B98D0DDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMmwWGJDYe5BLvLCcetThv-yfPR2QbphNuuh+bp-+ikg@mail.gmail.com>
 <PH0PR12MB5481ED8DC23DC6D42665FB8EDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <eb6c350e-1198-7d83-a553-99c9c8c21edc@intel.com>
 <PH0PR12MB5481760E00AD18DB8BF91636DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <ad1dd3a6-7c11-5c6b-b50f-d608ec027dcd@intel.com>
 <PH0PR12MB54819C4A4220712DCD57AD56DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <fff7720f-6019-bd87-b14b-c0bf996f3959@intel.com>
 <PH0PR12MB5481D11A7DF45292103D9290DCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <88b8b14c-88d8-1f76-0e6e-7b5f334171f1@intel.com>
 <PH0PR12MB5481CBE0CDFF4ACD712F371CDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2b3e8da1-5cbb-f990-0c1d-c0e894a73486@intel.com>
 <PH0PR12MB5481E8114A659954251F17DCDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtAe3j+A=gNEOJiZF8rcJnT-zw7Xg67LLM92FZCm0XqyQ@mail.gmail.com>
 <PH0PR12MB5481B44B636DA997885AABBEDCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtFWZAQ0fKFBJYpRGR_RCNyDZSxXY+22y==PbuZqHzrVA@mail.gmail.com>
In-Reply-To:
 <CACGkMEtFWZAQ0fKFBJYpRGR_RCNyDZSxXY+22y==PbuZqHzrVA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SJ2PR12MB9140:EE_
x-ms-office365-filtering-correlation-id: d7562cba-0ad4-4178-820d-08dbb41f7bf8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 b/qoeAgcrMXpToBMbIZk/h69DhuvXEjkzTJi02wSlda2qDoPd1jT/fLKTZ7GsVtIlu+qAq/BrW27thPyoG62hJc/O5cazpptzarUnScRebxO8a/jbJatiuOO8Gm15bFXODp91RhWh+LwmgrDzN1mNa4NABryGCRcr3R896DG2l8BcQzilbR/g4OKz/73pgOf5+ymKRaY2DBtbK0g98Qj676GKWBT7QsLrK2cSgl8/jNmI4Fnukay05Hb1uLAyzN3yHgq/Iov7Km0Ne2+8YZPptkqT0pc09+azd8TPTBh9ZS6s1T+mcEJYb6xL3SBl52KxCj0nxJMXiGea5WGD/QN1zIizqTvtuTM2BitEtD7kA6Kn2LcYkG30o9OdqR2Ge6m1c8XYW8csIA+cwSy/Yh/xCgKPcoFkXzjMxzXpNRdC2xtzisIb3DRQUgACf0BZ1ITIXkJVw4fJVpfygWfhSAc5B8qQ1VyvHmbMCFYRaZ71Vsg0tSc6gtcf2VQBrUbkjlPQM4Uzh1D4JRX1w4WxzVM22Ymmde3fZ+jBIoPSHw5BRQBqm9CwpAgW/zyCzZrlatsQj5sJhnL20btieK5LWAAEMp6G/bKNfeByocqwQf1wHha62BWNlOfC3E5xdOgiRhY
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(396003)(366004)(376002)(1800799009)(451199024)(186009)(9686003)(478600001)(6506007)(7696005)(53546011)(71200400001)(83380400001)(26005)(2906002)(41300700001)(66946007)(66476007)(66446008)(6916009)(76116006)(316002)(64756008)(66556008)(54906003)(5660300002)(4326008)(8676002)(8936002)(52536014)(86362001)(33656002)(122000001)(38070700005)(38100700002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cFM3eW5pbk83MmdUUnBYdGlhdCt5WjlpbGFLNTBFZ3RVejdjUmFVZXJIaEhC?=
 =?utf-8?B?SGY3cHBRWU90a21FeWUyQzN0RlpJMWh2RkdoT0hzU1hOSTFrZ0ZreC9qOHpQ?=
 =?utf-8?B?OExkb3JyN3BDVlNyYWo5Qk1MNWVMMU42VkhvcVdERXUrN2psbGw2cXI0ZEx6?=
 =?utf-8?B?ZU9WTy9IS3dRRzNEdmVMRytBSDh4TnBMSWtOQkpmcmJzTllEZUpjVnFEUHBs?=
 =?utf-8?B?cEJCR3h5MThYdG5zajlFbmJ5THU0MGNUQzUzK2pPQ3QyMW43MEhzOFdWV1FW?=
 =?utf-8?B?OW9Jb0ZZWVlISEt6c2xMaXVSajRSYkRWVmRSbDhFZThqWjhUWlcyOEE4WDJZ?=
 =?utf-8?B?ejNlaHEzemFsRlRUTmFnajhySDF4djNsTUVwaUdzeklzRWFtdG9Ha1BWTFE2?=
 =?utf-8?B?d2dCWEQyTHk3VlJ6SlNvU0xNUW1TODYvRWpCSFN4b21GVEJkVUZGUUticmU0?=
 =?utf-8?B?YmNZWlhySE5aR1hnd05MNnhYN29ORFRkNHBvNnVyZ2pRaWlEU0tiMUU4eE5F?=
 =?utf-8?B?WkxaaXNkZXdSZlBpOHdvQVFyclR2dER2ZzIwZUdSRWNnenN2OW1nbW0yMGNv?=
 =?utf-8?B?Z2drWGVGV1RWb3RZcjlBbWRoM3lKY2p0YysyczhQV0hPaEIwdFQ0MWFKdXZu?=
 =?utf-8?B?MGV6Y2dPTHk2ZnN0QnFvdHZlUmY5TGNmVllmT205dU1mS0xvcVUzVGtUdUtP?=
 =?utf-8?B?aHpqeTdXNzNnYURJYm5WNGUvYllPc2RidTJVTU1oRW8wb2VpRWsyUllVN0J0?=
 =?utf-8?B?V0FaOFFNVG1qdHFuV1VKVi9mbUNnbXhvOCtjL0VEeDVoQ2czNm1UaTIwMTZJ?=
 =?utf-8?B?aU4xcUV0Mkg4TVMraVVzVnV0VmM2S0dpZVQzd0xBWkwzUW9oM2RsdlBxUUsy?=
 =?utf-8?B?RXkzTFlVWXRRUFpMQ3NvOUJxdTg1Y29GZkZHVGlLVENlVlUxR3E1M3dIbGFY?=
 =?utf-8?B?Qm55T3lqK1FER3l4bm1aRmtWemp0VExMRWpXZ25ZenlibEFaWFgwTDk2ZHF0?=
 =?utf-8?B?eHJTRXhhRFpMV2NxbFM5bHJkbWJXZlBoZUtaQ3ZNa0lNV1Z4QXlmNWlFV1NY?=
 =?utf-8?B?U0pLcE1kMGxpamNjNWhPYklFQklvcmd1YlNINk53WnlnT3M4d2JmUTcyd2Fw?=
 =?utf-8?B?Vm9ZekdTK0h5T0NjQTdOTDl6K21IKzdoRE9WcWxJK2RGaVA1Tk1kQXpBTk9r?=
 =?utf-8?B?NG5paDVtd2d6QlY1WWF2NldMWkxFSS94N0tWN1pGVWQzcDhwejhDUGtiYkpS?=
 =?utf-8?B?ejRQWkZoTFNCWHlJdTc3NTNjUkluS3B3SUVjSVA5RElTdHBnNEVDWU1aYVFI?=
 =?utf-8?B?c3FYc2lWS2YrbXYvd0t6MlU0eS9HZ3VHUy8vQ0poUk4xMzhWdjhVb0tERjJC?=
 =?utf-8?B?K2VJTHRSY1M4Y216dzYwTis5QjRFdHpWVmVweE5ZcVZPMjM1OGI0STBSMGN0?=
 =?utf-8?B?OTd3THB2elVqUlcwSG4wY1pzYkJ0YzMyUXQ3c1pCUHpiLzdNVzJGTjkwcVQr?=
 =?utf-8?B?K1pqa2Y1THFHY293VUJiRERWMm42Tk5KZGR5YmhsNzV4ck1UODZGMVNDemgw?=
 =?utf-8?B?U0xxQW1kV0N1dkhhTFFtN21vN0xTTjhyYjd3VElCTjdGcFhSY2RnTi9LVnhx?=
 =?utf-8?B?anpIaXB4dkZDYWRFdklqTGxyTUJhWWRPaWtKRzFpaS9tdThvZk1UOHNCazBQ?=
 =?utf-8?B?bkczblZZaEtnRlhPWHNXb2NIVVh5V3hPNnRyWmFxNWZRZzJ3RU5MME9BY2N6?=
 =?utf-8?B?VXRZbVpveitKUGRkTUhHdXFkcmw0Vzk5WTlzQ2JZbGtqMFErRVVhSDl5Tm9q?=
 =?utf-8?B?SzM1bWk5UVZvRmc2ckpSblZQL3c1VktHenhweXNqSVZJRmlNb1k5WEpVNitO?=
 =?utf-8?B?YkdqcDRheHc3eE85QnRuQTFVU29neVdndUY3bUxOUEhzMGJZY1lWQzEzUy9B?=
 =?utf-8?B?R3NLejlEY2k1N3NkN0ZVYTJQbkwzNnFPWFlOOVV5Skl0QmRjdCtyZERwbHdj?=
 =?utf-8?B?S0xPeWYxNjZZUkNqclZ5WENZcmZ5NlNjRTVZTllBdjIwdStsbjRhTjRPT3hr?=
 =?utf-8?B?bjQrd3NrOWcwanExYUFCR0xucHZNN0lBU0FqdnRrYU1XUlJDbHdUMzFBZEhv?=
 =?utf-8?Q?gsDE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7562cba-0ad4-4178-820d-08dbb41f7bf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 06:05:51.9612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AM1f/hzAt84zYCXMtvRSWYtXGWehDUdVlLL8X7mCGb5dzPjxzUTNceE1F4+jOfHs5CYud4Qrb0hma6d97SAwIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9140
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQo+IEZyb206IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+DQo+IFNlbnQ6IFdlZG5l
c2RheSwgU2VwdGVtYmVyIDEzLCAyMDIzIDEwOjE0IEFNDQo+IFRvOiBQYXJhdiBQYW5kaXQgPHBh
cmF2QG52aWRpYS5jb20+DQoNCj4gPiBPbmUgY2FuIGJ1aWxkIGluZmluaXRlIGxldmVsIG9mIG5l
c3RpbmcgdG8gbm90IGRvIHBhc3N0aHJvdWdoLCBhdCB0aGUgZW5kIHVzZXINCj4gYXBwbGljYXRp
b25zIHJlbWFpbnMgc2xvdy4NCj4gDQo+IFdlIGFyZSB0YWxraW5nIGFib3V0IG5lc3RlZCB2aXJ0
dWFsaXphdGlvbiBidXQgbmVzdGVkIGVtdWxhdGlvbi4gSSB3b24ndCByZXBlYXQNCj4gdGhlIGRl
ZmluaXRpb24gb2YgdmlydHVhbGl6YXRpb24gYnV0IG5vIG1hdHRlciBob3cgbXVjaCBsZXZlbCBv
ZiBuZXN0aW5nLCB0aGUNCj4gaHlwZXJ2aXNvciB3aWxsIHRyeSBoYXJkIHRvIGxldCB0aGUgYXBw
bGljYXRpb24gcnVuIG5hdGl2ZWx5IGZvciBtb3N0IG9mIHRoZSB0aW1lLA0KPiBvdGhlcndpc2Ug
aXQncyBub3QgdGhlIG5lc3RlZCB2aXJ0dWFsaXphdGlvbiBhdCBhbGwuDQo+IA0KPiBOZXN0ZWQg
dmlydHVhbGl6YXRpb24gaGFzIGJlZW4gc3VwcG9ydGVkIGJ5IGFsbCBtYWpvciBjbG91ZCB2ZW5k
b3JzLCBwbGVhc2UNCj4gcmVhZCB0aGUgcmVsZXZhbnQgZG9jdW1lbnRhdGlvbiBmb3IgdGhlIHBl
cmZvcm1hbmNlIGltcGxpY2F0aW9ucy4gVmlydGlvDQo+IGNvbW11bml0eSBpcyBub3QgdGhlIGNv
cnJlY3QgcGxhY2UgdG8gZGViYXRlIHdoZXRoZXIgYSBuZXN0IGlzIHVzZWZ1bC4gV2UgbmVlZA0K
PiB0byBtYWtlIHN1cmUgdGhlIGRhdGFwYXRoIGNvdWxkIGJlIGFzc2lnbmVkIHRvIGFueSBuZXN0
IGxheWVycyB3aXRob3V0IGxvc2luZw0KPiBhbnkgZnVuZGFtZW50YWwgZmFjaWxpdGllcyBsaWtl
IG1pZ3JhdGlvbi4NCj4gDQpJIGFtIG5vdCBkZWJhdGluZy4gWW91IG9yIExpbmdzaGFuIGNsYWlt
IG9yIGltcGx5IHRoYXQgbWVkaWF0aW9uIGlzIHRoZSBvbmx5IHdheSB0byBwcm9ncmVzcy4NCkFu
ZCBmb3Igc3VyZSB2aXJ0aW8gZG8gbm90IG5lZWQgdG8gbGl2ZSBpbiB0aGUgZGFyayBzaGFkb3cg
b2YgbWVkaWF0aW9uIGFsd2F5cy4NCkZvciBuZXN0aW5nIHVzZSBjYXNlIHN1cmUgb25lIGNhbiBk
byBtZWRpYXRpb24gcmVsYXRlZCBtb2RlLg0KDQpTbyBvbmx5IG1lZGlhdGlvbiBpcyBub3QgdGhl
IGRpcmVjdGlvbi4NCg0KPiA+IFNvIGZvciBzdWNoIE4gYW5kIE0gYmVpbmcgPiAxLCBvbmUgY2Fu
IHVzZSBzb2Z0d2FyZSBiYXNlIGVtdWxhdGlvbiBhbnl3YXkuDQo+IA0KPiBObywgb25seSB0aGUg
Y29udHJvbCBwYXRoIGlzIHRyYXBwZWQsIHRoZSBkYXRhcGF0aCBpcyBzdGlsbCBwYXNzdGhyb3Vn
aC4NCj4gDQpBZ2FpbiwgaXQgZGVwZW5kcyBvbiB0aGUgdXNlIGNhc2UuDQoNCj4gPg0KPiA+ID4N
Cj4gPiA+IEFuZCBleHBvc2luZyB0aGUgd2hvbGUgZGV2aWNlIHRvIHRoZSBndWVzdCBkcml2ZXJz
IHdpbGwgaGF2ZQ0KPiA+ID4gc2VjdXJpdHkgaW1wbGljYXRpb25zLCB5b3VyIHByb3Bvc2FsIGhh
cyBkZW1vbnN0cmF0ZWQgdGhhdCB5b3UgbmVlZA0KPiA+ID4gYSB3b3JrYXJvdW5kIGZvcg0KPiA+
IFRoZXJlIGlzIG5vIHNlY3VyaXR5IGltcGxpY2F0aW9ucyBpbiBwYXNzdGhyb3VnaC4NCj4gDQo+
IEhvdyBjYW4geW91IHByb3ZlIHRoaXMgb3IgaXMgaXQgZXZlbiBwb3NzaWJsZSBmb3IgeW91IHRv
IHByb3ZlIHRoaXM/DQpIdWgsIHdoZW4geW91IGNsYWltIHRoYXQgaXQgaXMgbm90IHNlY3VyZSwg
cGxlYXNlIHBvaW50IG91dCBleGFjdGx5IHdoYXQgaXMgbm90IHNlY3VyZS4NClBsZWFzZSB0YWtl
IHdpdGggUENJIFNJRyBhbmQgZmlsZSBDVkUgdG8gUENJIHNpZy4NCg0KPiBZb3UgZXhwb3NlIGFs
bCBkZXZpY2UgZGV0YWlscyB0byBndWVzdHMgKGVzcGVjaWFsbHkgdGhlIHRyYW5zcG9ydCBzcGVj
aWZpYyBkZXRhaWxzKSwNCj4gdGhlIGF0dGFjayBzdXJmYWNlIGlzIGluY3JlYXNlZCBpbiB0aGlz
IHdheS4NCk9uZSBjYW4gc2F5IGl0IGlzIHRoZSBvcHBvc2l0ZS4NCkF0dGFjayBzdXJmYWNlIGlz
IGluY3JlYXNlZCBpbiBoeXBlcnZpc29yIGR1ZSB0byBtZWRpYXRpb24gcG9raW5nIGF0IGV2ZXJ5
dGhpbmcgY29udHJvbGxlZCBieSB0aGUgZ3Vlc3QuDQoNCg0KPiANCj4gV2hhdCdzIG1vcmUsIGEg
c2ltcGxlIHBhc3N0aHJvdWdoIG1heSBsb3NlIHRoZSBjaGFuY2UgdG8gd29ya2Fyb3VuZA0KPiBo
YXJkd2FyZSBlcnJhdGFzIGFuZCB5b3Ugd2lsbCBmaW5hbGx5IGdldCBiYWNrIHRvIHRoZSB0cmFw
IGFuZCBlbXVsYXRpb24uDQpIYXJkd2FyZSBlcnJhdGEncyBpcyBub3QgdGhlIHN0YXJ0aW5nIHBv
aW50IHRvIGJ1aWxkIHRoZSBzb2Z0d2FyZSBzdGFjayBhbmQgc3BlYy4NCldoYXQgeW91IGltcGx5
IGlzLCBvbmUgbXVzdCBuZXZlciB1c2UgdmZpbyBzdGFjaywgb25lIG11c3Qgbm90IHVzZSB2Y3B1
IGFjY2VsZXJhdGlvbiBhbmQgZXZlcnl0aGluZyBtdXN0IGJlIGVtdWxhdGVkLg0KDQpTYW1lIGFy
Z3VtZW50IG9mIGhhcmR3YXJlIGVycmF0YSBhcHBsaWVkIHRvIGRhdGEgcGF0aCB0b28uDQpPbmUg
c2hvdWxkIG5vdCBpbXBsZW1lbnQgaW4gaHcuLi4NCg0KSSBkaXNhZ3JlZSB3aXRoIHN1Y2ggYXJn
dW1lbnQuDQoNCllvdSBjYW4gc2F5IG5lc3RpbmcgaXMgcmVxdWlyZW1lbnQgZm9yIHNvbWUgdXNl
IGNhc2VzLCBzbyBzcGVjIHNob3VsZCBzdXBwb3J0IGl0IHdpdGhvdXQgYmxvY2tpbmcgdGhlIHBh
c3N0aHJvdWdoIG1vZGUuDQpUaGVuIGl0IGlzIGZhaXIgZGlzY3Vzc2lvbi4NCg0KSSB3aWxsIG5v
dCBkZWJhdGUgZnVydGhlciBvbiBwYXNzdGhyb3VnaCB2cyBjb250cm9sIHBhdGggbWVkaWF0aW9u
IGFzIGVpdGhlcl9vciBhcHByb2FjaC4NCg0KPiANCj4gPg0KPiA+ID4gRkxSIGF0IGxlYXN0Lg0K
PiA+IEl0IGlzIGFjdHVhbGx5IHRoZSBvcHBvc2l0ZS4NCj4gPiBGTFIgaXMgc3VwcG9ydGVkIHdp
dGggdGhlIHByb3Bvc2FsIHdpdGhvdXQgYW55IHdvcmthcm91bmRzIGFuZCBtZWRpYXRpb24uDQo+
IA0KPiBJdCdzIGFuIG9idmlvdXMgZHJhd2JhY2sgYnV0IG5vdCBhbiBhZHZhbnRhZ2UuIEFuZCBp
dCdzIG5vdCBhIG11c3QgZm9yIGxpdmUNCj4gbWlncmF0aW9uIHRvIHdvcmsuIFlvdSBuZWVkIHRv
IHByb3ZlIHRoZSBGTFIgZG9lc24ndCBjb25mbGljdCB3aXRoIHRoZSBsaXZlDQo+IG1pZ3JhdGlv
biwgYW5kIGl0J3Mgbm90IG9ubHkgRkxSIGJ1dCBhbHNvIGFsbCB0aGUgb3RoZXIgUENJIGZhY2ls
aXRpZXMuIA0KSSBkb27igJl0IGtub3cgd2hhdCB5b3UgbWVhbiBieSBwcm92ZS4gSXQgaXMgYWxy
ZWFkeSBjbGVhciBmcm9tIHRoZSBwcm9wb3NhbCBGTFIgaXMgbm90IG1lc3Npbmcgd2l0aCByZXN0
IG9mIHRoZSBkZXZpY2UgbWlncmF0aW9uIGluZnJhc3RydWN0dXJlLg0KWW91IHNob3VsZCByZWFk
IFsxXS4NCg0KPiBvbmUgb3RoZXINCj4gZXhhbXBsZSBpcyBQMlAgYW5kIHdoYXQncyB0aGUgbmV4
dD8gQXMgbW9yZSBmZWF0dXJlcyB3ZXJlIGFkZGVkIHRvIHRoZSBQQ0kNCj4gc3BlYywgeW91IHdp
bGwgaGF2ZSBlbmRsZXNzIHdvcmsgaW4gYXVkaXRpbmcgdGhlIHBvc3NpYmxlIGNvbmZsaWN0IHdp
dGggdGhlDQo+IHBhc3N0aHJvdWdoIGJhc2VkIGxpdmUgbWlncmF0aW9uLg0KPiANClRoaXMgZHJh
d2JhY2sgZXF1YWxseSBhcHBsaWVzIHRvIG1lZGlhdGlvbiByb3V0ZSB3aGVyZSBvbmUgbmVlZCB0
byBkbyBtb3JlIHRoYW4gYXVkaXQgd2hlcmUgdGhlIG1lZGlhdGlvbiBsYXllciB0byBiZSBleHRl
bmRlZC4NClNvIGVhY2ggbWV0aG9kIGhhcyBpdHMgcHJvcyBhbmQgY29ucy4gT25lIHN1aXRzIG9u
ZSB1c2UgY2FzZSwgb3RoZXIgc3VpdHMgb3RoZXIgdXNlIGNhc2UuDQpUaGVyZWZvcmUsIGFnYWlu
IGF0dGVtcHRpbmcgdG8gY2xhaW0gdGhhdCBvbmx5IG1lZGlhdGlvbiBhcHByb2FjaCBpcyB0aGUg
b25seSB3YXkgdG8gcHJvZ3Jlc3MgaXMgaW5jb3JyZWN0Lg0KDQpJbiBmYWN0IGF1ZGl0IGlzIHN0
aWxsIGJldHRlciB0aGFuIG1lZGlhdGlvbiBiZWNhdXNlIG1vc3QgYXVkaXRzIGFyZSByZWFkIG9u
bHkgd29yayBhcyBvcHBvc2VkIHRvIGVuZGxlc3NseSBleHRlbmRpbmcgdHJhcHBpbmcgYW5kIGFk
ZGluZyBzdXBwb3J0IGluIGNvcmUgc3RhY2suDQpBZ2FpbiwgaXQgaXMgYSBjaG9pY2UgdGhhdCB1
c2VyIG1ha2Ugd2l0aCB0aGUgdHJhZGVvZmYuDQoNCj4gPg0KPiA+ID4NCj4gPiA+IEZvciBub24g
c3RhbmRhcmQgZGV2aWNlIHdlIGRvbid0IGhhdmUgY2hvaWNlcyBvdGhlciB0aGFuDQo+ID4gPiBw
YXNzdGhyb3VnaCwgYnV0IGZvciBzdGFuZGFyZCBkZXZpY2VzIHdlIGhhdmUgb3RoZXIgY2hvaWNl
cy4NCj4gPg0KPiA+IFBhc3N0aHJvdWdoIGlzIGJhc2ljIHJlcXVpcmVtZW50IHRoYXQgd2Ugd2ls
bCBiZSBmdWxmaWxsaW5nLg0KPiANCj4gSXQgaGFzIHNldmVyYWwgZHJhd2JhY2tzIHRoYXQgSSB3
b3VsZCBub3QgbGlrZSB0byByZXBlYXQuIFdlIGFsbCBrbm93IGV2ZW4gZm9yDQo+IFZGSU8sIGl0
IHJlcXVpcmVzIGEgdHJhcCBpbnN0ZWFkIG9mIGEgY29tcGxldGUgcGFzc3Rocm91Z2guDQo+IA0K
U3VyZS4gQm90aCBoYXMgcHJvcyBhbmQgY29ucy4NCkFuZCBib3RoIGNhbiBjby1leGlzdC4NCg0K
PiA+IElmIG9uZSB3YW50cyB0byBkbyBzcGVjaWFsIG5lc3RpbmcsIG1heSBiZSwgdGhlcmUuDQo+
IA0KPiBOZXN0aW5nIGlzIG5vdCBzcGVjaWFsLiBHbyBhbmQgc2VlIGhvdyBpdCBpcyBzdXBwb3J0
ZWQgYnkgbWFqb3IgY2xvdWQgdmVuZG9ycw0KPiBhbmQgeW91IHdpbGwgZ2V0IHRoZSBhbnN3ZXIu
IEludHJvZHVjaW5nIGFuIGludGVyZmFjZSBpbiB2aXJ0aW8gdGhhdCBpcyBoYXJkIHRvIGJlDQo+
IHZpcnR1YWxpemVkIGlzIGV2ZW4gd29yc2UgdGhhbiB3cml0aW5nIGEgY29tcGlsZXIgdGhhdCBj
YW4gbm90IGRvIGJvb3RzdHJhcA0KPiBjb21waWxhdGlvbi4NCldlIGNoZWNrZWQgd2l0aCBtb3Jl
IHRoYW4gdHdvIG1ham9yIGNsb3VkIHZlbmRvcnMgYW5kIHBhc3N0aHJvdWdoIHN1ZmZpY2UgdGhl
aXIgdXNlIGNhc2VzIGFuZCB0aGV5IGFyZSBub3QgZG9pbmcgbmVzdGluZy4NCkFuZCBvdGhlciB2
aXJ0aW8gdmVuZG9yIHdvdWxkIGFsc28gbGlrZSB0byBzdXBwb3J0IG5hdGl2ZSBkZXZpY2VzLiBT
byBhZ2FpbiwgcGxlYXNlIGRvIG5vdCBwb3J0cmF5IHRoYXQgbmVzdGluZyBpcyB0aGUgb25seSB0
aGluZyBhbmQgcGFzc3Rocm91Z2ggbXVzdCBub3QgYmUgZG9uZS4NCg0K

