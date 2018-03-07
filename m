Return-Path: virtio-dev-return-3447-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Date: Wed, 7 Mar 2018 11:28:55 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180307112855.GB16861@stefanha-x1.localdomain>
References: <1520304620-10753-1-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Content-Disposition: inline
In-Reply-To: <1520304620-10753-1-git-send-email-changpeng.liu@intel.com>
Subject: Re: [virtio-dev] [PATCH v3] virtio-blk: add discard and write zeroes
 features to specification
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, cavery@redhat.com, pbonzini@redhat.com, pawelx.wodkowski@intel.com, james.r.harris@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 06, 2018 at 10:50:20AM +0800, Changpeng Liu wrote:
> +The \field{data} used for discard or write zeroes command is described
> +by one or more virtio_blk_discard_write_zeroes structs. \field{sector}
> +indicates the starting offset (multiplied by 512) of the segment, while

Did you mean "divided by 512 bytes" instead of "multiplied by 512"?

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJan8z3AAoJEJykq7OBq3PI+goIALx9iL3Z7uBePMtDPuQByMnb
fHZ5J8qH+vR2c8itjjhHNyKw3D2rop3yQUw/FvMh+3SZxaojN0YEmf4RpGMbXDEW
Q6OzTkm0sx5mbWuidTSBz+/LTF+MN1D8haYgRIEtH4FAYMNwyQ1jvJOjig1NFGlZ
iiPu64IDhSCspykNw6KfBX8Qm3Jg2Tx0D8+Wlxr7AflMhT8m/5oKOG7zJNl07suq
3CS7kl9zK1FuPbc4IbcuxgPKXfZthXCHIqqpk8PuHkc0UHBqaS8HvFdJP7DeGhdq
2R54XobrcNQ3Dxl4ubCvuet/3BH9IKz1VPmQbw70iedtOQ3TTmDQAjwRtFUhOz8=
=BY5M
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
