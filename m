Return-Path: <virtio-dev-return-12420-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E59FC77B7F
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 21:39:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 501C6419B5
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 21:39:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4286698666B
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 21:39:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 36EDC986653; Tue, 25 Apr 2023 21:39:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 244F2986485;
	Tue, 25 Apr 2023 21:39:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtmIThII5liHWQwayJnTs3gotkVdnxAIrd9UUcPAWRREO0KLlyPpHGghEjumRb38/qwpeuwkPcbxQN4KZH3F3zXfuD3NnCmAWymxv2YhuFWdGg1KCz8p/9Puws+mQ+zE6skVV7Gnb/fGmC6xwW1IC4UF70EZ3BF0MIkkDQfQrogWMjwuqUO8XybFVnNTfWLSPmC0In951QwQxeUrTV4eSexCIX/rpb7SDjtYZFaNRIa4Cjq9vWX+Bpy1ggmImWijxxOuGQ85XVuQRXAkgF2bHv1osW5Zf/3LNRYqVzkDpI/uTOOzmeSpnfH17+vjFDsuYaXtpQ4YMZumEGxWR5iPyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n8/H7i+vuvmUKXjMfCfQs1a2bNSWQlJzxneNYLNbxKk=;
 b=asCMglyG/HfCo2LgUWBCQfkFv9Eh9uxZ9lCIT4P4om4+vcEJSnRpTywhQiEX9Vfshn+H0PKBLXNwvWav7z0qC6+5eUsxOiJHZn2bWHMq1ivhDg6S4jYdTNKC8LaIAviJNz8Nnm9Z46yUExnUyPHSLSdIXSX1G6cBc5wYdULhSMt6Sn8n7qQfRj/PuL/+/hYTMDqPRMJmVZVGvHTbdyoFAuvraL6VZVAPQ1ByWG+LKD1unIFJLtG5GMcAPKq+bk82SLBRdTX1QkuEtreAwiGKx6Kz6mXNnBD1vZL3yTTgu/YajYJMB0yR06iUQ+GrySxrRejI8FfruwMaFKVhkEzsOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
CC: Heng Qi <hengqi@linux.alibaba.com>, "virtio-dev@lists.oasis-open.org"
	<virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org"
	<virtio-comment@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yuri
 Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo
	<xuanzhuo@linux.alibaba.com>
Thread-Topic: [virtio-comment] Re: [PATCH v13] virtio-net: support inner
 header hash
Thread-Index: AQHZdbY0vUbPhs5ETkuums+/PkRABq88fZaAgAAKkwCAAABpkA==
Date: Tue, 25 Apr 2023 21:39:28 +0000
Message-ID:
 <PH0PR12MB548148E35F4F0242A71FC5DFDC649@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230423073532.105636-1-hengqi@linux.alibaba.com>
 <f9221063-8419-9cb3-e59c-0b0393bdd501@nvidia.com>
 <20230425170341-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230425170341-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MN0PR12MB5980:EE_
