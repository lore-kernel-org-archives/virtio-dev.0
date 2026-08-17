Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2D1175A74
	for <virtio-dev@lists.linux.dev>; Mon, 17 Aug 2026 17:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786987018; cv=none; b=IK+hHYwDY1aqkLGzPM5OZz8x2STc3bf2YqC2NO3F/JsgAAXq8WfiDhmy+u9I8cz5YulLeksbRtvb+xctFaf0X4HpbAh3DoFVvqFFl5Oppn6Weid0OB9ttqP++YgvxvP2VvzJj+PVUBH3LTK8v2yRg652ReX1u8PZtqCEiGrM6d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786987018; c=relaxed/simple;
	bh=q/XXpk03cG9Ip7NiEw9sy74FY9kNp9iPBWLhyoVNwWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N57dVobk3iFl2yTVSWwl1ICt/zkGyUjyWxFpJ/FWewx700xUNCdL4XmYINzYOGCbR+wJWweXxrg3/FB1DYx3ddUmZRd3uavXkny7s/cj1sWGzEe6b4aDUsZOJ/9uJg42l0rAW7j/VjivAZJtYjPjdlJMlwGlcehXziXmQ8pgLmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NLzAcMZH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NLzAcMZH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786987015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0fvVW2l4i77LzuaDnoAVsreCQwQmWGNEBm5bv811roQ=;
	b=NLzAcMZHUnEJx415likOBeMhvN9EvB0EO9iQLiSzhKllJkqNoxk0qflU3PDucs4n9bUQD3
	Z0vzX9nUh6ydkVkanuQw14TG7wKdBGSjEFsbz3uhkEbXIVIgSO1EkeiJRAUp6aJEkccFp2
	UWM5AUfuDRyarOlox3Y/8KemxZrMM8c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-6ALSCGBwPRa_OWaRjxynPA-1; Mon,
 17 Aug 2026 13:16:53 -0400
X-MC-Unique: 6ALSCGBwPRa_OWaRjxynPA-1
X-Mimecast-MFC-AGG-ID: 6ALSCGBwPRa_OWaRjxynPA_1786987012
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4E0B51956096;
	Mon, 17 Aug 2026 17:16:52 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D5A503000239;
	Mon, 17 Aug 2026 17:16:51 +0000 (UTC)
Date: Mon, 17 Aug 2026 13:16:50 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
Cc: virtio-dev@lists.linux.dev, ebiggers@kernel.org,
	neeraj.soni@oss.qualcomm.com
Subject: Re: [PATCH v1] virtio-blk: Add inline encryption support
Message-ID: <20260817171650.GC143460@fedora>
References: <20260814142306.3934029-1-linlin.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Xo8IhOv5j2N7+7e4"
Content-Disposition: inline
In-Reply-To: <20260814142306.3934029-1-linlin.zhang@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

--Xo8IhOv5j2N7+7e4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 07:23:01AM -0700, Linlin Zhang wrote:
> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>=20
> Add VIRTIO_BLK_F_IE to advertise inline encryption support.
>=20
> When the feature is negotiated, the device reports inline encryption
> characteristics through virtio_blk_enc_characteristics. Add
> VIRTIO_BLK_T_GET_CRYPTO_MODES, VIRTIO_BLK_T_CRYPTO_IN, and
> VIRTIO_BLK_T_CRYPTO_OUT so that the driver can discover supported
> crypto modes and submit inline-encrypted I/O requests.
>=20
> Crypto I/O requests carry a virtual key slot index, data unit size,
> and initial Data Unit Number (DUN). The device maps the virtual key
> slot to a physical key slot in the storage backend and uses these
> parameters for inline encryption or decryption.
>=20
> Key provisioning is performed through an out-of-band mechanism and is
> outside the scope of this device type.
>=20
> For background on inline encryption in UFS and eMMC storage, see:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/block/inline-encryption.rst
>=20
> Change-Id: I83c52456bc0c9dd37f39ff46e6bfe73a715138ca
> Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/238
> ---
>  device-types/blk/description.tex | 297 ++++++++++++++++++++++++++++++-
>  1 file changed, 291 insertions(+), 6 deletions(-)

Hi,
I will review this on Wednesday, August 19th.

