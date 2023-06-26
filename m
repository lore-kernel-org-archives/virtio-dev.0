Return-Path: <virtio-dev-return-13086-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024CFEB64DC
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 12:20:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 003BB42939
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 12:20:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5E96A986825
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Jun 2023 12:20:34 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id B3320986394; Mon, 26 Jun 2023 12:20:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6DDF7986393;
	Mon, 26 Jun 2023 12:19:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KXX6rFnwlJEabtvCfOdlZD2xu7O/0hVMMPMgtlqMkinSkzQ0tGyusqZnnz7EPSPMMfX2dzradWubxWuBKKtnUvgYlRDeL5XhHrmfQ2lnvpvrs+kXggh3fmPewXRaq1FMlvpmoslVLoiy05wyntdNdRt9JjAIxOYUY8LdRdpxBZA1yLWDt6ac+jIfknc1Bov3qc68Sf2cAZSYJYhID6RKmdTuskfmfP9JZgxgNvro5P0GAtCbBejb9r7leEE+uWM5OeaRovNgokB8b4mK9LC4LLaHOYmy1z2j0mvxsGEBoJqDTK+/F8xCsCJbq8OAwAxvUYSXbDiW0wigNaxu4i+Okw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPpNjzW5UdzlKQmrhAg7S3ZBYsxqX7VJ+X2L9CEbFIY=;
 b=UUep3jCCj3OqEgqKsQi0C58QSsDe16BiokEMsU4rSJZQcKlBtwiNt+KZ08PYwIZm3Km5VZwcL9kWAgbWDZTZGRHIvyeFc0c22c1+xUZtFMeRfOky/fxXWJ1yqBCYhMTxeNfE4ES2B/1MT4GYVBxWHrb7fS2O86g+WorF+6e8S26irEaHJLqSUqLdzgX0aOIK5GUZFWVl+xQE9/4lDgeHnn+IhAPu3Fc0eZvkE7YUmjhCuhGnIHAChRlESqvVh21jIFtIpkRTLBaHbr9upvDHrwcuCd1Sfu2VbCcLDzDEXbjyQKu+BRo+rz5Qa7OD2NqcztMC2G7QvecYkfHGQURo3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "Zhu, Lingshan"
	<lingshan.zhu@intel.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"mst@redhat.com" <mst@redhat.com>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>
Thread-Topic: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] [RFC
 PATCH] admin-queue: bind the group member to the device
Thread-Index:
 AQHZp/aO4VG7c5VX5U2HGCV+HZ1m26+cowyAgAAHC4CAAA21gIAAA3QAgAAN8QCAAAS2AIAACv+AgAAPS4CAABdjkA==
Date: Mon, 26 Jun 2023 12:19:04 +0000
Message-ID:
 <PH0PR12MB54818E9B1BEE45EFC0E3E78CDC26A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230626062210.49020-1-xuanzhuo@linux.alibaba.com>
 <1ddd572b-a1d0-74eb-1e31-abb6dafdef3d@intel.com>
 <1687763309.2985258-1-xuanzhuo@linux.alibaba.com>
 <0a3cc0d7-638b-a49c-d846-8a4ba6e5501f@intel.com>
 <1687766994.5635917-1-xuanzhuo@linux.alibaba.com>
 <0d536952-bc05-460c-a116-3ec26c25b017@intel.com>
 <1687771000.8174524-1-xuanzhuo@linux.alibaba.com>
 <5809781c-1688-478e-d1db-39067fb45d80@intel.com>
 <1687776645.3360302-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1687776645.3360302-4-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW4PR12MB6922:EE_
