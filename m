Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A0930DEB0
	for <virtio-dev@lists.linux.dev>; Mon, 30 Mar 2026 18:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774894417; cv=none; b=BxMY6Ovc6TWmxlBPdmR/dVHUFhnLj4vL+hJhyw88rRJXpMV5i/t3pestxGAH7hVt5O97tdwKSIeyCZAZFKrbwxkfT5ZX1smKJZMjmwkczRqEgj9vST9gEpL5FJlSS5WQarc4eeZXbPqDerNa3XGlLK8y9rTXaJAvjvEQA7NHYZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774894417; c=relaxed/simple;
	bh=G34iQpdFs37jbcz1HUVr2XRTV1h3YObpWPaMkY9PAFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bi3UA6AAYBMX0a4nLRVxxpOymTRHtsFR07xRQojPxYwgF4zhM1H68xidZ98Rj3FPVwHxxI0Kuy72gnPbBOAAzJmfOJvjOBQ9NG+ZyHXiuKG1hsy+rv2Y5LSygNRUMJFokucMMqzjrUKbUgM09mALqNMPg0KhbndxGvuyXeX/ayQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=b+RbJ5vQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b+RbJ5vQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774894413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qkGlH3BNqptWc5/OD7rNOsEoa6b2h1CVKmvWYlCGq5c=;
	b=b+RbJ5vQkO8iAwZUBLImEw80FKxDQXiA6LNEnQt3lAg43zM0jo72sz/I+hZsZS2yrN7hL0
	Dq/KaXRJzGfnZQfYbAwArTkoWndxYGLbC+QsOs3l4qy9S2PVwD7bYoJNCATJiR56sv+9Kf
	4NXhpobRLG/qZfosgLlHAH60kID9AMI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-qL0KrSw1Ne6TqI8XAaMKMQ-1; Mon,
 30 Mar 2026 14:13:29 -0400
X-MC-Unique: qL0KrSw1Ne6TqI8XAaMKMQ-1
X-Mimecast-MFC-AGG-ID: qL0KrSw1Ne6TqI8XAaMKMQ_1774894408
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3C7AF19560B1;
	Mon, 30 Mar 2026 18:13:28 +0000 (UTC)
Received: from localhost (unknown [10.44.32.19])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BD45A30001A1;
	Mon, 30 Mar 2026 18:13:26 +0000 (UTC)
Date: Mon, 30 Mar 2026 11:32:30 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
Cc: Sebastian Mauritsson <sma@napatech.com>, virtio-dev@lists.linux.dev,
	quic_dshaikhu@quicinc.com
Subject: Re: [PATCH v2 1/1] virtio-blk: Add inline encryption support
Message-ID: <20260330153230.GD154632@fedora>
References: <20260210083208.472824-1-linlin.zhang@oss.qualcomm.com>
 <20260210083208.472824-2-linlin.zhang@oss.qualcomm.com>
 <20260210211842.GA158755@fedora>
 <fa458358-90c8-408c-a860-8bfdb11658bb@oss.qualcomm.com>
 <20260218215336.GD605390@fedora>
 <bca448cf-6c18-4c82-806d-f2a25579a02b@oss.qualcomm.com>
 <20260225095502.GB1653802@fedora>
 <22632a98-3d10-4c71-b579-d7aaefe8553d@oss.qualcomm.com>
 <20260301045516.GB42492@fedora>
 <112986be-3f22-45fe-ac68-6a2c172f629b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="CbfJVBSXguvosSGK"
Content-Disposition: inline
In-Reply-To: <112986be-3f22-45fe-ac68-6a2c172f629b@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4


--CbfJVBSXguvosSGK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 02, 2026 at 10:35:13PM +0800, Linlin Zhang wrote:
>=20
> Appreciate your review in detail. I attached the slide <FBE_virtualizatio=
n_proposal.pptx>. Please have a look and
> let me know if you have any concern. Thanks!

Hi Linlin,
Thanks for the slides. How does the TZ ICE driver validate GVM SCM
requests to prevent the GVM from performing key operations on physical
slots that do not belong to the GVM?

If the TZ ICE driver enforces isolation on the GVM SCM requests, then I
don't understand why the GVM uses physical slot indices. It could use
virtual slot indices and then the slot_offset field is not necessary.

If the TZ ICE driver does not enforce isolation, then there is probably
security problem with your design.

For the record, I prefer an in-band keyslot manager design where the
virtio-blk device provides the commands needed to program keys. That way
the virtio-blk interface is self-contained and does not depend on an
additional third-party component that requires extra drivers. It would
be cleaner to specify the key operations in virtio-blk and let
implementors decide how to implement them in the device rather than
exposing that to the (guest) driver.

The performance argument seems weak because every I/O request involves
the PVM anyway and keyslot manager operations should be much less
frequent than I/O requests.

The security argument of bypassing the PVM doesn't work because the PVM
can access GVM RAM anyway, so the key cannot be hidden even if the PVM
is bypassed during key operations.

I'm just sharing my opinions with you. I'd be happier for the key
operations to be included in virtio-blk, but I'm not an expert in ICE
and ultimately I'm fine with your approach as long as the design is
coherent and secure.

Stefan