In the meantime, is there a changelog from your previous patch series?

Stefan

>=20
> diff --git a/device-types/blk/description.tex b/device-types/blk/descript=
ion.tex
> index 3b3a4e7..f8a544b 100644
> --- a/device-types/blk/description.tex
> +++ b/device-types/blk/description.tex
> @@ -71,7 +71,16 @@ \subsection{Feature bits}\label{sec:Device Types / Blo=
ck Device / Feature bits}
> =20
>  \item[VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA (19)] Device supports the
>      VIRTIO_BLK_REQ_FLAG_OUT_FUA flag in the \field{flags} bitfield of the
> -    \field{virtio_blk_req} structure for VIRTIO_BLK_T_OUT requests.
> +    request for VIRTIO_BLK_T_OUT and VIRTIO_BLK_T_CRYPTO_OUT requests.
> +
> +\item[VIRTIO_BLK_F_IE (22)] Only when the storage backend supports inline
> +    encryption and this feature bit is negotiated, the data read from or
> +    written to the device can be decrypted from or encrypted to the stor=
age
> +    via inline crypto engine. Keys are provisioned into key slots of the
> +    inline crypto engine through a mechanism outside the scope of this d=
evice
> +    type, and requests identify, by key slot index, which provisioned ke=
y to
> +    use. The number of key slots, the maximum DUN size and the supported=
 key
