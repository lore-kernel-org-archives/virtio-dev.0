Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1774C1F0991
	for <virtio-dev@lists.linux.dev>; Sun,  1 Mar 2026 08:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772352270; cv=none; b=d5Npl4IJ84DzOZVDw1mO+3vGxCL8B39CEmVfrJB9iS/xG9l9aNKcNT5J5DCtX7tih8jV1UWnf8fxQUIssoH65MBLYFpZxgWU/0qxxMeHZwNazdg4BT69n/3INdhUcmxg1mrcvyvSk/esYad/ML2YxeWdTb/QbDoEejs+zcqK9po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772352270; c=relaxed/simple;
	bh=R/CoDuYag7w7DfGmAtcJQa6URlTUu3fhMpc+zS5M0z4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqP2zEfY2ohHhmCt8ogsHxFwYIREL9uazlfBassCv4HO69uhMkApenPLTssBlFSssgLhzRvW9mbj6pMsISD1dDgCXsjxcjG33gW0OOCNWUrdJKd1J67RpvX8ATCtN/e8urgjUWrGQRXQsVuPq4Ppx9Jp9uILC8RruCodgCJ+S8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CvAYWafK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CvAYWafK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772352266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zEtEkzRPQvPA61TxKdpGEdIp7VF3OE9RXW+ISYq5QTY=;
	b=CvAYWafKLqokxIqubEpcyUgrhuwfyCbx+J5v4mX244qkw41iLFf+1qWIBYbYaVnGSTG/RW
	x6noyWk7Iw0etKJzEiDCIJjnZFnRFqTTMtmmYMfHQJC3G3LdI4sdV+jkZc3Fotf6kaehqB
	eeQAwbG29nucKpieQNL7STCDoiJ8KT8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-460-prSL0UZjPXynBIpnio7Tdg-1; Sun,
 01 Mar 2026 03:04:23 -0500
X-MC-Unique: prSL0UZjPXynBIpnio7Tdg-1
X-Mimecast-MFC-AGG-ID: prSL0UZjPXynBIpnio7Tdg_1772352262
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 813F318004A9;
	Sun,  1 Mar 2026 08:04:21 +0000 (UTC)
Received: from localhost (unknown [10.45.224.22])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 696B81956053;
	Sun,  1 Mar 2026 08:04:18 +0000 (UTC)
Date: Sun, 1 Mar 2026 12:55:16 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
Cc: Sebastian Mauritsson <sma@napatech.com>, virtio-dev@lists.linux.dev,
	quic_dshaikhu@quicinc.com
Subject: Re: [PATCH v2 1/1] virtio-blk: Add inline encryption support
Message-ID: <20260301045516.GB42492@fedora>
References: <20260210083208.472824-1-linlin.zhang@oss.qualcomm.com>
 <20260210083208.472824-2-linlin.zhang@oss.qualcomm.com>
 <20260210211842.GA158755@fedora>
 <fa458358-90c8-408c-a860-8bfdb11658bb@oss.qualcomm.com>
 <20260218215336.GD605390@fedora>
 <bca448cf-6c18-4c82-806d-f2a25579a02b@oss.qualcomm.com>
 <20260225095502.GB1653802@fedora>
 <22632a98-3d10-4c71-b579-d7aaefe8553d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="sLE+t8Lb/rFbRLt1"
Content-Disposition: inline
In-Reply-To: <22632a98-3d10-4c71-b579-d7aaefe8553d@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17


--sLE+t8Lb/rFbRLt1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 09:34:01PM +0800, Linlin Zhang wrote:
>=20
>=20
> On 2/25/2026 5:55 PM, Stefan Hajnoczi wrote:
> > On Wed, Feb 25, 2026 at 01:33:17PM +0800, Linlin Zhang wrote:
> >>
> >>
> >> On 2/19/2026 5:53 AM, Stefan Hajnoczi wrote:
> >>> On Sat, Feb 14, 2026 at 03:22:21PM +0800, Linlin Zhang wrote:
> >>>>
> >>>>
> >>>> On 2/11/2026 5:18 AM, Stefan Hajnoczi wrote:
> >>>>> On Tue, Feb 10, 2026 at 12:32:08AM -0800, Linlin Zhang wrote:
> >>>>>> Inline encryption on virtio block can only be supported when
> >>>>>> the new feature bit VIRTIO_BLK_F_ICE is negotiated.
> >>>>>>
> >>>>>> Extend struct virtio_blk_config and struct virtio_blk_req,
> >>>>>> so that crypto capabilities can be got in the frontend and
> >>>>>> encryption metadata can be sent to the backend, together with
> >>>>>> each I/O transaction.
> >>>>>>
> >>>>>> About the inline encryption on UFS or eMMC storage, please
> >>>>>> refer to the Linux inline encryption documentation:
> >>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git=
/tree/Documentation/block/inline-encryption.rst
> >>>>>>
> >>>>>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/238
> >>>>>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >>>>>> Signed-off-by: linlzhan <quic_linlzhan@quicinc.com>
> >>>>>> Signed-off-by: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
> >>>>>> ---
> >>>>>>  device-types/blk/description.tex | 110 ++++++++++++++++++++++++++=
++++-
> >>>>>>  1 file changed, 108 insertions(+), 2 deletions(-)
> >>>>>>
> >>>>>> diff --git a/device-types/blk/description.tex b/device-types/blk/d=
escription.tex
> >>>>>> index 2712ada..60f46af 100644
> >>>>>> --- a/device-types/blk/description.tex
> >>>>>> +++ b/device-types/blk/description.tex
> >>>>>> @@ -66,6 +66,11 @@ \subsection{Feature bits}\label{sec:Device Type=
s / Block Device / Feature bits}
> >>>>>>  	(ZNS). For brevity, these standard documents are referred as "ZB=
D standards"
> >>>>>>  	from this point on in the text.
> >>>>>> =20
> >>>>>> +\item[VIRTIO_BLK_F_ICE(22)] Inline Crypto Extensions are supporte=
d. Only when this
> >>>>>> +     feature bit is negotiated, the device need expose crypto cha=
racteristics in
> >>>>>> +     configuration space and the driver need provide an extended =
request header
> >>>>>> +     containing a crypto payload for block I/O.
> >>>>>
> >>>>> Most of the feature bit descriptions are brief and the details are
> >>>>> covered later in the spec. I suggest doing this here too:
> >>>>>
> >>>>>   \item[VIRTIO_BLK_F_ICE (22)] Device supports Inline Crypto Engine=
 functionality.
