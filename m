Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF73625A359
	for <virtio-dev@lists.linux.dev>; Mon,  2 Feb 2026 15:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770047791; cv=none; b=gt9QFLMdtimgRhc8lbAbBtX75r2DPoaH+8U8L6pxJhtamfTk0EgFIMI86jMvCqHIO0Wkts6y+cBwJolt9WOa4oVrmGnKFfpjAu/8ON1doTDcmWjh+nFsKhfJ5Yh+PqwjTgZ3fqgV4PHJ5hIaOvnQzH1z9h9rUAlzJV0k+94mHRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770047791; c=relaxed/simple;
	bh=57599ZrJ/iNvkxAMiQPBmGTwN/v4LIV+V4+Ibi/qdsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nejAs7zK3yPzboynljYk8cjWVzwW/VQIkYGIaAEmHVdkoMuE0rCJ3gQKZVpod9ZV6i4Hjq//lszvaQxfJhRDm+kcSBRCt9qAnrfjm52y3iTrbBQx7jrodze9aiJrEr4+eMprBBmyX7AvtiDbZ5plmRAnv9zaeMrgHgaKaOzl4JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B3Bn8Cbp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B3Bn8Cbp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770047788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cEOad5ZJIaxl00hPhYx12ehWgXu3r67Uy0sZaYxnvZY=;
	b=B3Bn8CbpSb4V2CENNqnFYi58se9FUWukcPyVDvI8TTtX14ABIgPU6rYe3Ga9m6uDfJ7sX0
	OwyRgZ04Ug39Ve1+ugk2z175y0vwvWdmiQZmYUgNTgQJeSFJ9/ay+YMxKce2H6sp+CIPao
	zb57AfC5JWktMkjh+twR/9noPqXA8EU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-zzzGi5EnP4mCkV89M7xXBQ-1; Mon,
 02 Feb 2026 10:56:24 -0500
X-MC-Unique: zzzGi5EnP4mCkV89M7xXBQ-1
X-Mimecast-MFC-AGG-ID: zzzGi5EnP4mCkV89M7xXBQ_1770047784
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D4D1F180045C;
	Mon,  2 Feb 2026 15:56:23 +0000 (UTC)
Received: from localhost (unknown [10.2.16.105])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 81EBB1956053;
	Mon,  2 Feb 2026 15:56:23 +0000 (UTC)
Date: Mon, 2 Feb 2026 10:56:22 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Linlin Zhang <quic_linlzhan@quicinc.com>
Cc: virtio-dev@lists.linux.dev, quic_dshaikhu@quicinc.com
Subject: Re: [PATCH v1] virtio-blk: Add inline encryption support
Message-ID: <20260202155622.GA405548@fedora>
References: <20260127141432.2617357-1-quic_linlzhan@quicinc.com>
 <20260127142032.2619551-1-quic_linlzhan@quicinc.com>
 <20260127210951.GA96301@fedora>
 <b95cf6c4-db73-49e4-969e-fa7735a07527@quicinc.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VQwHT0qGWBSk3doP"
Content-Disposition: inline
In-Reply-To: <b95cf6c4-db73-49e4-969e-fa7735a07527@quicinc.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


