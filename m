Return-Path: virtio-dev-return-6013-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 662A0985CF5
	for <virtio-dev@lists.oasis-open.org>; Fri, 23 Aug 2019 14:59:52 +0000 (UTC)
Date: Fri, 23 Aug 2019 15:59:44 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190823145944.GB27586@stefanha-x1.localdomain>
References: <20190813131320.30829-1-stefanha@redhat.com>
 <20190813131320.30829-2-stefanha@redhat.com>
 <20190822132345.2c8920c1.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline
In-Reply-To: <20190822132345.2c8920c1.cohuck@redhat.com>
Subject: Re: [virtio-dev] [PATCH v6 1/2] content: add virtio file system
 device
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Sage Weil <sweil@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Vivek Goyal <vgoyal@redhat.com>, Steven Whitehouse <swhiteho@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Miklos Szeredi <mszeredi@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2019 at 01:23:45PM +0200, Cornelia Huck wrote:
> On Tue, 13 Aug 2019 14:13:19 +0100
> Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > +\item[\field{num_queues}] is the total number of request virtqueues ex=
posed by
> > +    the device.  Each virtqueue offers identical functionality and the=
re are no
> > +    ordering guarantees between requests made available on different q=
ueues.
> > +    Use of multiple queues is intended to increase performance.
>=20
> As this came up during review of the qemu implementation of the device:
> num_queues is not the number of virtqueues of the device, but rather
> the number of request queues -- which is clear from the description,
> but not from the field name. Maybe rename this field to
> num_request_queues or so?

Sounds good.  Will fix in the next revision.

> > +\subsubsection{Device Operation: Request Queues}\label{sec:Device Type=
s / File System Device / Device Operation / Device Operation: Request Queue=
s}
> > +
> > +The driver enqueues normal requests on an arbitrary request queue. High
> > +priority requests are not placed on request queues.  The device proces=
ses
> > +requests in any order.  The driver is responsible for ensuring that or=
dering
> > +constraints are met by making available a dependent request only after=
 its
> > +prerequisite request has been used.
> > +
> > +Requests have the following format with endianness chosen by the drive=
r as
>=20
> "chosen by the driver in the FUSE_INIT request used to initiate the
> session", maybe? You describe this below, but I think it would be
> easier to understand if you mentioned it here already.

Thanks, will fix in the next revision.

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl1f/2AACgkQnKSrs4Gr
c8jz9ggAmtet8kETr+zyTXeIyeXxJp807RJdmGjsgbdvDwmdm5eKKxAHaXF5l58D
8GeRQYRKRPNTxhLKoJyDcCu3EWPUsh2V7fylZ83hG4TgWclFodnpDUS7lmDzM8MI
MZQUSDihUsVQMN8HlEzcImd2Pbjx7REA4uoXnnPNTWt9WrDcXh3tv1NTSwRcLXkS
cNHIc7LArgOtf4MTjsJ0MoNeTZRk6eM2WbYMq0hGfiZKnVr1p7kbxiz5C89QHlTe
LkGd7dSQ3R3uoOjizKfGbWOAjiaLucv8V0sBzbZleZhhN4hE7xqS/a5s746qBT3q
30jCJ1hDh+kMwz+s5dMi8BBRnIG2Hw==
=Fd57
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
