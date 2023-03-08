Return-Path: <virtio-dev-return-11536-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A471C678D5
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 16:21:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 35D1A33098
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 16:21:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2E3DB98671C
	for <virtio-dev@archiver.kernel.org>; Wed,  8 Mar 2023 16:21:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 224639866F0; Wed,  8 Mar 2023 16:21:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0CD269866F1;
	Wed,  8 Mar 2023 16:21:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDyAX/8rvpUVw0Am/JLJNYQ3P9tOKc/y5F8PbfQFJAwzmAh0U7bnWTHpWYgMUeafJnGcxIay9aiNihojtq2oOeXyV4mBZ7F1FR6xCEMzMfRJyOLQoYWEo95g/pSqNaUxeZH8l3RCFBbXBklvd69agK96/j46U1od4qzOf47k87B5fdVDE1AOJYO9e9LVvvZmQfSkmNvHrKwDCe4UHqESWlKBL4HkxmkQMSKIPvm0drgmSbRGIS+dNRwwo2p96KawCHppbrQCf6r3B6Osv1qS9GjnGTbkDuxVv5wkWUHxc33SQAe4JCRvkCaBdX8f2zeeFVoRDPZCC7mbc7nrlvhgDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9TxqcofV5JPQMPACKXJAz4bcuxtWcFxFDY0pJwobAdo=;
 b=IE3X0OqnmWHYSw4Mjzo0k0BJIPILFkzd+7fg3IR4rhtlP/vZdWmZ16SZH2+9MmaNlL0u/waandVFpYnG6Ov9+ONnGRuPUWkbsFCPnQBhdTHAG0M7Rw0N3Q5vmueY0Q92Bs2INnRmwGxLB3IbWX2iJggw7UYFVoKt9a6c6DexT2xRXYpRBDlW0YbuOmmjMqyxvh1WeS+t8hcarJpRq3tz9XFd2Qm2S/KHfiJynIdFNY4z4N3CMFHsuygqhpoBw58A1mQ2rGgv3szL4jSdKcMjQobr8dxT2MjBaNEyClVmxk1PL2LrqmMRx10fCLG/zBxxxsRRREdlN/Kn4g47Wi6ZtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
CC: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>, "nrupal.jani@intel.com"
	<nrupal.jani@intel.com>, "Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>, "virtio@lists.oasis-open.org"
	<virtio@lists.oasis-open.org>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [virtio-comment] Re: [virtio] Re: [PATCH v10 04/10] admin:
 introduce virtio admin virtqueues
Thread-Index:
 AQHZTQegoqm3ZFh/hkOgShx3CSU6867n9EmAgAA5TwCAAOB7AIAAAnmAgABw4oCAAnEigIAA8WoAgACFfwCAADfJAIAARSqAgAAQFwCAAs6VgIAAMRqAgAAjw+A=
Date: Wed, 8 Mar 2023 16:21:38 +0000
Message-ID:
 <PH0PR12MB548190874CCBE4679073738BDCB49@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230303132840.GC2866370@fedora>
 <20230303083213-mutt-send-email-mst@kernel.org>
 <20230303202133.GA2901137@fedora>
 <20230305043419-mutt-send-email-mst@kernel.org>
 <20230306000302.GA244754@fedora>
 <7f63fa0a-7deb-5875-6c6b-bfc651681653@redhat.com>
 <20230306112030.GB35392@fedora>
 <853c78d0-f752-05e9-d79d-811e82801627@nvidia.com>
 <20230306162538.GA56760@fedora>
 <e74483a4-38fa-99b5-86b8-785f0b98d029@nvidia.com>
 <20230308141317.GC299426@fedora>
