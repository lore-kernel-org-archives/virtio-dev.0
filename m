Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC37F22301
	for <virtio-dev@lists.linux.dev>; Wed, 25 Feb 2026 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772013314; cv=none; b=nHxnAuycO3vykheqbqIjjMxvzIOZZkJ+6HQQsKiBa/ZK7fd2Gr/bb3THXXT/434yZtDZ+4XlaH4qqNt1QYAUWCtK8ij7dnaZ/pCkn93U41evjTgT0XuhOqvHi2GMQBk6NTpyOvC0mR1ViroE6YCG8YDMiKTjr8K+VWr0RG3dJhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772013314; c=relaxed/simple;
	bh=S3TVKw3UU+3gpbxjqdCBdNCIUQJAU2CQxHaFlM//aaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R48JeUIfkZ1K00Z2Jyh37p4rJ6zE5shQSQn8lXqe2xC6sGc2iOrFbxKnuIctcA+s0SjbbgBf/CDC9+CyVoHy3IcIdJ857dGsffXTDH5sceEWPPnHiYDcu/1N6sZxkLr+gy5PkZO5bEE6MG4Wn2Zi6Jh/dte6mYeU+LxSjkPDLFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XwG4Puro; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XwG4Puro"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772013311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=H6J1cP/TbA220PTFUNUrvScA0+pKXg/MbRC4bEG4eYo=;
	b=XwG4PuroQgLmjl6HOWoUTI+7cbSnxbARYqL9UtLTouiwWLAE181ur+wQatuUWgSfCoME9w
	xJOnNgKB2uGsQ6oC4kf+flZb7j5uDl+USwnf70ZXbs8gcfQuNg2NmsKEWvL8ZvwaKfvcBs
	yzvhgUqbbdUWtKpC3kKQg862yGNLbgs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-O3qh2fa4MeW6e75graxdHA-1; Wed,
 25 Feb 2026 04:55:07 -0500
X-MC-Unique: O3qh2fa4MeW6e75graxdHA-1
X-Mimecast-MFC-AGG-ID: O3qh2fa4MeW6e75graxdHA_1772013306
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 43B161955F41;
	Wed, 25 Feb 2026 09:55:06 +0000 (UTC)
Received: from localhost (unknown [10.2.16.120])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 06B653003D88;
	Wed, 25 Feb 2026 09:55:04 +0000 (UTC)
Date: Wed, 25 Feb 2026 17:55:02 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
Cc: Sebastian Mauritsson <sma@napatech.com>, virtio-dev@lists.linux.dev,
	quic_dshaikhu@quicinc.com
Subject: Re: [PATCH v2 1/1] virtio-blk: Add inline encryption support
Message-ID: <20260225095502.GB1653802@fedora>
References: <20260210083208.472824-1-linlin.zhang@oss.qualcomm.com>
 <20260210083208.472824-2-linlin.zhang@oss.qualcomm.com>
 <20260210211842.GA158755@fedora>
 <fa458358-90c8-408c-a860-8bfdb11658bb@oss.qualcomm.com>
 <20260218215336.GD605390@fedora>
 <bca448cf-6c18-4c82-806d-f2a25579a02b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IPTf/6q+RiGB07a8"
Content-Disposition: inline
In-Reply-To: <bca448cf-6c18-4c82-806d-f2a25579a02b@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


--IPTf/6q+RiGB07a8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 01:33:17PM +0800, Linlin Zhang wrote:
>=20
>=20
> On 2/19/2026 5:53 AM, Stefan Hajnoczi wrote:
> > On Sat, Feb 14, 2026 at 03:22:21PM +0800, Linlin Zhang wrote:
> >>
> >>
> >> On 2/11/2026 5:18 AM, Stefan Hajnoczi wrote:
> >>> On Tue, Feb 10, 2026 at 12:32:08AM -0800, Linlin Zhang wrote:
> >>>> Inline encryption on virtio block can only be supported when
> >>>> the new feature bit VIRTIO_BLK_F_ICE is negotiated.
> >>>>
> >>>> Extend struct virtio_blk_config and struct virtio_blk_req,
> >>>> so that crypto capabilities can be got in the frontend and
> >>>> encryption metadata can be sent to the backend, together with
> >>>> each I/O transaction.
> >>>>
> >>>> About the inline encryption on UFS or eMMC storage, please
> >>>> refer to the Linux inline encryption documentation:
> >>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/t=
ree/Documentation/block/inline-encryption.rst
> >>>>
> >>>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/238
> >>>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >>>> Signed-off-by: linlzhan <quic_linlzhan@quicinc.com>
> >>>> Signed-off-by: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
> >>>> ---
> >>>>  device-types/blk/description.tex | 110 ++++++++++++++++++++++++++++=
++-
> >>>>  1 file changed, 108 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/device-types/blk/description.tex b/device-types/blk/des=
cription.tex
> >>>> index 2712ada..60f46af 100644
> >>>> --- a/device-types/blk/description.tex
> >>>> +++ b/device-types/blk/description.tex
> >>>> @@ -66,6 +66,11 @@ \subsection{Feature bits}\label{sec:Device Types =
/ Block Device / Feature bits}
> >>>>  	(ZNS). For brevity, these standard documents are referred as "ZBD =
standards"
> >>>>  	from this point on in the text.
> >>>> =20
> >>>> +\item[VIRTIO_BLK_F_ICE(22)] Inline Crypto Extensions are supported.=
 Only when this
