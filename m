Return-Path: virtio-dev-return-3245-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 692B458191F8
	for <virtio-dev@lists.oasis-open.org>; Tue, 20 Feb 2018 09:15:49 -0800 (PST)
Date: Tue, 20 Feb 2018 17:15:44 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180220171544.GC12161@stefanha-x1.localdomain>
References: <61ea318df06f6e50c5f9cfffaaae85aa51ae5b58.1519045824.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eRtJSFbw+EEWtPj3"
Content-Disposition: inline
In-Reply-To: <61ea318df06f6e50c5f9cfffaaae85aa51ae5b58.1519045824.git.tgolembi@redhat.com>
Subject: Re: [virtio-dev] [PATCH] content: document balloon memory statistics
To: =?utf-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Jonathan Helman <jonathan.helman@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2018 at 02:10:29PM +0100, Tom=C3=A1=C5=A1 Golembiovsk=C3=BD=
 wrote:
> +\item[VIRTIO_BALLOON_S_CACHES (7)] The amount of memory currently used f=
or
> +  caching files and other data from disk (in bytes).
>  \end{description}

This one is somewhat vague.  I'm not sure if it means guest page cache
specifically or something more general.

On the other hand, the numbers tend to be OS specific...

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--eRtJSFbw+EEWtPj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJajFfAAAoJEJykq7OBq3PI3Y4IAML+tR5NMkqv7uD56ey6j9gc
b6w1do/+bv4/yTMubckx0dPBiVavHt3IrufsHszgkie6M3GON2ZAXs5+vU05c5gT
btM8SFdOjaoNloJ8cLreEK/ljaLNo1sWGHbOkgf6vCoq5RxbcNZFHSUjX/9oB2NC
wGrP1ZB969aLkltU3TBXASFYCVgcfmy0zpGJ2CP5yNh7/Abin4/94GcUjB0hfnbS
Tj9/lY71d4R9q3p3cxnGPQ4r7yFG045vu6qLzlP5quBbJPDrlZjo/cYXuWvNfclF
fDLyR/+l1bT8QgzP6aa+U4mol3cVYpA+kq04VjhHTJVut0pI9vRY3QrNwoVlDho=
=+YVg
-----END PGP SIGNATURE-----

--eRtJSFbw+EEWtPj3--
