Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CB526158C
	for <virtio-dev@lists.linux.dev>; Thu, 16 Apr 2026 20:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776371154; cv=none; b=D/3+NlUSmyjf7NcpYbeGGmgEz+R62GmY4i8+sMEEckZtdq1+3QF15tIHP6L2zapo7ZUkUpVt805JhdDEptgdl6uTAgvPGyDDe0ClaMSaRiQv2gbToM5qDedmRCUq8fWSaF6Bt9rZHOKca7Vu6mmYDEB0W+y8ownLwwY4sK0DCP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776371154; c=relaxed/simple;
	bh=I3IqU1O6HKzuG2drS4KTNfEahYohOnEHfw9ExAm68JY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8L5K47jAw1xyYJeTVuZ2vkK1ABTRV5JsovsUYi5N0VXBsHC3u3bDC3r49+1mjvhrSfr58yJyipfotsUiSl8l0upp8h/S+HDKVAaq6NkxD7FXspagOF5s6cuwn4VFOKWpxE1fIAS7bzfztOoopL6+OpnQt3AOxZCdX50C1BB3Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KWfNv6L5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KWfNv6L5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776371150;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=O17t3Ae1wa4WmvZZ52/OhS8BXIJX8C/e6kiEM9mV3U0=;
	b=KWfNv6L5AnfMFZ9eH2IkPWGUJVykPJhAax1T0bQ0jY/jusVwzJ1KKO+q7b02/P9+2ss11i
	VHm4dw0X99CidSRsvGpRRm3OxRTzs05WPROdgyMtw7UAH1FXhqG2nx7zqorWjADPWHgTgv
	S2ICdBp8cY30nKGKT0EIhnUyA79uVC4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-XXPM2dxfNAWwa9nb1JVckg-1; Thu,
 16 Apr 2026 16:25:48 -0400
X-MC-Unique: XXPM2dxfNAWwa9nb1JVckg-1
X-Mimecast-MFC-AGG-ID: XXPM2dxfNAWwa9nb1JVckg_1776371147
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 67A241800370;
	Thu, 16 Apr 2026 20:25:46 +0000 (UTC)
Received: from localhost (unknown [10.44.48.32])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 481AF1800446;
	Thu, 16 Apr 2026 20:25:43 +0000 (UTC)
Date: Thu, 16 Apr 2026 16:25:41 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
Cc: Eric Biggers <ebiggers@kernel.org>,
	Sebastian Mauritsson <sma@napatech.com>, virtio-dev@lists.linux.dev,
	quic_dshaikhu@quicinc.com, neeraj.soni@oss.qualcomm.com,
	Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>
Subject: Re: [PATCH v2 1/1] virtio-blk: Add inline encryption support
Message-ID: <20260416202541.GC258343@fedora>
References: <20260210211842.GA158755@fedora>
 <fa458358-90c8-408c-a860-8bfdb11658bb@oss.qualcomm.com>
 <20260218215336.GD605390@fedora>
 <bca448cf-6c18-4c82-806d-f2a25579a02b@oss.qualcomm.com>
 <20260225095502.GB1653802@fedora>
 <22632a98-3d10-4c71-b579-d7aaefe8553d@oss.qualcomm.com>
 <20260301045516.GB42492@fedora>
 <112986be-3f22-45fe-ac68-6a2c172f629b@oss.qualcomm.com>
 <20260330153230.GD154632@fedora>
 <094ef4db-3098-4f34-a0b8-a8149464dda8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mxArY4nhw/940xze"
Content-Disposition: inline
In-Reply-To: <094ef4db-3098-4f34-a0b8-a8149464dda8@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111


--mxArY4nhw/940xze
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 07:49:01PM +0800, Linlin Zhang wrote:
> Hello Stefan,
>=20
> Thanks for your review in detail.
>=20
> Only the host or the PVM knows the detail of physical key slots. There is=
n't
> any request notifying TZ ICE driver which physical slots cllocated to whi=
ch VM.
> So TZ ICE driver cannot validate the physical slot from GVM SCM request.
> That is also why we pass physical slot from LA GVM to TZ.
>=20
> virtio block frontend in LA GVM gets the physical slot offset and max-slot
> number from the host/PVM, it's the only way to enforce the isolation on
> physical slot passed by LA GVM to TZ in current design. If physical slot
> offset or max-slot number in LA GVM is temperred, it will lead to the bro=
ken
> of slots isolation b/w host/PVM and GVM.
>=20
> Is this the security problem you mentioned even though Linux kernel is
> always protected by Android Verified Boot 2.0?

I think it is a security problem because the system cannot trust the GVM
even if protected by Verified Boot. An exploit could compromise the GVM
at runtime and the compromised GVM could then use physical key slots
outside its allocated range.

>=20
> In-band keyslot manager design leaves slight more complex changes in
> the kernel of PVM, and both in-band and out-of-band design request
> added encrytion info per I/O request.
>=20
> And I also added Eric in the thread, who is very professional in the
> block crypto encryption. For a better understanding and discussion,
> I'll post a patch serial which including changes in virtio_blk of GVM
> and changes in block layer/storage layers of PVM, and request you review
> before this virtio SPEC is approved=EF=BC=8Censure the virtio SPEC is con=
sistent
> of the final solution.

Sure. If you would like to have a video call to discuss things more
quickly, please let me know.

=46rom a VIRTIO spec point of view I would prefer in-band key management
so that the virtio-blk ICE feature can be implemented directly in the
virtio-blk guest driver without the need to combine it with additional
vendor-specific key management drivers. I think this would make life
easier for both users and implementors without a lot of drawbacks.

=46rom a security point of view, the key slots available to the virtio-blk
driver must be restricted and this must be enforced by the device
implementation (e.g. hypervisor) since the GVM cannot be trusted.

If out-of-band key management is essential - I don't understand inline
crypto engines well to insist on in-band key management - then I'm okay
with that as long as you show that the design securely isolates the
guest from the physical key slots. I think that would require something
like the TZ ICE driver having a key slot remapping table that is
programmed by the hypervisor (and a consequence of that is the physical
slot offset is no longer needed in the virtio-blk spec).

Stefan