--VQwHT0qGWBSk3doP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 30, 2026 at 06:23:55PM +0800, Linlin Zhang wrote:
> Thank you for the review. I=E2=80=99ve added some clarifications and pote=
ntial updates.
> Could you please take another look before I send a new patch?
>=20
> On 1/28/2026 5:09 AM, Stefan Hajnoczi wrote:
> > On Tue, Jan 27, 2026 at 10:20:32PM +0800, Linlin Zhang wrote:
> >> From: linlzhan <quic_linlzhan@quicinc.com>
> >>
> >> Inline encryption on virtio block can only be supported when
> >> the new feature bit VIRTIO_BLK_F_ICE is negotiated.
> >>
> >> Extend struct virtio_blk_config and struct virtio_blk_req,
> >> so that crypto capabilities can be got in the frontend and
> >> encryption metadata can be sent to the backend, together with
> >> each I/O transaction.
> >=20
> > This looks like a Self-Encrypting Drives feature along the lines of TCG
> > Opal:
> > https://en.wikipedia.org/wiki/Opal_Storage_Specification
> >=20
> > Would it make sense to implement TCG Opal instead of defining a new
> > interface? That would make this more familiar to users and simplify
> > integration into existing tools like sedutil and cryptsetup (e.g. by
> > supporting the <linux/sed-opal.h> ioctl interface).
>=20
> This patch is for the FBE (File Based Encryption) support on UFS/EMMC
> storage with ICE (Inline Crypto Engine) enabled. TCG Opal is only applica=
ble
> to SED (self-encrypting drives), not applicable to ICE (Inline Crypto Eng=
ine).
>=20
> In Automotive or Embedded scenario, UFS/EMMC generally is used. The disk
> encryption on them is supported by the ICE pipeline of SOC, rather SSD
> controller, so we couldn't use TCG Opal here.

Okay. Is there a specification that this interface needs to comply with?

If not, you can include a link to the Linux inline encryption
documentation in the commit description:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Doc=
umentation/block/inline-encryption.rst

Having a reference will will help the discussion. That way we can be
confident the VIRTIO spec changes will be widely useful beyond a single
use case and easy to implement in drivers because they follow an
existing interface.

>=20
> >=20
> >> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/238
> >>
> >> Change-Id: Ic23b2137e5d9a599d826e06c279f1b614d79abdf
> >> Signed-off-by: linlzhan <quic_linlzhan@quicinc.com>
> >> ---
> >>  device-types/blk/description.tex | 69 ++++++++++++++++++++++++++++++++
> >>  1 file changed, 69 insertions(+)
> >>
> >> diff --git a/device-types/blk/description.tex b/device-types/blk/descr=
iption.tex
> >> index 2712ada..23d8dc0 100644
> >> --- a/device-types/blk/description.tex
> >> +++ b/device-types/blk/description.tex
> >> @@ -66,6 +66,11 @@ \subsection{Feature bits}\label{sec:Device Types / =
Block Device / Feature bits}
> >>  	(ZNS). For brevity, these standard documents are referred as "ZBD st=
andards"
> >>  	from this point on in the text.
> >> =20
> >> +\item[VIRTIO_BLK_F_ICE(22)] Inline Crypto Extensions are supported. W=
hen this
> >> +     is negotiated, the device exposes crypto characteristics in conf=
iguration
> >> +     space and the driver SHALL provide an extended request header co=
ntaining a
> >=20
> > SHALL, MUST, MAY, etc are only used in the normative sections of the
> > spec.
> >=20
> > Why "SHALL"? Does this mean the device must be prepared to receive
> > requests without the payload field when VIRTIO_BLK_F_ICE is negotiated?
> > How should the device behave in that case: fail the request or perform
> > I/O without crypto?
>=20
> This section - 5.2.3 Feature bits - is a normative section.

\section{Block Device}\label{sec:Device Types / Block Device}
=2E..
\subsection{Feature bits}\label{sec:Device Types / Block Device / Feature b=
its}

No, this is a non-normative section. The normative sections are the
"Device Requirements" (\devicenormative) and "Driver Requirements"
(\drivernormative) sections.

>=20
> What's expected for VIRTIO_BLK_F_ICE feature bit is that configuration sp=
ace
> must be prepared with the exposed crypto characteristics and the virtio b=
lock
> frontend must sent a virtblk request with encryption metadata packed into
> when VIRTIO_BLK_F_ICE is negotiated and hardware crypto is supported.
>
> By replacing 'SHALL' with 'MUST' here, Is the following rewording fine?
>=20
>   Inline Crypto Extensions are supported. When this is negotiated, the de=
vice MUST
>   expose crypto characteristics in configuration space and the driver MUS=
T provide
>   an extended request header containing a crypto payload for block I/O if=
 the
