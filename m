Return-Path: virtio-dev-return-5382-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4DF5A985BE2
	for <virtio-dev@lists.oasis-open.org>; Mon, 11 Feb 2019 07:33:20 +0000 (UTC)
Date: Mon, 11 Feb 2019 02:33:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190211021124-mutt-send-email-mst@kernel.org>
References: <2f0de388-de01-1e51-b6b6-339389a2268a@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <2f0de388-de01-1e51-b6b6-339389a2268a@solarflare.com>
Subject: Re: [virtio-dev] RFC: Doorbell suppression, packed-ring mode and
 hardware offload
To: David Riddoch <driddoch@solarflare.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Feb 01, 2019 at 02:23:55PM +0000, David Riddoch wrote:
> All,
>=20
> I'd like to propose a small extension to the packed virtqueue mode.=A0 My
> proposal is to add an offset/wrap field, written by the driver, indicating
> how many available descriptors have been added to the ring.
>=20
> The reason for wanting this is to improve performance of hardware devices=
.=A0
> Because of high read latency over a PCIe bus, it is important for hardware
> devices to read multiple ring entries in parallel.=A0 It is desirable to =
know
> how many descriptors are available prior to issuing these reads, else you
> risk fetching descriptors that are not yet available.=A0 As well as wasti=
ng
> bus bandwidth this adds complexity.
>=20
> I'd previously hoped that VIRTIO_F_NOTIFICATION_DATA would solve this
> problem,

Right. And this seems like the ideal solution latency-wise since
this pushes data out to device without need for round-trips
over PCIe.

> but we still have a problem.=A0 If you rely on doorbells to tell you
> how many descriptors are available, then you have to keep doorbells enabl=
ed
> at all times.

I would say right now there are two modes and device can transition
between them at will:

1. read each descriptor twice - once speculatively, once
   to get the actual data

   optimal for driver suboptimal for device

2. enable notification for each descritor and rely on
   these notifications

   optimal for device suboptimal for driver



> This can result in a very high rate of doorbells with some
> drivers, which can become a severe bottleneck (because x86 CPUs can't emit
> MMIOs at very high rates).

Interesting. Is there any data you could share to help guide the design?
E.g. what's the highest rate of MMIO writes supported etc?

> The proposed offset/wrap field allows devices to disable doorbells when
> appropriate, and determine the latest fill level via a PCIe read.

This kind of looks like a split ring though, does it not?  The issue is
we will again need to bounce more cache lines to communicate.

So I wonder: what if we made a change to spec that would allow prefetch
of ring entries?  E.g. you would be able to read at random and if you
guessed right then you can just use what you have read, no need to
re-fetch?






> I suggest the best place to put this would be in the driver area,
> immediately after the event suppression structure.

Could you comment on why is that a good place though?

> Presumably we would like this to be an optional feature, as implementatio=
ns
> of packed mode already exist in the wild.=A0 How about
> VIRTIO_F_RING_PACKED_AVAIL_IDX?
> If I prepare a patch to the spec is there still time to get this into v1.=
1?

Any new feature would require another round of public review.
I personally think it's better to instead try to do 1.2 soon after,
e.g. we could try to target quarterly releases.

But ultimately that would be up to the TC vote.


> Best,
> David
>=20
> --=20
> David Riddoch  <driddoch@solarflare.com> -- Chief Architect, Solarflare
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

