Return-Path: <virtio-dev-return-13793-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1201FC46CA1
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 06:46:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6022F159D2E
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 06:46:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 51522986533
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 06:46:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 424F7983DFF; Mon, 18 Sep 2023 06:46:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2D12798638E;
	Mon, 18 Sep 2023 06:46:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTu5j/1heCKS+RjnMUguTnem7HLitpPIQT/MjUzqVmhhUiwmt6ISFYeIGRjy+GxrsukLcmg+JtCr9EZKXvRYEiMjhY21/vA3HnK7v/HiZJIZ30KSSybnhP66zXRZz+l5WzefBs/maB5J8jMJeGAGuQ/Afr+Pwv/2/ADIRyX2CxLAofOH2rexeTCvOUAHfKUGZDSIemQgiex2DJ2acX021gMilSWoBbZ49y4gmTzVTzxCTLznavl1rl5A1ZKvZSnYE8p2TOBAxK21+V45UjXkgSfkm6+ABVAIFEMSXSxD89R18xkLKEBwf3aPcKVoUWRYn6UWgfPdn78SXE9HA+Jw2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Vjh86kqKIbuJEquuQKxfpIpTWh89sjkSud4/J7x/KA=;
 b=VXj+C5b/LiiFHzHKg224gEf38ikIYJdBNyv7lEtYvT+FKNPHGpWzLTQFEAcJ8GtvsWZfMTjwVbbGnSXM7glWtAiEWAT7yoUHpBHczflkIjkfStXREh38jjM/6wqFr8f7/R372Z8CoX7O1GN1ho1q0nY3bfL1mxD4wgaamx9rPmh9ckYuHhb7X4Q6DzoAUZVptgmhwyg8lW3iEwgBcKbbYbme5ZS+PWiJ4piivd/JAfG6TW1lHKy3zUckock5ykN255RE+pxPwsIOJ51C6O55w1vKLw/g23N/WwLKLhdhLFmWQgXB9stxEuYKmyiAhTOm6NoYUaD7BqxwMYm9Kd/PDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, "Michael S. Tsirkin"
	<mst@redhat.com>
CC: "jasowang@redhat.com" <jasowang@redhat.com>, "eperezma@redhat.com"
	<eperezma@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-comment] Re: [PATCH 2/5] virtio: introduce SUSPEND bit
 in device status
Thread-Index:
 AQHZ54Brxw1ek7h0hUC1WdnFAMp2C7Abu4+AgAQs4gCAAB0UEIAACZoAgAAQp2CAAAayAIAAAGhw
Date: Mon, 18 Sep 2023 06:46:33 +0000
Message-ID:
 <PH0PR12MB5481D3E0B9B8EC0F5626F373DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-3-lingshan.zhu@intel.com>
 <20230914073023-mutt-send-email-mst@kernel.org>
 <258989c9-8c5f-c72e-c03d-aabf11f9823d@intel.com>
 <20230915070504-mutt-send-email-mst@kernel.org>
 <3ff7e79f-8fbb-4e3e-eb12-17ed8943fe6f@intel.com>
 <PH0PR12MB5481E091659FEA931DBC826EDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <90ffd64c-9997-3ebb-6d4b-6fdb8d1bdb4f@intel.com>
 <PH0PR12MB5481309462314E5E17B064A1DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <c2fd48e4-0e2f-038a-5b11-85cc7e0ef081@intel.com>