>   hardware supports inline crypto. If this feature bit is negotiated, but=
 hardware
>   inline crypto doesn't support, the device SHOULD perform I/O without cr=
ypto.
>=20
> I'll add hw_enabled (type: u8) to virtio_blk_crypto_characteristics to in=
dicate
> whether the host supports hardware inline encryption.

I still have a question about this: why would a device advertise
VIRTIO_BLK_F_ICE but report hw_enabled =3D 0? I'm not sure how this is
functionally different from a device that does not report
VIRTIO_BLK_F_ICE. It seems simpler for devices to only advertise
VIRTIO_BLK_F_ICE when they support inline encryption.

> >=20
> >> +     crypto payload for block I/O.
> >> +
> >>  \end{description}
> >> =20
> >>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types=
 / Block Device / Feature bits / Legacy Interface: Feature bits}
> >> @@ -128,6 +133,11 @@ \subsection{Device configuration layout}\label{se=
c:Device Types / Block Device /
> >>                  u8 model;
> >>                  u8 unused2[3];
> >>          } zoned;
> >> +        struct virtio_blk_crypto_characteristics {
> >> +                __virtio16 slot_info;
> >> +                __virtio16 reserved;
> >> +                __virtio32 capability;
> >> +        } crypto;
> >>  };
> >>  \end{lstlisting}
> >> =20
> >> @@ -215,6 +225,25 @@ \subsection{Device configuration layout}\label{se=
c:Device Types / Block Device /
> >>  terminated by the device with a "zone resources exceeded" error as de=
fined for
> >>  specific commands later.
> >> =20
> >> +If the VIRTIO_BLK_F_ICE feature is negotiated, then in
> >> +\field{virtio_blk_crypto_characteristics},
> >> +\begin{itemize}
> >> +\item \field{slot_info} value packs two 8-bits values:
> >> +    \begin{itemize}
> >> +        \item Bits~\[15:8] (\emph{max\_slots}): the maximum number of=
 supported
> >> +            crypto key slots.
> >> +        \item Bits~\[7:0] (\emph{slot\_offset}): an offset applied to=
 slot numbering.
> >> +    \end{itemize}
> >> +\item \field{capability} value packs four 8-bits values:
> >> +    \begin{itemize}
> >> +        \item Bits~\[31:24]: crypto algorithm id.
> >> +        \item Bits~\[23:16]: mask of data unit size.
> >> +        \item Bits~\[15:8]: crypto key size.
> >> +        \item Bits~\[7:0]: unused.
> >> +    \end{itemize}
> >=20
> > Why are these fields packed? Configuration Space can have u8 fields.
>=20
> Given that &sect. 4.2.2.2 saying "For the device-specific configuration s=
pace,
> the driver MUST use 8 bit wide accesses for 8 bit wide fields, 16 bit wide
> and aligned accesses for 16 bit wide fields and 32 bit wide and aligned
> accesses for 32 and 64 bit wide fields.",  these fields are packed for a
> efficient read from the configuration space.

I see. I suggest mentioning this explicitly: "value packs two 8-bits
values to reduce the number of Configuration Space reads".

> >=20
> > These fields are not sufficiently documented. Where are the crypto
> > algorithm ids listed, etc?
>=20
> Can I reword it as the following?

Yes, looks good in general. I have some comments below.

>=20
>   \item Bits~\[31:24]: crypto algorithm identifiers.
>   The device SHALL support reporting and negotiating cryptographic
>   algorithms using the following algorithm identifiers:
>   \begin{lstlisting}
>       CRYPTO_ALG_AES_XTS              =3D 0x0
>       CRYPTO_ALG_BITLOCKER_AES_CBC    =3D 0x1
>       CRYPTO_ALG_AES_ECB              =3D 0x2
>       CRYPTO_ALG_ESSIV_AES_CBC        =3D 0x3
>   \end{lstlisting}
>   These identifiers abstract the underlying hardware crypto implementation
>   and MUST NOT assume any operating=E2=80=91system=E2=80=91specific data =
structures or
>   constants.

(The MUST NOT part needs to be in a \devicenormative or \drivernormative
sections, but I think "MUST NOT" can be replaced with "does not" here
because it actually describes the design of the interface rather than
imposing requirements on device implementors.)

>   \item Bits~\[23:16]: mask of data unit size. When bit j in this field
>   (j=3D0......7)is set, a data unit size of 512*2^j bytes is slected.

s/)is set/) is set/
s/slected/selected/

