Return-Path: virtio-comment-return-704-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Fri, 8 Mar 2019 09:19:32 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190308091932.GB12318@stefanha-x1.localdomain>
References: <20190304132531.10507-1-dgilbert@redhat.com>
 <20190304132531.10507-3-dgilbert@redhat.com>
 <20190307162811.GI2843@stefanha-x1.localdomain>
 <20190307182457.GM2811@work-vm>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xgyAXRrhYN0wYx8y"
Content-Disposition: inline
In-Reply-To: <20190307182457.GM2811@work-vm>
Subject: [virtio-comment] Re: [PATCH v3 2/3] shared memory: Define PCI capability
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, sebastien.boeuf@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--xgyAXRrhYN0wYx8y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 06:24:57PM +0000, Dr. David Alan Gilbert wrote:
> * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > On Mon, Mar 04, 2019 at 01:25:30PM +0000, Dr. David Alan Gilbert (git) =
wrote:
> > > +\begin{lstlisting}
> > > +struct virtio_pci_shm_cap {
> > > +        struct virtio_pci_cap cap;
> > > +        u32 offset_hi;
> > > +        u32 length_hi;
> > > +        u8  id;
> > > +};
> > > +\end{lstlisting}
> >=20
> > Are there any alignment requirements for PCI capability structures?
>=20
> The PCI spec says 'Each capability must be DWORD aligned. '
>=20
> > This struct ends with a u8, which might be a problem if 32-bit or 64-bit
> > alignemnt is required by something.
>=20
> It doesn't seem to be unusual, for example the MSI capability structure
> seems to be 10 or 14 bytes even with the DWORD alignement restriction
> for the start of it.

Sounds good.  Just wanted to check.

Stefan

--xgyAXRrhYN0wYx8y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcgjOkAAoJEJykq7OBq3PIH+oIALa2LNGJ/fOMUzEPaQkvVsTP
X0R6PjTqK2rl5gS4AZYnoEVg1oQPbHyWF6UgmwSrvhE6Rpl4jm/Y96VGF8H1XFeU
xdcBkbbehxtbCQO26WVKC4rKp3jyqZpO6f9dx98ElozJuHzHEtPJhjJNPEFB/t9u
wounuTfd4TABKz7Vldb07CIRpoqubghEJt+Nby7sbJA+6kLrg0uPDUWCZJyk0DVx
HDH7ocXRCFHRExiH+YKNiH8mJ7138wViMOvdJZg77Kh0/V7MlwOKYHXSowlTDuxA
iG02tG+9ROON0PQpuiCWDf/9+kGTlhki3SWZOdnpTbgU9RPcll79hO8THrQLIc8=
=3xq/
-----END PGP SIGNATURE-----

--xgyAXRrhYN0wYx8y--