> >>>> +     feature bit is negotiated, the device need expose crypto chara=
cteristics in
> >>>> +     configuration space and the driver need provide an extended re=
quest header
> >>>> +     containing a crypto payload for block I/O.
> >>>
> >>> Most of the feature bit descriptions are brief and the details are
> >>> covered later in the spec. I suggest doing this here too:
> >>>
> >>>   \item[VIRTIO_BLK_F_ICE (22)] Device supports Inline Crypto Engine f=
unctionality.
> >>>
> >>> I changed the name from Inline Crypto Extensions to Inline Crypto Eng=
ine
> >>> because that terminology is used in the Linux kernel. Web search resu=
lts
> >>> also favor "inline crypto engine" over "inline crypto extensions". Are
> >>> you okay with "engine"?
> >> Thanks! ACK
> >>
> >>>
> >>>> +
> >>>>  \end{description}
> >>>> =20
> >>>>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Typ=
es / Block Device / Feature bits / Legacy Interface: Feature bits}
> >>>> @@ -128,6 +133,10 @@ \subsection{Device configuration layout}\label{=
sec:Device Types / Block Device /
> >>>>                  u8 model;
> >>>>                  u8 unused2[3];
> >>>>          } zoned;
> >>>> +        struct virtio_blk_crypto_characteristics {
> >>>> +                __virtio16 slot_info;
> >>>> +                __virtio16 reserved;
> >>>> +        } crypto;
> >>>>  };
> >>>>  \end{lstlisting}
> >>>> =20
> >>>> @@ -215,6 +224,18 @@ \subsection{Device configuration layout}\label{=
sec:Device Types / Block Device /
> >>>>  terminated by the device with a "zone resources exceeded" error as =
defined for
> >>>>  specific commands later.
> >>>> =20
> >>>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then in
> >>>> +\field{virtio_blk_crypto_characteristics},
> >>>> +\begin{itemize}
> >>>> +\item \field{slot_info} value packs two 8-bits values to reduce the=
 number of
> >>>
> >>> 8-bits -> 8-bit
> >>
> >> ACK
> >>
> >>>
> >>>> +    Configuration Space reads.
> >>>> +    \begin{itemize}
> >>>> +        \item Bits~\[15:8] (\emph{max\_slots}): the maximum number =
of supported
> >>>> +            crypto key slots.
> >>>> +        \item Bits~\[7:0] (\emph{slot\_offset}): an offset applied =
to slot numbering.
> >>>
> >>> What is the purpose of slot_offset? This field is not used much in th=
is
> >>> spec, maybe it can be removed?
> >>>
> >>> Does that mean only slots in the range [slot_offset:max_slots) are
> >>> available or does it mean that the range is
> >>> [slot_offset:slot_offset+max_slots)?
> >>
> >> Only slots within the range [slot_offset, slot_offset + max_slots) are=
 accessible to the
> >> VM. The slot_offset specifies the base physical ICE slot allocated to =
the VM and is used
> >> to translate a virtual slot index into a physical slot.
> >>
> >> Because the GVM programs and evicts keys directly=E2=80=94without host=
/PVM involvement=E2=80=94it must
> >> supply the resolved physical slot when invoking key operations in Trus=
tZone or the Secure
> >> VM.
> >=20
> > It's not clear to me how what you've described offers isolation between
> > the PVM and the GVM. What stops the GVM from using key slots outside the
> > range that has been assigned to it?
> >=20
> > A few options for isolation come to mind:
> >=20
> > 1. Expose 2 separate virtio-blk devices, one of which is hidden from the
> >    GVM and only accessible to the PVM. The PVM can store its data on the
> >    hidden device.
> >=20
> > 2. Some kind of VIRTIO Admin queue Virtual Function approach where the
> >    PVM can instantiate a virtual function (a sub-device) that the GVM is
> >    allowed to access with isolation enforced by the device.
> >=20
> > 3. A single device could be used but the GVM cannot access it directly
> >    and needs to go through the PVM.
>=20
> The slot isolation between GVM and PVM is implemented by the max slots al=
located to the GVM and slot offset
> the GVM's starting slot relative to the physical starting slot.
>=20
> For instance, ICE hardware has 64 slots, the max slots allocated to the G=
VM is 32, and its slot offset is 20.
> The keyslot manager in the GVM ensure the virtual slot rang is [0,31], wh=
en programming a key, translate the
> virtual slot to a physical slot by using the slot offset, that means the =
physical slot range this GVM used
> is [20,51].
>=20
> The max_slots and slot_offset are configured by PVM, and GVM's virtio fro=
ntend only gets them from the configuration
> space of its virtio devices. So PVM is responsible to ensure the physical=
 slot range of the GVM is valid.

I don't understand how isolation between the PVM and GVM works. To me it
seems like if there is isolation, then it would not be necessary to
expose slot_offset to the GVM. And if there is no isolation, then this
design isn't safe because the PVM is not protected against the GVM.

I'm probably missing something. Can you explain how isolation is
enforced?

>=20
> >=20
> >>
> >>>
> >>>> +    \end{itemize}
> >>>> +\end{itemize}
> >>>> +
> >>>>  \subsubsection{Legacy Interface: Device configuration layout}\label=
{sec:Device Types / Block Device / Device configuration layout / Legacy Int=
erface: Device configuration layout}
> >>>>  When using the legacy interface, transitional devices and drivers
> >>>>  MUST format the fields in struct virtio_blk_config
> >>>> @@ -278,6 +299,10 @@ \subsection{Device Initialization}\label{sec:De=
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
> >>>> @@ -317,6 +342,9 @@ \subsection{Device Initialization}\label{sec:Dev=
ice Types / Block Device / Devic
> >>>>      driver SHOULD ignore all other fields in \field{zoned}.
> >>>>  \end{itemize}
> >>>> =20
> >>>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver MUST=
 validate
> >>>> +    the max_slots in \field{slot_info} before the slot usage.
> >>>
> >>> I'm not sure how the driver is supposed to validate max_slots?
> >>
> >> It means the diver validate the virtual slot doesn't exceed the max_sl=
ots before translating
> >> this virtual slot to a physical slot by using slot_offset.=20
> >>
> >> Can I rewrite it as the following?
> >>
> >>   If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver MUST =
validate that
> >>   the virtual slot received from upper layer doesn't exceed the max_sl=
ots in
> >>   \field{slot_info} before the slot usage.
> >=20
> > The notion of an "upper layer" can be eliminated so that there is no
> > assumption about the software design in the driver:
> >=20
> >   If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver MUST
> >   ensure that slot_offset <=3D \field{payload.slot} < slot_offset +
> >   max_slots, where slot_offset and max_slots are the values extracted
> >   from \field{crypto.slot_info} in configuration space.
>=20
> ACK. Thanks!
>=20
> >=20
> >>
> >>>
> >>>> +
> >>>>  \devicenormative{\subsubsection}{Device Initialization}{Device Type=
s / Block Device / Device Initialization}
> >>>> =20
> >>>>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
> >>>> @@ -402,6 +430,13 @@ \subsection{Device Initialization}\label{sec:De=
vice Types / Block Device / Devic
> >>>>  \item the device MUST initialize padding bytes \field{unused2} to 0.
> >>>>  \end{itemize}
> >>>> =20
> >>>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then the fields in \=
field{crypto}
> >>>> +struct in the configuration space MUST be set by the device.
> >>>> +\begin{itemize}
> >>>> +\item the \field{slot_info} field of \field{crypto} MUST be set by =
the device to a
> >>>> +    max_slots in the higher 8 bits and slot_offset in the lower 8 b=
its.
> >>>> +\end{itemize}
> >>>
> >>> There is no need for the \begin{itemize} here. It contains no new
> >>> information. The fields were already described in the configuration
> >>> space section and the previous sentence already said that the fields =
in
> >>> \field{crypto} must be set by the device.
> >>
> >> ACK, remove this \begin{itemize} here.
> >>
> >>>
> >>>> +
> >>>>  \subsubsection{Legacy Interface: Device Initialization}\label{sec:D=
evice Types / Block Device / Device Initialization / Legacy Interface: Devi=
ce Initialization}
> >>>> =20
> >>>>  Because legacy devices do not have FEATURES_OK, transitional devices
> >>>> @@ -436,6 +471,13 @@ \subsection{Device Operation}\label{sec:Device =
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
> >>>
> >>> "payload" is a generic term. crypto_payload would be clearer.
> >>>
> >>> I wonder whether consistently calling this feature "ice" rather than
> >>> "crypto" would help in case self-encrypting drive or other cryptograp=
hic
> >>> functionality is added to virtio-blk in the future. That way the spec
> >>> items related to inline crypto engine functionality will be easy to
> >>> differentiate from other crypto functionality.
> >>
> >> Ok, to differentiate ICE and other cryptographic functionality, can I =
modify it as
> >>
> >>   struct virtio_blk_ice_payload {
> >>       u8 slot;
> >>       u8 activate;
> >>       le16 reserved1;
> >>       le32 reserved2;
> >>       le64 data_unit_num;
> >>   } ice_payload;
> >=20
> > Looks good to me, thanks.
>=20
> Thanks!
>=20
> >=20
> >>
> >>>
> >>>>          u8 data[];
> >>>>          u8 status;
> >>>>  };
> >>>> @@ -445,8 +487,9 @@ \subsection{Device Operation}\label{sec:Device T=
ypes / Block Device / Device Ope
> >>>>  (VIRTIO_BLK_T_OUT), a discard (VIRTIO_BLK_T_DISCARD), a write zeroes
> >>>>  (VIRTIO_BLK_T_WRITE_ZEROES), a flush (VIRTIO_BLK_T_FLUSH), a get de=
vice ID
> >>>>  string command (VIRTIO_BLK_T_GET_ID), a secure erase
> >>>> -(VIRTIO_BLK_T_SECURE_ERASE), or a get device lifetime command
> >>>> -(VIRTIO_BLK_T_GET_LIFETIME).
> >>>> +(VIRTIO_BLK_T_SECURE_ERASE), a get device lifetime command
> >>>> +(VIRTIO_BLK_T_GET_LIFETIME), or a get device crypto capabilities co=
mmand
> >>>> +(VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES).
> >>>> =20
> >>>>  \begin{lstlisting}
> >>>>  #define VIRTIO_BLK_T_IN           0
> >>>> @@ -457,12 +500,27 @@ \subsection{Device Operation}\label{sec:Device=
 Types / Block Device / Device Ope
> >>>>  #define VIRTIO_BLK_T_DISCARD      11
> >>>>  #define VIRTIO_BLK_T_WRITE_ZEROES 13
> >>>>  #define VIRTIO_BLK_T_SECURE_ERASE   14
> >>>> +#define VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES   27
> >>>
> >>> The Linux virtio_blk.c driver assumes that odd numbered constants have
> >>> data buffers that are read by the device, so you may run into a bug w=
hen
> >>> using 27.
> >>>
> >>> There is an informal convention to use even numbers for read requests
> >>> and odd numbers for write requests. It doesn't hurt to try to follow =
the
> >>> convention even though it's not strictly necessary.
> >>>
> >>> The Linux driver could be fixed when adding support for ICE, but 16 is
> >>> available and it's safest to use that.
> >>
> >> OK. Agree to following the convention. But 16, 18,20,22,24,26 are alre=
ady used by
> >> zone device. Seems 12 is available. Correct it to 12.
> >>
> >>  #define VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES   12
> >=20
> > In that case I suggest using 28. I don't remember what 12 was used for
> > but there may be a historical reason for the gap.
>=20
> Thanks! Change it to 28.
>=20
> >=20
> >>
> >>>
> >>>>  \end{lstlisting}
> >>>> =20
> >>>>  The \field{sector} number indicates the offset (multiplied by 512) =
where
> >>>>  the read or write is to occur. This field is unused and set to 0 for
> >>>>  commands other than read, write and some zone operations.
> >>>> =20
> >>>> +The \field{payload} consists of the encryption information for curr=
ent
> >>>> +request. It is only present when the VIRTIO_BLK_F_ICE feature is ne=
gotiated and
> >>>> +\field{type} is VIRTIO_BLK_T_IN, VIRTIO_BLK_T_OUT or VIRTIO_BLK_T_F=
LUSH.
> >>>
> >>> TODO think about layout
> >>
> >> rewrite to the following
> >>
> >>   The \field{ice_payload} consists of the encryption information for c=
urrent
> >>   request. When VIRTIO_BLK_F_ICE is negotiated, the request header lay=
out becomes
> >>   that struct virtio_blk_outhdr includes \field{ice_payload} as a fixe=
d-size
> >>   extension. For non-ICE requests (or types not using crypto), the dri=
ver MUST
> >>   set \field{ice_payload} to 0 and device ignores them.
> >=20
> > Sorry, the TODO was a comment to myself while writing my reply :).
> >=20
> > I forgot to investigate. Basically the issue is that the spec must be
> > clear on whether:
> > 1. A field is absent and fields that follow it are present in the struct
> >    layout when a condition is false (e.g. type is not VIRTIO_BLK_T_IN,
> >    VIRTIO_BLK_T_OUT, or VIRTIO_BLK_T_FLUSH).
> > or
> > 2. A field is present but unused (zeroed) when a condition is false.
> >=20
> > #2 is usually easier to implement in code because it avoids creating
> > many different struct layouts at runtime depending on conditions like
> > negotiated feature bits.
> >=20
> > I was thinking that the ice fields should always be present but should
> > be zero when the feature bit is not negotiated or some other condition
> > (like the request type) is false. This way it will be much easier to add
> > additional fields later without worrying about struct layouts.
> >=20
> > This is how configuration space already works: the offset of the zoned
> > field is not affected by whether the device advertises the
> > VIRTIO_BLK_F_WRITE_ZEROES feature bit, it just means that the earlier
> > write_zeroes_may_unmap field may be unused. This approach should
> > probably be used everywhere and the spec language should be careful to
> > communicate that the field is still present but zero when unused. It's
> > okay for the driver to provide a shorter struct that doesn't include the
> > last field(s) to the device when the feature bit is not negotiated
> > though.
>=20
> Thanks. Refer to the statement you shared, try to rewrite it as the follo=
wing.
>=20
>   The \field{ice_payload} consists of the encryption information for curr=
ent
>   request. It is not affected by whether the device advertises the
>   VIRTIO_BLK_F_ICE feature bit, it just SHOULD be zero when the feature b=
it is
>   not negotiated or the \field{type} is not VIRTIO_BLK_T_IN, VIRTIO_BLK_T=
_OUT
>   or VIRTIO_BLK_T_FLUSH.=20

Sounds good.

>=20
> >=20
> >>
> >>>
> >>>> +\begin{itemize}
> >>>> +\item The \field{slot} field in \field{payload} indicates the ICE
> >>>> +  (Inline Crypto Encryption) slot index where the key resides.
> >>>> +
> >>>> +\item The \field{activate} field in \field{payload} implies this is=
 a
> >>>> +  inline encryption request.
> >>>> +
> >>>> +\item The \field{data_unit_num} field in \field{payload} indicates =
the
> >>>> +  starting block of the request.
> >>>
> >>> This is a block device, so the term "block" needs to be qualified to
> >>> avoid confusion. I guess this is the cryptography concept of a block
> >>> rather than the disk concept of a block. Please clarify this in the
> >>> text, maybe by explaining that the ICE handles data in fixed-size "da=
ta
> >>> units" instead of using the word "block".
> >>>
> >>> Also, can you explain the relationship between the data unit number a=
nd
> >>> the sector? In simple cases I imagine the data unit number would be t=
he
> >>> sector. How is the driver supposed to pick or calculate the data unit
> >>> number?
> >>
> >> The data unit number is the starting IV for AES crypto in ICE hardware=
, it's
> >> a stable value for I/O request targeting to same storage range. It can=
 be set
> >> to the file logic block number or the starting sector of BIO.=20
> >=20
> > It sounds like the data unit number calculation is up to the driver
> > (from the device's perspective) and the important thing is that the same
> > data unit number will always be used when reading/writing the same
> > logical data location.
>=20
> Yes. Correct.
>=20
> >=20
> >> The upper layer calculates it and passes it to virtio_blk driver in th=
is patch.
> >> ICE uses the data unit number and data unit size (the granularity to u=
se for
> >> en/decryption) to derive the next data unit number for the next crypto=
graphy
> >> block. data unit number in ICE increase 1 per data unit size. For inst=
ance,
> >>   data unit number =3D 2048
> >>   data unit size =3D 1024 bytes
> >> For the first 1024 bytes of the transaction, ICE hardware encrypt the =
data
> >> with IV equal to 2048.
> >> For the second 1024 bytes of the transaction, ICE hardware encrypt the=
 data
> >> with IV equal to (2048+1=3D)2049.
> >>
> >> Rewrite it as bellow.
> >>
> >>   \item The \field{data_unit_num} field in \field{ice_payload} indicat=
es the
> >>   starting IV. It can be the file logic block number or the starting s=
ector
> >>   of BIO.
> >=20
> > BIO is a Linux-specific concept, so it would be best to avoid it in the
> > VIRTIO spec.
> >=20
> >   \item The \field{data_unit_num} field in \field{ice_payload} indicates
> >   the starting IV. In order to successfully encrypt/decrypt data this
> >   number must be the same for successive read and write operations to
> >   the same logical data location. The driver typically sets it to the
> >   file logical block number or the disk sector number.
>=20
> Thanks! ACK.
>=20
> >=20
> >>
> >>>
> >>>> +\end{itemize}
> >>>> +
> >>>>  VIRTIO_BLK_T_IN requests populate \field{data} with the contents of=
 sectors
> >>>>  read from the block device (in multiples of 512 bytes).  VIRTIO_BLK=
_T_OUT
> >>>>  requests write the contents of \field{data} to the block device (in=
 multiples
> >>>> @@ -530,6 +588,47 @@ \subsection{Device Operation}\label{sec:Device =
Types / Block Device / Device Ope
> >>>>  The \field{device_lifetime_est_typ_b} refers to wear of MLC cells a=
nd is provided
> >>>>  with the same semantics as \field{device_lifetime_est_typ_a}.
> >>>> =20
> >>>> +VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests fetch the storage har=
dware crypto
> >>>> +capabilities into \field{data}. And the \field{data} is of the form
> >>>
> >>> How does VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES behave when data[] is t=
oo
> >>> small to fit all the device's crypto capabilities?
> >>
> >> Add a new field capability_num to the Configuration space header. The =
total size of
> >> \field{data} shall be computed as:
> >>   data_size=3Dcapability_num=C3=97capability_size
> >> where capability_size is the size (in bytes) of one capability structu=
re. Therefore, \field{data} contains exactly capability_num contiguous capa=
bility entries, each of length capability_size.
> >> Add a capability_num field in Configuration space. So it use size per =
capability
> >> multiply capability_num to define the size of \field{data}.
> >>
> >> Rewrite it as the following.
> >>
> >>   VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests fetch the storage hard=
ware crypto
> >>   capabilities into \field{data}. The crypto capabilities is a zero-pa=
dded array
> >>   up to (\field{capability_num}=C3=97capability_size) bytes long, wher=
e capability_size
> >>   is the size (in bytes) of one capability structure which is in form =
of
> >>  =20
> >>   \begin{lstlisting}
> >>     struct virtio_blk_crypto_cap {
> >>         u8 alg;
> >>         u8 data_unit_size;
> >>         u8 key_size;
> >>         u8 reserved;
> >>     };
> >>   \end{lstlisting}
> >>  =20
> >>   \begin{itemize}
> >>       \item The \field{alg} implies crypto algorithm identifiers.
> >>       The device supports reporting and negotiating cryptographic algo=
rithms
> >>       using the following algorithm identifiers:
> >>       \begin{lstlisting}
> >>           CRYPTO_ALG_AES_XTS              =3D 0x0
> >>           CRYPTO_ALG_BITLOCKER_AES_CBC    =3D 0x1
> >>           CRYPTO_ALG_AES_ECB              =3D 0x2
> >>           CRYPTO_ALG_ESSIV_AES_CBC        =3D 0x3
> >>       \end{lstlisting}
> >>       These identifiers abstract the underlying hardware crypto implem=
entation
> >>       and does not assume any operating=E2=80=91system=E2=80=91specifi=
c data structures or
> >>       constants.
> >>       \item The \field{data_unit_size} implies the mask of data unit s=
ize. When
> >>       bit j in this field (j=3D7......0) is set, a data unit size of 5=
12*2^j bytes
> >>       is selected.
> >>       \item The \field{key_size} is the crypto key size identifiers.
> >>       \begin{lstlisting}
> >>           CRYPTO_KEY_SIZE_INVALID     =3D 0x0
> >>           CRYPTO_KEY_SIZE_128_BITS    =3D 0x1
> >>           CRYPTO_KEY_SIZE_192_BITS    =3D 0x2
> >>           CRYPTO_KEY_SIZE_256_BITS    =3D 0x3
> >>           CRYPTO_KEY_SIZE_512_BITS    =3D 0x4
> >>       \end{lstlisting}
> >>       \item The \field{reserved} is unused.
> >>   \end{itemize}
> >>  =20
> >>   If the \field{data} is too short, it sets status to BLK_S_IO_ERR.
> >=20
> > Looks good. In the final sentence I suggest changing "it" to "the
> > device" for clarity.
>=20
> Thanks! Done.
>=20
> >=20
> >>
> >>>
> >>>> +
> >>>> +\begin{lstlisting}
> >>>> +struct virtio_blk_crypto_caps {
> >>>> +  u8 size;
> >>>> +  le32 crypto_capabilities[];
> >>>> +};
> >>>> +\end{lstlisting}
> >>>> +
> >>>> +The \field{size} specifies the size of array \field{crypto_capabili=
ties}.
> >>>
> >>> "number of elements" would be clearer than "size of array" because the
> >>> unit (bytes vs array elements) is ambiguous.
> >>>
> >>> The size field is not necessary since Used Ring descriptors contain
> >>> (struct virtq_used_elem in the spec) a len field indicating how many
> >>> bytes were written by the device.
> >>
> >> Remove virtio_blk_crypto_caps in above modification.
> >>
> >>>
> >>>> +The \field{crypto_capabilities} indicates the crypto capabilities s=
upported by the
> >>>> +hardware storage for inline encryption.
> >>>> +
> >>>> +A crypto capability packs four 8-bits values:
> >>>> +\begin{itemize}
> >>>> +    \item Bits~\[31:24]: crypto algorithm identifiers.
> >>>> +    The device supports reporting and negotiating cryptographic alg=
orithms
> >>>> +    using the following algorithm identifiers:
> >>>> +    \begin{lstlisting}
> >>>> +        CRYPTO_ALG_AES_XTS              =3D 0x0
> >>>> +        CRYPTO_ALG_BITLOCKER_AES_CBC    =3D 0x1
> >>>> +        CRYPTO_ALG_AES_ECB              =3D 0x2
> >>>> +        CRYPTO_ALG_ESSIV_AES_CBC        =3D 0x3
> >>>> +    \end{lstlisting}
> >>>> +    These identifiers abstract the underlying hardware crypto imple=
mentation
> >>>> +    and does not assume any operating=E2=80=91system=E2=80=91specif=
ic data structures or
> >>>> +    constants.
> >>>> +    \item Bits~\[23:16]: mask of data unit size. When bit j in this=
 field
> >>>> +    (j=3D7......0) is set, a data unit size of 512*2^j bytes is sel=
ected.
> >>>
> >>> Is only one bit ever set in the mask? If so, then maybe just express j
> >>> as an 8-bit unsigned integer (i.e. the exponent in 512*2^j) instead of
> >>> as a bit mask. It's simpler and increases the range for j.
> >>
> >> Yes, it's encoded in one-hot encoding. If j is expressed as an 8-bit u=
nsigned integer,
> >> it will confused the reader that more than one bit can be set in the m=
ask of data unit
> >> size. right?=20
> >=20
> > If the field is called the data unit size exponent (data_unit_size_exp)
> > then there is no confusion. I agree that calling it a mask would be
> > confusing.
>=20
> Thanks! Update it to data_unit_size_exp.
>=20
> >=20
> >>
> >>>
> >>>> +    \item Bits~\[15:8]: crypto key size identifiers.
> >>>> +    \begin{lstlisting}
> >>>> +        CRYPTO_KEY_SIZE_INVALID     =3D 0x0
> >>>> +        CRYPTO_KEY_SIZE_128_BITS    =3D 0x1
> >>>> +        CRYPTO_KEY_SIZE_192_BITS    =3D 0x2
> >>>> +        CRYPTO_KEY_SIZE_256_BITS    =3D 0x3
> >>>> +        CRYPTO_KEY_SIZE_512_BITS    =3D 0x4
> >>>> +    \end{lstlisting}
> >>>> +    \item Bits~\[7:0]: unused.
> >>>> +\end{itemize}
> >>>
> >>> A struct would be more natural here (the rest of the VIRTIO
> >>> specification rarely packs fields into an integer):
> >>>
> >>>   struct virtio_blk_crypto_cap {
> >>>       u8 alg;
> >>>       u8 data_unit_size;
> >>>       u8 key_size;
> >>>       u8 reserved;
> >>>   };
> >>
> >> ACK, see above rewrite statement.
> >>
> >>>
> >>> By the way, Linux seems to call this a "profile" rather than a
> >>> "capability". Do you want to use the same name as Linux for consisten=
cy?
> >>
> >> blk-crypto-profile is the keyslot manager which manage the usage of ke=
yslot and
> >> also checks if the key configuration set by upper layer can be support=
ed by the
> >> ICE hardware. While the capability aims to illustrate the capability p=
rovided by
> >> the ICE hardware. What we expected is the capability used to initializ=
ed
> >> blk-crypto-profile in Guest VM.
> >=20
> > I see.
> >=20
> >>
> >>>
> >>>> +
> >>>>  The final \field{status} byte is written by the device: either
> >>>>  VIRTIO_BLK_S_OK for success, VIRTIO_BLK_S_IOERR for device or driver
> >>>>  error or VIRTIO_BLK_S_UNSUPP for a request unsupported by device:
> >>>> @@ -912,6 +1011,13 @@ \subsection{Device Operation}\label{sec:Device=
 Types / Block Device / Device Ope
> >>>>  successfully, failed, or were processed by the device at all if the=
 request
> >>>>  failed with VIRTIO_BLK_S_IOERR.
> >>>> =20
> >>>> +The length of \field{data} MUST be a multiple of 4 bytes plus 1 for
> >>>> +VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests.
> >>>> +
> >>>> +A driver MUST set \field{activate} to 1 for VIRTIO_BLK_T_IN,VIRTIO_=
BLK_T_OUT,
> >>>> +    and VIRTIO_BLK_T_FLUSH requests that require inline encryption.=
 For other
> >>>> +    request types or when inline encryption is not required, it is =
set to 0.
> >>>> +
> >>>>  The following requirements only apply if the VIRTIO_BLK_F_ZONED fea=
ture is
> >>>>  negotiated.
> >>>
> >>> How does the driver assign a specific capability (algorithm, data unit
> >>> size, and key size tuple reported by
> >>> VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES) to a slot?
> >>>
> >>> How does the driver assign the key material for a slot?
> >>
> >> blk layer will initialize a blk_crypto_key based on the configuration =
received from
> >> FS layer. This blk_crypto_key contains expected algorithm, data unit s=
ize and key size expected
> >> by the upper layer. When submit_bio, blk_mq tries to program the key i=
ncluded in blk_crypto_key
> >> to the ICE hardware slot via blk_crypto_profile. During programming th=
e key, it will compare=20
> >> the algorithm, data unit size and key size in blk_crypto_key with the =
capability exposed by ICE
> >> hardware.
> >>
> >> It will follow bellow flow to assign the key material for a slot.
> >>   blk_crypto_profile -> virtio_blk driver -> virtio_blk extention -> S=
CM driver -> TZ
> >>
> >> That means the driver only maintain the capability in RAM, use it when=
 programming key.
> >=20
> > I don't see an interface for programming the key in this spec patch. The
> > Linux block driver interface includes struct blk_crypto_ll_ops with
> > driver functions for programming keys. I expected this spec would add
> > operations to the virtio-blk device for implementing those functions?
>=20
> The design is that having a virtio_blk extension driver to handle the ini=
tialization of keyslot manager
> for virtio block with VIRTIO_BLK_F_ICE feature bit negociated. And this e=
xtension driver also define the
> implementation of struct blk_crypto_ll_ops with driver functions for prog=
ramming keys, evicting keys and
> derive raw keys. Thees 3 key operation is done in a 'out of band' channel=
, that LA GVM calls to TrustZone
> (or secure VM) directly via SCM driver, bypass PVM.
>=20
> Add a new Kconfig VIRTIO_BLK_INLINE_CRYPTO, and this config need always t=
o be set as Y when inline encryption
> on virtio block is expected.
>=20
> In such scenario, the key programming/eviction/derivation doesn't affect =
the virtio block protocol, so I didn't
> add it in this patch. Do you think it's necessary to be shown in virtio S=
PEC in such design?

It seems like supporting keyslot manager operations via the virtio-blk
device is a possible future use case. The design of VIRTIO_BLK_F_ICE
should allow for adding it in the future so that we can be confident
that no breaking changes will be needed.

Why are the keyslot manager operations out of band in your TrustZone use
case? Maybe this is related to isolation between the PVM and GVM when
sharing a device, but it's not clear to me that isolation is actually
enforced, so then I see no need for out of band keyslot manager
operations.

Stefan

--IPTf/6q+RiGB07a8
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmexvYACgkQnKSrs4Gr
c8j8lAf+MegXO3OBkFuC45cbuf9ONWNsEVmRF3gs01ZaTOKRJlNoLkJMCzmAVtpK
4n5JPoTfupYevPbLfw0VUcEEUFmWh+QutmUNTNgNW7cTnpPOUVdcHilUcAyQd+0s
BoYfhoyyazXQ9DdczFdfsuED92oeGGn8jekHsXU6V/vdqYtr0Ng9nxkUuRD6rqHa
AF7zvpd+x/Am6rzDPZiMlhaObsPeLCwRYWDYJ8ESF9KnMKDeVcFGJ6PwpH6Zd/PU
dBsbWBAwj2T602QQkqWVkgmirEsyyuz+wuzBs/FdlmVYt9DkQk/pjeFNs4I4pliU
nRpLDFlIfyHB6PLLICw9L7A64s1CHA==
=lfpP
-----END PGP SIGNATURE-----

--IPTf/6q+RiGB07a8--