How is the data unit size used? Does it affect the allowed request sizes
of the device?

For example, if the mask is 0x2, so that mean request sizes must be
multiples of 1 KiB?

By the way, I'm not sure whether "j=3D0......7" mean that a mask value of
0x2 has j=3D1 or j=3D6? Usually bits are numbered right-to-left from least
significant bit to most significant bit.

>   \item Bits~\[15:8]: crypto key size identifiers.
>   \begin{lstlisting}
>       CRYPTO_KEY_SIZE_INVALID     =3D 0x0
>       CRYPTO_KEY_SIZE_128_BITS    =3D 0x1
>       CRYPTO_KEY_SIZE_192_BITS    =3D 0x2
>       CRYPTO_KEY_SIZE_256_BITS    =3D 0x3
>       CRYPTO_KEY_SIZE_512_BITS    =3D 0x4
>   \end{lstlisting}
>=20
> >=20
> > How can a device support multiple algorithms? I think Configuration
> > Space may not be flexible enough for this. You could introduce a
> > GET_CRYPTO_INFO request type that allows the driver to fetch arrays of
> > crypto algorithm characteristics.
>=20
> Virtio block driver need register crypto capability for request_queue of
> virtio block device. That means virtio block frontend need get crypto
> capability before virtio block device is ready. But the request can only
> be sent after the virtio block device is ready. Thus I think it's impossi=
ble
> to get such capabilities from the backend via a new request type, event
> though the hardware in the host may support a few algorithms (the actual
> number of algorithms will change depending on the vendor manufacturer.).
> Thus I assume the host only configure and expose one hardware crypto
> capability to the virtual machine and virtio block frontend gets is
> through configuration space.

The zoned storage feature also needs to use the virtqueues during driver
initialization in order to report zones. Here is the Linux virtio_blk.c
driver code:

static int virtblk_probe(struct virtio_device *vdev)
{
=2E..
    virtio_device_ready(vdev);

    /*
     * All steps that follow use the VQs therefore they need to be
     * placed after the virtio_device_ready() call above.
     */
    if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
        (lim.features & BLK_FEAT_ZONED)) {
            err =3D blk_revalidate_disk_zones(vblk->disk);
            if (err)
                    goto out_cleanup_disk;
    }

    err =3D device_add_disk(&vdev->dev, vblk->disk, virtblk_attr_groups);

Is it possible to call blk_crypto_register() between
virtio_device_read() and device_add_disk()?

