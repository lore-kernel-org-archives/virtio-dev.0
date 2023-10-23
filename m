Return-Path: <virtio-dev-return-14012-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33EFC25B41
	for <virtio-dev@archiver.kernel.org>; Mon, 23 Oct 2023 06:00:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 1F5FA71C95
	for <virtio-dev@archiver.kernel.org>; Mon, 23 Oct 2023 06:00:56 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 116A198698B
	for <virtio-dev@archiver.kernel.org>; Mon, 23 Oct 2023 06:00:56 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 03519986697; Mon, 23 Oct 2023 06:00:56 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E3185986665;
	Mon, 23 Oct 2023 06:00:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WOfS4Uv++U5a7uFaKpRttrNO/erMQPvgj3filPw14jVKRwOaO96pEC+8H3g+s/tyx0n+BxKHMRQZ93JozGITjHJTP205/rwhpk3ZHH2at2+uW+mz8Ni2rx8wo03neQhzkeyPugKXLu0nU3iIucnSiLc0hukmhcrdQ2p2+Jc+o7NKO1VbnW0tAFTrkt/6252vGl2F+0Wh62OWsS1JAi1w13OfUCgW1GC6ddkcSOSkksk/IYXpaRaryqKGYT59KRBUKPAg2ZgvA62mbd89UXB3eQaJLwunPtoSnwxwxSqUnezr0J1+xK1zMt9+hRZTE8OVYAEFcp+zXH8toQ60++icrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jm3QpyYatktBMUV9u5szBAKYtnLRy+e+Uqf5YmSaBzM=;
 b=AGs5VMTTrZxOtH9gVeJ08so1ZWWZlnUglpvoEIjDXUQagFkLwGBNY+V7NSRtqmeqe/+MfPfBZ/EDRRQfzgmzUu5xJbAICCIjgH48Ha1xG58wYqILfsgM2DzmK/VmnndMz0qSYGmKay0zSyXReuBjFgoXApmuPapJ5/3OZhQKgOWNiAPXnFr/jNVG6f/l+AWJ5zY2AmHqvrNpMgit5pG4AwCe7P7YvMuMDtVXwo8pDUWU/T61IHvGK/7oCkEjjk1wBi5HGH8jJfW/HBgt4njKqKSEDcAVc1jO4sFyOt6nXQpr9nAU0MQ/sABAdoRuKPviKa9S/cAf0PaaZSpSIQgeEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Jiqian Chen <Jiqian.Chen@amd.com>, "Michael S . Tsirkin" <mst@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan
 Zhuo <xuanzhuo@linux.alibaba.com>, David Airlie <airlied@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>,
	=?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@gmail.com>, Robert
 Beckett <bob.beckett@collabora.com>, Mikhail Golubev-Ciuchea
	<Mikhail.Golubev-Ciuchea@opensynergy.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
CC: Honglei Huang <Honglei1.Huang@amd.com>, Julia Zhang <Julia.Zhang@amd.com>,
	Huang Rui <Ray.Huang@amd.com>
Thread-Topic: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES
Thread-Index: AQHaA9H0ua9xMq0gbkqU60djCdCUsrBW4XZQ
Date: Mon, 23 Oct 2023 06:00:48 +0000
Message-ID:
 <PH0PR12MB548182FF345FE7D1DE0D89C1DCD8A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20231021035111.650248-1-Jiqian.Chen@amd.com>
 <20231021035111.650248-2-Jiqian.Chen@amd.com>
