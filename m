Return-Path: <virtio-dev-return-13885-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1C2CE79D0
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 13:41:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D796E77E91
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 13:41:04 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AEBB698667A
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 13:41:04 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8B02298666A; Wed, 20 Sep 2023 13:41:04 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7AD4298666B
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Sep 2023 13:41:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Af245aN9hqTLMNSIxVQnxAfvQI7dP96q0o0CD0GnErd7WRk0h/Nsdudw3SXBYNn8rH/jsBXroFoV7xHLiqIfNNqIwrBfG5Y0WtUwTLg0/mvcmxd52v32RBozOlcew7oKuNV6zVeG+uEme8AsWbWfOhWswsYO/tpN8FC5n9zKQsfgDC3oGWOT9j6yQjfXeWYCXME6k2YVkBlAOQL/ZBq3FY3D/Q5+IAcJ4zGhgDlvyVsZ9MgfqIcE2qjWtOX5UMFPhV+uCM0bQy1WHuVimkhbDUCHViM8HYStPrVCOyaGbLuKY3rdPwfYVhgFptH1nZAz56oGL6gdUgMI8KpWT8lWpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cv4g467KYNb6QeyS0FtnCy2NqfJqXvt5QBThETVFymQ=;
 b=TnI3ErdBw4v3n4XYdHsCwA88hhynB/9fzkGA0MrvYCnHyT40DsXVMadNlSpWqLlYrbj1MP/JXttoFeAxXejQlUhtBmOT74QIL/SQEriXaov5COwmC1Bzz+EmwE3iSub+dga6ZeKKgpba1JW6FLh1+Qvmng5SGC5yWQn0u93dj1jR+wGVjgX07DWugEgPmWNfeHrVI9kLR6IIlnnXtYQe4KJFXlf/u97fW3q0EGWYXeT8qMyYqHN7rpPpGng9CtGjTgoTdwfmCOGfXVWZesGFLMXf2UvLk4o+c2FG0n3eqGMB+24g7ovfy5hxZMsG4PT+/3N1iyLt3FO3EVL7eNHVtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, "Zhu, Lingshan"
	<lingshan.zhu@intel.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jason
 Wang <jasowang@redhat.com>
Thread-Topic: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state
Thread-Index:
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAC3dgIAAl98QgAADDoCAAk+KgIAAS2wAgAAM9QCAAAwSAIAAChWAgAAB0VA=
Date: Wed, 20 Sep 2023 13:41:00 +0000
Message-ID:
 <PH0PR12MB548110E53C924C984FA24A49DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <PH0PR12MB5481AE8C6E5EAFE9A4ADA6F6DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <f1fe513e-d42d-03a6-348c-5e58aac0a759@intel.com>
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com>
 <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org>
 <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org>
 <2f67fb85-2238-9c34-a265-b0f97b7ab7e1@intel.com>
 <20230920075243-mutt-send-email-mst@kernel.org>
 <20230920084058-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230920084058-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB7685:EE_
