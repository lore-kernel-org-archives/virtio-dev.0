Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82CA3D73
	for <virtio-dev@lists.linux.dev>; Fri, 21 Aug 2026 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787326243; cv=none; b=rOJn01cb2WGfJ1538VZvbk/YsGBNbzyLBiOPiZ5r39+XymuWQR5SYtGsPDtKVtt+VTNen5eW2zLCfmT8l2JC/HdnAeFdqqQu3923VufS8CCe+8ilI/Ldu3Y80uWQpl2DiAKfhcQjrQ06+Ae7+oBOQMsmlcg9UqSr5D+PrGi9jlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787326243; c=relaxed/simple;
	bh=4SyVgaXeMFEqg4q0LHxCPKMkQ5ArSsxEsmpMVfLG+XU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9zcG2FFg3XhyYDrmXm+TLQH50S1aa0YSsP6hLXEqu0iZ8tjmPR6j1i+g9kv1zayOl2Op2UlmmjV9zNnwr4pFdBZ/kimGDL3xuN8tl92a8+dwJu+K+ema/dmZOPI4VABzejaVgfVDLjocFf1ZjaeAywlx38QMqoJJbk26tMgNuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DHGu8yuR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DHGu8yuR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787326239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w8eISIv6npN2MkD+USvPUZtd9mNsG2/ef7gg2uCwX3A=;
	b=DHGu8yuRpnRO6B5JzJIvdWtITv8Or+XWZ147c0z8IkN3G4T9t7fU9aJFqo3BTwmFVH73Yp
	tCbZhWzXBkDLnfcdUQ5cmBQjYBnClGO2KccJLz/4y1jggzKUwdSkmsU+Mqmbrv6xn4vNjx
	9EHRG1Ujl4fmZF5Z5SFtnbv7ocDzNQ0=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-3uSYZsDxOjeilOAnmbM_IQ-1; Fri,
 21 Aug 2026 11:30:29 -0400
X-MC-Unique: 3uSYZsDxOjeilOAnmbM_IQ-1
X-Mimecast-MFC-AGG-ID: 3uSYZsDxOjeilOAnmbM_IQ_1787326228
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB4F31954B31;
	Fri, 21 Aug 2026 15:30:27 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6EAB318005BD;
	Fri, 21 Aug 2026 15:30:27 +0000 (UTC)
Date: Fri, 21 Aug 2026 11:30:24 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
Cc: virtio-dev@lists.linux.dev, ebiggers@kernel.org,
	neeraj.soni@oss.qualcomm.com
Subject: Re: [PATCH v1] virtio-blk: Add inline encryption support
Message-ID: <20260821153023.GA564943@fedora>
References: <20260814142306.3934029-1-linlin.zhang@oss.qualcomm.com>
 <20260819211845.GB470114@fedora>
 <c66459c5-0207-4cc5-bea7-71fe0e600aa1@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wO20YYxaEdqPJ3im"
Content-Disposition: inline
In-Reply-To: <c66459c5-0207-4cc5-bea7-71fe0e600aa1@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

--wO20YYxaEdqPJ3im
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 12:18:55AM +0800, Linlin Zhang wrote:
>=20
>=20
> On 8/20/2026 5:18 AM, Stefan Hajnoczi wrote:
> > On Fri, Aug 14, 2026 at 07:23:01AM -0700, Linlin Zhang wrote:
> >> From: linlzhan <linlin.zhang@oss.qualcomm.com>
> >>
> >> Add VIRTIO_BLK_F_IE to advertise inline encryption support.
> >>
> >> When the feature is negotiated, the device reports inline encryption
> >> characteristics through virtio_blk_enc_characteristics. Add
> >> VIRTIO_BLK_T_GET_CRYPTO_MODES, VIRTIO_BLK_T_CRYPTO_IN, and
> >> VIRTIO_BLK_T_CRYPTO_OUT so that the driver can discover supported
> >> crypto modes and submit inline-encrypted I/O requests.
> >>
> >> Crypto I/O requests carry a virtual key slot index, data unit size,
> >> and initial Data Unit Number (DUN). The device maps the virtual key
> >> slot to a physical key slot in the storage backend and uses these
> >> parameters for inline encryption or decryption.
> >>
> >> Key provisioning is performed through an out-of-band mechanism and is
> >> outside the scope of this device type.
> >>
> >> For background on inline encryption in UFS and eMMC storage, see:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/block/inline-encryption.rst
> >>
> >> Change-Id: I83c52456bc0c9dd37f39ff46e6bfe73a715138ca
> >> Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
> >> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/238
> >> ---
> >>  device-types/blk/description.tex | 297 ++++++++++++++++++++++++++++++-
> >>  1 file changed, 291 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/device-types/blk/description.tex b/device-types/blk/descr=
iption.tex
> >> index 3b3a4e7..f8a544b 100644
> >> --- a/device-types/blk/description.tex
> >> +++ b/device-types/blk/description.tex
> >> @@ -71,7 +71,16 @@ \subsection{Feature bits}\label{sec:Device Types / =
Block Device / Feature bits}
> >> =20
> >>  \item[VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA (19)] Device supports the
> >>      VIRTIO_BLK_REQ_FLAG_OUT_FUA flag in the \field{flags} bitfield of=
 the