In-Reply-To: <20231021035111.650248-2-Jiqian.Chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MW4PR12MB6899:EE_
x-ms-office365-filtering-correlation-id: c1dd048b-2c47-4202-cff4-08dbd38d6755
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 krCuWy6fTXftqDGYEYw7fK61Ixlue6A5s49jJ/UOCEF1Z0pDdeQNb5pI8vuaJp+EKdY8jDRokR/jFZZZI0HpjpLvI884bYOmarusGq0RwI3DrpfXMz3WvBg+LRKLQLxCcr/IVm292LkXOb3akqvUbXTVLrN92LuZJ58ofAF6487YBhCzpO9ZAuQ7wHR2PhKQIjRvYx/YETGRpjv+AUfXeW8B/nA2TsPeaxRaNz8HSUWJ9wQnuPT3cIdJCS+X9qbO+BOSL72/zz1/YJt+SYx5q2n26Ki8va7BXoj0oNc/7Yw+mo8/yKfSVEdIfS2EyRk3KsktruVBzQlQjLMy8E2modXyslAGXFS+0bbMDYILF03iWEdY5N8fbxuThpZEwLHVqzmnhiF/eI+pdiwNoEObO8gfiKUBw6MSR5+ld5Itf4d5ET9e9akl0QKStEV1B6r6m68G+gaTiVDJBM4zwk7TMz6FenWkbf4ZaL8nscU0la9ZcRWuhVfZJbQdWwFDDbQ7j5cy4xMlZbjxKuB2ets/BGfGD0qvc3gQB5hiNwoM/4M81dh77r6dqBGpyrM7q+rCeP+y3yysh0VHzxTjHeFzNfQQSseBo/RwghZ2BszvGkWA9wpGzSY8drYPczfsMEcCpZJMFkpJ/uMHQjCOiBzjzg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(346002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(83380400001)(53546011)(55236004)(26005)(9686003)(71200400001)(6506007)(7696005)(33656002)(38070700009)(86362001)(122000001)(38100700002)(921008)(4326008)(41300700001)(52536014)(8936002)(8676002)(478600001)(5660300002)(2906002)(7416002)(66556008)(66476007)(66446008)(54906003)(64756008)(110136005)(76116006)(55016003)(66946007)(316002)(66899024);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?X6y/Od83N+dYFzMcc8H+C5OSqukkvtrhZzK+X6pp7YeU4h1LiPl+khvq1a?=
 =?iso-8859-1?Q?RbJ4rp1goRQPXDyRF3eR2TyeAD5PrAZux0G/5HiAD/bbUwPXWbMExuI8Mc?=
 =?iso-8859-1?Q?RUkR+iyu+mUqsCyEE09MHU9nPE6i8F04HZxp4DkBePHPfVgCQp22sHNdVg?=
 =?iso-8859-1?Q?grzLvA0eXZ0o0f80Wr0YlHg6mZ3ZdnXZdWROBO7PkgCPihW3resaYFXgwR?=
 =?iso-8859-1?Q?VjFiHpOUeCr+eRMGx27Y/uG3WAHC1huNvjZe2cN2i3KrYauozpLd5cxZsi?=
 =?iso-8859-1?Q?7EIrBsMxagLpT/jVXiY9pEqh4+MYkusnrZsm1DkmWYLesuwevteCF5I54g?=
 =?iso-8859-1?Q?fEAx0Q/RHZgPKCmfF8ablRBgiVGqXxP8MQNG98+onglcL9LZfJj8UmtVc0?=
 =?iso-8859-1?Q?xHWBTWKKR8ahcfUSMD/i8WdB7I7VJx+FwGg2TGipkxF78QiXLJBb903AeS?=
 =?iso-8859-1?Q?IMSY3QU8Ne55qg5fgYevzyFhqZAzx4l+7toWFGbOS17OxgzkDVa04ZBV68?=
 =?iso-8859-1?Q?UcFSn1UcUIXvIpQdyKzmJhBTdOnRphbnuviOlwFQHZNEbUsgjuFmPtWPx3?=
 =?iso-8859-1?Q?jvqjgRItXZUYa4+XXgnI6QUOFZPXLc0O+Mx3ra6ZL8zLuW2lSGnBEgCE6x?=
 =?iso-8859-1?Q?Ca2yQvbzm72rgBIReVC/B95sHFvNovPTSJUwRqNrMESdOer17yEB2wN5oj?=
 =?iso-8859-1?Q?TgdOiXd0J9SF9AxVHZHjx09ENGvbmdpFynQnO+yU8R3R3aq2Xaar2RqCM2?=
 =?iso-8859-1?Q?nFR15ZCv9J3rRxyVJGMFZfMBi00AsbLjhdZDOVSA1bh9kuIIBAGnaflypx?=
 =?iso-8859-1?Q?xW7boGnkIvNbDk7+QqELDxRZLRJ0UQa2R+kkQcNFJuwYByuA693SYNzRyN?=
 =?iso-8859-1?Q?FZ8RxKsBCcqAKpVFNACjqtvM97ovf0sw6SvBU5eRk1WacqtcMDgGiTO+eL?=
 =?iso-8859-1?Q?X+IUpFG1oxp90RgyM/dsOnTRglxudtG34HxudXQ9a+v40690hHybDCX38q?=
 =?iso-8859-1?Q?hcr2d34aNf7sc4O+JpbAMj4+/j9bLmYPR8djk6BbthwKcKPayA4AUGNK4I?=
 =?iso-8859-1?Q?TlVpRr1V3YbvPhC8n+M0fpMlZGbxfA2Il6v0e7Ge90IrpnQ2vfqwKW0afv?=
 =?iso-8859-1?Q?uVDGL9QrogCF3Mn+RoMXAYixu7wz4HO32pwYFfOj2eQFa2aFcE6K2uBqvN?=
 =?iso-8859-1?Q?gO1v6Eiz50peYR/LuDnZnqnreUCV3vgNBF3Fcfrd8RBbd3N4YjIgwMscp9?=
 =?iso-8859-1?Q?vT9esrdp3gGJGku80pA9rI/g/+SwnwJyPdqW/WsJd0g9EdQtloAPP7MBlg?=
 =?iso-8859-1?Q?4MDkhw0iOV1q6Hkf+Y101D4Nnak8Z8REXNwa3Q5fzqzRzi0mKb3CBG4bfy?=
 =?iso-8859-1?Q?CM8iMSCOZVLuUdGL4fmcReCy6AiX1EvKivs6ZGrNRe8q7P8J2X2mt73FUJ?=
 =?iso-8859-1?Q?QU0OsyJFUGZN5KuPftn5k2i12q9ZH0juCIdZI36tddFTTtamGGVmvxPOuz?=
 =?iso-8859-1?Q?3IGrQDKsiASHqFpEPjv89Vm3GXvh98EIkE+keQZs15wD0X/knHnqwX4Lgu?=
 =?iso-8859-1?Q?ATtc2IKjO62K5mickuXbaJPFQnZDvoPrF7x7JfokmLH1GatbWdcKJqWuk+?=
 =?iso-8859-1?Q?N9Fy2cwNtoAus=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1dd048b-2c47-4202-cff4-08dbd38d6755
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 06:00:48.0409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MQ+qLSJ3T0js3mniK43dVoBdvdP5iI3sefaGWpiz9Mfr5bQoizN6HKlkpKgit7HlCAN0LYYhudD7VxBtKFiBcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6899
Subject: [virtio-dev] RE: [PATCH v6 1/1] content: Add new feature
 VIRTIO_F_PRESERVE_RESOURCES

Hi Jiqian,

> From: Jiqian Chen <Jiqian.Chen@amd.com>
> Sent: Saturday, October 21, 2023 9:21 AM
> To: Michael S . Tsirkin <mst@redhat.com>; Gerd Hoffmann
> <kraxel@redhat.com>; Parav Pandit <parav@nvidia.com>; Jason Wang
> <jasowang@redhat.com>; Xuan Zhuo <xuanzhuo@linux.alibaba.com>; David
> Airlie <airlied@redhat.com>; Gurchetan Singh
> <gurchetansingh@chromium.org>; Chia-I Wu <olvaffe@gmail.com>; Marc-
> Andr=E9 Lureau <marcandre.lureau@gmail.com>; Robert Beckett
> <bob.beckett@collabora.com>; Mikhail Golubev-Ciuchea <Mikhail.Golubev-
> Ciuchea@opensynergy.com>; virtio-comment@lists.oasis-open.org; virtio-
> dev@lists.oasis-open.org
> Cc: Honglei Huang <Honglei1.Huang@amd.com>; Julia Zhang
> <Julia.Zhang@amd.com>; Huang Rui <Ray.Huang@amd.com>; Jiqian Chen
> <Jiqian.Chen@amd.com>
> Subject: [PATCH v6 1/1] content: Add new feature
> VIRTIO_F_PRESERVE_RESOURCES
>=20
> In some scenes, Qemu may reset or destroy resources of virtio device, but=
 some
> of them can't be re-created, so that causes some problems.
>=20
It can be re-created. It is just that the guest driver lost the previous re=
source values.
So a better wording for the motivation is combining with below line to me i=
s,

Currently guest drivers destroy and re-create virtio resources during power=
 management suspend/resume sequence respectively.
For example, for a PCI transport, even if the device offers D3 to d0 state =
transition, a virtio guest driver has no way to know if=20
the device can store the state during D0->D3 transition and same state can =
be restored on D3->D0 transition.

> For example, when we do S3 for guest, guest will set device_status to 0, =
it
> causes Qemu to reset virtioi-gpu device, and then all render resources of=
 virtio-
> gpu will be destroyed. As a result, after guest resuming, the display can=
't come
> back, and we only see a black screen.
>=20
To make guest drivers aware of above device capability, introduce a new fea=
ture bit to indicate such device capability.
This patch adds...

> In order to deal with the above scene, we need a mechanism that allows gu=
est
> and Qemu to negotiate their behaviors for resources. So, this patch adds =
a new
> feature named VIRTIO_F_PRESERVE_RESOURCES. It allows guest to tell Qemu
> when there is a need to preserve resources, guest must preserve resources=
 until
> 0 is set.
>=20
I think this can be done without introducing the new register.
Can you please check if the PM register itself can serve the purpose instea=
d of new virtio level register?

> Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
> ---
>  conformance.tex   |  2 ++
>  content.tex       | 25 +++++++++++++++++++++++++
>  transport-pci.tex |  6 ++++++
>  3 files changed, 33 insertions(+)
>=20
> diff --git a/conformance.tex b/conformance.tex index dc00e84..60cc0b1
> 100644
> --- a/conformance.tex
> +++ b/conformance.tex
> @@ -91,6 +91,7 @@ \section{Conformance Targets}\label{sec:Conformance /
> Conformance Targets}  \item \ref{drivernormative:Basic Facilities of a Vi=
rtio
> Device / Packed Virtqueues / The Virtqueue Descriptor Table / Indirect
> Descriptors}  \item \ref{drivernormative:Basic Facilities of a Virtio Dev=
ice /
> Packed Virtqueues / Supplying Buffers to The Device / Updating flags}  \i=
tem
> \ref{drivernormative:Basic Facilities of a Virtio Device / Packed Virtque=
ues /
> Supplying Buffers to The Device / Sending Available Buffer Notifications}
> +\item \ref{drivernormative:Basic Facilities of a Virtio Device /
> +Preserve Resources}
>  \item \ref{drivernormative:General Initialization And Device Operation /
> Device Initialization}  \item \ref{drivernormative:General Initialization=
 And
> Device Operation / Device Cleanup}  \item \ref{drivernormative:Reserved
> Feature Bits} @@ -172,6 +173,7 @@ \section{Conformance
> Targets}\label{sec:Conformance / Conformance Targets}  \item
> \ref{devicenormative:Basic Facilities of a Virtio Device / Packed Virtque=
ues /
> The Virtqueue Descriptor Table}  \item \ref{devicenormative:Basic Facilit=
ies of
> a Virtio Device / Packed Virtqueues / Scatter-Gather Support}  \item
> \ref{devicenormative:Basic Facilities of a Virtio Device / Shared Memory
> Regions}
> +\item \ref{devicenormative:Basic Facilities of a Virtio Device /
> +Preserve Resources}
>  \item \ref{devicenormative:Reserved Feature Bits}  \end{itemize}
>=20
> diff --git a/content.tex b/content.tex
> index 0a62dce..b6b1859 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -502,6 +502,27 @@ \section{Exporting Objects}\label{sec:Basic Faciliti=
es
> of a Virtio Device / Expo  types. It is RECOMMENDED that devices generate
> version 4  UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
>=20
> +\section{Preserve Resources}\label{sec:Basic Facilities of a Virtio
> +Device / Preserve Resources}
> +
> +As virtio devices are paravirtualization devices by design.
This is not true and not relevant for the spec. Please remove this line.

> +There are various devices resources created by sending commands from
> +frontend and stored in backend.
> +
> +In some scenes, resources may be destroyed or reset, some of them can
> +be re-created since frontend has enough information , but some can't.
> +At this case, we can set \field{Preserve Resources} to 1 by specific
> +transport, to prevent resources being destroyed.
> +
> +Which kind of resources need to be preserved and how to preserve
> +resources depend on specific devices.
s/on specific devices/on specific device type/

> +
> +\drivernormative{\subsection}{Preserve Resources}{Basic Facilities of a
> +Virtio Device / Preserve resources} A driver SHOULD set \field{Preserve
> +Resources} to 1 when there is a need to preserve resources.
> +
> +\devicenormative{\subsection}{Preserve Resources}{Basic Facilities of a
> +Virtio Device / Preserve resources} A device MUST NOT destroy resources =
until
> \field{Preserve Resources} is 0.
> +
>  \input{admin.tex}
>=20
>  \chapter{General Initialization And Device Operation}\label{sec:General
> Initialization And Device Operation} @@ -872,6 +893,10 @@
> \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
>  	\ref{devicenormative:Basic Facilities of a Virtio Device / Feature Bits=
}
> for
>  	handling features reserved for future use.
>=20
> +  \item[VIRTIO_F_PRESERVE_RESOURCES(42)] This feature indicates  that
> + the device need to preserve resources.
> +  See \ref{sec:Basic Facilities of a Virtio Device / Preserve Resources}=
.
> +
>  \end{description}
>=20
>  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}=
 diff --
> git a/transport-pci.tex b/transport-pci.tex index a5c6719..f6eea65 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -325,6 +325,7 @@ \subsubsection{Common configuration structure
> layout}\label{sec:Virtio Transport
>          /* About the administration virtqueue. */
>          le16 admin_queue_index;         /* read-only for driver */
>          le16 admin_queue_num;         /* read-only for driver */
> +        le16 preserve_resources;        /* read-write */
Preserving these resources in the device implementation takes finite amount=
 of time.
Possibly more than 40nsec (time of PCIe write TLP).
Hence this register must be a polling register to indicate that preservatio=
n_done.
This will tell the guest when the preservation is done, and when restoratio=
n is done, so that it can resume upper layers.

Please refer to queue_reset definition to learn more about such register de=
finition.

Lets please make sure that PCIe PM level registers are sufficient/not-suffi=
cient to decide the addition of this register.

>  };
>  \end{lstlisting}
>=20
> @@ -428,6 +429,11 @@ \subsubsection{Common configuration structure
> layout}\label{sec:Virtio Transport
>  	The value 0 indicates no supported administration virtqueues.
>  	This field is valid only if VIRTIO_F_ADMIN_VQ has been
>  	negotiated.
> +
> +\item[\field{preserve_resources}]
> +        The driver writes this to let device preserve resources whenever=
 driver
> has demands.
> +        1 - device need to preserve resources which can't be re-created,=
 until 0 is
> set.
> +        0 - all resources can be destroyed.
>  \end{description}
>=20
>  \devicenormative{\paragraph}{Common configuration structure layout}{Virt=
io
> Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common
> configuration structure layout}
> --
> 2.34.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

