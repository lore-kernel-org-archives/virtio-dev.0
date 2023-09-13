Return-Path: <virtio-dev-return-13744-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3653EEB590
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:46:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 27D1E42C2E
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:46:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 197BA986677
	for <virtio-dev@archiver.kernel.org>; Wed, 13 Sep 2023 04:46:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0D47D986650; Wed, 13 Sep 2023 04:46:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F23EF986630;
	Wed, 13 Sep 2023 04:46:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NVe2jo7pNzsVByHp9V02D6y/dRuCrVoUA6FtgwcLBfLuICmvbOIcrfTepalYIU+OLMwLRglv7kW5UgQkya8RO+MTllOXXVN52Vbf9eQxLnzB9PAfEFyXhMsgtLAzLLT52kWoJ/IbS1U5wiLa5kGx4F5djd8Vfl8CgBNYdosVu+169CJfbIo6RBokxvOZBK/Pu69KpMKMrs+he7uS6HfRib36jukW0keZfp+gcokirw21K3bi3JX3UYms+j63KFkkcHKTGMtpe4rIzJhkoWqa1nuyplTgWxhf6WztANEuP6WrcAriG4JwP8iVmtTLb/rgdvCHcpZkzAvjm8tVKAhNiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1VVeBqH8l+EKHyQ1k66zMVKn8uPrFBW6X1UiRyUWXY=;
 b=GZs0Ry1QPy4W+8IcOFJzBYbT34lvBiS538COnL1755JHceDumMV5gTaiXnzeGkznVQtC217i/1ck3mWorpRtQrfh6gOPxn/mDsnFyALvZx9t6dlxlNuWeO1s01qdeCRXAYwbucHD2jpMVhHVocv2FhmeUwAjJzb0qQO5IDtNaXAWrkl0sCZo3ZoPfWR23YOK0SMH4RyXOFFl0Of3ozcsvYLaWVFuUWO1BPIRf5968hLfKiMXMuHuD3GCAQeX0IngBmMTHYgTuY2xGf26fF+w7Au3flWframfC939bg26By2F+tPxV1pNOsG+Z8EXl1PKLZJ6hevwbMRBF9lqgz4OWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jason Wang <jasowang@redhat.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>, Zhu Lingshan
	<lingshan.zhu@intel.com>, "eperezma@redhat.com" <eperezma@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "stefanha@redhat.com"
	<stefanha@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>
Thread-Topic: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE
Thread-Index:
 AQHZ4JzDvq0yIsiJnUeYIlWmAxqqv7AU9yyAgAASRHCAAChCgIAAAkbQgAFrJICAAB38cIABe3mAgAAAQYA=
Date: Wed, 13 Sep 2023 04:46:25 +0000
Message-ID:
 <PH0PR12MB54811C3EC1618E413695D8FDDCF0A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-6-lingshan.zhu@intel.com>
 <20230906043016-mutt-send-email-mst@kernel.org>
 <CACGkMEu4R_nUFmpoNesmjJ-PtoE5brpWh8NLruWhEWycm2K4yg@mail.gmail.com>
 <PH0PR12MB5481A50B1B13CE1756B98D0DDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtMmwWGJDYe5BLvLCcetThv-yfPR2QbphNuuh+bp-+ikg@mail.gmail.com>
 <PH0PR12MB5481ED8DC23DC6D42665FB8EDCF2A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEt9ATuU_OwtE_9rF1XHKCd9GavWCHx6_dFXCZibMKzJjA@mail.gmail.com>
 <PH0PR12MB5481D538B4F3F76B393C5757DCF1A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEs+5AjGzeDbWZYSkOMw65d6g6oDfgbOapa1G3EbtLUy7A@mail.gmail.com>
In-Reply-To:
 <CACGkMEs+5AjGzeDbWZYSkOMw65d6g6oDfgbOapa1G3EbtLUy7A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL0PR12MB4915:EE_