> +    types are reported in \field{enc_characteristics}.
> =20
>  \end{description}
> =20
> @@ -135,6 +144,12 @@ \subsection{Device configuration layout}\label{sec:D=
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
> @@ -222,6 +237,39 @@ \subsection{Device configuration layout}\label{sec:D=
evice Types / Block Device /
>  terminated by the device with a "zone resources exceeded" error as defin=
ed for
>  specific commands later.
> =20
> +If the VIRTIO_BLK_F_IE feature is negotiated, then in
> +\field{virtio_blk_enc_characteristics},
> +\begin{itemize}
> +\item \field{max_slots} is the number of key slots allocated to the Gues=
t VM.
> +    It MUST not exceed the number of key slots supported by the inline c=
rypto
> +    engine of the device backend storage. Key slots are indexed from 0 to
> +    \field{max_slots} - 1.
> +
> +\item \field{max_dun_bytes} is the maximum number of bytes of the Data U=
nit
> +    Number (DUN) that the device supports for any of its supported crypto
> +    modes. For example, known inline crypto engines report a
> +    \field{max_dun_bytes} of 4 (JEDEC eMMC Command Queue Host Controller
> +    Interface, CQHCI) or 8 (JEDEC UFS Host Controller Interface, UFSHCI);
> +    a device backed by different inline crypto engine hardware MAY report
> +    a different value, subject to the constraints in
> +    \ref{devicenormative:Device Types / Block Device / Device Initializa=
tion}.
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
> +
> +\item \field{unused3} is reserved for future use.
> +\end{itemize}
> +
>  \subsubsection{Legacy Interface: Device configuration layout}\label{sec:=
Device Types / Block Device / Device configuration layout / Legacy Interfac=
e: Device configuration layout}
>  When using the legacy interface, transitional devices and drivers
>  MUST format the fields in struct virtio_blk_config
> @@ -285,6 +333,14 @@ \subsection{Device Initialization}\label{sec:Device =
Types / Block Device / Devic
>      \field{zoned} can be read by the driver to determine the zone
>      characteristics of the device. All \field{zoned} fields are read-onl=
y.
> =20
> +\item If the VIRTIO_BLK_F_IE feature is negotiated, the fields in
> +    \field{enc_characteristics} can be read by the driver to determine t=
he
> +    inline encryption capabilities of the device, and a
> +    VIRTIO_BLK_T_GET_CRYPTO_MODES request (see
> +    \ref{sec:Device Types / Block Device / Device Operation}) can be sent
> +    to retrieve the set of supported crypto modes. All
> +    \field{enc_characteristics} fields are read-only.
> +
>  \end{enumerate}
> =20
>  \drivernormative{\subsubsection}{Device Initialization}{Device Types / B=
lock Device / Device Initialization}
> @@ -312,6 +368,10 @@ \subsection{Device Initialization}\label{sec:Device =
Types / Block Device / Devic
>  offered by the device with the VIRTIO_BLK_Z_HA or VIRTIO_BLK_Z_NONE zone=
 model,
>  then the driver MAY negotiate these two bits independently.
> =20
> +Zoned devices do not support inline encryption. If the VIRTIO_BLK_F_ZONED
> +feature is offered by the device, then the VIRTIO_BLK_F_IE feature MUST =
NOT
> +be negotiated by the driver.
> +
>  If the VIRTIO_BLK_F_ZONED feature is negotiated, then
>  \begin{itemize}
>  \item if the driver that can not support host-managed zoned devices
> @@ -327,6 +387,12 @@ \subsection{Device Initialization}\label{sec:Device =
Types / Block Device / Devic
>  The driver MUST NOT negotiate VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA without
>  VIRTIO_BLK_F_REQ_FLAGS.
> =20
> +Drivers MUST NOT negotiate the VIRTIO_BLK_F_IE feature if they are
> +incapable of provisioning keys into the key slots of the device backend
> +storage's inline crypto engine, or of conveying the key slot index,
> +data unit size in bits, and Data Unit Number (DUN) per request to
> +the device using the \field{virtio_blk_crypto_msg} structure.
> +
>  \devicenormative{\subsubsection}{Device Initialization}{Device Types / B=
lock Device / Device Initialization}
> =20
>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
> @@ -341,9 +407,15 @@ \subsection{Device Initialization}\label{sec:Device =
Types / Block Device / Devic
>  If the device that is being initialized is a not a zoned device, the dev=
ice
>  SHOULD NOT offer the VIRTIO_BLK_F_ZONED feature.
> =20
> +A zoned device MUST NOT offer the VIRTIO_BLK_F_IE feature.
> +
>  The VIRTIO_BLK_F_ZONED feature cannot be properly negotiated without
>  FEATURES_OK bit. Legacy devices MUST NOT offer VIRTIO_BLK_F_ZONED featur=
e bit.
> =20
> +The VIRTIO_BLK_F_IE feature cannot be properly negotiated without
> +FEATURES_OK bit. Legacy devices MUST NOT offer the VIRTIO_BLK_F_IE featu=
re
> +bit.
> +
>  If the VIRTIO_BLK_F_ZONED feature is not accepted by the driver,
>  \begin{itemize}
>  \item the device with the VIRTIO_BLK_Z_HA or VIRTIO_BLK_Z_NONE zone mode=
l SHOULD
> @@ -415,6 +487,26 @@ \subsection{Device Initialization}\label{sec:Device =
Types / Block Device / Devic
>  The device MUST NOT acknowledge FEATURES_OK if the driver sets
>  VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA without VIRTIO_BLK_F_REQ_FLAGS.
> =20
> +The device MUST NOT acknowledge FEATURES_OK if the driver negotiates both
> +VIRTIO_BLK_F_ZONED and VIRTIO_BLK_F_IE.
> +
> +If the device is incapable of consuming the \field{virtio_blk_crypto_msg=
},
> +the device SHOULD NOT offer the VIRTIO_BLK_F_IE feature.
> +
> +If the VIRTIO_BLK_F_IE feature is negotiated, the device MUST set
> +\field{max_slots} in \field{enc_characteristics} to a value greater than=
 0.
> +
> +If the VIRTIO_BLK_F_IE feature is negotiated, the device MUST set
> +\field{key_types} in \field{enc_characteristics} to have at least one of
> +VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW or VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED
> +set, and MUST NOT set any bit in \field{key_types} other than
> +VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW and VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED.
> +The device MUST initialize padding bytes \field{unused3} to 0.
> +
> +The device MUST NOT set \field{max_dun_bytes} in \field{enc_characterist=
ics}
> +to 0 or to a value greater than 8, since \field{dun} of
> +\field{virtio_blk_crypto_msg} is a fixed 8-byte field.
> +
>  \subsubsection{Legacy Interface: Device Initialization}\label{sec:Device=
 Types / Block Device / Device Initialization / Legacy Interface: Device In=
itialization}
> =20
>  Because legacy devices do not have FEATURES_OK, transitional devices
> @@ -478,8 +570,8 @@ \subsection{Device Operation}\label{sec:Device Types =
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
> @@ -886,6 +978,108 @@ \subsection{Device Operation}\label{sec:Device Type=
s / Block Device / Device Ope
>  operation by setting the VIRTIO_BLK_S_ZONE_INVALID_CMD value in
>  \field{status} of \field{virtio_blk_req} structure.
> =20
> +The following requirements only apply if the VIRTIO_BLK_F_IE feature is
> +negotiated.
> +
> +In addition to the request types defined for devices without inline
> +encryption support, the type of the request can be an inline-encrypted r=
ead
> +(VIRTIO_BLK_T_CRYPTO_IN), an inline-encrypted write (VIRTIO_BLK_T_CRYPTO=
_OUT)
> +or a get crypto modes command (VIRTIO_BLK_T_GET_CRYPTO_MODES).
> +
> +\begin{lstlisting}
> +#define VIRTIO_BLK_T_CRYPTO_OUT        27
> +#define VIRTIO_BLK_T_CRYPTO_IN         28
> +#define VIRTIO_BLK_T_GET_CRYPTO_MODES  30
> +\end{lstlisting}
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
> +        le32 data_unit_size_bits;
> +        le64 dun;
> +};
> +\end{lstlisting}
> +
> +\field{slot} is the virtual key slot index, in the range from 0 to
> +\field{max_slots} - 1 of \field{enc_characteristics}. The device maps th=
is
> +virtual key slot index to a physical key slot in the inline crypto engin=
e of
> +the device backend storage.
> +\field{data_unit_size_bits} is $log_2$ of the data unit size in bytes,
> +used for calculating DUNs for sub-requests if the request is split.
> +\field{dun} is the Data Unit Number, that is, the initial value that the
> +inline crypto engine increments by one for each successive data unit of
> +the size specified by \field{data_unit_size_bits}, while encrypting or
> +decrypting the data of the request.
> +
> +VIRTIO_BLK_T_GET_CRYPTO_MODES is a read request that returns the data un=
it
> +sizes with which each of the device's crypto modes can be used. The
> +response consists of a header followed by zero or more \field{le32}
> +bitmask elements, indexed by crypto mode number:
> +
> +\begin{lstlisting}
> +struct virtio_blk_crypto_modes {
> +        le32   nr_modes;
> +        u8     reserved[4];
> +        le32   modes[];
> +};
> +\end{lstlisting}
> +
> +The device sets \field{nr_modes} in the response header to the number of
> +fully transferred \field{modes} elements in the data buffer. \field{mode=
s[N]},
> +for crypto mode number N, is a bitmask indicating the data unit sizes wi=
th
> +which crypto mode N can be used by the device: the i'th bit of
> +\field{modes[N]} is set if crypto mode N can be used with a data unit si=
ze
> +of $(1 << i)$ bytes. A value of 0 for a \field{modes} element indicates
> +that the device does not support the corresponding crypto mode at all.
> +Crypto mode number 0 is reserved; \field{modes[0]} is always set to 0 by
> +the device.
> +
> +Crypto mode numbers are assigned by this specification, independently of
> +any operating system's internal representation of crypto algorithms, so
> +that support for additional crypto modes can be added in future revisions
> +of this specification without changing the meaning of previously assigned
> +numbers:
> +
> +\begin{lstlisting}
> +#define VIRTIO_BLK_CRYPTO_MODE_AES_256_XTS        1
> +#define VIRTIO_BLK_CRYPTO_MODE_AES_128_CBC_ESSIV  2
> +#define VIRTIO_BLK_CRYPTO_MODE_ADIANTUM           3
> +#define VIRTIO_BLK_CRYPTO_MODE_SM4_XTS            4
> +\end{lstlisting}
> +
> +A driver or device implementation MAY support only a subset of these
> +crypto modes. Crypto mode numbers already assigned by this or an earlier
> +version of this specification are never reused for a different crypto
> +mode; additional crypto modes are assigned new numbers, greater than the
> +highest number defined by the version of this specification the
> +implementation supports.
> +
> +VIRTIO_BLK_T_CRYPTO_IN and VIRTIO_BLK_T_GET_CRYPTO_MODES requests are re=
ads,
> +and VIRTIO_BLK_T_CRYPTO_OUT requests are writes.
> +
>  \drivernormative{\subsubsection}{Device Operation}{Device Types / Block =
Device / Device Operation}
> =20
>  The driver SHOULD check if the content of the \field{capacity} field has
> @@ -904,8 +1098,8 @@ \subsection{Device Operation}\label{sec:Device Types=
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
> @@ -984,6 +1178,42 @@ \subsection{Device Operation}\label{sec:Device Type=
s / Block Device / Device Ope
> =20
>  \end{enumerate}
> =20
> +The following requirements only apply if the VIRTIO_BLK_F_IE feature is
> +negotiated.
> +
> +A driver MUST NOT submit a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO=
_OUT
> +request with a \field{slot} value that is not less than \field{max_slots=
} of
> +\field{enc_characteristics}, or that identifies a key slot into which no=
 key
> +has been provisioned.
> +
> +A driver MUST set \field{data_unit_size_bits} of a VIRTIO_BLK_T_CRYPTO_I=
N or
> +VIRTIO_BLK_T_CRYPTO_OUT request's \field{crypto_msg} to $log_2$ of the d=
ata
> +unit size in bytes associated with the key provisioned in the virtual key
> +slot identified by \field{slot}. Since data unit sizes are reported by
> +VIRTIO_BLK_T_GET_CRYPTO_MODES as a bitmask of \field{le32} elements, a
> +driver MUST NOT set \field{data_unit_size_bits} to a value greater than =
31.
> +
> +A driver MUST NOT submit a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO=
_OUT
> +request with a zero length \field{data}.
> +
> +A driver MUST NOT submit a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO=
_OUT
> +request unless \field{sector}, multiplied by 512, and the length of
> +\field{data}, are both a multiple of $(1 << \field{data_unit_size_bits})$
> +bytes.
> +
> +A driver MUST NOT submit a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO=
_OUT
> +request if \field{dun} + $N$ - 1 is not representable in
> +\field{max_dun_bytes} bytes, where $N$ is the number of data units of
> +$2^{\field{data_unit_size_bits}}$ bytes in \field{data}.
> +
> +A driver MUST treat any crypto mode number that is not less than
> +\field{nr_modes} of a VIRTIO_BLK_T_GET_CRYPTO_MODES response as unsuppor=
ted
> +by the device.
> +
> +A driver MUST provide a \field{data} buffer of at least
> +sizeof(struct virtio_blk_crypto_modes) (8) bytes for a
> +VIRTIO_BLK_T_GET_CRYPTO_MODES request.
> +
>  \devicenormative{\subsubsection}{Device Operation}{Device Types / Block =
Device / Device Operation}
> =20
>  The device MAY change the content of the \field{capacity} field during
> @@ -1030,7 +1260,8 @@ \subsection{Device Operation}\label{sec:Device Type=
s / Block Device / Device Ope
> =20
>  \item\label{item:flush3} the VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA feature was
>    negotiated and the VIRTIO_BLK_REQ_FLAG_OUT_FUA bit in \field{flags} wa=
s set in
> -  the write request (regardless of whether the VIRTIO_BLK_F_FLUSH or
> +  the write request (VIRTIO_BLK_T_OUT or VIRTIO_BLK_T_CRYPTO_OUT, regard=
less of
> +  whether the VIRTIO_BLK_F_FLUSH or
>    VIRTIO_BLK_F_CONFIG_WCE features were negotiated, and regardless of the
>    current cache mode as expressed by the value of the \field{writeback} =
field in
>    configuration space).
> @@ -1225,6 +1456,60 @@ \subsection{Device Operation}\label{sec:Device Typ=
es / Block Device / Device Ope
>  handles VIRTIO_BLK_T_ZONE_RESET request for the zone range specified in =
the
>  VIRTIO_BLK_T_SECURE_ERASE request.
> =20
> +The following requirements only apply if the VIRTIO_BLK_F_IE feature is
> +negotiated.
> +
> +If a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO_OUT request:
> +\begin{itemize}
> +\item specifies a \field{slot} value that is not less than \field{max_sl=
ots},
> +    or that identifies a key slot into which no key has been provisioned,
> +
> +\item specifies a \field{data_unit_size_bits} value greater than 31, or
> +    that does not match $log_2$ of the data unit size in bytes associated
> +    with the key provisioned in the virtual key slot identified by the
> +    \field{slot},
> +
> +\item specifies a zero length \field{data},
> +
> +\item specifies a \field{sector}, multiplied by 512, or a length of
> +    \field{data}, that is not a multiple of $(1 << \field{data_unit_size=
_bits})$
> +    bytes, or
> +
> +\item specifies a \field{dun} such that \field{dun} + $N$ - 1 is not
> +    representable in \field{max_dun_bytes} bytes, where $N$ is the number
> +    of data units of $2^{\field{data_unit_size_bits}}$ bytes in
> +    \field{data},
> +\end{itemize}
> +then the device MUST set the \field{status} byte to VIRTIO_BLK_S_UNSUPP =
and
> +MUST NOT read or write any data.
> +
> +If a VIRTIO_BLK_T_GET_CRYPTO_MODES request's \field{data} buffer is smal=
ler
> +than sizeof(struct virtio_blk_crypto_modes) (8) bytes, the device MUST s=
et
> +the \field{status} byte to VIRTIO_BLK_S_UNSUPP and MUST NOT write any da=
ta.
> +
> +If the driver's \field{data} buffer in a VIRTIO_BLK_T_GET_CRYPTO_MODES
> +request is not large enough to hold \field{modes} elements up to the
> +highest crypto mode number the device supports, the device MUST set
> +\field{nr_modes} to the number of complete \field{modes} elements that f=
it
> +in the buffer, and MUST NOT write a partial element.
> +
> +The device MUST initialize padding bytes \field{reserved} of a
> +VIRTIO_BLK_T_GET_CRYPTO_MODES response to 0.
> +
> +For a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO_OUT request, the dev=
ice
> +MUST use the key provisioned in the virtual key slot identified by
> +\field{slot} of the request's \field{crypto_msg}, combined with \field{d=
un},
> +to decrypt the data read from, or encrypt the data written to, the device
> +backend storage. If the device backend storage splits the request into
> +sub-requests, each sub-request MUST begin at a byte offset, from the sta=
rt
> +of \field{data}, that is a multiple of $(1 << \field{data_unit_size_bits=
})$
> +bytes, MUST have a length that is a multiple of
> +$(1 << \field{data_unit_size_bits})$ bytes, and MUST use, in place of
> +\field{dun}, the Data Unit Number
> +$\field{dun} + (\mathit{byte\_offset} / (1 << \field{data_unit_size_bits=
}))$,
> +where $\mathit{byte\_offset}$ is that sub-request's starting byte offset
> +from the start of \field{data}.
> +
>  \subsubsection{Legacy Interface: Device Operation}\label{sec:Device Type=
s / Block Device / Device Operation / Legacy Interface: Device Operation}
>  When using the legacy interface, transitional devices and drivers
>  MUST format the fields in struct virtio_blk_req
> --=20
> 2.34.1
>=20

--Xo8IhOv5j2N7+7e4
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqDQgIACgkQnKSrs4Gr
c8g0ZQf+Ki81ozE2JXHi1p6nLT7l9Bz+CNq+lSrKGgvCPx9VnBFIx88qEcfnJ2IJ
4xkQOx7+Ss9Vw7wWC5rSBweBfowbPwFzeKFfa4wOsfCNEXxpF1L7twECIcLI5x7e
SnUCLHjjPCfCJPzfadT+w2hQK8ZgXPCrXnxSMYIcVqAuUl2mhKMGCJg0k6Nr2/Ip
rYM17DRN6KGsTqlUp1MNzm8/sUBgiPs4W8Vc7AS2oUBVcGFMfel2fYN32AR1rxTT
b1sUhB4kF3zll659MOgHrLedft2qNj9Xy2xqECcbuLFraaLEQuGF306jMkFlKrMk
dUQWou+JI0cxSHkAi9YUScqN7SBM/w==
=meXC
-----END PGP SIGNATURE-----

--Xo8IhOv5j2N7+7e4--

