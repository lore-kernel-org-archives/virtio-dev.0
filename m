Return-Path: <virtio-dev-return-14233-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E610C3DA79
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 08:53:02 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 067EA2AF8E
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 08:53:01 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E5AF19863E1
	for <virtio-dev@archiver.kernel.org>; Mon, 15 Jan 2024 08:53:00 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D50049863A8; Mon, 15 Jan 2024 08:53:00 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C2A76986367;
	Mon, 15 Jan 2024 08:52:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4p9JMS/y+6sOKzRNH7WLlWPIMAvAnN8T5VxUKo3L+ORH58dk/RwQ/+GR9MA2TEKu9sVuu3Dp7/pJl9ZTATGOgYeoNmuCPMvHQnmMftGcOgqaQd5VrH4s8ViHP8ka5zK9WzFOQL6TxN8Z8xxFDAfdaTJDUmEWxueA77WcjUA+tTtSiICHPsQBRb8lJpcA/aD3u2Bk3apqTEt2zbazEamuongS3Id/qJ6hUf2mKM7MKSDBYX7z6uubsN7paNQHeT7GI6RFzbEcpPUXYCVG1wFn6GVu/Dilt73jdgkOjEh6uaRLgfg2ID18kzgeYdZdKSeMVCLAiHdA5AHv2+BLHIFJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvpsIre9ghM22fO40RH+teobBeKpeiRkuA1/mEJ+t4g=;
 b=dsJ10aDlxgFgR8q8d7fgfIqcKwBFT1zJCIESuogjRva6xn57XTnRxvivYtuV27/pUxjbKHV56qNcc28L/nGw8CBf4dSrkXlG2WwpyQ0KlIYNkW0Vu7qpy37T+CjQx9FPabqb0sCyIiCD6fE8Vad51ysJYwflhyLHfKV9j3AI3ymjS+Kd7Dhsk1AhhsEgK1QxyQXWdAT4ZQP1B0/9QQy87PWurmgFqRY25kQvLfawoiidW1pW51x8dM63wO7LqVG1CSlb9tJJjX7oDF1uURYW8rTRkaIVdxGZxRD7SY7XQdJicAbegvEAUCAS1RFEjrf8bnATc3Qf3rtCpk50wPUWXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Chen, Jiqian" <Jiqian.Chen@amd.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	David Airlie <airlied@redhat.com>, Gurchetan Singh
	<gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
	=?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Robert
 Beckett <bob.beckett@collabora.com>, Mikhail Golubev-Ciuchea
	<Mikhail.Golubev-Ciuchea@opensynergy.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Huang,
 Honglei1" <Honglei1.Huang@amd.com>, "Zhang, Julia" <Julia.Zhang@amd.com>,
	"Huang, Ray" <Ray.Huang@amd.com>
Thread-Topic: [virtio-comment] RE: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES
Thread-Index:
 AQHaA9H0ua9xMq0gbkqU60djCdCUsrBW4XZQgABREYCAAC/xEIABYZmAgAADs4CAABezgIABBRDQgAIBBQCAAAGaAIABFX6AgHlRKACAAAN/0IAACNEAgAAEgaCAAAwWgIAABN1AgASS9ACAAADIQIAAA3aAgAABUvCAAAfBgIAACCRg
Date: Mon, 15 Jan 2024 08:52:54 +0000
Message-ID:
 <PH0PR12MB548145B7409F2D58AC2F6D44DC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20231021035111.650248-1-Jiqian.Chen@amd.com>
 <20231026062805-mutt-send-email-mst@kernel.org>
 <BL1PR12MB5849D7936DD77FECD1FE971EE7DCA@BL1PR12MB5849.namprd12.prod.outlook.com>
 <BL1PR12MB58499AD7442C0A9FC400D747E76F2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481553C8461B7F1F047B5D3DC6F2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB58492CAC080A708809E434B0E76F2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481AD6A2E262A419FA2CBA8DC6F2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584943FA1C20BBF618EBB73AE76F2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481BB80679107D8E0167954DC6F2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB584952204D1C8AD579F8A87CE76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB548102E41B13AAB57C7321FCDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB5849F3E85F2661EB38128A67E76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481158BD79A17E1C49ACB6BDC6C2@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB5849D8D396D00919482CB6D2E76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
In-Reply-To:
 <BL1PR12MB5849D8D396D00919482CB6D2E76C2@BL1PR12MB5849.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|PH8PR12MB7135:EE_
