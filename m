Return-Path: virtio-dev-return-3414-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id BDD225818F03
	for <virtio-dev@lists.oasis-open.org>; Mon,  5 Mar 2018 03:34:05 -0800 (PST)
Date: Mon, 5 Mar 2018 11:33:53 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180305113353.GH7910@stefanha-x1.localdomain>
References: <1519800868-19594-1-git-send-email-changpeng.liu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PW0Eas8rCkcu1VkF"
Content-Disposition: inline
In-Reply-To: <1519800868-19594-1-git-send-email-changpeng.liu@intel.com>
Subject: [virtio-dev] Re: [RFC v2] virtio-blk: add discard and write zeroes features to
 specification
To: Changpeng Liu <changpeng.liu@intel.com>
Cc: virtio-dev@lists.oasis-open.org, cavery@redhat.com, pbonzini@redhat.com, pawelx.wodkowski@intel.com, james.r.harris@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

--PW0Eas8rCkcu1VkF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2018 at 02:54:28PM +0800, Changpeng Liu wrote:
> @@ -4211,6 +4227,17 @@ according to the native endian of the guest rather=
 than
>    after reset can be either writeback or writethrough.  The actual
>    mode can be determined by reading \field{writeback} after feature
>    negotiation.
> +
> +\item If the VIRTIO_BLK_F_DISCARD feature is negotiated,
> +    \field{max_discard_sectors} and \field{max_discard_seg} can be read
> +    to determine the maximum discard sectors and maximum number of disca=
rd
> +    segments for the block driver to use. \field{discard_sector_alignmen=
t}
> +    can be used by OS when splitting a request based on alignment.
> +
> +\item if the VIRTIO_BLK_F_WRITE_ZEROES feature is negotiated,
> +    \field{max_write_zeroes_sectors} and \field{max_write_zeroes_seg} can
> +    be read to determine the maximum write zeroes sectors and maximum
> +    number of write zeroes segments for the block driver to use.

Does "sectors" use the same 512-byte units as the capacity field?  The
term "sectors" is slightly ambiguous in this spec so it would be helpful
to describe it explicitly.

What are the units of discard_sector_alignment?

>  The \field{sector} number indicates the offset (multiplied by 512) where
>  the read or write is to occur. This field is unused and set to 0
>  for scsi packet commands and for flush commands.
> =20
> +The \field{sector} number indicates the offset (multiplied by 512) where
> +the read or write is to occur. This field is unused and set to 0 for
> +commands other than read or write.

This paragraph has been duplicated.

--PW0Eas8rCkcu1VkF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJanSshAAoJEJykq7OBq3PIykIH/0J8auDlm/55hkcTHBpaER/C
NV6oAGT7wO8113WvgYTkc+iAReJU0ZKDdqqzafZkSkmq2vs9i/rxrPgH2rVC5iRu
uA3cHRI3USVvi5xF4vgafXMzJ71ARp4yGRdqSJ9uekHIUYvIwhBzPpOAY4mfpOOX
XwfLXK5Ip6E9/sMPmN/Js0bOfPVi+4spLMKw3IyPxOUJFcsxrBk8f2mQFfMb2EWv
bLHxwuYUeMC1/D6biEmK/FnaRHOnw0DdXVgkuHwm8vYMyDiYpmfy/Fi0ecuWjxgM
fkYsbFERGTk5aTBdRaXi7To09tuPdP6SZs3ykDIAMUMWLWV7/nVXpY93ePanZm0=
=q4PE
-----END PGP SIGNATURE-----

--PW0Eas8rCkcu1VkF--
