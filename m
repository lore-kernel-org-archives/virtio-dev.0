Return-Path: <virtio-dev-return-12634-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4B8C7EE22
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 17:33:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 89BE371C93
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 17:33:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 843EA986636
	for <virtio-dev@archiver.kernel.org>; Wed, 10 May 2023 17:33:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 774A59865AB; Wed, 10 May 2023 17:33:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5AC2C986591;
	Wed, 10 May 2023 17:33:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3c34zgU0jQuVRoFX/5NyNagTBzJywyOxzg9/3Afc41uiYWRpnwdhhXdc/N8JGxmQX33Q1z/7SQl3f4HR+xr+FcsPwgKp4HdFn+8cil4TlE9g6fYBhf7Qc5ng3aJhp9lYKr6by2RFb8lQYAObq3Ba/k/cXKmBm7U+P9EcYvlLHKNNQfZmlbQMs4/FTKFQXaQ2JPqZTzjtiquBKTfuyoX9LEdEGqqrsQh6YPj9dU+MpC/dH3pdQnJgvVXPwwubVlilJ23QBHKcAFkRfiWSU5zHwCeirSpIrx4O1TkTbHTDeLbcylW3xYpdrGvAQiZ6wMXG3MamSEUnj6mslosvHMhxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XuaXpCPivH24bap6USewVSdfZZ8CJ5uRCk6grNDfh64=;
 b=HJlCS2QQTD8uvzsY/TfGTxBa/PGnPw9MoGP6k6VDOa7PWm4AXYeV79aQqcS7/qXWFM7HJO5c6F2QyZRa3v+PeT9p0ujANWM+HLJbYI5AXDxxOPSjPCsdRQ1W/XRHiad0aLfMuDF5OTfUHjqE1miTZLDJqDyzIVrhak3qMK7GehrtbguAeaM8WSzjIs53LNyjIrvl+O1bfWu+0aaGTESEL2XIfxTuoBwNHybM2wIghJOlXAgGr8D9EOrYi7Hgt8t3Bw2ELAjiC+/W4W2mUw3z8KKuIFuH9rZobJ+2imwD5YpGTzLIa1fyqwNUFEXrkAd0TJi0ESRB9NHw4P4UqTMHLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Jason Wang <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"sburla@marvell.com" <sburla@marvell.com>, Yishai Hadas <yishaih@nvidia.com>,
	Maor Gottlieb <maorg@nvidia.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
Thread-Topic: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ
Thread-Index:
 AQHZf637tzEcVLD5bUyVf2EjaUYU3K9Mhl4AgAJOSwCAANQugIADYnEAgACpnQCAAAFGAIAAENkw
Date: Wed, 10 May 2023 17:33:40 +0000
Message-ID:
 <PH0PR12MB5481F030A76141320F03956EDC779@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230506000135.628899-1-parav@nvidia.com>
 <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org>
 <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org>
 <43ec1c8d-7d11-2400-3649-1fe366b1e21b@nvidia.com>
 <20230510121417-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230510121417-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS0PR12MB7534:EE_