x-ms-office365-filtering-correlation-id: 8c90fa49-c9a5-4faa-6ae9-08db763f88a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ysztqy+URosXfuHJmZCfVlxPaLXWPcFNayQsjt7u2a6VFYwVDsbAuFecRqixPhdJ5d8k3hQd6+ydFWCsUs/16N1fswH3g3pWJz5nVSuUhE9mAelncsjmjBdZBFmGqBq+XAUHRwL5I2DYP53Sx2Qoso9XFKTgnebyU50zxmAUpyULDqCGvA7VLkb4RWS32EhB2HqxZylQOh8pomzzySag7Xsb5y5WuiC2YFZQ+t03FI7+6ljL+433tQf9aIfSsS6x+VBA1xkTvABf91flZZjxrlqXHzar7Bv6FUf6sGH55DvwRTBGS2sxOMozsO0G8CRrBORGvpYqZC8TJWoD7LTpuNmO9KV3rbLL8+YKzM3v9e3tEbLoGt8iZzy2CZFzCvwV5L0u1BKre5RiP48vIvwfyAIIhyq0w9J2b7wRodKvCnXIRk3y2CgWmmddRxMc7kbew6uVSGPd7+on5slz3F0s0jdMNYKjLzWgdXGULNM5mgmxVelXEvetBJwI6ajopcAnMsymfFeQRItnEVSgDpDeTGsW6UuWzykdWgLEKGTgb8n5G7i78PCGEVz2XQbp40MDraTGPKn39VCgGR/i15ah0MebVgh9SJ9KkX0kOv7SEpAwAG+9ve10/tV/UGgNl0Ma4lOXJPoGuSuzM0roQDEa0rdHZXNAIfqKQsKBkMvWM0Uf9WuX8OdYmr1Nydnqz0yk
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(966005)(478600001)(54906003)(7696005)(71200400001)(110136005)(83380400001)(26005)(186003)(9686003)(6506007)(53546011)(66446008)(2906002)(30864003)(5660300002)(52536014)(33656002)(38100700002)(122000001)(4326008)(66946007)(55016003)(76116006)(316002)(86362001)(8936002)(8676002)(41300700001)(38070700005)(66556008)(64756008)(66476007)(66899021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EjIFPBvArpL44Ylx1XCA2juHGtP3rSrpCJE6C8Qzym1SX5QeUnK6arEKps1r?=
 =?us-ascii?Q?IhD3F3a/8RKGHHGsccuIZfZYVweRHRcaGbWpMyknf5NNFd/yqgXXN+lSEGZ+?=
 =?us-ascii?Q?ktUEy8NOiqus3K9nrMxDn9VtaJpylQOG/XUA97QXIysf25zX902miR3veXiJ?=
 =?us-ascii?Q?yn/KN10VOb6thmLEnrdIhnovS6vnb160JBs7bc39VncRFi3fKZehlVSrmUPu?=
 =?us-ascii?Q?ueAfQNqjvVBm/N2fLi6Jh4WL/O7VFKJxq5stDAva6691PSPntLhuZGrib3Eo?=
 =?us-ascii?Q?LFIpxRP7s4rx6nn+G/w3C0C886xIuC2/KP3rBHFX/1ZS/iYv5KpnLMDNSkpi?=
 =?us-ascii?Q?zsH/t1JKRxYICD+Mr75YUw+Sa/PYg5Addaoxb9eVvoi9NmK329G0b8N8gjdT?=
 =?us-ascii?Q?ERdoIm8aV70fcnsfwUcUUaNJtVc6aoBAKlc4cq4ulZBlnw+GMMOZt6zKRD2N?=
 =?us-ascii?Q?bTYh3ZVIiP/JrBN8o1ZuosmgMPGHZzaz+bOMdbZdCzlpuONKVXDMmrszhqMK?=
 =?us-ascii?Q?r/SulFJWIlOBuPb3kMSq5mhxhOsGslWgY1aMFzND5DrpsEIlb/lzAuIBkIZk?=
 =?us-ascii?Q?krpBEvgQh6TVbGR5sH2a+zXTSDRD9o069jbBeNVtpWCD+oNyNkcEq/sgFATf?=
 =?us-ascii?Q?RKYBD+godyj+8MF54rI6d+FxkfXZ9nEAddDR9bU5a6sQqeM+mLPxYXdZkgdl?=
 =?us-ascii?Q?U9T+5CaSMn9Hv4xhjfumC1RkuUiSDClUNGWQmVKsKJFc0XdiHRgdPJ3ercHC?=
 =?us-ascii?Q?yM7kwgpKdUH0fw2H/Smx2VAiPZlpcT9VDQdIVdkK6Q8AitaYeN0osRymsZZ3?=
 =?us-ascii?Q?uLbbG9PabwxrtvuNlGvuy2MvL8WnSu2Q7AmwKXEQKnJkDSfGOTA12XJ23YjM?=
 =?us-ascii?Q?wj2dC/0bdMVXWYASww6pjEU0mFWzQvJ7uQKdMx+2SYId/Bohm3jVIqn3vsAO?=
 =?us-ascii?Q?HTKP+L6QiJSQ7geTV2Mn9FmMpde+CZLP2V8eugIsSoShY+Cq9DSoaohuIGSB?=
 =?us-ascii?Q?oOklTnmKAsMuyzuwxImjuursTO2dvlj6bjG8jCRlbR0J9wFXgwikyMMdAUqP?=
 =?us-ascii?Q?KahZiSUn2zD3wAtPcvTgOc6UwR4LX4sG08b+6kXMzKAMnQ2F0hG7GAduRYZo?=
 =?us-ascii?Q?K54TpwiYdxXxnbPwVyJY5XLoxZDR1i6bS12uziiUlFKVR6SwivaY5Lk2TgW0?=
 =?us-ascii?Q?5yItA+/QWekd8MIF5LKBWI+kuv/QrA8r8lmqf3mIE3LOdkQ1Zg7Z5+R8i/Fk?=
 =?us-ascii?Q?7wA8CIxaigjT8jq7wOWO44hnohtWw/a/3QhTjI4mCxtCX2iKFlTF1e39rfTP?=
 =?us-ascii?Q?Wkm0UIednSR+jxJWylTqyaKxbRu+nJmak1Jsq/CwnsQu1vOZLaz+VUTeBnWK?=
 =?us-ascii?Q?ywDr738kmVF9TGXg8ZY5kcu+D+d997NBIpEuuXztgTDKmSOkqJGa+Ae6JaVB?=
 =?us-ascii?Q?lYvZFCj4zri3k8kXgs9sZr5gIBY49k0v1yg/IoZL66Sj5Z0NiR0myfSiumkB?=
 =?us-ascii?Q?4/lQHPYWHuFELwVtDT3NLIdkO1zqDoL4wNwRvSjmnBl8oHOhInKeNulPDStP?=
 =?us-ascii?Q?iHsOdJssU0I/Zg+Dm48=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c90fa49-c9a5-4faa-6ae9-08db763f88a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 12:19:05.0199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Dg8MEbD0704lShaLevNvw3YonfCdqLRNi+lNZ5Nldr4Kd8wUgN460IKgvBAoMKsrjOT7xCP/2cBrUB3dCeHHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6922
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio-dev] Re: [virtio-comment] [RFC
 PATCH] admin-queue: bind the group member to the device



> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Monday, June 26, 2023 6:51 AM
>=20
> On Mon, 26 Jun 2023 17:56:01 +0800, "Zhu, Lingshan"
> <lingshan.zhu@intel.com> wrote:
> >
> >
> > On 6/26/2023 5:16 PM, Xuan Zhuo wrote:
> > > On Mon, 26 Jun 2023 16:59:48 +0800, "Zhu, Lingshan"
> <lingshan.zhu@intel.com> wrote:
> > >>
> > >> On 6/26/2023 4:09 PM, Xuan Zhuo wrote:
> > >>> On Mon, 26 Jun 2023 15:57:33 +0800, "Zhu, Lingshan"
> <lingshan.zhu@intel.com> wrote:
> > >>>> On 6/26/2023 3:08 PM, Xuan Zhuo wrote:
> > >>>>> On Mon, 26 Jun 2023 14:43:17 +0800, "Zhu, Lingshan"
> <lingshan.zhu@intel.com> wrote:
> > >>>>>> On 6/26/2023 2:22 PM, Xuan Zhuo wrote:
> > >>>>>>> The VFs of the SR-IOV are created by the user inside the guest
> > >>>>>>> OS, so the virtio devices don't know about these VFs. Because
> > >>>>>>> each VF may be assigned a different role by the user, the virti=
o device
> can not choose one VF to bind random.
> > >>>>>>> So only the user knows how to bind the virtio devices to the VF=
s.
> > >>>>>>> On the other hand, generally the virtio devices are not
> > >>>>>>> created by the user inside the guest OS. This requires some
> management platform to participate.
> > >>>>>>>
> > >>>>>>> So the usage of this command:
> > >>>>>>> 1. The user purchases a virtio network card on the management
> platform,
> > >>>>>>>        and sets the ip, queue number, etc. The user obtains the=
 identity
