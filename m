Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8723361941
	for <virtio-dev@lists.linux.dev>; Mon, 31 Aug 2026 20:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788206708; cv=none; b=qhW5M69Ly0GrL+wdIEv8Tg3ov1IeprOX7yvyWtKQbZmeuc8+iK/VO+PqLWLcSs/VRW313FunsattQ3/Twb2n8lnStr74kN+e3RLhfC8Bya29us+ed2AtDhAoB1IXrA1ZOG2AcaG+6/SFg0fifUQvVew4vlDR6jlOh4PrbCMbInI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788206708; c=relaxed/simple;
	bh=PBIR/pcU+Q2ggkYJlXbFmj/JP2Mgbs7aoWM0o6akx4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mxwobv+dsgRbT/UbTyyctFPqTfYUuOu0pArcegZ31xPQUzbKm5p9YwUkOxT0925XiyHQLG3SI81AKwfT2QBxKuLEyq/Ym69dQ3NbWqw/WfFcLN1174ADzv4vDZSJSQEqTqlDSbkaNrRCWxm+3+Ksq93207Y2/oqueifk0/lSDmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WTIdQuZT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTIdQuZT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1788206704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Xjr/ml0NmualOD3BBUsEEtw9iQNH+jzRc0uUiPjbvDs=;
	b=WTIdQuZTxlcx4y4tnl5Gs3p/A2uI+ny13wqzJA1sOiQEWOUCJKcl54L/OVq7+P/HYU+UO1
	Lc5696O+WN0PkR0ou6HdKWnyq6yDwSHI/gvTxZV+nHabdPFrIhukuJzYQApN5FOQEX2nFn
	HWzukY9jvlJBqfH9FIOiJM2+JBjC4fs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-8ALZmOOSNX2WO-N8reo3xg-1; Mon,
 31 Aug 2026 16:05:01 -0400
X-MC-Unique: 8ALZmOOSNX2WO-N8reo3xg-1
X-Mimecast-MFC-AGG-ID: 8ALZmOOSNX2WO-N8reo3xg_1788206700
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 203B018AB44A;
	Mon, 31 Aug 2026 20:05:00 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 73FD61800577;
	Mon, 31 Aug 2026 20:04:59 +0000 (UTC)
Date: Mon, 31 Aug 2026 16:04:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
Cc: Eric Biggers <ebiggers@kernel.org>, virtio-dev@lists.linux.dev,
	neeraj.soni@oss.qualcomm.com
Subject: Re: [PATCH v1] virtio-blk: Add inline encryption support
Message-ID: <20260831200455.GB527638@fedora>
References: <20260814142306.3934029-1-linlin.zhang@oss.qualcomm.com>
 <20260819043321.GB9971@sol>
 <97c80fa6-2e04-490a-8b38-c951d7c80486@oss.qualcomm.com>
 <20260819193555.GA470114@fedora>
 <5d1a54d2-9e84-4a85-9124-ac9cbff75fdf@oss.qualcomm.com>
 <20260825233409.GA282683@fedora>
 <3605b7f4-820e-4a1d-999b-edaf0dbaea41@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n04PMN23K8sM2RSv"
Content-Disposition: inline
In-Reply-To: <3605b7f4-820e-4a1d-999b-edaf0dbaea41@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

--n04PMN23K8sM2RSv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 09:08:26PM +0800, Linlin Zhang wrote:
>=20
>=20
> On 8/26/2026 7:34 AM, Stefan Hajnoczi wrote:
> > On Thu, Aug 20, 2026 at 10:37:47PM +0800, Linlin Zhang wrote:
> >>
> >>
> >> On 8/20/2026 3:35 AM, Stefan Hajnoczi wrote:
> >>> On Wed, Aug 19, 2026 at 07:30:15PM +0800, Linlin Zhang wrote:
> >>>>
> >>>>
> >>>> On 8/19/2026 12:33 PM, Eric Biggers wrote:
> >>>>> On Fri, Aug 14, 2026 at 07:23:01AM -0700, Linlin Zhang wrote:
> >>>>>> When the feature is negotiated, the device reports inline encrypti=
on
> >>>>>> characteristics through virtio_blk_enc_characteristics. Add
> >>>>>> VIRTIO_BLK_T_GET_CRYPTO_MODES, VIRTIO_BLK_T_CRYPTO_IN, and
> >>>>>> VIRTIO_BLK_T_CRYPTO_OUT so that the driver can discover supported
> >>>>>> crypto modes and submit inline-encrypted I/O requests.
> >>>>>
> >>>>> How is the driver expected to program and evict keyslots?
> >>>>
> >>>> There are 2 new added drivers, one is virtio blk extension driver wh=
ich is
> >>>> generic, and the other is crypto virtualization driver which is vend=
or
> >>>> specific.
> >>>>
> >>>> The virtio blk extension driver manages the initialization of blk-cr=
ypto-profile,
> >>>> and implements the interfaces of blk_crypto_ll_ops.
> >>>>
> >>>> The crypto virtualization driver performs similar operation like the=
 key handling
