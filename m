Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3AD3EBF10
	for <virtio-dev@lists.linux.dev>; Wed, 18 Feb 2026 21:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771451626; cv=none; b=iN2pYbvOyhRIJMuSf2J0uLj4T5hahQI7QY/UnHM77bqbWzfwiDwc+7Qh5SuVnFEvGOnI+thSGaxsuvRCA0LH4x3OxfH66BdGMhnVAb7X5sqEc28rNQAZnNCxXmtvhGuALmiYITRf2SjK1v1lgR/QPgIfSxlJsbV0O+sJSO5Ou+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771451626; c=relaxed/simple;
	bh=sJdj9MbKz3iPcKiIg+jJqgb0LXDdXynYOkUlhlSFmbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faHWrN23Zwxojr33z12Zy0uzKvCrJVHy5l9d32peuDgRLy5mqLX8qR3d44ClrF4BL46JOsza/oM0fRMme+AvCM8M4qTFKuU2qduS0ZkfkbvmV7kTAgcJei9zh6tb/AjDqJp5DW1E1tkQlGHlWH8kKq9y+bieqkzAhL43b4BUfdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bpzSYEJV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpzSYEJV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771451623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tomjhteHSDZvVNwI3bm+q4Onkq9h10O29PKDXdSujWY=;
	b=bpzSYEJVQwUqM5v4LV8nrK0AanNKEknGrtIyFZhgNdjqZnjeYlndphhimZyFtHw2RbzjnW
	jvhFWVq+QBWmVhzLZL9ekBjJTjEKBkHLxERMWlrZv91spaZYS0a9nuGf+8lj5+mJDpBSVe
	+Wa67uK3f+0IxQheT6+eeRkWbbwWTk4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-AHI-FBT6P1eeNysamj9laQ-1; Wed,
 18 Feb 2026 16:53:39 -0500
X-MC-Unique: AHI-FBT6P1eeNysamj9laQ-1
X-Mimecast-MFC-AGG-ID: AHI-FBT6P1eeNysamj9laQ_1771451619
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BCE3B1955D4D;
	Wed, 18 Feb 2026 21:53:38 +0000 (UTC)
Received: from localhost (unknown [10.2.17.113])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 29B4D19560B7;
	Wed, 18 Feb 2026 21:53:38 +0000 (UTC)
Date: Wed, 18 Feb 2026 16:53:36 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
Cc: virtio-dev@lists.linux.dev, quic_dshaikhu@quicinc.com
Subject: Re: [PATCH v2 1/1] virtio-blk: Add inline encryption support
Message-ID: <20260218215336.GD605390@fedora>
References: <20260210083208.472824-1-linlin.zhang@oss.qualcomm.com>
 <20260210083208.472824-2-linlin.zhang@oss.qualcomm.com>
 <20260210211842.GA158755@fedora>
 <fa458358-90c8-408c-a860-8bfdb11658bb@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p2M5xaE3NudHUtCJ"
Content-Disposition: inline
In-Reply-To: <fa458358-90c8-408c-a860-8bfdb11658bb@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


