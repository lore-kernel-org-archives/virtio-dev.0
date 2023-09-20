Return-Path: <virtio-dev-return-13888-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0321C04ABA
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 17:21:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 11403759DA
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 17:21:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E4F11986675
	for <virtio-dev@archiver.kernel.org>; Wed, 20 Sep 2023 17:21:57 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CD35498666B; Wed, 20 Sep 2023 17:21:57 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BE97898666C
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Sep 2023 17:21:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=krG3lbN5SAVKLlqz4bc1eVITgcZjJ7R75Fk9x9gLqp5Wfb8Yd3AK9i4/b7EITNkIs9XYSq8+ekPiBBi4i4BRB8ZyuQ3WzPtNE35wyyOKMb35UoaH0ZBH9nW/Z5TqOscOhU51s/2jxAWFCeNM+frW6B7vGvSGrwgSpflXNapBvP17UWKgcy1tDIF5aEnhBKTEy3XgAPaiF9bidM7Y8o2Vp1fhLymNZZPHQo3+tYCddSgjMH+ydcXfoKG82N+pvPfZK3h6zR76sKO2has3QI+e7gjufkAy/kZqAQUvGsmIQ7cBauvVo6aculSo1zHMLLUu2PqtwCKl8DTT89NiiIFouA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GRwvSxCrfi77hFRoaZNiRFmxMYanrOWy+53eEH+GNis=;
 b=KhCPeOXl6Mepuv64NQolB6SSq1M1X7tuiYXaJGQdViX0qbCsZQ19dyi7C3aVatH+hFUA1btLzpFchqN59hOf/OZ5D6vV1bNxh56jFUyZ579vOES3tahrvo5bVPz6a6ZkbLSRe+qGpA7xpouxxWO/C9Sp5Y6WU2h4T6mZIWoaB8Cw1vJngjDQzR4xVAuTunmLSOJKvfabe1vrg55B8lh+8+bgKFf6GeNXlBm8/6vI7BWInDGEWV3zS424fxK6oydeSRHBosHmrv2R9GcyycoGKd5R8hWnQJ28yT/b8V/W4YzGgo5xYp0l4hB3Z30/ugp0UVfQ8xDXGxw+cIb5MCLMnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: "Zhu, Lingshan" <lingshan.zhu@intel.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jason
 Wang <jasowang@redhat.com>
Thread-Topic: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and
 vq state
Thread-Index:
 AQHZ540fvvI9R/h+mUufqKbomRy5frAegLUwgAFrbQCAABUsgIAAD5cAgAAA+ACAABKeIIAABNaAgAAAXmCAAC3dgIAAl98QgAADDoCAAk+KgIAAS2wAgAAM9QCAAAwSAIAAChWAgAAB0VCAABiEAIAAJySA
Date: Wed, 20 Sep 2023 17:21:52 +0000
Message-ID:
 <PH0PR12MB54816F8341A77E63831316DBDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
References:
 <PH0PR12MB5481323A3B4D67EB66328476DCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <5f01772f-eb27-bfe0-7f69-b83fbd90dda0@intel.com>
 <PH0PR12MB5481ABF4B9BC2082BC54AB1DDCFBA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230918144312-mutt-send-email-mst@kernel.org>
 <bb402c34-ad07-063a-f4f5-d8c6b3a642c7@intel.com>
 <20230920054836-mutt-send-email-mst@kernel.org>
 <2f67fb85-2238-9c34-a265-b0f97b7ab7e1@intel.com>
 <20230920075243-mutt-send-email-mst@kernel.org>
 <20230920084058-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548110E53C924C984FA24A49DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230920101402-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230920101402-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS7PR12MB5742:EE_