> >>>>>
> >>>>> I changed the name from Inline Crypto Extensions to Inline Crypto E=
ngine
> >>>>> because that terminology is used in the Linux kernel. Web search re=
sults
> >>>>> also favor "inline crypto engine" over "inline crypto extensions". =
Are
> >>>>> you okay with "engine"?
> >>>> Thanks! ACK
> >>>>
> >>>>>
> >>>>>> +
> >>>>>>  \end{description}
> >>>>>> =20
> >>>>>>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device T=
ypes / Block Device / Feature bits / Legacy Interface: Feature bits}
> >>>>>> @@ -128,6 +133,10 @@ \subsection{Device configuration layout}\labe=
l{sec:Device Types / Block Device /
> >>>>>>                  u8 model;
> >>>>>>                  u8 unused2[3];
> >>>>>>          } zoned;
> >>>>>> +        struct virtio_blk_crypto_characteristics {
> >>>>>> +                __virtio16 slot_info;
> >>>>>> +                __virtio16 reserved;
> >>>>>> +        } crypto;
> >>>>>>  };
> >>>>>>  \end{lstlisting}
> >>>>>> =20
> >>>>>> @@ -215,6 +224,18 @@ \subsection{Device configuration layout}\labe=
l{sec:Device Types / Block Device /
> >>>>>>  terminated by the device with a "zone resources exceeded" error a=
s defined for
> >>>>>>  specific commands later.
> >>>>>> =20
> >>>>>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then in
> >>>>>> +\field{virtio_blk_crypto_characteristics},
> >>>>>> +\begin{itemize}
> >>>>>> +\item \field{slot_info} value packs two 8-bits values to reduce t=
he number of
> >>>>>
> >>>>> 8-bits -> 8-bit
> >>>>
> >>>> ACK
> >>>>
> >>>>>
> >>>>>> +    Configuration Space reads.
> >>>>>> +    \begin{itemize}
> >>>>>> +        \item Bits~\[15:8] (\emph{max\_slots}): the maximum numbe=
r of supported
> >>>>>> +            crypto key slots.
> >>>>>> +        \item Bits~\[7:0] (\emph{slot\_offset}): an offset applie=
d to slot numbering.
> >>>>>
> >>>>> What is the purpose of slot_offset? This field is not used much in =
this
> >>>>> spec, maybe it can be removed?
> >>>>>
> >>>>> Does that mean only slots in the range [slot_offset:max_slots) are
> >>>>> available or does it mean that the range is
> >>>>> [slot_offset:slot_offset+max_slots)?
> >>>>
> >>>> Only slots within the range [slot_offset, slot_offset + max_slots) a=
re accessible to the
> >>>> VM. The slot_offset specifies the base physical ICE slot allocated t=
o the VM and is used
> >>>> to translate a virtual slot index into a physical slot.
> >>>>
> >>>> Because the GVM programs and evicts keys directly=E2=80=94without ho=
st/PVM involvement=E2=80=94it must
> >>>> supply the resolved physical slot when invoking key operations in Tr=
ustZone or the Secure
> >>>> VM.
> >>>
> >>> It's not clear to me how what you've described offers isolation betwe=
en
> >>> the PVM and the GVM. What stops the GVM from using key slots outside =
the
> >>> range that has been assigned to it?
> >>>
> >>> A few options for isolation come to mind:
> >>>
> >>> 1. Expose 2 separate virtio-blk devices, one of which is hidden from =
the
> >>>    GVM and only accessible to the PVM. The PVM can store its data on =
the
> >>>    hidden device.
> >>>
> >>> 2. Some kind of VIRTIO Admin queue Virtual Function approach where the
> >>>    PVM can instantiate a virtual function (a sub-device) that the GVM=
 is
> >>>    allowed to access with isolation enforced by the device.
> >>>
> >>> 3. A single device could be used but the GVM cannot access it directly
> >>>    and needs to go through the PVM.
> >>
> >> The slot isolation between GVM and PVM is implemented by the max slots=
 allocated to the GVM and slot offset
> >> the GVM's starting slot relative to the physical starting slot.
> >>
> >> For instance, ICE hardware has 64 slots, the max slots allocated to th=
e GVM is 32, and its slot offset is 20.
> >> The keyslot manager in the GVM ensure the virtual slot rang is [0,31],=
 when programming a key, translate the
> >> virtual slot to a physical slot by using the slot offset, that means t=
he physical slot range this GVM used
> >> is [20,51].
> >>
> >> The max_slots and slot_offset are configured by PVM, and GVM's virtio =
frontend only gets them from the configuration
> >> space of its virtio devices. So PVM is responsible to ensure the physi=
cal slot range of the GVM is valid.
> >=20
> > I don't understand how isolation between the PVM and GVM works. To me it
> > seems like if there is isolation, then it would not be necessary to
> > expose slot_offset to the GVM. And if there is no isolation, then this
> > design isn't safe because the PVM is not protected against the GVM.
> >=20
> > I'm probably missing something. Can you explain how isolation is
> > enforced?
>=20
> Appreciate your quick feedback!
>=20
> The key slots in ICE hardware are used by both PVM/Host and GVMs, the PVM=
/Host
> specifies the slot range of each VM used (including itself) by defining s=
tarting
> slot offest and max slots per VM, ensure that there isn't overlapping b/w=
 these
> slot ranges in physical slot level.
>=20
> In this way, if only the virtual slot in each VM doesn't exceed the max s=
lots
> allocated to it, the access to its physical ICE slot for one VM doesn' ha=
ve impact
> on the ICE slots belonging to the range of other VMs.=20
>=20
> You mentioned "this design isn't safe because the PVM is not protected ag=
ainst the
> GVM", do you mean that the slot_offest and/or max_slots of GVM are tamper=
ed by a
> malixious program, leading to unexpected access from GVM to a physical IC=
E slot
> allocated to PVM? If yes, I feel it's not a risk as kernel image can be p=
retotected
> via dm-verity/AVB, it's impossible for an attacker to rewrite them in run=
time from
> both PVM and GVM sides.

There are two separate issues that are still unclear to me:
1. The device appears to trust the guest to select valid slot indices.
2. How the PVM/GVM share the device.

About trusting the slot field:
- In VIRTIO the trust model is that the device does not trust the
  driver. This is necessary not just for reliability but also to prevent
  virtualized devices from being exploited by untrusted VMs (escaping
  confinement, consuming resources not allocated to the VM, etc).
- Given that the device cannot trust the driver, I don't understand why
  the interface is designed to require driver cooperation in choosing
  slot indices within the slot_offset/max_slots range.
- I expected the interface to expose a max_slots Configuration Space
  field but slot indices are in the range [0, max_slots) and are
  validated by the device.

About the PVM/GVM relationship, please see below where I'm asking about
the architecture of a system using ICE.

> >=20
> >>
> >>>
> >>>>
> >>>>>
> >>>>>> +    \end{itemize}
> >>>>>> +\end{itemize}
> >>>>>> +
> >>>>>>  \subsubsection{Legacy Interface: Device configuration layout}\lab=
el{sec:Device Types / Block Device / Device configuration layout / Legacy I=
nterface: Device configuration layout}
> >>>>>>  When using the legacy interface, transitional devices and drivers
> >>>>>>  MUST format the fields in struct virtio_blk_config
> >>>>>> @@ -278,6 +299,10 @@ \subsection{Device Initialization}\label{sec:=
Device Types / Block Device / Devic
> >>>>>>      \field{zoned} can be read by the driver to determine the zone
> >>>>>>      characteristics of the device. All \field{zoned} fields are r=
ead-only.
> >>>>>> =20
> >>>>>> +\item If the VIRTIO_BLK_F_ICE feature is negotiated, the fields in
> >>>>>> +    \field{crypto} can be read by the driver to determine the inl=
ine crypto
> >>>>>> +    characteristics of the device. All \field{crypto} fields are =
read-only.
> >>>>>> +
> >>>>>>  \end{enumerate}
> >>>>>> =20
> >>>>>>  \drivernormative{\subsubsection}{Device Initialization}{Device Ty=
pes / Block Device / Device Initialization}
> >>>>>> @@ -317,6 +342,9 @@ \subsection{Device Initialization}\label{sec:D=
evice Types / Block Device / Devic
> >>>>>>      driver SHOULD ignore all other fields in \field{zoned}.
> >>>>>>  \end{itemize}
> >>>>>> =20
> >>>>>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver MU=
ST validate
> >>>>>> +    the max_slots in \field{slot_info} before the slot usage.
> >>>>>
> >>>>> I'm not sure how the driver is supposed to validate max_slots?
> >>>>
> >>>> It means the diver validate the virtual slot doesn't exceed the max_=
slots before translating
> >>>> this virtual slot to a physical slot by using slot_offset.=20
> >>>>
> >>>> Can I rewrite it as the following?
> >>>>
> >>>>   If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver MUS=
T validate that
> >>>>   the virtual slot received from upper layer doesn't exceed the max_=
slots in
> >>>>   \field{slot_info} before the slot usage.
> >>>
> >>> The notion of an "upper layer" can be eliminated so that there is no
> >>> assumption about the software design in the driver:
> >>>
> >>>   If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver MUST
> >>>   ensure that slot_offset <=3D \field{payload.slot} < slot_offset +
> >>>   max_slots, where slot_offset and max_slots are the values extracted
> >>>   from \field{crypto.slot_info} in configuration space.
> >>
> >> ACK. Thanks!
> >>
> >>>
> >>>>
> >>>>>
> >>>>>> +
> >>>>>>  \devicenormative{\subsubsection}{Device Initialization}{Device Ty=
pes / Block Device / Device Initialization}
> >>>>>> =20
> >>>>>>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
> >>>>>> @@ -402,6 +430,13 @@ \subsection{Device Initialization}\label{sec:=
Device Types / Block Device / Devic
> >>>>>>  \item the device MUST initialize padding bytes \field{unused2} to=
 0.
> >>>>>>  \end{itemize}
> >>>>>> =20
> >>>>>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then the fields in=
 \field{crypto}
> >>>>>> +struct in the configuration space MUST be set by the device.
> >>>>>> +\begin{itemize}
> >>>>>> +\item the \field{slot_info} field of \field{crypto} MUST be set b=
y the device to a
> >>>>>> +    max_slots in the higher 8 bits and slot_offset in the lower 8=
 bits.
> >>>>>> +\end{itemize}
> >>>>>
> >>>>> There is no need for the \begin{itemize} here. It contains no new
> >>>>> information. The fields were already described in the configuration
> >>>>> space section and the previous sentence already said that the field=
s in
> >>>>> \field{crypto} must be set by the device.
> >>>>
> >>>> ACK, remove this \begin{itemize} here.
> >>>>
> >>>>>
> >>>>>> +
> >>>>>>  \subsubsection{Legacy Interface: Device Initialization}\label{sec=
:Device Types / Block Device / Device Initialization / Legacy Interface: De=
vice Initialization}
> >>>>>> =20
> >>>>>>  Because legacy devices do not have FEATURES_OK, transitional devi=
ces
> >>>>>> @@ -436,6 +471,13 @@ \subsection{Device Operation}\label{sec:Devic=
e Types / Block Device / Device Ope
> >>>>>>          le32 type;
> >>>>>>          le32 reserved;
> >>>>>>          le64 sector;
> >>>>>> +        struct virtio_blk_crypto_payload {
> >>>>>> +            u8 slot;
> >>>>>> +            u8 activate;
> >>>>>> +            le16 reserved1;
> >>>>>> +            le32 reserved2;
> >>>>>> +            le64 data_unit_num;
> >>>>>> +        } payload;
> >>>>>
> >>>>> "payload" is a generic term. crypto_payload would be clearer.
> >>>>>
> >>>>> I wonder whether consistently calling this feature "ice" rather than
> >>>>> "crypto" would help in case self-encrypting drive or other cryptogr=
aphic
> >>>>> functionality is added to virtio-blk in the future. That way the sp=
ec
> >>>>> items related to inline crypto engine functionality will be easy to
> >>>>> differentiate from other crypto functionality.
> >>>>
> >>>> Ok, to differentiate ICE and other cryptographic functionality, can =
I modify it as
> >>>>
> >>>>   struct virtio_blk_ice_payload {
> >>>>       u8 slot;
> >>>>       u8 activate;
> >>>>       le16 reserved1;
> >>>>       le32 reserved2;
> >>>>       le64 data_unit_num;
> >>>>   } ice_payload;
> >>>
> >>> Looks good to me, thanks.
> >>
> >> Thanks!
> >>
> >>>
> >>>>
> >>>>>
> >>>>>>          u8 data[];
> >>>>>>          u8 status;
> >>>>>>  };
> >>>>>> @@ -445,8 +487,9 @@ \subsection{Device Operation}\label{sec:Device=
 Types / Block Device / Device Ope
> >>>>>>  (VIRTIO_BLK_T_OUT), a discard (VIRTIO_BLK_T_DISCARD), a write zer=
oes
> >>>>>>  (VIRTIO_BLK_T_WRITE_ZEROES), a flush (VIRTIO_BLK_T_FLUSH), a get =
device ID
> >>>>>>  string command (VIRTIO_BLK_T_GET_ID), a secure erase
> >>>>>> -(VIRTIO_BLK_T_SECURE_ERASE), or a get device lifetime command
> >>>>>> -(VIRTIO_BLK_T_GET_LIFETIME).
> >>>>>> +(VIRTIO_BLK_T_SECURE_ERASE), a get device lifetime command
> >>>>>> +(VIRTIO_BLK_T_GET_LIFETIME), or a get device crypto capabilities =
command
> >>>>>> +(VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES).
> >>>>>> =20
> >>>>>>  \begin{lstlisting}
> >>>>>>  #define VIRTIO_BLK_T_IN           0
> >>>>>> @@ -457,12 +500,27 @@ \subsection{Device Operation}\label{sec:Devi=
ce Types / Block Device / Device Ope
> >>>>>>  #define VIRTIO_BLK_T_DISCARD      11
> >>>>>>  #define VIRTIO_BLK_T_WRITE_ZEROES 13
> >>>>>>  #define VIRTIO_BLK_T_SECURE_ERASE   14
> >>>>>> +#define VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES   27
> >>>>>
> >>>>> The Linux virtio_blk.c driver assumes that odd numbered constants h=
ave
> >>>>> data buffers that are read by the device, so you may run into a bug=
 when
> >>>>> using 27.
> >>>>>
> >>>>> There is an informal convention to use even numbers for read reques=
ts
> >>>>> and odd numbers for write requests. It doesn't hurt to try to follo=
w the
> >>>>> convention even though it's not strictly necessary.
> >>>>>
> >>>>> The Linux driver could be fixed when adding support for ICE, but 16=
 is
> >>>>> available and it's safest to use that.
> >>>>
> >>>> OK. Agree to following the convention. But 16, 18,20,22,24,26 are al=
ready used by
> >>>> zone device. Seems 12 is available. Correct it to 12.
> >>>>
> >>>>  #define VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES   12
> >>>
> >>> In that case I suggest using 28. I don't remember what 12 was used for
> >>> but there may be a historical reason for the gap.
> >>
> >> Thanks! Change it to 28.
> >>
> >>>
> >>>>
> >>>>>
> >>>>>>  \end{lstlisting}
> >>>>>> =20
> >>>>>>  The \field{sector} number indicates the offset (multiplied by 512=
) where
> >>>>>>  the read or write is to occur. This field is unused and set to 0 =
for
> >>>>>>  commands other than read, write and some zone operations.
> >>>>>> =20
> >>>>>> +The \field{payload} consists of the encryption information for cu=
rrent
> >>>>>> +request. It is only present when the VIRTIO_BLK_F_ICE feature is =
negotiated and
> >>>>>> +\field{type} is VIRTIO_BLK_T_IN, VIRTIO_BLK_T_OUT or VIRTIO_BLK_T=
_FLUSH.
> >>>>>
> >>>>> TODO think about layout
> >>>>
> >>>> rewrite to the following
> >>>>
> >>>>   The \field{ice_payload} consists of the encryption information for=
 current
> >>>>   request. When VIRTIO_BLK_F_ICE is negotiated, the request header l=
ayout becomes
> >>>>   that struct virtio_blk_outhdr includes \field{ice_payload} as a fi=
xed-size
> >>>>   extension. For non-ICE requests (or types not using crypto), the d=
river MUST
> >>>>   set \field{ice_payload} to 0 and device ignores them.
> >>>
> >>> Sorry, the TODO was a comment to myself while writing my reply :).
> >>>
> >>> I forgot to investigate. Basically the issue is that the spec must be
> >>> clear on whether:
> >>> 1. A field is absent and fields that follow it are present in the str=
uct
> >>>    layout when a condition is false (e.g. type is not VIRTIO_BLK_T_IN,
> >>>    VIRTIO_BLK_T_OUT, or VIRTIO_BLK_T_FLUSH).
> >>> or
> >>> 2. A field is present but unused (zeroed) when a condition is false.
> >>>
> >>> #2 is usually easier to implement in code because it avoids creating
> >>> many different struct layouts at runtime depending on conditions like
> >>> negotiated feature bits.
> >>>
> >>> I was thinking that the ice fields should always be present but should
> >>> be zero when the feature bit is not negotiated or some other condition
> >>> (like the request type) is false. This way it will be much easier to =
add
> >>> additional fields later without worrying about struct layouts.
> >>>
> >>> This is how configuration space already works: the offset of the zoned
> >>> field is not affected by whether the device advertises the
> >>> VIRTIO_BLK_F_WRITE_ZEROES feature bit, it just means that the earlier
> >>> write_zeroes_may_unmap field may be unused. This approach should
> >>> probably be used everywhere and the spec language should be careful to
> >>> communicate that the field is still present but zero when unused. It's
> >>> okay for the driver to provide a shorter struct that doesn't include =
the
> >>> last field(s) to the device when the feature bit is not negotiated
> >>> though.
> >>
> >> Thanks. Refer to the statement you shared, try to rewrite it as the fo=
llowing.
> >>
> >>   The \field{ice_payload} consists of the encryption information for c=
urrent
> >>   request. It is not affected by whether the device advertises the
> >>   VIRTIO_BLK_F_ICE feature bit, it just SHOULD be zero when the featur=
e bit is
> >>   not negotiated or the \field{type} is not VIRTIO_BLK_T_IN, VIRTIO_BL=
K_T_OUT
> >>   or VIRTIO_BLK_T_FLUSH.=20
> >=20
> > Sounds good.
> >=20
> >>
> >>>
> >>>>
> >>>>>
> >>>>>> +\begin{itemize}
> >>>>>> +\item The \field{slot} field in \field{payload} indicates the ICE
> >>>>>> +  (Inline Crypto Encryption) slot index where the key resides.
> >>>>>> +
> >>>>>> +\item The \field{activate} field in \field{payload} implies this =
is a
> >>>>>> +  inline encryption request.
> >>>>>> +
> >>>>>> +\item The \field{data_unit_num} field in \field{payload} indicate=
s the
> >>>>>> +  starting block of the request.
> >>>>>
> >>>>> This is a block device, so the term "block" needs to be qualified to
> >>>>> avoid confusion. I guess this is the cryptography concept of a block
> >>>>> rather than the disk concept of a block. Please clarify this in the
> >>>>> text, maybe by explaining that the ICE handles data in fixed-size "=
data
> >>>>> units" instead of using the word "block".
> >>>>>
> >>>>> Also, can you explain the relationship between the data unit number=
 and
> >>>>> the sector? In simple cases I imagine the data unit number would be=
 the
> >>>>> sector. How is the driver supposed to pick or calculate the data un=
it
> >>>>> number?
> >>>>
> >>>> The data unit number is the starting IV for AES crypto in ICE hardwa=
re, it's
> >>>> a stable value for I/O request targeting to same storage range. It c=
an be set
> >>>> to the file logic block number or the starting sector of BIO.=20
> >>>
> >>> It sounds like the data unit number calculation is up to the driver
> >>> (from the device's perspective) and the important thing is that the s=
ame
> >>> data unit number will always be used when reading/writing the same
> >>> logical data location.
> >>
> >> Yes. Correct.
> >>
> >>>
> >>>> The upper layer calculates it and passes it to virtio_blk driver in =
this patch.
> >>>> ICE uses the data unit number and data unit size (the granularity to=
 use for
> >>>> en/decryption) to derive the next data unit number for the next cryp=
tography
> >>>> block. data unit number in ICE increase 1 per data unit size. For in=
stance,
> >>>>   data unit number =3D 2048
> >>>>   data unit size =3D 1024 bytes
> >>>> For the first 1024 bytes of the transaction, ICE hardware encrypt th=
e data
> >>>> with IV equal to 2048.
> >>>> For the second 1024 bytes of the transaction, ICE hardware encrypt t=
he data
> >>>> with IV equal to (2048+1=3D)2049.
> >>>>
> >>>> Rewrite it as bellow.
> >>>>
> >>>>   \item The \field{data_unit_num} field in \field{ice_payload} indic=
ates the
> >>>>   starting IV. It can be the file logic block number or the starting=
 sector
> >>>>   of BIO.
> >>>
> >>> BIO is a Linux-specific concept, so it would be best to avoid it in t=
he
> >>> VIRTIO spec.
> >>>
> >>>   \item The \field{data_unit_num} field in \field{ice_payload} indica=
tes
> >>>   the starting IV. In order to successfully encrypt/decrypt data this
> >>>   number must be the same for successive read and write operations to
> >>>   the same logical data location. The driver typically sets it to the
> >>>   file logical block number or the disk sector number.
> >>
> >> Thanks! ACK.
> >>
> >>>
> >>>>
> >>>>>
> >>>>>> +\end{itemize}
> >>>>>> +
> >>>>>>  VIRTIO_BLK_T_IN requests populate \field{data} with the contents =
of sectors
> >>>>>>  read from the block device (in multiples of 512 bytes).  VIRTIO_B=
LK_T_OUT
> >>>>>>  requests write the contents of \field{data} to the block device (=
in multiples
> >>>>>> @@ -530,6 +588,47 @@ \subsection{Device Operation}\label{sec:Devic=
e Types / Block Device / Device Ope
> >>>>>>  The \field{device_lifetime_est_typ_b} refers to wear of MLC cells=
 and is provided
> >>>>>>  with the same semantics as \field{device_lifetime_est_typ_a}.
> >>>>>> =20
> >>>>>> +VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests fetch the storage h=
ardware crypto
> >>>>>> +capabilities into \field{data}. And the \field{data} is of the fo=
rm
> >>>>>
> >>>>> How does VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES behave when data[] is=
 too
> >>>>> small to fit all the device's crypto capabilities?
> >>>>
> >>>> Add a new field capability_num to the Configuration space header. Th=
e total size of
> >>>> \field{data} shall be computed as:
> >>>>   data_size=3Dcapability_num=C3=97capability_size
> >>>> where capability_size is the size (in bytes) of one capability struc=
ture. Therefore, \field{data} contains exactly capability_num contiguous ca=
pability entries, each of length capability_size.
> >>>> Add a capability_num field in Configuration space. So it use size pe=
r capability
> >>>> multiply capability_num to define the size of \field{data}.
> >>>>
> >>>> Rewrite it as the following.
> >>>>
> >>>>   VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests fetch the storage ha=
rdware crypto
> >>>>   capabilities into \field{data}. The crypto capabilities is a zero-=
padded array
> >>>>   up to (\field{capability_num}=C3=97capability_size) bytes long, wh=
ere capability_size
> >>>>   is the size (in bytes) of one capability structure which is in for=
m of
> >>>>  =20
> >>>>   \begin{lstlisting}
> >>>>     struct virtio_blk_crypto_cap {
> >>>>         u8 alg;
> >>>>         u8 data_unit_size;
> >>>>         u8 key_size;
> >>>>         u8 reserved;
> >>>>     };
> >>>>   \end{lstlisting}
> >>>>  =20
> >>>>   \begin{itemize}
> >>>>       \item The \field{alg} implies crypto algorithm identifiers.
> >>>>       The device supports reporting and negotiating cryptographic al=
gorithms
> >>>>       using the following algorithm identifiers:
> >>>>       \begin{lstlisting}
> >>>>           CRYPTO_ALG_AES_XTS              =3D 0x0
> >>>>           CRYPTO_ALG_BITLOCKER_AES_CBC    =3D 0x1
> >>>>           CRYPTO_ALG_AES_ECB              =3D 0x2
> >>>>           CRYPTO_ALG_ESSIV_AES_CBC        =3D 0x3
> >>>>       \end{lstlisting}
> >>>>       These identifiers abstract the underlying hardware crypto impl=
ementation
> >>>>       and does not assume any operating=E2=80=91system=E2=80=91speci=
fic data structures or
> >>>>       constants.
> >>>>       \item The \field{data_unit_size} implies the mask of data unit=
 size. When
> >>>>       bit j in this field (j=3D7......0) is set, a data unit size of=
 512*2^j bytes
> >>>>       is selected.
> >>>>       \item The \field{key_size} is the crypto key size identifiers.
> >>>>       \begin{lstlisting}
> >>>>           CRYPTO_KEY_SIZE_INVALID     =3D 0x0
> >>>>           CRYPTO_KEY_SIZE_128_BITS    =3D 0x1
> >>>>           CRYPTO_KEY_SIZE_192_BITS    =3D 0x2
> >>>>           CRYPTO_KEY_SIZE_256_BITS    =3D 0x3
> >>>>           CRYPTO_KEY_SIZE_512_BITS    =3D 0x4
> >>>>       \end{lstlisting}
> >>>>       \item The \field{reserved} is unused.
> >>>>   \end{itemize}
> >>>>  =20
> >>>>   If the \field{data} is too short, it sets status to BLK_S_IO_ERR.
> >>>
> >>> Looks good. In the final sentence I suggest changing "it" to "the
> >>> device" for clarity.
> >>
> >> Thanks! Done.
> >>
> >>>
> >>>>
> >>>>>
> >>>>>> +
> >>>>>> +\begin{lstlisting}
> >>>>>> +struct virtio_blk_crypto_caps {
> >>>>>> +  u8 size;
> >>>>>> +  le32 crypto_capabilities[];
> >>>>>> +};
> >>>>>> +\end{lstlisting}
> >>>>>> +
> >>>>>> +The \field{size} specifies the size of array \field{crypto_capabi=
lities}.
> >>>>>
> >>>>> "number of elements" would be clearer than "size of array" because =
the
> >>>>> unit (bytes vs array elements) is ambiguous.
> >>>>>
> >>>>> The size field is not necessary since Used Ring descriptors contain
> >>>>> (struct virtq_used_elem in the spec) a len field indicating how many
> >>>>> bytes were written by the device.
> >>>>
> >>>> Remove virtio_blk_crypto_caps in above modification.
> >>>>
> >>>>>
> >>>>>> +The \field{crypto_capabilities} indicates the crypto capabilities=
 supported by the
> >>>>>> +hardware storage for inline encryption.
> >>>>>> +
> >>>>>> +A crypto capability packs four 8-bits values:
> >>>>>> +\begin{itemize}
> >>>>>> +    \item Bits~\[31:24]: crypto algorithm identifiers.
> >>>>>> +    The device supports reporting and negotiating cryptographic a=
lgorithms
> >>>>>> +    using the following algorithm identifiers:
> >>>>>> +    \begin{lstlisting}
> >>>>>> +        CRYPTO_ALG_AES_XTS              =3D 0x0
> >>>>>> +        CRYPTO_ALG_BITLOCKER_AES_CBC    =3D 0x1
> >>>>>> +        CRYPTO_ALG_AES_ECB              =3D 0x2
> >>>>>> +        CRYPTO_ALG_ESSIV_AES_CBC        =3D 0x3
> >>>>>> +    \end{lstlisting}
> >>>>>> +    These identifiers abstract the underlying hardware crypto imp=
lementation
> >>>>>> +    and does not assume any operating=E2=80=91system=E2=80=91spec=
ific data structures or
> >>>>>> +    constants.
> >>>>>> +    \item Bits~\[23:16]: mask of data unit size. When bit j in th=
is field
> >>>>>> +    (j=3D7......0) is set, a data unit size of 512*2^j bytes is s=
elected.
> >>>>>
> >>>>> Is only one bit ever set in the mask? If so, then maybe just expres=
s j
> >>>>> as an 8-bit unsigned integer (i.e. the exponent in 512*2^j) instead=
 of
> >>>>> as a bit mask. It's simpler and increases the range for j.
> >>>>
> >>>> Yes, it's encoded in one-hot encoding. If j is expressed as an 8-bit=
 unsigned integer,
> >>>> it will confused the reader that more than one bit can be set in the=
 mask of data unit
> >>>> size. right?=20
> >>>
> >>> If the field is called the data unit size exponent (data_unit_size_ex=
p)
> >>> then there is no confusion. I agree that calling it a mask would be
> >>> confusing.
> >>
> >> Thanks! Update it to data_unit_size_exp.
> >>
> >>>
> >>>>
> >>>>>
> >>>>>> +    \item Bits~\[15:8]: crypto key size identifiers.
> >>>>>> +    \begin{lstlisting}
> >>>>>> +        CRYPTO_KEY_SIZE_INVALID     =3D 0x0
> >>>>>> +        CRYPTO_KEY_SIZE_128_BITS    =3D 0x1
> >>>>>> +        CRYPTO_KEY_SIZE_192_BITS    =3D 0x2
> >>>>>> +        CRYPTO_KEY_SIZE_256_BITS    =3D 0x3
> >>>>>> +        CRYPTO_KEY_SIZE_512_BITS    =3D 0x4
> >>>>>> +    \end{lstlisting}
> >>>>>> +    \item Bits~\[7:0]: unused.
> >>>>>> +\end{itemize}
> >>>>>
> >>>>> A struct would be more natural here (the rest of the VIRTIO
> >>>>> specification rarely packs fields into an integer):
> >>>>>
> >>>>>   struct virtio_blk_crypto_cap {
> >>>>>       u8 alg;
> >>>>>       u8 data_unit_size;
> >>>>>       u8 key_size;
> >>>>>       u8 reserved;
> >>>>>   };
> >>>>
> >>>> ACK, see above rewrite statement.
> >>>>
> >>>>>
> >>>>> By the way, Linux seems to call this a "profile" rather than a
> >>>>> "capability". Do you want to use the same name as Linux for consist=
ency?
> >>>>
> >>>> blk-crypto-profile is the keyslot manager which manage the usage of =
keyslot and
> >>>> also checks if the key configuration set by upper layer can be suppo=
rted by the
> >>>> ICE hardware. While the capability aims to illustrate the capability=
 provided by
> >>>> the ICE hardware. What we expected is the capability used to initial=
ized
> >>>> blk-crypto-profile in Guest VM.
> >>>
> >>> I see.
> >>>
> >>>>
> >>>>>
> >>>>>> +
> >>>>>>  The final \field{status} byte is written by the device: either
> >>>>>>  VIRTIO_BLK_S_OK for success, VIRTIO_BLK_S_IOERR for device or dri=
ver
> >>>>>>  error or VIRTIO_BLK_S_UNSUPP for a request unsupported by device:
> >>>>>> @@ -912,6 +1011,13 @@ \subsection{Device Operation}\label{sec:Devi=
ce Types / Block Device / Device Ope
> >>>>>>  successfully, failed, or were processed by the device at all if t=
he request
> >>>>>>  failed with VIRTIO_BLK_S_IOERR.
> >>>>>> =20
> >>>>>> +The length of \field{data} MUST be a multiple of 4 bytes plus 1 f=
or
> >>>>>> +VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests.
> >>>>>> +
> >>>>>> +A driver MUST set \field{activate} to 1 for VIRTIO_BLK_T_IN,VIRTI=
O_BLK_T_OUT,
> >>>>>> +    and VIRTIO_BLK_T_FLUSH requests that require inline encryptio=
n. For other
> >>>>>> +    request types or when inline encryption is not required, it i=
s set to 0.
> >>>>>> +
> >>>>>>  The following requirements only apply if the VIRTIO_BLK_F_ZONED f=
eature is
> >>>>>>  negotiated.
> >>>>>
> >>>>> How does the driver assign a specific capability (algorithm, data u=
nit
> >>>>> size, and key size tuple reported by
> >>>>> VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES) to a slot?
> >>>>>
> >>>>> How does the driver assign the key material for a slot?
> >>>>
> >>>> blk layer will initialize a blk_crypto_key based on the configuratio=
n received from
> >>>> FS layer. This blk_crypto_key contains expected algorithm, data unit=
 size and key size expected
> >>>> by the upper layer. When submit_bio, blk_mq tries to program the key=
 included in blk_crypto_key
> >>>> to the ICE hardware slot via blk_crypto_profile. During programming =
the key, it will compare=20
> >>>> the algorithm, data unit size and key size in blk_crypto_key with th=
e capability exposed by ICE
> >>>> hardware.
> >>>>
> >>>> It will follow bellow flow to assign the key material for a slot.
> >>>>   blk_crypto_profile -> virtio_blk driver -> virtio_blk extention ->=
 SCM driver -> TZ
> >>>>
> >>>> That means the driver only maintain the capability in RAM, use it wh=
en programming key.
> >>>
> >>> I don't see an interface for programming the key in this spec patch. =
The
> >>> Linux block driver interface includes struct blk_crypto_ll_ops with
> >>> driver functions for programming keys. I expected this spec would add
> >>> operations to the virtio-blk device for implementing those functions?
> >>
> >> The design is that having a virtio_blk extension driver to handle the =
initialization of keyslot manager
> >> for virtio block with VIRTIO_BLK_F_ICE feature bit negociated. And thi=
s extension driver also define the
> >> implementation of struct blk_crypto_ll_ops with driver functions for p=
rogramming keys, evicting keys and
> >> derive raw keys. Thees 3 key operation is done in a 'out of band' chan=
nel, that LA GVM calls to TrustZone
> >> (or secure VM) directly via SCM driver, bypass PVM.
> >>
> >> Add a new Kconfig VIRTIO_BLK_INLINE_CRYPTO, and this config need alway=
s to be set as Y when inline encryption
> >> on virtio block is expected.
> >>
> >> In such scenario, the key programming/eviction/derivation doesn't affe=
ct the virtio block protocol, so I didn't
> >> add it in this patch. Do you think it's necessary to be shown in virti=
o SPEC in such design?
> >=20
> > It seems like supporting keyslot manager operations via the virtio-blk
> > device is a possible future use case. The design of VIRTIO_BLK_F_ICE
> > should allow for adding it in the future so that we can be confident
> > that no breaking changes will be needed.
> >=20
> > Why are the keyslot manager operations out of band in your TrustZone use
> > case? Maybe this is related to isolation between the PVM and GVM when
> > sharing a device, but it's not clear to me that isolation is actually
> > enforced, so then I see no need for out of band keyslot manager
> > operations.
> >=20
> > Stefan
>=20
> For ICE based disk encryption (like File-Based Encryption), keyslot manag=
er
> (implemeneted in blk-crypot-profile.c in latest kernel version) is respon=
sible
> for forwarding blk-crypto-key from block layer to the bottom layer (i.e.
> storage driver in Bare Metal) implementing blk_crypto_ll_ops for the key
> programming/eviction/derivation.=20
>=20
> So, for a whole inline encryption support in virtio block, virtio block d=
evice
> must register a keyslot manager and provide the corresponding implementat=
ion of
> blk_crypto_ll_ops.=20
>=20
> The reasons of using out-of-band channel are
>   1. In Bare Metal, the operation of key programming/eviction/derivation =
is also
>      through a out-of-band channel.
>      keyslot manager -> storage driver -> scm driver -> Trust Zone
>   2. Challenges of using in-band channel
>      a. Passing the blk-crypot-key to virtio blk backend in userspace thr=
ough the
>         virtqueue. The virtio blk backend need pass this blk-crypot-key t=
o block
>         layer of PVM/Host. But it's not easy to be implemented. Addtional=
 changes
>         (like adding SET_BLK_CRYPTO_KEY blk ioctl syscal) need to be adde=
d in block
>         layer. In additiona, virtio block backend uses pread/pwrite imple=
menting
>         I/O in backend, it must ensure that blk-crypto-key is always boun=
d to its
>         corresponded I/O operation.
>      b. For key eviction operation, it's totally irrelevant to I/O operat=
ion, the
>         block layer only pass the blk crypto key to virtio block device v=
ia keyslot
>         manager. Even refer to virtblk_get_id to send this request to vir=
tio blk
>         backend, it faces on similar issue like programming key, that how=
 to populate
>         blk-crypto-key to the block layer in PVM. Adding EVICT_KEY ioctl =
seems not a
>         acceptable way as it exposes key evivtion operation to the usersp=
ace.

Would you be able to post a slide deck that illustrates:

1. The bare metal architecture with a UFS ICE device, TrustZone, the
   kernel (block layer, file systems, etc), userspace applications doing
   I/O, etc.

2. The modified architecture with a virtio-blk ICE device with a virtual
   machine monitor running in host userspace (i.e. QEMU), the emulated
   virtio-blk device, PVM/GVM, etc.

If there is already existing documentation that shows the big picture,
that would be great. Otherwise it would help if you could draw the
diagrams.

I need to understand the architecture in order to review this further.

Thanks,
Stefan

--sLE+t8Lb/rFbRLt1
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmjxrQACgkQnKSrs4Gr
c8hyrQf/RSnET39tvcfpD802iVpxZxY54YQePX4skCMVXW8DY2x5uhqMwKrOIxoO
BgPTs+80S7/g3XgUolO7/v6/J19Dxy5KrEx35fN8fCUold1jLJH8FiTaoPaYANnr
ZJ9Aaz23YHD7SRV1sUlFJsEHgXDu6CRAMP743vCQYYK2ufeC/p0GOVCw0jc9ItXl
osKb+trBsGgAzhiKGiA2pEp+ys9DZkmRAh9q3hDH8nUt3kCy7RRedy45+cfr/oI1
QPoFJ4Tv5qVXjMm6VxB2CzOxwmkYsDPjjVM9JgTbdJx5LSunzL5c352Ts5nyn2Gz
1x6E1kKJKWm0WYhthRZlX9qb+cq90g==
=PkP3
-----END PGP SIGNATURE-----

--sLE+t8Lb/rFbRLt1--

