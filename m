Return-Path: virtio-dev-return-7586-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3C0ED986097
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Jul 2020 09:48:18 +0000 (UTC)
Date: Fri, 17 Jul 2020 10:48:07 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20200717094807.GH128195@stefanha-x1.localdomain>
References: <20200518203721.7625-1-ndragazis@arrikto.com>
 <20200518203721.7625-9-ndragazis@arrikto.com>
MIME-Version: 1.0
In-Reply-To: <20200518203721.7625-9-ndragazis@arrikto.com>
Subject: Re: [virtio-dev] [PATCH v5 08/10] vhost-user: remove the extra PCI
 capabilities
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pfTAc8Cvt8L6I27a"
Content-Disposition: inline
To: Nikos Dragazis <ndragazis@arrikto.com>
Cc: virtio-dev@lists.oasis-open.org, "Michael S . Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--pfTAc8Cvt8L6I27a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2020 at 11:37:19PM +0300, Nikos Dragazis wrote:
> -Additional resources are configured on the virtio PCI transport by the f=
ollowing \field{struct virtio_pci_cap.cfg_type} values:
> +\subsubsection{Doorbell layout}\label{sec:Device Types / Vhost-user Devi=
ce Backend / Additional Device Resources / Doorbell layout}
> =20
> -\begin{lstlisting}
> -#define VIRTIO_PCI_CAP_DOORBELL_CFG 6
> -#define VIRTIO_PCI_CAP_NOTIFICATION_CFG 7
> -#define VIRTIO_PCI_CAP_SHARED_MEMORY_CFG 8
> -\end{lstlisting}
> +The device MUST reserve 2N+1 virtqueue indices that can be used by the d=
river to
> +send doorbell notifications. The driver can use these indices to send do=
orbell
> +notifications in the same way that it sends available buffer notificatio=
ns
> +\ref{sec:Basic Facilities of a Virtio Device / Notifications} for a virt=
queue.

Notifications and doorbells should be first-class VIRTIO device model
concepts, like Shared Memory resources. It should not be necessary to
reserve dummy virtqueues (a hack for getting MSI-X vectors and doorbell
registers).

--pfTAc8Cvt8L6I27a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl8Rc9cACgkQnKSrs4Gr
c8gFoAf/bpZBP7BpECi2JKZuAcgVuMkJh51rb8KOhSjviq4AGKf75XIgz+mruKWv
tP597SP53NVNfCXwcuzKWdcaJmiuXgsuTP4c/mGf/8qNijQ5oUK9V6wkcQnEB5DI
0P7SCBhruPAKhR4/1Ou4/xbkxjBmVirom2w1T47Eya/B1lQfhau3lUTpusnQ02FO
ZIqbuXJQ5hnwG4+Mitx0f9N2WkPZsdmo3ArNva37raog+Vkt+2OYlS7Xz0wj1X8H
EFcwtis7wZkQwpkEmLlAjO/gK6qdPZIE+5S4tp6d628YRbiJbIWtpSv9hTz83TEy
qY3zbRwEHwLAxuU6rx7hoFSF/DvZ7w==
=vPDJ
-----END PGP SIGNATURE-----

--pfTAc8Cvt8L6I27a--

