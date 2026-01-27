Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BA427B343
	for <virtio-dev@lists.linux.dev>; Tue, 27 Jan 2026 21:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769548200; cv=none; b=rjn/+TwYg7e6AK+jDQXcXSlXiuHPLGPbLQaQhtngytua8uP/rWmiZdoI2hWfGx0+LgkIYdMUpF8y4WKIvNlfxJ0JiZTuxHHOaJ8seNcgnJDJMTFhBVjBr9QSvl14OS61gX1AkXd8fQBBo4HSJp6JqHEqghlhlGmvTDUrz6Lyu08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769548200; c=relaxed/simple;
	bh=yfR8fcHhuaNzbosZQvQPEIJXvA0CI5HnI6/Gy1ebcU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nnStwiWQDcmXUyXq1h8PD/Si8Fqod1EiRkzN1YSmhjjb9R3F4V8hGmnj7yzA7Ju5Kd+L5Irq7eY/rhFlNh6+DtOFZUAMSkMLGy3ZI0sY5FYg+BjwLqpxYCPk8R7UL3fPfuBdfwrWGkYEJJHb+ZhmR5zo35RjWVw6R7dVkFzA1ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A4p+UOZx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A4p+UOZx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769548197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nb/2uJiYA8dSXxDjfG2sINCvPklnHxicZDJTcHdxP6g=;
	b=A4p+UOZxDBu8A3Je7Z2m4De3pSkCABcSatGK7GNYfBYi4Owx4XZQp2z+0Sjv2eBvkf4b/o
	RTaWQysWfI5FUd9+kG/Zie+mCyQB1kgZZNA9DHcDlIGfPrQazYRCgCOagS1QtY4W2ykrvn
	d+ZhX2CoaBlHEMOyKGAuxedfEdTLesk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-lNzA78FONaWBYa-iNiarHw-1; Tue,
 27 Jan 2026 16:09:53 -0500
X-MC-Unique: lNzA78FONaWBYa-iNiarHw-1
X-Mimecast-MFC-AGG-ID: lNzA78FONaWBYa-iNiarHw_1769548192
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9D60F18005BA;
	Tue, 27 Jan 2026 21:09:52 +0000 (UTC)
Received: from localhost (unknown [10.2.16.97])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1F7C819560B4;
	Tue, 27 Jan 2026 21:09:51 +0000 (UTC)
Date: Tue, 27 Jan 2026 16:09:51 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Linlin Zhang <quic_linlzhan@quicinc.com>
Cc: virtio-dev@lists.linux.dev, quic_dshaikhu@quicinc.com
Subject: Re: [PATCH v1] virtio-blk: Add inline encryption support
Message-ID: <20260127210951.GA96301@fedora>
References: <20260127141432.2617357-1-quic_linlzhan@quicinc.com>
 <20260127142032.2619551-1-quic_linlzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pmzsL2FTZqWa7WEz"
Content-Disposition: inline
In-Reply-To: <20260127142032.2619551-1-quic_linlzhan@quicinc.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


--pmzsL2FTZqWa7WEz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 27, 2026 at 10:20:32PM +0800, Linlin Zhang wrote:
> From: linlzhan <quic_linlzhan@quicinc.com>
>=20
> Inline encryption on virtio block can only be supported when
> the new feature bit VIRTIO_BLK_F_ICE is negotiated.
>=20
> Extend struct virtio_blk_config and struct virtio_blk_req,
> so that crypto capabilities can be got in the frontend and
> encryption metadata can be sent to the backend, together with
> each I/O transaction.

This looks like a Self-Encrypting Drives feature along the lines of TCG
Opal:
https://en.wikipedia.org/wiki/Opal_Storage_Specification

Would it make sense to implement TCG Opal instead of defining a new
interface? That would make this more familiar to users and simplify
integration into existing tools like sedutil and cryptsetup (e.g. by
supporting the <linux/sed-opal.h> ioctl interface).

> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/238
>=20
> Change-Id: Ic23b2137e5d9a599d826e06c279f1b614d79abdf
> Signed-off-by: linlzhan <quic_linlzhan@quicinc.com>
> ---
>  device-types/blk/description.tex | 69 ++++++++++++++++++++++++++++++++
>  1 file changed, 69 insertions(+)
>=20
> diff --git a/device-types/blk/description.tex b/device-types/blk/descript=
ion.tex
> index 2712ada..23d8dc0 100644
> --- a/device-types/blk/description.tex
> +++ b/device-types/blk/description.tex
> @@ -66,6 +66,11 @@ \subsection{Feature bits}\label{sec:Device Types / Blo=
ck Device / Feature bits}
>  	(ZNS). For brevity, these standard documents are referred as "ZBD stand=
ards"
>  	from this point on in the text.
> =20
> +\item[VIRTIO_BLK_F_ICE(22)] Inline Crypto Extensions are supported. When=
 this
> +     is negotiated, the device exposes crypto characteristics in configu=
ration
> +     space and the driver SHALL provide an extended request header conta=
ining a

SHALL, MUST, MAY, etc are only used in the normative sections of the
spec.

Why "SHALL"? Does this mean the device must be prepared to receive
requests without the payload field when VIRTIO_BLK_F_ICE is negotiated?
How should the device behave in that case: fail the request or perform
I/O without crypto?

