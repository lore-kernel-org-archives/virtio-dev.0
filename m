Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CD81DC985
	for <virtio-dev@lists.linux.dev>; Tue,  3 Feb 2026 14:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770129813; cv=none; b=FL3iTX7VvGNuGSzkgoBkLjTEO/+GC75Z4xTYQOO9wuo8dmxC8myr0I1IT3dG593vJzGhsAY4DlYRxaDy/03vW29JhWcwt7Jav3lzMRixXMo2NTK3zKK127a8HRO3ApSwOu2rSxBm0d9j7FxCaDtI7Nuq4sn7PWzq/KqrZ/GAa1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770129813; c=relaxed/simple;
	bh=KvypKfTtNrW402i3vm8FG4de4WNXTTBeqfGNmsysRLQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DaPD1WM/FgKfkSV4QdsS/wazHiHfxV9j5mb+5tzPs2kjWnouT7WXONJEry+HJMMTmy7EezVEYLsv885mQilL0bQqFtJnwxIO5hjhOSOVYbU+sLVHlmCFDXgnPJ8Ei8ZeE1yt4M7RSBmBUTUIW1Y5oYmUbfjAysajtr1nhaThVjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pyz06y05; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pyz06y05"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770129809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KwLaKNeUZNZng6CGDQROtxDjq3WjT2K1CT/emLQBdaY=;
	b=Pyz06y05OV+TJtYL/B7e2aWLmeTelOBGn5ljbCYQp5mfLdsTQUqeIczdHt3uHgcjXJR+O3
	Y5yLNbuOEnyy7Yu1xkTRoU+O2zEdyUepF+kAHC8qeDjIhEilMzE1zcurGzaX0n5v5Q0BKq
	h8OGe/9vM3DDd2v5qOO1bVo3sfD8w7I=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-624-plMEOhjbMtW-0XRvio69jw-1; Tue,
 03 Feb 2026 09:43:24 -0500
X-MC-Unique: plMEOhjbMtW-0XRvio69jw-1
X-Mimecast-MFC-AGG-ID: plMEOhjbMtW-0XRvio69jw_1770129803
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 39EF518002C5;
	Tue,  3 Feb 2026 14:43:23 +0000 (UTC)
Received: from localhost (unknown [10.2.16.143])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B60671800577;
	Tue,  3 Feb 2026 14:43:22 +0000 (UTC)
Date: Tue, 3 Feb 2026 09:43:21 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Linlin Zhang <quic_linlzhan@quicinc.com>
Cc: virtio-dev@lists.linux.dev, quic_dshaikhu@quicinc.com
Subject: Re: [PATCH v1] virtio-blk: Add inline encryption support
Message-ID: <20260203144321.GA445116@fedora>
References: <20260127141432.2617357-1-quic_linlzhan@quicinc.com>
 <20260127142032.2619551-1-quic_linlzhan@quicinc.com>
 <20260127210951.GA96301@fedora>
 <b95cf6c4-db73-49e4-969e-fa7735a07527@quicinc.com>
 <20260202155622.GA405548@fedora>
 <a704fabe-c4cb-4aa0-8460-2c57980650be@quicinc.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hw3vcwHDvi5Lr37U"
Content-Disposition: inline
In-Reply-To: <a704fabe-c4cb-4aa0-8460-2c57980650be@quicinc.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111


