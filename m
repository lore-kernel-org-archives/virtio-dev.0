Return-Path: virtio-dev-return-3982-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 30E065818D93
	for <virtio-dev@lists.oasis-open.org>; Fri, 27 Apr 2018 06:02:55 -0700 (PDT)
Date: Fri, 27 Apr 2018 14:02:46 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180427130246.GA11150@stefanha-x1.localdomain>
References: <20180425082312.32244-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <20180425082312.32244-1-tiwei.bie@intel.com>
Subject: [virtio-dev] Re: [RFC] VIRTIO_F_IO_BARRIER: use I/O barriers in driver
To: Tiwei Bie <tiwei.bie@intel.com>
Cc: mst@redhat.com, pbonzini@redhat.com, jasowang@redhat.com, virtio-dev@lists.oasis-open.org, cunming.liang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 04:23:12PM +0800, Tiwei Bie wrote:
> There will be hardware virtio devices in the future, which
> require drivers to use the barriers suitable for I/O device,
> compared with software virtio devices which just require
> drivers to use the barriers suitable for CPU core.
>=20
> To fix the ordering issue for hardware virtio devices, add
> a new feature: VIRTIO_F_IO_BARRIER. When negotiated, driver
> will use the barriers suitable for I/O device.
>=20
> Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
> ---
>  content.tex | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/content.tex b/content.tex
> index ae5fa4c..f24e320 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -5445,6 +5445,8 @@ Descriptors} and \ref{sec:Packed Virtqueues / Indir=
ect Flag: Scatter-Gather Supp
>    that drivers pass extra data (besides identifying the Virtqueue)
>    in their device notifications.
>    See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueue=
s / Driver notifications}.
> +  \item[VIRTIO_F_IO_BARRIER(37)] This feature indicates that the device
> +  needs the driver to use the barriers suitable for hardware device.

s/hardware device/hardware devices/ (plural)

>  \end{description}
> =20
>  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> @@ -5460,6 +5462,10 @@ addresses to the device.
> =20
>  A driver SHOULD accept VIRTIO_F_RING_PACKED if it is offered.
> =20
> +A driver SHOULD accept VIRTIO_F_IO_BARRIER if it is offered.
> +If VIRTIO_F_IO_BARRIER has been negotiated, a driver MUST use
> +the barriers suitable for hardware device.

s/hardware device/hardware devices/ (plural)

Please add a little context so the purpose is clear to readers (I
wouldn't be 100% sure what the spec means without more detail):

  Some transports require barriers to ensure hardware devices have a
  consistent view of memory.  When devices are implemented in software a
  weaker form of barrier may be sufficient and yield better performance.
  This feature bit indicates whether the full hardware barrier is
  necessary.

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa4x92AAoJEJykq7OBq3PIptUIAI4vSGE2VqL0of4/1mGNMK0+
5ts8p/sag5BYKz/kw4df+6CIFWhvOUab/wNKB13FP5F4fyQ0pVjGdWR+PjdPTTb/
p9ZecBFI1NPvwavbFsw99ua3rGNqBqsUn8b99qE2s8W8Qo6x2ngLLbHSXSlH9+Th
h56ASQgNbmNG2MQtKw2pULwh9jFXbUk50PUuqn7rk56hRBc2qKgQqWxcggl2Y5Zv
BF0UGsOYna/GtAI7LhQaPJLI0jbmIofHPdWpzWNgHbJGESzJ+UEwpMsEjkb4Do7w
zLjVo8Hgb189LcYfLjo+KxSb3IOK3yG4+qRUIH6UqmdS5JAUXqhApJnHXXDGEhg=
=jy77
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
