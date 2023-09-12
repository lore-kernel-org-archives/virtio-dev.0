Return-Path: <virtio-dev-return-13716-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87A4CA0EC3
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 10:33:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3C89142A6E
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 10:33:24 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 365E8986641
	for <virtio-dev@archiver.kernel.org>; Tue, 12 Sep 2023 10:33:24 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 295B7986485; Tue, 12 Sep 2023 10:33:24 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 161BD98648C;
	Tue, 12 Sep 2023 10:33:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X6hlW+3GfRZgIrYTlqHhiAHEVWOvdKjQm6QzJJtulVGjhO4zdQUuwmyDEm74PdBMLTuFXw8xUPT1jLEXBsrpz0Ev+KY1D1duUQOE+8E2vtJGODnRyd+b3rXoUhKF+yN4KMgHYPSGRnSxz9uhZ52BmZJXV5HzMqtL3yK9bMdLixi0HBpGt3yXc5mIScFI9d2/O8C8XEB98Kq0esS1X2WRzKraGamwBYrc4WPWsmuv7cwGCubSZs7Ouhk4+J/qF0YNTlumZKbtZixy8ZNHfYtW4jiHBmZpUQUYSxfO+NfHKnV2pkMMlYl630We9/KZ5+FZb+Zr6ICD9AB4KEWOiAV+Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuvTVIvaxZRBzTWET/4rIt7fgfmhjcdaj3YhF5eGJwo=;
 b=KMh1yQ6N8HoI7S40JymaXXZq7cCh6YXjqQeFKfVEho2a3Gu2R6E507WvNjarm48lmItOBpaUFf1x/PZCg1QYOE/vpcNov9mAVY5m9BnUxTamp7rQ7xBN6cHbQ8NUlesbdyLweA1JZ9Qwt7DZ/T2pW3MimzPxMKl5gWM+6MHAeVXvA7+fGEQeCKiOfyGIQEK19gwpdfTJUyQMiOxNIK3xta0hyqVOwJNChOEspWusoUccCYqxtLk2dlP/ugbUHGcr7WzA4j00QCuzUHaVdidjJrzVhmnGcipm/VlnygjhD1qHMMTvwdNz6v7pODIj3va1ktk6XIjJ+8/Pm7+IN1b8fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, "eperezma@redhat.com"
	<eperezma@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE
Thread-Index:
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAFrJICAAB38cIAACoIAgAAB5TCAAAzeAIAAAVowgAAud4CAAABSIA==
Date: Tue, 12 Sep 2023 10:33:09 +0000
Message-ID:
 <PH0PR12MB54817178B8D5799FE74D4331DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-6-lingshan.zhu@intel.com>
 <20230906043016-mutt-send-email-mst@kernel.org>
 <CACGkMEu4R_nUFmpoNesmjJ-PtoE5brpWh8NLruWhEWycm2K4yg@mail.gmail.com>
 <PH0PR12MB5481A50B1B13CE1756B98D0DDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMmwWGJDYe5BLvLCcetThv-yfPR2QbphNuuh+bp-+ikg@mail.gmail.com>
 <PH0PR12MB5481ED8DC23DC6D42665FB8EDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEt9ATuU_OwtE_9rF1XHKCd9GavWCHx6_dFXCZibMKzJjA@mail.gmail.com>
 <PH0PR12MB5481D538B4F3F76B393C5757DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <7cc22be6-f984-ba53-5979-0306a118a6df@intel.com>
 <PH0PR12MB5481961B5EA6DEE900CCF068DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5449424a-4872-0164-0c3f-caa34ad46388@intel.com>
 <PH0PR12MB5481CBCF7BEE5637D16BC179DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <4c4c2478-c90b-fb5b-cc06-bc74293862b9@intel.com>