x-ms-office365-filtering-correlation-id: c0554e5c-0095-4c62-90b9-08db45d58c43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jEqe+jQ9KE7n7VUwGIk4dDVGT/zPM8nl542clWs7WHj3e9d5SmGKQAmAjFgA3atsSfc8rQs4Gf0Af7bSnlt7j3tZCflRcJNJuv3zxx1foIF+Fxh9joW033S19xTBX2f+zCuFsz3M6WvwxGZr7KssiVKL9iCYktV+Cf1G4zDQVNW3gipAuqSS2iNafR9ZKznpeAaXutizOoFj3ZeeDh8NgdJVF5MK/IxyxVbhl+zXk8jirOm4oi5fEtDDtvsoSiNWCxY15HLOKuIhhKgxpWvf6eo/M8wfdmYRpIuvfYydGETWcJSKfh/obGzeYAN+Jwc8mAO738rl49pxdvvdBFLOLi4fc/YGqZ1hr66I6/JUZXJIr0a3gKfsg/YgdzqVXjBL7Z43XS+yXEkefhpjgz+ESfL8LN+Iv9gg2GzqLO3OcoB075cPJtLlP/NhjeD2lPz5I9VEe73EdYXWyg5vAwRjaDRoVFZ0Rxv1KoCxwSt52Y84K8H33Nmp5u8ptI3Hgj9M5gRsdbsSWDdNi8PLWAgDjBd+I71ECLImRxS8pbkJ5qt5LIRyezOErtlIueXkeXlZM860173dff40ZInuJKFJQrU102+xqDv1rZpZTtSgOccBND3VVtiC2+7UQiA/a8I9
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199021)(76116006)(64756008)(66446008)(66556008)(66476007)(66946007)(71200400001)(7696005)(6916009)(2906002)(53546011)(8936002)(6506007)(55016003)(186003)(8676002)(41300700001)(9686003)(26005)(5660300002)(316002)(33656002)(52536014)(38070700005)(86362001)(54906003)(38100700002)(4326008)(122000001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?ZWYO1mfBvxhJIFimg0COPOy+2m45J3nvNaqdrOoai9Rj7Yttz8mL2T/cmlSf?=
 =?us-ascii?Q?ruZenVN15qyHYZi1m5L4Zw8J/gCCAZTOW4tj+5FyM9Yf7XSRdn5sj2XyqHBg?=
 =?us-ascii?Q?OOwTLr0yJVGrC6pRBTDAvjJec7OcOfBmkruqr18DEPzoyJtpekApCSr/D+an?=
 =?us-ascii?Q?zCq6qglZE3bit+FgDcihrZNYRqVCojArq3nFkNwcXju7KPxVebia/rFYNK/Z?=
 =?us-ascii?Q?LjpATXfT8Oc0Ng2a3Mtg1caP2AwOsIOPoBjSCfsXYWcXTn+GZ3JHOUoIDBmx?=
 =?us-ascii?Q?NuKsRJ6qanVcPfdCdvxYML7VRLj7qE+2nxczZcB+FfgdEtqEfK8Gdrx7wX6o?=
 =?us-ascii?Q?8H+BQ7RR54Fa9i4URtxxrA+uE2S7l7IvCcUSIz/JpPA7+HW9GULVPLpROaAS?=
 =?us-ascii?Q?5mh3pGZCKIymVgW1Ah8+4d8zoIyImLRiAd+7EfydTc0/Lu5BwiugafMK8FxK?=
 =?us-ascii?Q?1wL4ve1Nz759l+Dl1pihzC8mKb2AZyfB2+jL2K3X1kj2xuwbc1yA1LMpAFla?=
 =?us-ascii?Q?RZvqydMgX441cLhFum0jt+RUHr2p1JpNlVmkzMHKHB9jazm6+UMWxTPss79y?=
 =?us-ascii?Q?xAT+sJkh1mn3uD/7aY31xR/I8VT6gj/l8w97N8clejjAvVI1VEYPUvrhPzt1?=
 =?us-ascii?Q?B9Gc2thOMDdkmuVVKh/q7wexXDpP45jklspv38+Rw+tDwTCKeM4S8nRL73uT?=
 =?us-ascii?Q?FfsdSoyhYMggXg9+YGE1c6jgvy3B5EqVNWgQNWVf4KRxGFpesg+TEjYYBazW?=
 =?us-ascii?Q?qPPtdBb6G3KVEq9Q5VIUT+iI6P25eXIY/s6xiki7/kHbm3pZMR+o4Lq8lwNZ?=
 =?us-ascii?Q?wdWl9dOl/U8S9icA82QxrEvHvBPm4Epe/koNIFCEABOZTbFHZbhK48FyvMmz?=
 =?us-ascii?Q?nY1iUffd/NoqMp0w9ixKeSdatFAN4h9olwDrjvK4i8IzGLm+C581TdFwfOYK?=
 =?us-ascii?Q?pzON2v0uVp9ZIz6cBvHc+vLhpQ9nqO/DnKQ1UE9fNHC/JLkXmghu57grI6+P?=
 =?us-ascii?Q?jJ+2EWdfmt+GCdLJSCE3Z1XHrr5UIuAGWiVVcnrbBl8tp2Z/IhTycYMnqrYU?=
 =?us-ascii?Q?Wcz+MpIrjhwcA/A3rm++3Mh0j8qeaLwm9/KnWPlnpRcZg5jKvI4RVHcGPHkw?=
 =?us-ascii?Q?7Wf+qZGgpvx9ZvnK+51kBcBMY+x2Jvxc4Tqdvn6i7DVVxGj2IsOM5qMjj7z3?=
 =?us-ascii?Q?889vb9PEjFMudE74qloifMnh8439WkfG/c2cJ4vflAeTzUx716zvwYXFjsr/?=
 =?us-ascii?Q?z7SVGrdWMngmDe3TZwMRDITOXAWptXOyM8mubDwZ+fjCCHNAkULQfv+/GhJC?=
 =?us-ascii?Q?l1uoPPffuD+mahheU77yGMGl3mOpydDPA1bJPT7NFfYHg5i54qIoUCgGt6+L?=
 =?us-ascii?Q?CUs4Cgb8KC22H/Mls/ZoMancsawpOl4VoyiPiiYE1C2kg7VxRhUgBdpOqIpC?=
 =?us-ascii?Q?K+/nRSOeePvBdtZt89eogz7KUJVXUuFGT/OPXqRBvaB1ixt03rdib4T616Hn?=
 =?us-ascii?Q?tZ6/pnsU/KrRGTRo+A113Nc8+ji+T8kdh/Xem3Zhucnz4JYYv8+yhSgJAARO?=
 =?us-ascii?Q?r/gTdgqJXbyLjHZvLzs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0554e5c-0095-4c62-90b9-08db45d58c43
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2023 21:39:28.6132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8cEY6I86sebh7KJPbapjzNlTORk3uwF0V+zIvR7Zol5354oEwk5uBmnwda5LqToCs2G3eHRcdEq/3NlnhtPiew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5980
Subject: [virtio-dev] RE: [virtio-comment] Re: [PATCH v13] virtio-net: support inner header
 hash


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Tuesday, April 25, 2023 5:06 PM
> > On 4/23/2023 3:35 AM, Heng Qi wrote:
> > >   \subsubsection{Legacy Interface: Feature bits}\label{sec:Device
> > > Types / Network Device / Feature bits / Legacy Interface: Feature bit=
s} @@
> -198,6 +202,7 @@ \subsection{Device configuration layout}\label{sec:Devic=
e
> Types / Network Device
> > >           u8 rss_max_key_size;
> > >           le16 rss_max_indirection_table_length;
> > >           le32 supported_hash_types;
> > > +        le32 supported_tunnel_hash_types;
>=20
> this needs a comment explaining it only exists with some feature bits.
>=20
Yes, it is already there.
+Field \field{supported_tunnel_hash_types} only exists if the device suppor=
ts inner header hash, i.e. if VIRTIO_NET_F_HASH_TUNNEL is set.
+
I think it should be changed from "device supports" to "driver negotiated".

> > >   };
> > In v12 I was asking this to move to above field from the config area
> > to the GET command in comment [1] as,
> >
> > "With that no need to define two fields at two different places in
> > config area and also in cvq."
>=20
> I think I disagree.
> the proposed design is consistent with regular tunneling.
>=20
Sure.
I understand how config space has evolved from 0.9.5 to know without much a=
ttention, but really expanding this way is not helpful.
It requires building more and more RAM based devices even for PCI PFs, whic=
h is sub optimal.
CVQ already exists and provides the SET command. There is no reason to do G=
ET in some other way.
Device has single channel to provide a value and hence it doesn't need any =
internal synchronization between two paths.

So, if we add a new feature bit as VIRTIO_F_CFG_SPACE_OVER_AQ it is an impr=
ovement.
But it still comes with a cost which device cannot mitigate.
The cost is,=20
1. a driver may not negotiate such feature bit, and device ends up burning =
memory.
1.b Device provisioning becomes a factor of what some guests may use/not us=
e/already using on the live system.

2. Every device needs AQ even when the CVQ exists.

Hence, better to avoid expanding current structure for any new fields, spec=
ially which has the SET equivalent.

But if we want to with the path of VIRTIO_F_CFG_SPACE_OVER_AQ, it is fine.
More things can evolve for generic things like config space over AQ.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