--hw3vcwHDvi5Lr37U
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 03, 2026 at 06:06:33PM +0800, Linlin Zhang wrote:
>=20
>=20
> On 2/2/2026 11:56 PM, Stefan Hajnoczi wrote:
> > On Fri, Jan 30, 2026 at 06:23:55PM +0800, Linlin Zhang wrote:
> >> Thank you for the review. I=E2=80=99ve added some clarifications and p=
otential updates.
> >> Could you please take another look before I send a new patch?
> >>
> >> On 1/28/2026 5:09 AM, Stefan Hajnoczi wrote:
> >>> On Tue, Jan 27, 2026 at 10:20:32PM +0800, Linlin Zhang wrote:
> >>>> From: linlzhan <quic_linlzhan@quicinc.com>
> >>>>
> >>>> Inline encryption on virtio block can only be supported when
> >>>> the new feature bit VIRTIO_BLK_F_ICE is negotiated.
> >>>>
> >>>> Extend struct virtio_blk_config and struct virtio_blk_req,
> >>>> so that crypto capabilities can be got in the frontend and
> >>>> encryption metadata can be sent to the backend, together with
> >>>> each I/O transaction.
> >>>
> >>> This looks like a Self-Encrypting Drives feature along the lines of T=
CG
> >>> Opal:
> >>> https://en.wikipedia.org/wiki/Opal_Storage_Specification
> >>>
> >>> Would it make sense to implement TCG Opal instead of defining a new
> >>> interface? That would make this more familiar to users and simplify
> >>> integration into existing tools like sedutil and cryptsetup (e.g. by
> >>> supporting the <linux/sed-opal.h> ioctl interface).
> >>
> >> This patch is for the FBE (File Based Encryption) support on UFS/EMMC
> >> storage with ICE (Inline Crypto Engine) enabled. TCG Opal is only appl=
icable
> >> to SED (self-encrypting drives), not applicable to ICE (Inline Crypto =
Engine).
> >>
> >> In Automotive or Embedded scenario, UFS/EMMC generally is used. The di=
sk
> >> encryption on them is supported by the ICE pipeline of SOC, rather SSD
> >> controller, so we couldn't use TCG Opal here.
> >=20
> > Okay. Is there a specification that this interface needs to comply with?
> >=20
> > If not, you can include a link to the Linux inline encryption
> > documentation in the commit description:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/block/inline-encryption.rst
> >=20
> > Having a reference will will help the discussion. That way we can be
> > confident the VIRTIO spec changes will be widely useful beyond a single
> > use case and easy to implement in drivers because they follow an
> > existing interface.
>=20
> ACK
>=20
> >=20
> >>
> >>>
> >>>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/238
> >>>>
> >>>> Change-Id: Ic23b2137e5d9a599d826e06c279f1b614d79abdf
> >>>> Signed-off-by: linlzhan <quic_linlzhan@quicinc.com>
> >>>> ---
> >>>>  device-types/blk/description.tex | 69 +++++++++++++++++++++++++++++=
+++
> >>>>  1 file changed, 69 insertions(+)
> >>>>
> >>>> diff --git a/device-types/blk/description.tex b/device-types/blk/des=
cription.tex
> >>>> index 2712ada..23d8dc0 100644
> >>>> --- a/device-types/blk/description.tex
> >>>> +++ b/device-types/blk/description.tex
> >>>> @@ -66,6 +66,11 @@ \subsection{Feature bits}\label{sec:Device Types =
/ Block Device / Feature bits}
> >>>>  	(ZNS). For brevity, these standard documents are referred as "ZBD =
standards"
> >>>>  	from this point on in the text.
> >>>> =20
> >>>> +\item[VIRTIO_BLK_F_ICE(22)] Inline Crypto Extensions are supported.=
 When this
> >>>> +     is negotiated, the device exposes crypto characteristics in co=
nfiguration
> >>>> +     space and the driver SHALL provide an extended request header =
containing a
> >>>
> >>> SHALL, MUST, MAY, etc are only used in the normative sections of the
> >>> spec.
> >>>
> >>> Why "SHALL"? Does this mean the device must be prepared to receive
> >>> requests without the payload field when VIRTIO_BLK_F_ICE is negotiate=
d?
> >>> How should the device behave in that case: fail the request or perform
> >>> I/O without crypto?
> >>
> >> This section - 5.2.3 Feature bits - is a normative section.
> >=20
> > \section{Block Device}\label{sec:Device Types / Block Device}
> > ...
> > \subsection{Feature bits}\label{sec:Device Types / Block Device / Featu=
re bits}
> >=20
> > No, this is a non-normative section. The normative sections are the
> > "Device Requirements" (\devicenormative) and "Driver Requirements"
> > (\drivernormative) sections.
>=20
> OK, as this is a non-normative section, can I use lowercase 'shall', 'mus=
t'.etc here?

