Return-Path: virtio-dev-return-5366-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5250F985A3D
	for <virtio-dev@lists.oasis-open.org>; Mon,  4 Feb 2019 05:40:59 +0000 (UTC)
Date: Mon, 4 Feb 2019 13:40:53 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190204054053.GE29758@stefanha-x1.localdomain>
References: <CAOGAQepUKjQuqJ9o4_bTwCjT-dJO9=eMBevvrULUW3KgieoXHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ytoMbUMiTKPMT3hY"
Content-Disposition: inline
In-Reply-To: <CAOGAQepUKjQuqJ9o4_bTwCjT-dJO9=eMBevvrULUW3KgieoXHg@mail.gmail.com>
Subject: Re: [virtio-dev] Memory sharing device
To: Roman Kiryanov <rkir@google.com>
Cc: virtio-dev@lists.oasis-open.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, kraxel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

--ytoMbUMiTKPMT3hY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 01, 2019 at 12:34:07PM -0800, Roman Kiryanov wrote:
> for our purposes we need to access host's memory (e.g. Vulkan buffers,
> but we also considering other things, like running all drivers in
> userspace) directly from a linux guest (Android). I implemented a
> device in QEMU and a linux driver for it:
>=20
> https://android.googlesource.com/kernel/goldfish/+/android-goldfish-4.14-=
dev/drivers/misc/goldfish_address_space.c
>=20
> https://android.googlesource.com/platform/external/qemu/+/emu-master-dev/=
hw/pci/goldfish_address_space.c
>=20
> during upstreaming the driver it was suggested that developing a
> virtio spec could be a better approach than inventing our specific
> driver and device.
>=20
> Could you please advise how to start?

Hi Roman,
David Gilbert, Gerd Hoffmann, and I have discussed adding shared memory
resources to VIRTIO.  That means memory made available by the device to
the driver instead of the usual other way around.

virtio-gpu needs this and perhaps that use case overlaps with yours too.

virtio-fs and virtio-vhost-user both also need shared memory.

Here is David Gilbert's latest draft spec:
https://lists.oasis-open.org/archives/virtio-comment/201901/msg00000.html

Is this what you were thinking of?

Stefan

--ytoMbUMiTKPMT3hY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcV9BlAAoJEJykq7OBq3PIYO8H+gIOie9+vRe2+AH0daOjTX32
da3B93w8k6CVSNI6s0QQzM9sk2FQzf+C9FjmH8PpT03OvNLaJlUHhaEVIPvOU+ct
cXPywvsilZnvu6e9wtbwERAu8MREf5hZqIJGaijg45krx78LqQapvXaCzjTAwr0u
fDGOUhBedcViJTOqXbwTXmN1BdWBRvrn6YIyXdN8jtW1qBB/xTB118NufC6j0aPV
tgrN56tNeX89LzonmKAfQFu1QstA1kIBfPk13/xkTbRhpSXAxAVj9fuK71sp9rzt
KOwtDfwlKJsKueuML/PWFfCExPjmlXtr7QNieDs2UVpwxXQFkXQNGvJXD5+l0Q8=
=KRiP
-----END PGP SIGNATURE-----

--ytoMbUMiTKPMT3hY--
