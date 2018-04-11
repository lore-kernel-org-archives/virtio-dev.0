Return-Path: virtio-return-3064-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 11 Apr 2018 10:19:55 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180411021955.GG28698@stefanha-x1.localdomain>
References: <1523398287-25480-1-git-send-email-pasic@linux.vnet.ibm.com>
 <1523398287-25480-2-git-send-email-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vJguvTgX93MxBIIe"
Content-Disposition: inline
In-Reply-To: <1523398287-25480-2-git-send-email-pasic@linux.vnet.ibm.com>
Subject: Re: [virtio] [RFC PATCH 1/3] notifications: unify notifications
 wording in core
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--vJguvTgX93MxBIIe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2018 at 12:11:25AM +0200, Halil Pasic wrote:
> Let us unify the wording when talking about notifications. This change
> establishes the terms available buffer notification for what was usually
> simply called notification or virtqueue notification in v1.0 and used
> buffer notification for what was usually called interrupt.
>=20
> The term configuration change notification in kept where called so and
> consolidated where it's called configuration change interrupt or
> similar.
>=20
> The changes done here are limited to the core part, and don't
> conceptually involve neither the transports nor the devices (references
> are updated though). Future changes should address these parts.

Nice, I think the cleanup is worthwhile.

>  \begin{lstlisting}
> -virtq_disable_interrupts(vq);
> +virtq_disable_notifications(vq);

This name is ambiguous.  Only used buffer notifications are disabled,
not configuration change notifications.

How about:

  virtq_disable_used_buffer_notifications(vq);

--vJguvTgX93MxBIIe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJazXDLAAoJEJykq7OBq3PIP8gH/A+fk7a7kRUjipaXUE1kNv+4
7ub2Q+UTQoornDZQXlDugP4R6dcbGiMxV2jCKS7tsTzz05Vci/I3wN24t9FK8ldQ
Ej+qdzD/nDJs79jlqtQGErSBfbOKwunXOV4zAT+sg0oDKa8lsvZwsUAxEc24FnKx
P1jEbJ2iOuFTG6OKZQuhCGKKxJvlNwMfHZ8wyq8yWAjEDgvikqSskQvCEY6zZscN
imdWCSI2gwhB+NUViU+SfIScdljfOA/ULTMNYumHwMDeEAm3IU1wfzvQya3Yei4d
MwmtTp4uu9imf9EV5XUs9Ov8bTd9pv4oPX9DeP/nu712gn22oT8ea+6TKd+NSy0=
=Lskm
-----END PGP SIGNATURE-----

--vJguvTgX93MxBIIe--
