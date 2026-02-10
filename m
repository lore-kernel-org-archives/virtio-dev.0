Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2599818C933
	for <virtio-dev@lists.linux.dev>; Tue, 10 Feb 2026 21:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770758331; cv=none; b=Ajw75VlokxHc9Av+UzA4AfIpJ96ba9oMrNlffCGS02JWbpsrToIAhRWw/zcme36bi3iomo+udCRqfH8+wPLaNAlACkjSW65v/vvi7M6vnKfNJKqnlz0AeqI/ENXiZ4vezsY+A/agpmTqEszGBN0PoJPtqLUpAWNvhiT/aejIF+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770758331; c=relaxed/simple;
	bh=HTB/KHmIXJ3/wNmE6Yi3evV2N4xVP7G9OlSaODK/pLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6M292KfSsbPqSj3ZRgU5VVBZ8iWXu6NvvMQfCzFzYaQ/4W9+IhG7qucOatEldiLDrgJkPdREp45Syiw9v4T3ZqusqJaTh3KCOMWBVkLbyOOfrHY9P13sZJto+MowwP+bpRWuXeZvcK4bHHwRH4Kr6nSVGwWHgtgZEnTOn8eqgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AaUeLI/F; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AaUeLI/F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770758329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w9Gp4oNlIyK7sAyakyCxI6hrN8RiGBdf60qKQG3MhJI=;
	b=AaUeLI/FggKwXMJthpMd8uu0jA56KDMaX9Ce679C6Ke3g4HX5dOOgkUdRApVDcFoAEz7qI
	pX2f/M9nziEFeT9U5g+DdubntRjQngsOJjJ8XNWXs0zhRuBqb2+y74rrnQajWhLLiF1rC+
	/gFuvSWMQDrT0y5pGTuQ7t1ThX7SP3k=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-VPcxP4hBOZKZkuzsb0gS1A-1; Tue,
 10 Feb 2026 16:18:45 -0500
X-MC-Unique: VPcxP4hBOZKZkuzsb0gS1A-1
X-Mimecast-MFC-AGG-ID: VPcxP4hBOZKZkuzsb0gS1A_1770758324
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 506811956056;
	Tue, 10 Feb 2026 21:18:44 +0000 (UTC)
Received: from localhost (unknown [10.2.17.130])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ACEB51800464;
	Tue, 10 Feb 2026 21:18:43 +0000 (UTC)
Date: Tue, 10 Feb 2026 16:18:42 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
Cc: virtio-dev@lists.linux.dev, quic_dshaikhu@quicinc.com
Subject: Re: [PATCH v2 1/1] virtio-blk: Add inline encryption support
Message-ID: <20260210211842.GA158755@fedora>
References: <20260210083208.472824-1-linlin.zhang@oss.qualcomm.com>
 <20260210083208.472824-2-linlin.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jF7AJY1Zi/yx4fAx"
Content-Disposition: inline
In-Reply-To: <20260210083208.472824-2-linlin.zhang@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111


--jF7AJY1Zi/yx4fAx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 12:32:08AM -0800, Linlin Zhang wrote:
> Inline encryption on virtio block can only be supported when
> the new feature bit VIRTIO_BLK_F_ICE is negotiated.
>=20
> Extend struct virtio_blk_config and struct virtio_blk_req,
> so that crypto capabilities can be got in the frontend and
> encryption metadata can be sent to the backend, together with
> each I/O transaction.
>=20
> About the inline encryption on UFS or eMMC storage, please
> refer to the Linux inline encryption documentation:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/block/inline-encryption.rst
>=20
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/238
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: linlzhan <quic_linlzhan@quicinc.com>
> Signed-off-by: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
> ---
>  device-types/blk/description.tex | 110 ++++++++++++++++++++++++++++++-
>  1 file changed, 108 insertions(+), 2 deletions(-)
>=20
> diff --git a/device-types/blk/description.tex b/device-types/blk/descript=
ion.tex
> index 2712ada..60f46af 100644
> --- a/device-types/blk/description.tex
> +++ b/device-types/blk/description.tex
> @@ -66,6 +66,11 @@ \subsection{Feature bits}\label{sec:Device Types / Blo=
ck Device / Feature bits}
>  	(ZNS). For brevity, these standard documents are referred as "ZBD stand=
ards"
>  	from this point on in the text.
> =20
> +\item[VIRTIO_BLK_F_ICE(22)] Inline Crypto Extensions are supported. Only=
 when this
> +     feature bit is negotiated, the device need expose crypto characteri=
stics in
> +     configuration space and the driver need provide an extended request=
 header
> +     containing a crypto payload for block I/O.

Most of the feature bit descriptions are brief and the details are
covered later in the spec. I suggest doing this here too:

  \item[VIRTIO_BLK_F_ICE (22)] Device supports Inline Crypto Engine functio=