> Regards,
> Linlin
>=20
>=20
> On 3/30/2026 11:32 PM, Stefan Hajnoczi wrote:
> > On Mon, Mar 02, 2026 at 10:35:13PM +0800, Linlin Zhang wrote:
> >>
> >> Appreciate your review in detail. I attached the slide <FBE_virtualiza=
tion_proposal.pptx>. Please have a look and
> >> let me know if you have any concern. Thanks!
> >=20
> > Hi Linlin,
> > Thanks for the slides. How does the TZ ICE driver validate GVM SCM
> > requests to prevent the GVM from performing key operations on physical
> > slots that do not belong to the GVM?
> >=20
> > If the TZ ICE driver enforces isolation on the GVM SCM requests, then I
> > don't understand why the GVM uses physical slot indices. It could use
> > virtual slot indices and then the slot_offset field is not necessary.
> >=20
> > If the TZ ICE driver does not enforce isolation, then there is probably
> > security problem with your design.
> >=20
> > For the record, I prefer an in-band keyslot manager design where the
> > virtio-blk device provides the commands needed to program keys. That way
> > the virtio-blk interface is self-contained and does not depend on an
> > additional third-party component that requires extra drivers. It would
> > be cleaner to specify the key operations in virtio-blk and let
> > implementors decide how to implement them in the device rather than
> > exposing that to the (guest) driver.
> >=20
> > The performance argument seems weak because every I/O request involves
> > the PVM anyway and keyslot manager operations should be much less
> > frequent than I/O requests.
> >=20
> > The security argument of bypassing the PVM doesn't work because the PVM
> > can access GVM RAM anyway, so the key cannot be hidden even if the PVM
> > is bypassed during key operations.
> >=20
> > I'm just sharing my opinions with you. I'd be happier for the key
> > operations to be included in virtio-blk, but I'm not an expert in ICE
> > and ultimately I'm fine with your approach as long as the design is
> > coherent and secure.
> >=20
> > Stefan
> >=20
> >>
> >> Linlin
> >>
> >> On 3/1/2026 12:55 PM, Stefan Hajnoczi wrote:
> >>> On Thu, Feb 26, 2026 at 09:34:01PM +0800, Linlin Zhang wrote:
> >>>>
> >>>>
> >>>> On 2/25/2026 5:55 PM, Stefan Hajnoczi wrote:
> >>>>> On Wed, Feb 25, 2026 at 01:33:17PM +0800, Linlin Zhang wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 2/19/2026 5:53 AM, Stefan Hajnoczi wrote:
> >>>>>>> On Sat, Feb 14, 2026 at 03:22:21PM +0800, Linlin Zhang wrote:
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> On 2/11/2026 5:18 AM, Stefan Hajnoczi wrote:
> >>>>>>>>> On Tue, Feb 10, 2026 at 12:32:08AM -0800, Linlin Zhang wrote:
> >>>>>>>>>> Inline encryption on virtio block can only be supported when
> >>>>>>>>>> the new feature bit VIRTIO_BLK_F_ICE is negotiated.
> >>>>>>>>>>
> >>>>>>>>>> Extend struct virtio_blk_config and struct virtio_blk_req,
> >>>>>>>>>> so that crypto capabilities can be got in the frontend and
> >>>>>>>>>> encryption metadata can be sent to the backend, together with
> >>>>>>>>>> each I/O transaction.
> >>>>>>>>>>
> >>>>>>>>>> About the inline encryption on UFS or eMMC storage, please
> >>>>>>>>>> refer to the Linux inline encryption documentation:
> >>>>>>>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux=
=2Egit/tree/Documentation/block/inline-encryption.rst
> >>>>>>>>>>
> >>>>>>>>>> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/238
> >>>>>>>>>> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> >>>>>>>>>> Signed-off-by: linlzhan <quic_linlzhan@quicinc.com>
> >>>>>>>>>> Signed-off-by: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
> >>>>>>>>>> ---
> >>>>>>>>>>  device-types/blk/description.tex | 110 ++++++++++++++++++++++=
++++++++-
> >>>>>>>>>>  1 file changed, 108 insertions(+), 2 deletions(-)
> >>>>>>>>>>
> >>>>>>>>>> diff --git a/device-types/blk/description.tex b/device-types/b=
lk/description.tex
> >>>>>>>>>> index 2712ada..60f46af 100644
> >>>>>>>>>> --- a/device-types/blk/description.tex
> >>>>>>>>>> +++ b/device-types/blk/description.tex
> >>>>>>>>>> @@ -66,6 +66,11 @@ \subsection{Feature bits}\label{sec:Device =
Types / Block Device / Feature bits}
> >>>>>>>>>>  	(ZNS). For brevity, these standard documents are referred as=
 "ZBD standards"
> >>>>>>>>>>  	from this point on in the text.
> >>>>>>>>>> =20
> >>>>>>>>>> +\item[VIRTIO_BLK_F_ICE(22)] Inline Crypto Extensions are supp=
orted. Only when this
> >>>>>>>>>> +     feature bit is negotiated, the device need expose crypto=
 characteristics in