>=20
> Linlin
>=20
> On 3/1/2026 12:55 PM, Stefan Hajnoczi wrote:
> > On Thu, Feb 26, 2026 at 09:34:01PM +0800, Linlin Zhang wrote:
> >>
> >>
> >> On 2/25/2026 5:55 PM, Stefan Hajnoczi wrote:
> >>> On Wed, Feb 25, 2026 at 01:33:17PM +0800, Linlin Zhang wrote:
> >>>>
> >>>>
> >>>> On 2/19/2026 5:53 AM, Stefan Hajnoczi wrote:
> >>>>> On Sat, Feb 14, 2026 at 03:22:21PM +0800, Linlin Zhang wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 2/11/2026 5:18 AM, Stefan Hajnoczi wrote:
> >>>>>>> On Tue, Feb 10, 2026 at 12:32:08AM -0800, Linlin Zhang wrote:
> >>>>>>>> Inline encryption on virtio block can only be supported when
> >>>>>>>> the new feature bit VIRTIO_BLK_F_ICE is negotiated.
> >>>>>>>>
> >>>>>>>> Extend struct virtio_blk_config and struct virtio_blk_req,
> >>>>>>>> so that crypto capabilities can be got in the frontend and
> >>>>>>>> encryption metadata can be sent to the backend, together with
> >>>>>>>> each I/O transaction.
> >>>>>>>>
> >>>>>>>> About the inline encryption on UFS or eMMC storage, please
> >>>>>>>> refer to the Linux inline encryption documentation:
> >>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.g=
it/tree/Documentation/block/inline-encryption.rst
> >>>>>>>>
> >>>>>>>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/238
> >>>>>>>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >>>>>>>> Signed-off-by: linlzhan <quic_linlzhan@quicinc.com>
> >>>>>>>> Signed-off-by: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
> >>>>>>>> ---
> >>>>>>>>  device-types/blk/description.tex | 110 ++++++++++++++++++++++++=
++++++-
> >>>>>>>>  1 file changed, 108 insertions(+), 2 deletions(-)
> >>>>>>>>
> >>>>>>>> diff --git a/device-types/blk/description.tex b/device-types/blk=
/description.tex
> >>>>>>>> index 2712ada..60f46af 100644
> >>>>>>>> --- a/device-types/blk/description.tex
> >>>>>>>> +++ b/device-types/blk/description.tex
> >>>>>>>> @@ -66,6 +66,11 @@ \subsection{Feature bits}\label{sec:Device Ty=
pes / Block Device / Feature bits}
> >>>>>>>>  	(ZNS). For brevity, these standard documents are referred as "=
ZBD standards"
> >>>>>>>>  	from this point on in the text.
> >>>>>>>> =20
> >>>>>>>> +\item[VIRTIO_BLK_F_ICE(22)] Inline Crypto Extensions are suppor=
ted. Only when this
> >>>>>>>> +     feature bit is negotiated, the device need expose crypto c=
haracteristics in
> >>>>>>>> +     configuration space and the driver need provide an extende=
d request header
> >>>>>>>> +     containing a crypto payload for block I/O.
> >>>>>>>
> >>>>>>> Most of the feature bit descriptions are brief and the details are
> >>>>>>> covered later in the spec. I suggest doing this here too:
> >>>>>>>
> >>>>>>>   \item[VIRTIO_BLK_F_ICE (22)] Device supports Inline Crypto Engi=
ne functionality.
> >>>>>>>
> >>>>>>> I changed the name from Inline Crypto Extensions to Inline Crypto=
 Engine
> >>>>>>> because that terminology is used in the Linux kernel. Web search =
results
> >>>>>>> also favor "inline crypto engine" over "inline crypto extensions"=
=2E Are
> >>>>>>> you okay with "engine"?
> >>>>>> Thanks! ACK
> >>>>>>
> >>>>>>>
> >>>>>>>> +
> >>>>>>>>  \end{description}
> >>>>>>>> =20
> >>>>>>>>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device=
 Types / Block Device / Feature bits / Legacy Interface: Feature bits}