x-ms-office365-filtering-correlation-id: 4a696f53-d996-4f91-d28f-08dbb414631f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 L/kczd1gnbjVk2K3NJX6x9PUV76ewps3tdr41STag6WjjmiYqffbtEg3u3rL5cPDhyvF3kNh+gwdNK+QZMdOiVMh70Ns6ZB554QMObyJOlUP62+LRp/dWOpuVBZIyWo6LtN4o3Fn1OyPID9cio9Efzz+O1p6LDPZenksyiPJ+DH4B3SUYGOpuaqRFjJ/CKqRuGMnRz/1Rqm9EN5R2uIZYZ9cyJXd8X/FaSryzrx62iXxX3Lxq1+L9s5pG3Z4MOXqxuHHUKi9fDcLp4d1ETXDzPZSlfivfg8VVd16nL+b/gTZrH5KvyOLN4r0n13TqC/pSC9RB5o1qIxST40HwdqOByIIsP5IYdAW0ii1pRFRyO7HT07683IIg+j3y9/wJ6ddrPn7NculbLPmsl0mAksO1KeaL7cywwrSb3IlK2cwiCziLQwT9tJYzoHOcsQfr8IVmvRKqeYk8m+WhtuKXLze07GasTYDPdJgL2Sma3q0sdNfUNBtOd7hwg7fLqpZmn3f33AbHqC/5FLv2kGINp6Lkp0XewCAZ9rSZCFVRd62fdErktJSHWWHbYbgl/KlMg3IY7xJpf3xwuEBHSCCL5RWuSit2AyjuZZMc1swWlTPvFbklkCPuRHzXPqwx75ltD6x
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(366004)(376002)(136003)(186009)(451199024)(1800799009)(8936002)(26005)(6506007)(55016003)(316002)(54906003)(64756008)(66556008)(6916009)(66476007)(66446008)(478600001)(66946007)(76116006)(2906002)(4744005)(38100700002)(38070700005)(122000001)(86362001)(8676002)(4326008)(41300700001)(52536014)(5660300002)(9686003)(71200400001)(7696005)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eGIweGRLbUdzZmp1bzhqVUxoOGR3RGxLOHEzUk96dVBXdVdYVlJrd0E3am9O?=
 =?utf-8?B?Q0E3alM2WStLV05FdVlnR211ZFRLTm5pOHZkV0xIS3JOOTVqYVJ1RVh1K3Bo?=
 =?utf-8?B?aVlzL1VaNm1lNDAwQ21BRkNkcU8xUXdhR3kzeWszWXhYUENuMWI3dDdaLytY?=
 =?utf-8?B?VDhkcE5pMlNLdjVuWkVaVWNSL3F0V0NQa0hRNUlqUW91Rk5JK09wVUVrL3hF?=
 =?utf-8?B?c1c5SVFOSU9CenBKZ0JXWWYySzFLc1FJeXdBQXVCa09zeVNvNTEwelJIa2VS?=
 =?utf-8?B?cWI1bjZXYWNncW0rc0svNGt4UWVtQlNZelVoNUFONnR1WVM2Qm0xb0FLNTBm?=
 =?utf-8?B?elppQVdLUzR6S0J4MitCNnk2MTBtVlVYYzF5TFE1eFZMU0dmMWtLRlZNQk5n?=
 =?utf-8?B?OGN4bUlDYitEZ2VPeDQzMDExdW8zMGpWSVF5K21oSXRKOUUyM09SQWJWZG9V?=
 =?utf-8?B?M3FITDhOandMdUx1Q1JIUmJScVhYWFRSK2twV0EvbGZZMHE3R1RtWFNQVjJF?=
 =?utf-8?B?ekhIN0kvcG1qSUFPUDY2ZmlRVDZ6b2tocko4b0VCYS80M3NIamtxUGUyTnE2?=
 =?utf-8?B?Z3krRUVUR296eWVhYS90TTg5ekNhNkwwbjFka05wUUNUOW5ldEVmVS80cFV1?=
 =?utf-8?B?UkswVjhNM0Q2RDVJR3FtYjVPT3o3RVVhOGZRK2s2ZU85M0hIYyswcVVkeWFv?=
 =?utf-8?B?MWtMcDEzbmRYeUJWNm8vTHlURGxJczRGS3RDaVR2bnUxUWw2TjE2SXJyTDJE?=
 =?utf-8?B?VnhNWUc3RGVSenR0T0ZoZGpLRHBxdGpNN3BqSm94UHZnRjJrT3NpQWRoSmg2?=
 =?utf-8?B?ZnZRYmNZZWY2eGZMTE1jOERzZGVvdE9tZWxRVVRWVy9ucE1tbGRRVDlhcEZP?=
 =?utf-8?B?TnBSbW94NGxXUDFCZFhnU3FDaXZJV2lpMk9CNytiVDRzZGJ5ZTI2OEg2WTJQ?=
 =?utf-8?B?YTMxUGNtWmxXZW1YUUVoVUdqRXlSSnZySmhTaElvVFZZWTZ2NVZhZ1I3a2Zw?=
 =?utf-8?B?OUFVbGkxcjlpZVo4RW40TGQwRElnZ08xdlZzOWlucU44aTB6UmlLZzQ2VjZz?=
 =?utf-8?B?RDRqMUl2a3RTWnh2K0s5TzFFOGpkZWl6OXVMOG0yRkJnSDQ2WkdZU2U4UWhH?=
 =?utf-8?B?RFpoOGMzY0F4TFNlcEFHNDNjOHhwY3Q5QXVJMmU0QmRkbDUyUWM3MU44bTlR?=
 =?utf-8?B?TTlUeTF2S1ZESkZTbWhQTitrVW9VT0llQWFTN0h4UGR1OFp4ejQ5cm90RDJ0?=
 =?utf-8?B?R09sN1pvSVl1SEdpR3BWTWc3aldPcVNSNE1BZ2k5QnRBVlF5cnl3dWZsalpI?=
 =?utf-8?B?cHBEVW9ndkdUK1psbUl5Nmh1NVhJZVdUTG9kc0hIU0ZiUE51L05RM0MxWkJr?=
 =?utf-8?B?ZWxIUWZjSWdKVk1ZWmQ2amIzTHRnMURtYTU5cEhBaXF6RlpWZEgwU2RERlpW?=
 =?utf-8?B?YXBnU0x5djZ1cGkrZytrZUZvbEZhRTBMTHZ1aW44YnowbDZCajhSZE9KMkpl?=
 =?utf-8?B?OXUxLzhMYVJFZExGd21ROTByN3dGSWU4VktqQXNDM044OXZTNVQ2clNub1Ru?=
 =?utf-8?B?Q05ZdmJNN09hY3dCL3kwQzkrOVRNdXdCd1dGZUdhOTVkb0NIUitSZ0tJMHdw?=
 =?utf-8?B?aE9hQVlLZ3hvSEYwQ20rSkdFVm5kQ2E5di9wOW9FREhiQmZIaHpjRGpNVTBD?=
 =?utf-8?B?UEx4WUtYdzZRYThrQ1o0WFhEYmZIRXl2ZE1BVjNkVlhsSVBCS0FZSEo2aW5W?=
 =?utf-8?B?K0ZaV2VrWmhWRjNCN1VEb1JpVUdkTWpLRlFCbGs1TmMvT0hYL0YybDVTbU1M?=
 =?utf-8?B?K0dUUDZ6NitZeUlMY0FVOUMzRDh0ZWJZU0xIeFNWYkJDcXR5eVNCQTI0S1k3?=
 =?utf-8?B?cW9ZQXpPSkkvcGVBcU8rWnBGWmVhMW40N2ZDWkVJT0dKUEEyeFN0QVNqZ0tR?=
 =?utf-8?B?QnBpd2QzeXQyQnZNbSswMVZ2QUhnZkJGME9RYkNtSkVMa1BLMjM1YmQ1TEFD?=
 =?utf-8?B?b2V3NDMrVlFQTWFmVVQ5VlNYOWVhSjNPL2FZUDZjWkFBQ080ZGxsc012RDd3?=
 =?utf-8?B?YjNhQWlRdm9MZXF3ZStCSW84UjRaaTk3aEQ1VGpDUS8xQmZibW95R1ZsZ05B?=
 =?utf-8?Q?JcYo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a696f53-d996-4f91-d28f-08dbb414631f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 04:46:25.7825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oi+c06AJXecxj6uCOIJkFKkYFvaR7NGQG9X8vG2HMuTki78imrcmhrsfNjn9WA3Zg7eA/M7hMVBrCtYfVBk9Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4915