x-ms-office365-filtering-correlation-id: 9124a35b-3a3f-4b91-8cf5-08dbb9fe14c0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3KvxjfyMlVAzGLNff3kCGnPVra+AnK5MNT5mq1z3VsCGJdD2ijKQUtZNZXODMYtlTxtkmZHP/Y2c/EACWKPyGsWA8M+13Ag4J2Ch5yWpDdQ3xvLL8fuvAaim3KjmkUkWhZnSldYWa3HmZ/f4sXobK8zb1NGyzFBG4JYQ1Gqbmgza0UJPmcfYiTmdTXjBCfjchuzdRYe1fO/u8VXznjStGumDdmViNRQCItIFK5NltoCKFSKMdeD1cSju9NpewnwPOyMkGWdF3dCKg7D94bhJv5dO6r5sg6vNnCsc5NgumgrT8Gkm0VbM5BThtpGK10+fEMsQAKLvAzSCcJtlopvDnEIlwAZzhOir/sa3zBpuQywlaC4PlnX4J6mOGmyBqIJSDVshkReh+3ZuYIPltQZOk0sBb8+9dS/dMTuR3g78cov7ZGSZyNMA2SwWtWvjd18TWy6U/BmnWQWv6WC2eoQUQU3hPT2MMLcE0/qnsqwQF7pQ1cHSuqm1nr1qj6k7r5wF8JenJYrrU5BstblEXulvY6HNU5JqVImVMU/XlPv6JvqIxjpJJalu7w2wgqnlKRyx+fwUOa+K7cFmJwbuRFVxb2wynZbMVXmCJ/HiXl2UTPhV4Hu2lRwwkniACC+nt6Xu6BjRAHQUu2lE9karbzC69Pw53pa2+CV3UxFF8SxF3JQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(451199024)(186009)(1800799009)(966005)(55016003)(5660300002)(6506007)(7696005)(86362001)(64756008)(66446008)(478600001)(54906003)(76116006)(9686003)(66946007)(66476007)(38100700002)(316002)(41300700001)(38070700005)(66556008)(71200400001)(6916009)(84970400001)(8936002)(52536014)(26005)(33656002)(83380400001)(2906002)(4326008)(122000001)(8676002)(15650500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5+JM/LDz7N528eJac1x/4qaQpNEoAfIdfWWg/MCVTl0pJR2MKNbuVzUcjHl6?=
 =?us-ascii?Q?XqvjWqnI7v6PXZZN+WJLQPphGYdS1PFz1xIf998cTQMd1n+AVfY1PYzSD+yC?=
 =?us-ascii?Q?1XmBHSrUn9ZU6sJ9oegM4eLYX4R9V8IaN2g5sYUjrK+KHyuEMh5SJvo431gc?=
 =?us-ascii?Q?4rBU6ej/ftH325YwYxJ6UE5YIOIe5BhVA1YYV+hK2M3K2BUB3KtQRGFcF0m8?=
 =?us-ascii?Q?xc17HT1VzzJBcDrp+1MmmZVE6/SuQeHpfoOQN9rUFuB9x6tEwkHKAycbHZHT?=
 =?us-ascii?Q?7leZfMnlEDcSVxVXGdgl6GJfv8Ioc2sFmVEf0YGZk4XzG1nN3U9KyrJ22Rg8?=
 =?us-ascii?Q?v00OOJf5exCnv29p58sCZ78yCVNWmvKykCniZtJu9gASi3A3Z1r11cHEzchs?=
 =?us-ascii?Q?X11IYwUJi/rWUFyYumdsg5woiYOjvTd6Ecbc1seAaCaMwbRphlnjTZzTYNba?=
 =?us-ascii?Q?vuzjGs62EHSGbRg1WO1tlThm/NHAY3yZ6fAmGkSruZX28DsMjJojoOzgFcKj?=
 =?us-ascii?Q?htI8fmdar1Jz5Rnr2pG/JOtaqyF3LoAWZcYCf0bDQO/rKxBHnXATzhJsKgDk?=
 =?us-ascii?Q?6F14oz55XiY7iQ3pZGCsMDVx8dV40G6O+XWMMeCosu00Xeb01WZ8RNLZSXHH?=
 =?us-ascii?Q?j1a5LvICI2beksqHfJE+mfo31aQp9QKFe94D+5EH5wfbFG07yCaDu1u93x3O?=
 =?us-ascii?Q?6oJVjTmlTNw2JQvHwp/3l7lDHf/4dL8FJmCf/uACcFoGcjvivdceWoTTiVr1?=
 =?us-ascii?Q?cMPNXomVOB1WPoj0YT8tprGsjoNHGdojeE01lIKY3KZxG02YspdIo6nUalsK?=
 =?us-ascii?Q?ZtGHnAF/xcm97+iox35+YC59N0orPE7JZPf1wsrzFsdxGu9WGOasZSC3+TIl?=
 =?us-ascii?Q?VgiOy2fzs8jnIJQ2NrEZTwf0ff89r3YeiZxx6kfkSB8HHMkgJ9FwQumxD30C?=
 =?us-ascii?Q?jtdbpWeK5uyxDZr10RD8hwNyqAkqx7bX9ZOqhm2ptr3jjTa2l3UoBtUSVK0B?=
 =?us-ascii?Q?Sepz3DpoEXNyfWSChz+KNFkNQua+y3u/2A1jCnIHUyuIENBg/B+ve0nC8Uzo?=
 =?us-ascii?Q?U2kxQkhlxzGqMet+wtLSMz8d5v8gwKD5cUToZJ7zJaJjAmGj7BDuL6DVXKGT?=
 =?us-ascii?Q?EfrWxkjID2PLY42P4GrzNL8t/vPpBVEUs1jYF5NEjnhe8c9AYB/0j7FG7P6i?=
 =?us-ascii?Q?IAqwxxSWjON/PANQuBrGttiX2Ug/Ec8aS7P2CUNkJMw4uw+Q4NnBK6KZ0leg?=
 =?us-ascii?Q?sKg3Qqtvo2Mbe06GcXGw2dBEahzT1hFja+cv74wxMc3y2kJdFYMyQLTGpGvg?=
 =?us-ascii?Q?NVFZA7GtCdNGXH4Yvo4tvqwutPASh9IyN2JJSEB1tJjS/7JlasxeaPOFNwB/?=
 =?us-ascii?Q?7cSLzsuu/NRfUmoG2ZIs6svZvlSdKJMW1lsSWC9cMwfXUD7iQsFiX2VqI1qo?=
 =?us-ascii?Q?gI/k6JOd3/Iw6wI4zdfEUDi1Rij/V+EUdMIqaERhtDF17xmJmNzk394E+vP+?=
 =?us-ascii?Q?5xnNm9/3xM8K6KcO21t+k27I1MWgU+2+cl5YWMcQfzqpb/A0VuJmHuqFBoLu?=
 =?us-ascii?Q?1+LXp2AKM3HC64CBTnU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9124a35b-3a3f-4b91-8cf5-08dbb9fe14c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 17:21:52.4003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s5e07JKzlLlU7HABE++b0Ovyw42ZN58c1Q435stUj7hbBGNYeM+jEBXsp2wa0BJRrBwLjYoNsIr6/QP2mPJGqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5742
Subject: RE: [virtio-dev] Re: [PATCH 0/5] virtio: introduce SUSPEND bit and vq
 state


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, September 20, 2023 7:46 PM
>=20
> > Details of his position in my view:
> >
> > 1. Device migration must be done through VF itself by suspending specif=
ic vqs
> and the VF device both.
> > 2. When device migration is done using #1, it must be done using mediat=
ion
> approach in hypervisor.
> >
> > 3. When migration is done using inband mediation it is more secure than=
 AQ
> approach.
> > (as opposed to AQ of the owner device who enables/disables SR-IOV).
> >
> > 4. AQ is not secure.
> > But,
> > 5. AQ and admin commands can be built on top of his proposal #1, even i=
f AQ
> is less secure. Opposing statements...
> >
> > 6. Dirty page tracking and inflight descriptors tracking to be done in =
his v1. but
> he does not want to review such coverage in [1].
> >
> > 8. Since his series does not cover any device context migration and
> > does not talk anything about it, I deduce that he plans to use cvq for =
setting
> ups RSS and other fields using inband CVQ of the VF.
> > This further limit the solution to only net device, ignoring rest of th=
e other
> 20+ device types, where all may not have the CVQ.
> >
> > 9. trapping and emulation of following objects: AQ, CVQ, virtio config =
space,
> PCI FLR flow in hypervisor is secure, but when if AQ of the PF do far sma=
ll work
> of it, AQ is not secure.
> >
> > 10. Any traps proposed in #9 mostly do not work with future TDISP as TD=
ISP do
> not bifurcate the device, so ignore them for now to promote inband migrat=
ion.
> >
> > 11. He do not show interest in collaboration (even after requesting few=
 times)
> to see if we can produce common commands that may work for both
> passthrough (without mediation) and using mediation for nested case.
> >
> > 12. Some how register access on single physical card for the PFs and VF=
s gives
> better QoS guarantee than virtqueue as registers can scale infinitely no =
matter
> how many VFs or for multiple VQs because it is per VF.
> >
> > [1]
> > https://lore.kernel.org/virtio-comment/20230909142911.524407-7-parav@n
> > vidia.com/T/#md9fcfa1ba997463de8c7fb8c6d1786b224b0bead
>=20
>=20
> OK so with this summary in mind, can you find any advantages to
> inband+mediation that are real or do you just see disadvantages? And
> it's a tricky question because I can see some advantages ;)

inband + mediation may be useful for nested case.

In attempting inband + mediation, there are many critical pieces are let go=
.
It may be fine to let go for some cases but not for passthrough.

The fundamental advantages of owner-based approach I see are:
1. Nesting use case usually involve large number of VMs to be hosted in one=
 VM
For this purpose, better to hand over a PF to level 0 VM that hosts VFs and=
 level 1 VMs and avoid two level device nesting.

2. Support P2P natively

3. Single non replicated resource (AQ) manages less frequent work of device=
 migration
No need to replicate AQs to thousands of VFs who rarely do the migration wo=
rk.
Overall gains system, device, and memory efficiency.

5. Passthrough simply do not work at all ever without owner device.
This is because dirty page tracking, device context management, CVQ, FLR, c=
onfig space, device status, MSIX config all must be trapped.
Many systems do not prefer this involvement of hypervisor even if the hyper=
visor is trusted. (to avoid moving parts).
New generation TEE, TPM devices are on horizon, and they would not like thi=
ngs not trapped either.
The security audit surface is very large for them.

6. Any new basic functionality added to device must always also require con=
stant software updates at few layers in mediation entities

7. TDISP is inherently covered. Without owner device TDISP is broken as dev=
ice cannot be bifurcated.

To me #2, #5, #7 are critical piece that a device migration must support/wo=
rk with.
Rest is second level of importance.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