> >>>>>>>>>> +     configuration space and the driver need provide an exten=
ded request header
> >>>>>>>>>> +     containing a crypto payload for block I/O.
> >>>>>>>>>
> >>>>>>>>> Most of the feature bit descriptions are brief and the details =
are
> >>>>>>>>> covered later in the spec. I suggest doing this here too:
> >>>>>>>>>
> >>>>>>>>>   \item[VIRTIO_BLK_F_ICE (22)] Device supports Inline Crypto En=
gine functionality.
> >>>>>>>>>
> >>>>>>>>> I changed the name from Inline Crypto Extensions to Inline Cryp=
to Engine
> >>>>>>>>> because that terminology is used in the Linux kernel. Web searc=
h results
> >>>>>>>>> also favor "inline crypto engine" over "inline crypto extension=
s". Are
> >>>>>>>>> you okay with "engine"?
> >>>>>>>> Thanks! ACK
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>> +
> >>>>>>>>>>  \end{description}
> >>>>>>>>>> =20
> >>>>>>>>>>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Devi=
ce Types / Block Device / Feature bits / Legacy Interface: Feature bits}
> >>>>>>>>>> @@ -128,6 +133,10 @@ \subsection{Device configuration layout}\=
label{sec:Device Types / Block Device /
> >>>>>>>>>>                  u8 model;
> >>>>>>>>>>                  u8 unused2[3];
> >>>>>>>>>>          } zoned;
> >>>>>>>>>> +        struct virtio_blk_crypto_characteristics {
> >>>>>>>>>> +                __virtio16 slot_info;
> >>>>>>>>>> +                __virtio16 reserved;
> >>>>>>>>>> +        } crypto;
> >>>>>>>>>>  };
> >>>>>>>>>>  \end{lstlisting}
> >>>>>>>>>> =20
> >>>>>>>>>> @@ -215,6 +224,18 @@ \subsection{Device configuration layout}\=
label{sec:Device Types / Block Device /
> >>>>>>>>>>  terminated by the device with a "zone resources exceeded" err=
or as defined for
> >>>>>>>>>>  specific commands later.
> >>>>>>>>>> =20
> >>>>>>>>>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then in
> >>>>>>>>>> +\field{virtio_blk_crypto_characteristics},
> >>>>>>>>>> +\begin{itemize}
> >>>>>>>>>> +\item \field{slot_info} value packs two 8-bits values to redu=
ce the number of
> >>>>>>>>>
> >>>>>>>>> 8-bits -> 8-bit
> >>>>>>>>
> >>>>>>>> ACK
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>> +    Configuration Space reads.
> >>>>>>>>>> +    \begin{itemize}
> >>>>>>>>>> +        \item Bits~\[15:8] (\emph{max\_slots}): the maximum n=
umber of supported
> >>>>>>>>>> +            crypto key slots.
> >>>>>>>>>> +        \item Bits~\[7:0] (\emph{slot\_offset}): an offset ap=
plied to slot numbering.
> >>>>>>>>>
> >>>>>>>>> What is the purpose of slot_offset? This field is not used much=
 in this
> >>>>>>>>> spec, maybe it can be removed?
> >>>>>>>>>
> >>>>>>>>> Does that mean only slots in the range [slot_offset:max_slots) =
are
> >>>>>>>>> available or does it mean that the range is
> >>>>>>>>> [slot_offset:slot_offset+max_slots)?
> >>>>>>>>
> >>>>>>>> Only slots within the range [slot_offset, slot_offset + max_slot=
s) are accessible to the
> >>>>>>>> VM. The slot_offset specifies the base physical ICE slot allocat=
ed to the VM and is used
> >>>>>>>> to translate a virtual slot index into a physical slot.
> >>>>>>>>
> >>>>>>>> Because the GVM programs and evicts keys directly=E2=80=94withou=
t host/PVM involvement=E2=80=94it must
> >>>>>>>> supply the resolved physical slot when invoking key operations i=
n TrustZone or the Secure
> >>>>>>>> VM.
> >>>>>>>
> >>>>>>> It's not clear to me how what you've described offers isolation b=
etween
> >>>>>>> the PVM and the GVM. What stops the GVM from using key slots outs=
ide the
> >>>>>>> range that has been assigned to it?
> >>>>>>>
> >>>>>>> A few options for isolation come to mind:
> >>>>>>>
> >>>>>>> 1. Expose 2 separate virtio-blk devices, one of which is hidden f=
rom the
> >>>>>>>    GVM and only accessible to the PVM. The PVM can store its data=
 on the
> >>>>>>>    hidden device.
> >>>>>>>
> >>>>>>> 2. Some kind of VIRTIO Admin queue Virtual Function approach wher=
e the
> >>>>>>>    PVM can instantiate a virtual function (a sub-device) that the=
 GVM is
> >>>>>>>    allowed to access with isolation enforced by the device.
> >>>>>>>
> >>>>>>> 3. A single device could be used but the GVM cannot access it dir=
ectly
> >>>>>>>    and needs to go through the PVM.
> >>>>>>
> >>>>>> The slot isolation between GVM and PVM is implemented by the max s=
lots allocated to the GVM and slot offset
> >>>>>> the GVM's starting slot relative to the physical starting slot.
> >>>>>>
> >>>>>> For instance, ICE hardware has 64 slots, the max slots allocated t=
o the GVM is 32, and its slot offset is 20.
> >>>>>> The keyslot manager in the GVM ensure the virtual slot rang is [0,=
31], when programming a key, translate the
> >>>>>> virtual slot to a physical slot by using the slot offset, that mea=
ns the physical slot range this GVM used
> >>>>>> is [20,51].
> >>>>>>
> >>>>>> The max_slots and slot_offset are configured by PVM, and GVM's vir=
tio frontend only gets them from the configuration
> >>>>>> space of its virtio devices. So PVM is responsible to ensure the p=
hysical slot range of the GVM is valid.
> >>>>>
> >>>>> I don't understand how isolation between the PVM and GVM works. To =
me it
> >>>>> seems like if there is isolation, then it would not be necessary to
> >>>>> expose slot_offset to the GVM. And if there is no isolation, then t=
his
> >>>>> design isn't safe because the PVM is not protected against the GVM.
> >>>>>
> >>>>> I'm probably missing something. Can you explain how isolation is
> >>>>> enforced?
> >>>>
> >>>> Appreciate your quick feedback!
> >>>>
> >>>> The key slots in ICE hardware are used by both PVM/Host and GVMs, th=
e PVM/Host
> >>>> specifies the slot range of each VM used (including itself) by defin=
ing starting
> >>>> slot offest and max slots per VM, ensure that there isn't overlappin=
g b/w these
> >>>> slot ranges in physical slot level.
> >>>>
> >>>> In this way, if only the virtual slot in each VM doesn't exceed the =
max slots
> >>>> allocated to it, the access to its physical ICE slot for one VM does=
n' have impact
> >>>> on the ICE slots belonging to the range of other VMs.=20
> >>>>
> >>>> You mentioned "this design isn't safe because the PVM is not protect=
ed against the
> >>>> GVM", do you mean that the slot_offest and/or max_slots of GVM are t=
ampered by a
> >>>> malixious program, leading to unexpected access from GVM to a physic=
al ICE slot
> >>>> allocated to PVM? If yes, I feel it's not a risk as kernel image can=
 be pretotected
> >>>> via dm-verity/AVB, it's impossible for an attacker to rewrite them i=
n runtime from
> >>>> both PVM and GVM sides.
> >>>
> >>> There are two separate issues that are still unclear to me:
> >>> 1. The device appears to trust the guest to select valid slot indices.
> >>> 2. How the PVM/GVM share the device.
> >>>
> >>> About trusting the slot field:
> >>> - In VIRTIO the trust model is that the device does not trust the
> >>>   driver. This is necessary not just for reliability but also to prev=
ent
> >>>   virtualized devices from being exploited by untrusted VMs (escaping
> >>>   confinement, consuming resources not allocated to the VM, etc).
> >>> - Given that the device cannot trust the driver, I don't understand w=
hy
> >>>   the interface is designed to require driver cooperation in choosing
> >>>   slot indices within the slot_offset/max_slots range.
> >>> - I expected the interface to expose a max_slots Configuration Space
> >>>   field but slot indices are in the range [0, max_slots) and are
> >>>   validated by the device.
> >>
> >> The FBE key programing/eviction in a out-of-band channel here is a com=
promise for
> >> upstream. The reason I'll show it in the proposal slide.
> >>
> >> In such way, the GVM has to transfer the virtio slot to the physical s=
lot, and send it
> >> to Trust Zone during key programming/eviction, bypass slot check in th=
e PVM.
> >> So, slot_offset on hardware must also be provided by the PVM together =
with max_slots for
> >> the GVM. On the GVM side, the virtio block driver trusts that max_slot=
s and slot_offest.
> >> The layers upper virtio block crypto exteansion driver only see the vi=
rtual slots in the
> >> range [0, max_slots) and use it. Only when the virtual slot is passed =
to virtio block
> >> crypto exteansion driver, this exteansion driver will ensure the virtu=
al slot is resided
> >> in [0, max_slots) and translates it to the physical slot by adding slo=
t_offset.
> >>
> >> Sorry, I get your point about your second issue. Hope the slide can gi=
ve you more
> >> information.
> >>
> >>>
> >>> About the PVM/GVM relationship, please see below where I'm asking abo=
ut
> >>> the architecture of a system using ICE.
> >>>
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>> +    \end{itemize}
> >>>>>>>>>> +\end{itemize}
> >>>>>>>>>> +
> >>>>>>>>>>  \subsubsection{Legacy Interface: Device configuration layout}=
\label{sec:Device Types / Block Device / Device configuration layout / Lega=
cy Interface: Device configuration layout}
> >>>>>>>>>>  When using the legacy interface, transitional devices and dri=
vers
> >>>>>>>>>>  MUST format the fields in struct virtio_blk_config
> >>>>>>>>>> @@ -278,6 +299,10 @@ \subsection{Device Initialization}\label{=
sec:Device Types / Block Device / Devic
> >>>>>>>>>>      \field{zoned} can be read by the driver to determine the =
zone
> >>>>>>>>>>      characteristics of the device. All \field{zoned} fields a=
re read-only.
> >>>>>>>>>> =20
> >>>>>>>>>> +\item If the VIRTIO_BLK_F_ICE feature is negotiated, the fiel=
ds in
> >>>>>>>>>> +    \field{crypto} can be read by the driver to determine the=
 inline crypto
> >>>>>>>>>> +    characteristics of the device. All \field{crypto} fields =
are read-only.
> >>>>>>>>>> +
> >>>>>>>>>>  \end{enumerate}
> >>>>>>>>>> =20
> >>>>>>>>>>  \drivernormative{\subsubsection}{Device Initialization}{Devic=
e Types / Block Device / Device Initialization}
> >>>>>>>>>> @@ -317,6 +342,9 @@ \subsection{Device Initialization}\label{s=
ec:Device Types / Block Device / Devic
> >>>>>>>>>>      driver SHOULD ignore all other fields in \field{zoned}.
> >>>>>>>>>>  \end{itemize}
> >>>>>>>>>> =20
> >>>>>>>>>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then the drive=
r MUST validate
> >>>>>>>>>> +    the max_slots in \field{slot_info} before the slot usage.
> >>>>>>>>>
> >>>>>>>>> I'm not sure how the driver is supposed to validate max_slots?
> >>>>>>>>
> >>>>>>>> It means the diver validate the virtual slot doesn't exceed the =
max_slots before translating
> >>>>>>>> this virtual slot to a physical slot by using slot_offset.=20
> >>>>>>>>
> >>>>>>>> Can I rewrite it as the following?
> >>>>>>>>
> >>>>>>>>   If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver=
 MUST validate that
> >>>>>>>>   the virtual slot received from upper layer doesn't exceed the =
max_slots in
> >>>>>>>>   \field{slot_info} before the slot usage.
> >>>>>>>
> >>>>>>> The notion of an "upper layer" can be eliminated so that there is=
 no
> >>>>>>> assumption about the software design in the driver:
> >>>>>>>
> >>>>>>>   If the VIRTIO_BLK_F_ICE feature is negotiated, then the driver =
MUST
> >>>>>>>   ensure that slot_offset <=3D \field{payload.slot} < slot_offset=
 +
> >>>>>>>   max_slots, where slot_offset and max_slots are the values extra=
cted
> >>>>>>>   from \field{crypto.slot_info} in configuration space.
> >>>>>>
> >>>>>> ACK. Thanks!
> >>>>>>
> >>>>>>>
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>> +
> >>>>>>>>>>  \devicenormative{\subsubsection}{Device Initialization}{Devic=
e Types / Block Device / Device Initialization}
> >>>>>>>>>> =20
> >>>>>>>>>>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offe=
r it
> >>>>>>>>>> @@ -402,6 +430,13 @@ \subsection{Device Initialization}\label{=
sec:Device Types / Block Device / Devic
> >>>>>>>>>>  \item the device MUST initialize padding bytes \field{unused2=
} to 0.
> >>>>>>>>>>  \end{itemize}
> >>>>>>>>>> =20
> >>>>>>>>>> +If the VIRTIO_BLK_F_ICE feature is negotiated, then the field=
s in \field{crypto}
> >>>>>>>>>> +struct in the configuration space MUST be set by the device.
> >>>>>>>>>> +\begin{itemize}
> >>>>>>>>>> +\item the \field{slot_info} field of \field{crypto} MUST be s=
et by the device to a
> >>>>>>>>>> +    max_slots in the higher 8 bits and slot_offset in the low=
er 8 bits.
> >>>>>>>>>> +\end{itemize}
> >>>>>>>>>
> >>>>>>>>> There is no need for the \begin{itemize} here. It contains no n=
ew
> >>>>>>>>> information. The fields were already described in the configura=
tion
> >>>>>>>>> space section and the previous sentence already said that the f=
ields in
> >>>>>>>>> \field{crypto} must be set by the device.
> >>>>>>>>
> >>>>>>>> ACK, remove this \begin{itemize} here.
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>> +
> >>>>>>>>>>  \subsubsection{Legacy Interface: Device Initialization}\label=
{sec:Device Types / Block Device / Device Initialization / Legacy Interface=
: Device Initialization}
> >>>>>>>>>> =20
> >>>>>>>>>>  Because legacy devices do not have FEATURES_OK, transitional =
devices
> >>>>>>>>>> @@ -436,6 +471,13 @@ \subsection{Device Operation}\label{sec:D=
evice Types / Block Device / Device Ope
> >>>>>>>>>>          le32 type;
> >>>>>>>>>>          le32 reserved;
> >>>>>>>>>>          le64 sector;
> >>>>>>>>>> +        struct virtio_blk_crypto_payload {
> >>>>>>>>>> +            u8 slot;
> >>>>>>>>>> +            u8 activate;
> >>>>>>>>>> +            le16 reserved1;
> >>>>>>>>>> +            le32 reserved2;
> >>>>>>>>>> +            le64 data_unit_num;
> >>>>>>>>>> +        } payload;
> >>>>>>>>>
> >>>>>>>>> "payload" is a generic term. crypto_payload would be clearer.
> >>>>>>>>>
> >>>>>>>>> I wonder whether consistently calling this feature "ice" rather=
 than
> >>>>>>>>> "crypto" would help in case self-encrypting drive or other cryp=
tographic
> >>>>>>>>> functionality is added to virtio-blk in the future. That way th=
e spec
> >>>>>>>>> items related to inline crypto engine functionality will be eas=
y to
> >>>>>>>>> differentiate from other crypto functionality.
> >>>>>>>>
> >>>>>>>> Ok, to differentiate ICE and other cryptographic functionality, =
can I modify it as
> >>>>>>>>
> >>>>>>>>   struct virtio_blk_ice_payload {
> >>>>>>>>       u8 slot;
> >>>>>>>>       u8 activate;
> >>>>>>>>       le16 reserved1;
> >>>>>>>>       le32 reserved2;
> >>>>>>>>       le64 data_unit_num;
> >>>>>>>>   } ice_payload;
> >>>>>>>
> >>>>>>> Looks good to me, thanks.
> >>>>>>
> >>>>>> Thanks!
> >>>>>>
> >>>>>>>
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>>          u8 data[];
> >>>>>>>>>>          u8 status;
> >>>>>>>>>>  };
> >>>>>>>>>> @@ -445,8 +487,9 @@ \subsection{Device Operation}\label{sec:De=
vice Types / Block Device / Device Ope
> >>>>>>>>>>  (VIRTIO_BLK_T_OUT), a discard (VIRTIO_BLK_T_DISCARD), a write=
 zeroes
> >>>>>>>>>>  (VIRTIO_BLK_T_WRITE_ZEROES), a flush (VIRTIO_BLK_T_FLUSH), a =
get device ID
> >>>>>>>>>>  string command (VIRTIO_BLK_T_GET_ID), a secure erase
> >>>>>>>>>> -(VIRTIO_BLK_T_SECURE_ERASE), or a get device lifetime command
> >>>>>>>>>> -(VIRTIO_BLK_T_GET_LIFETIME).
> >>>>>>>>>> +(VIRTIO_BLK_T_SECURE_ERASE), a get device lifetime command
> >>>>>>>>>> +(VIRTIO_BLK_T_GET_LIFETIME), or a get device crypto capabilit=
ies command
> >>>>>>>>>> +(VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES).
> >>>>>>>>>> =20
> >>>>>>>>>>  \begin{lstlisting}
> >>>>>>>>>>  #define VIRTIO_BLK_T_IN           0
> >>>>>>>>>> @@ -457,12 +500,27 @@ \subsection{Device Operation}\label{sec:=
Device Types / Block Device / Device Ope
> >>>>>>>>>>  #define VIRTIO_BLK_T_DISCARD      11
> >>>>>>>>>>  #define VIRTIO_BLK_T_WRITE_ZEROES 13
> >>>>>>>>>>  #define VIRTIO_BLK_T_SECURE_ERASE   14
> >>>>>>>>>> +#define VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES   27
> >>>>>>>>>
> >>>>>>>>> The Linux virtio_blk.c driver assumes that odd numbered constan=
ts have
> >>>>>>>>> data buffers that are read by the device, so you may run into a=
 bug when
> >>>>>>>>> using 27.
> >>>>>>>>>
> >>>>>>>>> There is an informal convention to use even numbers for read re=
quests
> >>>>>>>>> and odd numbers for write requests. It doesn't hurt to try to f=
ollow the
> >>>>>>>>> convention even though it's not strictly necessary.
> >>>>>>>>>
> >>>>>>>>> The Linux driver could be fixed when adding support for ICE, bu=
t 16 is
> >>>>>>>>> available and it's safest to use that.
> >>>>>>>>
> >>>>>>>> OK. Agree to following the convention. But 16, 18,20,22,24,26 ar=
e already used by
> >>>>>>>> zone device. Seems 12 is available. Correct it to 12.
> >>>>>>>>
> >>>>>>>>  #define VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES   12
> >>>>>>>
> >>>>>>> In that case I suggest using 28. I don't remember what 12 was use=
d for
> >>>>>>> but there may be a historical reason for the gap.
> >>>>>>
> >>>>>> Thanks! Change it to 28.
> >>>>>>
> >>>>>>>
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>>  \end{lstlisting}
> >>>>>>>>>> =20
> >>>>>>>>>>  The \field{sector} number indicates the offset (multiplied by=
 512) where
> >>>>>>>>>>  the read or write is to occur. This field is unused and set t=
o 0 for
> >>>>>>>>>>  commands other than read, write and some zone operations.
> >>>>>>>>>> =20
> >>>>>>>>>> +The \field{payload} consists of the encryption information fo=
r current
> >>>>>>>>>> +request. It is only present when the VIRTIO_BLK_F_ICE feature=
 is negotiated and
> >>>>>>>>>> +\field{type} is VIRTIO_BLK_T_IN, VIRTIO_BLK_T_OUT or VIRTIO_B=
LK_T_FLUSH.
> >>>>>>>>>
> >>>>>>>>> TODO think about layout
> >>>>>>>>
> >>>>>>>> rewrite to the following
> >>>>>>>>
> >>>>>>>>   The \field{ice_payload} consists of the encryption information=
 for current
> >>>>>>>>   request. When VIRTIO_BLK_F_ICE is negotiated, the request head=
er layout becomes
> >>>>>>>>   that struct virtio_blk_outhdr includes \field{ice_payload} as =
a fixed-size
> >>>>>>>>   extension. For non-ICE requests (or types not using crypto), t=
he driver MUST
> >>>>>>>>   set \field{ice_payload} to 0 and device ignores them.
> >>>>>>>
> >>>>>>> Sorry, the TODO was a comment to myself while writing my reply :).
> >>>>>>>
> >>>>>>> I forgot to investigate. Basically the issue is that the spec mus=
t be
> >>>>>>> clear on whether:
> >>>>>>> 1. A field is absent and fields that follow it are present in the=
 struct
> >>>>>>>    layout when a condition is false (e.g. type is not VIRTIO_BLK_=
T_IN,
> >>>>>>>    VIRTIO_BLK_T_OUT, or VIRTIO_BLK_T_FLUSH).
> >>>>>>> or
> >>>>>>> 2. A field is present but unused (zeroed) when a condition is fal=
se.
> >>>>>>>
> >>>>>>> #2 is usually easier to implement in code because it avoids creat=
ing
> >>>>>>> many different struct layouts at runtime depending on conditions =
like
> >>>>>>> negotiated feature bits.
> >>>>>>>
> >>>>>>> I was thinking that the ice fields should always be present but s=
hould
> >>>>>>> be zero when the feature bit is not negotiated or some other cond=
ition
> >>>>>>> (like the request type) is false. This way it will be much easier=
 to add
> >>>>>>> additional fields later without worrying about struct layouts.
> >>>>>>>
> >>>>>>> This is how configuration space already works: the offset of the =
zoned
> >>>>>>> field is not affected by whether the device advertises the
> >>>>>>> VIRTIO_BLK_F_WRITE_ZEROES feature bit, it just means that the ear=
lier
> >>>>>>> write_zeroes_may_unmap field may be unused. This approach should
> >>>>>>> probably be used everywhere and the spec language should be caref=
ul to
> >>>>>>> communicate that the field is still present but zero when unused.=
 It's
> >>>>>>> okay for the driver to provide a shorter struct that doesn't incl=
ude the
> >>>>>>> last field(s) to the device when the feature bit is not negotiated
> >>>>>>> though.
> >>>>>>
> >>>>>> Thanks. Refer to the statement you shared, try to rewrite it as th=
e following.
> >>>>>>
> >>>>>>   The \field{ice_payload} consists of the encryption information f=
or current
> >>>>>>   request. It is not affected by whether the device advertises the
> >>>>>>   VIRTIO_BLK_F_ICE feature bit, it just SHOULD be zero when the fe=
ature bit is
> >>>>>>   not negotiated or the \field{type} is not VIRTIO_BLK_T_IN, VIRTI=
O_BLK_T_OUT
> >>>>>>   or VIRTIO_BLK_T_FLUSH.=20
> >>>>>
> >>>>> Sounds good.
> >>>>>
> >>>>>>
> >>>>>>>
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>> +\begin{itemize}
> >>>>>>>>>> +\item The \field{slot} field in \field{payload} indicates the=
 ICE
> >>>>>>>>>> +  (Inline Crypto Encryption) slot index where the key resides.
> >>>>>>>>>> +
> >>>>>>>>>> +\item The \field{activate} field in \field{payload} implies t=
his is a
> >>>>>>>>>> +  inline encryption request.
> >>>>>>>>>> +
> >>>>>>>>>> +\item The \field{data_unit_num} field in \field{payload} indi=
cates the
> >>>>>>>>>> +  starting block of the request.
> >>>>>>>>>
> >>>>>>>>> This is a block device, so the term "block" needs to be qualifi=
ed to
> >>>>>>>>> avoid confusion. I guess this is the cryptography concept of a =
block
> >>>>>>>>> rather than the disk concept of a block. Please clarify this in=
 the
> >>>>>>>>> text, maybe by explaining that the ICE handles data in fixed-si=
ze "data
> >>>>>>>>> units" instead of using the word "block".
> >>>>>>>>>
> >>>>>>>>> Also, can you explain the relationship between the data unit nu=
mber and
> >>>>>>>>> the sector? In simple cases I imagine the data unit number woul=
d be the
> >>>>>>>>> sector. How is the driver supposed to pick or calculate the dat=
a unit
> >>>>>>>>> number?
> >>>>>>>>
> >>>>>>>> The data unit number is the starting IV for AES crypto in ICE ha=
rdware, it's
> >>>>>>>> a stable value for I/O request targeting to same storage range. =
It can be set
> >>>>>>>> to the file logic block number or the starting sector of BIO.=20
> >>>>>>>
> >>>>>>> It sounds like the data unit number calculation is up to the driv=
er
> >>>>>>> (from the device's perspective) and the important thing is that t=
he same
> >>>>>>> data unit number will always be used when reading/writing the same
> >>>>>>> logical data location.
> >>>>>>
> >>>>>> Yes. Correct.
> >>>>>>
> >>>>>>>
> >>>>>>>> The upper layer calculates it and passes it to virtio_blk driver=
 in this patch.
> >>>>>>>> ICE uses the data unit number and data unit size (the granularit=
y to use for
> >>>>>>>> en/decryption) to derive the next data unit number for the next =
cryptography
> >>>>>>>> block. data unit number in ICE increase 1 per data unit size. Fo=
r instance,
> >>>>>>>>   data unit number =3D 2048
> >>>>>>>>   data unit size =3D 1024 bytes
> >>>>>>>> For the first 1024 bytes of the transaction, ICE hardware encryp=
t the data
> >>>>>>>> with IV equal to 2048.
> >>>>>>>> For the second 1024 bytes of the transaction, ICE hardware encry=
pt the data
> >>>>>>>> with IV equal to (2048+1=3D)2049.
> >>>>>>>>
> >>>>>>>> Rewrite it as bellow.
> >>>>>>>>
> >>>>>>>>   \item The \field{data_unit_num} field in \field{ice_payload} i=
ndicates the
> >>>>>>>>   starting IV. It can be the file logic block number or the star=
ting sector
> >>>>>>>>   of BIO.
> >>>>>>>
> >>>>>>> BIO is a Linux-specific concept, so it would be best to avoid it =
in the
> >>>>>>> VIRTIO spec.
> >>>>>>>
> >>>>>>>   \item The \field{data_unit_num} field in \field{ice_payload} in=
dicates
> >>>>>>>   the starting IV. In order to successfully encrypt/decrypt data =
this
> >>>>>>>   number must be the same for successive read and write operation=
s to
> >>>>>>>   the same logical data location. The driver typically sets it to=
 the
> >>>>>>>   file logical block number or the disk sector number.
> >>>>>>
> >>>>>> Thanks! ACK.
> >>>>>>
> >>>>>>>
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>> +\end{itemize}
> >>>>>>>>>> +
> >>>>>>>>>>  VIRTIO_BLK_T_IN requests populate \field{data} with the conte=
nts of sectors
> >>>>>>>>>>  read from the block device (in multiples of 512 bytes).  VIRT=
IO_BLK_T_OUT
> >>>>>>>>>>  requests write the contents of \field{data} to the block devi=
ce (in multiples
> >>>>>>>>>> @@ -530,6 +588,47 @@ \subsection{Device Operation}\label{sec:D=
evice Types / Block Device / Device Ope
> >>>>>>>>>>  The \field{device_lifetime_est_typ_b} refers to wear of MLC c=
ells and is provided
> >>>>>>>>>>  with the same semantics as \field{device_lifetime_est_typ_a}.
> >>>>>>>>>> =20
> >>>>>>>>>> +VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests fetch the stora=
ge hardware crypto
> >>>>>>>>>> +capabilities into \field{data}. And the \field{data} is of th=
e form
> >>>>>>>>>
> >>>>>>>>> How does VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES behave when data[=
] is too
> >>>>>>>>> small to fit all the device's crypto capabilities?
> >>>>>>>>
> >>>>>>>> Add a new field capability_num to the Configuration space header=
=2E The total size of
> >>>>>>>> \field{data} shall be computed as:
> >>>>>>>>   data_size=3Dcapability_num=C3=97capability_size
> >>>>>>>> where capability_size is the size (in bytes) of one capability s=
tructure. Therefore, \field{data} contains exactly capability_num contiguou=
s capability entries, each of length capability_size.
> >>>>>>>> Add a capability_num field in Configuration space. So it use siz=
e per capability
> >>>>>>>> multiply capability_num to define the size of \field{data}.
> >>>>>>>>
> >>>>>>>> Rewrite it as the following.
> >>>>>>>>
> >>>>>>>>   VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests fetch the storag=
e hardware crypto
> >>>>>>>>   capabilities into \field{data}. The crypto capabilities is a z=
ero-padded array
> >>>>>>>>   up to (\field{capability_num}=C3=97capability_size) bytes long=
, where capability_size
> >>>>>>>>   is the size (in bytes) of one capability structure which is in=
 form of
> >>>>>>>>  =20
> >>>>>>>>   \begin{lstlisting}
> >>>>>>>>     struct virtio_blk_crypto_cap {
> >>>>>>>>         u8 alg;
> >>>>>>>>         u8 data_unit_size;
> >>>>>>>>         u8 key_size;
> >>>>>>>>         u8 reserved;
> >>>>>>>>     };
> >>>>>>>>   \end{lstlisting}
> >>>>>>>>  =20
> >>>>>>>>   \begin{itemize}
> >>>>>>>>       \item The \field{alg} implies crypto algorithm identifiers.
> >>>>>>>>       The device supports reporting and negotiating cryptographi=
c algorithms
> >>>>>>>>       using the following algorithm identifiers:
> >>>>>>>>       \begin{lstlisting}
> >>>>>>>>           CRYPTO_ALG_AES_XTS              =3D 0x0
> >>>>>>>>           CRYPTO_ALG_BITLOCKER_AES_CBC    =3D 0x1
> >>>>>>>>           CRYPTO_ALG_AES_ECB              =3D 0x2
> >>>>>>>>           CRYPTO_ALG_ESSIV_AES_CBC        =3D 0x3
> >>>>>>>>       \end{lstlisting}
> >>>>>>>>       These identifiers abstract the underlying hardware crypto =
implementation
> >>>>>>>>       and does not assume any operating=E2=80=91system=E2=80=91s=
pecific data structures or
> >>>>>>>>       constants.
> >>>>>>>>       \item The \field{data_unit_size} implies the mask of data =
unit size. When
> >>>>>>>>       bit j in this field (j=3D7......0) is set, a data unit siz=
e of 512*2^j bytes
> >>>>>>>>       is selected.
> >>>>>>>>       \item The \field{key_size} is the crypto key size identifi=
ers.
> >>>>>>>>       \begin{lstlisting}
> >>>>>>>>           CRYPTO_KEY_SIZE_INVALID     =3D 0x0
> >>>>>>>>           CRYPTO_KEY_SIZE_128_BITS    =3D 0x1
> >>>>>>>>           CRYPTO_KEY_SIZE_192_BITS    =3D 0x2
> >>>>>>>>           CRYPTO_KEY_SIZE_256_BITS    =3D 0x3
> >>>>>>>>           CRYPTO_KEY_SIZE_512_BITS    =3D 0x4
> >>>>>>>>       \end{lstlisting}
> >>>>>>>>       \item The \field{reserved} is unused.
> >>>>>>>>   \end{itemize}
> >>>>>>>>  =20
> >>>>>>>>   If the \field{data} is too short, it sets status to BLK_S_IO_E=
RR.
> >>>>>>>
> >>>>>>> Looks good. In the final sentence I suggest changing "it" to "the
> >>>>>>> device" for clarity.
> >>>>>>
> >>>>>> Thanks! Done.
> >>>>>>
> >>>>>>>
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>> +
> >>>>>>>>>> +\begin{lstlisting}
> >>>>>>>>>> +struct virtio_blk_crypto_caps {
> >>>>>>>>>> +  u8 size;
> >>>>>>>>>> +  le32 crypto_capabilities[];
> >>>>>>>>>> +};
> >>>>>>>>>> +\end{lstlisting}
> >>>>>>>>>> +
> >>>>>>>>>> +The \field{size} specifies the size of array \field{crypto_ca=
pabilities}.
> >>>>>>>>>
> >>>>>>>>> "number of elements" would be clearer than "size of array" beca=
use the
> >>>>>>>>> unit (bytes vs array elements) is ambiguous.
> >>>>>>>>>
> >>>>>>>>> The size field is not necessary since Used Ring descriptors con=
tain
> >>>>>>>>> (struct virtq_used_elem in the spec) a len field indicating how=
 many
> >>>>>>>>> bytes were written by the device.
> >>>>>>>>
> >>>>>>>> Remove virtio_blk_crypto_caps in above modification.
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>> +The \field{crypto_capabilities} indicates the crypto capabili=
ties supported by the
> >>>>>>>>>> +hardware storage for inline encryption.
> >>>>>>>>>> +
> >>>>>>>>>> +A crypto capability packs four 8-bits values:
> >>>>>>>>>> +\begin{itemize}
> >>>>>>>>>> +    \item Bits~\[31:24]: crypto algorithm identifiers.
> >>>>>>>>>> +    The device supports reporting and negotiating cryptograph=
ic algorithms
> >>>>>>>>>> +    using the following algorithm identifiers:
> >>>>>>>>>> +    \begin{lstlisting}
> >>>>>>>>>> +        CRYPTO_ALG_AES_XTS              =3D 0x0
> >>>>>>>>>> +        CRYPTO_ALG_BITLOCKER_AES_CBC    =3D 0x1
> >>>>>>>>>> +        CRYPTO_ALG_AES_ECB              =3D 0x2
> >>>>>>>>>> +        CRYPTO_ALG_ESSIV_AES_CBC        =3D 0x3
> >>>>>>>>>> +    \end{lstlisting}
> >>>>>>>>>> +    These identifiers abstract the underlying hardware crypto=
 implementation
> >>>>>>>>>> +    and does not assume any operating=E2=80=91system=E2=80=91=
specific data structures or
> >>>>>>>>>> +    constants.
> >>>>>>>>>> +    \item Bits~\[23:16]: mask of data unit size. When bit j i=
n this field
> >>>>>>>>>> +    (j=3D7......0) is set, a data unit size of 512*2^j bytes =
is selected.
> >>>>>>>>>
> >>>>>>>>> Is only one bit ever set in the mask? If so, then maybe just ex=
press j
> >>>>>>>>> as an 8-bit unsigned integer (i.e. the exponent in 512*2^j) ins=
tead of
> >>>>>>>>> as a bit mask. It's simpler and increases the range for j.
> >>>>>>>>
> >>>>>>>> Yes, it's encoded in one-hot encoding. If j is expressed as an 8=
-bit unsigned integer,
> >>>>>>>> it will confused the reader that more than one bit can be set in=
 the mask of data unit
> >>>>>>>> size. right?=20
> >>>>>>>
> >>>>>>> If the field is called the data unit size exponent (data_unit_siz=
e_exp)
> >>>>>>> then there is no confusion. I agree that calling it a mask would =
be
> >>>>>>> confusing.
> >>>>>>
> >>>>>> Thanks! Update it to data_unit_size_exp.
> >>>>>>
> >>>>>>>
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>> +    \item Bits~\[15:8]: crypto key size identifiers.
> >>>>>>>>>> +    \begin{lstlisting}
> >>>>>>>>>> +        CRYPTO_KEY_SIZE_INVALID     =3D 0x0
> >>>>>>>>>> +        CRYPTO_KEY_SIZE_128_BITS    =3D 0x1
> >>>>>>>>>> +        CRYPTO_KEY_SIZE_192_BITS    =3D 0x2
> >>>>>>>>>> +        CRYPTO_KEY_SIZE_256_BITS    =3D 0x3
> >>>>>>>>>> +        CRYPTO_KEY_SIZE_512_BITS    =3D 0x4
> >>>>>>>>>> +    \end{lstlisting}
> >>>>>>>>>> +    \item Bits~\[7:0]: unused.
> >>>>>>>>>> +\end{itemize}
> >>>>>>>>>
> >>>>>>>>> A struct would be more natural here (the rest of the VIRTIO
> >>>>>>>>> specification rarely packs fields into an integer):
> >>>>>>>>>
> >>>>>>>>>   struct virtio_blk_crypto_cap {
> >>>>>>>>>       u8 alg;
> >>>>>>>>>       u8 data_unit_size;
> >>>>>>>>>       u8 key_size;
> >>>>>>>>>       u8 reserved;
> >>>>>>>>>   };
> >>>>>>>>
> >>>>>>>> ACK, see above rewrite statement.
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>> By the way, Linux seems to call this a "profile" rather than a
> >>>>>>>>> "capability". Do you want to use the same name as Linux for con=
sistency?
> >>>>>>>>
> >>>>>>>> blk-crypto-profile is the keyslot manager which manage the usage=
 of keyslot and
> >>>>>>>> also checks if the key configuration set by upper layer can be s=
upported by the
> >>>>>>>> ICE hardware. While the capability aims to illustrate the capabi=
lity provided by
> >>>>>>>> the ICE hardware. What we expected is the capability used to ini=
tialized
> >>>>>>>> blk-crypto-profile in Guest VM.
> >>>>>>>
> >>>>>>> I see.
> >>>>>>>
> >>>>>>>>
> >>>>>>>>>
> >>>>>>>>>> +
> >>>>>>>>>>  The final \field{status} byte is written by the device: either
> >>>>>>>>>>  VIRTIO_BLK_S_OK for success, VIRTIO_BLK_S_IOERR for device or=
 driver
> >>>>>>>>>>  error or VIRTIO_BLK_S_UNSUPP for a request unsupported by dev=
ice:
> >>>>>>>>>> @@ -912,6 +1011,13 @@ \subsection{Device Operation}\label{sec:=
Device Types / Block Device / Device Ope
> >>>>>>>>>>  successfully, failed, or were processed by the device at all =
if the request
> >>>>>>>>>>  failed with VIRTIO_BLK_S_IOERR.
> >>>>>>>>>> =20
> >>>>>>>>>> +The length of \field{data} MUST be a multiple of 4 bytes plus=
 1 for
> >>>>>>>>>> +VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES requests.
> >>>>>>>>>> +
> >>>>>>>>>> +A driver MUST set \field{activate} to 1 for VIRTIO_BLK_T_IN,V=
IRTIO_BLK_T_OUT,
> >>>>>>>>>> +    and VIRTIO_BLK_T_FLUSH requests that require inline encry=
ption. For other
> >>>>>>>>>> +    request types or when inline encryption is not required, =
it is set to 0.
> >>>>>>>>>> +
> >>>>>>>>>>  The following requirements only apply if the VIRTIO_BLK_F_ZON=
ED feature is
> >>>>>>>>>>  negotiated.
> >>>>>>>>>
> >>>>>>>>> How does the driver assign a specific capability (algorithm, da=
ta unit
> >>>>>>>>> size, and key size tuple reported by
> >>>>>>>>> VIRTIO_BLK_T_GET_CRYPTO_CAPABILITIES) to a slot?
> >>>>>>>>>
> >>>>>>>>> How does the driver assign the key material for a slot?
> >>>>>>>>
> >>>>>>>> blk layer will initialize a blk_crypto_key based on the configur=
ation received from
> >>>>>>>> FS layer. This blk_crypto_key contains expected algorithm, data =
unit size and key size expected
> >>>>>>>> by the upper layer. When submit_bio, blk_mq tries to program the=
 key included in blk_crypto_key
> >>>>>>>> to the ICE hardware slot via blk_crypto_profile. During programm=
ing the key, it will compare=20
> >>>>>>>> the algorithm, data unit size and key size in blk_crypto_key wit=
h the capability exposed by ICE
> >>>>>>>> hardware.
> >>>>>>>>
> >>>>>>>> It will follow bellow flow to assign the key material for a slot.
> >>>>>>>>   blk_crypto_profile -> virtio_blk driver -> virtio_blk extentio=
n -> SCM driver -> TZ
> >>>>>>>>
> >>>>>>>> That means the driver only maintain the capability in RAM, use i=
t when programming key.
> >>>>>>>
> >>>>>>> I don't see an interface for programming the key in this spec pat=
ch. The
> >>>>>>> Linux block driver interface includes struct blk_crypto_ll_ops wi=
th
> >>>>>>> driver functions for programming keys. I expected this spec would=
 add
> >>>>>>> operations to the virtio-blk device for implementing those functi=
ons?
> >>>>>>
> >>>>>> The design is that having a virtio_blk extension driver to handle =
the initialization of keyslot manager
> >>>>>> for virtio block with VIRTIO_BLK_F_ICE feature bit negociated. And=
 this extension driver also define the
> >>>>>> implementation of struct blk_crypto_ll_ops with driver functions f=
or programming keys, evicting keys and
> >>>>>> derive raw keys. Thees 3 key operation is done in a 'out of band' =
channel, that LA GVM calls to TrustZone
> >>>>>> (or secure VM) directly via SCM driver, bypass PVM.
> >>>>>>
> >>>>>> Add a new Kconfig VIRTIO_BLK_INLINE_CRYPTO, and this config need a=
lways to be set as Y when inline encryption
> >>>>>> on virtio block is expected.
> >>>>>>
> >>>>>> In such scenario, the key programming/eviction/derivation doesn't =
affect the virtio block protocol, so I didn't
> >>>>>> add it in this patch. Do you think it's necessary to be shown in v=
irtio SPEC in such design?
> >>>>>
> >>>>> It seems like supporting keyslot manager operations via the virtio-=
blk
> >>>>> device is a possible future use case. The design of VIRTIO_BLK_F_ICE
> >>>>> should allow for adding it in the future so that we can be confident
> >>>>> that no breaking changes will be needed.
> >>>>>
> >>>>> Why are the keyslot manager operations out of band in your TrustZon=
e use
> >>>>> case? Maybe this is related to isolation between the PVM and GVM wh=
en
> >>>>> sharing a device, but it's not clear to me that isolation is actual=
ly
> >>>>> enforced, so then I see no need for out of band keyslot manager
> >>>>> operations.
> >>>>>
> >>>>> Stefan
> >>>>
> >>>> For ICE based disk encryption (like File-Based Encryption), keyslot =
manager
> >>>> (implemeneted in blk-crypot-profile.c in latest kernel version) is r=
esponsible
> >>>> for forwarding blk-crypto-key from block layer to the bottom layer (=
i.e.
> >>>> storage driver in Bare Metal) implementing blk_crypto_ll_ops for the=
 key
> >>>> programming/eviction/derivation.=20
> >>>>
> >>>> So, for a whole inline encryption support in virtio block, virtio bl=
ock device
> >>>> must register a keyslot manager and provide the corresponding implem=
entation of
> >>>> blk_crypto_ll_ops.=20
> >>>>
> >>>> The reasons of using out-of-band channel are
> >>>>   1. In Bare Metal, the operation of key programming/eviction/deriva=
tion is also
> >>>>      through a out-of-band channel.
> >>>>      keyslot manager -> storage driver -> scm driver -> Trust Zone
> >>>>   2. Challenges of using in-band channel
> >>>>      a. Passing the blk-crypot-key to virtio blk backend in userspac=
e through the
> >>>>         virtqueue. The virtio blk backend need pass this blk-crypot-=
key to block
> >>>>         layer of PVM/Host. But it's not easy to be implemented. Addt=
ional changes
> >>>>         (like adding SET_BLK_CRYPTO_KEY blk ioctl syscal) need to be=
 added in block
> >>>>         layer. In additiona, virtio block backend uses pread/pwrite =
implementing
> >>>>         I/O in backend, it must ensure that blk-crypto-key is always=
 bound to its
> >>>>         corresponded I/O operation.
> >>>>      b. For key eviction operation, it's totally irrelevant to I/O o=
peration, the
> >>>>         block layer only pass the blk crypto key to virtio block dev=
ice via keyslot
> >>>>         manager. Even refer to virtblk_get_id to send this request t=
o virtio blk
> >>>>         backend, it faces on similar issue like programming key, tha=
t how to populate
> >>>>         blk-crypto-key to the block layer in PVM. Adding EVICT_KEY i=
octl seems not a
> >>>>         acceptable way as it exposes key evivtion operation to the u=
serspace.
> >>>
> >>> Would you be able to post a slide deck that illustrates:
> >>>
> >>> 1. The bare metal architecture with a UFS ICE device, TrustZone, the
> >>>    kernel (block layer, file systems, etc), userspace applications do=
ing
> >>>    I/O, etc.
> >>>
> >>> 2. The modified architecture with a virtio-blk ICE device with a virt=
ual
> >>>    machine monitor running in host userspace (i.e. QEMU), the emulated
> >>>    virtio-blk device, PVM/GVM, etc.
> >>>
> >>> If there is already existing documentation that shows the big picture,
> >>> that would be great. Otherwise it would help if you could draw the
> >>> diagrams.
> >>>
> >>> I need to understand the architecture in order to review this further.
> >>>
> >>> Thanks,
> >>> Stefan
> >=20
> >=20
>=20

--mxArY4nhw/940xze
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnhRcUACgkQnKSrs4Gr
c8iH2QgAlT1h1wFGYGCl9q+7htfAv/jiMouCmG4I5mUr5nUW7ZzkyG9R/3U2ke9m
MDVZVpJdE9wQeIQbGn1bTOJMOZ+jGzb/3kUNzS64VeGyvEq3AEm7v+6SgInLtG0Z
SmEpXxsYqGUbJZa9XY51Ca/aP8aFtt2n7GzYo83/QIMLC/iTC2/DfQy4jOLfzAw9
BpPcE2dhNKrQchv6QVBmXt9ntrGJYErXBPqiGUooYTw/mJh2sCNvIlXPHT9C4CMw
YXuxuT5cRuqOv+GANzneXb4kTF1Rz4utDYxtDMsSE1RRV6KsOmz4xEfTdw8vrSCT
qqbgR02WJ/h41zGp0y4il/oznrIdYw==
=ITX2
-----END PGP SIGNATURE-----

--mxArY4nhw/940xze--

