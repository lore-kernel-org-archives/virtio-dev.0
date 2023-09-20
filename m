Return-Path: <virtio-dev-return-13867-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EC7DCE79AC
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 09:45:17 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 713AC66DCF
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 09:45:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 61A61986679
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 09:45:16 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 55E83986669; Wed, 20 Sep 2023 09:45:16 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 47D7E98666C
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Sep 2023 09:45:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kc5wRgqJBEHwiL85hO9NzTz1FsazK19TyufcpAN8DWPdWlNsY5I9TBqtvEL+B2HisFoCTt6l0aApUqMdpiewHwpL0ZRV1pEDcutqtRKOAmw0LKUYVM2uBwzutSBUGZIhB6pa6YIsIPSf/BAYKHUxjcbvjQCGL16AkxtxUmvHfbLGolha2KB6GZdaQrxx/tpNFVIRBR35lM4/JA+dI9SZ9I82yLDCBPiIC4mBqa5KKv/wxnYWNP8So5RfnzShXLdMcnPLTZ3nz3p3ekLan+u56BUcGG0FXORg4xuUUCyduoBIR3SgTiHwcTaGmEDhdfSsFCxTaSVmHohhk7XP6t5HWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVAbVC6Pi9cEbG/Nhabw/ypN43FZf6X+qIZB2yVW6Ow=;
 b=UCU2U585DPmxvh5H54FaUd4T8jSep/XyfuL0iNlp3MBizT3QGQEg3+pHOzi3iEG8aXHwDMXQ0fgJIzitQErvKQRk7QU4juVw/psJ+jXdHYZ4k0Vc5jvHPm0NpfHhd75V54JmQvCt/TMXUO4DgDl3pPJC1kbq/iG5D25f3wIKPpVcBlLNYGsrgqNRYdJbp2Ww4rAw9vjCCIJ+roE8UwHW75LqjFSt6wDwGE2zgJTIeQ92yi2em+OTO2jsmgj0PnzljUpr29Z2K2A4/YDwHGco4KpmIKW53x7kmg++F524FKwL+SOAPY7eIY72B6fOpByWrupM6lMUdZHKcjWWIG90Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: jeshwank <JESHWANTHKUMAR.NK@amd.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>
CC: "Mythri.Pandeshwarakrishna@amd.com" <Mythri.Pandeshwarakrishna@amd.com>,
	"Devaraj.Rangasamy@amd.com" <Devaraj.Rangasamy@amd.com>,
	"Rijo-john.Thomas@amd.com" <Rijo-john.Thomas@amd.com>, "Nimesh.Easow@amd.com"
	<Nimesh.Easow@amd.com>, "babulu.ellune@amd.com" <babulu.ellune@amd.com>
Thread-Topic: [virtio-dev] [PATCH] virtio-tee: Reserve device ID 46 for TEE
 device
Thread-Index: AQHZ4KaYEgYaP3dT2EuYXxaxQQ0c/rAjjGTQ
Date: Wed, 20 Sep 2023 09:45:13 +0000
Message-ID:
 <PH0PR12MB54810E429F2FE6E18E4D5987DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <d38932451104835ebe23acfc723dc3f0a9f43b98.1693993329.git.JESHWANTHKUMAR.NK@amd.com>
In-Reply-To:
 <d38932451104835ebe23acfc723dc3f0a9f43b98.1693993329.git.JESHWANTHKUMAR.NK@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY8PR12MB7435:EE_