x-ms-office365-filtering-correlation-id: 76df1bc7-2558-4738-2bc7-08db517cb1e6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Yk+stdaP7WjsHPXvuQyLGJo7PWvJspYywOnDpsm6lYG11yj/Cp/vMLLPntzNiAKjaf0JEllRxOTt/h2tBu4c34LGYiHb8ERNWS8l3eXM1PPuiGR9xlpMKFaMSiA9siQ5lLXti7+j8Z9B7aFcn/QDIOEoyrpSar9V1d3gbzGQT8TJrApXMMYZ4gLdRuIqHVuMsfnFs5DBBi2oG7VL6OOQVos9ns4ZUQeu0wFp2uzxaB3SiB5Zra5jFCPIz0iOl1ZWnMHmadoiZVne7gII8NIPS4Z16bZJ814hoAxfuUOiy7WMZUgSrYqt0tL++pDlyTD3Q+DabnN7Q5zuMLRPtvGlERYG0K1pfOrk3isXZHnDM+hCftQXjy60z8vbOqDDqdnTE1Th6qfCcSWJ+1i8rAjO0yjaoine0r2FHGM064LJRID0sfLBgLj5jzQVPccguVDgFMv42ocTVjgB+B7M1qQsrSsOhzAhP7VxAmoYlXmuGrI1wrWi01mSyrSQCkfGhMz2PHw/Pj6+lz9GUfbexlMz9Oa0NHPXMWXhWZUY87ufICvIf60RnV3RIjgnfBQ1ab/WQKJ7w9q+FC2WeJfgBHWcHQQ7rCZNEaBTl+8nBAr41IFN7RqqKNTh8irAtjymTJhOc0aD85s6STmwhJtRvTOwZ7dN/gPMfrTRpECDyPo4nwOBWZGbzlTBeZlalay69JtF
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(451199021)(83380400001)(66946007)(64756008)(66446008)(76116006)(66476007)(66556008)(7696005)(107886003)(9686003)(966005)(478600001)(54906003)(186003)(71200400001)(55016003)(52536014)(86362001)(2906002)(5660300002)(53546011)(6506007)(33656002)(38100700002)(6916009)(122000001)(4326008)(41300700001)(38070700005)(316002)(8676002)(8936002)(84970400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?v2ehwVkIcI+6IuC9cQZSJ4c+6zrDIyWLxZ+XN/6rGtJk/QU8H529WdrH2qoP?=
 =?us-ascii?Q?mc9ZeIrnl9vB2BoHwNm2T25tDSyZWxX9FLN6NPPOTodXR4TlvCsuKqPLtxrn?=
 =?us-ascii?Q?pTrBKFXnjrlS/r4GxmBcTlbjBhyleTbcmlHvZl2JsMl10b6CCUtScuv7887p?=
 =?us-ascii?Q?o+8E1B+D3Rdd/mk6uES98NUzdAZKg6sd8zozy/+SGGZbCC52v5JQgsTjguIh?=
 =?us-ascii?Q?BmAF2lQqkCrbfOBPcB4tNXqjBzrr2PA8YwcChIqxuVA+FmiWDMYTg4JsY6fY?=
 =?us-ascii?Q?v8XBiykG9GGWGlMvUp6kHafZ9/1Mac0s6WquwE8/ySDJa3UEkwjpLfQonC8+?=
 =?us-ascii?Q?Tkk+WMhMLKy2H12w5/TAY1vkllKaFgtayKypp6RYcdLwf2TfmjFz15WT0sLM?=
 =?us-ascii?Q?CM1MgkMe49fbphuIuTfnfa61vU/Vac6AIAuMHgTGfj/uo6O/Z6e/8bjhoaqC?=
 =?us-ascii?Q?5VyaQPXqrnEvJApiMso5xHJ484TcxnzpffAARU8Ie1d1TmqGEBOkk+5SlGlQ?=
 =?us-ascii?Q?dlGRTlPDBAslLEuA3lK8Eia8EgvQ/2I1Klv6NrPgLvGPi3T04GpJp9dhY/jQ?=
 =?us-ascii?Q?KVSFNR6C9NkLI5UnHJ8ulySSR8q+YhC9TRVnmUP8DWXJD2bu9TqAVq3L9WqG?=
 =?us-ascii?Q?LOoP0us+fh15rQnEqPxc6WWqipJOJ1dClfGbA1cneNczzMbk93jxzx9NQ3XD?=
 =?us-ascii?Q?2rv/I6BTZhnZgJTz/MpGgnqDYymTViAZRrjg+XQhZmNmkVoLjdpKa7SY1GN6?=
 =?us-ascii?Q?kItpg1bXG39j4f3s/X92Fjp2Xmsxy+PDW6AWj94MfjM9Ef5IBo26QGwUeRqo?=
 =?us-ascii?Q?R84aaRSqFdommwSBrvncS4WTh1hcziKmc2BgD7wqUbQwMMtjaDCs0n/ucjka?=
 =?us-ascii?Q?KJxoRgOepCA+JSDNFxwuMYLMzs84/MVJyCDYqV95tvAiRxrqjRsQSD+btVNG?=
 =?us-ascii?Q?NMpusEASFRiu1PMohB8J5lCQZeFyyPI/PBIi/cAFFP6ittfyBE2DUBCcnG+h?=
 =?us-ascii?Q?SJhS+hFLrXrX2p8AqSuIivmyLvIq8ujjY/w9fHNPKe7aCVWFzfDAZa7HvH0O?=
 =?us-ascii?Q?2+2lczaE+zULXTNau7zoruoIV558UU+8Xc9/SVJa7ueqju2iweWISpOteruv?=
 =?us-ascii?Q?6AA/052w12QJoVHm4PCDcOKDW0Xn7MIvD5Z3ejdT9hkeGHReQFjxF7TZCvIQ?=
 =?us-ascii?Q?4C3ex3iFlMjJi+mLUgon55mbUSH2RyPfgXq4h1JwiigfY4fFI8kYaJBDvtuq?=
 =?us-ascii?Q?0i7yoJAXVIr7U3lcaS1JI017KZ2ntBDz34RJmT+SoCHMkre/hlZeuYky6gfT?=
 =?us-ascii?Q?gc2YTdNdyQenzArMKRp1FeUdCXxueX+/rABB+04UseY2KZdDeXTrZcQwJXnB?=
 =?us-ascii?Q?WCYtPZUq3EY/7lQIwDyFuTLOLOut1oSvJV227A2dERHC/r26uYsqnX7U34R7?=
 =?us-ascii?Q?ZtA7ovDHkvrfzmaQVVdD4opeMZ/XKUxy4l/WMedm1YW2DAl/V1OzD1IRqvz8?=
 =?us-ascii?Q?PhIBDTmeVUlqmBz8L8PV4qGo2B7xDSXM/wE/IOy3q7ULWRLVq+9bYeMKXsM6?=
 =?us-ascii?Q?Ir3G2Z8kfaXUJVV9kk0/Szjug4xLIWDILgxEcjwBb0KFOCt0dxbAix8rYbNw?=
 =?us-ascii?Q?Cp/T/htc0Tzbf9dx3HkB8NA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76df1bc7-2558-4738-2bc7-08db517cb1e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2023 17:33:40.5476
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DU8wfQL43bi8C7j9PpRmMXTwiipqjAHf2kBuo39VzZs0yfozoYbXWOtbNrjXvc+t0W00IBeL89e9staL9U9f4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7534
Subject: [virtio-dev] RE: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ



> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Wednesday, May 10, 2023 12:16 PM
>=20
> On Wed, May 10, 2023 at 12:11:50PM -0400, Parav Pandit wrote:
> >
> >
> > On 5/10/2023 2:04 AM, Michael S. Tsirkin wrote:
> > > On Mon, May 08, 2023 at 10:23:39AM +0800, Jason Wang wrote:
> > > > > I thought so too originally. Unfortunately I now think that no,
> > > > > legacy is not going to be a byproduct of transport virtqueue for
> > > > > modern - it is different enough that it needs dedicated commands.
> > > >
> > > > If you mean the transport virtqueue, I think some dedicated
> > > > commands for legacy are needed. Then it would be a transport that
> > > > supports transitional devices. It would be much better than having
> > > > commands for a partial transport like this patch did.
> > >
> > > OK I am beginning to get what you are saying.  So your criticism is
> > > this: what if device supports vq transport for modern, and we want
> > > to build a transitional device on top.  how will that look. yes?
> > > A reasonable thing to include at least in the commit log. Parav?
> > >
> > I am still trying to understand what is "vq transport for modern"?
> > Do you mean transporting currently defined config space access over vq?
> > If so, is this VQ belong to the guest or hypervisor?
>=20
> https://lore.kernel.org/all/20220826100034.200432-2-
> lingshan.zhu%40intel.com/t.mbox.gz

The gz link is not accessible.
But I got the right link [1].

[1] https://lore.kernel.org/all/20220826100034.200432-2-lingshan.zhu@intel.=
com/

1. Above patch cover letter [1] is missing the basic objective/problem stat=
ement.
i.e. why a transport virtqueue is needed?
But I probably get the idea of [1] as we did the AQ.

2. Commit log says about=20
a. querying resource of management device (aka group owner in AQ now)
b. creating and destroying the managed device  (aka group owner creating gr=
oup member devices)
c. configure the managed device (aka group owner configuring/composing grou=
p member devices such as VFs, SFs, SIOV).

So, all above 2.a to 2.c belongs to the admin group owner and group managem=
ent commands like how it is defined in the AQ proposal.

So, 3 out of the 4 motivations are achieved by AQ proposal.
This AQ belongs to the hypervisor. I am clear on this part.

4th point in cover letter is: "config virtqueues of the managed device".

This work belongs to the driver -> device direct communication using a queu=
e from driver to device.
So, I imagine this work can be done using a queue by the guest driver and s=
erviced by the device like how a guest driver configures the queue today wi=
thout any mediation.
For PCI, MMIO transport, surely this can be done by the PCI device directly=
 being is PF, VF or SIOV.
(Instead of config register, using a new queue interface). Looks fine to me=
.

Can this new cfg queue mediated like CVQ that is done in a sw? May be yes.
Should it be always mediated when it is of VF, SIOV Device? Mostly no becau=
se it is yet another VQ for PF, VF, SIOV.

I am yet to parse rest of the 4 patches, please give me some time to review=
 it.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