--p2M5xaE3NudHUtCJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 14, 2026 at 03:22:21PM +0800, Linlin Zhang wrote:
>=20
>=20
> On 2/11/2026 5:18 AM, Stefan Hajnoczi wrote:
> > On Tue, Feb 10, 2026 at 12:32:08AM -0800, Linlin Zhang wrote:
> >> Inline encryption on virtio block can only be supported when
> >> the new feature bit VIRTIO_BLK_F_ICE is negotiated.
> >>
> >> Extend struct virtio_blk_config and struct virtio_blk_req,
> >> so that crypto capabilities can be got in the frontend and
> >> encryption metadata can be sent to the backend, together with
> >> each I/O transaction.
> >>
> >> About the inline encryption on UFS or eMMC storage, please
> >> refer to the Linux inline encryption documentation:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/block/inline-encryption.rst
> >>
> >> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/238
> >> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >> Signed-off-by: linlzhan <quic_linlzhan@quicinc.com>
> >> Signed-off-by: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
> >> ---
> >>  device-types/blk/description.tex | 110 ++++++++++++++++++++++++++++++-
> >>  1 file changed, 108 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/device-types/blk/description.tex b/device-types/blk/descr=
iption.tex
> >> index 2712ada..60f46af 100644
> >> --- a/device-types/blk/description.tex
> >> +++ b/device-types/blk/description.tex
> >> @@ -66,6 +66,11 @@ \subsection{Feature bits}\label{sec:Device Types / =
Block Device / Feature bits}
> >>  	(ZNS). For brevity, these standard documents are referred as "ZBD st=
andards"
> >>  	from this point on in the text.
> >> =20
> >> +\item[VIRTIO_BLK_F_ICE(22)] Inline Crypto Extensions are supported. O=
nly when this
> >> +     feature bit is negotiated, the device need expose crypto charact=
eristics in
> >> +     configuration space and the driver need provide an extended requ=
est header
> >> +     containing a crypto payload for block I/O.
> >=20
> > Most of the feature bit descriptions are brief and the details are
> > covered later in the spec. I suggest doing this here too:
> >=20
> >   \item[VIRTIO_BLK_F_ICE (22)] Device supports Inline Crypto Engine fun=
ctionality.
> >=20
> > I changed the name from Inline Crypto Extensions to Inline Crypto Engine
> > because that terminology is used in the Linux kernel. Web search results
> > also favor "inline crypto engine" over "inline crypto extensions". Are
> > you okay with "engine"?
> Thanks! ACK
>=20
> >=20
> >> +
> >>  \end{description}
> >> =20
> >>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types=
 / Block Device / Feature bits / Legacy Interface: Feature bits}
