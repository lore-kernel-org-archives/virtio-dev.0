Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3561223EA94
	for <virtio-dev@lists.linux.dev>; Tue, 25 Aug 2026 23:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787701089; cv=none; b=GSY1iOwW1S79PJzKjaEwDTkqveeud7UWuNF2PiTj4R9a322prSAxoaRCk/JvyN3G17bvLGQvpywWFw28hzG8BYU/G3XarpdWaA0k11/oBmwMVWZfH+XZAE9efrq3poxAcXDoiyVfuGq7hP9oN6n+uzxu8lN+ZA3qQ7yDj9esJ1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787701089; c=relaxed/simple;
	bh=V0GoBhPsvfVLz00OO3oMKuDBh/9sJ4/KujjFq253NUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FpyiS0yW9874aDDHdhnbLGmV55MDgV6w1opy1fP6hvwOO3ndiACK9mH5redWthHQsobU4AxYn6iq+Qv9PQq0tLJFACG7B7vnEJYaPQZS+aTT2jp6emCZhceRnsdc8xmvS+U9VrvWkINV3JDhSMmQKUpPVRAjRsap5y/NIPL+dVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S0swEIEg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S0swEIEg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787701086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OPE+Yys+zZc/Atwmhm2YSTqYXxDjqkQPe0D3crRLebk=;
	b=S0swEIEgQBOHiOg1QWmzh7S8ozIqZP+nBGKGhZkkJVGTi2eJsGr6ZX7Mpi2Da4zAKbkPAP
	92K502CUCC0UVRtpffC4+bTrMlJfF6VVIhOafArjHda4wpi/emteDgsX3jFFf1SDcZvEZZ
	I2xJWj+v/NSNzSMbIFytAx1n5TT/BvY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-296-Cc8X8WW5OcS9JMmOtdOxQg-1; Tue,
 25 Aug 2026 19:38:02 -0400
X-MC-Unique: Cc8X8WW5OcS9JMmOtdOxQg-1
X-Mimecast-MFC-AGG-ID: Cc8X8WW5OcS9JMmOtdOxQg_1787701081
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D0092183F9E5;
	Tue, 25 Aug 2026 23:38:00 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4F6A91801AFF;
	Tue, 25 Aug 2026 23:38:00 +0000 (UTC)
Date: Tue, 25 Aug 2026 19:34:09 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
Cc: Eric Biggers <ebiggers@kernel.org>, virtio-dev@lists.linux.dev,
	neeraj.soni@oss.qualcomm.com
Subject: Re: [PATCH v1] virtio-blk: Add inline encryption support
Message-ID: <20260825233409.GA282683@fedora>
References: <20260814142306.3934029-1-linlin.zhang@oss.qualcomm.com>
 <20260819043321.GB9971@sol>
 <97c80fa6-2e04-490a-8b38-c951d7c80486@oss.qualcomm.com>
 <20260819193555.GA470114@fedora>
 <5d1a54d2-9e84-4a85-9124-ac9cbff75fdf@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Hix4mzlQLUDCeXas"
Content-Disposition: inline
In-Reply-To: <5d1a54d2-9e84-4a85-9124-ac9cbff75fdf@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

--Hix4mzlQLUDCeXas
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 10:37:47PM +0800, Linlin Zhang wrote:
>=20
>=20
> On 8/20/2026 3:35 AM, Stefan Hajnoczi wrote:
> > On Wed, Aug 19, 2026 at 07:30:15PM +0800, Linlin Zhang wrote:
> >>
> >>
> >> On 8/19/2026 12:33 PM, Eric Biggers wrote:
> >>> On Fri, Aug 14, 2026 at 07:23:01AM -0700, Linlin Zhang wrote:
> >>>> When the feature is negotiated, the device reports inline encryption
> >>>> characteristics through virtio_blk_enc_characteristics. Add
> >>>> VIRTIO_BLK_T_GET_CRYPTO_MODES, VIRTIO_BLK_T_CRYPTO_IN, and
> >>>> VIRTIO_BLK_T_CRYPTO_OUT so that the driver can discover supported
> >>>> crypto modes and submit inline-encrypted I/O requests.
> >>>
> >>> How is the driver expected to program and evict keyslots?
> >>
> >> There are 2 new added drivers, one is virtio blk extension driver whic=
h is
> >> generic, and the other is crypto virtualization driver which is vendor
> >> specific.
> >>
> >> The virtio blk extension driver manages the initialization of blk-cryp=
to-profile,
> >> and implements the interfaces of blk_crypto_ll_ops.
> >>
> >> The crypto virtualization driver performs similar operation like the k=
ey handling
> >> part in ufs-qcom and ice drivers. It forwards the key program/eviction=
 request to