nality.

I changed the name from Inline Crypto Extensions to Inline Crypto Engine
because that terminology is used in the Linux kernel. Web search results
also favor "inline crypto engine" over "inline crypto extensions". Are
you okay with "engine"?

> +
>  \end{description}
> =20
>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / =
Block Device / Feature bits / Legacy Interface: Feature bits}
> @@ -128,6 +133,10 @@ \subsection{Device configuration layout}\label{sec:D=
evice Types / Block Device /
>                  u8 model;
>                  u8 unused2[3];
>          } zoned;
> +        struct virtio_blk_crypto_characteristics {
> +                __virtio16 slot_info;
> +                __virtio16 reserved;
> +        } crypto;
>  };
>  \end{lstlisting}
> =20
> @@ -215,6 +224,18 @@ \subsection{Device configuration layout}\label{sec:D=
evice Types / Block Device /
>  terminated by the device with a "zone resources exceeded" error as defin=
ed for
>  specific commands later.
> =20
> +If the VIRTIO_BLK_F_ICE feature is negotiated, then in
> +\field{virtio_blk_crypto_characteristics},
> +\begin{itemize}
> +\item \field{slot_info} value packs two 8-bits values to reduce the numb=
er of

8-bits -> 8-bit

> +    Configuration Space reads.
> +    \begin{itemize}
> +        \item Bits~\[15:8] (\emph{max\_slots}): the maximum number of su=
pported
> +            crypto key slots.
> +        \item Bits~\[7:0] (\emph{slot\_offset}): an offset applied to sl=
ot numbering.

What is the purpose of slot_offset? This field is not used much in this
spec, maybe it can be removed?

Does that mean only slots in the range [slot_offset:max_slots) are
available or does it mean that the range is
[slot_offset:slot_offset+max_slots)?

> +    \end{itemize}
> +\end{itemize}
> +
>  \subsubsection{Legacy Interface: Device configuration layout}\label{sec:=
Device Types / Block Device / Device configuration layout / Legacy Interfac=
e: Device configuration layout}
>  When using the legacy interface, transitional devices and drivers
>  MUST format the fields in struct virtio_blk_config
> @@ -278,6 +299,10 @@ \subsection{Device Initialization}\label{sec:Device =
Types / Block Device / Devic
>      \field{zoned} can be read by the driver to determine the zone
>      characteristics of the device. All \field{zoned} fields are read-onl=
y.
> =20
> +\item If the VIRTIO_BLK_F_ICE feature is negotiated, the fields in
> +    \field{crypto} can be read by the driver to determine the inline cry=
pto
> +    characteristics of the device. All \field{crypto} fields are read-on=
ly.
> +
>  \end{enumerate}
> =20
>  \drivernormative{\subsubsection}{Device Initialization}{Device Types / B=
lock Device / Device Initialization}
> @@ -317,6 +342,9 @@ \subsection{Device Initialization}\label{sec:Device T=
ypes / Block Device / Devic
>      driver SHOULD ignore all other fields in \field{zoned}.
>  \end{itemize}
> =20
> +If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver MUST vali=
date
> +    the max_slots in \field{slot_info} before the slot usage.

I'm not sure how the driver is supposed to validate max_slots?

> +
>  \devicenormative{\subsubsection}{Device Initialization}{Device Types / B=
lock Device / Device Initialization}
> =20
>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
> @@ -402,6 +430,13 @@ \subsection{Device Initialization}\label{sec:Device =
Types / Block Device / Devic
>  \item the device MUST initialize padding bytes \field{unused2} to 0.
>  \end{itemize}
> =20
> +If the VIRTIO_BLK_F_ICE feature is negotiated, then the fields in \field=
{crypto}
> +struct in the configuration space MUST be set by the device.
> +\begin{itemize}
> +\item the \field{slot_info} field of \field{crypto} MUST be set by the d=
evice to a
> +    max_slots in the higher 8 bits and slot_offset in the lower 8 bits.
> +\end{itemize}

There is no need for the \begin{itemize} here. It contains no new
information. The fields were already described in the configuration
space section and the previous sentence already said that the fields in
\field{crypto} must be set by the device.

> +
>  \subsubsection{Legacy Interface: Device Initialization}\label{sec:Device=
 Types / Block Device / Device Initialization / Legacy Interface: Device In=
itialization}
> =20
>  Because legacy devices do not have FEATURES_OK, transitional devices
> @@ -436,6 +471,13 @@ \subsection{Device Operation}\label{sec:Device Types=
 / Block Device / Device Ope
>          le32 type;
>          le32 reserved;
>          le64 sector;
> +        struct virtio_blk_crypto_payload {
> +            u8 slot;
> +            u8 activate;
> +            le16 reserved1;
> +            le32 reserved2;
> +            le64 data_unit_num;
> +        } payload;

"payload" is a generic term. crypto_payload would be clearer.

I wonder whether consistently calling this feature "ice" rather than
"crypto" would help in case self-encrypting drive or other cryptographic
functionality is added to virtio-blk in the future. That way the spec
items related to inline crypto engine functionality will be easy to
differentiate from other crypto functionality.

>          u8 data[];
>          u8 status;
>  };
> @@ -445,8 +487,9 @@ \subsection{Device Operation}\label{sec:Device Types =
/ Block Device / Device Ope
>  (VIRTIO_BLK_T_OUT), a discard (VIRTIO_BLK_T_DISCARD), a write zeroes
>  (VIRTIO_BLK_T_WRITE_ZEROES), a flush (VIRTIO_BLK_T_FLUSH), a get device =
ID
>  string command (VIRTIO_BLK_T_GET_ID), a secure erase
> -(VIRTIO_BLK_T_SECURE_ERASE), or a get device lifetime command
> -(VIRTIO_BLK_T_GET_LIFETIME).
> +(VIRTIO_BLK_T_SECURE_ERASE), a get device lifetime command
> +(VIRTIO_BLK_T_GET_LIFETIME), or a get device crypto capabilities command
> +(VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES).
> =20
>  \begin{lstlisting}
>  #define VIRTIO_BLK_T_IN           0
> @@ -457,12 +500,27 @@ \subsection{Device Operation}\label{sec:Device Type=
s / Block Device / Device Ope
>  #define VIRTIO_BLK_T_DISCARD      11
>  #define VIRTIO_BLK_T_WRITE_ZEROES 13
>  #define VIRTIO_BLK_T_SECURE_ERASE   14
> +#define VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES   27

The Linux virtio_blk.c driver assumes that odd numbered constants have
data buffers that are read by the device, so you may run into a bug when
using 27.

There is an informal convention to use even numbers for read requests
and odd numbers for write requests. It doesn't hurt to try to follow the
convention even though it's not strictly necessary.

The Linux driver could be fixed when adding support for ICE, but 16 is
available and it's safest to use that.

>  \end{lstlisting}
> =20
>  The \field{sector} number indicates the offset (multiplied by 512) where
>  the read or write is to occur. This field is unused and set to 0 for
>  commands other than read, write and some zone operations.
> =20
> +The \field{payload} consists of the encryption information for current
> +request. It is only present when the VIRTIO_BLK_F_ICE feature is negotia=
ted and
> +\field{type} is VIRTIO_BLK_T_IN, VIRTIO_BLK_T_OUT or VIRTIO_BLK_T_FLUSH.

TODO think about layout

> +\begin{itemize}
> +\item The \field{slot} field in \field{payload} indicates the ICE
> +  (Inline Crypto Encryption) slot index where the key resides.
> +
> +\item The \field{activate} field in \field{payload} implies this is a
> +  inline encryption request.
> +
> +\item The \field{data_unit_num} field in \field{payload} indicates the
> +  starting block of the request.

This is a block device, so the term "block" needs to be qualified to
avoid confusion. I guess this is the cryptography concept of a block
rather than the disk concept of a block. Please clarify this in the
text, maybe by explaining that the ICE handles data in fixed-size "data
units" instead of using the word "block".

Also, can you explain the relationship between the data unit number and
the sector? In simple cases I imagine the data unit number would be the
sector. How is the driver supposed to pick or calculate the data unit
number?

> +\end{itemize}
> +
>  VIRTIO_BLK_T_IN requests populate \field{data} with the contents of sect=
ors
>  read from the block device (in multiples of 512 bytes).  VIRTIO_BLK_T_OUT
>  requests write the contents of \field{data} to the block device (in mult=
iples
> @@ -530,6 +588,47 @@ \subsection{Device Operation}\label{sec:Device Types=
 / Block Device / Device Ope
>  The \field{device_lifetime_est_typ_b} refers to wear of MLC cells and is=
 provided
>  with the same semantics as \field{device_lifetime_est_typ_a}.
> =20
> +VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests fetch the storage hardware=
 crypto
> +capabilities into \field{data}. And the \field{data} is of the form

How does VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES behave when data[] is too
small to fit all the device's crypto capabilities?

> +
> +\begin{lstlisting}
> +struct virtio_blk_crypto_caps {
> +  u8 size;
> +  le32 crypto_capabilities[];
> +};
> +\end{lstlisting}
> +
> +The \field{size} specifies the size of array \field{crypto_capabilities}.

"number of elements" would be clearer than "size of array" because the
unit (bytes vs array elements) is ambiguous.

The size field is not necessary since Used Ring descriptors contain
(struct virtq_used_elem in the spec) a len field indicating how many
bytes were written by the device.

> +The \field{crypto_capabilities} indicates the crypto capabilities suppor=
ted by the
> +hardware storage for inline encryption.
> +
> +A crypto capability packs four 8-bits values:
> +\begin{itemize}
> +    \item Bits~\[31:24]: crypto algorithm identifiers.
> +    The device supports reporting and negotiating cryptographic algorith=
ms
> +    using the following algorithm identifiers:
> +    \begin{lstlisting}
> +        CRYPTO_ALG_AES_XTS              =3D 0x0
> +        CRYPTO_ALG_BITLOCKER_AES_CBC    =3D 0x1
> +        CRYPTO_ALG_AES_ECB              =3D 0x2
> +        CRYPTO_ALG_ESSIV_AES_CBC        =3D 0x3
> +    \end{lstlisting}
> +    These identifiers abstract the underlying hardware crypto implementa=
tion
> +    and does not assume any operating=E2=80=91system=E2=80=91specific da=
ta structures or
> +    constants.
> +    \item Bits~\[23:16]: mask of data unit size. When bit j in this field
> +    (j=3D7......0) is set, a data unit size of 512*2^j bytes is selected.

Is only one bit ever set in the mask? If so, then maybe just express j
as an 8-bit unsigned integer (i.e. the exponent in 512*2^j) instead of
as a bit mask. It's simpler and increases the range for j.

> +    \item Bits~\[15:8]: crypto key size identifiers.
> +    \begin{lstlisting}
> +        CRYPTO_KEY_SIZE_INVALID     =3D 0x0
> +        CRYPTO_KEY_SIZE_128_BITS    =3D 0x1
> +        CRYPTO_KEY_SIZE_192_BITS    =3D 0x2
> +        CRYPTO_KEY_SIZE_256_BITS    =3D 0x3
> +        CRYPTO_KEY_SIZE_512_BITS    =3D 0x4
> +    \end{lstlisting}
> +    \item Bits~\[7:0]: unused.
> +\end{itemize}

A struct would be more natural here (the rest of the VIRTIO
specification rarely packs fields into an integer):

  struct virtio_blk_crypto_cap {
      u8 alg;
      u8 data_unit_size;
      u8 key_size;
      u8 reserved;
  };

By the way, Linux seems to call this a "profile" rather than a
"capability". Do you want to use the same name as Linux for consistency?

> +
>  The final \field{status} byte is written by the device: either
>  VIRTIO_BLK_S_OK for success, VIRTIO_BLK_S_IOERR for device or driver
>  error or VIRTIO_BLK_S_UNSUPP for a request unsupported by device:
> @@ -912,6 +1011,13 @@ \subsection{Device Operation}\label{sec:Device Type=
s / Block Device / Device Ope
>  successfully, failed, or were processed by the device at all if the requ=
est
>  failed with VIRTIO_BLK_S_IOERR.
> =20
> +The length of \field{data} MUST be a multiple of 4 bytes plus 1 for
> +VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests.
> +
> +A driver MUST set \field{activate} to 1 for VIRTIO_BLK_T_IN,VIRTIO_BLK_T=
_OUT,
> +    and VIRTIO_BLK_T_FLUSH requests that require inline encryption. For =
other
> +    request types or when inline encryption is not required, it is set t=
o 0.
> +
>  The following requirements only apply if the VIRTIO_BLK_F_ZONED feature =
is
>  negotiated.

How does the driver assign a specific capability (algorithm, data unit
size, and key size tuple reported by
VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES) to a slot?

How does the driver assign the key material for a slot?

Stefan

--jF7AJY1Zi/yx4fAx
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmLoLIACgkQnKSrs4Gr
c8h1KAf+PBGIvfPVpQA7S35OqQ6E73Dt3nLCnSTP26zF2frNULR/4Sd4t3AAKzu9
D+ZpjvHLql0Sx5XCddWYEcdyeFEXqPAsr0HvnThsCaAViO7Whbfr8JvntXdl022O
5dtpJ/joE5Cnaa5YDImltGpV65mbNH4zLaxTihyKgYiMfmFOSTu6FItCiRczLaRB
ijamITiJQg2j95uaCULPIYxUF5Gh03CqLBxl1yWmafGDXUgCFe5NaeRyo6thPPrI
kFaDbbKTITXZNMHy/TgKwRKyADKnNBpDVe1BRtk2oQydVX/bf6TtPNbbSxHA9lwF
WzX1MIDOWEAMxJ0WjbLHrryVqam9XQ==
=1pgZ
-----END PGP SIGNATURE-----

--jF7AJY1Zi/yx4fAx--