> of
> > >>>>>>>        the network card.
> > >>>>>>> 2. The user creates a VF with echo 8 > sriov_numvfs 3. The
> > >>>>>>> user binds the net crad to a VF with identity through the comma=
nd
> > >>>>>>>        of the patch
> > >>>>>>>
> > >>>>>>> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > >>>>>>> ---
> > >>>>>>>      admin.tex | 41 ++++++++++++++++++++++++++++++++++++++++-
> > >>>>>>>      1 file changed, 40 insertions(+), 1 deletion(-)
> > >>>>>>>
> > >>>>>>> diff --git a/admin.tex b/admin.tex index 2efd4d7..64d0667
> > >>>>>>> 100644
> > >>>>>>> --- a/admin.tex
> > >>>>>>> +++ b/admin.tex
> > >>>>>>> @@ -115,7 +115,8 @@ \subsection{Group administration
> commands}\label{sec:Basic Facilities of a Virti
> > >>>>>>>      \hline \hline
> > >>>>>>>      0x0000 & VIRTIO_ADMIN_CMD_LIST_QUERY & Provides to driver
> list of commands supported for this group type    \\
> > >>>>>>>      0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device li=
st
> of commands used for this group type \\
> > >>>>>>> -0x0002 - 0x7FFF & - & Commands using \field{struct
> virtio_admin_cmd}    \\
> > >>>>>>> +0x0002 & VIRTIO_ADMIN_CMD_BIND_DEVICE & Bind the device to
> one group member \\
> > >>>>>>> +0x0003 - 0x7FFF & - & Commands using \field{struct
> virtio_admin_cmd}    \\
> > >>>>>>>      \hline
> > >>>>>>>      0x8000 - 0xFFFF & - & Reserved for future commands (possib=
ly
> using a different structure)    \\
> > >>>>>>>      \hline
> > >>>>>>> @@ -429,6 +430,44 @@ \subsection{Group administration
> commands}\label{sec:Basic Facilities of a Virti
> > >>>>>>>      \field{VF Enable} refer to registers within the SR-IOV Ext=
ended
> > >>>>>>>      Capability as specified by \hyperref[intro:PCIe]{[PCIe]}.
> > >>>>>>>
> > >>>>>>> +\subsubsection{Bind the device for member}
> > >>>>>>> +
> > >>>>>>> +The VFs of the SR-IOV are created by the user inside the
> > >>>>>>> +guest OS, so the virtio
> > >>>>>> If the VFs are create in a guest OS, I assume that means the
> > >>>>>> user has passthrough-ed the PF to the guest. For nested, I am
> > >>>>>> not sure whether this is a security issue(affects host pci).
> > >>>>> No care about the passthrough, we always created VFs by the PF.
> > >>>>>
> > >>>>> I should not say "inside the guest OS". I just want to say that
> > >>>>> the VF is create by the user in the OS. The devices does not know
> about it.
> > >>>> OK, perhaps just say create VFs from a PF in the OS?
> > >>> YES.
> > >>>
> > >>>
> > >>>>>>> +devices don't know about these VFs. Because each VF may be
> > >>>>>>> +assigned a different role by the user, the virtio device can n=
ot
> choose one VF to bind random.
> > >>>>>> I failed to understand this, once a VF is created, it has a
> > >>>>>> personality, e.g., create a virtio-net VF from a virtio-net PF,
> > >>>>>> and PF knows that.
> > >>>>>>
> > >>>>>> I am not familiar with the background, What do you mean by
> > >>>>>> virtio device choose one VF to bind?
> > >>>>> On the cloud, the nic is created by the management platform, the
> > >>>>> user can not create a new nic inside the OS.
> > >>>>>
> > >>>>> So after echo sriov_numvfs, the user just got some VFs, there is
> > >>>>> not backend virtio-net devices.
> > >>>> I think it is not a "user" mange the VFs, the VFs usually
> > >>>> provisioned by the orchestration software and it assign properly
> > >>>> selected a VF to a guest on demands.
> > >>> Yes, but we do not need to care about the guest. Because VF may
> > >>> only be used in host, such as docker.
> > >>>
> > >>> The problem is that the user (you can think of this as the
> > >>> orchestration
> > >>> software) creates some VFs, these are only some PCI devices, which
> > >>> virtio devices will work on these VFs. I think that creating a vf
> > >>> and creating a virtio-net device are two different things. One is
> > >>> done by user in the OS, one is done on the management platform.  So=
 we
> need to bind them together.
> > >> If the VFs are created through sriov_numvfs, once created, the VF
> > >> device and its personality are determined.
> > >>
> > >> PCI spec says:
> > >> All VFs associated with a PF must be the same device type as the
> > >> PF, (e.g., the same network device type or the same storage device
> > >> type.)
> > >>
> > >> So how can the creating process be splitted into separated steps?
> > >>
> > >> Are we discussing something beyond the spec?
> > > NO.
> > >
> > > The device types are same.
> > >
> > > How do we configure the ip, mac, etc of the virtio-net device? In
> > > the cloud, these are managed by the management platform. On the
> > > cloud, there is an abstract object in the backend, which contains
> > > things that are generally configured on the management platform. It i=
s
> something that users purchase.
> > > Under the virtio standard it is similar to device.
> > >
> > > In my understanding, we just created a pci vf, and virtio works on
> > > top of pci, so there must be two steps here (If I mistake, please
> > > point out.). When we create a vf, it doesn't mean that the backend
> > > deivce is ready. Of course, in some scenarios, we can immediately
> > > have a backend default device respond when the driver probe the vf.  =
But in
> our scenario, each device is independent.
> > Once a VF is crated, there comes with some default configurations,
> > like MTU and MAC.
> > Do you mean first step creation and second step initialize it?
>=20
> Not exactly correct,
>=20
> The first step is just to create a vf, at this time there can be a defaul=
t virtio-net, it
> doesn't matter.
>=20
> In the second step, we can bind a backend device to this vf.
>=20
> Not just for initialization for new divice, we also want to support live =
migration.
>=20
> For example, on the host, we create a vf and passthrough it into a guest =
os, this
> guest is migrated from another host, and its corresponding network card i=
s also
> migrated to this host. We need to bind this vf to the migrated network ca=
rd.
>=20
> So just initialization is not enough.
>

Yet to catch up on the thread, so likely I am missing something.

The flow is for one OS (Linux) is:
1. user enable SR-IOV on the PF device in a host, which creates SR-IOV VFs =
in the device.
(num_vfs and vf enable bit in the PCI capability)

2. VFs are created at the PCI level in the host system and also inside the =
device

3. A user on the host may bind these VFs to the VF driver (virtionet/blk or=
 vfio or vp_vdpa or some other)

Between step #2 and #3, a user may configure one or multiple attributes of =
the VF.
This includes feature bits, config space fields, vf msix vectors and more.
This is to be using admin command.
These admin commands definition is due.


=20
> Thanks
>=20
> > If so, current spec only allow the user to config MAC through control v=
q.
> > vDPA allows to provision a device with proper configuration, maybe
> > that can be the solution?
> >
> > For binding, maybe the orchestration layer manages the pool and it
> > knows how to initialize the device
> >
> > Thanks
> > >
> > > Thanks.
> > >
> > >> Thanks
> > >>> Thanks.
> > >>>
> > >>>
> > >>>
> > >>>> So I am confused what the intention of this patch.
> > >>>>> Thanks.
> > >>>>>
> > >>>>>
> > >>>>>>> +So only the user knows how to bind the virtio devices to the V=
Fs.
> > >>>>>>> +On the other hand, generally the virtio devices are not
> > >>>>>>> +created by the user inside the guest OS. This requires some
> management platform to participate.
> > >>>>>>> +
> > >>>>>>> +So we introduce a new admin queue command to bind the VFs and
> > >>>>>>> +the virtio devices.
> > >>>>>> Sorry, failed to process this. Maybe an orchestration sw layer c=
an
> help?
> > >>>>>> Provision a device on demands and assign it to a guest?
> > >>>>>>
> > >>>>>> Thanks
> > >>>>>>> +
> > >>>>>>> +\begin{lstlisting}
> > >>>>>>> +struct virtio_admin_cmd_bind {
> > >>>>>>> +    u64 identity;
> > >>>>>>> +};
> > >>>>>>> +\end{lstlisting}
> > >>>>>>> +
> > >>>>>>> +The user got the \field{identity} from the management
> > >>>>>>> +platform, that is not included by this spec.
> > >>>>>>> +
> > >>>>>>> +\drivernormative{\paragraph}{Group administration
> > >>>>>>> +commands}{Basic Facilities of a Virtio Device / Device groups
> > >>>>>>> +/ Group administration commands / Bind the device for member}
> > >>>>>>> +
> > >>>>>>> +VIRTIO_ADMIN_CMD_BIND_DEVICE requires that the
> \field{group_member_id} MUST be set.
> > >>>>>>> +
> > >>>>>>> +The \field{identity} is passed by the user. It is the
> > >>>>>>> +identity of the virtio device.
> > >>>>>>> +
> > >>>>>>> +\devicenormative{\paragraph}{Group administration
> > >>>>>>> +commands}{Basic Facilities of a Virtio Device / Device groups
> > >>>>>>> +/ Group administration commands / Bind the device for member}
> > >>>>>>> +
> > >>>>>>> +Every device MUST have one unique \field{identity} in the host=
.
> > >>>>>>> +
> > >>>>>>> +If the PF device can not find the device by the
> > >>>>>>> +\field{identity}, the \field{status} MUST be set to
> VIRTIO_ADMIN_STATUS_EINVAL.
> > >>>>>>> +
> > >>>>>>> +If the device is found by the \field{identity}, the device
> > >>>>>>> +MUST work as the device of this group member specified by the
> \field{group_member_id}.
> > >>>>>>> +
> > >>>>>>>      \section{Administration Virtqueues}\label{sec:Basic
> > >>>>>>> Facilities of a Virtio Device / Administration Virtqueues}
> > >>>>>>>
> > >>>>>>>      An administration virtqueue of an owner device is used to
> > >>>>>>> submit
> > >>>>> This publicly archived list offers a means to provide input to
> > >>>>> the OASIS Virtual I/O Device (VIRTIO) TC.
> > >>>>>
> > >>>>> In order to verify user consent to the Feedback License terms
> > >>>>> and to minimize spam in the list archive, subscription is
> > >>>>> required before posting.
> > >>>>>
> > >>>>> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > >>>>> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > >>>>> List help: virtio-comment-help@lists.oasis-open.org
> > >>>>> List archive:
> > >>>>> https://lists.oasis-open.org/archives/virtio-comment/
> > >>>>> Feedback License:
> > >>>>> https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > >>>>> List Guidelines:
> > >>>>> https://www.oasis-open.org/policies-guidelines/mailing-lists
> > >>>>> Committee: https://www.oasis-open.org/committees/virtio/
> > >>>>> Join OASIS: https://www.oasis-open.org/join/
> > >>>>>
> > >>>> This publicly archived list offers a means to provide input to
> > >>>> the OASIS Virtual I/O Device (VIRTIO) TC.
> > >>>>
> > >>>> In order to verify user consent to the Feedback License terms and
> > >>>> to minimize spam in the list archive, subscription is required
> > >>>> before posting.
> > >>>>
> > >>>> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > >>>> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > >>>> List help: virtio-comment-help@lists.oasis-open.org
> > >>>> List archive:
> > >>>> https://lists.oasis-open.org/archives/virtio-comment/
> > >>>> Feedback License:
> > >>>> https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > >>>> List Guidelines:
> > >>>> https://www.oasis-open.org/policies-guidelines/mailing-lists
> > >>>> Committee: https://www.oasis-open.org/committees/virtio/
> > >>>> Join OASIS: https://www.oasis-open.org/join/
> > >>>>
> > >>> ------------------------------------------------------------------
> > >>> --- To unsubscribe, e-mail:
> > >>> virtio-dev-unsubscribe@lists.oasis-open.org
> > >>> For additional commands, e-mail:
> > >>> virtio-dev-help@lists.oasis-open.org
> > >>>
> > > This publicly archived list offers a means to provide input to the
> > > OASIS Virtual I/O Device (VIRTIO) TC.
> > >
> > > In order to verify user consent to the Feedback License terms and to
> > > minimize spam in the list archive, subscription is required before
> > > posting.
> > >
> > > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > > List help: virtio-comment-help@lists.oasis-open.org
> > > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > > Feedback License:
> > > https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > > List Guidelines:
> > > https://www.oasis-open.org/policies-guidelines/mailing-lists
> > > Committee: https://www.oasis-open.org/committees/virtio/
> > > Join OASIS: https://www.oasis-open.org/join/
> > >
> >

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

