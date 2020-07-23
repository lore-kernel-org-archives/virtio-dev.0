Return-Path: virtio-dev-return-7613-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 97F03985DD7
	for <virtio-dev@lists.oasis-open.org>; Thu, 23 Jul 2020 06:29:51 +0000 (UTC)
Date: Thu, 23 Jul 2020 07:29:40 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20200723062940.GC268427@stefanha-x1.localdomain>
References: <20200518203721.7625-1-ndragazis@arrikto.com>
 <20200518203721.7625-9-ndragazis@arrikto.com>
 <20200717094807.GH128195@stefanha-x1.localdomain>
 <d6fa9520-82f7-ed73-f991-f91b70f712ca@arrikto.com>
MIME-Version: 1.0
In-Reply-To: <d6fa9520-82f7-ed73-f991-f91b70f712ca@arrikto.com>
Subject: Re: [virtio-dev] [PATCH v5 08/10] vhost-user: remove the extra PCI
 capabilities
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="m51xatjYGsM+13rf"
Content-Disposition: inline
To: Nikos Dragazis <ndragazis@arrikto.com>
Cc: virtio-dev@lists.oasis-open.org, "Michael S . Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--m51xatjYGsM+13rf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2020 at 06:03:57PM +0300, Nikos Dragazis wrote:
> On 17/7/20 12:48 =CE=BC.=CE=BC., Stefan Hajnoczi wrote:
>=20
> > On Mon, May 18, 2020 at 11:37:19PM +0300, Nikos Dragazis wrote:
> > > -Additional resources are configured on the virtio PCI transport by t=
he following \field{struct virtio_pci_cap.cfg_type} values:
> > > +\subsubsection{Doorbell layout}\label{sec:Device Types / Vhost-user =
Device Backend / Additional Device Resources / Doorbell layout}
> > > -\begin{lstlisting}
> > > -#define VIRTIO_PCI_CAP_DOORBELL_CFG 6
> > > -#define VIRTIO_PCI_CAP_NOTIFICATION_CFG 7
> > > -#define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
> > > -\end{lstlisting}
> > > +The device MUST reserve 2N+1 virtqueue indices that can be used by t=
he driver to
> > > +send doorbell notifications. The driver can use these indices to sen=
d doorbell
> > > +notifications in the same way that it sends available buffer notific=
ations
> > > +\ref{sec:Basic Facilities of a Virtio Device / Notifications} for a =
virtqueue.
> > Notifications and doorbells should be first-class VIRTIO device model
> > concepts, like Shared Memory resources. It should not be necessary to
> > reserve dummy virtqueues (a hack for getting MSI-X vectors and doorbell
> > registers).
>=20
> Well, it's not exactly equivalent to the shared memory resource
> because, in case of doorbells and notifications, the functionality is
> already there. But I see your point. It is a design issue. We could
> definitely standardize the doorbell and notification resources, but I
> don't see why this solution is preferable. Do you have something in
> mind?

Yes, there are advantages to defining doorbells and notifications as
separate concepts:

 * Doorbells and notifications may be implemented differently from
   virtqueue notifications on some the transports.
 * Virtqueues may consume more resources on some transports.
 * Existing drivers may have issues distinguishing between normal
   virtqueues and dummy virtqueues.

Overall I think using dummy virtqueues is a hacky approach. It's
something that would be necessary if we couldn't extend the core VIRTIO
device model. Since we do have the opportunity of extending the core
VIRTIO device model cleanly I think doing so will avoid headaches later.

Stefan

--m51xatjYGsM+13rf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8ZLlQACgkQnKSrs4Gr
c8hN8AgAwekH0jsMZKHyGNk6gpEAPI7vjixoMX77VzOyqHp3vnxAfBTQMQVWYe5h
FIsHzBSOWezsVE4y1EliMOwTGUoHawflzNu2P8LNvxmUz0vfjzHwTTbwlidrQwdL
WtkTvo0RFic+A3uHYjhh2zbasdlYJrRodwVnNxonzi/soiOV3IcIpuvo+jNpCFC9
AxdGvSMapfv2Hm4OHllev90yr0HXvP9DhpaHSAvmV5Fm1w+mGzZYqqqsaI2ev2Qe
6EWzCSqQPZv9jwpqfjBkylBIZh85E8nSsBelN0k+Q8dbw7cQVLxl9M4GyQUjY0qn
GgqWtEXdAQgsnfOTH77l/79rnc75Hg==
=w/iN
-----END PGP SIGNATURE-----

--m51xatjYGsM+13rf--