> >>>> part in ufs-qcom and ice drivers. It forwards the key program/evicti=
on request to
> >>>> Trust Zone via SMC call.
> >>>>
> >>>> For QCOM, the whole flow of key program/eviction is like
> >>>>   - block layer passes the request to virtio_blk extension driver vi=
a blk_crypto_ll_ops
> >>>>   - virtio_blk extension -> crypto virtualization -> qcom_scm -> SCM=
 -> HYP ->TZ
> >>>
> >>> Can you annotate this with "guest" and "host"? Here is my guess:
> >>> - virtio_blk + extension driver: guest
> >>> - crypto virtualization + qcom_scm + SCM: guest
> >>> - HYP: host
> >>> - TZ: host
> >>>
> >>> If this is correct, then it's unclear to me why a vendor-specific gue=
st
> >>> component is involved?
> >>
> >> Thanks for your comments!
> >>
> >> That 's correct basically.
> >>
> >> - Guest VM
> >> - virtio-blk + virtio-blk crypto extension
> >> - crypto virtualization driver + qcom_scm
> >> - SCM interface
> >>
> >> - Secure World/Platform
> >> - Hypervisor
> >> - Trust Zone
> >>
> >> The primary purpose of introducing a vendor-specific guest component i=
s to
> >> enable the guest VM to handle key programming and eviction directly th=
rough
> >> TrustZone, avoiding any dependency on the primary VM for these operati=
ons.
> >=20
> > If I understand correctly, you are saying that the qcom_scm driver
> > inside the guest (EL1) uses the SMC instruction to trap directly into
> > the host's Secure World (EL3) without going through the hypervisor
> > (EL2)?
> >=20
>=20
> There are 2 kinds of hypervisors. Sorry that I only focused on the type-1
> hypervisor previously.
>=20
> For type-1 hypervisor, qcom_scm driver inside the guest (EL1) uses the
> SMC instruction to trap into the hypervisor (EL2) first, and the hypervis=
or
> transfers SMC call to the Secure World (EL3), totally bypass the primary =
VM.
>=20
> For type-2 hypervisor, qcom_scm driver inside the guest (EL1) goes to the
> host via HAB driver (which is in upstream progress), the host (EL2)
> transfers SMC call to the Secure World (EL3).

I see. The VM exit performance advantage with SCM does not seem to be
that great since EL2 is involved in both cases, just that the primary VM
can be bypassed in the Type 1 case.

Technically it ought to be possible to bypass the Type 1 primary VM even
with a virtqueue (similar to how vhost devices in the Linux kernel can
offload virtqueues from QEMU userspace to the host kernel), but that
involves extra work and complexity - it's only worth it key programming
this is performance bottleneck.

> > If the virtio-blk interface standardized blk_crypto_ll_ops requests,
> > then virtqueue requests would instead be used instead of SMC
> > instructions and the hypervisor's (EL2) device emulation would handle
> > the key programming on behalf of the guest.
> >=20
>=20
> Thanks for the point!
>=20
> The hypervisor's (EL2) device emulation you mean is QEMU, right?=20
> I said QEMU in the following as the hypervisor's (EL2) device emulation.
>=20
> If I understand correctly, the key programming flow you suggested is like
> the following.
>=20
>   GVM -> blk_crypto_ll_ops in virtio-blk
>       -> virtqueue request
>       -> the hypervisor's (EL2) device emulation (QEMU)
>       -> key programming in Host module
>       -> ICE
>=20
> To support it,=20
>   1. need create a new control queue for the transmission of blk_crypto_l=
l_ops
>      requests
>   2. in the program key interface of blk_crypto_ll_ops, it has the key
>      and the slot index the key provisioned to, Guest VM only knows the
>      virtual slots, so the virt_slot need be transferred to the correspon=
ding
>      physical one in QEMU or the following flow before programming it to =
ICE

Security could be improved by limiting QEMU's key slot index range to
the virtual slots assigned to the guest. That way QEMU has no more
privileges than the guest and the impact of a VM escape is reduced.