>=20
> >=20
> >> +\end{itemize}
> >> +
> >> +
> >>  \subsubsection{Legacy Interface: Device configuration layout}\label{s=
ec:Device Types / Block Device / Device configuration layout / Legacy Inter=
face: Device configuration layout}
> >>  When using the legacy interface, transitional devices and drivers
> >>  MUST format the fields in struct virtio_blk_config
> >> @@ -278,6 +307,10 @@ \subsection{Device Initialization}\label{sec:Devi=
ce Types / Block Device / Devic
> >>      \field{zoned} can be read by the driver to determine the zone
> >>      characteristics of the device. All \field{zoned} fields are read-=
only.
> >> =20
> >> +\item If the VIRTIO_BLK_F_ICE feature is negotiated, the fields in
> >> +    \field{crypto} can be read by the driver to determine the inline =
crypto
> >> +    characteristics of the device. All \field{crypto} fields are read=
-only.
> >> +
> >>  \end{enumerate}
> >> =20
> >>  \drivernormative{\subsubsection}{Device Initialization}{Device Types =
/ Block Device / Device Initialization}
> >> @@ -317,6 +350,9 @@ \subsection{Device Initialization}\label{sec:Devic=
e Types / Block Device / Devic
> >>      driver SHOULD ignore all other fields in \field{zoned}.
> >>  \end{itemize}
> >> =20
> >> +If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver must v=
alidate
> >> +    the max_slots in \field{slot_info} before the slot usage.
> >> +
> >>  \devicenormative{\subsubsection}{Device Initialization}{Device Types =
/ Block Device / Device Initialization}
> >> =20
> >>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
> >> @@ -402,6 +438,16 @@ \subsection{Device Initialization}\label{sec:Devi=
ce Types / Block Device / Devic
> >>  \item the device MUST initialize padding bytes \field{unused2} to 0.
> >>  \end{itemize}
> >> =20
> >> +If the VIRTIO_BLK_F_ICE feature is negotiated, then the fields in \fi=
eld{cryto}
> >=20
> > s/cryto/crypto/
>=20
> Thanks for the correction. Update it in new patch.
>=20
> >=20
> >> +struct in the configuration space MUST be set by the device.
> >> +\begin{itemize}
> >> +\item the \field{slot_info} field of \field{crypto} MUST be set by th=
e device to a
> >> +    max_slots in the higher 8 bits and slot_offset in the lower 8 bit=
s.
> >> +
> >> +\item the \field{capability} field of \field{crypto} MUST be set by t=
he device
> >> +    to a crypto capability read from the storage register.
> >> +\end{itemize}
> >> +
> >>  \subsubsection{Legacy Interface: Device Initialization}\label{sec:Dev=
ice Types / Block Device / Device Initialization / Legacy Interface: Device=
 Initialization}
> >> =20
> >>  Because legacy devices do not have FEATURES_OK, transitional devices
> >> @@ -436,6 +482,13 @@ \subsection{Device Operation}\label{sec:Device Ty=
pes / Block Device / Device Ope
> >>          le32 type;
> >>          le32 reserved;
> >>          le64 sector;
> >> +        struct virtio_blk_crypto_payload {
> >> +            u8 slot;
> >> +            u8 activate;
> >> +            le16 reserved1;
> >> +            le32 reserved2;
> >> +            le64 data_unit_num;
> >> +        } payload;
> >>          u8 data[];
> >>          u8 status;
> >>  };
> >> @@ -463,6 +516,20 @@ \subsection{Device Operation}\label{sec:Device Ty=
pes / Block Device / Device Ope
> >>  the read or write is to occur. This field is unused and set to 0 for
> >>  commands other than read, write and some zone operations.
> >> =20
> >> +The \field{payload} consists of the encryption information for current
> >> +request. It need to be set by the driver only when the feature VIRTIO=
_BLK_F_ICE
> >> +is negotiated.
> >=20
> > "set" is ambiguous: does it meaning filling in the fields or does it
> > mean the fields are only present when VIRTIO_BLK_F_ICE is negotiated
> > (this distinction is important if other features add more fields after
> > payload in the future).
> >=20
> > The sentence could be reworded:
> >=20
> >   It is only present when the VIRTIO_BLK_F_ICE feature is negotiated and
> >   \field{type} is VIRTIO_BLK_T_IN or VIRTIO_BLK_T_OUT.
> >=20
> > (I'm not sure whether DISCARD, WRITE_ZEROES, or SECURE_ERASE also need
> > the payload field. It seems like GET_ID and GET_LIFETIME do not need the
> > payload field.)
>=20
> Accept and update it as the following.
>=20
>   It is only present when the VIRTIO_BLK_F_ICE feature is negotiated and
>   +\field{type} is VIRTIO_BLK_T_IN, VIRTIO_BLK_T_OUT or VIRTIO_BLK_T_FLUS=
H.

Thanks.

>=20
> >=20
> >> +\begin{itemize}
> >> +\item The \field{slot} filed in \field{payload} indicates the ICE
> >=20
> > s/filed/field/
>=20
> Thanks for the correction. Update it in new patch.
>=20
> >=20
> >> +  (Inline Crypto Encryption) slot index where the key resides in.
> >=20
> > s/where the key resides in/where the key resides/
>=20
> Thanks for the correction. Update it in new patch.
>=20
> >=20
> >> +
> >> +\item The \field{activate} filed in \field{payload} implies this is a
> >=20
> > s/filed/field/
>=20
> Thanks for the correction. Update it in new patch.
>=20
> >=20
> >> +  encryption request.
> >=20
> > Does "encryption" really mean just encryption or does it mean
> > encryption for writes and decryption for reads?
>=20
> Actually encryption request here means both encryption for writes and
> decryption for reads. Need I modify it as the following?

If writing "encryption/decryption" is too tedious, maybe use the feature
name ("inline encryption"). That way it's clear we're talking about the
feature and not specifically about an encryption operation (vs a
decryption operation).

>=20
>   \item The \field{activate} field in \field{payload} implies this is a
>   encryption write request or decryption read request.
>=20
> >=20
> >> +
> >> +\item The \field{data_unit_num} filed in \field{payload} indicates the
> >=20
> > s/filed/field/
>=20
> Thanks for the correction. Update it in new patch.
>=20
> >=20
> >> +  starting block of the request.
> >> +\end{itemize}
> >> +
> >>  VIRTIO_BLK_T_IN requests populate \field{data} with the contents of s=
ectors
> >>  read from the block device (in multiples of 512 bytes).  VIRTIO_BLK_T=
_OUT
> >>  requests write the contents of \field{data} to the block device (in m=
ultiples
> >> @@ -912,6 +979,8 @@ \subsection{Device Operation}\label{sec:Device Typ=
es / Block Device / Device Ope
> >>  successfully, failed, or were processed by the device at all if the r=
equest
> >>  failed with VIRTIO_BLK_S_IOERR.
> >> =20
> >> +A driver MUST set \field{activate} to 0 for a non VIRTIO_BLK_F_ICE re=
quest.
> >=20
> > Please explicitly list request types where the payload field is present
> > and where activate is optional.
>=20
> How about adding the following supplement?
>=20
>   \begin{itemize}
>   \item only when the block request contains crypto context and the reque=
st type

I'm not sure what "when the block request contains crypto context"
means. Is that the same as "when VIRTIO_BLK_F_ICE has been negotiated"?

>       is one of VIRTIO_BLK_T_IN, VIRTIO_BLK_T_OUT and VIRTIO_BLK_T_FLUSH,
>       \field{activate} MUST be set to 1.
>=20
>   \item \field{activate} should be set to 0 for all the other cases.
>   \end{itemize}
>=20
> >=20
> >> +
> >>  The following requirements only apply if the VIRTIO_BLK_F_ZONED featu=
re is
> >>  negotiated.
> >> =20
> >> --=20
> >> 2.34.1
> >>
> >>
>=20

--VQwHT0qGWBSk3doP
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmAySYACgkQnKSrs4Gr
c8jjjwgArqxkefBvc3BLv6I6BQBCs2LbGPM21IuCstbTKJO61HJezl6wOTojDciU
/rCTQcUyVXAvZAoBvi5/+DzRV6UC3KLu+tgXpT/Fw822lbeKlyl1Ncfqg8vsQp7C
1bOmcCCYQ2AFatoFbqrK9COGu/11V5A4cQxGmAbE5b5jirWAiAQOJDbpiaUwEJ43
MYweABcLTvlx0oAUks/xrY6hZMv6vfGlhJDQ8cTvmau9b/v6+z48CI91WhUTCy1k
hgOErYzF+icxHP/Ro1gqZ6XLr4RWebuqZXA7hcPDkXyK0jDJxyqnm447fAmevtiR
z0fAMb6+aUTFQwvFJPujI1hmV5NIbw==
=j4/b
-----END PGP SIGNATURE-----

--VQwHT0qGWBSk3doP--