x-ms-office365-filtering-correlation-id: 3d2d7ec8-d5b0-4d28-9952-08dc15a75d06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IQ4jsrIcNuFR7Gm0QBzCUswL8Yk7vDoBgbUOqWo9Fbln5EIzI3e5ncjrcBXKCw1aDIz84hYDM7osGabNDHMWnZrPsB6luCzZnbGqXGr8KAljlhVU73pTgJvXrlLjuXBPD9vgtpi6mjeZNtoi1MB9wNA4Ek2v/fHqeiIppozi3eyPi38XbyCxfrQgn7+E5ztk8eA7s7TdaXmC9HozqqzvvMyKVeoW+a1gIDpg7JDKSM9gDt2t4KSwQQVY4N0BzPJH23agPu26c8savRswBgceawdNSv71/LXCkQ0S77GHS+fTJINSfgQDxxGt3YHTb6vyPtk3/bersXwp/tY2iZIvwf+NY75+cW2JmnPnGhA6NT+dS6CtWVvCt+zby94DEqA7+ZEsf+R5SRqYKDf0JGd3qEPSEW6hWF/Gt4ldnLalWyU2+bgO95kC37UvvCxjh0aFEhgphZEIkSDfG7CC2hU1xd3b8sUY3FuYZaziS64lOZ01C/4GnIZUTRGtKyLrRGKJ91yNIejlWi3agURSd/Nof/Q4vgbJy0+whNImEvvnj5rWXL8b0/M7RIGnxxujNf9jUEtjMHH49TgjS7zOgCQvWbp6KfG8JktcmHCBhY1al9Jt+WIpwETAZDsXwwlXFUiy
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(396003)(136003)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(9686003)(71200400001)(26005)(478600001)(53546011)(7696005)(6506007)(55236004)(7416002)(83380400001)(5660300002)(4326008)(2906002)(41300700001)(66556008)(8676002)(66446008)(64756008)(66476007)(54906003)(6916009)(316002)(8936002)(66946007)(52536014)(86362001)(38070700009)(33656002)(38100700002)(122000001)(76116006)(66899024)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OEFITG5tZUdwcUxPTmRrSWJWeEZFUk9VNHJRbGNhdzdJKzYycjQ5NHIzRkZu?=
 =?utf-8?B?bytvSXorZmc5MzFYbXZSakxIMU9MOWVHRHFZamVkcHZBVWZlckZWMm9CVVJ2?=
 =?utf-8?B?R0ozTnBLUGtiMTlEUXpNK3U3L0JSVjV1bkRqSkRtRDFJUUlBb2xtci9hSEts?=
 =?utf-8?B?WGx5ZExMdXhHNWZXZWg4a3pWdEx3TnhkTkdLYUpjayt5NmtsMkxWdHNsaU9x?=
 =?utf-8?B?ZldScmZXZGJva1pSSjkyUm1hSHhvYnAxSTNEUzVjcDB2cXoxekxqNk9rbG11?=
 =?utf-8?B?cDk1TFpXOGJKcTZvNmltc2dpdmlzTzNXVWFsajNMYmhOWmQ3cFRSd1g5YUc0?=
 =?utf-8?B?Ymt0MytXWjhSYjMwV2RyOE5pU1pKWHlEOGVOZE5ONlhiZ3pDaHhmbXJwUWJ6?=
 =?utf-8?B?dVVPWEtxWkp1Nll4OURBWi9mbWoxR3ZQdG1GNHh3UHBNUGZtWDFNTFR0UGNP?=
 =?utf-8?B?TmlrVEpRcnZSNXZycEMzMjVsRUxOek1oUVBjWnRFZ3FFK3VIbE02eTdQZ09G?=
 =?utf-8?B?YjJieFVFZlE4c0NTQi8xaXY5VkhFN0pQREIvZGUwaXZXTktoWHovdk9VTnFT?=
 =?utf-8?B?aGc5ZnJiT3IyS2lJVjBxZktFVXM5STJ1NVIwM01KLys5U1Z5eTV3S3Q2SW82?=
 =?utf-8?B?QzI5UnNFNTdvR3hhd1Y2UWVBWVd4dmJ2V0FMaUdJbVdvQ3oyM2FydHNUUnNI?=
 =?utf-8?B?emgzSDU0cGdVaHJhRW1wVFV0MmUySzFkS01JbThUVGRHQTZSN0ZxRGNtRWYy?=
 =?utf-8?B?amZJZ0c0MitZMDRYUFhQVTN4T0FjM2NSVEZHalN4N1R4OGdQcUpybXF3d28v?=
 =?utf-8?B?cDB3UTdzN3RUbTU5M3pXN2FMb3c5VHZsdGFRL3JLdWdTdnkxK2x2dDRERzZO?=
 =?utf-8?B?SWNDSnVxYjB1MENTSTkvRWZNaUNvUHd6aFV1NStiRnZqeFNWU3psN0V4L3hm?=
 =?utf-8?B?MXhxSHBsSmNxSENIU1FpVzZPYU1JYnJQTE5pM3FoanFHOEhQdXVhZnBUZXpV?=
 =?utf-8?B?d1hmcVBYV0hRVjRxeUJKdXlBY1VodkRWd1JIeEpEaENqWkQ3ZElKNDZpS1JR?=
 =?utf-8?B?U2NNY0QydGk4cUw3Mld4Q0RSdStaVkczSGo3Um5jQjhML280UFpSR1NkK2xq?=
 =?utf-8?B?QkVrcTFISHRGcUxjYThCdkFxMDdGT3VRRWFPNWxGZWRGVkhjeTcxclBqekJ4?=
 =?utf-8?B?Z0JTUGVBS28wNGFnQzVsRUpQRSsvVStYVzdML3lQaVhQZURYdEhFaWQvQ2N3?=
 =?utf-8?B?RzQzWmZPS3ZtWXpVK25HaEVINWQ1eDFiM1Rram9iRmN2Wk43azl2Ri9rNmpW?=
 =?utf-8?B?S0FqZUJWU1hXUzJhdTFueEtvd1BJK1dEcmNoWjFiSEpVb1p6TmhoSm5FR0dB?=
 =?utf-8?B?L2xrcHlqc3VVSXNZek9FSGhma0ZsWVM2K280SjV3a0VMcEFkMSs2ejhyeG9k?=
 =?utf-8?B?UGpJUGovTHpaTnBZcjJZNzRHRndkZ2xod3BOdVpaMVZ2ck92SDdwYWZkanZh?=
 =?utf-8?B?VnBIZkh6c2FPaCtIaHhLc1Y2SmZsMEZrZkQ3WlFaQXY1dlN5d2d0eldFemo5?=
 =?utf-8?B?K2FJNjRENHEyMVp1Z0kxS1h0QjV6K0gxWkY3RVVNcE9oNDA4TFVSeXR3MGRB?=
 =?utf-8?B?U1ZDNWt6UWRKSktBcmpISWlNY0ZxbGNtTHdJU0FjYXNGNWpkZFpET05CSnVW?=
 =?utf-8?B?MExLMW1RemVxUFZLb0VOSWpacE1ROW96VWdTeWhldG1KSUJmaWlKRFdPblJQ?=
 =?utf-8?B?MHUyUFdvQ2lmU2hJMEg2cm1UNVpaUHR1RU9OTlV2QmRLWm1HM1pycTZtZ0p0?=
 =?utf-8?B?K2RlRExnVk85amY2VEkyc0xqNGJkeHVZR1FiL1lJY05MemsvRXNsbFdEUDZJ?=
 =?utf-8?B?cFQrWUFaLy9jcUhiakR6UkR2RFdVdlh5Q1FtVWJrOGZaOEdvN3NRUTFncUZt?=
 =?utf-8?B?cUtVaDVGbktJKzdXSHR6Y3l3aHhGV3hyQWFDYTgrUHJKL1BlTWNFaDB6L0xV?=
 =?utf-8?B?Z096dHJuaVIvdDhxMFhCai9xWUhXYWgwejZwUUVVdnJjZm9sWGJrVGtoVHlL?=
 =?utf-8?B?RW1UU25Na1hDdm5xMStTUXo1WTUwT1AwUXFUZzgrSWl6RjJIeVdXQnNnMlFU?=
 =?utf-8?Q?e/Tw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2d7ec8-d5b0-4d28-9952-08dc15a75d06
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 08:52:54.3678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BkCgJX1IyihShpGM2A6cc0e69fOe2djzylPZbgMae8J3ta+8Q+0EzdpcTNoHtfoJOKQRD892TFCNxBeO3m1X9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7135
Subject: [virtio-dev] RE: [virtio-comment] RE: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES

DQo+IEZyb206IENoZW4sIEppcWlhbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4NCj4gU2VudDogTW9u
ZGF5LCBKYW51YXJ5IDE1LCAyMDI0IDE6NTEgUE0NCj4gDQo+IE9uIDIwMjQvMS8xNSAxNTo1NSwg
UGFyYXYgUGFuZGl0IHdyb3RlOg0KPiA+DQo+ID4+IEZyb206IENoZW4sIEppcWlhbiA8SmlxaWFu
LkNoZW5AYW1kLmNvbT4NCj4gPj4gU2VudDogTW9uZGF5LCBKYW51YXJ5IDE1LCAyMDI0IDE6MTgg
UE0NCj4gPj4NCj4gPj4gT24gMjAyNC8xLzE1IDE1OjM3LCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+
ID4+Pg0KPiA+Pj4+IEZyb206IENoZW4sIEppcWlhbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4NCj4g
Pj4+PiBTZW50OiBNb25kYXksIEphbnVhcnkgMTUsIDIwMjQgMTowMyBQTQ0KPiA+Pj4+DQo+ID4+
Pj4gT24gMjAyNC8xLzEyIDE3OjQ0LCBQYXJhdiBQYW5kaXQgd3JvdGU6DQo+ID4+Pj4+DQo+ID4+
Pj4+DQo+ID4+Pj4+PiBGcm9tOiBDaGVuLCBKaXFpYW4gPEppcWlhbi5DaGVuQGFtZC5jb20+DQo+
ID4+Pj4+PiBTZW50OiBGcmlkYXksIEphbnVhcnkgMTIsIDIwMjQgMjo1NSBQTQ0KPiA+Pj4+Pj4N
Cj4gPj4+Pj4+IE9uIDIwMjQvMS8xMiAxNjo0NywgUGFyYXYgUGFuZGl0IHdyb3RlOg0KPiA+Pj4+
Pj4+DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+Pj4gRnJvbTogQ2hlbiwgSmlxaWFuIDxKaXFpYW4uQ2hl
bkBhbWQuY29tPg0KPiA+Pj4+Pj4+PiBTZW50OiBGcmlkYXksIEphbnVhcnkgMTIsIDIwMjQgMTo1
NSBQTQ0KPiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+PiBPbiAyMDI0LzEvMTIgMTY6
MDIsIFBhcmF2IFBhbmRpdCB3cm90ZToNCj4gPj4+Pj4+Pj4+IEhpIEppcWlhbiwNCj4gPj4+Pj4+
Pj4+DQo+ID4+Pj4+Pj4+Pj4gRnJvbTogQ2hlbiwgSmlxaWFuIDxKaXFpYW4uQ2hlbkBhbWQuY29t
Pg0KPiA+Pj4+Pj4+Pj4+IFNlbnQ6IEZyaWRheSwgSmFudWFyeSAxMiwgMjAyNCAxOjExIFBNDQo+
ID4+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+Pj4gSGkgYWxsLA0KPiA+Pj4+Pj4+
Pj4+IFNvcnJ5IHRvIHJlcGx5IGxhdGUuDQo+ID4+Pj4+Pj4+Pj4gSSBkb24ndCBrbm93IGlmIHlv
dSBzdGlsbCByZW1lbWJlciB0aGlzIHByb2JsZW0sIGxldCBtZQ0KPiA+Pj4+Pj4+Pj4+IGJyaWVm
bHkgZGVzY3JpcHQNCj4gPj4+Pj4+IGl0Lg0KPiA+Pj4+Pj4+Pj4+IEkgYW0gd29ya2luZyB0byBp
bXBsZW1lbnQgdmlydGdwdSBTMyBmdW5jdGlvbiBvbiBYZW4uDQo+ID4+Pj4+Pj4+Pj4gQ3VycmVu
dGx5IG9uIFhlbiwgaWYgd2Ugc3RhcnQgYSBndWVzdCB0aHJvdWdoIHFlbXUgd2l0aA0KPiA+Pj4+
Pj4+Pj4+IGVuYWJsaW5nIHZpcnRncHUsIGFuZCB0aGVuIHN1c3BlbmQgYW5kIHJlc3VtZSBndWVz
dC4gV2UgY2FuDQo+ID4+Pj4+Pj4+Pj4gZmluZCB0aGF0IHRoZSBndWVzdCBrZXJuZWwgY29tZXMg
YmFjaywgYnV0IHRoZSBkaXNwbGF5IGRvZXNuJ3QuDQo+ID4+Pj4+Pj4+Pj4gSXQganVzdCBzaG93
biBhIGJsYWNrDQo+ID4+Pj4+Pj4+IHNjcmVlbi4NCj4gPj4+Pj4+Pj4+PiBUaGF0IGlzIGJlY2F1
c2UgZHVyaW5nIHN1c3BlbmRpbmcsIGd1ZXN0IGNhbGxlZCBpbnRvIHFlbXUgYW5kDQo+ID4+Pj4+
Pj4+Pj4gcWVtdSBkZXN0cm95ZWQgYWxsIGRpc3BsYXkgcmVzb3VyY2VzIGFuZCByZXNldCByZW5k
ZXJlci4gVGhpcw0KPiA+Pj4+Pj4+Pj4+IG1hZGUgdGhlIGRpc3BsYXkgZ29uZSBhZnRlciBndWVz
dCByZXN1bWVkLg0KPiA+Pj4+Pj4+Pj4+IFNvLCBJIGFkZCBhIG5ldyBjb21tYW5kIGZvciB2aXJ0
aW8tZ3B1IHRoYXQgd2hlbiBndWVzdCBpcw0KPiA+Pj4+Pj4+Pj4+IHN1c3BlbmRpbmcsIGl0IHdp
bGwgbm90aWZ5IHFlbXUgYW5kIHNldA0KPiA+Pj4+Pj4+Pj4+IHBhcmFtZXRlcihwcmVzZXJ2ZXJf
cmVzb3VyY2UpIHRvIDEgYW5kIHRoZW4gcWVtdSB3aWxsDQo+ID4+Pj4+Pj4+Pj4gcHJlc2VydmUg
cmVzb3VyY2VzLCBhbmQgd2hlbiByZXN1bWluZywgZ3Vlc3Qgd2lsbCBub3RpZnkgcWVtdQ0KPiA+
Pj4+Pj4+Pj4+IHRvIHNldCBwYXJhbWV0ZXIgdG8gMCwgYW5kIHRoZW4gcWVtdSB3aWxsIGtlZXAg
dGhlIG5vcm1hbA0KPiBhY3Rpb25zLg0KPiA+Pj4+Pj4+Pj4+IFRoYXQgY2FuDQo+ID4+Pj4+PiBo
ZWxwIGd1ZXN0J3MgZGlzcGxheSBjb21lIGJhY2suDQo+ID4+Pj4+Pj4+Pj4gV2hlbiBJIHVwc3Ry
ZWFtIGFib3ZlIGltcGxlbWVudGF0aW9uLCBQYXJhdiBhbmQgTVNUIHN1Z2dlc3QNCj4gPj4+Pj4+
Pj4+PiBtZQ0KPiA+Pj4+IHRvDQo+ID4+Pj4+Pj4+IHVzZQ0KPiA+Pj4+Pj4+Pj4+IHRoZSBQTSBj
YXBhYmlsaXR5IHRvIGZpeCB0aGlzIHByb2JsZW0gaW5zdGVhZCBvZiBhZGRpbmcgYSBuZXcNCj4g
Pj4+Pj4+Pj4+PiBjb21tYW5kIG9yIHN0YXRlIGJpdC4NCj4gPj4+Pj4+Pj4+PiBOb3csIEkgaGF2
ZSB0cmllZCB0aGUgUE0gY2FwYWJpbGl0eSBvZiB2aXJ0aW8tZ3B1LCBpdCBjYW4ndA0KPiA+Pj4+
Pj4+Pj4+IGJlIHVzZWQgdG8gc29sdmUgdGhpcyBwcm9ibGVtLg0KPiA+Pj4+Pj4+Pj4+IFRoZSBy
ZWFzb24gaXM6DQo+ID4+Pj4+Pj4+Pj4gZHVyaW5nIGd1ZXN0IHN1c3BlbmRpbmcsIGl0IHdpbGwg
d3JpdGUgRDMgc3RhdGUgdGhyb3VnaCBQTQ0KPiA+Pj4+Pj4+Pj4+IGNhcCwgdGhlbiBJIGNhbiBz
YXZlIHRoZSByZXNvdXJjZXMgb2YgdmlydGlvLWdwdSBvbiBRZW11DQo+ID4+Pj4+Pj4+Pj4gc2lk
ZShzZXQgcHJlc2VydmVyX3Jlc291cmNlIHRvIDEpLCBidXQgZHVyaW5nIHRoZSBwcm9jZXNzIG9m
DQo+ID4+Pj4+Pj4+Pj4gcmVzdW1pbmcsIHRoZSBzdGF0ZSBvZiBQTSBjYXAgd2lsbCBiZSBjbGVh
cmVkIGJ5IHFlbXUNCj4gPj4+Pj4+Pj4+PiByZXNldHRpbmcocWVtdV9zeXN0ZW1fd2FrZXVwLT4g
cWVtdV9kZXZpY2VzX3Jlc2V0LT4NCj4gPj4+Pj4+Pj4+PiB2aXJ0aW9fdmdhX2Jhc2VfcmVzZXQt
PiB2aXJ0aW9fZ3B1X2dsX3Jlc2V0KSwgaXQgY2F1c2VzIHRoYXQNCj4gPj4+Pj4+Pj4+PiB3aGVu
IGd1ZXN0IHJlYWRzIHN0YXRlIGZyb20gUE0gY2FwLCBpdCB3aWxsIGZpbmQgdGhlDQo+ID4+Pj4+
Pj4+Pj4gdmlydGlvLWdwdSBoYXMgYWxyZWFkeSBiZWVuIEQwIHN0YXRlLA0KPiA+Pj4+Pj4+Pj4g
VGhpcyBiZWhhdmlvciBuZWVkcyB0byBiZSBmaXhlZC4gQXMgdGhlIHNwZWMgbGlzdGVkIG91dCwg
Ig0KPiA+Pj4+Pj4+Pj4gVGhpcyAyLWJpdCBmaWVsZCBpcw0KPiA+Pj4+Pj4+PiB1c2VkIGJvdGgg
dG8gZGV0ZXJtaW5lIHRoZSBjdXJyZW50IHBvd2VyIHN0YXRlIG9mIGEgRnVuY3Rpb24iDQo+ID4+
Pj4+Pj4+IERvIHlvdSBtZWFuIGl0IGlzIHdyb25nIHRvIHJlc2V0IFBNIGNhcCB3aGVuIHZyaXRp
b19ncHUgcmVzZXQNCj4gPj4+Pj4+Pj4gaW4gY3VycmVudCBxZW11IGNvZGU/IFdoeT8NCj4gPj4+
Pj4+PiBCZWNhdXNlIFBNIGlzIGltcGxlbWVudGluZyB0aGUgc3VwcG9ydCBmcm9tIEQzLT5kMCB0
cmFuc2l0aW9uDQo+ID4+Pj4+Pj4gYW5kIGlmIGl0DQo+ID4+Pj4+PiBkZXZpY2UgaW4gRDMsIHRo
ZSBkZXZpY2UgbmVlZHMgdG8gcmVzcG9uZCB0aGF0IGl0IGlzIGluIEQzIHRvDQo+ID4+Pj4+PiBt
YXRjaCB0aGUgUENJIHNwZWMuDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+Pj4gU2hvdWxkbid0IGFsbCBk
ZXZpY2Ugc3RhdGVzLCBpbmNsdWRpbmcgUE0gcmVnaXN0ZXJzLCBiZSByZXNldA0KPiA+Pj4+Pj4+
PiBkdXJpbmcgdGhlIHByb2Nlc3Mgb2YgdmlydGlvLWdwdSByZXNldD8NCj4gPj4+Pj4+PiBJZiBO
b19Tb2Z0X1Jlc2V0PT0gMCwgbm8gZGV2aWNlIGNvbnRleHQgdG8gYmUgcHJlc2VydmVkLg0KPiA+
Pj4+Pj4+IElmIE5vX1NvZnRfUmVzZXQgPT0gMSwgZGV2aWNlIHRvIHByZXNlcnZlIG1pbmltYWwg
cmVnaXN0ZXJzIGFuZA0KPiA+Pj4+Pj4+IG90aGVyDQo+ID4+Pj4+PiB0aGluZ3MgbGlzdGVkIGlu
IHBjaSBzcGVjLg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+
Pj4gU28gZGV2aWNlIG5lZWRzIHRvIHJldHVybiBEMyBpbiB0aGUgUG93ZXJTdGF0ZSBmaWVsZC4g
IFRoaXMgaXMgbXVzdC4NCj4gPj4+Pj4+Pj4gQnV0IGN1cnJlbnQgYmVoYXZpb3IgaXMgYSBraW5k
IG9mIHNvZnQgcmVzZXQsIEkNCj4gPj4+Pj4+Pj4gdGhpbmsoIVBDSV9QTV9DVFJMX05PX1NPRlRf
UkVTRVQpLiBUaGUgcG0gY2FwIGlzIHJlc2V0IGJ5DQo+IHFlbXUNCj4gPj4gaXMNCj4gPj4+Pj4+
Pj4gcmVhc29uYWJsZS4NCj4gPj4+Pj4+PiBXaGF0IHlvdSBkZXNjcmliZWQgaXMsIHlvdSBuZWVk
IHRvIGRvIE5vX1NvZnRfUmVzZXQ9MSwgc28gcGxlYXNlDQo+ID4+Pj4+Pj4gc2V0IHRoZQ0KPiA+
Pj4+Pj4gY2FwIGFjY29yZGluZ2x5IHRvIGFjaGlldmUgdGhlIHJlc3RvcmUuDQo+ID4+Pj4+Pj4N
Cj4gPj4+Pj4+PiBBbHNvIGluIHlvdXIgY2FzZSB0aGUgaWYgdGhlIFFFTVUga25vd3MgdGhhdCBp
dCB3aWxsIGhhdmUgdG8NCj4gPj4+Pj4+PiByZXN1bWUgdGhlDQo+ID4+Pj4+PiBkZXZpY2Ugc29v
bi4NCj4gPj4+Pj4+PiBIZW5jZSwgaXQgY2FuIHdlbGwgcHJlcGFyZSB0aGUgZ3B1IGNvbnRleHQg
YmVmb3JlIHJlc3VtaW5nIHRoZSB2Y3B1cy4NCj4gPj4+Pj4+PiBJbiBzdWNoIGNhc2UsIHRoZSBl
eHRyYSByZWdpc3RlciB3b3VsZG7igJl0IGJlIG5lY2Vzc2FyeS4NCj4gPj4+Pj4+PiBIYXZpbmcg
UE0gY29udHJvbCByZWdpc3RlciBpcyBhbnl3YXkgbmVlZGVkIHRvIGRyaXZlIHRoZSBkZXZpY2UN
Cj4gPj4gcHJvcGVybHkuDQo+ID4+Pj4+PiBFdmVuIGFzIHlvdSBzYWlkLCB0aGUgcmVzZXQgYmVo
YXZpb3Igb2YgUE0gaW4gdGhlIGN1cnJlbnQgUUVNVQ0KPiA+Pj4+Pj4gY29kZSBpcyBpbmNvcnJl
Y3QsIGFuZCBldmVuIGlmIGl0IGlzIG1vZGlmaWVkLCBpdCBhbHNvIGNhbm5vdCBmaXgNCj4gPj4+
Pj4+IHRoaXMgcHJvYmxlbSB3aXRoDQo+ID4+IFMzLg0KPiA+Pj4+PiBZb3UgbWVhbnQgRDM/DQo+
ID4+Pj4+DQo+ID4+Pj4+PiBCZWNhdXNlIHRoZXJlIGlzIHR3aWNlIGRldmljZSByZXNldCBkdXJp
bmcgcmVzdW1pbmcuDQo+ID4+Pj4+PiBGaXJzdCBpcyB3aGVuIHdlIHRyaWdnZXIgYSByZXN1bWUg
Y29tbWFuZCB0byBxZW11LCBxZW11IHdpbGwNCj4gPj4+Pj4+IHJlc2V0IGRldmljZShxZW11X3N5
c3RlbV93YWtldXAtPiBxZW11X2RldmljZXNfcmVzZXQtPg0KPiA+Pj4+Pj4gdmlydGlvX3ZnYV9i
YXNlX3Jlc2V0LT4gdmlydGlvX2dwdV9nbF9yZXNldCkuDQo+ID4+Pj4+IEEgZGV2aWNlIGltcGxl
bWVudGF0aW9uIHRoYXQgc3VwcG9ydHMgUE0gc2hvdWxkIG5vdCByZXNldCB0aGUgZGV2aWNlLg0K
PiA+Pj4+IFBsZWFzZSBmaXggaXQuDQo+ID4+Pj4gRG8geW91IG1lYW4gdGhlIGRldmljZXNfcmVz
ZXQgYmVoYXZpb3Igb2YgcWVtdSBzaG91bGRuJ3QgaGFwcGVuDQo+ID4+Pj4gd2hlbiBhIGRldmlj
ZSBoYXMgUE0gY2FwPw0KPiA+Pj4gUmlnaHQuIERldmljZSByZXNldCBzaG91bGQgbm90IGhhcHBl
biBvbiBQTSBjYXBhYmxlIGRldmljZSB0aGF0DQo+ID4+PiBvZmZlcnMNCj4gPj4gbm9fc29mdF9y
ZXNldD09MS4NCj4gPj4gQnV0IGN1cnJlbnQgcWVtdSBjb2RlLCBub19zb2Z0X3Jlc2V0PT0wLg0K
PiA+Pg0KPiA+IFNvIHBsZWFzZSBmaXggdGhlIHFlbXUgd2hlbiB5b3UgYXJlIGFkZGluZyB0aGUg
ZnVuY3Rpb25hbGl0eSBvZiByZXN0b3JpbmcNCj4gdGhlIGRldmljZSBjb250ZXh0IG9uIFBNLg0K
PiBNeSBwYXRjaCBkaWRuJ3QgYWRkIHRoZSBmdW5jdGlvbmFsaXR5IG9mIHJlc3RvcmluZyB0aGUg
ZGV2aWNlIGNvbnRleHQgb24gUE0uDQo+IElzIG5vX3NvZnRfcmVzZXQgbXVzdCBzZXQgMSB3aGVu
IGEgZGV2aWNlIGhhcyBQTSBjYXA/IA0KDQpJdCB0aGUgZGV2aWNlIHdhbnRzIHRvIGV4cG9zZSB0
aGUgYWJpbGl0eSB0byBzYXZlIGFuZCByZXN0b3JlIGNvbnRleHQsIHRoZW4geWVzLCBub19zb2Z0
X3Jlc2V0ID0gMSwgYXMgZGVmaW5lZCBieSB0aGUgUENJIHNwZWMuDQoNCj4gSXQgc2hvdWxkIGFs
c28gYmUNCj4gYWxsb3dlZCBmb3Igc2l0dWF0aW9ucyB0aGF0IGFyZSBub3QgZXF1YWwgdG8gMSwg
cmlnaHQ/DQpJIGRvbuKAmXQgc2VlIHRoZSBuZWVkIG9mIGl0LiBJdCB3b3VsZCBub3QgYmUgYWxp
Z25lZCB0byBub19zb2Z0X3Jlc2V0IGJpdCBhbHJlYWR5IGRlZmluZWQgYml0Lg0KDQo+IFRoZXJl
IHNob3VsZCBiZSBkZXZpY2VzIHRoYXQgaGFzIFBNIGNhcCBidXQgbm9fc29mdF9yZXNldCBpcyAw
IGJlY2F1c2UgdGhhdA0KPiBkZXZpY2VzIGNhbid0IHN0b3JlIGFuZCByZXN0b3JlIHRoZSBkZXZp
Y2UgY29udGV4dCBvbiBkMy0+ZDAgdHJhbnNpdGlvbiwgbGlrZQ0KPiBjdXJyZW50IHFlbXUgY29k
ZS4NClJpZ2h0LCBQTSBjYXAgd2l0aCBub19zb2Z0X3Jlc2V0PTAsIHdpbGwgbm90IHJlc3RvcmUg
dGhlIGNvbnRleHQgb24gZDMtPmQwIGFzIHRvZGF5Lg0KDQo+IFNvIHRoZSBmaXggc2hvdWxkIGJl
IGZlYXNpYmxlIGZvciBhbGwgc2l0dWF0aW9ucyB0aGF0IHdoZXRoZXIgdGhlIG5vX3NvZnRfcmVz
ZXQgaXMNCj4gMSBvciBub3QuDQpJIGRvbuKAmXQgZm9sbG93IHRoZSAiZml4IHNob3VsZCBiZSBm
ZWFzaWJsZSIuDQpRRU1VIHJlc2V0IHRoZSBkZXZpY2Ugb24gZDMtPmQwIHRyYW5zaXRpb24gd2hl
biBub19zb2Z0X3Jlc2V0ID0gMCBzZWVtcyBmaW5lIGJlY2F1c2UgaXQgZm9sbG93cyB0aGUgZGVm
aW5lZCBwY2kgc3BlYy4NCg0KPiBJZiB1c2UgUE0gY2FwLCBub3QgZXZlcnkgc2l0dWF0aW9uIGNh
biBzb2x2ZSBjdXJyZW50IHByb2JsZW0gKGRpc3BsYXkNCj4gcmVzb3VyY2VzIG9mIEdQVSB3aWxs
IGJlIGRlc3Ryb3llZCkuDQo=