In-Reply-To: <c2fd48e4-0e2f-038a-5b11-85cc7e0ef081@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|SA1PR12MB6728:EE_
x-ms-office365-filtering-correlation-id: 692895f0-30d3-4751-ce43-08dbb812ff3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pWZw008NZVP5jsaoWslOKRxFQtI5HbyXMmX2utjjZjlEftKZbfeUilA0rDheW6bU/0cbV94bK2BIAJC98PcUQ59OvT5d9bh34ypGQx468BP8X0+tz4ahTV6N9CSjCXRYWg2p81QpPp1fVvQlq7DbwUfCPgFL3qNPzfkwy9B3foRTPLnW9iajvrNoA2l/mNtQZcIU+b95MOeFb8xA4nSaspEP1DQgwAXJLnXOcWhVIx1uPF/TMagFH5AfnHPbAd2OhA0GQVyZjnolWTvNy4LTQugj4p1wgUnMB+KtNQH/4i25Lidv/YDbxNR9Hh2sRNDyUZhHOPgvaP5cbU9vaow4TSoKqV6qbsSHr2ykn7rFBe1m6Gk2JVryCfwrw9JBcAkz+s4gpekdFyZsyLMSv2jPlGV5F9CzCZqPm9tMDNHTd8mo/tw7geLhTGIvzUAyT5FnIJEEqlODaT8H/l8/hlvNLAizpBc+cEPLEVNO8S+wCqKdOfP4uQeYgtgM2VjpQjmPVev35mdfidi2UhecGnMi6hhmFIPpydXd8AbyVHxAmN1qsCML1NtDONGHypikI13U+oew0DYRe55lAlEyw77Ar8HgsWIFO0mIEjNr8Wn6P/uPUiG/UqWuzn2cAo07wH+/
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(39860400002)(396003)(136003)(1800799009)(186009)(451199024)(6506007)(83380400001)(9686003)(26005)(316002)(15650500001)(41300700001)(110136005)(4744005)(66556008)(54906003)(64756008)(76116006)(66446008)(66476007)(52536014)(66946007)(5660300002)(8676002)(8936002)(4326008)(71200400001)(2906002)(7696005)(478600001)(55016003)(86362001)(38100700002)(33656002)(122000001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dUNmbUtLVmk3ZjNuRlhJYTE5cWFiaDNKd2FkdEVYa3IwMTlOZWl4bTRXMHg2?=
 =?utf-8?B?SEYrdUorbmxGWXFUTVAwaW9YeWR1VkdyQ2VmS1AraUd4TVdqSVpEcEtoNmsr?=
 =?utf-8?B?NDBlNnRnejJUQXZtb0xUL3loYjREU2p5dXhVZlB5cjVzQjFtbkpHTWhGVHBQ?=
 =?utf-8?B?ekRBUFI3ZmY1aTdxb1pzckFjSUFSb25aVVFEa25BSjhYMThWSi9aemdvTnI3?=
 =?utf-8?B?MHFYbHA1bmhXSzRjVDJRT0hDSWpHNGVFRnViL05wSDY1cjJmbTMyK2F1cUxT?=
 =?utf-8?B?YjdIYzhnT0YwUWZXWG52MnBjK1BrZkpXOHF1dTllbjJGTWRYVTRlNnpPY0ll?=
 =?utf-8?B?cHZBMjYwblZpTHRZNjJsQnREbmR0YkRoZ08vczdGR2dwZko1YThrcjZxVytC?=
 =?utf-8?B?UENmRDlCOGlyb0lnOGd2dVNFWldYNUlRcSs5bEloVGFEaC9XSWNNL1doeVBn?=
 =?utf-8?B?Z2NNS3NkdlZQTHIvRHZSbHFIL0NiT3ZKcG1BWE50M0FGaEw1RHlYODNpdURM?=
 =?utf-8?B?US9odzdlT0RYNG5yeldHQ1NZRmhBNVJZU2NnRkRxOS9vY050eVV5eXAxaFFX?=
 =?utf-8?B?TjRqa09hTVB4TE4yVURQWHNjdkpJOUsyNS9FaEhaRjdySGVNdURJVkc1RXd2?=
 =?utf-8?B?bUt5b0dzc1R5T1ZybWlvRlFzcVZyZmVuUjgzc0IwMHBBSFhoSnQzOHlXR1ZD?=
 =?utf-8?B?ejZtWnAyQ3JvaHBVMnJ4enJaUTg3VDJob1BmTnBvNE84Q2J3d0EyeHR6a1Fr?=
 =?utf-8?B?czRVTEJvdytKODk5Nkl1SFliNkQzNy85aHMwR0pNSmJBUFhsSHJ3YktlcHNl?=
 =?utf-8?B?K3B4OE56ZHFTRDJocUhxck1DZVMvYmpZYVRNMElURktrOTNBMERWVGxBY2NZ?=
 =?utf-8?B?b0dzTGx5cFFhUFdZSTY0V25SVXBtU0JQQzVVK2lxMHNaSVBCYktzdG9PME5s?=
 =?utf-8?B?U2R4WDg0M1BmUFNhdlR6VnBCeVJoUWFKN05aWCtHUW4rRGtRMWpnWDExSURY?=
 =?utf-8?B?MnVoZUsxcENGV1RUWnlJYU5vajVOdVZLVjJtanB2QjNlZjVqeFd5ZFlJOVVv?=
 =?utf-8?B?Z0hzT0lPdVNKWmtoanVUUTFSbGF2aU1Rd0hiMS9MZ3JJaFpHMndPcitHZ056?=
 =?utf-8?B?bTZzU2dtWW5PZzBkem9CR0hwczlPMlRFTGdzbDNiM09yZlJ4ZkhsQkluMW02?=
 =?utf-8?B?UkxRdG5VYnFBZUNhNFVwQ3prbFdqNXRraGRjT2ZNVTZoSkkxMUVmWml4Y0Zl?=
 =?utf-8?B?TGNPanJLWWhmeS9DYTV6LzJsWUNjbk9aSURqTEdsOFRqQ0swdG91bnN5MWFs?=
 =?utf-8?B?V1Rlb2N3UDNkZFdualljbUNUejc2OHB0Wmx5Q1dUVU9MQkNDejF0UzdrK2F2?=
 =?utf-8?B?ejJCVDNxbExTdFNYM1FZNlI0cER6cHBtY3pWTlBodDdjQm9jQ1NjRUlpNVN3?=
 =?utf-8?B?Mm5TNkdtMzJOZHBwT2plY044ZDZHenpXMWRHaFZPaHVVMll0Q2hpUmFXTlVK?=
 =?utf-8?B?eVhQaVlYcEdxbytwRmtaUDNnTTc2NFJrQkRMcmNqVUhYLyt4WHJ6VzBLNlJ0?=
 =?utf-8?B?RHR6R3BvWHZPZzl1d0FCemhmWmIwcmFXektGc203a2YyMHlTQlZQeDhkYW9Z?=
 =?utf-8?B?WDBlZjN5U29XcHRjbFh5N1FVOUJueWllejFvaDVQWlU0ZmovZEN0NUk5K3VO?=
 =?utf-8?B?VVF3WHZTd0xsUEtVVC9mSFhvYTRTZXB3UjZ5T2xHTmhHQjA3VFVSSitvcVBK?=
 =?utf-8?B?bGVwM3VDZGlxd044ek9kTnAyelRYcDRvMTJ0QTFsVUN0YXhuNWtjeFNWWDI5?=
 =?utf-8?B?STZUK2hQakZXaWpobVBZSzVvTnNQVHA0MmxpTjZSQW9odWpuZlJYdWtWVFJR?=
 =?utf-8?B?VFhqaGxEU1hYTEd0SDUyNGpUOVBudWxLdEhta3BzeERJL1A0dGV4dzcwTC9L?=
 =?utf-8?B?VGJFMThtS0dxMEV4RVdiMzNsOUU4NU5QcEc0WWl2bGthVmxQWkVNc0hBVkNz?=
 =?utf-8?B?MU1BNW9QV2l5SzdndVJjdzFzTE9tMTlSOHBTKzFBOW1nUkhqRlpDeUhrQ0Jw?=
 =?utf-8?B?enpKcTJBMTgxc3BnK2lURXdJUk03SUhmSEE4Y3dLc0VrQytxZDJzanF4cDN5?=
 =?utf-8?Q?GkGM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 692895f0-30d3-4751-ce43-08dbb812ff3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 06:46:33.3916
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t1tPcflPRz9sFlxjFoCLtdOqbT9LoKiRoB1GAbOn27N6kRwLsCP0ZTTLHHl4SrDReFKiyFveeIAld43aUiwYkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6728
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH 2/5] virtio: introduce SUSPEND bit in
 device status

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IE1vbmRheSwgU2VwdGVtYmVyIDE4LCAyMDIzIDEyOjA5IFBNDQoNCj4gPiBUaGVyZSBpcyBwYXJl
bnQgb2JqZWN0Lg0KPiA+IFRoZXJlIGlzIFZRIHdoaWNoIHlvdSBwcm9wb3NlIHRvIGRvIFNVU1BF
TkRfUkVTRVQgb2YgdGhlIHBhcmVudCB2aXJ0aW8NCj4gZGV2aWNlIHdoaWNoIGlzIGFscmVhZHkg
U1VTUEVOREVELg0KPiB0aGF0IGlzIHdoeSB3ZSBwbGFuIHRvIGltcGxlbWVudCBhIG5ldyBmZWF0
dXJlIGJpdCB0byBjb250cm9sIHRoaXMgYmVoYXZpb3IuDQo+IA0KSXQgZG9lcyBub3QgbWF0dGVy
IGFkZGluZyBhIGZlYXR1cmUgYml0IHdoZW4gdGhlIHNlbWFudGljcyBpdHNlbGYgaXMgd3Jvbmcu
DQoNCj4gSG93ZXZlciwgaW4gbmV4dCB2ZXJzaW9uLCBhcyBNU1Qgc3VnZ2VzdGVkLCBJIHdpbGwg
Zm9yYmlkIHJlc2V0dGluZyB2cXMgYWZ0ZXINCj4gU1VTUEVORC4NCk9rLiBUaGF0IGlzIGdvb2Qu
DQpJIGdvdCBjb25mdXNlZCB3aXRoIGFib3ZlIHByb3Bvc2VkIGJpdC4NCg==

