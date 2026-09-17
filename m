Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0C2491581
	for <virtio-dev@lists.linux.dev>; Mon, 21 Sep 2026 13:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789997863; cv=none; b=swkeeb5CMGa9yEograYNDe25kyiOVV/VKRRweFJHVTdgukLOjAIXKbAzmZoV615clQEBVYKd+b+wwVA6mpKgw6apdIxd38njkgT6gZrxpaMc+qFZz8jVC5FIoOO1MB816N/mrGnFvY8Y24G3BNm6Bv7Ry3HH2AQYTK7B3liZWqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789997863; c=relaxed/simple;
	bh=ZgmRp7QI1a8gOPLgHltpEoUUn4nG1lAFZWCiMEwQbVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auppgk+PSO5BnS0pPqy7OKeeBH7bnmaOvxHMFDnC9krBTz/zo1U7LHDIlnm2B5faDPiEkG1sAhgyxN5pGblsdtP/jaV4HvvyBmJVX1B09n5m7KeVgkqlX+DzODbeJkO1mOoHJTre707DlfOtUwZfhz3M7zZeoL88Lnyr+ITfxDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QWrQfzSh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QWrQfzSh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789997857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JxzDDDtfdz51i+0+rCV00g8j8jSS2c2iAyM3+lNBI9U=;
	b=QWrQfzShCogD7543dF8KkifqPvmtaedRKnjBtMq+lIQ231FLNfb9H1MWIIA7jmYEvF6avk
	xNft5ej1aYDi3GDo1xEttThMtQ/CoRmUFcfmMJQTsHY5w+2mLJmjlQkOJVT9IcnZ1SEldh
	klcJg05BiV+KLLRveD1OWULX3qYOrnY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-CcFVGGsSOuW8aAFVfP3krw-1; Mon,
 21 Sep 2026 09:37:33 -0400
X-MC-Unique: CcFVGGsSOuW8aAFVfP3krw-1
X-Mimecast-MFC-AGG-ID: CcFVGGsSOuW8aAFVfP3krw_1789997852
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C11D4184B3B9;
	Mon, 21 Sep 2026 13:37:32 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3B1E4180057F;
	Mon, 21 Sep 2026 13:37:32 +0000 (UTC)
Date: Thu, 17 Sep 2026 17:05:02 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
Cc: virtio-dev@lists.linux.dev, ebiggers@kernel.org,
	neeraj.soni@oss.qualcomm.com
Subject: Re: [PATCH v3 2/2] virtio-blk: Add inline encryption support
Message-ID: <20260917210502.GC331587@fedora>
References: <20260913161628.368484-1-linlin.zhang@oss.qualcomm.com>
 <20260913161628.368484-3-linlin.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="g2RUInp6Y5aculox"
Content-Disposition: inline
In-Reply-To: <20260913161628.368484-3-linlin.zhang@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