> >> Trust Zone via SMC call.
> >>
> >> For QCOM, the whole flow of key program/eviction is like
> >>   - block layer passes the request to virtio_blk extension driver via =
blk_crypto_ll_ops
> >>   - virtio_blk extension -> crypto virtualization -> qcom_scm -> SCM -=
> HYP ->TZ
> >=20
> > Can you annotate this with "guest" and "host"? Here is my guess:
> > - virtio_blk + extension driver: guest
> > - crypto virtualization + qcom_scm + SCM: guest
> > - HYP: host
> > - TZ: host
> >=20
> > If this is correct, then it's unclear to me why a vendor-specific guest
> > component is involved?
>=20
> Thanks for your comments!
>=20
> That 's correct basically.
>=20
> - Guest VM
> - virtio-blk + virtio-blk crypto extension
> - crypto virtualization driver + qcom_scm
> - SCM interface
>=20
> - Secure World/Platform
> - Hypervisor
> - Trust Zone
>=20
> The primary purpose of introducing a vendor-specific guest component is to
> enable the guest VM to handle key programming and eviction directly throu=
gh
> TrustZone, avoiding any dependency on the primary VM for these operations.

If I understand correctly, you are saying that the qcom_scm driver
inside the guest (EL1) uses the SMC instruction to trap directly into
the host's Secure World (EL3) without going through the hypervisor
(EL2)?

If the virtio-blk interface standardized blk_crypto_ll_ops requests,
then virtqueue requests would instead be used instead of SMC
instructions and the hypervisor's (EL2) device emulation would handle
the key programming on behalf of the guest.

> Because SCM firmware interfaces can differ across vendors, the design
> introduces an intermediate crypto virtualization layer. This layer provid=
es
> a common abstraction for key management operations, while allowing each
> vendor to implement the backend interfaces according to its specific SCM
> firmware and security architecture.

Which layer is the "intermediate crypto virtualization layer" that you
are describing? I don't see that in this spec proposal. Is it the
existing blk_crypto_ll_ops struct in Linux?

> > What is the advantage of shipping qcom_scm inside the guest versus
> > defining a standard virtio-blk interface for blk_crypto_ll_ops that the
> > hypervisor's virtio-blk device implements via TZ on the host?
>=20
> Keeping SCM in the guest preserves key isolation, minimizes virtio-blk
> payloads, and avoids additional inter-VM communication.
>=20
> Key programming occurs after a request has entered the block request
> queue. Performing it through a standard virtio-blk request would require
> issuing key request in the same request before handling I/O path,
> introducing dead lock concerns.

A separate key programming virtqueue can be used to avoid deadlock
concerns. That way is is still possible to access the key programming
interface when a request queue is full.

> In my opinion, passing the encryption key in each virtio-blk request is
> also undesirable, as it exposes key material outside the guest, increases
> request size, and adds VM transition overhead.

I'm not sure there is a significant security benefit since the device
emulation code in the hypervisor already has access to the plaintext I/O
buffers, can snoop guest memory, and can cause guest code execution
(including accessing the qcom_scm driver inside the guest)?

Regarding the VM transition overhead, I think you are right unless blk
crypto changes are made to allow a more efficient request submission
scheme (like combining key programming with I/O requests if there is a
bottleneck in the I/O path). However, it's not clear to me whether key
programming is a performance bottleneck: hopefully key programming does
not happen in the I/O path and only in the control path when opening a
file or directory?

My concern about the key programming interface being a vendor-specific
interface beyond the scope of the VIRTIO spec is that I'm not sure if
there will ever be any other users. In other words, should ICE actually
go into the VIRTIO spec or is it a vendor-specific functionality?

The approach with a separate key programming interface seems very
specific to UFS and Qualcomm's SCM. For example, is it possible to have
multiple virtio-blk devices with their own ICEs (key spaces) or does
this design assume there is only one virtio-blk device with ICE per
guest because existing SoCs only support that?

It would be cleaner and more obvious from a spec perspective if the key
programming interface was part of the VIRTIO spec. Then the spec would
be self-contained and the vendor-specific part would only be in the
device's implementation on the host without also requiring
vendor-specific drivers inside the guest.

I took a look at the few blk_ll_crypto_ops drivers in the Linux kernel
and they are more or less copy-pasted code that only exists because
there is no standardized hardware interface. I think we should avoid
propagating that into VIRTIO and instead just define a key programming
virtqueue for the virtio-blk device once and for all.

Having said that, there is much I don't know about ICE, ARM
virtualization, etc and I would like to hear your thoughts if you think
I'm wrong.

Thanks,
Stefan

>=20
> >=20
> > (We talked about this in the past, but I am still not familiar enough
> > with the Qualcomm hypervisor architecture to understand.)
> >=20
> > Thanks,
> > Stefan
>=20

--Hix4mzlQLUDCeXas
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqOJnEACgkQnKSrs4Gr
c8j+nQf/afTYTomphs6e2lXjMYWm5F6c7HwOGaOb88iDTLC6Qa5SjLBagNJ9CE1k
6H0ccXQmQMMJskf+ROJ5KCOcpHwz2pBJhLHznO+ajsbTJn17pKIbpGepX3qQTSqh
oM2bjII/kkwbhA43MxrOxpWfHn5KPGKHVBq3FVgmUyC9OpS7VUoIWccrX0kD7LnV
PBHezQ5MKWHZ+548oaQ6rj8YhxnAh0hNbn2+sN9kWUMmLXlAUA/VgQ52rXg7xAIx
6wK2inbQezZjqDTJU/qFYrXBC7L7Uf7eFCuOqeEejwFzMhlMfSxV9YEDV2Nk7c7i
+u0rXeYnda8WCbmOc9d2SRzVUbcERQ==
=waFD
-----END PGP SIGNATURE-----

--Hix4mzlQLUDCeXas--

