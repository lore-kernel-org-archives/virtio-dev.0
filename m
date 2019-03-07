Return-Path: virtio-comment-return-696-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Thu, 7 Mar 2019 16:28:11 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190307162811.GI2843@stefanha-x1.localdomain>
References: <20190304132531.10507-1-dgilbert@redhat.com>
 <20190304132531.10507-3-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tctmm6wHVGT/P6vA"
Content-Disposition: inline
In-Reply-To: <20190304132531.10507-3-dgilbert@redhat.com>
Subject: [virtio-comment] Re: [PATCH v3 2/3] shared memory: Define PCI capability
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, sebastien.boeuf@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--tctmm6wHVGT/P6vA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 04, 2019 at 01:25:30PM +0000, Dr. David Alan Gilbert (git) wrote:
> +\begin{lstlisting}
> +struct virtio_pci_shm_cap {
> +        struct virtio_pci_cap cap;
> +        u32 offset_hi;
> +        u32 length_hi;
> +        u8  id;
> +};
> +\end{lstlisting}

Are there any alignment requirements for PCI capability structures?
This struct ends with a u8, which might be a problem if 32-bit or 64-bit
alignemnt is required by something.

Otherwise:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--tctmm6wHVGT/P6vA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcgUabAAoJEJykq7OBq3PI3mMIAL7N2JSuwHy+6ND7ZW6+bTdC
Pp8aBhOf7zbuZRg63oQ7y+vPD1v+n9Gz4OJwzy1JGJ0mhZdnoIg7t2K31Ane2Xsa
nhMg6KEFIEJ8R4jWigRZJnc9RI2kUhmYiXHvL5JhZytnywlnIQ9nToTNfb0HGpaA
T0eA11jWTDWTbeWdr53fZ/WVHlN70ymUn9bRpB452DDwYRyeVGEWagSrr0bTirOM
MV2Wy2PP7QeBT/302P2e2KGaqHZJOh7x/IXFkckN0lqSZgkbSDd+k3ymgdFRXIPz
lu/CXxmoOvSETPSiyNnUt2HyAbagmHYKZlSKBO010N/71IUYt/1tp/jzcSabH70=
=M6Ge
-----END PGP SIGNATURE-----

--tctmm6wHVGT/P6vA--