In-Reply-To: <4c4c2478-c90b-fb5b-cc06-bc74293862b9@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS7PR12MB6335:EE_
x-ms-office365-filtering-correlation-id: 9ca717d3-b704-4291-a079-08dbb37ba8f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 GAnLLBrkt/vWRz++9/+WJiY1gMDeNp/XRaFtlzLj4AUyvudGfyKXh5Ddgk91pJUdGylNUPteX5+NUzL1qwl/9VWKbgXujjTsp+dMB9HT+ODviHW6/ddBwRzyEf7oaDDiyNneypcxo6RTkphZ/Z1IgnG4Aa2Iv4bu6I9bqmzpU66uXUtgMbyJO+qNbCrKd+S1p3i/gO5EABgBb7JQRQCzLaEXntw1uJb3/HYfPDTVCDjHyY4yUSyN2eY8KVDjbUpXjnxM/cBwLBB52C5FUHMRzylzLose9QxHvwcNHHbjIE3j0czPv/0ly1VNmS+0R+8TM/UHZd0hngh4WQzsYS9o74Qe132BCyc1k8hpzc4LHEXwgCyQfj7j/dYx4nm6BWgIV2MID18ojm7/CWkAeEDAjobUn4DIuFbOSnRQsTaBNSAyGlue1LcEbQ2eMieup7cxkUAIeU2slxGSUINDXljCDjHMtw0S+J1hkZOAV+cXWBPY45EY32Rfp5bF9U0tvrjtRgubAQWekf44g81QvI07WwKqGdxkZyAAwynrq6nCdZru9O/DlVfcP3locg1MVnCnVh9eJR52lLJEqd8ASlJbzcjTwks/ByWUF6CdMiqlBPodQv7iNWp3oD4l6DHF8W3QKWomstFpGYO1MPquGqZ2CA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199024)(186009)(1800799009)(5660300002)(52536014)(66946007)(41300700001)(316002)(54906003)(66446008)(8676002)(4326008)(66476007)(8936002)(64756008)(66556008)(110136005)(76116006)(122000001)(478600001)(966005)(45080400002)(38100700002)(71200400001)(6506007)(7696005)(4744005)(86362001)(2906002)(26005)(38070700005)(33656002)(9686003)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OXltRjFDbGFqWnVoVXFJalhhWVhPK0JjNEIyYkVIWWd6dS9jd3lEYXJBcVZV?=
 =?utf-8?B?L0QvS3lSbC9zcU9nK1V1U3FJZFNXcEpOYVdXem1Qa3lsaG1ueTdpajh6NjNT?=
 =?utf-8?B?emE2SUVtWkNITzZoTzVabzJqRHRRN3hrc3h5UXZhbUpweDhpTGNlbWpSRkdQ?=
 =?utf-8?B?VzhCTCthS1VYRnhtMVBWWDU1NHQzaTBuQ1d4U0xiS3puajV4d0pPdGdKcGZ4?=
 =?utf-8?B?dzBDek9BY0Q5K2tZc1dHeGpVRW8wYktpQmp1SlpybjAvUnBwQVVBV3RhWktH?=
 =?utf-8?B?akc3RkRvQXIxdElKN01jUjh2OWdzWDcrUzBRYXBwSmZvSENHMWQ3dWFrck53?=
 =?utf-8?B?b09UdElpSlU3QmJNYWRKSnZlR3hnTXVXcTVXbjJLOForVXZrcm13dlNCbW96?=
 =?utf-8?B?ZUw1YVlqSDVOSTF0TjRIS2w1Zk5IcnYzcEtKVFNsRFVCbXMxZ2huL3RreFFX?=
 =?utf-8?B?dWR3MDR6dDRyc0RLWllrVEZpcXk1U0FYYmF5NTNwWENrdEl4RGZ3WDBJdVFm?=
 =?utf-8?B?R3oyWGNuQ0Jja0NlOE51dW0va3ZLUUhXRTg4eThpYmZKcHE2NzB2YmozQXpI?=
 =?utf-8?B?dGF5ZW1XVkpQS0xiRUVNdm00TEdhUTRyTjJSWUtjYisxam0vMzFTZWJBM3l0?=
 =?utf-8?B?OHdTa1RLbW14MFRDVUxqOGdLbGJ1d2ZaWU5XblAycjFMVEVTWS9yYkJUbmN0?=
 =?utf-8?B?dzdzR3BRUVE5YVBZOFdQRHYzb0Z6RnY3a3VPb2hxRTg5djBkZ3JJV2tLNFNT?=
 =?utf-8?B?MUlQWUtYRWNkbmFFUzZHL2xpb0M2T0xBN1ZvVFNkdzhOVElyVUN2VjJMUjdO?=
 =?utf-8?B?alJrZ1hvdWdHaEl5YmJrOGpQQU5sWXYzTkp0OVB4OTBiSHhlTFdtYTF5VUFh?=
 =?utf-8?B?WmpHbHhSbk9UeFlKSktZTXVIc2MyUmVIRDNPUG1GT0Vwc1NpZlNNUE5mZE44?=
 =?utf-8?B?cHhuQUlScEdUTWdOVXJENWd3SmRYRk9udlFPbGRxU3IxV3Rwald5SURxblNm?=
 =?utf-8?B?SjlZVi9wSHNJQXVMSHFwVlJyN1BsNkdudGd5QWN6TEZFdEZTbkJOQ24wR0Fl?=
 =?utf-8?B?enA5WVZKUXVPNWswN0dhT2VJV01TSzFlQUNmTHYrMHZlUTZnTDVaa2ZvZjRq?=
 =?utf-8?B?eFpJMy9VeGREWXJGdnRZcVVlT0R0S2lWeGhHcnZ0a3lUb3lsUXN5aXJZOVoz?=
 =?utf-8?B?QnNsellqTGY3bEw3bnIyOVpjWUNyUFFKSGIvZXM1bnVHNEV6Y3FaK2RRMjZ6?=
 =?utf-8?B?aXFmdkhRdThQMWZSVFdWY1oxSW82MjgxWnlVRzZTRTUzNWxPQXVWRHhnVzQ2?=
 =?utf-8?B?bmlaYkJjRWFwc0pSejdzWWZqSnpaWEw5bExpQWs5RUFBdnFpbVM4ald1L0RE?=
 =?utf-8?B?azVLeDRoOVFIdTRJWGtaWFhvclNtNy9KNFVnM1BETU41U0U4UWc3RVk1OUw5?=
 =?utf-8?B?Yy9GUkFWUjNuWWtTWTRGTEFGMVVvUmp0Z21sb2hMSjc4NndFRitxV2ZzV0lY?=
 =?utf-8?B?Rm5BcThjMEpOSFJadGpaOE1SZThaSkNjY04yRGtkM0g1Tk51aTZBeEFEbDY2?=
 =?utf-8?B?QkJxZVdFOGh4N0hXU1Y5bENIYlVjb3hTQWxMcndDY3BMTlIrMmJKbWpBMkdv?=
 =?utf-8?B?TFRpcFNQbHVKeU5Id0JmL1BuR0YraUI0Tlcxb0N0RlRnVGNScUE0Mk9LVTRK?=
 =?utf-8?B?TWhQQkRjeHZQTUYxeVJiUnl2NXdrRkZsdG8wVk1MblRaN2cyTUYzSXVCUGUr?=
 =?utf-8?B?OVVyMTN2MUE0MERsb2lyM0lJait5WHNtTzNma2I2S0thSEJUTEd5V3E4Y0x4?=
 =?utf-8?B?SHQ4a1lDNytGZ3lnK29XajUwZnp5cmRlQUMyUXJPclp0VHNRTHgxdG0vczM1?=
 =?utf-8?B?cWF6ekErSE5JSXdqOFp6dGhuZUtZRzdtYkxSK2hhUk4vcWI5THVzWnN2WDl2?=
 =?utf-8?B?a2N2U3IwTkxVMkFxSEJFaCs4RXFiSTcvVUtUL3c0SkF0cmFTR2YxTmErbXcz?=
 =?utf-8?B?a1JrcDUrQTF5MWZRc0M3a2lDL2o2QWo0RktlVXA1VVorc3huamdMcEptNzZF?=
 =?utf-8?B?M0ErNWxNMmhMUnZ6Z2hEQWhjV3ZqNWFreVNGWHNINlZzVE1OcnVTNVljK3FB?=
 =?utf-8?Q?IieI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca717d3-b704-4291-a079-08dbb37ba8f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 10:33:09.9641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m/2nVSuHjD6Icr1RTRLrKlvNxfvvSR8M7OrbLF9KJj4KyZV8hCkVg6YYbh7ehbOs1cYeoPGxAoaWsquoBd1TCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6335
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