I think that is discouraged to prevent confusion. It can be phrased in a
descriptive way instead:

  and the driver provides an extended request header containing a ...

>=20
> >=20
> >>
> >> What's expected for VIRTIO_BLK_F_ICE feature bit is that configuration=
 space
> >> must be prepared with the exposed crypto characteristics and the virti=
o block
> >> frontend must sent a virtblk request with encryption metadata packed i=
nto
> >> when VIRTIO_BLK_F_ICE is negotiated and hardware crypto is supported.
> >>
> >> By replacing 'SHALL' with 'MUST' here, Is the following rewording fine?
> >>
> >>   Inline Crypto Extensions are supported. When this is negotiated, the=
 device MUST
> >>   expose crypto characteristics in configuration space and the driver =
MUST provide
> >>   an extended request header containing a crypto payload for block I/O=
 if the
> >>   hardware supports inline crypto. If this feature bit is negotiated, =
but hardware
> >>   inline crypto doesn't support, the device SHOULD perform I/O without=
 crypto.
> >>
> >> I'll add hw_enabled (type: u8) to virtio_blk_crypto_characteristics to=
 indicate
> >> whether the host supports hardware inline encryption.
> >=20
> > I still have a question about this: why would a device advertise
> > VIRTIO_BLK_F_ICE but report hw_enabled =3D 0? I'm not sure how this is
> > functionally different from a device that does not report
> > VIRTIO_BLK_F_ICE. It seems simpler for devices to only advertise
> > VIRTIO_BLK_F_ICE when they support inline encryption.
>=20
> ACK.
> Previously I assume VIRTIO_BLK_F_ICE is negotiated even ICE (Inline Crypt=
o Engine)
> isn't enabled. Seems it isn't needed. a device should only advertise
> VIRTIO_BLK_F_ICE when ICE is enabled. Correct the statement as the follow=
ing.
>=20
>   Inline Crypto Extensions are supported. Only when this feature b is neg=
otiated, the device need
>   expose crypto characteristics in configuration space and the driver nee=
d provide
>   an extended request header containing a crypto payload for block I/O.=
=20

Good.

