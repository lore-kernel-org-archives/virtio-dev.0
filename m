Return-Path: virtio-dev-return-6756-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 33AF6984347
	for <virtio-dev@lists.oasis-open.org>; Mon, 17 Feb 2020 18:22:04 +0000 (UTC)
Date: Mon, 17 Feb 2020 19:21:50 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
Message-ID: <20200217192150.07f9e253@collabora.com>
In-Reply-To: <CAFNex=BuHdsEjFK3_cTqO2nOE-kB_MSH26sCTekF_6AK8Fyv3Q@mail.gmail.com>
References: <20200207182842.770bfb27@collabora.com>
	<20200217145835.0bd7b028@collabora.com>
	<CAFNex=BuHdsEjFK3_cTqO2nOE-kB_MSH26sCTekF_6AK8Fyv3Q@mail.gmail.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [RFC] Upstreaming virtio-wayland (or an alternative)
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: Zach Reizner <zachr@google.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Zach Reizner <zachr@chromium.org>, David Stevens <stevensd@chromium.org>, =?UTF-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tomasz Figa <tfiga@chromium.org>, virtio-dev@lists.oasis-open.org, Alexandros Frantzis <alexandros.frantzis@collabora.co.uk>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 17 Feb 2020 09:47:46 -0800
Zach Reizner <zachr@google.com> wrote:

> > Thats why I don't like the new virtio device idea much and would prefer
> > vhost being reused, either directly (#1) or via proxy (#2).
>=20
> For crosvm's purposes, we are looking at ways to reduce vhost usage in
> order to reduce host kernel exposure to untrusted guest input,
> including from the guest kernel. That is why a non-vhost based
> solution would be prefered.

Okay, I didn't know you were avoiding vhost-based solutions to
reduce the attack surface.

>=20
> > Any potential security hole should be considered IMHO, even if it's not
> > easily exploitable.
>=20
> I second Boris's statement. In the age of Spectre-like exploits,
> keeping secrets from other processes should be considered riskier than
> using FDs to prove that a process can access a resource.
>=20
> > We might be able to do that lazily if we add
> > ->virtio_fd_to_vfd()/->virtio_vfd_to_fd() hooks to the file_operations
> > struct, instead of expecting the subsystem to pro-actively create those
> > mappings (when those hooks are not implemented, that means the resource
> > backed by this FD can't be passed on a VSOCK).
>=20
> virtio-wayland actually will handle passing arbitrary FDs back and
> forth, but it does have special handling for virtio-gpu dmabufs. For
> everything else, virtio-wayland will determine if the FD is
> readable/writable/mappable and will recreate a pipe/memfd on the other
> side to emulate the FD. For mappable FDs, this is limited host->guest
> passing because in practice this is used only by the compositor to
> send the keyboard mapping to clients. The pipes are needed for both
> host->guest and guest->host because they are used to request clipboard
> content. The only FDs that require special handling are ones where
> there already is a host-side FD corresponding to the guest side FD,
> such as the case of wayland socket connections or dmabufs.
>=20
> As for the question of which solution to go for, I would suggest
> either 3 (dedicated virtio device) or combining features from
> virtio-wayland with virtio-gpu. I don't think extending vsock is a
> good idea because there's enough going on with virtio-wayland with
> respect to FD passing and emulation that a generic interface will be
> too opinionated.

Can you be more specific? What would be the limitations of such a
generic interface that would make it unusable for the virtio-wayland
use case?

> I like the combination with virtio-gpu because it
> already has two related but separate graphics concepts combined into
> one device (display and rendering), so wayland would feel right at
> home.

Except that, looking at the virtio-wayland code nothing in there looks
fundamentally wayland specific, or even display-server specific. Sure,
FD passing support is focused on what wayland needs (pipes, dmabuf FDs,
...), but I see nothing that would prevent making it generic enough to
pass other kind of resources if we ever need to.

> Because wayland benefits from allocation and sharing of
> virtio-gpu buffers, a virtio-gpu combo device simplifies access to
> those buffers, whereas the separate virtio devices as implemented in
> crosvm requires bridging of resource handles (in guest kernel) and FDs
> (in crosvm).

I must admit I'm not a huge fan of integrating a protocol-agnostic
message passing interface (with FD-passing support) to virtio-gpu.
Sounds like something that could be re-used without virtio-gpu being
involved to me. As for the resource bridging thing, that's more or less
what I proposed with the generic interface to translate resource handles
(what I called VFDs) to local FDs. It would probably be easier with a
vhost-based solution, but your resource bridge interface in crosvm
seems to provide the same kind of abstraction. Any reason you want to
avoid this split?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