x-ms-office365-filtering-correlation-id: cd173c17-f9fa-4bd0-a35e-08dbb9be4a02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ENRB40LPeDfuUlRS95NyRCK1UkoSmeUo62BzAz85nK8ZBnQ/q59UHKMsU7EJxGrzZQFQjlC71XkmsUHea5h9HpsjaUnDf05gMTS4iPYM+iwE7QjWnE5jCV9HGw8TUdFfJYyLbNuM+ZNJFrBSGz1uJ8JDLcOW2VWdGTmAlqwef3zlI9G8otsnCJuis6C0ZrbyXvZE17TbmLXJdztjoS2x6NOirk/PRcwJSYjzO4W9beuCGLkRGRf1wKN12rW8lLf1bf/Qf2qQgKJanxIa6EesJWrb9FWNOehypcmU4LNiKFgqYaiX8wP5Y4IYW4/oBWEqSFV35NFPhAH85HDVw4eU7e49Xjg/h/rdB8kTMZWD5xy0JfKh0EG5Mrx82hXPHQXEsZmtGaeBn/WAJbAdUjDGfGmcuhn981W8f1eKgHh/uNg1WfKa52LFsEEz1FPBkCtK1BuRslpR9buNqnz7J9KqurtydDbD8YjS4tv6Brpwxt2xjWVrHipePDvmHrjFh5Gl550YJ77ScdtyKYq77TDLpIfCMiw+zLcDo3QTx679C0yCvPsEoYaH6bdzdTNiZTjr8sosji+MApE5shYZWQVFPjuqYu41kKvK/LLkkplbNZUa8pfpXmpiwGuNmDSrLhgk
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(366004)(346002)(451199024)(1800799009)(186009)(55016003)(66899024)(6506007)(7696005)(38070700005)(122000001)(33656002)(38100700002)(5660300002)(86362001)(9686003)(2906002)(71200400001)(478600001)(83380400001)(8676002)(41300700001)(316002)(52536014)(4326008)(64756008)(110136005)(8936002)(76116006)(54906003)(66446008)(66476007)(66556008)(66946007)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MHNNcDlPbWxkMmdjUjl6dU1hazFMVmovalN0Uko3ZjhpNzVXZWFvNTdqZ0l1?=
 =?utf-8?B?M3BucHE1ZGhRSnRVN3JnTlJCTFJWL3EyMG1GTjV5TjAxd0dFZUYzS1luTjFx?=
 =?utf-8?B?RW1JczE0V2t3YTVUc0R5ZlR1NDVtWi93OTJOU3FCWDBNU0pUckZpYWkrVG1Y?=
 =?utf-8?B?eWh5UzlMZEJIZHJNOEEvTjdQZ2ovTHQxUDlsdXhCUjNRRU1BTHkyUnhIVTN0?=
 =?utf-8?B?c2xDUDVNWmdpOVZyQkErOCsyOHZNdGJVZ3ZtK1ZIQ2xUZ01LVnJ5OUJzUDht?=
 =?utf-8?B?L2VMSk1RZG01WWlYOGJuOUZGYm1iRnAyU0RzRlM1VU84ZzV6NHJXR1YyNm8x?=
 =?utf-8?B?aG5LNitHNE1HTHFyUFQ5UlVlOFVoS09PeGJsalAwWllVUys2U21lQlVBcU03?=
 =?utf-8?B?aU1xSU9KcWdGOTNpME9xdEpqeWJjbXR4dHd1UjRqMGg0T0dGOHhXMDluSnA1?=
 =?utf-8?B?N3NLeXhXYnpXR2k5YkpZQTllZU9FWFFWMDRVSndKUWwwRmZCYmc3UUNrRnhE?=
 =?utf-8?B?b0Q0VG9IWHRLYUhQenFabUY2N2ZJQjM3b2djNDFrc2xQcFg3MklBK3BwOUF5?=
 =?utf-8?B?WWJkNHZFQTNtNU4wOUZRL21GRHhGcnRodEkzMzRpSSsramh6azc1ZnAwRkJM?=
 =?utf-8?B?S3BEWG5QRlJQWnVJOW9wNUhLY3lGTE1zdTEwTGYwbmF1SzZqSFlxNzJKcXhW?=
 =?utf-8?B?alN3M0hWMTdlUVZzU3kxZThaakdFelM0MmZqeXg0TkRndVZQMFlUcnJiM2tr?=
 =?utf-8?B?Y1l3SGtYRFNVamhVeDlKK0ZZTWo4bTNCZXFHT1J2c25BekNRYklWM1o4MGpZ?=
 =?utf-8?B?K2huaUthSVd4ZXJjR0owLy9pak9vQ0V6d3VRZUNmK1lvbitES0N2MzUwWHU1?=
 =?utf-8?B?WmN3TGI2bDRQMEp6TDRuOVdUWVlpSTZUSWc0U0lZUU4zc3JpbUwwNHBUSjNs?=
 =?utf-8?B?YkZ5U2ZoTlpIVUdTZFlEbzlMUzliRW81L0FLcnNxbTZRc3JoeTdXSHpWUzhr?=
 =?utf-8?B?bVJHamV0T1BnL0I0NTVkcWdZS05jVlJLRWViZVNCM0xZN0RuSHF2VklyV3Jl?=
 =?utf-8?B?MUc2L1lDWlI3WEVkYjA0UlZJS2grU1I5MGZJN21HdmdmSVZpRStyd2hUOFcz?=
 =?utf-8?B?ZmkwVE1Id29UY3N6TEJFSFl0bDhzSVlsTzEwS0g3ekwwSFdZK0kwemhZeStS?=
 =?utf-8?B?WDVEdGs1c1ErUDljOXFYdnhpWnVhYUV6UkJMT3RoR3J1SWpnVzkwekY1eVlH?=
 =?utf-8?B?Smk5dkFNVEpteCtPVmlVb05Yb3NIQStWaHV0L0R6bndYQkZnWDl0WFF2T0NL?=
 =?utf-8?B?TUJJZ2MvajE4ZlF3M1AxS1dJQ1hqb1RCcWN4SVQ0WDB2dlhFT1hyY0p1dzF2?=
 =?utf-8?B?SDdlVHcwWDcrRUN6Yk1mWEFORU5kWWx0UXR0aFVRQ3QzTUdwZWlTR04wa085?=
 =?utf-8?B?UlpHazhsa1JWMEZEQkY3dlhvbGRJNVB1b0FLK3kxSjJrY0JuY1lxS09JcHZt?=
 =?utf-8?B?cS9BY1NSZ2NNRkhrQTdPZDR6Znk2WEFOK2UxblZiRFlFNDdTNWluUG9Idm5X?=
 =?utf-8?B?SlZ6Z2R3dWJYNysvQThVRUU1em5MRW9nbWN3MXljSFpnbzRiVkpPeG1zckx0?=
 =?utf-8?B?ZkNZSm9pTm1pVVhHazRNbC93N0dmdi9BRGFOZVBVeUxNdlM2Vkh0bmsrc2xW?=
 =?utf-8?B?RTRUTGFhcXlzSUdKWHJhSlpiYWlMMTFqK3dCUjJJNWQwOE1nZ3NadkN6UjVk?=
 =?utf-8?B?T3NMU3BOdzNzVmJjUHNVZXlDbXBwV2VDSXNVczRoa3dqYlFrVUFRSCt2cytR?=
 =?utf-8?B?TGwvSnU1dEJrRG81SHIrMWRpVHlHbW9UbDVvdVhzbS9KZEF5bjl3V242clJo?=
 =?utf-8?B?d3VFVUVTVDZ3Nm1Kbk96UXZqVWRzMXRiSnJaS2ZXNFcvdnFYU3poN3ZRSUZM?=
 =?utf-8?B?SjMyUzRTb3V5L3dVVjE0UVVFYXlCVzFGMHR1V1V3bVBxY0J5SW1heHJNMjcr?=
 =?utf-8?B?d2ZxOEZITFRuSExBdlgrZmtKdTNmN0haTEpLNXR2ZnJzbnVhZDlPQVdhQTc3?=
 =?utf-8?B?YXV2M1NNMExvK0pHMnB1TkxFZ0hvUkZqSitJTHF2U2RXRktiVUZJTkU4bXJ2?=
 =?utf-8?Q?Dmec=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd173c17-f9fa-4bd0-a35e-08dbb9be4a02
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 09:45:13.9146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m16o7PWwl4ud8EuPO7GhKLRm5/091tsiyYvsxSggXxN6LCIwJ4W+o99Ej+iVEBo0gdrTiUjkIvJSdP9Z6sS6lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7435
Subject: RE: [virtio-dev] [PATCH] virtio-tee: Reserve device ID 46 for TEE
 device

