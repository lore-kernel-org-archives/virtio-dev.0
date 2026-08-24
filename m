Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA16446BE0
	for <virtio-dev@lists.linux.dev>; Mon, 24 Aug 2026 15:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586275; cv=none; b=gevroRWHV7oKOzD3JqLZYbEJ02AB0LGzP7jk/09r3U2G1v4yImJE1W/EeYTRNHCYNXjfTlimC8x6IgiyViuKYnRfn/kpZpt1Ma++5A6DQfzEmSW2tZ4l9VVuU3Ll60PSJpZOOsqNx2CFCmPTWP0fFljTBNekax/KP8DJzyKcO8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586275; c=relaxed/simple;
	bh=61990i1CC5rsXkCWC4pVoY0ZbkVW+4R43ZW6OQ+2+c4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l0LVnNTtKWbyw+YyN9k4LRI/BtaRWzZSVkRYvQvnovPGIm1epScDRXP+5T0xAIHRFRUC7UehaBnlaubbfj7FG0zA9h/eWAY/e1WgqUBjfJLPhg5/O5PlKyZwg+/mxDKhL9kiy4ASJRAYdK/cpNogDE+JmQH9qeo4YStf4shGDfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ONlUx8D5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONlUx8D5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787586269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CPW+dvLbr4T1P31s4WWjBRo8WBPsMyeIKEtrjqW4/s8=;
	b=ONlUx8D5Tq27gRJFVDfpvXh/daxkEQHJmprCZb9ylp2g2g1IrieJg+f2XTYa/baps5IXqL
	supmrnUJ3eLCc5bQ8AgvlxCVR4DcX6alMj+d5DRSnDY6CP8mcTXkWkYlxEWyJ6vc0QWtlf
	xKbROxjY1Katp3pAdgueptaThSbl74A=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-473-drChWXSWM4mzhKEs5kOcOw-1; Mon,
 24 Aug 2026 11:44:26 -0400
X-MC-Unique: drChWXSWM4mzhKEs5kOcOw-1
X-Mimecast-MFC-AGG-ID: drChWXSWM4mzhKEs5kOcOw_1787586265
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0EE51834522;
	Mon, 24 Aug 2026 15:44:24 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3F7011955F09;
	Mon, 24 Aug 2026 15:44:24 +0000 (UTC)
Date: Mon, 24 Aug 2026 11:44:20 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
Cc: virtio-dev@lists.linux.dev, ebiggers@kernel.org,
	neeraj.soni@oss.qualcomm.com
Subject: Re: [PATCH v1] virtio-blk: Add inline encryption support
Message-ID: <20260824154420.GA755926@fedora>
References: <20260814142306.3934029-1-linlin.zhang@oss.qualcomm.com>
 <20260819211845.GB470114@fedora>
 <c66459c5-0207-4cc5-bea7-71fe0e600aa1@oss.qualcomm.com>
 <20260821153023.GA564943@fedora>
 <56b6e8ec-f68d-47d7-97af-c5eef814957b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4DAF179dshbJysJE"
Content-Disposition: inline
In-Reply-To: <56b6e8ec-f68d-47d7-97af-c5eef814957b@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

--4DAF179dshbJysJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 22, 2026 at 06:43:28PM +0800, Linlin Zhang wrote:
>=20
>=20
> On 8/21/2026 11:30 PM, Stefan Hajnoczi wrote:
> > On Fri, Aug 21, 2026 at 12:18:55AM +0800, Linlin Zhang wrote:
> >>
> >>
> >> On 8/20/2026 5:18 AM, Stefan Hajnoczi wrote:
> >>> On Fri, Aug 14, 2026 at 07:23:01AM -0700, Linlin Zhang wrote:
> >>>> From: linlzhan <linlin.zhang@oss.qualcomm.com>
> >>>>
> >>>> Add VIRTIO_BLK_F_IE to advertise inline encryption support.
> >>>>
> >>>> When the feature is negotiated, the device reports inline encryption
> >>>> characteristics through virtio_blk_enc_characteristics. Add
> >>>> VIRTIO_BLK_T_GET_CRYPTO_MODES, VIRTIO_BLK_T_CRYPTO_IN, and
> >>>> VIRTIO_BLK_T_CRYPTO_OUT so that the driver can discover supported
> >>>> crypto modes and submit inline-encrypted I/O requests.
> >>>>
> >>>> Crypto I/O requests carry a virtual key slot index, data unit size,
> >>>> and initial Data Unit Number (DUN). The device maps the virtual key
> >>>> slot to a physical key slot in the storage backend and uses these
> >>>> parameters for inline encryption or decryption.
> >>>>
> >>>> Key provisioning is performed through an out-of-band mechanism and is
> >>>> outside the scope of this device type.
> >>>>
> >>>> For background on inline encryption in UFS and eMMC storage, see:
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/Documentation/block/inline-encryption.rst
> >>>>
> >>>> Change-Id: I83c52456bc0c9dd37f39ff46e6bfe73a715138ca
> >>>> Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
> >>>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/238
> >>>> ---
> >>>>  device-types/blk/description.tex | 297 ++++++++++++++++++++++++++++=
++-
> >>>>  1 file changed, 291 insertions(+), 6 deletions(-)
> >>>>
> >>>> diff --git a/device-types/blk/description.tex b/device-types/blk/des=
cription.tex
> >>>> index 3b3a4e7..f8a544b 100644
> >>>> --- a/device-types/blk/description.tex
> >>>> +++ b/device-types/blk/description.tex
> >>>> @@ -71,7 +71,16 @@ \subsection{Feature bits}\label{sec:Device Types =
/ Block Device / Feature bits}
> >>>> =20
> >>>>  \item[VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA (19)] Device supports the
> >>>>      VIRTIO_BLK_REQ_FLAG_OUT_FUA flag in the \field{flags} bitfield =
of the
> >>>> -    \field{virtio_blk_req} structure for VIRTIO_BLK_T_OUT requests.
> >>>> +    request for VIRTIO_BLK_T_OUT and VIRTIO_BLK_T_CRYPTO_OUT reques=
ts.
> >>>
> >>> More concise: "bitfield in VIRTIO_BLK_T_OUT and VIRTIO_BLK_T_CRYPTO_O=
UT requests"?
> >>
> >> Thanks for your comments!
> >>
> >> Does this makes it clear that \field{flags} refers to the field in str=
uct
> >> \field{virtio_blk_req}. If so, I'm fine with the change.
> >=20
> > Another option is to explicitly state that VIRTIO_BLK_T_OUT uses
> > virtio_blk_req and VIRTIO_BLK_T_CRYPTO_OUT uses virtio_blk_req_crypto.
> > That makes the sentence a longer and a bit unwieldy - I guess why you
> > dropped the reference to virtio_blk_req? It's up to you which approach
> > you prefer.
> >=20
>=20
> Thanks for the comments!
>=20
> I'd like to reword it as:
>=20
>  - bitfield of both \field{virtio_blk_req} (for VIRTIO_BLK_T_OUT requests=
) and
>    \field{virtio_blk_req_crypto} (for VIRTIO_BLK_T_CRYPTO_OUT requests).

