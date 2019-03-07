Return-Path: virtio-comment-return-695-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Thu, 7 Mar 2019 16:25:16 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190307162516.GH2843@stefanha-x1.localdomain>
References: <20190304132531.10507-1-dgilbert@redhat.com>
 <20190304132531.10507-2-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CEUtFxTsmBsHRLs3"
Content-Disposition: inline
In-Reply-To: <20190304132531.10507-2-dgilbert@redhat.com>
Subject: Re: [virtio-comment] [PATCH v3 1/3] shared memory: Define shared
 memory regions
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, sebastien.boeuf@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--CEUtFxTsmBsHRLs3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 04, 2019 at 01:25:29PM +0000, Dr. David Alan Gilbert (git) wrote:
> +\subsection{Addressing within regions}\label{sec:Basic Facilities of a Virtio Device / Shared Memory Regions / Addressing within regions }
> +
> +Commands sent over the virtqueues may refer to data within the
> +shared memory regions, for example a command may be used by a
> +driver to cause a device to add or remove a mapping within
> +a region.  When referring to data, the addresses will normally be
> +offsets within a particular region rather than absolute host or
> +guest addresses.  The \field{shmid} may be explicit or may be
> +inferred from the command type.

This sounds like normative statements.  They belong in a driver or
device normative section.

Otherwise:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--CEUtFxTsmBsHRLs3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcgUXsAAoJEJykq7OBq3PIR50IAIOton/wRvYeFMDq9eoRtEgQ
tiUtoKgyRIsrrWjFEC5ZzMkhGPPxUeMyEAMFCmNsjYdaX/Vs4WbsjTf6aNX9Twl0
hpK5isbkae/1J39AfYuULIJIHPqH93PGlCTlAwEil7UWM2PrIUMonteZwY/CQIox
bN5a6K1wsGoCZ4/lbguq3tZB3/Y9LVl05tOBJZAZIgFByOIaWvQUZAuh+s1I8oe2
CYAoWnIvGDvGcuSNZaFn+6LqroLl8LBtzJdAjJ83MvPEHRDg+dmfgHYT1GHNVEw+
9tCj+Dr7sTJhecIorgYq4hHpwEeG11Xxj36LwCX5b2KCPUzDWG0KTe+2bf/ZMYk=
=lJya
-----END PGP SIGNATURE-----

--CEUtFxTsmBsHRLs3--