SGksDQoNCj4gRnJvbTogdmlydGlvLWRldkBsaXN0cy5vYXNpcy1vcGVuLm9yZyA8dmlydGlvLWRl
dkBsaXN0cy5vYXNpcy1vcGVuLm9yZz4gT24NCj4gQmVoYWxmIE9mIGplc2h3YW5rDQo+IFNlbnQ6
IFdlZG5lc2RheSwgU2VwdGVtYmVyIDYsIDIwMjMgMzoxMyBQTQ0KPiANCj4gVGhlIHZpcnRpby10
ZWUgZGV2aWNlIGFsbG93cyBndWVzdCBPUyB0byBhY2Nlc3MgdGhlIFRFRSBwcmVzZW50IGluIGhv
c3Qgc3lzdGVtLA0KPiB0byBwZXJmb3JtIHNlY3VyZSBvcGVyYXRpb25zLg0KPiANCj4gVGhpcyBw
YXRjaCBpcyB0byByZXNlcnZlIGEgZGV2aWNlIElEIDQ2IGZvciB2aXJ0aW8tdGVlIGRldmljZS4N
Cj4gDQoNCkZvciB0aG9zZSB3aG8gYnJlYXRoIFRFRSBpdHMgbWF5IGJlIG9idmlvdXMgdGhpbmcu
IPCfmIoNCkZvciBtZSwgYSBodW1ibGUgcmVxdWVzdCwgDQpjYW4geW91IHBsZWFzZSBleHBhbmQg
dGhpcyBwYXRjaCB0byBjb250YWluIHNob3J0IGRlc2NyaXB0aW9uIG9mIGJhc2ljIGZ1bmN0aW9u
YWxpdHkgb2YgdGhlIFRFRSBkZXZpY2UgdG8gZW5jb21wYXNzIHVuZGVyIHRoaXMgZGV2aWNlLWlk
Pw0KDQo+IFNpZ25lZC1vZmYtYnk6IGplc2h3YW5rIDxKRVNIV0FOVEhLVU1BUi5OS0BhbWQuY29t
Pg0KPiAtLS0NCj4gIGNvbnRlbnQudGV4IHwgMiArKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5z
ZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2NvbnRlbnQudGV4IGIvY29udGVudC50ZXgN
Cj4gaW5kZXggMGE2MmRjZS4uNjQ0YWE0YSAxMDA2NDQNCj4gLS0tIGEvY29udGVudC50ZXgNCj4g
KysrIGIvY29udGVudC50ZXgNCj4gQEAgLTczOSw2ICs3MzksOCBAQCBcY2hhcHRlcntEZXZpY2Ug
VHlwZXN9XGxhYmVse3NlYzpEZXZpY2UgVHlwZXN9ICBcaGxpbmUNCj4gIDQ1ICAgICAgICAgJiAg
IFNQSSBtYXN0ZXIgXFwNCj4gIFxobGluZQ0KPiArNDYgICAgICAgICAmICAgVEVFIGRldmljZSBc
XA0KPiArXGhsaW5lDQo+ICBcZW5ke3RhYnVsYXJ9DQo+IA0KPiAgU29tZSBvZiB0aGUgZGV2aWNl
cyBhYm92ZSBhcmUgdW5zcGVjaWZpZWQgYnkgdGhpcyBkb2N1bWVudCwNCj4gLS0NCj4gMi4yNS4x
DQo+IA0KPiANCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IFRvIHVuc3Vic2NyaWJlLCBlLW1haWw6IHZpcnRp
by1kZXYtdW5zdWJzY3JpYmVAbGlzdHMub2FzaXMtb3Blbi5vcmcNCj4gRm9yIGFkZGl0aW9uYWwg
Y29tbWFuZHMsIGUtbWFpbDogdmlydGlvLWRldi1oZWxwQGxpc3RzLm9hc2lzLW9wZW4ub3JnDQoN
Cg==

