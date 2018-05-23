Return-Path: virtio-dev-return-4133-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 9FD3658191B0
	for <virtio-dev@lists.oasis-open.org>; Wed, 23 May 2018 03:48:33 -0700 (PDT)
Date: Wed, 23 May 2018 11:48:21 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180523104821.GC3898@stefanha-x1.localdomain>
References: <20180518044106.31357-1-pagupta@redhat.com>
 <20180522094248.GI21655@stefanha-x1.localdomain>
 <c2984e27-a8ef-7295-8451-31480ab67216@redhat.com>
 <965065117.36673579.1527051680099.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rQ2U398070+RC21q"
Content-Disposition: inline
In-Reply-To: <965065117.36673579.1527051680099.JavaMail.zimbra@redhat.com>
Subject: Re: [virtio-dev] [PATCH] content: reserve device ID for virtio-pmem
 devices
To: Pankaj Gupta <pagupta@redhat.com>
Cc: David Hildenbrand <david@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

--rQ2U398070+RC21q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 23, 2018 at 01:01:20AM -0400, Pankaj Gupta wrote:
>=20
> Hi Stefan,
>=20
> > >> We need a device ID for virtio-pmem devices. As 24 is already
> > >> requested by virtio-mem, so requesting next available(25)
> > >>
> > >> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > >> ---
> > >>  content.tex | 2 ++
> > >>  1 file changed, 2 insertions(+)
> > >=20
> > > virtio-mem is designed for hotplug.  Does it make sense to merge
> > > virtio-pmem into virtio-mem since you'll need hotplug too?
> > >=20
> > > Stefan
> > >=20
> > Hi Stefan,
> >=20
> > Initially I had (and even proposed during some discussion) the same
> > idea. But it turns out that they are fundamentally different.
> >=20
> > They are memory devices, yes, but that's the point where they stop being
> > similar.
> >=20
> > While virtio-pmem wants to expose a memory region as persistent memory
> > and adding a flushing interface, virtio-mem is all about managing
> > (add/remove/online/offline) sub-chunks and applying protection
> > mechanisms on the hypervisor side to make sure unplugged memory cannot
> > (or only in some limited sense) be accessed.
>=20
> Yes, we discussed possibility of merging both these devices in the past.
> As rightly explained by David, both these devices solving different probl=
ems.
> Also, their architectures are different, common part is both use memory d=
evice=20
> & VIRTIO.
>=20
> Also, as we plan to add more features specific to each virtio{mem/pmem}, =
it=20
> will be more confusing and difficult to maintain. I think it makes more s=
ense to=20
> keep both these devices separate.=20

Okay.

Stefan

--rQ2U398070+RC21q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbBUb1AAoJEJykq7OBq3PIQwsIAJWP9MKGH/Tk+IiY7ovjzZUZ
jv3aWa94NymJbbMqR544G5pgcl8DUx0KpN68bsnP2nU7XlHeUrxOu3UU0CMtVFVv
RmHeoGx2nCDfsQtHBPZ00z6IBi36Y0RNUmjE9rjaJQaH+5fRc1ULHwIzUq5AAhrM
CO78qNYxchBP1yVQ09P/Dg6mqOwOHm+pNSI+UP32oQYJTFOfCjrQ8rKEs8RU4+HT
NHA5wba2Yept0pOXi2ZK0qbcXoz9bC9VwKwdVAHXX5LZKGZyVw/+r1AGVx+7m/Ed
uwZ+0WB1yLlwU4sD85niyQF/FpjqlUOKlo09hKP39UVHlaYYyalP21ZmdcYVLlE=
=RMTv
-----END PGP SIGNATURE-----

--rQ2U398070+RC21q--
