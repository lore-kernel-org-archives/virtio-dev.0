Return-Path: <virtio-dev-return-9028-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C93099864E5
	for <virtio-dev@lists.oasis-open.org>; Thu, 13 Jan 2022 10:37:01 +0000 (UTC)
Date: Thu, 13 Jan 2022 10:36:52 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YeAAxCYT3I7Z/SmW@stefanha-x1.localdomain>
References: <20220112055755.41011-1-jasowang@redhat.com>
 <Yd6xAbl9TGjU72Ng@stefanha-x1.localdomain>
 <CACGkMEsSVPnZNHXtNCkCNTMhXHfgNssimWjCdZ_Mfi2TNjPBJA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsSVPnZNHXtNCkCNTMhXHfgNssimWjCdZ_Mfi2TNjPBJA@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH V2 0/2] virito-pci: PASID support
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="d4yDWtIiaIzHbvPK"
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, mst <mst@redhat.com>, eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--d4yDWtIiaIzHbvPK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 13, 2022 at 09:28:19AM +0800, Jason Wang wrote:
> On Wed, Jan 12, 2022 at 6:44 PM Stefan Hajnoczi <stefanha@redhat.com> wro=
te:
> >
> > On Wed, Jan 12, 2022 at 01:57:53PM +0800, Jason Wang wrote:
> > > Hi All:
> > >
> > > This series tries to add PASID support for virtio-pci to allow the
> > > virtqueue to use PASID TLP prefix for PCI transactions. This will be
> > > useful for future work like, queue assignment, virtqueue
> > > virtualization and presenting multiple vDPA devices with a single PCI
> > > device.
> > >
> > > Since we're short of the space for the PCI capabilities, the PCI
> > > extended capability for virtio structure is introduced that allows th=
e
> > > PASID configuration structure to use.
> > >
> > > A prototype is implemented with emulated virtio-pci device in [1]. A
> > > test driver is implemented in [2].
> > >
> > > Please review.
> >
> > I don't know the security model for PASIDs. My guess is that PASIDs can
> > be bruteforced so we must trust the driver (it can assign PASIDs to
> > virtqueue groups) and we must prevent untrusted applications from
> > setting PASIDs on virtqueues. Is that correct?
>=20
> Yes, and the kernel can choose to hide PASID even for the trusted
> application by using token or other intermediate layers.

It would be good to describe the security model from a virtio-pci
perspective so driver implementors don't accidentally expose trusted
interfaces to untrusted applications. It's obvious to someone who
already understands and has thought through all of this, but not obvious
to someone who is implementing a driver for the first time or someone
who is modifying the VIRTIO specification and doesn't know/care about
PASIDs.

Stefan

--d4yDWtIiaIzHbvPK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmHgAMQACgkQnKSrs4Gr
c8jT7wf9FZ8CQw11TjIHJXr1RyY/C82TOQ+iwy5bQCRvBxr9UMi0qCLzyltul7A1
0fSmJoLJyTPIL6LnRlFhm/IEHG9py2JGesuGJGBtDiVqbgcfv68HtMKs3c/zyz4O
rPhoSS80xVoE5LGcZhnyhLM+aFPGvTkq46OR3N4Q0jOC4puEtMCj68tkg/MMe3i6
twNfM6TIQ0bbOBlXR11zKbtoZFumjeouu4KAalbALDiFzRop/4iMXPwRxV2YWkLf
t8Co2xS37PQtZlVShqQr3EeaiblaZigdabQWeOkgMWtOSRaf/iKhamX+CxoZf5tR
Hjrh6d1wEfXmgcL2mD8mnWtTUZ0SFA==
=xbrs
-----END PGP SIGNATURE-----

--d4yDWtIiaIzHbvPK--