--g2RUInp6Y5aculox
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 09:16:15AM -0700, Linlin Zhang wrote:
> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>=20
> Add VIRTIO_BLK_F_IE to advertise inline encryption support.
>=20
> Add the virtio-blk inline encryption protocol, including device
> capabilities, encrypted request metadata, crypto mode discovery,
> key management commands, keyslot state semantics, and DUN handling.
>=20
> This allows drivers to use device-backed inline encryption while
> preserving key and request capability validation across implementations.
>=20
> Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/238
> ---
>  device-types/blk/description.tex | 450 +++++++++++++++++++++++++++++--
>  1 file changed, 428 insertions(+), 22 deletions(-)
>=20
> diff --git a/device-types/blk/description.tex b/device-types/blk/descript=
ion.tex
> index 9bfdc4a..5869af0 100644
> --- a/device-types/blk/description.tex
> +++ b/device-types/blk/description.tex
> @@ -21,7 +21,8 @@ \subsection{Virtqueues}\label{sec:Device Types / Block =
Device / Virtqueues}
> =20
>  If VIRTIO_BLK_F_CTRL_VQ is negotiated, the control virtqueue is appended
>  after the request virtqueues. The control virtqueue is reserved for cont=
rol
> -requests defined by this specification.
> +requests defined by this specification, including the cryptographic cont=
rol
> +requests described below.
> =20
>  \subsection{Feature bits}\label{sec:Device Types / Block Device / Featur=
e bits}
> =20
> @@ -75,11 +76,21 @@ \subsection{Feature bits}\label{sec:Device Types / Bl=
ock Device / Feature bits}
>      bitfield in the \field{virtio_blk_req} structure.
> =20
>  \item[VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA (19)] Device supports the
> -    VIRTIO_BLK_REQ_FLAG_OUT_FUA flag in the \field{flags} bitfield of the
> -    \field{virtio_blk_req} structure for VIRTIO_BLK_T_OUT requests.
> +    VIRTIO_BLK_REQ_FLAG_OUT_FUA flag in the \field{flags} bitfield in the
> +    \field{virtio_blk_req} structure for VIRTIO_BLK_T_OUT and
> +    VIRTIO_BLK_T_CRYPTO_OUT requests.
> =20
>  \item[VIRTIO_BLK_F_CTRL_VQ (22)] Device supports a control virtqueue.
> =20
> +\item[VIRTIO_BLK_F_INLINE_ENCRYPTION (23)] Only when the storage backend
> +    supports inline encryption and this feature bit is negotiated, the d=
ata
> +    read from or written to the device can be decrypted from or encrypte=
d to
> +    the storage via an inline crypto engine. Keys are provisioned into k=
ey
> +    slots of the device, and requests identify, by key slot index, which
> +    provisioned key to use. The number of key slots, the maximum size of
> +    the Data Unit Number (DUN) and the supported key types are reported
> +    in \field{enc_characteristics}.
> +
>  \end{description}
> =20
>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / =
Block Device / Feature bits / Legacy Interface: Feature bits}
> @@ -142,6 +153,12 @@ \subsection{Device configuration layout}\label{sec:D=
evice Types / Block Device /
>                  u8 model;
>                  u8 unused2[3];
>          } zoned;
> +        struct virtio_blk_enc_characteristics {
> +                le16 max_slots;
> +                u8 max_dun_bytes;
> +                u8 key_types;
> +                le32 unused3;
> +        } enc_characteristics;
>  };
>  \end{lstlisting}
> =20
> @@ -229,6 +246,34 @@ \subsection{Device configuration layout}\label{sec:D=
evice Types / Block Device /
>  terminated by the device with a "zone resources exceeded" error as defin=
ed for
>  specific commands later.
> =20
> +If the VIRTIO_BLK_F_INLINE_ENCRYPTION feature is negotiated, then in
> +\field{virtio_blk_enc_characteristics},
> +\begin{itemize}
> +\item \field{max_slots} is the number of available key slots. Key slots =
are
> +    indexed from 0 to \field{max_slots} - 1.
> +
> +\item \field{max_dun_bytes} is the maximum number of bytes of the Data U=
nit
> +    Number (DUN) that the device supports for any of its supported crypto
> +    modes. For example, known inline crypto engines report a
> +    \field{max_dun_bytes} of 4 (JEDEC eMMC Command Queue Host Controller
> +    Interface, CQHCI) or 8 (JEDEC UFS Host Controller Interface, UFSHCI).
> +
> +\item \field{key_types} is a bitmask of the key types the device support=
s,
> +    using the following values:
> +    \begin{lstlisting}
> +#define VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW    (1 << 0)
> +#define VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED  (1 << 1)
> +    \end{lstlisting}
> +    VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW indicates that keys are provisioned i=
nto
> +    key slots in raw (plaintext) form. VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRA=
PPED
> +    indicates that the key exists only in ephemerally-wrapped form in me=
mory
> +    outside of dedicated hardware, and can only be unwrapped and provisi=
oned
> +    into key slots by dedicated hardware (e.g. a hardware key manager). =
The
> +    plaintext key never exists in software-accessible memory.

VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW and VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED
are not mentioned much in rest of the spec and there may not be enough
information for someone to implement a driver based on this information.

Do you want to say anything else about hw-wrapped keys, like their
lifetime across device reset? Do hw-wrapped keys require a special
initialization sequence after device reset to unlock the keys that the
hardware holds (I guess they need to be recreated by the driver after
reboot or device reset, whereas raw keys can be used forever)?

> +
> +\item \field{unused3} is reserved for future use.
> +\end{itemize}
> +
>  \subsubsection{Legacy Interface: Device configuration layout}\label{sec:=
Device Types / Block Device / Device configuration layout / Legacy Interfac=
e: Device configuration layout}
>  When using the legacy interface, transitional devices and drivers
>  MUST format the fields in struct virtio_blk_config
> @@ -279,7 +324,7 @@ \subsection{Device Initialization}\label{sec:Device T=
ypes / Block Device / Devic
>      number of write zeroes segments for the block driver to use.
> =20
>  \item If the VIRTIO_BLK_F_MQ feature is negotiated, \field{num_queues} f=
ield
> -    can be read to determine the number of queues.
> +     can be read to determine the number of queues.
> =20
>  \item If the VIRTIO_BLK_F_CTRL_VQ feature is negotiated, the driver MUST
>      identify the control virtqueue as queue N, after all request virtque=
ues.
> @@ -295,6 +340,14 @@ \subsection{Device Initialization}\label{sec:Device =
Types / Block Device / Devic
>      \field{zoned} can be read by the driver to determine the zone
>      characteristics of the device. All \field{zoned} fields are read-onl=
y.
> =20
> +\item If the VIRTIO_BLK_F_INLINE_ENCRYPTION feature is negotiated, the f=
ields in
> +    \field{enc_characteristics} can be read by the driver to determine t=
he
> +    inline encryption capabilities of the device, and a
> +    VIRTIO_BLK_T_GET_CRYPTO_MODES control virtqueue request (see
> +    \ref{sec:Device Types / Block Device / Device Operation}) can be sent
> +    to retrieve the set of supported crypto modes. All
> +    \field{enc_characteristics} fields are read-only.
> +
>  \end{enumerate}
> =20
>  \drivernormative{\subsubsection}{Device Initialization}{Device Types / B=
lock Device / Device Initialization}
> @@ -322,6 +375,10 @@ \subsection{Device Initialization}\label{sec:Device =
Types / Block Device / Devic
>  offered by the device with the VIRTIO_BLK_Z_HA or VIRTIO_BLK_Z_NONE zone=
 model,
>  then the driver MAY negotiate these two bits independently.
> =20
> +Zoned devices do not support inline encryption. If the VIRTIO_BLK_F_ZONED
> +feature is offered by the device, then the VIRTIO_BLK_F_INLINE_ENCRYPTION
> +feature MUST NOT be negotiated by the driver.
> +
>  If the VIRTIO_BLK_F_ZONED feature is negotiated, then
>  \begin{itemize}
>  \item if the driver that can not support host-managed zoned devices
> @@ -341,6 +398,20 @@ \subsection{Device Initialization}\label{sec:Device =
Types / Block Device / Devic
>  any request to the control virtqueue unless the request is defined by th=
is
>  specification.
> =20
> +Drivers MUST NOT negotiate the VIRTIO_BLK_F_INLINE_ENCRYPTION feature
> +unless they are capable of:
> +\begin{itemize}
> +\item provisioning and evicting keys in the block device's keyslots thro=
ugh
> +    the control virtqueue.
> +\item submitting the keyslot index and Data Unit Number (DUN) per crypto
> +    request to the device using the \field{virtio_blk_crypto_msg} struct=
ure.
> +\item retrieving the inline encryption characteristics from the device
> +    configuration space.
> +\end{itemize}
> +
> +A driver that negotiates VIRTIO_BLK_F_INLINE_ENCRYPTION MUST also
> +negotiate VIRTIO_BLK_F_CTRL_VQ.
> +
>  \devicenormative{\subsubsection}{Device Initialization}{Device Types / B=
lock Device / Device Initialization}
> =20
>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
> @@ -355,9 +426,15 @@ \subsection{Device Initialization}\label{sec:Device =
Types / Block Device / Devic
>  If the device that is being initialized is a not a zoned device, the dev=
ice
>  SHOULD NOT offer the VIRTIO_BLK_F_ZONED feature.
> =20
> +A zoned device MUST NOT offer the VIRTIO_BLK_F_INLINE_ENCRYPTION feature.
> +
>  The VIRTIO_BLK_F_ZONED feature cannot be properly negotiated without
>  FEATURES_OK bit. Legacy devices MUST NOT offer VIRTIO_BLK_F_ZONED featur=
e bit.
> =20
> +The VIRTIO_BLK_F_INLINE_ENCRYPTION feature cannot be properly negotiated=
 without
> +FEATURES_OK bit. Legacy devices MUST NOT offer the VIRTIO_BLK_F_INLINE_E=
NCRYPTION feature
> +bit.
> +
>  If the VIRTIO_BLK_F_ZONED feature is not accepted by the driver,
>  \begin{itemize}
>  \item the device with the VIRTIO_BLK_Z_HA or VIRTIO_BLK_Z_NONE zone mode=
l SHOULD
> @@ -429,6 +506,35 @@ \subsection{Device Initialization}\label{sec:Device =
Types / Block Device / Devic
>  The device MUST NOT acknowledge FEATURES_OK if the driver sets
>  VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA without VIRTIO_BLK_F_REQ_FLAGS.
> =20
> +The device MUST NOT acknowledge FEATURES_OK if the driver negotiates both
> +VIRTIO_BLK_F_ZONED and VIRTIO_BLK_F_INLINE_ENCRYPTION.
> +
> +If the device is incapable of consuming the \field{virtio_blk_crypto_msg=
},
> +the device SHOULD NOT offer the VIRTIO_BLK_F_INLINE_ENCRYPTION feature.
> +
> +The device MUST NOT offer the VIRTIO_BLK_F_INLINE_ENCRYPTION feature wit=
hout
> +also offering VIRTIO_BLK_F_CTRL_VQ.

This sentence says a device that offers VIRTIO_BLK_F_INLINE_ENCRYPTION
must also offer VIRTIO_BLK_F_CTRL_VQ, but it does not require that
VIRTIO_BLK_F_CTRL_VQ is negotiated together with
VIRTIO_BLK_F_INLINE_ENCRYPTION. Perhaps explicitly say: "The device MUST
NOT accept VIRTIO_BLK_F_INLINE_ENCRYPTION without VIRTIO_BLK_F_CTRL_VQ"?

> +If the VIRTIO_BLK_F_INLINE_ENCRYPTION feature is negotiated, the device
> +MUST set \field{max_slots} in \field{enc_characteristics} to a value
> +greater than 0. The value SHOULD reflect the number of key slots that
> +the backend storage device makes available for use by this virtio-blk
> +device.
> +
> +If the VIRTIO_BLK_F_INLINE_ENCRYPTION feature is negotiated, the device
> +MUST set \field{key_types} in \field{enc_characteristics} to have at
> +least one of VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW or
> +VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED set, and MUST NOT set any bit in
> +\field{key_types} other than VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW and
> +VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED. The device MUST initialize padding
> +bytes \field{unused3} to 0.
> +
> +The device MUST NOT set \field{max_dun_bytes} in \field{enc_characterist=
ics}
> +to 0 or to a value greater than 32, since \field{dun[4]} of
> +\field{virtio_blk_crypto_msg} is a fixed four-element array of 64-bit fi=
elds.
> +The value reported by \field{max_dun_bytes} MAY vary depending on the
> +capabilities of the underlying inline crypto engine.
> +
>  \subsubsection{Legacy Interface: Device Initialization}\label{sec:Device=
 Types / Block Device / Device Initialization / Legacy Interface: Device In=
itialization}
> =20
>  Because legacy devices do not have FEATURES_OK, transitional devices
> @@ -468,11 +574,6 @@ \subsection{Device Operation}\label{sec:Device Types=
 / Block Device / Device Ope
>  };
>  \end{lstlisting}
> =20
> -Control virtqueue requests consist of a type field in an output buffer,
> -followed by an optional command-specific output buffer, an optional
> -command-specific input buffer, and a status byte in an input buffer. The
> -type field and status byte MUST each be in their own buffer.
> -
>  The type of the request is either a read (VIRTIO_BLK_T_IN), a write
>  (VIRTIO_BLK_T_OUT), a discard (VIRTIO_BLK_T_DISCARD), a write zeroes
>  (VIRTIO_BLK_T_WRITE_ZEROES), a flush (VIRTIO_BLK_T_FLUSH), a get device =
ID
> @@ -497,8 +598,8 @@ \subsection{Device Operation}\label{sec:Device Types =
/ Block Device / Device Ope
>  value is the bit index in the \field{flags} bitfield):
> =20
>  \begin{description}
> -\item[VIRTIO_BLK_REQ_FLAG_OUT_FUA (0) for VIRTIO_BLK_T_OUT requests] For=
ce Unit
> -    Access (FUA) flag.
> +\item[VIRTIO_BLK_REQ_FLAG_OUT_FUA (0) for VIRTIO_BLK_T_OUT and
> +    VIRTIO_BLK_T_CRYPTO_OUT requests] Force Unit Access (FUA) flag.
>  \end{description}
> =20
>  The \field{sector} number indicates the offset (multiplied by 512) where
> @@ -905,6 +1006,189 @@ \subsection{Device Operation}\label{sec:Device Typ=
es / Block Device / Device Ope
>  operation by setting the VIRTIO_BLK_S_ZONE_INVALID_CMD value in
>  \field{status} of \field{virtio_blk_req} structure.
> =20
> +The following requirements only apply if the VIRTIO_BLK_F_INLINE_ENCRYPT=
ION
> +and VIRTIO_BLK_F_CTRL_VQ features are negotiated.

Use a subsubsection to deliniate the "following requirements" and
prevent confusion if non-crypto features are added after this place in
the spec in the future?

> +
> +In addition to the request types defined for devices without inline
> +encryption support, the type of a request on a request virtqueue can be =
an
> +inline-encrypted read (VIRTIO_BLK_T_CRYPTO_IN) or an inline-encrypted wr=
ite
> +(VIRTIO_BLK_T_CRYPTO_OUT).
> +
> +The following request types are defined:
> +
> +\begin{lstlisting}
> +#define VIRTIO_BLK_T_CRYPTO_OUT             27
> +#define VIRTIO_BLK_T_CRYPTO_IN              28

Please definine control virtqueue requests separately (e.g.
VIRTIO_BLK_CTRL_T_...) to reduce the risk of confusion. It should be
impossible to send the wrong type of request on a virtqueue because the
distinct naming and structs would make it clear to the implementor that
it won't work.

> +#define VIRTIO_BLK_T_GET_CRYPTO_MODES       29
> +#define VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM 30
> +#define VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT   31
> +#define VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET 32
> +#define VIRTIO_BLK_T_CRYPTO_GENERATE_KEY    33
> +#define VIRTIO_BLK_T_CRYPTO_IMPORT_KEY      34
> +#define VIRTIO_BLK_T_CRYPTO_PREPARE_KEY     35
> +\end{lstlisting}
> +
> +VIRTIO_BLK_T_CRYPTO_IN and VIRTIO_BLK_T_CRYPTO_OUT requests are submitted
> +on a request virtqueue. All other request types listed above are submitt=
ed
> +on the control virtqueue.
> +
> +VIRTIO_BLK_T_CRYPTO_IN and VIRTIO_BLK_T_CRYPTO_OUT requests behave the s=
ame
> +as VIRTIO_BLK_T_IN and VIRTIO_BLK_T_OUT requests respectively, except th=
at
> +the data in \field{data} is decrypted (for VIRTIO_BLK_T_CRYPTO_IN) or is=
 to
> +be encrypted (for VIRTIO_BLK_T_CRYPTO_OUT) by the inline crypto engine in
> +the device backend storage using the key already provisioned in the key
> +slot identified by the request, combined with the request's Data Unit
> +Number (DUN). For this reason, the VIRTIO_BLK_T_CRYPTO_IN and
> +VIRTIO_BLK_T_CRYPTO_OUT requests have the layout that is extended to have
> +the \field{crypto_msg} field to carry this information:
> +
> +\begin{lstlisting}
> +struct virtio_blk_req_crypto {
> +        le32 type;
> +        le32 flags;
> +        le64 sector;
> +        struct virtio_blk_crypto_msg crypto_msg;
> +        u8 data[];
> +        u8 status;
> +};
> +\end{lstlisting}
> +
> +\field{crypto_msg} has the following structure:
> +
> +\begin{lstlisting}
> +struct virtio_blk_crypto_msg {
> +        le32 slot;
> +        u8 unused[4];
> +        le64 dun[4];
> +};
> +\end{lstlisting}
> +
> +\field{slot} is the key slot index, in the range from 0 to
> +\field{max_slots} - 1 of \field{enc_characteristics}. The device backend
> +uses the key programmed into this slot together with \field{dun[4]}.
> +\field{dun[4]} is a 256-bit unsigned Data Unit Number represented as four
> +little-endian 64-bit elements, with \field{dun[0]} as the least-signific=
ant
> +element. The device increments this 256-bit value by one for each succes=
sive
> +data unit of the size specified by \field{data_unit_size_bits} in the
> +\field{virtio_blk_crypto_key_desc}, propagating carries from each elemen=
t to
> +the next, while encrypting or decrypting the data of the request.
> +\field{unused} is reserved and MUST be initialized to zero by the driver=
 and
> +ignored by the device.

"MUST" is not allowed in a non-normative section of the spec. You can
say "\field{unused} is reserved and is initialized to zero by the driver
and ignored by the device" or you can move this to the \drivernormative
and \devicenormative sections where "MUST" can be used.

> +
> +Control virtqueue requests consist of a type field in an output buffer,
> +followed by an optional command-specific output buffer, an optional
> +command-specific input buffer, and a status byte in an input buffer. The
> +type field and status byte MUST each be in their own buffer.
> +
> +The command-specific buffers for each control command MUST be arranged as
> +follows, in addition to the type and status buffers:
> +
> +\begin{description}
> +\item[VIRTIO_BLK_T_GET_CRYPTO_MODES] One device-writable
> +    \field{virtio_blk_crypto_modes} response buffer.
> +
> +\item[VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM and
> +    VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT] One device-readable
> +    \field{virtio_blk_crypto_key_desc} command buffer.
> +
> +\item[VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET] One device-readable
> +    \field{virtio_blk_crypto_key_blob} command buffer followed by one
> +    device-writable \field{virtio_blk_crypto_sw_secret} response buffer.
> +
> +\item[VIRTIO_BLK_T_CRYPTO_GENERATE_KEY] One device-writable
> +    \field{virtio_blk_crypto_key_blob} response buffer.
> +
> +\item[VIRTIO_BLK_T_CRYPTO_IMPORT_KEY and
> +    VIRTIO_BLK_T_CRYPTO_PREPARE_KEY] One device-readable
> +    \field{virtio_blk_crypto_key_blob} command buffer followed by one
> +    device-writable \field{virtio_blk_crypto_key_blob} response buffer.
> +\end{description}

Please use C struct syntax to describe the layout. This is what the rest
of the VIRTIO specification does.

> +
> +VIRTIO_BLK_T_GET_CRYPTO_MODES returns the data unit sizes with which each
> +of the crypto modes specified by this specification can be used by the
> +device. Its response is:
> +
> +\begin{lstlisting}
> +struct virtio_blk_crypto_modes {
> +        le32 modes[2];
> +};
> +\end{lstlisting}
> +
> +\field{modes[N]}, for crypto mode number N, is a bitmask indicating the
> +data unit sizes with which crypto mode N can be used by the device: bit =
i of
> +\field{modes[N]} is set if crypto mode N can be used with a data unit si=
ze of
> +$(1 << i)$ bytes. \field{modes[0]} is reserved and is always set to 0 by=
 the
> +device. A zero value for \field{modes[N]} indicates that the device does=
 not
> +support that crypto mode.
> +
> +Crypto mode numbers are assigned by this specification, independently of
> +any operating system's internal representation of crypto algorithms, so
> +that support for additional crypto modes can be added in future revisions
> +of this specification without changing the meaning of previously assigned
> +numbers:
> +
> +\begin{lstlisting}
> +#define VIRTIO_BLK_CRYPTO_MODE_AES_256_XTS        1
> +\end{lstlisting}
> +
> +Crypto mode numbers already assigned by this or an earlier
> +version of this specification are never reused for a different crypto
> +mode; additional crypto modes are assigned new numbers, greater than the
> +highest number defined by the version of this specification the
> +implementation supports.
> +
> +Because crypto mode numbers, and the version of this specification each
> +crypto mode was assigned in, are fixed by this specification rather than
> +negotiated between the driver and the device, both sides need only refer
> +to this specification to agree on their meaning: the driver sizes its
> +response buffer to cover every crypto mode number defined by the
> +version of this specification it implements, and the device fills in
> +\field{modes[N]}, for each such N, directly according to whether and how
> +it supports the crypto mode assigned to N by this specification. Neither
> +side needs any additional mapping, renumbering, or out-of-band agreement
> +for this.
> +
> +The remaining control commands use the following structures:
> +
> +\begin{lstlisting}
> +struct virtio_blk_crypto_key_desc {
> +        le32 slot;
> +        u8 bytes[128];
> +        le32 key_size;
> +        le32 crypto_mode;
> +        le32 key_type;
> +        le32 data_unit_size_bits;
> +        le32 dun_bytes;
> +};
> +
> +struct virtio_blk_crypto_key_blob {
> +        le32 key_size;
> +        u8 key[128];
> +};
> +
> +struct virtio_blk_crypto_sw_secret {
> +        u8 secret[32];
> +};
> +\end{lstlisting}
> +
> +VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM and VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT
> +use \field{virtio_blk_crypto_key_desc} as their command-specific input to
> +the device.
> +VIRTIO_BLK_T_CRYPTO_GENERATE_KEY returns a
> +\field{virtio_blk_crypto_key_blob}. VIRTIO_BLK_T_CRYPTO_IMPORT_KEY and
> +VIRTIO_BLK_T_CRYPTO_PREPARE_KEY use a key blob as output and return a key

s/output/input/?

> +blob. VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET uses a key blob as output and
> +returns \field{virtio_blk_crypto_sw_secret}.

These control command descriptions lack enough information for
implementation. The spec needs to describe behavior in detail so that is
unambiguous. Please flesh these control virtqueue commands out to
explain:

1. The semantics of the command. The text does not explain what
   KEYSLOT_PROGRAM even does, plus conditions to be aware of like
   whether the driver can replace an existing key by programming that
   key slot or if the driver first needs to evict that key slot.

2. Error values that drivers should expect.

> +
> +VIRTIO_BLK_T_CRYPTO_IN requests are reads and VIRTIO_BLK_T_CRYPTO_OUT re=
quests
> +are writes. The control virtqueue commands use the direction of each buf=
fer
> +described above.
> +
> +For \field{virtio_blk_crypto_key_desc}, only the first \field{key_size} =
bytes
> +of \field{bytes} contain key material. The remaining bytes,
> +\field{bytes[key_size:128]}, are reserved, MUST be initialized to zero b=
y the
> +driver, and MUST be ignored by the device.

MUST needs to go in the normative sections of the spec.

> +
>  \drivernormative{\subsubsection}{Device Operation}{Device Types / Block =
Device / Device Operation}
> =20
>  The driver SHOULD check if the content of the \field{capacity} field has
> @@ -923,8 +1207,8 @@ \subsection{Device Operation}\label{sec:Device Types=
 / Block Device / Device Ope
>  A driver MUST set \field{sector} to 0 for a VIRTIO_BLK_T_FLUSH request.
>  A driver SHOULD NOT include any data in a VIRTIO_BLK_T_FLUSH request.
> =20
> -The length of \field{data} MUST be a multiple of 512 bytes for VIRTIO_BL=
K_T_IN
> -and VIRTIO_BLK_T_OUT requests.
> +The length of \field{data} MUST be a multiple of 512 bytes for VIRTIO_BL=
K_T_IN,
> +VIRTIO_BLK_T_OUT, VIRTIO_BLK_T_CRYPTO_IN and VIRTIO_BLK_T_CRYPTO_OUT req=
uests.
> =20
>  The length of \field{data} MUST be a multiple of the size of struct
>  virtio_blk_discard_write_zeroes for VIRTIO_BLK_T_DISCARD,
> @@ -1003,6 +1287,67 @@ \subsection{Device Operation}\label{sec:Device Typ=
es / Block Device / Device Ope
> =20
>  \end{enumerate}
> =20
> +The following requirements only apply if the VIRTIO_BLK_F_INLINE_ENCRYPT=
ION
> +and VIRTIO_BLK_F_CTRL_VQ features are negotiated.

Use a subsubsection to deliniate the "following requirements" and
prevent confusion if non-crypto features are added after this place in
the spec in the future?

> +
> +A driver MUST NOT submit a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO=
_OUT
> +request unless all of the following conditions are satisfied:
> +
> +\begin{itemize}
> +\item \field{slot} identifies a valid keyslot in the range
> +    [0, \field{max_slots} - 1].
> +
> +\item a key has been provisioned into the specified keyslot.
> +
> +\item \field{data} is non-empty.
> +
> +\item (\field{sector} * 512) is aligned to the data unit size associated
> +    with the programmed key.
> +
> +\item the length of \field{data} is a multiple of that data unit size
> +    associated with the programmed key.
> +
> +\item the Data Unit Number (DUN) of every data unit covered by the
> +    request is representable in the \field{dun_bytes} bytes specified wh=
en
> +    the key was programmed. \field{dun_bytes} MUST NOT be greater than
> +    \field{max_dun_bytes}.
> +\end{itemize}
> +
> +For a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO_OUT request,
> +\field{dun[4]} SHALL specify the 256-bit DUN of the first data unit cove=
red
> +by the request. The DUN corresponding to each subsequent data unit SHALL=
 be
> +obtained by incrementing the 256-bit value by one, propagating carries f=
rom
> +\field{dun[0]} through \field{dun[3]}.
> +
> +For a keyslot-program command, the driver MUST:
> +
> +\begin{itemize}
> +\item Set \field{key_size} to a value between 64 and 128, inclusive.
> +
> +\item Set \field{data_unit_size_bits} to the base-2 logarithm of the
> +data unit size in bytes.
> +
> +\item Set \field{dun_bytes} to the number of bytes used to represent
> +the DUN for the programmed key. \field{dun_bytes} MUST be between 1 and =
32,
> +inclusive, and MUST NOT be greater than \field{max_dun_bytes}.
> +
> +\item Set every byte in \field{bytes[key_size:128]} to zero.
> +\end{itemize}
> +
> +A driver MUST treat any crypto mode number for which its response
> +buffer does not contain a corresponding \field{modes} element as
> +unsupported by the device.
> +
> +A driver MUST provide a device-writable buffer with size
> +$(M + 1) \times 4$ bytes for the complete \field{modes} array as
> +the response buffer for a VIRTIO_BLK_T_GET_CRYPTO_MODES control request,
> +where $M$ is the highest crypto mode number defined by that version
> +of this specification (the $+1$ accounts for the reserved crypto mode
> +number 0).
> +
> +The driver MUST set all reserved fields in crypto-related structures
> +to zero.
> +
>  \devicenormative{\subsubsection}{Device Operation}{Device Types / Block =
Device / Device Operation}
> =20
>  The device MAY change the content of the \field{capacity} field during
> @@ -1049,10 +1394,10 @@ \subsection{Device Operation}\label{sec:Device Ty=
pes / Block Device / Device Ope
> =20
>  \item\label{item:flush3} the VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA feature was
>    negotiated and the VIRTIO_BLK_REQ_FLAG_OUT_FUA bit in \field{flags} wa=
s set in
> -  the write request (regardless of whether the VIRTIO_BLK_F_FLUSH or
> -  VIRTIO_BLK_F_CONFIG_WCE features were negotiated, and regardless of the
> -  current cache mode as expressed by the value of the \field{writeback} =
field in
> -  configuration space).
> +  the write request (VIRTIO_BLK_T_OUT or VIRTIO_BLK_T_CRYPTO_OUT, regard=
less of
> +  whether the VIRTIO_BLK_F_FLUSH or VIRTIO_BLK_F_CONFIG_WCE features were
> +  negotiated, and regardless of the current cache mode as expressed by t=
he value
> +  of the \field{writeback} field in configuration space).
> =20
>  \item\label{item:flush4} a VIRTIO_BLK_T_FLUSH request is sent \textbf{af=
ter the write is
>    completed} and is completed itself.
> @@ -1068,11 +1413,6 @@ \subsection{Device Operation}\label{sec:Device Typ=
es / Block Device / Device Ope
>  and its completion, the write could be either volatile or stable when
>  its completion is reported; in other words, the exact behavior is undefi=
ned.
> =20
> -% According to the device requirements for device initialization:
> -%   Offer(CONFIG_WCE) =3D> Offer(FLUSH).
> -%
> -% After reversing the implication:
> -%   not Offer(FLUSH) =3D> not Offer(CONFIG_WCE).

Please drop unrelated changes. If you'd like to send cleanups (fixing
whitespace or removing comments), doing that in separate patches is
preferred so the commit message can describe it and it can be
merged/backported intentionally rather than mixed in with the crypto
feature.

> =20
>  If VIRTIO_BLK_F_FLUSH was not offered by the
>    device\footnote{Note that in this case, according to
> @@ -1244,6 +1584,72 @@ \subsection{Device Operation}\label{sec:Device Typ=
es / Block Device / Device Ope
>  handles VIRTIO_BLK_T_ZONE_RESET request for the zone range specified in =
the
>  VIRTIO_BLK_T_SECURE_ERASE request.
> =20
> +If the VIRTIO_BLK_F_INLINE_ENCRYPTION feature is not negotiated, the dev=
ice
> +MUST reject all inline-encryption request and control command types with
> +VIRTIO_BLK_S_UNSUPP status.
> +
> +The following requirements only apply if the VIRTIO_BLK_F_INLINE_ENCRYPT=
ION
> +and VIRTIO_BLK_F_CTRL_VQ features are negotiated.
> +
> +If an encrypted request specifies an invalid slot, zero-length data, a
> +misaligned sector or data length, or a DUN range that is not representab=
le in
> +the \field{dun_bytes} bytes specified when the key was programmed, the d=
evice
> +MUST set \field{status} to
> +VIRTIO_BLK_S_UNSUPP and MUST NOT access the data.
> +
> +For VIRTIO_BLK_T_GET_CRYPTO_MODES, the device MUST fill each
> +\field{modes[N]} element that fits entirely within the response buffer.
> +
> +For a mode index N, \field{modes[N]} SHALL indicate whether the
> +corresponding crypto mode defined by this specification is supported by
> +both the virtio-blk device and the backend storage device.
> +
> +The device MUST set \field{modes[N]} to zero if:
> +
> +\begin{itemize}
> +\item no crypto mode is assigned to N by this specification.
> +
> +\item the corresponding crypto mode is not supported.
> +\end{itemize}
> +
> +The device MUST NOT write beyond the response buffer and MUST NOT write
> +a partial \field{modes} element.
> +
> +For encrypted reads and writes, the device MUST use the key provisioned =
in
> +the requested slot and the request's \field{dun[4]}. If the device split=
s the
> +request, each sub-request MUST preserve data-unit alignment and use the
> +256-bit DUN obtained by incrementing the request DUN by the number of
> +preceding data units.
> +
> +For a keyslot program command, the device MUST validate
> +\field{slot}, \field{key_size}, \field{crypto_mode}, \field{key_type},
> +\field{data_unit_size_bits}, and \field{dun_bytes} against the device
> +capabilities. In particular, \field{key_size} MUST be between 64 and 128,
> +inclusive; \field{crypto_mode} MUST identify a supported crypto mode,
> +\field{key_type} MUST identify a supported key type,
> +\field{data_unit_size_bits} MUST identify a data unit size supported for=
 the
> +specified crypto mode, and \field{dun_bytes} MUST be between 1 and
> +\field{max_dun_bytes}, inclusive. The device MUST reject invalid values =
with
> +VIRTIO_BLK_S_UNSUPP.
> +
> +For a successful keyslot program command, the device MUST store the supp=
lied
> +key and associated parameters in the specified slot, replacing any value
> +previously stored in that slot. If the command fails, the device MUST le=
ave
> +the contents and state of the specified slot unchanged.
> +
> +For a keyslot evict command, the device MUST validate \field{slot}. If t=
he
> +slot is valid, the device MUST remove any key and associated parameters =
=66rom
> +the slot and complete the command successfully. Evicting an already empty
> +slot MUST also complete successfully. If the slot is invalid, the device
> +MUST reject the command with VIRTIO_BLK_S_UNSUPP and MUST leave all slots
> +unchanged.
> +
> +For a keyslot evict command, fields other than \field{slot} in the
> +\field{virtio_blk_crypto_key_desc} are ignored by the device.
> +
> +The device MUST reject a control command with an invalid command-specific
> +buffer or an unknown command type with VIRTIO_BLK_S_UNSUPP.
> +
>  \subsubsection{Legacy Interface: Device Operation}\label{sec:Device Type=
s / Block Device / Device Operation / Legacy Interface: Device Operation}
>  When using the legacy interface, transitional devices and drivers
>  MUST format the fields in struct virtio_blk_req
> --=20
> 2.34.1
>=20

--g2RUInp6Y5aculox
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqsVf4ACgkQnKSrs4Gr
c8hddQf/dbe15b6KknF1Gb5Qn/Y7HGCRSaMdV/lv0GWOmuKkTxb7wZOmzi9qQ7/6
MtwNZsOb74rJM6afMxfqT1SfVaxM+Qn3I51e/YooKgJNs0rPzYVyV92wv41wPo3O
OWgdaGIoyQjF6Idgt6VYJ8qi/zXPlouMFNC9NS/r0e7ioXkol9TYN8ycLhHfADiq
XBG49uV1igEueli7qDlHa8MZ6+sr628oQtRzcwXWz3LlmPyZV/2qpH9mw3AewBke
3KvCZnIOOxtncibaR4xdpJwq6vjnTisJbjzZ1iOHJVsPhCvLX1SS4D2V7xfFfVRB
shrGjJwknuOH30woBFGzydI7XZ6W4w==
=laCT
-----END PGP SIGNATURE-----

--g2RUInp6Y5aculox--

