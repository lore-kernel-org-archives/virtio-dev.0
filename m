Return-Path: <virtio-dev-return-8202-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9E54C986070
	for <virtio-dev@lists.oasis-open.org>; Mon, 28 Jun 2021 13:01:51 +0000 (UTC)
Date: Thu, 24 Jun 2021 10:48:20 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <YNRU5DqWPtjAzoQo@stefanha-x1.localdomain>
References: <20210609153740.262346-1-stefanha@redhat.com>
 <20210609153740.262346-3-stefanha@redhat.com>
 <20210623132843.GA1566698@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210623132843.GA1566698@redhat.com>
Subject: [virtio-dev] Re: [PATCH v3 2/2] virtio-fs: add notification queue
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Vn8zCJjmIjmQdRCJ"
Content-Disposition: inline
To: Vivek Goyal <vgoyal@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Liu Bo <bo.liu@linux.alibaba.com>, iangelak@redhat.com, mszeredi@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

--Vn8zCJjmIjmQdRCJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 23, 2021 at 09:28:43AM -0400, Vivek Goyal wrote:
> On Wed, Jun 09, 2021 at 04:37:40PM +0100, Stefan Hajnoczi wrote:
>=20
> [..]
> >  \subsection{Device configuration layout}\label{sec:Device Types / File=
 System Device / Device configuration layout}
> > =20
> > -All fields of this configuration are always available.
> > -
> >  \begin{lstlisting}
> >  struct virtio_fs_config {
> >          char tag[36];
> >          le32 num_request_queues;
> > +        le32 notify_buf_size;
>=20
> Hi Stefan,
>=20
> I am wondering if there should be a negotiation for number of descriptors
> in the notification queue between device and driver. How does it work
> for regular queus. I remeber there is a qemu has "queue-size" parameter
> which controls this.
>=20
> But given this is notification queue and number of descriptors will be
> allocated by driver. For now I have hardcoded it to 16 in driver. But
> may be device should be able to specify how many descriptors to allocate
> for notification queue, possibly using configuration space? WDYT.

VIRTIO devices report the maximum supported queue size via
transport-specific means (e.g. virtio-pci's struct
virtio_pci_common_cfg->queue_size field). QEMU's -device
virtio-*,queue-size=3D sets this field.

The driver can reduce the queue size from that maximum, if desired.

Since this mechanism is already present I don't think anything
additional is needed in the virtiofs device specification.

Stefan

--Vn8zCJjmIjmQdRCJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmDUVOQACgkQnKSrs4Gr
c8jhkgf9EkYSNQCgaaRcA0zqfpK2vOpuQPv+/gb2Tvj4TwkphEY81mPR53LencUT
IOVNEnyZh6HVJw6ljshh4ellRn5RxzMN1yEpimLQLI9NTQyTOrGP4hoS69d171Zs
48jYhWCcz7meIlpUVLN2AxHbnmjq1zty+bPQ5qV6IvpdTY82UZcKVXuKdqDcptMI
bbmv3HMlDlT764KEWjLYHAl8J9BV1mnVW6KP5cHcg04XVitRRlWdfUdD67L0kuBw
viBDQAYpPUCzr8Vmwrm3MWgD1D/R5KsOkYmsr1RhikBK38XkIUFnIKVZPvbRmY90
I9Ds91/ENpjFSx/eN6vZo7FT70L7Hw==
=6Sfn
-----END PGP SIGNATURE-----

--Vn8zCJjmIjmQdRCJ--