>   3. QEMU is a userspace process, we need add new blk ioctls (like key
>      generate/import/prepare ioctls added recently) to allow the
>      userpsace client to program a key to ICE
>=20
> The 3rd point is my main concern, if such ioctls (program/evict/derive_sw=
_secret)
> can be added, especially that the program key ioctl which specifies the k=
ey to the exact
> slot, and the evict key ioctl which allows the usespace client wipe the k=
ey
> in a specific slot. I thought it's a high security concern.

Yes, I think it would be necessary to limit userspace's physical key
slot access. The driver interface (e.g. ioctl) should be designed to
restrict the key slot index range.

>=20
> Another concern is the broken of key isolation b/w VMs, except more VM ex=
it
> operations.
>=20
> >> Because SCM firmware interfaces can differ across vendors, the design
> >> introduces an intermediate crypto virtualization layer. This layer pro=
vides
> >> a common abstraction for key management operations, while allowing each
> >> vendor to implement the backend interfaces according to its specific S=
CM
> >> firmware and security architecture.
> >=20
> > Which layer is the "intermediate crypto virtualization layer" that you
> > are describing? I don't see that in this spec proposal. Is it the
> > existing blk_crypto_ll_ops struct in Linux?
> >=20
>=20
> I mean the 'crypto virtualization driver', which is corresponding to the
> crypto_virt.c in the kernel patch series.
>=20
> See https://lore.kernel.org/all/20260827160806.1295313-3-linlin.zhang@oss=
=2Equalcomm.com/

Thanks, I will take a look.