>=20
> >=20
> >>>
> >>>> +     crypto payload for block I/O.
> >>>> +
> >>>>  \end{description}
> >>>> =20
> >>>>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Typ=
es / Block Device / Feature bits / Legacy Interface: Feature bits}
> >>>> @@ -128,6 +133,11 @@ \subsection{Device configuration layout}\label{=
sec:Device Types / Block Device /
> >>>>                  u8 model;
> >>>>                  u8 unused2[3];
> >>>>          } zoned;
> >>>> +        struct virtio_blk_crypto_characteristics {
> >>>> +                __virtio16 slot_info;
> >>>> +                __virtio16 reserved;
> >>>> +                __virtio32 capability;
> >>>> +        } crypto;
> >>>>  };
> >>>>  \end{lstlisting}
> >>>> =20
> >>>> @@ -215,6 +225,25 @@ \subsection{Device configuration layout}\label{=
sec:Device Types / Block Device /
> >>>>  terminated by the device with a "zone resources exceeded" error as =
defined for
> >>>>  specific commands later.
> >>>> =20
> >>>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then in
> >>>> +\field{virtio_blk_crypto_characteristics},
> >>>> +\begin{itemize}
> >>>> +\item \field{slot_info} value packs two 8-bits values:
> >>>> +    \begin{itemize}
> >>>> +        \item Bits~\[15:8] (\emph{max\_slots}): the maximum number =
of supported
> >>>> +            crypto key slots.
> >>>> +        \item Bits~\[7:0] (\emph{slot\_offset}): an offset applied =
to slot numbering.
> >>>> +    \end{itemize}
> >>>> +\item \field{capability} value packs four 8-bits values:
> >>>> +    \begin{itemize}
> >>>> +        \item Bits~\[31:24]: crypto algorithm id.
> >>>> +        \item Bits~\[23:16]: mask of data unit size.
> >>>> +        \item Bits~\[15:8]: crypto key size.
> >>>> +        \item Bits~\[7:0]: unused.
> >>>> +    \end{itemize}
> >>>
> >>> Why are these fields packed? Configuration Space can have u8 fields.
> >>
> >> Given that &sect. 4.2.2.2 saying "For the device-specific configuratio=
n space,
> >> the driver MUST use 8 bit wide accesses for 8 bit wide fields, 16 bit =
wide
> >> and aligned accesses for 16 bit wide fields and 32 bit wide and aligned
> >> accesses for 32 and 64 bit wide fields.",  these fields are packed for=
 a
> >> efficient read from the configuration space.
> >=20
> > I see. I suggest mentioning this explicitly: "value packs two 8-bits
> > values to reduce the number of Configuration Space reads".
>=20
> ACK
>=20
> >=20
> >>>
> >>> These fields are not sufficiently documented. Where are the crypto
> >>> algorithm ids listed, etc?
> >>
> >> Can I reword it as the following?
> >=20
> > Yes, looks good in general. I have some comments below.
> >=20
> >>
> >>   \item Bits~\[31:24]: crypto algorithm identifiers.
> >>   The device SHALL support reporting and negotiating cryptographic
> >>   algorithms using the following algorithm identifiers:
> >>   \begin{lstlisting}
> >>       CRYPTO_ALG_AES_XTS              =3D 0x0
> >>       CRYPTO_ALG_BITLOCKER_AES_CBC    =3D 0x1
> >>       CRYPTO_ALG_AES_ECB              =3D 0x2
> >>       CRYPTO_ALG_ESSIV_AES_CBC        =3D 0x3
> >>   \end{lstlisting}
> >>   These identifiers abstract the underlying hardware crypto implementa=
tion
> >>   and MUST NOT assume any operating=E2=80=91system=E2=80=91specific da=
ta structures or
> >>   constants.
> >=20
> > (The MUST NOT part needs to be in a \devicenormative or \drivernormative
> > sections, but I think "MUST NOT" can be replaced with "does not" here
> > because it actually describes the design of the interface rather than
> > imposing requirements on device implementors.)
>=20
> ACK
>=20
> >=20
> >>   \item Bits~\[23:16]: mask of data unit size. When bit j in this field
> >>   (j=3D0......7)is set, a data unit size of 512*2^j bytes is slected.
> >=20
> > s/)is set/) is set/
> > s/slected/selected/
>=20
> ACK
>=20
> >=20
> > How is the data unit size used? Does it affect the allowed request sizes
> > of the device?
> >=20
> > For example, if the mask is 0x2, so that mean request sizes must be
> > multiples of 1 KiB?
>=20
> The data unit size is only used in the control flow of programing a key i=
nto
> ICE slot. It hasn't impact on the virtblk request size.
> For instance, if the mask is 0x2, so that mean the encryption granularity=
 is
> (2^1 * 512 =3D ) 1024 bytes. I.e. ICE hardware increase DUN (Date Unit Nu=
mber)
> per 1024 bytes to do encryption/decryption.

Okay.

>=20
> >=20
> > By the way, I'm not sure whether "j=3D0......7" mean that a mask value =
of
> > 0x2 has j=3D1 or j=3D6? Usually bits are numbered right-to-left from le=
ast
> > significant bit to most significant bit.
>=20
> A mask value of 0x2 has j=3D1. It comply with right-to-left number sequen=
ce.