x-ms-office365-filtering-correlation-id: 7dcf7360-88a8-460f-d8a2-08dbb9df3a49
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3BccASPGCO0bOXdOiLkzFi0qYwJOSzON3son/e9IYicK/VQ/vUXLwYBk+uTNz+XjWGHaGFCwHOKZZTpIY/yABy61vTX+yZoXsMVTgY+LwEBSeUgkMdYAXSmphmNu/ZM6JPGeh4Jh/Nqc9ieKeo2Ul4VV/PAr+QCbqBma/Sn4hEougpx29PSU8g3h9HPC1paKTSjLWhU1zaYiN50rjtP1gJmki/qnWfXiOugAW79Hy/GiTHvamMbWyaIfg594h3wGv1aNARM7YdEIeqhFN7AEslRZOYHRD3dZM0YNmrtapK7XrzZoFaG2Qzik18dBu49Yoq2rIn6hKSOBL4IiphQ6Lbkr2t2Q5w9zGNUkrQe9SRiTJy/sDcVdRuU45pKfzCwjn1e7/VmCB2kMgpDmEhnOT7Va9RSB2WZbtznOyMFfjXbXT4mVtm1QGVh3U4n+Sw+XCXKIs1ysTSlShf7RfnjKuM7TECVg+mgmHbdVOLJg3b8r+xa8B7EwyLr50AB/tLrjt3gshfpDJsSzZ1S06NQ6cXJO1JsCtSMRU58dJWSWxS2WW8e9ekXONgIc+ByzJcKUx3bHCtHNpDCrcDLUHg4Y4IpPtMhZSPjGXir8mXDJN811PnHNNrgHCrwutFdmyNMHLN1xxoiqjuZ9D64GC70Gl3J1LhSj1J6XpFR9oJKl8PA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(376002)(396003)(366004)(1800799009)(186009)(451199024)(6506007)(7696005)(966005)(9686003)(478600001)(83380400001)(26005)(2906002)(15650500001)(4326008)(76116006)(54906003)(66476007)(66556008)(66946007)(66446008)(316002)(64756008)(8676002)(110136005)(52536014)(5660300002)(8936002)(41300700001)(71200400001)(86362001)(33656002)(55016003)(38100700002)(38070700005)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cDRcBzL0wyvBaAIuZfWBmvVINBuWgSX8X5m7ximJm/cYd7eDad6Z0bHimC5Y?=
 =?us-ascii?Q?xQvPgCX/j531fbqf0PddRBioO8EnX/zgu/HN5xt42yYY6zl99JVQ/yhU35i6?=
 =?us-ascii?Q?dn2LELYXgTRC0wHW8LRe6zUYswKzJwtukWsGIv/bu2/xaXu+BaWWJ/fzDJy8?=
 =?us-ascii?Q?WHE1cS1eIxEPOuGm4DiwzBlpLI288Ltb0nQQN+bDivvs6clA7MNwcta+M33w?=
 =?us-ascii?Q?PqrD80gnfpV+0ypemN3xNO1VQFfTot86RQvKAnXGjbNhYWAEG1MgQeTiG2KR?=
 =?us-ascii?Q?ejXlRszGQYMlnmR/N4a1hZSTImuF6Xt8zTrebkgO0s13zpluoq+bxjCKuMry?=
 =?us-ascii?Q?XyDjmtbLDeOXMRWNBl5lA+7zEuKZdnMOUiRLnwDHhr+8jjW+7XW7yCrv17CJ?=
 =?us-ascii?Q?wJbMwCf2rGIzWkm+6F2KjorG+kor55WxXLgWQw1rh509HpD42AgbdzkMB77m?=
 =?us-ascii?Q?nI8CFALaIG7n2ErY+p2wi+5SS/u9ur7JfyyGCKXe3Qb9/Fld8IWCQi8qBaj2?=
 =?us-ascii?Q?F5+jePj6dq2RxhT2ok4guJNAvvjduORX1HNIeFg/Foj/9oaX9TkwEmPUQyhw?=
 =?us-ascii?Q?dZ7TtyljPVCT+x9btd75NQi8Ere6MzM4hJvAq3YiCI9J5egD3zuQVefzJzsb?=
 =?us-ascii?Q?i9qmNJx4LtzcoL/1Veo+2DsoLhSt3FuI+DndrXUiBktz3twk6UkQyt9jJzfk?=
 =?us-ascii?Q?GPnpqqA2Krm/aCxHrT0BSh3zd23Ml9xbkx0Pf4yNjtJ9GNyflCFLKICgPHNX?=
 =?us-ascii?Q?UE+KZcOUEGpD49BaUhTQ1ugJB1GyCH8fyiIXuJT+T0A/MxxisE/xo0wzGNSR?=
 =?us-ascii?Q?hiH8cDW/LMmGx4P95btuwvwabPP6bh5ZvJsqv1Hr4VMMt/QT1L+xZeCWEm1F?=
 =?us-ascii?Q?/9V+yMoPVc690L/fcOXZsPFISBF8r7CuQ/LVsnkF2SyDUrSNN/hNJsOS8qO0?=
 =?us-ascii?Q?Zj2PNuw/Y+tOE2VMB+ljdM6YsMByAzsaMON5W7sJRZug7pcbEzVdyYvK+V1q?=
 =?us-ascii?Q?DWzBvg8ciEeTvYI2HyUEFc0hhn4MBGEU9E4vXFv4aLnOM7IpAAT8xZTMtftg?=
 =?us-ascii?Q?Q63/Mmn8x8+7eANiBnFVsGShRGEsWCshlI43r5mkyIXqeIRtL6P5mDrFc5Ab?=
 =?us-ascii?Q?m0GT0BIBPzJ2zOvSUP5oHv3dj2oV23F1LEeOgdTibah3/TRrKHA3vYAJ/mSo?=
 =?us-ascii?Q?lIbcICx7tYf4vK89GECBG8yrED7giVapA0ZtdOmaKyPKLGDht8cm/jZrbU1o?=
 =?us-ascii?Q?vsMcb1gyw5HOYSrDKr0YQMDJM28K4cflc1ZnpSEijsgIrkGyjxRixtqi1ROS?=
 =?us-ascii?Q?Jc8sVWX2Gbl0Abgh4fTVqfK6Iw+0D7g5Hm+JzDVVGwfwVFdzjTO7ZEy6VSTo?=
 =?us-ascii?Q?O2S6hVuOQMABIE6KgdMf6GN/h6GQgQ6RpyIA4Yn+C++UmwaTeCzH4XmBB9uK?=
 =?us-ascii?Q?SgZ3brIOH+Rpgt9QGI5UMZt/MeoYwYBYFGFNbiV5JEp+opjEj+S5jz4D6UDS?=
 =?us-ascii?Q?rYcQMJuZlQ/DsrdSxi7Vp3Jpearl4U0KsmKYJXD580MbDerXKYgcxzndFhbn?=
 =?us-ascii?Q?F8ghio7OUQrytQGGNPs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dcf7360-88a8-460f-d8a2-08dbb9df3a49
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 13:41:00.9782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a04KT6fVilgw4vCrBYvgcKCfRtMpq1rv8aORDmUckhFDPpnpwRTuCz/0+NMUaaME3tNsZLgWLySX+fWHbk9Jjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7685
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, September 20, 2023 6:12 PM