> +     crypto payload for block I/O.
> +
>  \end{description}
> =20
>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / =
Block Device / Feature bits / Legacy Interface: Feature bits}
> @@ -128,6 +133,11 @@ \subsection{Device configuration layout}\label{sec:D=
evice Types / Block Device /
>                  u8 model;
>                  u8 unused2[3];
>          } zoned;
> +        struct virtio_blk_crypto_characteristics {
> +                __virtio16 slot_info;
> +                __virtio16 reserved;
> +                __virtio32 capability;
> +        } crypto;
>  };
>  \end{lstlisting}
> =20
> @@ -215,6 +225,25 @@ \subsection{Device configuration layout}\label{sec:D=
evice Types / Block Device /
>  terminated by the device with a "zone resources exceeded" error as defin=
ed for
>  specific commands later.
> =20
> +If the VIRTIO_BLK_F_ICE feature is negotiated, then in
> +\field{virtio_blk_crypto_characteristics},
> +\begin{itemize}
> +\item \field{slot_info} value packs two 8-bits values:
> +    \begin{itemize}
> +        \item Bits~\[15:8] (\emph{max\_slots}): the maximum number of su=
pported
> +            crypto key slots.
> +        \item Bits~\[7:0] (\emph{slot\_offset}): an offset applied to sl=
ot numbering.
> +    \end{itemize}
> +\item \field{capability} value packs four 8-bits values:
> +    \begin{itemize}
> +        \item Bits~\[31:24]: crypto algorithm id.
> +        \item Bits~\[23:16]: mask of data unit size.
> +        \item Bits~\[15:8]: crypto key size.
> +        \item Bits~\[7:0]: unused.
> +    \end{itemize}

Why are these fields packed? Configuration Space can have u8 fields.

These fields are not sufficiently documented. Where are the crypto
algorithm ids listed, etc?

How can a device support multiple algorithms? I think Configuration
Space may not be flexible enough for this. You could introduce a
GET_CRYPTO_INFO request type that allows the driver to fetch arrays of
crypto algorithm characteristics.

> +\end{itemize}
> +
> +
>  \subsubsection{Legacy Interface: Device configuration layout}\label{sec:=
Device Types / Block Device / Device configuration layout / Legacy Interfac=
e: Device configuration layout}
>  When using the legacy interface, transitional devices and drivers
>  MUST format the fields in struct virtio_blk_config
> @@ -278,6 +307,10 @@ \subsection{Device Initialization}\label{sec:Device =
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
> @@ -317,6 +350,9 @@ \subsection{Device Initialization}\label{sec:Device T=
ypes / Block Device / Devic
>      driver SHOULD ignore all other fields in \field{zoned}.
>  \end{itemize}
> =20
> +If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver must vali=
date
> +    the max_slots in \field{slot_info} before the slot usage.
> +
>  \devicenormative{\subsubsection}{Device Initialization}{Device Types / B=
lock Device / Device Initialization}
> =20
>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
> @@ -402,6 +438,16 @@ \subsection{Device Initialization}\label{sec:Device =
Types / Block Device / Devic
>  \item the device MUST initialize padding bytes \field{unused2} to 0.
>  \end{itemize}
> =20
> +If the VIRTIO_BLK_F_ICE feature is negotiated, then the fields in \field=
{cryto}

s/cryto/crypto/

> +struct in the configuration space MUST be set by the device.
> +\begin{itemize}
> +\item the \field{slot_info} field of \field{crypto} MUST be set by the d=
evice to a
> +    max_slots in the higher 8 bits and slot_offset in the lower 8 bits.
> +
> +\item the \field{capability} field of \field{crypto} MUST be set by the =
device
> +    to a crypto capability read from the storage register.
> +\end{itemize}
> +
>  \subsubsection{Legacy Interface: Device Initialization}\label{sec:Device=
 Types / Block Device / Device Initialization / Legacy Interface: Device In=
itialization}
> =20
>  Because legacy devices do not have FEATURES_OK, transitional devices
> @@ -436,6 +482,13 @@ \subsection{Device Operation}\label{sec:Device Types=
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
>          u8 data[];
>          u8 status;
>  };
> @@ -463,6 +516,20 @@ \subsection{Device Operation}\label{sec:Device Types=
 / Block Device / Device Ope
>  the read or write is to occur. This field is unused and set to 0 for
>  commands other than read, write and some zone operations.
> =20
> +The \field{payload} consists of the encryption information for current
> +request. It need to be set by the driver only when the feature VIRTIO_BL=
K_F_ICE
> +is negotiated.

"set" is ambiguous: does it meaning filling in the fields or does it
mean the fields are only present when VIRTIO_BLK_F_ICE is negotiated
(this distinction is important if other features add more fields after
payload in the future).

The sentence could be reworded:

  It is only present when the VIRTIO_BLK_F_ICE feature is negotiated and
  \field{type} is VIRTIO_BLK_T_IN or VIRTIO_BLK_T_OUT.

(I'm not sure whether DISCARD, WRITE_ZEROES, or SECURE_ERASE also need
the payload field. It seems like GET_ID and GET_LIFETIME do not need the
payload field.)

> +\begin{itemize}
> +\item The \field{slot} filed in \field{payload} indicates the ICE

s/filed/field/

> +  (Inline Crypto Encryption) slot index where the key resides in.

s/where the key resides in/where the key resides/

> +
> +\item The \field{activate} filed in \field{payload} implies this is a

s/filed/field/

> +  encryption request.

Does "encryption" really mean just encryption or does it mean
encryption for writes and decryption for reads?

> +
> +\item The \field{data_unit_num} filed in \field{payload} indicates the

s/filed/field/

> +  starting block of the request.
> +\end{itemize}
> +
>  VIRTIO_BLK_T_IN requests populate \field{data} with the contents of sect=
ors
>  read from the block device (in multiples of 512 bytes).  VIRTIO_BLK_T_OUT
>  requests write the contents of \field{data} to the block device (in mult=
iples
> @@ -912,6 +979,8 @@ \subsection{Device Operation}\label{sec:Device Types =
/ Block Device / Device Ope
>  successfully, failed, or were processed by the device at all if the requ=
est
>  failed with VIRTIO_BLK_S_IOERR.
> =20
> +A driver MUST set \field{activate} to 0 for a non VIRTIO_BLK_F_ICE reque=
st.

Please explicitly list request types where the payload field is present
and where activate is optional.

> +
>  The following requirements only apply if the VIRTIO_BLK_F_ZONED feature =
is
>  negotiated.
> =20
> --=20
> 2.34.1
>=20
>=20

--pmzsL2FTZqWa7WEz
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAml5KZ4ACgkQnKSrs4Gr
c8itBQgAvy8RC6e3V/PX0g73YTwXt01+FLmJTc7qiqrC+Awt4I+3RPJjTu/qIq+y
6p7Z7BAXN2wtJGCEL85m+Dq5vDNfYVYa71b1iWkcgz/qnYHytEZ8rx3ieyV2CMrk
LTc0ClS//yQCvw5sU9B6+4iGHUtWxgDAilBRR7P/WJlvllCdO08Z62aPtdZ6YPJs
TkkmlkDTUKG9SR109oTR7O60nYcARfK70CJNNmjnV+LIKhezAv1MaAlAteM3GY9Y
mEeczLEAhU+iKFFgKlmnpSHslrk//Lc26ZKjXRHn1nGbCe5nsu4i9+/xduP3aWqU
83kxFnWHg7ekzHlAGFWRICROTvLIwA==
=Dosf
-----END PGP SIGNATURE-----

--pmzsL2FTZqWa7WEz--

