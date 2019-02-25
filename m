Return-Path: virtio-comment-return-651-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Mon, 25 Feb 2019 16:50:14 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190225165014.GE379@stefanha-x1.localdomain>
References: <20190222115433.7160-1-dgilbert@redhat.com>
 <20190222115433.7160-4-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bjuZg6miEcdLYP6q"
Content-Disposition: inline
In-Reply-To: <20190222115433.7160-4-dgilbert@redhat.com>
Subject: [virtio-comment] Re: [PATCH v2 3/3] shared memory: Define mmio registers
To: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

--bjuZg6miEcdLYP6q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 22, 2019 at 11:54:33AM +0000, Dr. David Alan Gilbert (git) wrot=
e:
> diff --git a/content.tex b/content.tex
> index 9838208..c3070bd 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -1726,6 +1726,28 @@ All register values are organized as Little Endian.
>      selected by writing to \field{QueueSel}.
>    }
>    \hline=20
> +  \mmioreg{SHMId}{Shared memory id}{0x0ac}{W}{%
> +    Writing to this register selects the shared memory region \ref{sec:B=
asic Facilities of a Virtio Device / Shared Memory Regions}
> +    following operations on \field{SHMLenLow}, \field{SHMLenHigh},
> +    \field{SHMBaseLow} and \field{SHMBaseHigh} apply to.
> +  }
> +  \hline=20
> +  \mmiodreg{SHMLenLow}{SHMLenHigh}{Shared memory region 64 bit long leng=
th}{0x0b0}{0x0xb4}{R}{%

QueueDescLow/High explicitly documents the low and high 32 bits
relationship of these two registers.  Please do the same of
SHMLenLow/High and SHMBaseLow/High for clarity and consistency.  That
way readers know the purpose of Low and High.

> +    These registers return the length of the shared memory

Adding "in bytes" makes the units explicit.

> +    region, as defined by the device for the region selected by
> +    the \field{SHMId} register.  Reading from a non-existent
> +    region (i.e. where the ID written to \field{SHMId} is unused)
> +    results in a length of -1.

-1 is used to indicate the absence of a region, does 0 have a meaning?

> @@ -1761,6 +1783,9 @@ driver seeing an inconsistent configuration state.
> =20
>  The device MUST NOT access virtual queue contents when \field{QueueReady=
} is zero (0x0).
> =20
> +The device MUST NOT respond to SHM Base writes for none-existent

s/none/non/

--bjuZg6miEcdLYP6q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcdBzGAAoJEJykq7OBq3PISn8IAMCydtEtsrMVS5ZpfiqRjLk8
rK0s3L8Ql8qWHu7F9DI/YAGhnjnQEPJtffUhGVpbr37Sz8N8t+8aJ+i9XfhXnGxS
BoXd2yhpI1iD6Bw28rVY3MZpXBXJNPMqgyexDCQy36Js8F4by5wBBTgG7g4Qrpfz
SXEesUNDdA6wNIBSPxWmO64C5b6qPaRrd6trLHCVp63fcdx9p5vWek3UwGpC+Xzz
0pF08Ynk1QQz43d1MWgvNQS+5VPvHXfZbPS7qUfL1WlMC3LfzEgZ4oJmA/3YQrg5
9v8ey7/CBvlIZXxdmXADCsJ00dzQ/YCw/PvLfAKpBHuvvvUnka5eIBmF6i2JRHc=
=Zje8
-----END PGP SIGNATURE-----

--bjuZg6miEcdLYP6q--
