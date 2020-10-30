Return-Path: virtio-return-3442-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Fri, 30 Oct 2020 11:37:32 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20201030113732.GG307361@stefanha-x1.localdomain>
References: <20201029075047.119209-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201029075047.119209-1-mst@redhat.com>
Subject: [virtio] Re: [virtio-dev] [PATCH] VIRTIO_F_RING_PACKED_USED: packing used
 descriptors
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aYDVKSzuImP48n7V"
Content-Disposition: inline
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--aYDVKSzuImP48n7V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 29, 2020 at 03:50:57AM -0400, Michael S. Tsirkin wrote:
> +When after processing the used descriptor, the batch counter
> +exceeds the ring size, the batch counter is decremented by the
> +ring size; both device and driver then skip to the
> +beginning (offset 0) of the ring until processing (reading for
> +the driver and writing for the device) the next used descriptor.

This may be clearer:

  both device and driver then use ring index 0 for the next used
  descriptor

Or:

  The device writes the next used descriptor at ring index 0. The driver
  reads the next used descriptor from ring index 0.

I'm not sure I understand this scheme. Is this pseudo-code correct?

  batch_counter += num_used_descs
  if batch_counter > ring_size:
      batch_counter -= ring_size
      used_idx = 0

Can you share an explanation of how this scheme ensures that the
driver's next avail descriptor index never overtakes the device's next
used descriptor index?

Previously it was obvious that the two never cross because the used
descriptor index jumped by the number of avail descriptors that were
processed by the device.

Stefan

--aYDVKSzuImP48n7V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl+b+vwACgkQnKSrs4Gr
c8gVOQgAufdGu9jlQWO9XpWem/HUH2XnKjXnWgR/JSNhRaZvhe+xLqJjMlRXp/l7
MpJj1R9DSsIQZQF1f+ijNh+g7HXxChnF9fivwFD47Z4TmNfL9HdXe7QzwOPSPqbS
8+phgxHfkjNcycJ90kbK1a1z86wuogMlAUJ3Njr0O8Koi3hWa8DF+plp81HEbXHe
QFGliQcgIo9YWBl1Oy0uchohoM5ajoyzWMN9bmQjEFwncqLo6jMGDo6F303CW0YV
QVs7dQrTM8kdu4dkx6TLU4rhQCyEnIK5mk024P7MHlg1NlKl58yeBf7WTpC4HXtY
4RrxlSDvfqeIkQ90O66tnvgXz3B6yA==
=sya4
-----END PGP SIGNATURE-----

--aYDVKSzuImP48n7V--