>=20
> >>> What is the advantage of shipping qcom_scm inside the guest versus
> >>> defining a standard virtio-blk interface for blk_crypto_ll_ops that t=
he
> >>> hypervisor's virtio-blk device implements via TZ on the host?
> >>
> >> Keeping SCM in the guest preserves key isolation, minimizes virtio-blk
> >> payloads, and avoids additional inter-VM communication.
> >>
> >> Key programming occurs after a request has entered the block request
> >> queue. Performing it through a standard virtio-blk request would requi=
re
> >> issuing key request in the same request before handling I/O path,
> >> introducing dead lock concerns.
> >=20
> > A separate key programming virtqueue can be used to avoid deadlock
> > concerns. That way is is still possible to access the key programming
> > interface when a request queue is full.
> >=20
>=20
> Thanks.
> I agree with you. A separate control virtqueue must be added for the
> virtio-blk interface standardized blk_crypto_ll_ops requests.
>=20
> >> In my opinion, passing the encryption key in each virtio-blk request is
> >> also undesirable, as it exposes key material outside the guest, increa=
ses
> >> request size, and adds VM transition overhead.
> >=20
> > I'm not sure there is a significant security benefit since the device
> > emulation code in the hypervisor already has access to the plaintext I/O
> > buffers, can snoop guest memory, and can cause guest code execution
> > (including accessing the qcom_scm driver inside the guest)?
> > > Regarding the VM transition overhead, I think you are right unless blk
> > crypto changes are made to allow a more efficient request submission
> > scheme (like combining key programming with I/O requests if there is a
> > bottleneck in the I/O path). However, it's not clear to me whether key
> > programming is a performance bottleneck: hopefully key programming does
> > not happen in the I/O path and only in the control path when opening a
> > file or directory?
> >=20
>=20
> Thanks for the clarification.
>=20
> From the memory visibility perspective, I agree with you that the guest
> keys are transparent for the host. From the key's ownership aspect, I
> feel that the host programming the key on behalf of the guest leads to
> the ownership change, I'm not sure if it's a security concern.
>=20
> The key programming occurs when submitting BIO to the request in the I/O
> path, which means pre read/write from the virito device triggers programi=
ng
> key first(vm exit -> QEMU -> the host program key module -> TZ -> ICE ->
> back to the guest), and then send IO request(vm exit -> QEMU -> the host
> I/O path). Compared with the SMC call from GVM solution (implemented in
> https://lore.kernel.org/linux-block/20260827160806.1295313-1-linlin.zhang=
@oss.qualcomm.com/T/#u),
> the key programming via virtio involves one 1 more vm exit.

Can you clarify what you mean by "1 more vm exit", that wording is
confusing to me since an SMC guest instruction also causes a vm exit?

>=20
> > My concern about the key programming interface being a vendor-specific
> > interface beyond the scope of the VIRTIO spec is that I'm not sure if
> > there will ever be any other users. In other words, should ICE actually
> > go into the VIRTIO spec or is it a vendor-specific functionality?
> >=20
>=20
> I have confidence that this is a generic requirement for the virtualizati=
on
> platform. It's better to have it in the virtio SPEC.
> And there is a new common virtio block ops added for the key programming.
> This allows the vendor to implement the key program based on their platfo=
rm.
>=20
> See https://lore.kernel.org/all/20260827160806.1295313-3-linlin.zhang@oss=
=2Equalcomm.com/,
> the vendor need implement the virtblk_crypto_variant_ops in=20
> https://lore.kernel.org/all/20260827160806.1295313-2-linlin.zhang@oss.qua=
lcomm.com/#Z31include:linux:virtio_blk_crypto_ext.h

These are Linux kernel patches, not VIRTIO spec definitions. The VIRTIO
spec is independent of the Linux kernel source code (except where
explicitly designed to pass through Linux structures). There needs to be
information in the VIRTIO spec about the key programming interface
concepts so that someone implementing a driver or device knows how key
slots behave even if the actual programming interface (e.g. Qualcomm's
SCM interface) details are not covered by the spec.

>=20
> > The approach with a separate key programming interface seems very
> > specific to UFS and Qualcomm's SCM. For example, is it possible to have
> > multiple virtio-blk devices with their own ICEs (key spaces) or does
> > this design assume there is only one virtio-blk device with ICE per
> > guest because existing SoCs only support that?
> >=20
>=20
> Yes. This design does allow multiple virtio-blk devices with inline
> encryption supported. And per virtio-blk device has its own ICE. Though
> only one ICE is assumed in above Linux patch set, a small change can
> be made to support different virtio-blk devices with different ICEs,
> and don't need update the virtio SPEC.
>=20
> > It would be cleaner and more obvious from a spec perspective if the key
> > programming interface was part of the VIRTIO spec. Then the spec would
> > be self-contained and the vendor-specific part would only be in the
> > device's implementation on the host without also requiring
> > vendor-specific drivers inside the guest.
> >=20
> > I took a look at the few blk_ll_crypto_ops drivers in the Linux kernel
> > and they are more or less copy-pasted code that only exists because
> > there is no standardized hardware interface. I think we should avoid
> > propagating that into VIRTIO and instead just define a key programming
> > virtqueue for the virtio-blk device once and for all.
> >=20
>=20
> I agree with you that programming interfaces in virtio SPEC makes it more
> clear for the one who implements it. Current design is a compromise of
> the security concern and the virtio protocol. Implementing it need a
> full understanding of the inline encryption feature bit in virtio SPEC
> and the virtio blk code in the Linux kernel.(See the above link of
> virtio_blk_crypto_ext.h)
>=20
> Would you please go through the virtio blk inline encryption support
> patch (https://lore.kernel.org/all/20260827160806.1295313-3-linlin.zhang@=
oss.qualcomm.com/)
> and double confirm if this combination (virtio spec defines the data
> flow for crypto IO, virtio_blk_crypto_ext defines the control flow
> of crypto IO) can be accepted?
>=20
> I'm appreciated your insights.

Sure, I will take a look at the Linux patches.

Stefan

>=20
> > Having said that, there is much I don't know about ICE, ARM
> > virtualization, etc and I would like to hear your thoughts if you think
> > I'm wrong.
> >=20
> > Thanks,
> > Stefan
> >=20
> >>
> >>>
> >>> (We talked about this in the past, but I am still not familiar enough
> >>> with the Qualcomm hypervisor architecture to understand.)
> >>>
> >>> Thanks,
> >>> Stefan
> >>
>=20

--n04PMN23K8sM2RSv
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqV3mcACgkQnKSrs4Gr
c8gQbwf/Zlkt8uxW9ieOIlYqepDzEMjzaXSBMx0dGQd9fzxyyQsCehT2c+uYhSir
0WaZ2Mv/c+5lE4OkRdx1f1CaOhVPZq/4NljAlSxbhxKzWhi3rQYlXGXfGc5EkqJK
f/BAH5L0PJt4jxqxw3uDdQ3jkOuXYvBlXp7nq5u6L4Y9RCib8bMQ5I8bJGM9MEvW
9crSsPTJuGue5eSa0CWtDRzZsyzOo0bE0oaRv+ji0azmGAphdsCbG0jNsvh55U6f
r3tluxGEyMHWy/zXDrCWA3jo4uZc2RH6XqbbqBH4WmazugfLhjNIOKBrFq563Mzo
Nei9MR1IJAD5iQQATz2tImhH/nR4Aw==
=PN3z
-----END PGP SIGNATURE-----

--n04PMN23K8sM2RSv--

