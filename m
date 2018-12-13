Return-Path: virtio-dev-return-5194-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 020DA985D95
	for <virtio-dev@lists.oasis-open.org>; Thu, 13 Dec 2018 09:16:50 +0000 (UTC)
Date: Thu, 13 Dec 2018 09:16:44 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20181213091644.GA20832@stefanha-x1.localdomain>
References: <20181129181659.21284-1-stefanha@redhat.com>
 <20181130162140-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Content-Disposition: inline
In-Reply-To: <20181130162140-mutt-send-email-mst@kernel.org>
Subject: [virtio-dev] Re: [PATCH v10] vsock: add vsock device
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>, Ian Campbell <ian.campbell@docker.com>
List-ID: <virtio-dev.lists.oasis-open.org>

--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 30, 2018 at 04:23:52PM -0500, Michael S. Tsirkin wrote:
> On Thu, Nov 29, 2018 at 06:16:59PM +0000, Stefan Hajnoczi wrote:
> > +\subsection{Feature bits}\label{sec:Device Types / Socket Device / Fea=
ture bits}
> > +
> > +\begin{description}
> > +There are currently no feature bits defined for this device.
> > +\end{description}
>=20
> this breaks latex: \item must be used within description.
> I have dropped description environment.
> Pls make sure to build document before posting.

Sorry, I was unable to run ./makepdf.sh without the Microsoft fonts and
thought ./makehtml.sh alone would catch errors (but it didn't!).

Will fix.

Stefan

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcEiN8AAoJEJykq7OBq3PIuUgH/1bUKVa2NG5ecs8Lp+nOcSR4
tTNP9h5PHgAdLRCSZlBTPBYrBJ3fdb62TKpEY9Elzva8pjG+7bdQEqk8oyh449mx
zS99DEpHSQzOKAPxfZ0S6fKCs2T2mO80viopi7p0Vu9qt2ozOOGgupG2cgZ4hMu1
plH/yDM3PZ9h0wbPLECC0K1aD+EZ9EQGmPnbCSfbqcDc9HumZjUMw4e3L8OFbCQD
P9AE2ApS4r7XawYnwE25dfenRcy0ifBNM/d7G4f4iO5J7tQv0rijd19ulJ3yUwCb
5AAIyHjWCRpgy8dyIFOaFs6KyMe5thpadqlnRewz1tBc+z3U7WRygMzkQk7UYU4=
=3HFX
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