In-Reply-To: <20230308141317.GC299426@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL1PR12MB5286:EE_
x-ms-office365-filtering-correlation-id: 18a62649-1d15-40c3-71c7-08db1ff131ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kShp7TpJ8kzzsql/qFVFnxSejcsQcJBD/BBDuR+NXLO4Y22fEEHuybl2n558J0MtYeVtjTG1qjR1A5F14RlEYBu61Lzdy5Ub91/eIkXRXfXybXicSRi37ruFP5VDSL08xWWkBxScFxohYYMbz5DRnE31+3ZtSYt+3DYK5IwARFSxBUYlJGRn9J+e3X4dNVPs44gjwtDB6qo53GC8J0An8DMfns+l8amtbahzzSscRjQ4RS8HC/3gSUBAnWR2oW/N3pSX+gudUo0BxFiNaC8lGtNmWVUJpfKSg62suUo4qNHLEjssTdh4Edz9TgM3duBYBJtMnaYY+laCXp5U43UjCSNBUrthw+AG196YIHeG8G98Ms0xtUXmudMENYmdy82Kj4SquAjoe7vo/pSENeAUYBCKU9QKfShL403mZhaR4ZjpFNDr30HfKKADz/4J8aMdyjAENqnkoF3j5m2oJWwcTRQZkWQfSYEvvGt5uLJCWWB2aZP5RPZgv/+m2Af/iz4Qo7EFxypiy/gtCLuXSUHz3lQw7XzyzVY8h9K12dtVmIciZztaJoROiLhDhgKMRSC7btjb1I/vsOBzPsq4zty4854iSnbEVHNoHtBQSRl95xd9U16NDS6pioudoZ94Bi26IJMn7t+73Rz+fKEZhdO/jokOQXlu/AtTYISn5iVge393TrAP1Y2lktuT9ntzIuE+fEImwYaRw8c4Da6CC/ijQw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(396003)(346002)(366004)(451199018)(8676002)(8936002)(122000001)(66556008)(66476007)(41300700001)(66446008)(66946007)(76116006)(4326008)(2906002)(5660300002)(7416002)(64756008)(33656002)(38100700002)(558084003)(86362001)(38070700005)(26005)(71200400001)(7696005)(6506007)(54906003)(6636002)(478600001)(55016003)(316002)(110136005)(107886003)(52536014)(83380400001)(186003)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TFdkNnYyRFVjOHUxaVpBWFlkMndCZ1pIK1BnaDc4RTZTQlBMNk43Ymc2aDVp?=
 =?utf-8?B?NHV5NExoVSt6TmdDYUEwUFlOalMrUFM2cGphb3BQa1c5ekdqL1l6ZCtkcjh5?=
 =?utf-8?B?aDBxZzh2dHFhck10T1B4ZE9HdUtTOFJISE1UNTBjeWEwcGdwZGhJUW13clJY?=
 =?utf-8?B?U2xyRW1lTWp0U2x3RUdxUFhxN0czRDB5L20zZU44WUtUV204YTZWeUNwbmEr?=
 =?utf-8?B?MHJyOWRLc0tWd3I5OWRMNzF0ZTZQd3ZWUU1XaW9wWmx6WkxHUDdmZ1FJcFdJ?=
 =?utf-8?B?ZW51QlhIK3pSN3pHazlFbENidkxQaDlSMkZlbnl2aEVxdmpRR3lza2dTcVNI?=
 =?utf-8?B?aGViNUdsQW41aDRvWUEwU3BXRUJ6QzFGSkZ6cXppcDBEc2hjbmhxbXRIQjhw?=
 =?utf-8?B?alFlVTk0enVwbDF4QVd5MnhvNVdNSndabFdXSWQ2S2RvUExuL05saGtCSGUw?=
 =?utf-8?B?RUR5K0hMbkc3ci9UM1RaUjMwMjhUV1BvcUY2V1hyMUZIKy9XL0tVOXdLWDFk?=
 =?utf-8?B?YnVhL0Z4aThsOTZaQ1l0a01xdmZjcmdRS1VXRm9WWWZGRXR1TENVMU1HbzVY?=
 =?utf-8?B?alhVSkJjalJPRnVDTkZtNXYzWVNhM3lEZXhDamwybGxFSDM3RU8wT3AvL3lq?=
 =?utf-8?B?YjlydjlJNnhXOWJtL1VZOHpuZFJzT2ZLS1JGU2VJU1huMHFuZEo3OG52UHlR?=
 =?utf-8?B?VnhXOUpkYS9uRHdIdzNiNEJpWWVOaGVlZ1JpbUNuTHRWSzN4MGRYZDBCY0Uw?=
 =?utf-8?B?VVJuTGZSd1RGQkhaMzhkMVVkWXFyemhlTVoyZHZCemFnZW1zb0ZjbmR0VCs1?=
 =?utf-8?B?TGRTa3JNWFJ0SHNtNnhMellxdENEVndhTE9SWlFrRnZRM0lKSDh4TDVFSkNX?=
 =?utf-8?B?NmFWZVlZYXpSUWtxZkhFdklldG5xaURpWi9rRFBoaWZRUGgrU0VQT2RKZlln?=
 =?utf-8?B?T3pTRDd1S1lZczFYdnhML2RUejhHOGd6cEQwWWVEMzc0eXJ3T1lTVW5GT3pa?=
 =?utf-8?B?WDdVMW1KckFmdUQ0ZmNyTDk3SFVUYmJZMXVHM2N2TUxXSVU3TWszOUEzbVNW?=
 =?utf-8?B?dVJnOExueEpDRmZ4MkY3K2hxZkMra1ZObVdjRy9FZklrZFV5cXZBNzJZUXEy?=
 =?utf-8?B?Y0VNRkExV3FqTk5rdEtmS2VMUjVBQVNibStWeklMa3dRMjRTeUltMXpBMXR0?=
 =?utf-8?B?SXYyMnF6bVhObjFtNDI5YURwNWNDSE9CcGFDMnQ0UjVlak9WcTdtdUcrc09i?=
 =?utf-8?B?WEQwVUhsNEJMUEUxTmFmQ0RMRGEvOHVrNVJCOVJXdnNJSUVGd3h0K3FjSVo5?=
 =?utf-8?B?R0owanRIN0UxVWg0SjJXVlMzaU1sSUVLMFZLOUtteFc2SGVJYVdmN2xmcWlr?=
 =?utf-8?B?NVFJcm1jdUxOSWVmR2lYUUlBZGhYM0JVZFUvdGNWaTdjcThKYW5CVFZXeFVx?=
 =?utf-8?B?SHk5WXZwdUwra2ExVy9qZzN2MTVIZnFqUWlUL2VRUVFST2M0dXBiWFhRd1Np?=
 =?utf-8?B?UEtxenUxRW5WeXVGVFhKZVVtTG9ub21BekRtc3VFU1FKR25yckkrVzRkM1cw?=
 =?utf-8?B?K0NiazBKTXNOdW1wWmtHa2s0ZnZGa1hjcWhBVzJheDczaXVUV21GeVJmdFZU?=
 =?utf-8?B?cFlhLzU0bW1HeHFZTzFHRXdwaW5GUnhqckxLbWxzSE1oYTJxc2IwSHdzdnZ6?=
 =?utf-8?B?MkdlTklGVmw0Z0puL2FHamJScElXYlhCOFMzemVPV1I1amY1Y1lwS0RGeWxM?=
 =?utf-8?B?MGtYTnY4NzlVRTc2UmczV1lJeWJQNzVtOHk3eVRrMG5OR1pPQnBSbG1hV1Vq?=
 =?utf-8?B?SERqc3lyS1BNSS9ONXJDcGthaGoyOStDR0hxOWZzYWk0dzN6d3JQeHdWcThS?=
 =?utf-8?B?aTZGeTlBbDdpQzdLSE9BMWVnV0ZpcVpBdGFXVVhkMlUzTGVkZkpEUVVZZFJH?=
 =?utf-8?B?ZE82ZkxDR1phWWdBZjFuNHBESHhIMVVtUHZpM3d3dklKUDEzakdCSXAzY3NS?=
 =?utf-8?B?SStEWFVSVDdZMHFMU2dqWllXRzNWbmdicUlHV0FCSGtDUFVKaUViL0JzaThU?=
 =?utf-8?B?MC9UdHlzNmVxVnhvTkZrZ2M0ak5Sb1ROdVJ2d1dlWHBqdFYxMkplLzFPcjhS?=
 =?utf-8?Q?wG7Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a62649-1d15-40c3-71c7-08db1ff131ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2023 16:21:38.7943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xo/4MsHewlPr58ibXwynk7fJjR1vr+zYD6KZYdLSOMTVQhg+p/hwHuX3RY+cSLFTOSEKdhVJ14sgtpVL6J9NFQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5286
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio] Re: [PATCH v10 04/10] admin:
 introduce virtio admin virtqueues

DQoNCj4gRnJvbTogU3RlZmFuIEhham5vY3ppIDxzdGVmYW5oYUByZWRoYXQuY29tPg0KPiBTZW50
OiBXZWRuZXNkYXksIE1hcmNoIDgsIDIwMjMgOToxMyBBTQ0KDQo+IFRoZXJlZm9yZSBJIHRoaW5r
IHRoZSBhZG1pbiBxdWV1ZSBtdXN0IGJlIGRlc2lnbmVkIHVuZGVyIHRoZSBhc3N1bXB0aW9uIHRo
YXQNCj4gc29tZSBjb21tYW5kcyB0YWtlIGEgdmVyeSBsb25nIHRpbWUuDQoNCisxDQo=