> >> @@ -128,6 +133,10 @@ \subsection{Device configuration layout}\label{se=
c:Device Types / Block Device /
> >>                  u8 model;
> >>                  u8 unused2[3];
> >>          } zoned;
> >> +        struct virtio_blk_crypto_characteristics {
> >> +                __virtio16 slot_info;
> >> +                __virtio16 reserved;
> >> +        } crypto;
> >>  };
> >>  \end{lstlisting}
> >> =20
> >> @@ -215,6 +224,18 @@ \subsection{Device configuration layout}\label{se=
c:Device Types / Block Device /
> >>  terminated by the device with a "zone resources exceeded" error as de=
fined for
> >>  specific commands later.
> >> =20
> >> +If the VIRTIO_BLK_F_ICE feature is negotiated, then in
> >> +\field{virtio_blk_crypto_characteristics},
> >> +\begin{itemize}
> >> +\item \field{slot_info} value packs two 8-bits values to reduce the n=
umber of
> >=20
> > 8-bits -> 8-bit
>=20
> ACK
>=20
> >=20
> >> +    Configuration Space reads.
> >> +    \begin{itemize}
> >> +        \item Bits~\[15:8] (\emph{max\_slots}): the maximum number of=
 supported
> >> +            crypto key slots.
> >> +        \item Bits~\[7:0] (\emph{slot\_offset}): an offset applied to=
 slot numbering.
> >=20
> > What is the purpose of slot_offset? This field is not used much in this
> > spec, maybe it can be removed?
> >=20
> > Does that mean only slots in the range [slot_offset:max_slots) are
> > available or does it mean that the range is
> > [slot_offset:slot_offset+max_slots)?
>=20
> Only slots within the range [slot_offset, slot_offset + max_slots) are ac=
cessible to the
> VM. The slot_offset specifies the base physical ICE slot allocated to the=
 VM and is used
> to translate a virtual slot index into a physical slot.
>=20
> Because the GVM programs and evicts keys directly=E2=80=94without host/PV=
M involvement=E2=80=94it must
> supply the resolved physical slot when invoking key operations in TrustZo=
ne or the Secure
> VM.

It's not clear to me how what you've described offers isolation between
the PVM and the GVM. What stops the GVM from using key slots outside the
range that has been assigned to it?

A few options for isolation come to mind:

1. Expose 2 separate virtio-blk devices, one of which is hidden from the
   GVM and only accessible to the PVM. The PVM can store its data on the
   hidden device.

2. Some kind of VIRTIO Admin queue Virtual Function approach where the
   PVM can instantiate a virtual function (a sub-device) that the GVM is
   allowed to access with isolation enforced by the device.

3. A single device could be used but the GVM cannot access it directly
   and needs to go through the PVM.

>=20
> >=20
> >> +    \end{itemize}
> >> +\end{itemize}
> >> +
> >>  \subsubsection{Legacy Interface: Device configuration layout}\label{s=
ec:Device Types / Block Device / Device configuration layout / Legacy Inter=
face: Device configuration layout}
> >>  When using the legacy interface, transitional devices and drivers
> >>  MUST format the fields in struct virtio_blk_config
> >> @@ -278,6 +299,10 @@ \subsection{Device Initialization}\label{sec:Devi=
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
> >> @@ -317,6 +342,9 @@ \subsection{Device Initialization}\label{sec:Devic=
e Types / Block Device / Devic
> >>      driver SHOULD ignore all other fields in \field{zoned}.
> >>  \end{itemize}
> >> =20
> >> +If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver MUST v=
alidate
> >> +    the max_slots in \field{slot_info} before the slot usage.
> >=20
> > I'm not sure how the driver is supposed to validate max_slots?
>=20
> It means the diver validate the virtual slot doesn't exceed the max_slots=
 before translating
> this virtual slot to a physical slot by using slot_offset.=20
>=20
> Can I rewrite it as the following?
>=20
>   If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver MUST val=
idate that
>   the virtual slot received from upper layer doesn't exceed the max_slots=
 in
>   \field{slot_info} before the slot usage.

The notion of an "upper layer" can be eliminated so that there is no
assumption about the software design in the driver:

  If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver MUST
  ensure that slot_offset <=3D \field{payload.slot} < slot_offset +
  max_slots, where slot_offset and max_slots are the values extracted
  from \field{crypto.slot_info} in configuration space.

>=20
> >=20
> >> +
> >>  \devicenormative{\subsubsection}{Device Initialization}{Device Types =
/ Block Device / Device Initialization}
> >> =20
> >>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
> >> @@ -402,6 +430,13 @@ \subsection{Device Initialization}\label{sec:Devi=
ce Types / Block Device / Devic
> >>  \item the device MUST initialize padding bytes \field{unused2} to 0.
> >>  \end{itemize}
> >> =20
> >> +If the VIRTIO_BLK_F_ICE feature is negotiated, then the fields in \fi=
eld{crypto}
> >> +struct in the configuration space MUST be set by the device.
> >> +\begin{itemize}
> >> +\item the \field{slot_info} field of \field{crypto} MUST be set by th=
e device to a
> >> +    max_slots in the higher 8 bits and slot_offset in the lower 8 bit=
s.
> >> +\end{itemize}
> >=20
> > There is no need for the \begin{itemize} here. It contains no new
> > information. The fields were already described in the configuration
> > space section and the previous sentence already said that the fields in
> > \field{crypto} must be set by the device.
>=20
> ACK, remove this \begin{itemize} here.
>=20
> >=20
> >> +
> >>  \subsubsection{Legacy Interface: Device Initialization}\label{sec:Dev=
ice Types / Block Device / Device Initialization / Legacy Interface: Device=
 Initialization}
> >> =20
> >>  Because legacy devices do not have FEATURES_OK, transitional devices
> >> @@ -436,6 +471,13 @@ \subsection{Device Operation}\label{sec:Device Ty=
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
> >=20
> > "payload" is a generic term. crypto_payload would be clearer.
> >=20
> > I wonder whether consistently calling this feature "ice" rather than
> > "crypto" would help in case self-encrypting drive or other cryptographic
> > functionality is added to virtio-blk in the future. That way the spec
> > items related to inline crypto engine functionality will be easy to
> > differentiate from other crypto functionality.
>=20
> Ok, to differentiate ICE and other cryptographic functionality, can I mod=
ify it as
>=20
>   struct virtio_blk_ice_payload {
>       u8 slot;
>       u8 activate;
>       le16 reserved1;
>       le32 reserved2;
>       le64 data_unit_num;
>   } ice_payload;

Looks good to me, thanks.

>=20
> >=20
> >>          u8 data[];
> >>          u8 status;
> >>  };
> >> @@ -445,8 +487,9 @@ \subsection{Device Operation}\label{sec:Device Typ=
es / Block Device / Device Ope
> >>  (VIRTIO_BLK_T_OUT), a discard (VIRTIO_BLK_T_DISCARD), a write zeroes
> >>  (VIRTIO_BLK_T_WRITE_ZEROES), a flush (VIRTIO_BLK_T_FLUSH), a get devi=
ce ID
> >>  string command (VIRTIO_BLK_T_GET_ID), a secure erase
> >> -(VIRTIO_BLK_T_SECURE_ERASE), or a get device lifetime command
> >> -(VIRTIO_BLK_T_GET_LIFETIME).
> >> +(VIRTIO_BLK_T_SECURE_ERASE), a get device lifetime command
> >> +(VIRTIO_BLK_T_GET_LIFETIME), or a get device crypto capabilities comm=
and
> >> +(VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES).
> >> =20
> >>  \begin{lstlisting}
> >>  #define VIRTIO_BLK_T_IN           0
> >> @@ -457,12 +500,27 @@ \subsection{Device Operation}\label{sec:Device T=
ypes / Block Device / Device Ope
> >>  #define VIRTIO_BLK_T_DISCARD      11
> >>  #define VIRTIO_BLK_T_WRITE_ZEROES 13
> >>  #define VIRTIO_BLK_T_SECURE_ERASE   14
> >> +#define VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES   27
> >=20
> > The Linux virtio_blk.c driver assumes that odd numbered constants have
> > data buffers that are read by the device, so you may run into a bug when
> > using 27.
> >=20
> > There is an informal convention to use even numbers for read requests
> > and odd numbers for write requests. It doesn't hurt to try to follow the
> > convention even though it's not strictly necessary.
> >=20
> > The Linux driver could be fixed when adding support for ICE, but 16 is
> > available and it's safest to use that.
>=20
> OK. Agree to following the convention. But 16, 18,20,22,24,26 are already=
 used by
> zone device. Seems 12 is available. Correct it to 12.
>=20
>  #define VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES   12

In that case I suggest using 28. I don't remember what 12 was used for
but there may be a historical reason for the gap.

>=20
> >=20
> >>  \end{lstlisting}
> >> =20
> >>  The \field{sector} number indicates the offset (multiplied by 512) wh=
ere
> >>  the read or write is to occur. This field is unused and set to 0 for
> >>  commands other than read, write and some zone operations.
> >> =20
> >> +The \field{payload} consists of the encryption information for current
> >> +request. It is only present when the VIRTIO_BLK_F_ICE feature is nego=
tiated and
> >> +\field{type} is VIRTIO_BLK_T_IN, VIRTIO_BLK_T_OUT or VIRTIO_BLK_T_FLU=
SH.
> >=20
> > TODO think about layout
>=20
> rewrite to the following
>=20
>   The \field{ice_payload} consists of the encryption information for curr=
ent
>   request. When VIRTIO_BLK_F_ICE is negotiated, the request header layout=
 becomes
>   that struct virtio_blk_outhdr includes \field{ice_payload} as a fixed-s=
ize
>   extension. For non-ICE requests (or types not using crypto), the driver=
 MUST
>   set \field{ice_payload} to 0 and device ignores them.

Sorry, the TODO was a comment to myself while writing my reply :).

I forgot to investigate. Basically the issue is that the spec must be
clear on whether:
1. A field is absent and fields that follow it are present in the struct
   layout when a condition is false (e.g. type is not VIRTIO_BLK_T_IN,
   VIRTIO_BLK_T_OUT, or VIRTIO_BLK_T_FLUSH).
or
2. A field is present but unused (zeroed) when a condition is false.

#2 is usually easier to implement in code because it avoids creating
many different struct layouts at runtime depending on conditions like
negotiated feature bits.

I was thinking that the ice fields should always be present but should
be zero when the feature bit is not negotiated or some other condition
(like the request type) is false. This way it will be much easier to add
additional fields later without worrying about struct layouts.

This is how configuration space already works: the offset of the zoned
field is not affected by whether the device advertises the
VIRTIO_BLK_F_WRITE_ZEROES feature bit, it just means that the earlier
write_zeroes_may_unmap field may be unused. This approach should
probably be used everywhere and the spec language should be careful to
communicate that the field is still present but zero when unused. It's
okay for the driver to provide a shorter struct that doesn't include the
last field(s) to the device when the feature bit is not negotiated
though.

>=20
> >=20
> >> +\begin{itemize}
> >> +\item The \field{slot} field in \field{payload} indicates the ICE
> >> +  (Inline Crypto Encryption) slot index where the key resides.
> >> +
> >> +\item The \field{activate} field in \field{payload} implies this is a
> >> +  inline encryption request.
> >> +
> >> +\item The \field{data_unit_num} field in \field{payload} indicates the
> >> +  starting block of the request.
> >=20
> > This is a block device, so the term "block" needs to be qualified to
> > avoid confusion. I guess this is the cryptography concept of a block
> > rather than the disk concept of a block. Please clarify this in the
> > text, maybe by explaining that the ICE handles data in fixed-size "data
> > units" instead of using the word "block".
> >=20
> > Also, can you explain the relationship between the data unit number and
> > the sector? In simple cases I imagine the data unit number would be the
> > sector. How is the driver supposed to pick or calculate the data unit
> > number?
>=20
> The data unit number is the starting IV for AES crypto in ICE hardware, i=
t's
> a stable value for I/O request targeting to same storage range. It can be=
 set
> to the file logic block number or the starting sector of BIO.=20

It sounds like the data unit number calculation is up to the driver
(from the device's perspective) and the important thing is that the same
data unit number will always be used when reading/writing the same
logical data location.

> The upper layer calculates it and passes it to virtio_blk driver in this =
patch.
> ICE uses the data unit number and data unit size (the granularity to use =
for
> en/decryption) to derive the next data unit number for the next cryptogra=
phy
> block. data unit number in ICE increase 1 per data unit size. For instanc=
e,
>   data unit number =3D 2048
>   data unit size =3D 1024 bytes
> For the first 1024 bytes of the transaction, ICE hardware encrypt the data
> with IV equal to 2048.
> For the second 1024 bytes of the transaction, ICE hardware encrypt the da=
ta
> with IV equal to (2048+1=3D)2049.
>=20
> Rewrite it as bellow.
>=20
>   \item The \field{data_unit_num} field in \field{ice_payload} indicates =
the
>   starting IV. It can be the file logic block number or the starting sect=
or
>   of BIO.

BIO is a Linux-specific concept, so it would be best to avoid it in the
VIRTIO spec.

  \item The \field{data_unit_num} field in \field{ice_payload} indicates
  the starting IV. In order to successfully encrypt/decrypt data this
  number must be the same for successive read and write operations to
  the same logical data location. The driver typically sets it to the
  file logical block number or the disk sector number.

>=20
> >=20
> >> +\end{itemize}
> >> +
> >>  VIRTIO_BLK_T_IN requests populate \field{data} with the contents of s=
ectors
> >>  read from the block device (in multiples of 512 bytes).  VIRTIO_BLK_T=
_OUT
> >>  requests write the contents of \field{data} to the block device (in m=
ultiples
> >> @@ -530,6 +588,47 @@ \subsection{Device Operation}\label{sec:Device Ty=
pes / Block Device / Device Ope
> >>  The \field{device_lifetime_est_typ_b} refers to wear of MLC cells and=
 is provided
> >>  with the same semantics as \field{device_lifetime_est_typ_a}.
> >> =20
> >> +VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests fetch the storage hardw=
are crypto
> >> +capabilities into \field{data}. And the \field{data} is of the form
> >=20
> > How does VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES behave when data[] is too
> > small to fit all the device's crypto capabilities?
>=20
> Add a new field capability_num to the Configuration space header. The tot=
al size of
> \field{data} shall be computed as:
>   data_size=3Dcapability_num=C3=97capability_size
> where capability_size is the size (in bytes) of one capability structure.=
 Therefore, \field{data} contains exactly capability_num contiguous capabil=
ity entries, each of length capability_size.
> Add a capability_num field in Configuration space. So it use size per cap=
ability
> multiply capability_num to define the size of \field{data}.
>=20
> Rewrite it as the following.
>=20
>   VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests fetch the storage hardwar=
e crypto
>   capabilities into \field{data}. The crypto capabilities is a zero-padde=
d array
>   up to (\field{capability_num}=C3=97capability_size) bytes long, where c=
apability_size
>   is the size (in bytes) of one capability structure which is in form of
>  =20
>   \begin{lstlisting}
>     struct virtio_blk_crypto_cap {
>         u8 alg;
>         u8 data_unit_size;
>         u8 key_size;
>         u8 reserved;
>     };
>   \end{lstlisting}
>  =20
>   \begin{itemize}
>       \item The \field{alg} implies crypto algorithm identifiers.
>       The device supports reporting and negotiating cryptographic algorit=
hms
>       using the following algorithm identifiers:
>       \begin{lstlisting}
>           CRYPTO_ALG_AES_XTS              =3D 0x0
>           CRYPTO_ALG_BITLOCKER_AES_CBC    =3D 0x1
>           CRYPTO_ALG_AES_ECB              =3D 0x2
>           CRYPTO_ALG_ESSIV_AES_CBC        =3D 0x3
>       \end{lstlisting}
>       These identifiers abstract the underlying hardware crypto implement=
ation
>       and does not assume any operating=E2=80=91system=E2=80=91specific d=
ata structures or
>       constants.
>       \item The \field{data_unit_size} implies the mask of data unit size=
=2E When
>       bit j in this field (j=3D7......0) is set, a data unit size of 512*=
2^j bytes
>       is selected.
>       \item The \field{key_size} is the crypto key size identifiers.
>       \begin{lstlisting}
>           CRYPTO_KEY_SIZE_INVALID     =3D 0x0
>           CRYPTO_KEY_SIZE_128_BITS    =3D 0x1
>           CRYPTO_KEY_SIZE_192_BITS    =3D 0x2
>           CRYPTO_KEY_SIZE_256_BITS    =3D 0x3
>           CRYPTO_KEY_SIZE_512_BITS    =3D 0x4
>       \end{lstlisting}
>       \item The \field{reserved} is unused.
>   \end{itemize}
>  =20
>   If the \field{data} is too short, it sets status to BLK_S_IO_ERR.

Looks good. In the final sentence I suggest changing "it" to "the
device" for clarity.

>=20
> >=20
> >> +
> >> +\begin{lstlisting}
> >> +struct virtio_blk_crypto_caps {
> >> +  u8 size;
> >> +  le32 crypto_capabilities[];
> >> +};
> >> +\end{lstlisting}
> >> +
> >> +The \field{size} specifies the size of array \field{crypto_capabiliti=
es}.
> >=20
> > "number of elements" would be clearer than "size of array" because the
> > unit (bytes vs array elements) is ambiguous.
> >=20
> > The size field is not necessary since Used Ring descriptors contain
> > (struct virtq_used_elem in the spec) a len field indicating how many
> > bytes were written by the device.
>=20
> Remove virtio_blk_crypto_caps in above modification.
>=20
> >=20
> >> +The \field{crypto_capabilities} indicates the crypto capabilities sup=
ported by the
> >> +hardware storage for inline encryption.
> >> +
> >> +A crypto capability packs four 8-bits values:
> >> +\begin{itemize}
> >> +    \item Bits~\[31:24]: crypto algorithm identifiers.
> >> +    The device supports reporting and negotiating cryptographic algor=
ithms
> >> +    using the following algorithm identifiers:
> >> +    \begin{lstlisting}
> >> +        CRYPTO_ALG_AES_XTS              =3D 0x0
> >> +        CRYPTO_ALG_BITLOCKER_AES_CBC    =3D 0x1
> >> +        CRYPTO_ALG_AES_ECB              =3D 0x2
> >> +        CRYPTO_ALG_ESSIV_AES_CBC        =3D 0x3
> >> +    \end{lstlisting}
> >> +    These identifiers abstract the underlying hardware crypto impleme=
ntation
> >> +    and does not assume any operating=E2=80=91system=E2=80=91specific=
 data structures or
> >> +    constants.
> >> +    \item Bits~\[23:16]: mask of data unit size. When bit j in this f=
ield
> >> +    (j=3D7......0) is set, a data unit size of 512*2^j bytes is selec=
ted.
> >=20
> > Is only one bit ever set in the mask? If so, then maybe just express j
> > as an 8-bit unsigned integer (i.e. the exponent in 512*2^j) instead of
> > as a bit mask. It's simpler and increases the range for j.
>=20
> Yes, it's encoded in one-hot encoding. If j is expressed as an 8-bit unsi=
gned integer,
> it will confused the reader that more than one bit can be set in the mask=
 of data unit
> size. right?=20

If the field is called the data unit size exponent (data_unit_size_exp)
then there is no confusion. I agree that calling it a mask would be
confusing.

>=20
> >=20
> >> +    \item Bits~\[15:8]: crypto key size identifiers.
> >> +    \begin{lstlisting}
> >> +        CRYPTO_KEY_SIZE_INVALID     =3D 0x0
> >> +        CRYPTO_KEY_SIZE_128_BITS    =3D 0x1
> >> +        CRYPTO_KEY_SIZE_192_BITS    =3D 0x2
> >> +        CRYPTO_KEY_SIZE_256_BITS    =3D 0x3
> >> +        CRYPTO_KEY_SIZE_512_BITS    =3D 0x4
> >> +    \end{lstlisting}
> >> +    \item Bits~\[7:0]: unused.
> >> +\end{itemize}
> >=20
> > A struct would be more natural here (the rest of the VIRTIO
> > specification rarely packs fields into an integer):
> >=20
> >   struct virtio_blk_crypto_cap {
> >       u8 alg;
> >       u8 data_unit_size;
> >       u8 key_size;
> >       u8 reserved;
> >   };
>=20
> ACK, see above rewrite statement.
>=20
> >=20
> > By the way, Linux seems to call this a "profile" rather than a
> > "capability". Do you want to use the same name as Linux for consistency?
>=20
> blk-crypto-profile is the keyslot manager which manage the usage of keysl=
ot and
> also checks if the key configuration set by upper layer can be supported =
by the
> ICE hardware. While the capability aims to illustrate the capability prov=
ided by
> the ICE hardware. What we expected is the capability used to initialized
> blk-crypto-profile in Guest VM.

I see.

>=20
> >=20
> >> +
> >>  The final \field{status} byte is written by the device: either
> >>  VIRTIO_BLK_S_OK for success, VIRTIO_BLK_S_IOERR for device or driver
> >>  error or VIRTIO_BLK_S_UNSUPP for a request unsupported by device:
> >> @@ -912,6 +1011,13 @@ \subsection{Device Operation}\label{sec:Device T=
ypes / Block Device / Device Ope
> >>  successfully, failed, or were processed by the device at all if the r=
equest
> >>  failed with VIRTIO_BLK_S_IOERR.
> >> =20
> >> +The length of \field{data} MUST be a multiple of 4 bytes plus 1 for
> >> +VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests.
> >> +
> >> +A driver MUST set \field{activate} to 1 for VIRTIO_BLK_T_IN,VIRTIO_BL=
K_T_OUT,
> >> +    and VIRTIO_BLK_T_FLUSH requests that require inline encryption. F=
or other
> >> +    request types or when inline encryption is not required, it is se=
t to 0.
> >> +
> >>  The following requirements only apply if the VIRTIO_BLK_F_ZONED featu=
re is
> >>  negotiated.
> >=20
> > How does the driver assign a specific capability (algorithm, data unit
> > size, and key size tuple reported by
> > VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES) to a slot?
> >=20
> > How does the driver assign the key material for a slot?
>=20
> blk layer will initialize a blk_crypto_key based on the configuration rec=
eived from
> FS layer. This blk_crypto_key contains expected algorithm, data unit size=
 and key size expected
> by the upper layer. When submit_bio, blk_mq tries to program the key incl=
uded in blk_crypto_key
> to the ICE hardware slot via blk_crypto_profile. During programming the k=
ey, it will compare=20
> the algorithm, data unit size and key size in blk_crypto_key with the cap=
ability exposed by ICE
> hardware.
>=20
> It will follow bellow flow to assign the key material for a slot.
>   blk_crypto_profile -> virtio_blk driver -> virtio_blk extention -> SCM =
driver -> TZ
>=20
> That means the driver only maintain the capability in RAM, use it when pr=
ogramming key.

I don't see an interface for programming the key in this spec patch. The
Linux block driver interface includes struct blk_crypto_ll_ops with
driver functions for programming keys. I expected this spec would add
operations to the virtio-blk device for implementing those functions?

Stefan

--p2M5xaE3NudHUtCJ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmWNOAACgkQnKSrs4Gr
c8h1Zwf/W6M65luhUIkyH4w9UHRR36H9MU9dmX5bmfeWhilwRLFWGYtoNT2oq8FD
HbOrNRZ+exQj0lont5xLcWib2eEslHyZWYqCOmfbkZ9cWaSZVabqJIquNbXwJ1wD
GOxTBBKA895b9c9koKRofTgDOIrkyyujEQaGFTm+s5Q09ufEuG2483sMEoOepUOO
DNBIvBIIIlE9MDZfe4xVeHW8/pNrxjZIIw565CWMDJHbcNBS2b8QpDNUWaZKzLVd
9zQaj3Gwq+vMnObiuwPW9lb56jI7hRIxn9da555pZUumovDWBLnlSh4mbcP9A2Zi
vpkVICFNqij0Qb4WW6vcS9yUQ2XMiQ==
=LRt5
-----END PGP SIGNATURE-----

--p2M5xaE3NudHUtCJ--