Sounds good.

>=20
> >>
> >>>
> >>>> +
> >>>> +\item[VIRTIO_BLK_F_IE (22)] Only when the storage backend supports =
inline
> >>>
> >>> VIRTIO_BLK_F_INLINE_ENCRYPTION is longer but self-describing. I think
> >>> that name would be clearer.
> >>
> >> ACK
> >>
> >>>
> >>>> +    encryption and this feature bit is negotiated, the data read fr=
om or
> >>>> +    written to the device can be decrypted from or encrypted to the=
 storage
> >>>> +    via inline crypto engine. Keys are provisioned into key slots o=
f the
> >>>
> >>> via an inline crypto engine
> >>
> >> ACK
> >>
> >>>
> >>>> +    inline crypto engine through a mechanism outside the scope of t=
his device
> >>>> +    type, and requests identify, by key slot index, which provision=
ed key to
> >>>> +    use. The number of key slots, the maximum DUN size and the supp=
orted key
> >>>> +    types are reported in \field{enc_characteristics}.
> >>>> =20
> >>>>  \end{description}
> >>>> =20
> >>>> @@ -135,6 +144,12 @@ \subsection{Device configuration layout}\label{=
sec:Device Types / Block Device /
> >>>>                  u8 model;
> >>>>                  u8 unused2[3];
> >>>>          } zoned;
> >>>> +        struct virtio_blk_enc_characteristics {
> >>>> +                le16 max_slots;
> >>>> +                u8 max_dun_bytes;
> >>>> +                u8 key_types;
> >>>> +                le32 unused3;
> >>>> +        } enc_characteristics;
> >>>>  };
> >>>>  \end{lstlisting}
> >>>> =20
> >>>> @@ -222,6 +237,39 @@ \subsection{Device configuration layout}\label{=
sec:Device Types / Block Device /
> >>>>  terminated by the device with a "zone resources exceeded" error as =
defined for
> >>>>  specific commands later.
> >>>> =20
> >>>> +If the VIRTIO_BLK_F_IE feature is negotiated, then in
> >>>> +\field{virtio_blk_enc_characteristics},
> >>>> +\begin{itemize}
> >>>> +\item \field{max_slots} is the number of key slots allocated to the=
 Guest VM.
> >>>
> >>> It is preferable to avoid virtualization-specific terminology like
> >>> Guest, VM, etc. VIRTIO usage has expanded beyond virtualization and t=
he
> >>> specification tends to use Driver and Device instead of Guest and Hos=
t.
> >>> How about:
> >>>
> >>>   ... is the number of available key slots.
> >>>
> >>
> >> ACK
> >>
> >>>> +    It MUST not exceed the number of key slots supported by the inl=
ine crypto
> >>>> +    engine of the device backend storage. Key slots are indexed fro=
m 0 to
> >>>
> >>> The MUST sentence needs to be moved to the device normative section
> >>> because the non-normative sections of the specification do not have
> >>> MUST/SHOULD/etc.
> >>>
> >>
> >> ACK
> >>
> >>>> +    \field{max_slots} - 1.
> >>>> +
> >>>> +\item \field{max_dun_bytes} is the maximum number of bytes of the D=
ata Unit
> >>>> +    Number (DUN) that the device supports for any of its supported =
crypto
> >>>> +    modes. For example, known inline crypto engines report a
> >>>> +    \field{max_dun_bytes} of 4 (JEDEC eMMC Command Queue Host Contr=
oller
> >>>> +    Interface, CQHCI) or 8 (JEDEC UFS Host Controller Interface, UF=
SHCI);
> >>>> +    a device backed by different inline crypto engine hardware MAY =
report
> >>>
> >>> The MAY clause must go in the device normative section. Or you could
> >>> reword this to something like "but other values are possible depending
> >>> on the inline crypto engine hardware".
> >>>
> >>
> >> ACK
> >>
> >>>> +    a different value, subject to the constraints in
> >>>> +    \ref{devicenormative:Device Types / Block Device / Device Initi=
alization}.
> >>>> +
> >>>> +\item \field{key_types} is a bitmask of the key types the device su=
pports,
> >>>> +    using the following values:
> >>>> +    \begin{lstlisting}
> >>>> +#define VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW    (1 << 0)
> >>>> +#define VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRAPPED  (1 << 1)
> >>>> +    \end{lstlisting}
> >>>> +    VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW indicates that keys are provisio=
ned into
> >>>> +    key slots in raw (plaintext) form. VIRTIO_BLK_CRYPTO_KEY_TYPE_H=
W_WRAPPED
> >>>> +    indicates that the key exists only in ephemerally-wrapped form =
in memory
> >>>> +    outside of dedicated hardware, and can only be unwrapped and pr=
ovisioned
> >>>> +    into key slots by dedicated hardware (e.g. a hardware key manag=
er). The
> >>>> +    plaintext key never exists in software-accessible memory.
> >>>
> >>> Why is this reported here if the virtio-blk interface has no ability =
to
> >>> program key slots? I would expect this information to be part of the =
key
> >>> programming interface because the extension driver will need to indic=
ate
> >>> whether it is using raw keys or hardware-wrapped keys. The virtio-blk
> >>> driver itself will never never use this information?
> >>>
> >>
> >> key_types describes the key types supported by the hardware. Before ke=
yslot
> >> programming, the key_type requested by the block layer is validated ag=
ainst
> >> this set, and only the key with supported key types are accepted for t=
he
> >> subsequent key programming operation.
> >=20
> > I'm still not sure why virtio-blk should report the key types since
> > virtio-blk will never be configured with the chosen key type. If we
> > ignore the Linux blk-crypto implementation for a second, is there a
> > reason why virtio-blk needs to report this information? It seems like
> > the choice of key types belongs with the keyslot programming interface
> > where this information is actually used.
> >=20
>=20
> Thanks!
>=20
> Even if we set aside the Linux blk-crypto implementation, the frontend st=
ill
> needs a way to determine whether a key type requested by the upper layer =
is
> supported by the underlying hardware.
>=20
> Reporting the supported key types through virtio-blk enables the frontend
> to validate a requested key type before entering the key programming flow.
> This fail-fast approach allows the system to determine whether hardware
> inline encryption can be used or whether it should fall back to software
> encryption, avoiding unnecessary preparation and key programming operatio=
ns
> for unsupported key types.

It's still not clear to me why the virtio-blk device interface reports
this information rather than the key programming interface. The fact
that this information is never used by the driver to program the
virito-blk device suggests that it belongs elsewhere.=20

Doesn't the key programming interface have a way to report this
information?

> >>>> +
> >>>> +\item \field{unused3} is reserved for future use.
> >>>> +\end{itemize}
> >>>> +
> >>>>  \subsubsection{Legacy Interface: Device configuration layout}\label=
{sec:Device Types / Block Device / Device configuration layout / Legacy Int=
erface: Device configuration layout}
> >>>>  When using the legacy interface, transitional devices and drivers
> >>>>  MUST format the fields in struct virtio_blk_config
> >>>> @@ -285,6 +333,14 @@ \subsection{Device Initialization}\label{sec:De=
vice Types / Block Device / Devic
> >>>>      \field{zoned} can be read by the driver to determine the zone
> >>>>      characteristics of the device. All \field{zoned} fields are rea=
d-only.
> >>>> =20
> >>>> +\item If the VIRTIO_BLK_F_IE feature is negotiated, the fields in
> >>>> +    \field{enc_characteristics} can be read by the driver to determ=
ine the
> >>>> +    inline encryption capabilities of the device, and a
> >>>> +    VIRTIO_BLK_T_GET_CRYPTO_MODES request (see
> >>>> +    \ref{sec:Device Types / Block Device / Device Operation}) can b=
e sent
> >>>> +    to retrieve the set of supported crypto modes. All
> >>>> +    \field{enc_characteristics} fields are read-only.
> >>>> +
> >>>>  \end{enumerate}
> >>>> =20
> >>>>  \drivernormative{\subsubsection}{Device Initialization}{Device Type=
s / Block Device / Device Initialization}
> >>>> @@ -312,6 +368,10 @@ \subsection{Device Initialization}\label{sec:De=
vice Types / Block Device / Devic
> >>>>  offered by the device with the VIRTIO_BLK_Z_HA or VIRTIO_BLK_Z_NONE=
 zone model,
> >>>>  then the driver MAY negotiate these two bits independently.
> >>>> =20
> >>>> +Zoned devices do not support inline encryption. If the VIRTIO_BLK_F=
_ZONED
> >>>> +feature is offered by the device, then the VIRTIO_BLK_F_IE feature =
MUST NOT
> >>>> +be negotiated by the driver.
> >>>> +
> >>>>  If the VIRTIO_BLK_F_ZONED feature is negotiated, then
> >>>>  \begin{itemize}
> >>>>  \item if the driver that can not support host-managed zoned devices
> >>>> @@ -327,6 +387,12 @@ \subsection{Device Initialization}\label{sec:De=
vice Types / Block Device / Devic
> >>>>  The driver MUST NOT negotiate VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA without
> >>>>  VIRTIO_BLK_F_REQ_FLAGS.
> >>>> =20
> >>>> +Drivers MUST NOT negotiate the VIRTIO_BLK_F_IE feature if they are
> >>>> +incapable of provisioning keys into the key slots of the device bac=
kend
> >>>> +storage's inline crypto engine, or of conveying the key slot index,
> >>>> +data unit size in bits, and Data Unit Number (DUN) per request to
> >>>> +the device using the \field{virtio_blk_crypto_msg} structure.
> >>>> +
> >>>>  \devicenormative{\subsubsection}{Device Initialization}{Device Type=
s / Block Device / Device Initialization}
> >>>> =20
> >>>>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
> >>>> @@ -341,9 +407,15 @@ \subsection{Device Initialization}\label{sec:De=
vice Types / Block Device / Devic
> >>>>  If the device that is being initialized is a not a zoned device, th=
e device
> >>>>  SHOULD NOT offer the VIRTIO_BLK_F_ZONED feature.
> >>>> =20
> >>>> +A zoned device MUST NOT offer the VIRTIO_BLK_F_IE feature.
> >>>> +
> >>>>  The VIRTIO_BLK_F_ZONED feature cannot be properly negotiated without
> >>>>  FEATURES_OK bit. Legacy devices MUST NOT offer VIRTIO_BLK_F_ZONED f=
eature bit.
> >>>> =20
> >>>> +The VIRTIO_BLK_F_IE feature cannot be properly negotiated without
> >>>> +FEATURES_OK bit. Legacy devices MUST NOT offer the VIRTIO_BLK_F_IE =
feature
> >>>> +bit.
> >>>> +
> >>>>  If the VIRTIO_BLK_F_ZONED feature is not accepted by the driver,
> >>>>  \begin{itemize}
> >>>>  \item the device with the VIRTIO_BLK_Z_HA or VIRTIO_BLK_Z_NONE zone=
 model SHOULD
> >>>> @@ -415,6 +487,26 @@ \subsection{Device Initialization}\label{sec:De=
vice Types / Block Device / Devic
> >>>>  The device MUST NOT acknowledge FEATURES_OK if the driver sets
> >>>>  VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA without VIRTIO_BLK_F_REQ_FLAGS.
> >>>> =20
> >>>> +The device MUST NOT acknowledge FEATURES_OK if the driver negotiate=
s both
> >>>> +VIRTIO_BLK_F_ZONED and VIRTIO_BLK_F_IE.
> >>>> +
> >>>> +If the device is incapable of consuming the \field{virtio_blk_crypt=
o_msg},
> >>>> +the device SHOULD NOT offer the VIRTIO_BLK_F_IE feature.
> >>>> +
> >>>> +If the VIRTIO_BLK_F_IE feature is negotiated, the device MUST set
> >>>> +\field{max_slots} in \field{enc_characteristics} to a value greater=
 than 0.
> >>>> +
> >>>> +If the VIRTIO_BLK_F_IE feature is negotiated, the device MUST set
> >>>> +\field{key_types} in \field{enc_characteristics} to have at least o=
ne of
> >>>> +VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW or VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WRA=
PPED
> >>>> +set, and MUST NOT set any bit in \field{key_types} other than
> >>>> +VIRTIO_BLK_CRYPTO_KEY_TYPE_RAW and VIRTIO_BLK_CRYPTO_KEY_TYPE_HW_WR=
APPED.
> >>>> +The device MUST initialize padding bytes \field{unused3} to 0.
> >>>> +
> >>>> +The device MUST NOT set \field{max_dun_bytes} in \field{enc_charact=
eristics}
> >>>> +to 0 or to a value greater than 8, since \field{dun} of
> >>>> +\field{virtio_blk_crypto_msg} is a fixed 8-byte field.
> >>>> +
> >>>>  \subsubsection{Legacy Interface: Device Initialization}\label{sec:D=
evice Types / Block Device / Device Initialization / Legacy Interface: Devi=
ce Initialization}
> >>>> =20
> >>>>  Because legacy devices do not have FEATURES_OK, transitional devices
> >>>> @@ -478,8 +570,8 @@ \subsection{Device Operation}\label{sec:Device T=
ypes / Block Device / Device Ope
> >>>>  value is the bit index in the \field{flags} bitfield):
> >>>> =20
> >>>>  \begin{description}
> >>>> -\item[VIRTIO_BLK_REQ_FLAG_OUT_FUA (0) for VIRTIO_BLK_T_OUT requests=
] Force Unit
> >>>> -    Access (FUA) flag.
> >>>> +\item[VIRTIO_BLK_REQ_FLAG_OUT_FUA (0) for VIRTIO_BLK_T_OUT and
> >>>> +    VIRTIO_BLK_T_CRYPTO_OUT requests] Force Unit Access (FUA) flag.
> >>>>  \end{description}
> >>>> =20
> >>>>  The \field{sector} number indicates the offset (multiplied by 512) =
where
> >>>> @@ -886,6 +978,108 @@ \subsection{Device Operation}\label{sec:Device=
 Types / Block Device / Device Ope
> >>>>  operation by setting the VIRTIO_BLK_S_ZONE_INVALID_CMD value in
> >>>>  \field{status} of \field{virtio_blk_req} structure.
> >>>> =20
> >>>> +The following requirements only apply if the VIRTIO_BLK_F_IE featur=
e is
> >>>> +negotiated.
> >>>> +
> >>>> +In addition to the request types defined for devices without inline
> >>>> +encryption support, the type of the request can be an inline-encryp=
ted read
> >>>> +(VIRTIO_BLK_T_CRYPTO_IN), an inline-encrypted write (VIRTIO_BLK_T_C=
RYPTO_OUT)
> >>>> +or a get crypto modes command (VIRTIO_BLK_T_GET_CRYPTO_MODES).
> >>>> +
> >>>> +\begin{lstlisting}
> >>>> +#define VIRTIO_BLK_T_CRYPTO_OUT        27
> >>>> +#define VIRTIO_BLK_T_CRYPTO_IN         28
> >>>> +#define VIRTIO_BLK_T_GET_CRYPTO_MODES  30
> >>>> +\end{lstlisting}
> >>>> +
> >>>> +VIRTIO_BLK_T_CRYPTO_IN and VIRTIO_BLK_T_CRYPTO_OUT requests behave =
the same
> >>>> +as VIRTIO_BLK_T_IN and VIRTIO_BLK_T_OUT requests respectively, exce=
pt that
> >>>> +the data in \field{data} is decrypted (for VIRTIO_BLK_T_CRYPTO_IN) =
or is to
> >>>> +be encrypted (for VIRTIO_BLK_T_CRYPTO_OUT) by the inline crypto eng=
ine in
> >>>> +the device backend storage using the key already provisioned in the=
 key
> >>>> +slot identified by the request, combined with the request's Data Un=
it
> >>>> +Number (DUN). For this reason, the VIRTIO_BLK_T_CRYPTO_IN and
> >>>> +VIRTIO_BLK_T_CRYPTO_OUT requests have the layout that is extended t=
o have
> >>>> +the \field{crypto_msg} field to carry this information:
> >>>> +
> >>>> +\begin{lstlisting}
> >>>> +struct virtio_blk_req_crypto {
> >>>> +        le32 type;
> >>>> +        le32 flags;
> >>>> +        le64 sector;
> >>>> +        struct virtio_blk_crypto_msg crypto_msg;
> >>>> +        u8 data[];
> >>>> +        u8 status;
> >>>> +};
> >>>> +\end{lstlisting}
> >>>> +
> >>>> +\field{crypto_msg} has the following structure:
> >>>> +
> >>>> +\begin{lstlisting}
> >>>> +struct virtio_blk_crypto_msg {
> >>>> +        le32 slot;
> >>>> +        le32 data_unit_size_bits;
> >>>> +        le64 dun;
> >>>> +};
> >>>> +\end{lstlisting}
> >>>> +
> >>>> +\field{slot} is the virtual key slot index, in the range from 0 to
> >>>> +\field{max_slots} - 1 of \field{enc_characteristics}. The device ma=
ps this
> >>>> +virtual key slot index to a physical key slot in the inline crypto =
engine of
> >>>> +the device backend storage.
> >>>> +\field{data_unit_size_bits} is $log_2$ of the data unit size in byt=
es,
> >>>> +used for calculating DUNs for sub-requests if the request is split.
> >>>
> >>> Mention VIRTIO_BLK_T_CRYPTO_MODES here so the reader knows how the
> >>> driver will pick a data_unit_size_bits value?
> >>>
> >>
> >> Thanks for pointing it out!
> >>
> >> The crypto mode and data unit size are configured by fscrypt and propa=
gated
> >> through the block layer. After validating that the selected combinatio=
n is
> >> supported by the hardware, both values are programmed into the keyslot
> >> configuration registers. Therefore, data_unit_size is associated with =
the
> >> programmed key.
> >>
> >> Re-write it as
> >>   - used for calculating DUNs for sub-requests if the request is split.
> >>     The value corresponds to the data unit size associated with the
> >>     programmed key and written into the keyslot configuration registers
> >>     during key programming.
> >=20
> > Thanks.
> >=20
> >>
> >>
> >>>> +\field{dun} is the Data Unit Number, that is, the initial value tha=
t the
> >>>> +inline crypto engine increments by one for each successive data uni=
t of
> >>>> +the size specified by \field{data_unit_size_bits}, while encrypting=
 or
> >>>> +decrypting the data of the request.
> >>>> +
> >>>> +VIRTIO_BLK_T_GET_CRYPTO_MODES is a read request that returns the da=
ta unit
> >>>> +sizes with which each of the device's crypto modes can be used. The
> >>>> +response consists of a header followed by zero or more \field{le32}
> >>>> +bitmask elements, indexed by crypto mode number:
> >>>> +
> >>>> +\begin{lstlisting}
> >>>> +struct virtio_blk_crypto_modes {
> >>>> +        le32   nr_modes;
> >>>> +        u8     reserved[4];
> >>>> +        le32   modes[];
> >>>> +};
> >>>> +\end{lstlisting}
> >>>> +
> >>>> +The device sets \field{nr_modes} in the response header to the numb=
er of
> >>>> +fully transferred \field{modes} elements in the data buffer. \field=
{modes[N]},
> >>>> +for crypto mode number N, is a bitmask indicating the data unit siz=
es with
> >>>> +which crypto mode N can be used by the device: the i'th bit of
> >>>> +\field{modes[N]} is set if crypto mode N can be used with a data un=
it size
> >>>> +of $(1 << i)$ bytes. A value of 0 for a \field{modes} element indic=
ates
> >>>> +that the device does not support the corresponding crypto mode at a=
ll.
> >>>> +Crypto mode number 0 is reserved; \field{modes[0]} is always set to=
 0 by
> >>>> +the device.
> >>>> +
> >>>> +Crypto mode numbers are assigned by this specification, independent=
ly of
> >>>> +any operating system's internal representation of crypto algorithms=
, so
> >>>> +that support for additional crypto modes can be added in future rev=
isions
> >>>> +of this specification without changing the meaning of previously as=
signed
> >>>> +numbers:
> >>>> +
> >>>> +\begin{lstlisting}
> >>>> +#define VIRTIO_BLK_CRYPTO_MODE_AES_256_XTS        1
> >>>> +#define VIRTIO_BLK_CRYPTO_MODE_AES_128_CBC_ESSIV  2
> >>>> +#define VIRTIO_BLK_CRYPTO_MODE_ADIANTUM           3
> >>>> +#define VIRTIO_BLK_CRYPTO_MODE_SM4_XTS            4
> >>>> +\end{lstlisting}
> >>>> +
> >>>> +A driver or device implementation MAY support only a subset of these
> >>>> +crypto modes. Crypto mode numbers already assigned by this or an ea=
rlier
> >>>> +version of this specification are never reused for a different cryp=
to
> >>>> +mode; additional crypto modes are assigned new numbers, greater tha=
n the
> >>>> +highest number defined by the version of this specification the
> >>>> +implementation supports.
> >>>> +
> >>>> +VIRTIO_BLK_T_CRYPTO_IN and VIRTIO_BLK_T_GET_CRYPTO_MODES requests a=
re reads,
> >>>> +and VIRTIO_BLK_T_CRYPTO_OUT requests are writes.
> >>>> +
> >>>>  \drivernormative{\subsubsection}{Device Operation}{Device Types / B=
lock Device / Device Operation}
> >>>> =20
> >>>>  The driver SHOULD check if the content of the \field{capacity} fiel=
d has
> >>>> @@ -904,8 +1098,8 @@ \subsection{Device Operation}\label{sec:Device =
Types / Block Device / Device Ope
> >>>>  A driver MUST set \field{sector} to 0 for a VIRTIO_BLK_T_FLUSH requ=
est.
> >>>>  A driver SHOULD NOT include any data in a VIRTIO_BLK_T_FLUSH reques=
t.
> >>>> =20
> >>>> -The length of \field{data} MUST be a multiple of 512 bytes for VIRT=
IO_BLK_T_IN
> >>>> -and VIRTIO_BLK_T_OUT requests.
> >>>> +The length of \field{data} MUST be a multiple of 512 bytes for VIRT=
IO_BLK_T_IN,
> >>>> +VIRTIO_BLK_T_OUT, VIRTIO_BLK_T_CRYPTO_IN and VIRTIO_BLK_T_CRYPTO_OU=
T requests.
> >>>> =20
> >>>>  The length of \field{data} MUST be a multiple of the size of struct
> >>>>  virtio_blk_discard_write_zeroes for VIRTIO_BLK_T_DISCARD,
> >>>> @@ -984,6 +1178,42 @@ \subsection{Device Operation}\label{sec:Device=
 Types / Block Device / Device Ope
> >>>> =20
> >>>>  \end{enumerate}
> >>>> =20
> >>>> +The following requirements only apply if the VIRTIO_BLK_F_IE featur=
e is
> >>>> +negotiated.
> >>>> +
> >>>> +A driver MUST NOT submit a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_C=
RYPTO_OUT
> >>>> +request with a \field{slot} value that is not less than \field{max_=
slots} of
> >>>
> >>> "not less" -> "greater" (too many negatives in this MUST NOT sentence=
 :))
> >>>
> >>
> >> ACK
> >>
> >> As \field{slot} starts from 0, correct the statement to
> >>
> >>   - request with a \field{slot} value that is greater than \field{max_=
slots} of
> >>     \field{enc_characteristics} - 1,
> >>
> >>>> +\field{enc_characteristics}, or that identifies a key slot into whi=
ch no key
> >>>> +has been provisioned.
> >>>> +
> >>>> +A driver MUST set \field{data_unit_size_bits} of a VIRTIO_BLK_T_CRY=
PTO_IN or
> >>>> +VIRTIO_BLK_T_CRYPTO_OUT request's \field{crypto_msg} to $log_2$ of =
the data
> >>>> +unit size in bytes associated with the key provisioned in the virtu=
al key
> >>>> +slot identified by \field{slot}. Since data unit sizes are reported=
 by
> >>>> +VIRTIO_BLK_T_GET_CRYPTO_MODES as a bitmask of \field{le32} elements=
, a
> >>>> +driver MUST NOT set \field{data_unit_size_bits} to a value greater =
than 31.
> >>>> +
> >>>> +A driver MUST NOT submit a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_C=
RYPTO_OUT
> >>>> +request with a zero length \field{data}.
> >>>
> >>> Does VIRTIO_BLK_T_WRITE_ZEROES need an equivalent
> >>> VIRTIO_BLK_T_CRYPTO_WRITE_ZEROES request type? If the driver sends
> >>> VIRTIO_BLK_T_WRITE_ZEROES then the device might write zeroes in
> >>> plaintext, which isn't what we want.
> >>>
> >>
> >> Yes, it's still cipher text that is flushed into disk even the driver =
sends
> >> VIRTIO_BLK_T_WRITE_ZEROES. Need add a VIRTIO_BLK_T_CRYPTO_WRITE_ZEROES=
 request
> >> type.
> >>
> >>>> +
> >>>> +A driver MUST NOT submit a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_C=
RYPTO_OUT
> >>>> +request unless \field{sector}, multiplied by 512, and the length of
> >>>> +\field{data}, are both a multiple of $(1 << \field{data_unit_size_b=
its})$
> >>>> +bytes.
> >>>> +
> >>>> +A driver MUST NOT submit a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_C=
RYPTO_OUT
> >>>> +request if \field{dun} + $N$ - 1 is not representable in
> >>>> +\field{max_dun_bytes} bytes, where $N$ is the number of data units =
of
> >>>> +$2^{\field{data_unit_size_bits}}$ bytes in \field{data}.
> >>>> +
> >>>> +A driver MUST treat any crypto mode number that is not less than
> >>>
> >>> "not less" -> "greater"
> >>>
> >>
> >> ACK
> >>
> >>>> +\field{nr_modes} of a VIRTIO_BLK_T_GET_CRYPTO_MODES response as uns=
upported
> >>>> +by the device.
> >>>> +
> >>>> +A driver MUST provide a \field{data} buffer of at least
> >>>> +sizeof(struct virtio_blk_crypto_modes) (8) bytes for a
> >>>> +VIRTIO_BLK_T_GET_CRYPTO_MODES request.
> >>>> +
> >>>>  \devicenormative{\subsubsection}{Device Operation}{Device Types / B=
lock Device / Device Operation}
> >>>> =20
> >>>>  The device MAY change the content of the \field{capacity} field dur=
ing
> >>>> @@ -1030,7 +1260,8 @@ \subsection{Device Operation}\label{sec:Device=
 Types / Block Device / Device Ope
> >>>> =20
> >>>>  \item\label{item:flush3} the VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA feature=
 was
> >>>>    negotiated and the VIRTIO_BLK_REQ_FLAG_OUT_FUA bit in \field{flag=
s} was set in
> >>>> -  the write request (regardless of whether the VIRTIO_BLK_F_FLUSH or
> >>>> +  the write request (VIRTIO_BLK_T_OUT or VIRTIO_BLK_T_CRYPTO_OUT, r=
egardless of
> >>>> +  whether the VIRTIO_BLK_F_FLUSH or
> >>>>    VIRTIO_BLK_F_CONFIG_WCE features were negotiated, and regardless =
of the
> >>>>    current cache mode as expressed by the value of the \field{writeb=
ack} field in
> >>>>    configuration space).
> >>>> @@ -1225,6 +1456,60 @@ \subsection{Device Operation}\label{sec:Devic=
e Types / Block Device / Device Ope
> >>>>  handles VIRTIO_BLK_T_ZONE_RESET request for the zone range specifie=
d in the
> >>>>  VIRTIO_BLK_T_SECURE_ERASE request.
> >>>> =20
> >>>> +The following requirements only apply if the VIRTIO_BLK_F_IE featur=
e is
> >>>> +negotiated.
> >>>> +
> >>>> +If a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO_OUT request:
> >>>> +\begin{itemize}
> >>>> +\item specifies a \field{slot} value that is not less than \field{m=
ax_slots},
> >>>> +    or that identifies a key slot into which no key has been provis=
ioned,
> >>>> +
> >>>> +\item specifies a \field{data_unit_size_bits} value greater than 31=
, or
> >>>> +    that does not match $log_2$ of the data unit size in bytes asso=
ciated
> >>>> +    with the key provisioned in the virtual key slot identified by =
the
> >>>> +    \field{slot},
> >>>> +
> >>>> +\item specifies a zero length \field{data},
> >>>> +
> >>>> +\item specifies a \field{sector}, multiplied by 512, or a length of
> >>>> +    \field{data}, that is not a multiple of $(1 << \field{data_unit=
_size_bits})$
> >>>> +    bytes, or
> >>>> +
> >>>> +\item specifies a \field{dun} such that \field{dun} + $N$ - 1 is not
> >>>> +    representable in \field{max_dun_bytes} bytes, where $N$ is the =
number
> >>>> +    of data units of $2^{\field{data_unit_size_bits}}$ bytes in
> >>>> +    \field{data},
> >>>> +\end{itemize}
> >>>> +then the device MUST set the \field{status} byte to VIRTIO_BLK_S_UN=
SUPP and
> >>>> +MUST NOT read or write any data.
> >>>> +
> >>>> +If a VIRTIO_BLK_T_GET_CRYPTO_MODES request's \field{data} buffer is=
 smaller
> >>>> +than sizeof(struct virtio_blk_crypto_modes) (8) bytes, the device M=
UST set
> >>>> +the \field{status} byte to VIRTIO_BLK_S_UNSUPP and MUST NOT write a=
ny data.
> >>>> +
> >>>> +If the driver's \field{data} buffer in a VIRTIO_BLK_T_GET_CRYPTO_MO=
DES
> >>>> +request is not large enough to hold \field{modes} elements up to the
> >>>> +highest crypto mode number the device supports, the device MUST set
> >>>> +\field{nr_modes} to the number of complete \field{modes} elements t=
hat fit
> >>>> +in the buffer, and MUST NOT write a partial element.
> >>>
> >>> This interface offers no way to query the maximum crypto mode. It see=
ms
> >>> the assumption is that this will never be needed since the driver
> >>> hardcodes VIRTIO_BLK_CRYPTO_MODE_* values. It would be more flexible =
to
> >>> define VIRTIO_BLK_T_GET_CRYPTO_MODES in a way that queries the device=
's
> >>> maximum crypto mode index.
> >>>
> >>> The nr_modes field is kind of redundant anyway since the device fills
> >>> modes[] elements with 0 when the mode is not supported and the driver
> >>> determines the buffer size (it will not look any further). So the dev=
ice
> >>> doesn't really need to tell the driver how many modes were filled in,
> >>> but it's potentially more useful to tell the driver what the highest
> >>> crypto mode index is so the driver can size its data buffer correctly=
 in
> >>> the next VIRTIO_BLK_T_GET_CRYPTO_MODES request.
> >>>
> >>> I don't feel strongly about this, but it seems more flexible and it's
> >>> easy to get this into the spec now, rather than later.
> >>>
> >>
> >> Thanks for the comments.
> >>
> >> I agree that exposing the highest crypto mode index would allow the dr=
iver
> >> to allocate the correct buffer size for a subsequent
> >> VIRTIO_BLK_T_GET_CRYPTO_MODES request.
> >>
> >> However, this would imply that a particular crypto mode could be unsup=
ported
> >> for file-based encryption on one virtio-blk device while being support=
ed on
> >> another. That does not seem to be a meaningful use case.
> >>
> >> Given that AES-256-XTS is currently the only crypto mode with actual h=
ardware
> >> support, as Eric pointed out, I wonder whether we could simply define =
all
> >> inline-encryption crypto modes directly in the virtio specification. I=
n that
> >> case, the driver would always know the exact buffer size in advance,
> >> eliminating the need to query the highest mode index. If additional cr=
ypto
> >> modes gain hardware support in the future, the virtio specification co=
uld be
> >> extended accordingly.
> >=20
> > Fair enough, there is no real need for the driver to detect crypto modes
> > it doesn't know about since they have hardcoded semantics and cannot be
> > detected at runtime with knowledge of those hardcoded semantics.
> >=20
> > Adding a new crypto mode in the future would involve:
> > - Adding a VIRTIO_BLK_T_CRYPTO_MODE_FOO feature bit for the new mode
> >   and a new VIRTIO_BLK_CRYPTO_MODE_FOO constant.
> > - Old drivers will not negotiate the new feature bit and they will not
> >   provide enough modes[] elements in VIRTIO_BLK_T_GET_CRYPTO_MODES to
> >   fetch information about that mode.
> > - New drivers will need to be updated to negotiate the new feature bit
> >   and provide enough modes[] elements in VIRTIO_BLK_T_GET_CRYPTO_MODES
> >   to fetch information about that mode.
> >=20
> > That seems okay. We don't expect many modes to be added.
> >=20
>=20
> Thanks!
>=20
> I don't think a new feature bit is needed when a new crypto mode is added,
> because VIRTIO_BLK_F_INLINE_ENCRYPTION already gates the whole mechanism,
> and the index of supported crypto modes is already defined in the virtio
> sepec.
>=20
> Assume that VIRTIO_BLK_F_INLINE_ENCRYPTION has been negotiated.
>=20
> Initially, both the frontend and backend implement the same version of
> the virtio specification. The frontend allocates a buffer large enough
> to hold all crypto modes defined by that specification version, and the
> backend fills the entire buffer accordingly.
>=20
> During future upgrades, there are several possible compatibility scenario=
s:
>=20
>   1. Both frontend and backend are upgraded to the same newer specificati=
on
>      version
>      Both sides recognize the same set of crypto modes. The frontend prov=
ides
>      a buffer large enough for all supported modes, and the backend fills=
 it
>      completely. No compatibility issue arises.
>=20
>   2. Frontend and backend support different specification versions
>      - Frontend supports more crypto modes than the backend
>        The frontend allocates a larger buffer. The backend only reports t=
he
>        crypto modes it recognizes and fills the remaining buffer entries =
as 0.
>        No compatibility issue arises.
>=20
>      - Frontend supports fewer crypto modes than the backend
>        The backend determines the number of entries that can fit in the b=
uffer
>        provided by the frontend and populates the buffer with the corresp=
onding
>        subset of its crypto mode list. Any additional crypto modes suppor=
ted only
>        by the newer backend are simply not reported. No compatibility iss=
ue arises.
>=20
> I'd be interested to hear your thoughts on this. If you agree with the
> approach and don't have any further concerns, I'll send a v3 series.
> Patch v2 already addresses most of the issues you pointed out.

You are right. I'm glad we discussed this and it will be possible to add
more crypto modes in the future in a compatible way.

> >>>> +
> >>>> +The device MUST initialize padding bytes \field{reserved} of a
> >>>> +VIRTIO_BLK_T_GET_CRYPTO_MODES response to 0.
> >>>> +
> >>>> +For a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CRYPTO_OUT request, th=
e device
> >>>> +MUST use the key provisioned in the virtual key slot identified by
> >>>> +\field{slot} of the request's \field{crypto_msg}, combined with \fi=
eld{dun},
> >>>> +to decrypt the data read from, or encrypt the data written to, the =
device
> >>>> +backend storage. If the device backend storage splits the request i=
nto
> >>>> +sub-requests, each sub-request MUST begin at a byte offset, from th=
e start
> >>>> +of \field{data}, that is a multiple of $(1 << \field{data_unit_size=
_bits})$
> >>>> +bytes, MUST have a length that is a multiple of
> >>>> +$(1 << \field{data_unit_size_bits})$ bytes, and MUST use, in place =
of
> >>>> +\field{dun}, the Data Unit Number
> >>>> +$\field{dun} + (\mathit{byte\_offset} / (1 << \field{data_unit_size=
_bits}))$,
> >>>> +where $\mathit{byte\_offset}$ is that sub-request's starting byte o=
ffset
> >>>> +from the start of \field{data}.
> >>>> +
> >>>>  \subsubsection{Legacy Interface: Device Operation}\label{sec:Device=
 Types / Block Device / Device Operation / Legacy Interface: Device Operati=
on}
> >>>>  When using the legacy interface, transitional devices and drivers
> >>>>  MUST format the fields in struct virtio_blk_req
> >>>> --=20
> >>>> 2.34.1
> >>>>
> >>
>=20

--4DAF179dshbJysJE
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqMZtQACgkQnKSrs4Gr
c8jU+Qf+OQ1PGkGB5A2mLP4zO0mxsthsdCi7COogr7AVQqGHsGJOxdjZsok1CMf9
ACsbeN5KaTsWiwj4RWZZdXYs/HaeQw9i6K1NMHU2uMM0+N4C1kzgaHSX727HZoYt
t4f/iW7Hu4kqP0ySgtncCWSkFBjsSuvi4lRfACzy/wJfcQd84RL/ojbdeFcrDTKs
QpWKnayJFNC4p4xVx8lXfah0cO/3PJQqDQoWmgTS8Y1L2aT9nRr54LN7+Y0Qi3QD
aPzfoVxUPCvjNL/OASn/gdbVv5+BpJL9h+/u9joyNyHKGi/5DaKaUbDOaPOnlMJr
Z+BBy96UX9ksO9eR3nbyzMStkdnY+A==
=2+W3
-----END PGP SIGNATURE-----

--4DAF179dshbJysJE--