> >> -    \field{virtio_blk_req} structure for VIRTIO_BLK_T_OUT requests.
> >> +    request for VIRTIO_BLK_T_OUT and VIRTIO_BLK_T_CRYPTO_OUT requests.
> >=20
> > More concise: "bitfield in VIRTIO_BLK_T_OUT and VIRTIO_BLK_T_CRYPTO_OUT=
 requests"?
>=20
> Thanks for your comments!
>=20
> Does this makes it clear that \field{flags} refers to the field in struct
> \field{virtio_blk_req}. If so, I'm fine with the change.

Another option is to explicitly state that VIRTIO_BLK_T_OUT uses
virtio_blk_req and VIRTIO_BLK_T_CRYPTO_OUT uses virtio_blk_req_crypto.
That makes the sentence a longer and a bit unwieldy - I guess why you
dropped the reference to virtio_blk_req? It's up to you which approach
you prefer.

>=20
> >=20
> >> +
> >> +\item[VIRTIO_BLK_F_IE (22)] Only when the storage backend supports in=
line
> >=20
> > VIRTIO_BLK_F_INLINE_ENCRYPTION is longer but self-describing. I think
> > that name would be clearer.
>=20
> ACK
>=20
> >=20
> >> +    encryption and this feature bit is negotiated, the data read from=
 or
> >> +    written to the device can be decrypted from or encrypted to the s=
torage
> >> +    via inline crypto engine. Keys are provisioned into key slots of =
the
> >=20
> > via an inline crypto engine
>=20
> ACK
>=20
> >=20
> >> +    inline crypto engine through a mechanism outside the scope of thi=
s device
> >> +    type, and requests identify, by key slot index, which provisioned=
 key to