DQo+IEZyb206IHZpcnRpby1jb21tZW50QGxpc3RzLm9hc2lzLW9wZW4ub3JnIDx2aXJ0aW8tY29t
bWVudEBsaXN0cy5vYXNpcy0NCj4gb3Blbi5vcmc+IE9uIEJlaGFsZiBPZiBaaHUsIExpbmdzaGFu
DQo+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAxMiwgMjAyMyAzOjU3IFBNDQoNCj4gPiBJdCBp
cyB0aGUgYmFzZSBsaW5lIGltcGxlbWVudGF0aW9uIG9mIGxlYWRpbmcgT1Mgc3VjaCBhcyBMaW51
eCBrZXJuZWwuDQo+ID4NCj4gPiBEZWNhZGUgbWF0dXJlIHN0YWNrIGxpa2UgdmZpbyByZWNvbW1l
bmRzIHN1cHBvcnQgZm9yIHAycCBhcyBiYXNlIGxpbmUNCj4gd2l0aG91dCB3aGljaCBtdWx0aXBs
ZSBkZXZpY2VzIG1pZ3JhdGlvbiBjYW4gZmFpbCBhcyBoeXBlcnZpc29yIGhhcyBubw0KPiBrbm93
bGVkZ2UgaWYgdHdvIGRldmljZXMgYXJlIGludGVyYWN0aW5nIG9yIG5vdC4NCj4gPg0KPiA+IFsx
XQ0KPiA+IGh0dHBzOi8vbGlzdHMub2FzaXMtb3Blbi5vcmcvYXJjaGl2ZXMvdmlydGlvLWNvbW1l
bnQvMjAyMzA5L21zZzAwMDcxLmgNCj4gPiB0bWwNCj4gc3RpbGwsIHdoeSBkbyB5b3UgdGhpbmsg
UDJQIGlzIGEgY29uY2VybiBvZiBsaXZlIG1pZ3JhdGlvbj8gT3Igd2h5IGRvIHlvdSB0aGluaw0K
PiBMaXZlIE1pZ3JhdGlvbiBzaG91bGQgaW1wbGVtZW50IHNwZWNpYWwgc3VwcG9ydCBmb3IgUDJQ
Pw0KDQpJdCBpcyBiZWNhdXNlIHAycCBuZWVkcyB0byB3b3JrIHdpdGggbGl2ZSBtaWdyYXRpb24u
DQpZb3UgcHJvYmFibHkgbWlzc2VkIHRoZSByZXNwb25zZS4NCkkgYW5zd2VyZWQgYmVmb3JlIGF0
IFsxXS4NCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3ZpcnRpby1jb21tZW50L1BIMFBS
MTJNQjU0ODE5NjFCNUVBNkRFRTkwMENDRjA2OERDRjFBQFBIMFBSMTJNQjU0ODEubmFtcHJkMTIu
cHJvZC5vdXRsb29rLmNvbS8NCg0K