Subject: [virtio-dev] RE: [virtio-comment] [PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

PiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiBTZW50OiBXZWRuZXNk
YXksIFNlcHRlbWJlciAxMywgMjAyMyAxMDoxNCBBTQ0KDQo+IEl0J3Mgbm90IGFib3V0IGhvdyBt
YW55IHN0YXRlcyBpbiBhIHNpbmdsZSBzdGF0ZSBtYWNoaW5lLCBpdCdzIGFib3V0IGhvdyBtYW55
DQo+IHN0YXRlIG1hY2hpbmVzIHRoYXQgZXhpc3QgZm9yIGRldmljZSBzdGF0dXMuIEhhdmluZyBt
b3JlIHRoYW4gb25lIGNyZWF0ZXMgYmlnDQo+IG9ic3RhY2xlcyBhbmQgY29tcGxleGl0eSBpbiB0
aGUgZGV2aWNlLiBZb3UgbmVlZCB0byBkZWZpbmUgdGhlIGludGVyYWN0aW9uIG9mDQo+IGVhY2gg
c3RhdGUgb3RoZXJ3aXNlIHlvdSBsZWF2ZSB1bmRlZmluZWQgYmVoYXZpb3Vycy4NClRoZSBkZXZp
Y2UgbW9kZSBoYXMgemVybyByZWxhdGlvbiB0byB0aGUgZGV2aWNlIHN0YXR1cy4gSXQgZG9lcyBu
b3QgbWVzcyB3aXRoIGl0IGF0IGFsbC4NCkluIGZhY3QgdGhlIG5ldyBiaXRzIGluIGRldmljZSBz
dGF0dXMgaXMgbWFraW5nIGl0IG1vcmUgY29tcGxleCBmb3IgdGhlIGRldmljZSB0byBoYW5kbGUu
DQo=