> >> +    use. The number of key slots, the maximum DUN size and the suppor=
ted key
> >> +    types are reported in \field{enc_characteristics}.
> >> =20
> >>  \end{description}
> >> =20
> >> @@ -135,6 +144,12 @@ \subsection{Device configuration layout}\label{se=
c:Device Types / Block Device /
> >>                  u8 model;
> >>                  u8 unused2[3];
> >>          } zoned;
> >> +        struct virtio_blk_enc_characteristics {
> >> +                le16 max_slots;
> >> +                u8 max_dun_bytes;
> >> +                u8 key_types;
> >> +                le32 unused3;
> >> +        } enc_characteristics;
> >>  };
> >>  \end{lstlisting}
> >> =20
> >> @@ -222,6 +237,39 @@ \subsection{Device configuration layout}\label{se=
c:Device Types / Block Device /
> >>  terminated by the device with a "zone resources exceeded" error as de=
fined for
> >>  specific commands later.
> >> =20
> >> +If the VIRTIO_BLK_F_IE feature is negotiated, then in
> >> +\field{virtio_blk_enc_characteristics},
> >> +\begin{itemize}
> >> +\item \field{max_slots} is the number of key slots allocated to the G=
uest VM.
> >=20
> > It is preferable to avoid virtualization-specific terminology like
> > Guest, VM, etc. VIRTIO usage has expanded beyond virtualization and the
> > specification tends to use Driver and Device instead of Guest and Host.
> > How about:
> >=20
> >   ... is the number of available key slots.
> >=20
>=20
> ACK
>=20
> >> +    It MUST not exceed the number of key slots supported by the inlin=
e crypto
> >> +    engine of the device backend storage. Key slots are indexed from =
0 to
> >=20
> > The MUST sentence needs to be moved to the device normative section
> > because the non-normative sections of the specification do not have
> > MUST/SHOULD/etc.
> >=20
>=20
> ACK
>=20
> >> +    \field{max_slots} - 1.
> >> +
> >> +\item \field{max_dun_bytes} is the maximum number of bytes of the Dat=
a Unit
> >> +    Number (DUN) that the device supports for any of its supported cr=
ypto
> >> +    modes. For example, known inline crypto engines report a
> >> +    \field{max_dun_bytes} of 4 (JEDEC eMMC Command Queue Host Control=
ler
> >> +    Interface, CQHCI) or 8 (JEDEC UFS Host Controller Interface, UFSH=
CI);
> >> +    a device backed by different inline crypto engine hardware MAY re=
port
> >=20
> > The MAY clause must go in the device normative section. Or you could
> > reword this to something like "but other values are possible depending
> > on the inline crypto engine hardware".
> >=20
>=20
> ACK
>=20
> >> +    a different value, subject to the constraints in
> >> +    \ref{devicenormative:Device Types / Block Device / Device Initial=
ization}.
> >> +
> >> +\item \field{key_types} is a bitmask of the key types the device supp=
orts,
> >> +    using the following values:
> >> +    \begin{lstlisting}
> >> +#define VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW    (1 << 0)
> >> +#define VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED  (1 << 1)
> >> +    \end{lstlisting}
> >> +    VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW indicates that keys are provisione=
d into
> >> +    key slots in raw (plaintext) form. VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_=
WRAPPED
> >> +    indicates that the key exists only in ephemerally-wrapped form in=
 memory
> >> +    outside of dedicated hardware, and can only be unwrapped and prov=
isioned
> >> +    into key slots by dedicated hardware (e.g. a hardware key manager=
). The
> >> +    plaintext key never exists in software-accessible memory.
> >=20
> > Why is this reported here if the virtio-blk interface has no ability to
> > program key slots? I would expect this information to be part of the key
> > programming interface because the extension driver will need to indicate
> > whether it is using raw keys or hardware-wrapped keys. The virtio-blk
> > driver itself will never never use this information?
> >=20
>=20
> key_types describes the key types supported by the hardware. Before keysl=
ot
> programming, the key_type requested by the block layer is validated again=
st
> this set, and only the key with supported key types are accepted for the
> subsequent key programming operation.

I'm still not sure why virtio-blk should report the key types since
virtio-blk will never be configured with the chosen key type. If we
ignore the Linux blk-crypto implementation for a second, is there a
reason why virtio-blk needs to report this information? It seems like
the choice of key types belongs with the keyslot programming interface
where this information is actually used.

> >> +
> >> +\item \field{unused3} is reserved for future use.
> >> +\end{itemize}
> >> +
> >>  \subsubsection{Legacy Interface: Device configuration layout}\label{s=
ec:Device Types / Block Device / Device configuration layout / Legacy Inter=
face: Device configuration layout}
> >>  When using the legacy interface, transitional devices and drivers
> >>  MUST format the fields in struct virtio_blk_config
> >> @@ -285,6 +333,14 @@ \subsection{Device Initialization}\label{sec:Devi=
ce Types / Block Device / Devic
> >>      \field{zoned} can be read by the driver to determine the zone
> >>      characteristics of the device. All \field{zoned} fields are read-=
only.
> >> =20
> >> +\item If the VIRTIO_BLK_F_IE feature is negotiated, the fields in
> >> +    \field{enc_characteristics} can be read by the driver to determin=
e the
> >> +    inline encryption capabilities of the device, and a
> >> +    VIRTIO_BLK_T_GET_CRYPTO_MODES request (see
> >> +    \ref{sec:Device Types / Block Device / Device Operation}) can be =
sent
> >> +    to retrieve the set of supported crypto modes. All
> >> +    \field{enc_characteristics} fields are read-only.
> >> +
> >>  \end{enumerate}
> >> =20
> >>  \drivernormative{\subsubsection}{Device Initialization}{Device Types =
/ Block Device / Device Initialization}
> >> @@ -312,6 +368,10 @@ \subsection{Device Initialization}\label{sec:Devi=
ce Types / Block Device / Devic
> >>  offered by the device with the VIRTIO_BLK_Z_HA or VIRTIO_BLK_Z_NONE z=
one model,
> >>  then the driver MAY negotiate these two bits independently.
> >> =20
> >> +Zoned devices do not support inline encryption. If the VIRTIO_BLK_F_Z=
ONED
> >> +feature is offered by the device, then the VIRTIO_BLK_F_IE feature MU=
ST NOT
> >> +be negotiated by the driver.
> >> +
> >>  If the VIRTIO_BLK_F_ZONED feature is negotiated, then
> >>  \begin{itemize}
> >>  \item if the driver that can not support host-managed zoned devices
> >> @@ -327,6 +387,12 @@ \subsection{Device Initialization}\label{sec:Devi=
ce Types / Block Device / Devic
> >>  The driver MUST NOT negotiate VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA without
> >>  VIRTIO_BLK_F_REQ_FLAGS.
> >> =20
> >> +Drivers MUST NOT negotiate the VIRTIO_BLK_F_IE feature if they are
> >> +incapable of provisioning keys into the key slots of the device backe=
nd
> >> +storage's inline crypto engine, or of conveying the key slot index,
> >> +data unit size in bits, and Data Unit Number (DUN) per request to
> >> +the device using the \field{virtio_blk_crypto_msg} structure.
> >> +
> >>  \devicenormative{\subsubsection}{Device Initialization}{Device Types =
/ Block Device / Device Initialization}
> >> =20
> >>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
> >> @@ -341,9 +407,15 @@ \subsection{Device Initialization}\label{sec:Devi=
ce Types / Block Device / Devic
> >>  If the device that is being initialized is a not a zoned device, the =
device
> >>  SHOULD NOT offer the VIRTIO_BLK_F_ZONED feature.
> >> =20
> >> +A zoned device MUST NOT offer the VIRTIO_BLK_F_IE feature.
> >> +
> >>  The VIRTIO_BLK_F_ZONED feature cannot be properly negotiated without
> >>  FEATURES_OK bit. Legacy devices MUST NOT offer VIRTIO_BLK_F_ZONED fea=
ture bit.
> >> =20
> >> +The VIRTIO_BLK_F_IE feature cannot be properly negotiated without
> >> +FEATURES_OK bit. Legacy devices MUST NOT offer the VIRTIO_BLK_F_IE fe=
ature
> >> +bit.
> >> +
> >>  If the VIRTIO_BLK_F_ZONED feature is not accepted by the driver,
> >>  \begin{itemize}
> >>  \item the device with the VIRTIO_BLK_Z_HA or VIRTIO_BLK_Z_NONE zone m=
odel SHOULD
> >> @@ -415,6 +487,26 @@ \subsection{Device Initialization}\label{sec:Devi=
ce Types / Block Device / Devic
> >>  The device MUST NOT acknowledge FEATURES_OK if the driver sets
> >>  VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA without VIRTIO_BLK_F_REQ_FLAGS.
> >> =20
> >> +The device MUST NOT acknowledge FEATURES_OK if the driver negotiates =
both
> >> +VIRTIO_BLK_F_ZONED and VIRTIO_BLK_F_IE.
> >> +
> >> +If the device is incapable of consuming the \field{virtio_blk_crypto_=
msg},
> >> +the device SHOULD NOT offer the VIRTIO_BLK_F_IE feature.
> >> +
> >> +If the VIRTIO_BLK_F_IE feature is negotiated, the device MUST set
> >> +\field{max_slots} in \field{enc_characteristics} to a value greater t=
han 0.
> >> +
> >> +If the VIRTIO_BLK_F_IE feature is negotiated, the device MUST set
> >> +\field{key_types} in \field{enc_characteristics} to have at least one=
 of
> >> +VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW or VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPP=
ED
> >> +set, and MUST NOT set any bit in \field{key_types} other than
> >> +VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW and VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAP=
PED.
> >> +The device MUST initialize padding bytes \field{unused3} to 0.
> >> +
> >> +The device MUST NOT set \field{max_dun_bytes} in \field{enc_character=
istics}
> >> +to 0 or to a value greater than 8, since \field{dun} of
> >> +\field{virtio_blk_crypto_msg} is a fixed 8-byte field.
> >> +
> >>  \subsubsection{Legacy Interface: Device Initialization}\label{sec:Dev=
ice Types / Block Device / Device Initialization / Legacy Interface: Device=
 Initialization}
> >> =20
> >>  Because legacy devices do not have FEATURES_OK, transitional devices
> >> @@ -478,8 +570,8 @@ \subsection{Device Operation}\label{sec:Device Typ=
es / Block Device / Device Ope
> >>  value is the bit index in the \field{flags} bitfield):
> >> =20
> >>  \begin{description}
> >> -\item[VIRTIO_BLK_REQ_FLAG_OUT_FUA (0) for VIRTIO_BLK_T_OUT requests] =
Force Unit
> >> -    Access (FUA) flag.
> >> +\item[VIRTIO_BLK_REQ_FLAG_OUT_FUA (0) for VIRTIO_BLK_T_OUT and
> >> +    VIRTIO_BLK_T_CRYPTO_OUT requests] Force Unit Access (FUA) flag.
> >>  \end{description}
> >> =20
> >>  The \field{sector} number indicates the offset (multiplied by 512) wh=
ere
> >> @@ -886,6 +978,108 @@ \subsection{Device Operation}\label{sec:Device T=
ypes / Block Device / Device Ope
> >>  operation by setting the VIRTIO_BLK_S_ZONE_INVALID_CMD value in
> >>  \field{status} of \field{virtio_blk_req} structure.
> >> =20
> >> +The following requirements only apply if the VIRTIO_BLK_F_IE feature =
is
> >> +negotiated.
> >> +
> >> +In addition to the request types defined for devices without inline
> >> +encryption support, the type of the request can be an inline-encrypte=
d read
> >> +(VIRTIO_BLK_T_CRYPTO_IN), an inline-encrypted write (VIRTIO_BLK_T_CRY=
PTO_OUT)
> >> +or a get crypto modes command (VIRTIO_BLK_T_GET_CRYPTO_MODES).
> >> +
> >> +\begin{lstlisting}
> >> +#define VIRTIO_BLK_T_CRYPTO_OUT        27
> >> +#define VIRTIO_BLK_T_CRYPTO_IN         28
> >> +#define VIRTIO_BLK_T_GET_CRYPTO_MODES  30
> >> +\end{lstlisting}
> >> +
> >> +VIRTIO_BLK_T_CRYPTO_IN and VIRTIO_BLK_T_CRYPTO_OUT requests behave th=
e same
> >> +as VIRTIO_BLK_T_IN and VIRTIO_BLK_T_OUT requests respectively, except=
 that
> >> +the data in \field{data} is decrypted (for VIRTIO_BLK_T_CRYPTO_IN) or=
 is to
> >> +be encrypted (for VIRTIO_BLK_T_CRYPTO_OUT) by the inline crypto engin=
e in
> >> +the device backend storage using the key already provisioned in the k=
ey
> >> +slot identified by the request, combined with the request's Data Unit
> >> +Number (DUN). For this reason, the VIRTIO_BLK_T_CRYPTO_IN and
> >> +VIRTIO_BLK_T_CRYPTO_OUT requests have the layout that is extended to =
have
> >> +the \field{crypto_msg} field to carry this information:
> >> +
> >> +\begin{lstlisting}
> >> +struct virtio_blk_req_crypto {
> >> +        le32 type;
> >> +        le32 flags;
> >> +        le64 sector;
> >> +        struct virtio_blk_crypto_msg crypto_msg;
> >> +        u8 data[];
> >> +        u8 status;
> >> +};
> >> +\end{lstlisting}
> >> +
> >> +\field{crypto_msg} has the following structure:
> >> +
> >> +\begin{lstlisting}
> >> +struct virtio_blk_crypto_msg {
> >> +        le32 slot;
> >> +        le32 data_unit_size_bits;
> >> +        le64 dun;
> >> +};
> >> +\end{lstlisting}
> >> +
> >> +\field{slot} is the virtual key slot index, in the range from 0 to
> >> +\field{max_slots} - 1 of \field{enc_characteristics}. The device maps=
 this
> >> +virtual key slot index to a physical key slot in the inline crypto en=
gine of
> >> +the device backend storage.
> >> +\field{data_unit_size_bits} is $log_2$ of the data unit size in bytes,
> >> +used for calculating DUNs for sub-requests if the request is split.
> >=20
> > Mention VIRTIO_BLK_T_CRYPTO_MODES here so the reader knows how the
> > driver will pick a data_unit_size_bits value?
> >=20
>=20
> Thanks for pointing it out!
>=20
> The crypto mode and data unit size are configured by fscrypt and propagat=
ed
> through the block layer. After validating that the selected combination is
> supported by the hardware, both values are programmed into the keyslot
> configuration registers. Therefore, data_unit_size is associated with the
> programmed key.
>=20
> Re-write it as
>   - used for calculating DUNs for sub-requests if the request is split.
>     The value corresponds to the data unit size associated with the
>     programmed key and written into the keyslot configuration registers
>     during key programming.

Thanks.

>=20
>=20
> >> +\field{dun} is the Data Unit Number, that is, the initial value that =
the
> >> +inline crypto engine increments by one for each successive data unit =
of
> >> +the size specified by \field{data_unit_size_bits}, while encrypting or
> >> +decrypting the data of the request.
> >> +
> >> +VIRTIO_BLK_T_GET_CRYPTO_MODES is a read request that returns the data=
 unit
> >> +sizes with which each of the device's crypto modes can be used. The
> >> +response consists of a header followed by zero or more \field{le32}
> >> +bitmask elements, indexed by crypto mode number:
> >> +
> >> +\begin{lstlisting}
> >> +struct virtio_blk_crypto_modes {
> >> +        le32   nr_modes;
> >> +        u8     reserved[4];
> >> +        le32   modes[];
> >> +};
> >> +\end{lstlisting}
> >> +
> >> +The device sets \field{nr_modes} in the response header to the number=
 of
> >> +fully transferred \field{modes} elements in the data buffer. \field{m=
odes[N]},
> >> +for crypto mode number N, is a bitmask indicating the data unit sizes=
 with
> >> +which crypto mode N can be used by the device: the i'th bit of
> >> +\field{modes[N]} is set if crypto mode N can be used with a data unit=
 size
> >> +of $(1 << i)$ bytes. A value of 0 for a \field{modes} element indicat=
es
> >> +that the device does not support the corresponding crypto mode at all.
> >> +Crypto mode number 0 is reserved; \field{modes[0]} is always set to 0=
 by
> >> +the device.
> >> +
> >> +Crypto mode numbers are assigned by this specification, independently=
 of
> >> +any operating system's internal representation of crypto algorithms, =
so
> >> +that support for additional crypto modes can be added in future revis=
ions
> >> +of this specification without changing the meaning of previously assi=
gned
> >> +numbers:
> >> +
> >> +\begin{lstlisting}
> >> +#define VIRTIO_BLK_CRYPTO_MODE_AES_256_XTS        1
> >> +#define VIRTIO_BLK_CRYPTO_MODE_AES_128_CBC_ESSIV  2
> >> +#define VIRTIO_BLK_CRYPTO_MODE_ADIANTUM           3
> >> +#define VIRTIO_BLK_CRYPTO_MODE_SM4_XTS            4
> >> +\end{lstlisting}
> >> +
> >> +A driver or device implementation MAY support only a subset of these
> >> +crypto modes. Crypto mode numbers already assigned by this or an earl=
ier
> >> +version of this specification are never reused for a different crypto
> >> +mode; additional crypto modes are assigned new numbers, greater than =
the
> >> +highest number defined by the version of this specification the
> >> +implementation supports.
> >> +
> >> +VIRTIO_BLK_T_CRYPTO_IN and VIRTIO_BLK_T_GET_CRYPTO_MODES requests are=
 reads,
> >> +and VIRTIO_BLK_T_CRYPTO_OUT requests are writes.
> >> +
> >>  \drivernormative{\subsubsection}{Device Operation}{Device Types / Blo=
ck Device / Device Operation}
> >> =20
> >>  The driver SHOULD check if the content of the \field{capacity} field =
has
> >> @@ -904,8 +1098,8 @@ \subsection{Device Operation}\label{sec:Device Ty=
pes / Block Device / Device Ope
> >>  A driver MUST set \field{sector} to 0 for a VIRTIO_BLK_T_FLUSH reques=
t.
> >>  A driver SHOULD NOT include any data in a VIRTIO_BLK_T_FLUSH request.
> >> =20
> >> -The length of \field{data} MUST be a multiple of 512 bytes for VIRTIO=
_BLK_T_IN
> >> -and VIRTIO_BLK_T_OUT requests.
> >> +The length of \field{data} MUST be a multiple of 512 bytes for VIRTIO=
_BLK_T_IN,
> >> +VIRTIO_BLK_T_OUT, VIRTIO_BLK_T_CRYPTO_IN and VIRTIO_BLK_T_CRYPTO_OUT =
requests.
> >> =20
> >>  The length of \field{data} MUST be a multiple of the size of struct
> >>  virtio_blk_discard_write_zeroes for VIRTIO_BLK_T_DISCARD,
> >> @@ -984,6 +1178,42 @@ \subsection{Device Operation}\label{sec:Device T=
ypes / Block Device / Device Ope
> >> =20
> >>  \end{enumerate}
> >> =20
> >> +The following requirements only apply if the VIRTIO_BLK_F_IE feature =
is
> >> +negotiated.
> >> +
> >> +A driver MUST NOT submit a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRY=
PTO_OUT
> >> +request with a \field{slot} value that is not less than \field{max_sl=
ots} of
> >=20
> > "not less" -> "greater" (too many negatives in this MUST NOT sentence :=
))
> >=20
>=20
> ACK
>=20
> As \field{slot} starts from 0, correct the statement to
>=20
>   - request with a \field{slot} value that is greater than \field{max_slo=
ts} of
>     \field{enc_characteristics} - 1,
>=20
> >> +\field{enc_characteristics}, or that identifies a key slot into which=
 no key
> >> +has been provisioned.
> >> +
> >> +A driver MUST set \field{data_unit_size_bits} of a VIRTIO_BLK_T_CRYPT=
O_IN or
> >> +VIRTIO_BLK_T_CRYPTO_OUT request's \field{crypto_msg} to $log_2$ of th=
e data
> >> +unit size in bytes associated with the key provisioned in the virtual=
 key
> >> +slot identified by \field{slot}. Since data unit sizes are reported by
> >> +VIRTIO_BLK_T_GET_CRYPTO_MODES as a bitmask of \field{le32} elements, a
> >> +driver MUST NOT set \field{data_unit_size_bits} to a value greater th=
an 31.
> >> +
> >> +A driver MUST NOT submit a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRY=
PTO_OUT
> >> +request with a zero length \field{data}.
> >=20
> > Does VIRTIO_BLK_T_WRITE_ZEROES need an equivalent
> > VIRTIO_BLK_T_CRYPTO_WRITE_ZEROES request type? If the driver sends
> > VIRTIO_BLK_T_WRITE_ZEROES then the device might write zeroes in
> > plaintext, which isn't what we want.
> >=20
>=20
> Yes, it's still cipher text that is flushed into disk even the driver sen=
ds
> VIRTIO_BLK_T_WRITE_ZEROES. Need add a VIRTIO_BLK_T_CRYPTO_WRITE_ZEROES re=
quest
> type.
>=20
> >> +
> >> +A driver MUST NOT submit a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRY=
PTO_OUT
> >> +request unless \field{sector}, multiplied by 512, and the length of
> >> +\field{data}, are both a multiple of $(1 << \field{data_unit_size_bit=
s})$
> >> +bytes.
> >> +
> >> +A driver MUST NOT submit a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRY=
PTO_OUT
> >> +request if \field{dun} + $N$ - 1 is not representable in
> >> +\field{max_dun_bytes} bytes, where $N$ is the number of data units of
> >> +$2^{\field{data_unit_size_bits}}$ bytes in \field{data}.
> >> +
> >> +A driver MUST treat any crypto mode number that is not less than
> >=20
> > "not less" -> "greater"
> >=20
>=20
> ACK
>=20
> >> +\field{nr_modes} of a VIRTIO_BLK_T_GET_CRYPTO_MODES response as unsup=
ported
> >> +by the device.
> >> +
> >> +A driver MUST provide a \field{data} buffer of at least
> >> +sizeof(struct virtio_blk_crypto_modes) (8) bytes for a
> >> +VIRTIO_BLK_T_GET_CRYPTO_MODES request.
> >> +
> >>  \devicenormative{\subsubsection}{Device Operation}{Device Types / Blo=
ck Device / Device Operation}
> >> =20
> >>  The device MAY change the content of the \field{capacity} field during
> >> @@ -1030,7 +1260,8 @@ \subsection{Device Operation}\label{sec:Device T=
ypes / Block Device / Device Ope
> >> =20
> >>  \item\label{item:flush3} the VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA feature w=
as
> >>    negotiated and the VIRTIO_BLK_REQ_FLAG_OUT_FUA bit in \field{flags}=
 was set in
> >> -  the write request (regardless of whether the VIRTIO_BLK_F_FLUSH or
> >> +  the write request (VIRTIO_BLK_T_OUT or VIRTIO_BLK_T_CRYPTO_OUT, reg=
ardless of
> >> +  whether the VIRTIO_BLK_F_FLUSH or
> >>    VIRTIO_BLK_F_CONFIG_WCE features were negotiated, and regardless of=
 the
> >>    current cache mode as expressed by the value of the \field{writebac=
k} field in
> >>    configuration space).
> >> @@ -1225,6 +1456,60 @@ \subsection{Device Operation}\label{sec:Device =
Types / Block Device / Device Ope
> >>  handles VIRTIO_BLK_T_ZONE_RESET request for the zone range specified =
in the
> >>  VIRTIO_BLK_T_SECURE_ERASE request.
> >> =20
> >> +The following requirements only apply if the VIRTIO_BLK_F_IE feature =
is
> >> +negotiated.
> >> +
> >> +If a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO_OUT request:
> >> +\begin{itemize}
> >> +\item specifies a \field{slot} value that is not less than \field{max=
_slots},
> >> +    or that identifies a key slot into which no key has been provisio=
ned,
> >> +
> >> +\item specifies a \field{data_unit_size_bits} value greater than 31, =
or
> >> +    that does not match $log_2$ of the data unit size in bytes associ=
ated
> >> +    with the key provisioned in the virtual key slot identified by the
> >> +    \field{slot},
> >> +
> >> +\item specifies a zero length \field{data},
> >> +
> >> +\item specifies a \field{sector}, multiplied by 512, or a length of
> >> +    \field{data}, that is not a multiple of $(1 << \field{data_unit_s=
ize_bits})$
> >> +    bytes, or
> >> +
> >> +\item specifies a \field{dun} such that \field{dun} + $N$ - 1 is not
> >> +    representable in \field{max_dun_bytes} bytes, where $N$ is the nu=
mber
> >> +    of data units of $2^{\field{data_unit_size_bits}}$ bytes in
> >> +    \field{data},
> >> +\end{itemize}
> >> +then the device MUST set the \field{status} byte to VIRTIO_BLK_S_UNSU=
PP and
> >> +MUST NOT read or write any data.
> >> +
> >> +If a VIRTIO_BLK_T_GET_CRYPTO_MODES request's \field{data} buffer is s=
maller
> >> +than sizeof(struct virtio_blk_crypto_modes) (8) bytes, the device MUS=
T set
> >> +the \field{status} byte to VIRTIO_BLK_S_UNSUPP and MUST NOT write any=
 data.
> >> +
> >> +If the driver's \field{data} buffer in a VIRTIO_BLK_T_GET_CRYPTO_MODES
> >> +request is not large enough to hold \field{modes} elements up to the
> >> +highest crypto mode number the device supports, the device MUST set
> >> +\field{nr_modes} to the number of complete \field{modes} elements tha=
t fit
> >> +in the buffer, and MUST NOT write a partial element.
> >=20
> > This interface offers no way to query the maximum crypto mode. It seems
> > the assumption is that this will never be needed since the driver
> > hardcodes VIRTIO_BLK_CRYPTO_MODE_* values. It would be more flexible to
> > define VIRTIO_BLK_T_GET_CRYPTO_MODES in a way that queries the device's
> > maximum crypto mode index.
> >=20
> > The nr_modes field is kind of redundant anyway since the device fills
> > modes[] elements with 0 when the mode is not supported and the driver
> > determines the buffer size (it will not look any further). So the device
> > doesn't really need to tell the driver how many modes were filled in,
> > but it's potentially more useful to tell the driver what the highest
> > crypto mode index is so the driver can size its data buffer correctly in
> > the next VIRTIO_BLK_T_GET_CRYPTO_MODES request.
> >=20
> > I don't feel strongly about this, but it seems more flexible and it's
> > easy to get this into the spec now, rather than later.
> >=20
>=20
> Thanks for the comments.
>=20
> I agree that exposing the highest crypto mode index would allow the driver
> to allocate the correct buffer size for a subsequent
> VIRTIO_BLK_T_GET_CRYPTO_MODES request.
>=20
> However, this would imply that a particular crypto mode could be unsuppor=
ted
> for file-based encryption on one virtio-blk device while being supported =
on
> another. That does not seem to be a meaningful use case.
>=20
> Given that AES-256-XTS is currently the only crypto mode with actual hard=
ware
> support, as Eric pointed out, I wonder whether we could simply define all
> inline-encryption crypto modes directly in the virtio specification. In t=
hat
> case, the driver would always know the exact buffer size in advance,
> eliminating the need to query the highest mode index. If additional crypto
> modes gain hardware support in the future, the virtio specification could=
 be
> extended accordingly.

Fair enough, there is no real need for the driver to detect crypto modes
it doesn't know about since they have hardcoded semantics and cannot be
detected at runtime with knowledge of those hardcoded semantics.

Adding a new crypto mode in the future would involve:
- Adding a VIRTIO_BLK_T_CRYPTO_MODE_FOO feature bit for the new mode
  and a new VIRTIO_BLK_CRYPTO_MODE_FOO constant.
- Old drivers will not negotiate the new feature bit and they will not
  provide enough modes[] elements in VIRTIO_BLK_T_GET_CRYPTO_MODES to
  fetch information about that mode.
- New drivers will need to be updated to negotiate the new feature bit
  and provide enough modes[] elements in VIRTIO_BLK_T_GET_CRYPTO_MODES
  to fetch information about that mode.

That seems okay. We don't expect many modes to be added.

> >> +
> >> +The device MUST initialize padding bytes \field{reserved} of a
> >> +VIRTIO_BLK_T_GET_CRYPTO_MODES response to 0.
> >> +
> >> +For a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO_OUT request, the =
device
> >> +MUST use the key provisioned in the virtual key slot identified by
> >> +\field{slot} of the request's \field{crypto_msg}, combined with \fiel=
d{dun},
> >> +to decrypt the data read from, or encrypt the data written to, the de=
vice
> >> +backend storage. If the device backend storage splits the request into
> >> +sub-requests, each sub-request MUST begin at a byte offset, from the =
start
> >> +of \field{data}, that is a multiple of $(1 << \field{data_unit_size_b=
its})$
> >> +bytes, MUST have a length that is a multiple of
> >> +$(1 << \field{data_unit_size_bits})$ bytes, and MUST use, in place of
> >> +\field{dun}, the Data Unit Number
> >> +$\field{dun} + (\mathit{byte\_offset} / (1 << \field{data_unit_size_b=
its}))$,
> >> +where $\mathit{byte\_offset}$ is that sub-request's starting byte off=
set
> >> +from the start of \field{data}.
> >> +
> >>  \subsubsection{Legacy Interface: Device Operation}\label{sec:Device T=
ypes / Block Device / Device Operation / Legacy Interface: Device Operation}
> >>  When using the legacy interface, transitional devices and drivers
> >>  MUST format the fields in struct virtio_blk_req
> >> --=20
> >> 2.34.1
> >>
>=20

--wO20YYxaEdqPJ3im
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqIbw8ACgkQnKSrs4Gr
c8hNGwf/SPp8VT+VUI097d2USFVZs9R8t80zy+ciObw8uW9ctqatnV47felb7Na7
4ZVnRvnT0hY6Un7cosGUS6I8FQMoy/9NI9skeSwy9Wlb+p2TYzEg8JyM+H/XOuj5
eKnA/DRUA5B+swppoVE5+ymgtr7jYCBYwoqgPT/HKcXk4bM2VIuf3W4n9nL3P0i6
6pxaRu9RxriTEUBx7gYZn7mdRfN/KC6Kjnh6XzDAsl5ga+J+n3JRFsneNtRUhNis
vDoDdAwnO5ZAYeuCpszx1pxCd85p9G649f5+ibUoEdHK1xZTOQI4HzFR+Z9zLQRj
SP/4IOAYeXDB584rpc3qhO37Xi2NBA==
=9Qil
-----END PGP SIGNATURE-----

--wO20YYxaEdqPJ3im--