> >>>>>>>> @@ -128,6 +133,10 @@ \subsection{Device configuration layout}\la=
bel{sec:Device Types / Block Device /
> >>>>>>>>                  u8 model;
> >>>>>>>>                  u8 unused2[3];
> >>>>>>>>          } zoned;
> >>>>>>>> +        struct virtio_blk_crypto_characteristics {
> >>>>>>>> +                __virtio16 slot_info;
> >>>>>>>> +                __virtio16 reserved;
> >>>>>>>> +        } crypto;
> >>>>>>>>  };
> >>>>>>>>  \end{lstlisting}
> >>>>>>>> =20
> >>>>>>>> @@ -215,6 +224,18 @@ \subsection{Device configuration layout}\la=
bel{sec:Device Types / Block Device /
> >>>>>>>>  terminated by the device with a "zone resources exceeded" error=
 as defined for
> >>>>>>>>  specific commands later.
> >>>>>>>> =20
> >>>>>>>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then in
> >>>>>>>> +\field{virtio_blk_crypto_characteristics},
> >>>>>>>> +\begin{itemize}
> >>>>>>>> +\item \field{slot_info} value packs two 8-bits values to reduce=
 the number of
> >>>>>>>
> >>>>>>> 8-bits -> 8-bit
> >>>>>>
> >>>>>> ACK
> >>>>>>
> >>>>>>>
> >>>>>>>> +    Configuration Space reads.
> >>>>>>>> +    \begin{itemize}
> >>>>>>>> +        \item Bits~\[15:8] (\emph{max\_slots}): the maximum num=
ber of supported
> >>>>>>>> +            crypto key slots.
> >>>>>>>> +        \item Bits~\[7:0] (\emph{slot\_offset}): an offset appl=
ied to slot numbering.
> >>>>>>>
> >>>>>>> What is the purpose of slot_offset? This field is not used much i=
n this
> >>>>>>> spec, maybe it can be removed?
> >>>>>>>
> >>>>>>> Does that mean only slots in the range [slot_offset:max_slots) are
> >>>>>>> available or does it mean that the range is
> >>>>>>> [slot_offset:slot_offset+max_slots)?
> >>>>>>
> >>>>>> Only slots within the range [slot_offset, slot_offset + max_slots)=
 are accessible to the
> >>>>>> VM. The slot_offset specifies the base physical ICE slot allocated=
 to the VM and is used
> >>>>>> to translate a virtual slot index into a physical slot.
> >>>>>>
> >>>>>> Because the GVM programs and evicts keys directly=E2=80=94without =
host/PVM involvement=E2=80=94it must
> >>>>>> supply the resolved physical slot when invoking key operations in =
TrustZone or the Secure
> >>>>>> VM.
> >>>>>
> >>>>> It's not clear to me how what you've described offers isolation bet=
ween
> >>>>> the PVM and the GVM. What stops the GVM from using key slots outsid=
e the
> >>>>> range that has been assigned to it?
> >>>>>
> >>>>> A few options for isolation come to mind:
> >>>>>
> >>>>> 1. Expose 2 separate virtio-blk devices, one of which is hidden fro=
m the
> >>>>>    GVM and only accessible to the PVM. The PVM can store its data o=
n the
> >>>>>    hidden device.
> >>>>>
> >>>>> 2. Some kind of VIRTIO Admin queue Virtual Function approach where =
the
> >>>>>    PVM can instantiate a virtual function (a sub-device) that the G=
VM is
> >>>>>    allowed to access with isolation enforced by the device.
> >>>>>
> >>>>> 3. A single device could be used but the GVM cannot access it direc=
tly
> >>>>>    and needs to go through the PVM.
> >>>>
> >>>> The slot isolation between GVM and PVM is implemented by the max slo=
ts allocated to the GVM and slot offset
> >>>> the GVM's starting slot relative to the physical starting slot.
> >>>>
> >>>> For instance, ICE hardware has 64 slots, the max slots allocated to =
the GVM is 32, and its slot offset is 20.
> >>>> The keyslot manager in the GVM ensure the virtual slot rang is [0,31=
], when programming a key, translate the
> >>>> virtual slot to a physical slot by using the slot offset, that means=
 the physical slot range this GVM used
> >>>> is [20,51].
> >>>>
> >>>> The max_slots and slot_offset are configured by PVM, and GVM's virti=
o frontend only gets them from the configuration
> >>>> space of its virtio devices. So PVM is responsible to ensure the phy=
sical slot range of the GVM is valid.
> >>>
> >>> I don't understand how isolation between the PVM and GVM works. To me=
 it
> >>> seems like if there is isolation, then it would not be necessary to
> >>> expose slot_offset to the GVM. And if there is no isolation, then this
> >>> design isn't safe because the PVM is not protected against the GVM.
> >>>
> >>> I'm probably missing something. Can you explain how isolation is
> >>> enforced?
> >>
> >> Appreciate your quick feedback!
> >>
> >> The key slots in ICE hardware are used by both PVM/Host and GVMs, the =
PVM/Host
> >> specifies the slot range of each VM used (including itself) by definin=
g starting
> >> slot offest and max slots per VM, ensure that there isn't overlapping =
b/w these
> >> slot ranges in physical slot level.
> >>
> >> In this way, if only the virtual slot in each VM doesn't exceed the ma=
x slots
> >> allocated to it, the access to its physical ICE slot for one VM doesn'=
 have impact
> >> on the ICE slots belonging to the range of other VMs.=20
> >>
> >> You mentioned "this design isn't safe because the PVM is not protected=
 against the
> >> GVM", do you mean that the slot_offest and/or max_slots of GVM are tam=
pered by a
> >> malixious program, leading to unexpected access from GVM to a physical=
 ICE slot
> >> allocated to PVM? If yes, I feel it's not a risk as kernel image can b=
e pretotected
> >> via dm-verity/AVB, it's impossible for an attacker to rewrite them in =
runtime from
> >> both PVM and GVM sides.
> >=20
> > There are two separate issues that are still unclear to me:
> > 1. The device appears to trust the guest to select valid slot indices.
> > 2. How the PVM/GVM share the device.
> >=20
> > About trusting the slot field:
> > - In VIRTIO the trust model is that the device does not trust the
> >   driver. This is necessary not just for reliability but also to prevent
> >   virtualized devices from being exploited by untrusted VMs (escaping
> >   confinement, consuming resources not allocated to the VM, etc).
> > - Given that the device cannot trust the driver, I don't understand why
> >   the interface is designed to require driver cooperation in choosing
> >   slot indices within the slot_offset/max_slots range.
> > - I expected the interface to expose a max_slots Configuration Space
> >   field but slot indices are in the range [0, max_slots) and are
> >   validated by the device.
>=20
> The FBE key programing/eviction in a out-of-band channel here is a compro=
mise for
> upstream. The reason I'll show it in the proposal slide.
>=20
> In such way, the GVM has to transfer the virtio slot to the physical slot=
, and send it
> to Trust Zone during key programming/eviction, bypass slot check in the P=
VM.
> So, slot_offset on hardware must also be provided by the PVM together wit=
h max_slots for
> the GVM. On the GVM side, the virtio block driver trusts that max_slots a=
nd slot_offest.
> The layers upper virtio block crypto exteansion driver only see the virtu=
al slots in the
> range [0, max_slots) and use it. Only when the virtual slot is passed to =
virtio block
> crypto exteansion driver, this exteansion driver will ensure the virtual =
slot is resided
> in [0, max_slots) and translates it to the physical slot by adding slot_o=
ffset.
>=20
> Sorry, I get your point about your second issue. Hope the slide can give =
you more
> information.
>=20
> >=20
> > About the PVM/GVM relationship, please see below where I'm asking about
> > the architecture of a system using ICE.
> >=20
> >>>
> >>>>
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>>> +    \end{itemize}
> >>>>>>>> +\end{itemize}
> >>>>>>>> +
> >>>>>>>>  \subsubsection{Legacy Interface: Device configuration layout}\l=
abel{sec:Device Types / Block Device / Device configuration layout / Legacy=
 Interface: Device configuration layout}
> >>>>>>>>  When using the legacy interface, transitional devices and drive=
rs
> >>>>>>>>  MUST format the fields in struct virtio_blk_config
> >>>>>>>> @@ -278,6 +299,10 @@ \subsection{Device Initialization}\label{se=
c:Device Types / Block Device / Devic
> >>>>>>>>      \field{zoned} can be read by the driver to determine the zo=
ne
> >>>>>>>>      characteristics of the device. All \field{zoned} fields are=
 read-only.
> >>>>>>>> =20
> >>>>>>>> +\item If the VIRTIO_BLK_F_ICE feature is negotiated, the fields=
 in
> >>>>>>>> +    \field{crypto} can be read by the driver to determine the i=
nline crypto
> >>>>>>>> +    characteristics of the device. All \field{crypto} fields ar=
e read-only.
> >>>>>>>> +
> >>>>>>>>  \end{enumerate}
> >>>>>>>> =20
> >>>>>>>>  \drivernormative{\subsubsection}{Device Initialization}{Device =
Types / Block Device / Device Initialization}
> >>>>>>>> @@ -317,6 +342,9 @@ \subsection{Device Initialization}\label{sec=
:Device Types / Block Device / Devic
> >>>>>>>>      driver SHOULD ignore all other fields in \field{zoned}.
> >>>>>>>>  \end{itemize}
> >>>>>>>> =20
> >>>>>>>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver =
MUST validate
> >>>>>>>> +    the max_slots in \field{slot_info} before the slot usage.
> >>>>>>>
> >>>>>>> I'm not sure how the driver is supposed to validate max_slots?
> >>>>>>
> >>>>>> It means the diver validate the virtual slot doesn't exceed the ma=
x_slots before translating
> >>>>>> this virtual slot to a physical slot by using slot_offset.=20
> >>>>>>
> >>>>>> Can I rewrite it as the following?
> >>>>>>
> >>>>>>   If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver M=
UST validate that
> >>>>>>   the virtual slot received from upper layer doesn't exceed the ma=
x_slots in
> >>>>>>   \field{slot_info} before the slot usage.
> >>>>>
> >>>>> The notion of an "upper layer" can be eliminated so that there is no
> >>>>> assumption about the software design in the driver:
> >>>>>
> >>>>>   If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver MU=
ST
> >>>>>   ensure that slot_offset <=3D \field{payload.slot} < slot_offset +
> >>>>>   max_slots, where slot_offset and max_slots are the values extract=
ed
> >>>>>   from \field{crypto.slot_info} in configuration space.
> >>>>
> >>>> ACK. Thanks!
> >>>>
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>>> +
> >>>>>>>>  \devicenormative{\subsubsection}{Device Initialization}{Device =
Types / Block Device / Device Initialization}
> >>>>>>>> =20
> >>>>>>>>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer =
it
> >>>>>>>> @@ -402,6 +430,13 @@ \subsection{Device Initialization}\label{se=
c:Device Types / Block Device / Devic
> >>>>>>>>  \item the device MUST initialize padding bytes \field{unused2} =
to 0.
> >>>>>>>>  \end{itemize}
> >>>>>>>> =20
> >>>>>>>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then the fields =
in \field{crypto}
> >>>>>>>> +struct in the configuration space MUST be set by the device.
> >>>>>>>> +\begin{itemize}
> >>>>>>>> +\item the \field{slot_info} field of \field{crypto} MUST be set=
 by the device to a
> >>>>>>>> +    max_slots in the higher 8 bits and slot_offset in the lower=
 8 bits.
> >>>>>>>> +\end{itemize}
> >>>>>>>
> >>>>>>> There is no need for the \begin{itemize} here. It contains no new
> >>>>>>> information. The fields were already described in the configurati=
on
> >>>>>>> space section and the previous sentence already said that the fie=
lds in
> >>>>>>> \field{crypto} must be set by the device.
> >>>>>>
> >>>>>> ACK, remove this \begin{itemize} here.
> >>>>>>
> >>>>>>>
> >>>>>>>> +
> >>>>>>>>  \subsubsection{Legacy Interface: Device Initialization}\label{s=
ec:Device Types / Block Device / Device Initialization / Legacy Interface: =
Device Initialization}
> >>>>>>>> =20
> >>>>>>>>  Because legacy devices do not have FEATURES_OK, transitional de=
vices
> >>>>>>>> @@ -436,6 +471,13 @@ \subsection{Device Operation}\label{sec:Dev=
ice Types / Block Device / Device Ope
> >>>>>>>>          le32 type;
> >>>>>>>>          le32 reserved;
> >>>>>>>>          le64 sector;
> >>>>>>>> +        struct virtio_blk_crypto_payload {
> >>>>>>>> +            u8 slot;
> >>>>>>>> +            u8 activate;
> >>>>>>>> +            le16 reserved1;
> >>>>>>>> +            le32 reserved2;
> >>>>>>>> +            le64 data_unit_num;
> >>>>>>>> +        } payload;
> >>>>>>>
> >>>>>>> "payload" is a generic term. crypto_payload would be clearer.
> >>>>>>>
> >>>>>>> I wonder whether consistently calling this feature "ice" rather t=
han
> >>>>>>> "crypto" would help in case self-encrypting drive or other crypto=
graphic
> >>>>>>> functionality is added to virtio-blk in the future. That way the =
spec
> >>>>>>> items related to inline crypto engine functionality will be easy =
to
> >>>>>>> differentiate from other crypto functionality.
> >>>>>>
> >>>>>> Ok, to differentiate ICE and other cryptographic functionality, ca=
n I modify it as
> >>>>>>
> >>>>>>   struct virtio_blk_ice_payload {
> >>>>>>       u8 slot;
> >>>>>>       u8 activate;
> >>>>>>       le16 reserved1;
> >>>>>>       le32 reserved2;
> >>>>>>       le64 data_unit_num;
> >>>>>>   } ice_payload;
> >>>>>
> >>>>> Looks good to me, thanks.
> >>>>
> >>>> Thanks!
> >>>>
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>>>          u8 data[];
> >>>>>>>>          u8 status;
> >>>>>>>>  };
> >>>>>>>> @@ -445,8 +487,9 @@ \subsection{Device Operation}\label{sec:Devi=
ce Types / Block Device / Device Ope
> >>>>>>>>  (VIRTIO_BLK_T_OUT), a discard (VIRTIO_BLK_T_DISCARD), a write z=
eroes
> >>>>>>>>  (VIRTIO_BLK_T_WRITE_ZEROES), a flush (VIRTIO_BLK_T_FLUSH), a ge=
t device ID
> >>>>>>>>  string command (VIRTIO_BLK_T_GET_ID), a secure erase
> >>>>>>>> -(VIRTIO_BLK_T_SECURE_ERASE), or a get device lifetime command
> >>>>>>>> -(VIRTIO_BLK_T_GET_LIFETIME).
> >>>>>>>> +(VIRTIO_BLK_T_SECURE_ERASE), a get device lifetime command
> >>>>>>>> +(VIRTIO_BLK_T_GET_LIFETIME), or a get device crypto capabilitie=
s command
> >>>>>>>> +(VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES).
> >>>>>>>> =20
> >>>>>>>>  \begin{lstlisting}
> >>>>>>>>  #define VIRTIO_BLK_T_IN           0
> >>>>>>>> @@ -457,12 +500,27 @@ \subsection{Device Operation}\label{sec:De=
vice Types / Block Device / Device Ope
> >>>>>>>>  #define VIRTIO_BLK_T_DISCARD      11
> >>>>>>>>  #define VIRTIO_BLK_T_WRITE_ZEROES 13
> >>>>>>>>  #define VIRTIO_BLK_T_SECURE_ERASE   14
> >>>>>>>> +#define VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES   27
> >>>>>>>
> >>>>>>> The Linux virtio_blk.c driver assumes that odd numbered constants=
 have
> >>>>>>> data buffers that are read by the device, so you may run into a b=
ug when
> >>>>>>> using 27.
> >>>>>>>
> >>>>>>> There is an informal convention to use even numbers for read requ=
ests
> >>>>>>> and odd numbers for write requests. It doesn't hurt to try to fol=
low the
> >>>>>>> convention even though it's not strictly necessary.
> >>>>>>>
> >>>>>>> The Linux driver could be fixed when adding support for ICE, but =
16 is
> >>>>>>> available and it's safest to use that.
> >>>>>>
> >>>>>> OK. Agree to following the convention. But 16, 18,20,22,24,26 are =
already used by
> >>>>>> zone device. Seems 12 is available. Correct it to 12.
> >>>>>>
> >>>>>>  #define VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES   12
> >>>>>
> >>>>> In that case I suggest using 28. I don't remember what 12 was used =
for
> >>>>> but there may be a historical reason for the gap.
> >>>>
> >>>> Thanks! Change it to 28.
> >>>>
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>>>  \end{lstlisting}
> >>>>>>>> =20
> >>>>>>>>  The \field{sector} number indicates the offset (multiplied by 5=
12) where
> >>>>>>>>  the read or write is to occur. This field is unused and set to =
0 for
> >>>>>>>>  commands other than read, write and some zone operations.
> >>>>>>>> =20
> >>>>>>>> +The \field{payload} consists of the encryption information for =
current
> >>>>>>>> +request. It is only present when the VIRTIO_BLK_F_ICE feature i=
s negotiated and
> >>>>>>>> +\field{type} is VIRTIO_BLK_T_IN, VIRTIO_BLK_T_OUT or VIRTIO_BLK=
_T_FLUSH.
> >>>>>>>
> >>>>>>> TODO think about layout
> >>>>>>
> >>>>>> rewrite to the following
> >>>>>>
> >>>>>>   The \field{ice_payload} consists of the encryption information f=
or current
> >>>>>>   request. When VIRTIO_BLK_F_ICE is negotiated, the request header=
 layout becomes
> >>>>>>   that struct virtio_blk_outhdr includes \field{ice_payload} as a =
fixed-size
> >>>>>>   extension. For non-ICE requests (or types not using crypto), the=
 driver MUST
> >>>>>>   set \field{ice_payload} to 0 and device ignores them.
> >>>>>
> >>>>> Sorry, the TODO was a comment to myself while writing my reply :).
> >>>>>
> >>>>> I forgot to investigate. Basically the issue is that the spec must =
be
> >>>>> clear on whether:
> >>>>> 1. A field is absent and fields that follow it are present in the s=
truct
> >>>>>    layout when a condition is false (e.g. type is not VIRTIO_BLK_T_=
IN,
> >>>>>    VIRTIO_BLK_T_OUT, or VIRTIO_BLK_T_FLUSH).
> >>>>> or
> >>>>> 2. A field is present but unused (zeroed) when a condition is false.
> >>>>>
> >>>>> #2 is usually easier to implement in code because it avoids creating
> >>>>> many different struct layouts at runtime depending on conditions li=
ke
> >>>>> negotiated feature bits.
> >>>>>
> >>>>> I was thinking that the ice fields should always be present but sho=
uld
> >>>>> be zero when the feature bit is not negotiated or some other condit=
ion
> >>>>> (like the request type) is false. This way it will be much easier t=
o add
> >>>>> additional fields later without worrying about struct layouts.
> >>>>>
> >>>>> This is how configuration space already works: the offset of the zo=
ned
> >>>>> field is not affected by whether the device advertises the
> >>>>> VIRTIO_BLK_F_WRITE_ZEROES feature bit, it just means that the earli=
er
> >>>>> write_zeroes_may_unmap field may be unused. This approach should
> >>>>> probably be used everywhere and the spec language should be careful=
 to
> >>>>> communicate that the field is still present but zero when unused. I=
t's
> >>>>> okay for the driver to provide a shorter struct that doesn't includ=
e the
> >>>>> last field(s) to the device when the feature bit is not negotiated
> >>>>> though.
> >>>>
> >>>> Thanks. Refer to the statement you shared, try to rewrite it as the =
following.
> >>>>
> >>>>   The \field{ice_payload} consists of the encryption information for=
 current
> >>>>   request. It is not affected by whether the device advertises the
> >>>>   VIRTIO_BLK_F_ICE feature bit, it just SHOULD be zero when the feat=
ure bit is
> >>>>   not negotiated or the \field{type} is not VIRTIO_BLK_T_IN, VIRTIO_=
BLK_T_OUT
> >>>>   or VIRTIO_BLK_T_FLUSH.=20
> >>>
> >>> Sounds good.
> >>>
> >>>>
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>>> +\begin{itemize}
> >>>>>>>> +\item The \field{slot} field in \field{payload} indicates the I=
CE
> >>>>>>>> +  (Inline Crypto Encryption) slot index where the key resides.
> >>>>>>>> +
> >>>>>>>> +\item The \field{activate} field in \field{payload} implies thi=
s is a
> >>>>>>>> +  inline encryption request.
> >>>>>>>> +
> >>>>>>>> +\item The \field{data_unit_num} field in \field{payload} indica=
tes the
> >>>>>>>> +  starting block of the request.
> >>>>>>>
> >>>>>>> This is a block device, so the term "block" needs to be qualified=
 to
> >>>>>>> avoid confusion. I guess this is the cryptography concept of a bl=
ock
> >>>>>>> rather than the disk concept of a block. Please clarify this in t=
he
> >>>>>>> text, maybe by explaining that the ICE handles data in fixed-size=
 "data
> >>>>>>> units" instead of using the word "block".
> >>>>>>>
> >>>>>>> Also, can you explain the relationship between the data unit numb=
er and
> >>>>>>> the sector? In simple cases I imagine the data unit number would =
be the
> >>>>>>> sector. How is the driver supposed to pick or calculate the data =
unit
> >>>>>>> number?
> >>>>>>
> >>>>>> The data unit number is the starting IV for AES crypto in ICE hard=
ware, it's
> >>>>>> a stable value for I/O request targeting to same storage range. It=
 can be set
> >>>>>> to the file logic block number or the starting sector of BIO.=20
> >>>>>
> >>>>> It sounds like the data unit number calculation is up to the driver
> >>>>> (from the device's perspective) and the important thing is that the=
 same
> >>>>> data unit number will always be used when reading/writing the same
> >>>>> logical data location.
> >>>>
> >>>> Yes. Correct.
> >>>>
> >>>>>
> >>>>>> The upper layer calculates it and passes it to virtio_blk driver i=
n this patch.
> >>>>>> ICE uses the data unit number and data unit size (the granularity =
to use for
> >>>>>> en/decryption) to derive the next data unit number for the next cr=
yptography
> >>>>>> block. data unit number in ICE increase 1 per data unit size. For =
instance,
> >>>>>>   data unit number =3D 2048
> >>>>>>   data unit size =3D 1024 bytes
> >>>>>> For the first 1024 bytes of the transaction, ICE hardware encrypt =
the data
> >>>>>> with IV equal to 2048.
> >>>>>> For the second 1024 bytes of the transaction, ICE hardware encrypt=
 the data
> >>>>>> with IV equal to (2048+1=3D)2049.
> >>>>>>
> >>>>>> Rewrite it as bellow.
> >>>>>>
> >>>>>>   \item The \field{data_unit_num} field in \field{ice_payload} ind=
icates the
> >>>>>>   starting IV. It can be the file logic block number or the starti=
ng sector
> >>>>>>   of BIO.
> >>>>>
> >>>>> BIO is a Linux-specific concept, so it would be best to avoid it in=
 the
> >>>>> VIRTIO spec.
> >>>>>
> >>>>>   \item The \field{data_unit_num} field in \field{ice_payload} indi=
cates
> >>>>>   the starting IV. In order to successfully encrypt/decrypt data th=
is
> >>>>>   number must be the same for successive read and write operations =
to
> >>>>>   the same logical data location. The driver typically sets it to t=
he
> >>>>>   file logical block number or the disk sector number.
> >>>>
> >>>> Thanks! ACK.
> >>>>
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>>> +\end{itemize}
> >>>>>>>> +
> >>>>>>>>  VIRTIO_BLK_T_IN requests populate \field{data} with the content=
s of sectors
> >>>>>>>>  read from the block device (in multiples of 512 bytes).  VIRTIO=
_BLK_T_OUT
> >>>>>>>>  requests write the contents of \field{data} to the block device=
 (in multiples
> >>>>>>>> @@ -530,6 +588,47 @@ \subsection{Device Operation}\label{sec:Dev=
ice Types / Block Device / Device Ope
> >>>>>>>>  The \field{device_lifetime_est_typ_b} refers to wear of MLC cel=
ls and is provided
> >>>>>>>>  with the same semantics as \field{device_lifetime_est_typ_a}.
> >>>>>>>> =20
> >>>>>>>> +VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests fetch the storage=
 hardware crypto
> >>>>>>>> +capabilities into \field{data}. And the \field{data} is of the =
form
> >>>>>>>
> >>>>>>> How does VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES behave when data[] =
is too
> >>>>>>> small to fit all the device's crypto capabilities?
> >>>>>>
> >>>>>> Add a new field capability_num to the Configuration space header. =
The total size of
> >>>>>> \field{data} shall be computed as:
> >>>>>>   data_size=3Dcapability_num=C3=97capability_size
> >>>>>> where capability_size is the size (in bytes) of one capability str=
ucture. Therefore, \field{data} contains exactly capability_num contiguous =
capability entries, each of length capability_size.
> >>>>>> Add a capability_num field in Configuration space. So it use size =
per capability
> >>>>>> multiply capability_num to define the size of \field{data}.
> >>>>>>
> >>>>>> Rewrite it as the following.
> >>>>>>
> >>>>>>   VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests fetch the storage =
hardware crypto
> >>>>>>   capabilities into \field{data}. The crypto capabilities is a zer=
o-padded array
> >>>>>>   up to (\field{capability_num}=C3=97capability_size) bytes long, =
where capability_size
> >>>>>>   is the size (in bytes) of one capability structure which is in f=
orm of
> >>>>>>  =20
> >>>>>>   \begin{lstlisting}
> >>>>>>     struct virtio_blk_crypto_cap {
> >>>>>>         u8 alg;
> >>>>>>         u8 data_unit_size;
> >>>>>>         u8 key_size;
> >>>>>>         u8 reserved;
> >>>>>>     };
> >>>>>>   \end{lstlisting}
> >>>>>>  =20
> >>>>>>   \begin{itemize}
> >>>>>>       \item The \field{alg} implies crypto algorithm identifiers.
> >>>>>>       The device supports reporting and negotiating cryptographic =
algorithms
> >>>>>>       using the following algorithm identifiers:
> >>>>>>       \begin{lstlisting}
> >>>>>>           CRYPTO_ALG_AES_XTS              =3D 0x0
> >>>>>>           CRYPTO_ALG_BITLOCKER_AES_CBC    =3D 0x1
> >>>>>>           CRYPTO_ALG_AES_ECB              =3D 0x2
> >>>>>>           CRYPTO_ALG_ESSIV_AES_CBC        =3D 0x3
> >>>>>>       \end{lstlisting}
> >>>>>>       These identifiers abstract the underlying hardware crypto im=
plementation
> >>>>>>       and does not assume any operating=E2=80=91system=E2=80=91spe=
cific data structures or
> >>>>>>       constants.
> >>>>>>       \item The \field{data_unit_size} implies the mask of data un=
it size. When
> >>>>>>       bit j in this field (j=3D7......0) is set, a data unit size =
of 512*2^j bytes
> >>>>>>       is selected.
> >>>>>>       \item The \field{key_size} is the crypto key size identifier=
s.
> >>>>>>       \begin{lstlisting}
> >>>>>>           CRYPTO_KEY_SIZE_INVALID     =3D 0x0
> >>>>>>           CRYPTO_KEY_SIZE_128_BITS    =3D 0x1
> >>>>>>           CRYPTO_KEY_SIZE_192_BITS    =3D 0x2
> >>>>>>           CRYPTO_KEY_SIZE_256_BITS    =3D 0x3
> >>>>>>           CRYPTO_KEY_SIZE_512_BITS    =3D 0x4
> >>>>>>       \end{lstlisting}
> >>>>>>       \item The \field{reserved} is unused.
> >>>>>>   \end{itemize}
> >>>>>>  =20
> >>>>>>   If the \field{data} is too short, it sets status to BLK_S_IO_ERR.
> >>>>>
> >>>>> Looks good. In the final sentence I suggest changing "it" to "the
> >>>>> device" for clarity.
> >>>>
> >>>> Thanks! Done.
> >>>>
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>>> +
> >>>>>>>> +\begin{lstlisting}
> >>>>>>>> +struct virtio_blk_crypto_caps {
> >>>>>>>> +  u8 size;
> >>>>>>>> +  le32 crypto_capabilities[];
> >>>>>>>> +};
> >>>>>>>> +\end{lstlisting}
> >>>>>>>> +
> >>>>>>>> +The \field{size} specifies the size of array \field{crypto_capa=
bilities}.
> >>>>>>>
> >>>>>>> "number of elements" would be clearer than "size of array" becaus=
e the
> >>>>>>> unit (bytes vs array elements) is ambiguous.
> >>>>>>>
> >>>>>>> The size field is not necessary since Used Ring descriptors conta=
in
> >>>>>>> (struct virtq_used_elem in the spec) a len field indicating how m=
any
> >>>>>>> bytes were written by the device.
> >>>>>>
> >>>>>> Remove virtio_blk_crypto_caps in above modification.
> >>>>>>
> >>>>>>>
> >>>>>>>> +The \field{crypto_capabilities} indicates the crypto capabiliti=
es supported by the
> >>>>>>>> +hardware storage for inline encryption.
> >>>>>>>> +
> >>>>>>>> +A crypto capability packs four 8-bits values:
> >>>>>>>> +\begin{itemize}
> >>>>>>>> +    \item Bits~\[31:24]: crypto algorithm identifiers.
> >>>>>>>> +    The device supports reporting and negotiating cryptographic=
 algorithms
> >>>>>>>> +    using the following algorithm identifiers:
> >>>>>>>> +    \begin{lstlisting}
> >>>>>>>> +        CRYPTO_ALG_AES_XTS              =3D 0x0
> >>>>>>>> +        CRYPTO_ALG_BITLOCKER_AES_CBC    =3D 0x1
> >>>>>>>> +        CRYPTO_ALG_AES_ECB              =3D 0x2
> >>>>>>>> +        CRYPTO_ALG_ESSIV_AES_CBC        =3D 0x3
> >>>>>>>> +    \end{lstlisting}
> >>>>>>>> +    These identifiers abstract the underlying hardware crypto i=
mplementation
> >>>>>>>> +    and does not assume any operating=E2=80=91system=E2=80=91sp=
ecific data structures or
> >>>>>>>> +    constants.
> >>>>>>>> +    \item Bits~\[23:16]: mask of data unit size. When bit j in =
this field
> >>>>>>>> +    (j=3D7......0) is set, a data unit size of 512*2^j bytes is=
 selected.
> >>>>>>>
> >>>>>>> Is only one bit ever set in the mask? If so, then maybe just expr=
ess j
> >>>>>>> as an 8-bit unsigned integer (i.e. the exponent in 512*2^j) inste=
ad of
> >>>>>>> as a bit mask. It's simpler and increases the range for j.
> >>>>>>
> >>>>>> Yes, it's encoded in one-hot encoding. If j is expressed as an 8-b=
it unsigned integer,
> >>>>>> it will confused the reader that more than one bit can be set in t=
he mask of data unit
> >>>>>> size. right?=20
> >>>>>
> >>>>> If the field is called the data unit size exponent (data_unit_size_=
exp)
> >>>>> then there is no confusion. I agree that calling it a mask would be
> >>>>> confusing.
> >>>>
> >>>> Thanks! Update it to data_unit_size_exp.
> >>>>
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>>> +    \item Bits~\[15:8]: crypto key size identifiers.
> >>>>>>>> +    \begin{lstlisting}
> >>>>>>>> +        CRYPTO_KEY_SIZE_INVALID     =3D 0x0
> >>>>>>>> +        CRYPTO_KEY_SIZE_128_BITS    =3D 0x1
> >>>>>>>> +        CRYPTO_KEY_SIZE_192_BITS    =3D 0x2
> >>>>>>>> +        CRYPTO_KEY_SIZE_256_BITS    =3D 0x3
> >>>>>>>> +        CRYPTO_KEY_SIZE_512_BITS    =3D 0x4
> >>>>>>>> +    \end{lstlisting}
> >>>>>>>> +    \item Bits~\[7:0]: unused.
> >>>>>>>> +\end{itemize}
> >>>>>>>
> >>>>>>> A struct would be more natural here (the rest of the VIRTIO
> >>>>>>> specification rarely packs fields into an integer):
> >>>>>>>
> >>>>>>>   struct virtio_blk_crypto_cap {
> >>>>>>>       u8 alg;
> >>>>>>>       u8 data_unit_size;
> >>>>>>>       u8 key_size;
> >>>>>>>       u8 reserved;
> >>>>>>>   };
> >>>>>>
> >>>>>> ACK, see above rewrite statement.
> >>>>>>
> >>>>>>>
> >>>>>>> By the way, Linux seems to call this a "profile" rather than a
> >>>>>>> "capability". Do you want to use the same name as Linux for consi=
stency?
> >>>>>>
> >>>>>> blk-crypto-profile is the keyslot manager which manage the usage o=
f keyslot and
> >>>>>> also checks if the key configuration set by upper layer can be sup=
ported by the
> >>>>>> ICE hardware. While the capability aims to illustrate the capabili=
ty provided by
> >>>>>> the ICE hardware. What we expected is the capability used to initi=
alized
> >>>>>> blk-crypto-profile in Guest VM.
> >>>>>
> >>>>> I see.
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>>> +
> >>>>>>>>  The final \field{status} byte is written by the device: either
> >>>>>>>>  VIRTIO_BLK_S_OK for success, VIRTIO_BLK_S_IOERR for device or d=
river
> >>>>>>>>  error or VIRTIO_BLK_S_UNSUPP for a request unsupported by devic=
e:
> >>>>>>>> @@ -912,6 +1011,13 @@ \subsection{Device Operation}\label{sec:De=
vice Types / Block Device / Device Ope
> >>>>>>>>  successfully, failed, or were processed by the device at all if=
 the request
> >>>>>>>>  failed with VIRTIO_BLK_S_IOERR.
> >>>>>>>> =20
> >>>>>>>> +The length of \field{data} MUST be a multiple of 4 bytes plus 1=
 for
> >>>>>>>> +VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests.
> >>>>>>>> +
> >>>>>>>> +A driver MUST set \field{activate} to 1 for VIRTIO_BLK_T_IN,VIR=
TIO_BLK_T_OUT,
> >>>>>>>> +    and VIRTIO_BLK_T_FLUSH requests that require inline encrypt=
ion. For other
> >>>>>>>> +    request types or when inline encryption is not required, it=
 is set to 0.
> >>>>>>>> +
> >>>>>>>>  The following requirements only apply if the VIRTIO_BLK_F_ZONED=
 feature is
> >>>>>>>>  negotiated.
> >>>>>>>
> >>>>>>> How does the driver assign a specific capability (algorithm, data=
 unit
> >>>>>>> size, and key size tuple reported by
> >>>>>>> VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES) to a slot?
> >>>>>>>
> >>>>>>> How does the driver assign the key material for a slot?
> >>>>>>
> >>>>>> blk layer will initialize a blk_crypto_key based on the configurat=
ion received from
> >>>>>> FS layer. This blk_crypto_key contains expected algorithm, data un=
it size and key size expected
> >>>>>> by the upper layer. When submit_bio, blk_mq tries to program the k=
ey included in blk_crypto_key
> >>>>>> to the ICE hardware slot via blk_crypto_profile. During programmin=
g the key, it will compare=20
> >>>>>> the algorithm, data unit size and key size in blk_crypto_key with =
the capability exposed by ICE
> >>>>>> hardware.
> >>>>>>
> >>>>>> It will follow bellow flow to assign the key material for a slot.
> >>>>>>   blk_crypto_profile -> virtio_blk driver -> virtio_blk extention =
-> SCM driver -> TZ
> >>>>>>
> >>>>>> That means the driver only maintain the capability in RAM, use it =
when programming key.
> >>>>>
> >>>>> I don't see an interface for programming the key in this spec patch=
=2E The
> >>>>> Linux block driver interface includes struct blk_crypto_ll_ops with
> >>>>> driver functions for programming keys. I expected this spec would a=
dd
> >>>>> operations to the virtio-blk device for implementing those function=
s?
> >>>>
> >>>> The design is that having a virtio_blk extension driver to handle th=
e initialization of keyslot manager
> >>>> for virtio block with VIRTIO_BLK_F_ICE feature bit negociated. And t=
his extension driver also define the
> >>>> implementation of struct blk_crypto_ll_ops with driver functions for=
 programming keys, evicting keys and
> >>>> derive raw keys. Thees 3 key operation is done in a 'out of band' ch=
annel, that LA GVM calls to TrustZone
> >>>> (or secure VM) directly via SCM driver, bypass PVM.
> >>>>
> >>>> Add a new Kconfig VIRTIO_BLK_INLINE_CRYPTO, and this config need alw=
ays to be set as Y when inline encryption
> >>>> on virtio block is expected.
> >>>>
> >>>> In such scenario, the key programming/eviction/derivation doesn't af=
fect the virtio block protocol, so I didn't
> >>>> add it in this patch. Do you think it's necessary to be shown in vir=
tio SPEC in such design?
> >>>
> >>> It seems like supporting keyslot manager operations via the virtio-blk
> >>> device is a possible future use case. The design of VIRTIO_BLK_F_ICE
> >>> should allow for adding it in the future so that we can be confident
> >>> that no breaking changes will be needed.
> >>>
> >>> Why are the keyslot manager operations out of band in your TrustZone =
use
> >>> case? Maybe this is related to isolation between the PVM and GVM when
> >>> sharing a device, but it's not clear to me that isolation is actually
> >>> enforced, so then I see no need for out of band keyslot manager
> >>> operations.
> >>>
> >>> Stefan
> >>
> >> For ICE based disk encryption (like File-Based Encryption), keyslot ma=
nager
> >> (implemeneted in blk-crypot-profile.c in latest kernel version) is res=
ponsible
> >> for forwarding blk-crypto-key from block layer to the bottom layer (i.=
e.
> >> storage driver in Bare Metal) implementing blk_crypto_ll_ops for the k=
ey
> >> programming/eviction/derivation.=20
> >>
> >> So, for a whole inline encryption support in virtio block, virtio bloc=
k device
> >> must register a keyslot manager and provide the corresponding implemen=
tation of
> >> blk_crypto_ll_ops.=20
> >>
> >> The reasons of using out-of-band channel are
> >>   1. In Bare Metal, the operation of key programming/eviction/derivati=
on is also
> >>      through a out-of-band channel.
> >>      keyslot manager -> storage driver -> scm driver -> Trust Zone
> >>   2. Challenges of using in-band channel
> >>      a. Passing the blk-crypot-key to virtio blk backend in userspace =
through the
> >>         virtqueue. The virtio blk backend need pass this blk-crypot-ke=
y to block
> >>         layer of PVM/Host. But it's not easy to be implemented. Addtio=
nal changes
> >>         (like adding SET_BLK_CRYPTO_KEY blk ioctl syscal) need to be a=
dded in block
> >>         layer. In additiona, virtio block backend uses pread/pwrite im=
plementing
> >>         I/O in backend, it must ensure that blk-crypto-key is always b=
ound to its
> >>         corresponded I/O operation.
> >>      b. For key eviction operation, it's totally irrelevant to I/O ope=
ration, the
> >>         block layer only pass the blk crypto key to virtio block devic=
e via keyslot
> >>         manager. Even refer to virtblk_get_id to send this request to =
virtio blk
> >>         backend, it faces on similar issue like programming key, that =
how to populate
> >>         blk-crypto-key to the block layer in PVM. Adding EVICT_KEY ioc=
tl seems not a
> >>         acceptable way as it exposes key evivtion operation to the use=
rspace.
> >=20
> > Would you be able to post a slide deck that illustrates:
> >=20
> > 1. The bare metal architecture with a UFS ICE device, TrustZone, the
> >    kernel (block layer, file systems, etc), userspace applications doing
> >    I/O, etc.
> >=20
> > 2. The modified architecture with a virtio-blk ICE device with a virtual
> >    machine monitor running in host userspace (i.e. QEMU), the emulated
> >    virtio-blk device, PVM/GVM, etc.
> >=20
> > If there is already existing documentation that shows the big picture,
> > that would be great. Otherwise it would help if you could draw the
> > diagrams.
> >=20
> > I need to understand the architecture in order to review this further.
> >=20
> > Thanks,
> > Stefan



--CbfJVBSXguvosSGK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnKl44ACgkQnKSrs4Gr
c8j3sggAnpiJNj0DbkCNvMsiPCE03qKAEgcB61H/4n3YTZC3WfyF4SDn7N5PfRQI
qx5IoPFOS4++c3ar5Qz37P3L7aRTFIkiVwXHIMYuJ/VUVtQgc2FTAM7jdutTV7BA
+MCJClBn+FascUPybBxS5DRNZukDK9cNMO/s4Ej/SvB2ygYhwKu/H55IOOy6ZbGX
v+e5tWcNrYX8D2T552r+9FES0kDTfurX+0uQEA70vkcFi54XUmkr6DbvpUf3MqeP
DfUlYwz0VK8n40t0lAhxPHE2Z1z+FTohDQhMT838W+jquoZk8IMcl/jY6cloCpoP
3WieQVyGI8QA1xgl5SXPUvgNwIJThQ==
=zJuU
-----END PGP SIGNATURE-----

--CbfJVBSXguvosSGK--