Okay. It might be clearer to write "j=3D7......0" so the right-to-left
numbering is shown.

>=20
> >=20
> >>   \item Bits~\[15:8]: crypto key size identifiers.
> >>   \begin{lstlisting}
> >>       CRYPTO_KEY_SIZE_INVALID     =3D 0x0
> >>       CRYPTO_KEY_SIZE_128_BITS    =3D 0x1
> >>       CRYPTO_KEY_SIZE_192_BITS    =3D 0x2
> >>       CRYPTO_KEY_SIZE_256_BITS    =3D 0x3
> >>       CRYPTO_KEY_SIZE_512_BITS    =3D 0x4
> >>   \end{lstlisting}
> >>
> >>>
> >>> How can a device support multiple algorithms? I think Configuration
> >>> Space may not be flexible enough for this. You could introduce a
> >>> GET_CRYPTO_INFO request type that allows the driver to fetch arrays of
> >>> crypto algorithm characteristics.
> >>
> >> Virtio block driver need register crypto capability for request_queue =
of
> >> virtio block device. That means virtio block frontend need get crypto
> >> capability before virtio block device is ready. But the request can on=
ly
> >> be sent after the virtio block device is ready. Thus I think it's impo=
ssible
> >> to get such capabilities from the backend via a new request type, event
> >> though the hardware in the host may support a few algorithms (the actu=
al
> >> number of algorithms will change depending on the vendor manufacturer.=
).
> >> Thus I assume the host only configure and expose one hardware crypto
> >> capability to the virtual machine and virtio block frontend gets is
> >> through configuration space.
> >=20
> > The zoned storage feature also needs to use the virtqueues during driver
> > initialization in order to report zones. Here is the Linux virtio_blk.c
> > driver code:
> >=20
> > static int virtblk_probe(struct virtio_device *vdev)
> > {
> > ...
> >     virtio_device_ready(vdev);
> >=20
> >     /*
> >      * All steps that follow use the VQs therefore they need to be
> >      * placed after the virtio_device_ready() call above.
> >      */
> >     if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> >         (lim.features & BLK_FEAT_ZONED)) {
> >             err =3D blk_revalidate_disk_zones(vblk->disk);
> >             if (err)
> >                     goto out_cleanup_disk;
> >     }
> >=20
> >     err =3D device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups=
);
> >=20
> > Is it possible to call blk_crypto_register() between
> > virtio_device_read() and device_add_disk()?
>=20
> Thanks! Referring to zoned storage feature, if we use the virtqueues to
> get crypto capabilities, we need extend in_hdr in struct virtblk_req to
> add new fields for crypto capability. Like the following field
> crypto_append. Is it fine?=20
> we can not use a fixed-size array for crypto capabilities. Because the
> number of the capabilities differs for different OEMs and storage devices.
>=20
>   struct virtblk_req {
>       /* Out header */
>       struct virtio_blk_outhdr out_hdr;
>  =20
>       /* In header */
>       union {
>           u8 status;
>  =20
>           /*
>           * The zone append command has an extended in header.
>           * The status field in zone_append_in_hdr must always
>           * be the last byte.
>           */
>           struct {
>               __virtio64 sector;
>               u8 status;
>           } zone_append;
>=20
>           struct {
>               u8 num;
>               __virtio32 *capabilities;
>           } crypto_append;

This is not necessary. Take a look at virtblk_get_id(). It maps the
id_str buffer so the device can DMA the disk's serial number. The serial
number field is treated as a data read buffer, not as an in_hdr field.

Here is how it could work:

  struct virtio_blk_outhdr {
      .type =3D VIRTIO_BLK_T_GET_CRYPTO_PROFILES,
      .ioprio =3D 0,
      .sector =3D 0
  };

  struct virtio_blk_crypto_profile profiles[MAX_PROFILES];

  u8 status;

The device fills in profiles[], sets the used buffer element's len field
to the number of bytes filled in, and sets the status field to
VIRTIO_BLK_S_OK.

If profiles[] is too short, it sets status to BLK_S_IO_ERR. The driver
is expected to increase the size (e.g. double the buffer) and try again.
Alternatively there could be a num_crypto_profiles field in
Configuration Space.

(Many variations are possible. For example, virtio_blk_outhdr's sector
field could be an offset into the list of profiles, allowing the driver
to page through profiles without allocating a buffer large enough to
hold all profiles at a time. But that's probably unnecessary, so I would
keep it simple.)

>       } in_hdr;
>  =20
>       size_t in_hdr_len;
>  =20
>       struct sg_table sg_table;
>       struct scatterlist sg[];
>   };
>=20
> >=20
> >>
> >>>
> >>>> +\end{itemize}
> >>>> +
> >>>> +
> >>>>  \subsubsection{Legacy Interface: Device configuration layout}\label=
{sec:Device Types / Block Device / Device configuration layout / Legacy Int=
erface: Device configuration layout}
> >>>>  When using the legacy interface, transitional devices and drivers
> >>>>  MUST format the fields in struct virtio_blk_config
> >>>> @@ -278,6 +307,10 @@ \subsection{Device Initialization}\label{sec:De=
vice Types / Block Device / Devic
> >>>>      \field{zoned} can be read by the driver to determine the zone
> >>>>      characteristics of the device. All \field{zoned} fields are rea=
d-only.
> >>>> =20
> >>>> +\item If the VIRTIO_BLK_F_ICE feature is negotiated, the fields in
> >>>> +    \field{crypto} can be read by the driver to determine the inlin=
e crypto
> >>>> +    characteristics of the device. All \field{crypto} fields are re=
ad-only.
> >>>> +
> >>>>  \end{enumerate}
> >>>> =20
> >>>>  \drivernormative{\subsubsection}{Device Initialization}{Device Type=
s / Block Device / Device Initialization}
> >>>> @@ -317,6 +350,9 @@ \subsection{Device Initialization}\label{sec:Dev=
ice Types / Block Device / Devic
> >>>>      driver SHOULD ignore all other fields in \field{zoned}.
> >>>>  \end{itemize}
> >>>> =20
> >>>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver must=
 validate
> >>>> +    the max_slots in \field{slot_info} before the slot usage.
> >>>> +
> >>>>  \devicenormative{\subsubsection}{Device Initialization}{Device Type=
s / Block Device / Device Initialization}
> >>>> =20
> >>>>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
> >>>> @@ -402,6 +438,16 @@ \subsection{Device Initialization}\label{sec:De=
vice Types / Block Device / Devic
> >>>>  \item the device MUST initialize padding bytes \field{unused2} to 0.
> >>>>  \end{itemize}
> >>>> =20
> >>>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then the fields in \=
field{cryto}
> >>>
> >>> s/cryto/crypto/
> >>
> >> Thanks for the correction. Update it in new patch.
> >>
> >>>
> >>>> +struct in the configuration space MUST be set by the device.
> >>>> +\begin{itemize}
> >>>> +\item the \field{slot_info} field of \field{crypto} MUST be set by =
the device to a
> >>>> +    max_slots in the higher 8 bits and slot_offset in the lower 8 b=
its.
> >>>> +
> >>>> +\item the \field{capability} field of \field{crypto} MUST be set by=
 the device
> >>>> +    to a crypto capability read from the storage register.
> >>>> +\end{itemize}
> >>>> +
> >>>>  \subsubsection{Legacy Interface: Device Initialization}\label{sec:D=
evice Types / Block Device / Device Initialization / Legacy Interface: Devi=
ce Initialization}
> >>>> =20
> >>>>  Because legacy devices do not have FEATURES_OK, transitional devices
> >>>> @@ -436,6 +482,13 @@ \subsection{Device Operation}\label{sec:Device =
Types / Block Device / Device Ope
> >>>>          le32 type;
> >>>>          le32 reserved;
> >>>>          le64 sector;
> >>>> +        struct virtio_blk_crypto_payload {
> >>>> +            u8 slot;
> >>>> +            u8 activate;
> >>>> +            le16 reserved1;
> >>>> +            le32 reserved2;
> >>>> +            le64 data_unit_num;
> >>>> +        } payload;
> >>>>          u8 data[];
> >>>>          u8 status;
> >>>>  };
> >>>> @@ -463,6 +516,20 @@ \subsection{Device Operation}\label{sec:Device =
Types / Block Device / Device Ope
> >>>>  the read or write is to occur. This field is unused and set to 0 for
> >>>>  commands other than read, write and some zone operations.
> >>>> =20
> >>>> +The \field{payload} consists of the encryption information for curr=
ent
> >>>> +request. It need to be set by the driver only when the feature VIRT=
IO_BLK_F_ICE
> >>>> +is negotiated.
> >>>
> >>> "set" is ambiguous: does it meaning filling in the fields or does it
> >>> mean the fields are only present when VIRTIO_BLK_F_ICE is negotiated
> >>> (this distinction is important if other features add more fields after
> >>> payload in the future).
> >>>
> >>> The sentence could be reworded:
> >>>
> >>>   It is only present when the VIRTIO_BLK_F_ICE feature is negotiated =
and
> >>>   \field{type} is VIRTIO_BLK_T_IN or VIRTIO_BLK_T_OUT.
> >>>
> >>> (I'm not sure whether DISCARD, WRITE_ZEROES, or SECURE_ERASE also need
> >>> the payload field. It seems like GET_ID and GET_LIFETIME do not need =
the
> >>> payload field.)
> >>
> >> Accept and update it as the following.
> >>
> >>   It is only present when the VIRTIO_BLK_F_ICE feature is negotiated a=
nd
> >>   +\field{type} is VIRTIO_BLK_T_IN, VIRTIO_BLK_T_OUT or VIRTIO_BLK_T_F=
LUSH.
> >=20
> > Thanks.
> >=20
> >>
> >>>
> >>>> +\begin{itemize}
> >>>> +\item The \field{slot} filed in \field{payload} indicates the ICE
> >>>
> >>> s/filed/field/
> >>
> >> Thanks for the correction. Update it in new patch.
> >>
> >>>
> >>>> +  (Inline Crypto Encryption) slot index where the key resides in.
> >>>
> >>> s/where the key resides in/where the key resides/
> >>
> >> Thanks for the correction. Update it in new patch.
> >>
> >>>
> >>>> +
> >>>> +\item The \field{activate} filed in \field{payload} implies this is=
 a
> >>>
> >>> s/filed/field/
> >>
> >> Thanks for the correction. Update it in new patch.
> >>
> >>>
> >>>> +  encryption request.
> >>>
> >>> Does "encryption" really mean just encryption or does it mean
> >>> encryption for writes and decryption for reads?
> >>
> >> Actually encryption request here means both encryption for writes and
> >> decryption for reads. Need I modify it as the following?
> >=20
> > If writing "encryption/decryption" is too tedious, maybe use the feature
> > name ("inline encryption"). That way it's clear we're talking about the
> > feature and not specifically about an encryption operation (vs a
> > decryption operation).
>=20
> ACK
>=20
> >=20
> >>
> >>   \item The \field{activate} field in \field{payload} implies this is a
> >>   encryption write request or decryption read request.
> >>
> >>>
> >>>> +
> >>>> +\item The \field{data_unit_num} filed in \field{payload} indicates =
the
> >>>
> >>> s/filed/field/
> >>
> >> Thanks for the correction. Update it in new patch.
> >>
> >>>
> >>>> +  starting block of the request.
> >>>> +\end{itemize}
> >>>> +
> >>>>  VIRTIO_BLK_T_IN requests populate \field{data} with the contents of=
 sectors
> >>>>  read from the block device (in multiples of 512 bytes).  VIRTIO_BLK=
_T_OUT
> >>>>  requests write the contents of \field{data} to the block device (in=
 multiples
> >>>> @@ -912,6 +979,8 @@ \subsection{Device Operation}\label{sec:Device T=
ypes / Block Device / Device Ope
> >>>>  successfully, failed, or were processed by the device at all if the=
 request
> >>>>  failed with VIRTIO_BLK_S_IOERR.
> >>>> =20
> >>>> +A driver MUST set \field{activate} to 0 for a non VIRTIO_BLK_F_ICE =
request.
> >>>
> >>> Please explicitly list request types where the payload field is prese=
nt
> >>> and where activate is optional.
> >>
> >> How about adding the following supplement?
> >>
> >>   \begin{itemize}
> >>   \item only when the block request contains crypto context and the re=
quest type
> >=20
> > I'm not sure what "when the block request contains crypto context"
> > means. Is that the same as "when VIRTIO_BLK_F_ICE has been negotiated"?
>=20
> No, crypto context means bio_crypt_ctx in BIO struct.
>   struct bio {
>   ...
>   #ifdef CONFIG_BLK_INLINE_ENCRYPTION
> 	  struct bio_crypt_ctx	*bi_crypt_context;
>   #endif
>   ...
>   }
>=20
> When VIRTIO_BLK_F_ICE has been negotiated, virtio block backend receives =
crypto
> payload from virtio block frontend, and the crypto payload, together with=
 I/O
> transaction, is sent to block layer of the host finally. The crypto paylo=
ad is
> used to construct the bio_crypt_ctx filed of BIO.

Is that equivalent to struct virtio_blk_crypto_payload in this patch? If
yes, then I suggest only talking about the payload or slots - concepts
that are part of the virtio-blk inline crypto interface - instead of
Linux's bio_crypt_ctx.

If that's not possible, then the crypto context needs to be defined in
the spec so that readers know what it means.

>=20
> >=20
> >>       is one of VIRTIO_BLK_T_IN, VIRTIO_BLK_T_OUT and VIRTIO_BLK_T_FLU=
SH,
> >>       \field{activate} MUST be set to 1.
> >>
> >>   \item \field{activate} should be set to 0 for all the other cases.
> >>   \end{itemize}
> >>
> >>>
> >>>> +
> >>>>  The following requirements only apply if the VIRTIO_BLK_F_ZONED fea=
ture is
> >>>>  negotiated.
> >>>> =20
> >>>> --=20
> >>>> 2.34.1
> >>>>
> >>>>
> >>
>=20

--hw3vcwHDvi5Lr37U
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmCCYkACgkQnKSrs4Gr
c8in2gf+NTkFRor+124N18LOj3a0HGkbc47WXERUsxP/iSpNEYaR082u8xroe4nh
vrftFlYh4396SzpaB/4v+XxIjP5TmWHboX40JqmCuNUCGcbtvc6Wx5VukJdNe0Yo
gXfcweXGxNuQbBy7mgEnFhWk1TEQ8C/emUTu6PLG3XXk1FGyzaQC74YxsDwGFLBI
v2F8Gq7v8Q02inIsac5VQR1nWmaDfLWsyiiX81qOSzVNtUVQdVEABRIBEoEAB5vE
jWDcQGYtpIsIJTdRx82gn4KGlAD+Dgnb+Q6BLGmx2plqBm/jQse1Q63M8fCJsRQi
SwmSrWXuqR4QtvoGQGWEO4ekD6k57g==
=j/Bw
-----END PGP SIGNATURE-----

--hw3vcwHDvi5Lr37U--