> And Parav same goes for you - can you summarize Zhu Lingshan's position?

Below is my summary about Zhu Lingshan's position:

One line summary of his position in my view:

0. Use inband device migration only, use mediation, mediation is secure, bu=
t AQ is not secure.

Details of his position in my view:

1. Device migration must be done through VF itself by suspending specific v=
qs and the VF device both.
2. When device migration is done using #1, it must be done using mediation =
approach in hypervisor.

3. When migration is done using inband mediation it is more secure than AQ =
approach.
(as opposed to AQ of the owner device who enables/disables SR-IOV).

4. AQ is not secure.
But,
5. AQ and admin commands can be built on top of his proposal #1, even if AQ=
 is less secure. Opposing statements...

6. Dirty page tracking and inflight descriptors tracking to be done in his =
v1. but he does not want to review such coverage in [1].

8. Since his series does not cover any device context migration and does no=
t talk anything about it,=20
I deduce that he plans to use cvq for setting ups RSS and other fields usin=
g inband CVQ of the VF.
This further limit the solution to only net device, ignoring rest of the ot=
her 20+ device types, where all may not have the CVQ.

9. trapping and emulation of following objects: AQ, CVQ, virtio config spac=
e, PCI FLR flow in hypervisor is secure, but when if AQ of the PF do far sm=
all work of it, AQ is not secure.

10. Any traps proposed in #9 mostly do not work with future TDISP as TDISP =
do not bifurcate the device, so ignore them for now to promote inband migra=
tion.

11. He do not show interest in collaboration (even after requesting few tim=
es) to see if we can produce common commands that may work for both passthr=
ough (without mediation) and using mediation for nested case.

12. Some how register access on single physical card for the PFs and VFs gi=
ves better QoS guarantee than virtqueue as registers can scale infinitely n=
o matter how many VFs or for multiple VQs because it is per VF.

[1] https://lore.kernel.org/virtio-comment/20230909142911.524407-7-parav@nv=
idia.com/T/#md9fcfa1ba997463de8c7fb8c6d1786b224b0bead

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

