Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060EA2D7398
	for <virtio-dev@lists.linux.dev>; Fri, 21 Aug 2026 15:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787326444; cv=none; b=u/4C7wDhOPAKJFV5ixamzXGej/Pd0rzEEiiLbUqkITVMDHFi1lE5dAccN7TOp9a636Tsy6YKrsUmpnpAUhHa5wgW6Fx1YCnV0XlE1hY3dEm2tItEErW2VdUVvspnPFK4yQA6+2shXpPDJBUyj5dv8gF6vpwmv/VfGkuvqt4qHK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787326444; c=relaxed/simple;
	bh=wKjbjNYX6dSHvpp1ev8u3F9bQZ5pxwRqViWTQ6mlA4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IwAh8xiS0710pAhhW2HQknez7o7qlfbCACauAQIV/urPkedz0tbM2Y0GlyYSrD4TvInuI8TgqexelzlspG2kpF3H9akBCxGRaYmQ+ZWCDfVib00sC17T2wMeCJSq6E40JlhDMDPU6blknQnoShgdmetol87ii9MFddiGCoP2EwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X0a4eSA2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0a4eSA2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787326441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wKjbjNYX6dSHvpp1ev8u3F9bQZ5pxwRqViWTQ6mlA4o=;
	b=X0a4eSA2GGPe1I5n6TxZS0y7KyfvBYJqMvm15Z3v8SXmNU7PE45xzB9fGay0bJRKojQUeg
	unbxkP9OgrU0i49yVe6EFv6UrvuVWCWJ4v/094LmT4wPH4aj8aGU5oZXMVXuyZKzUdr5bm
	cn5tzJf7KdrzqeZLOOa1zntcRGntxY4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-536-KiE_D1SKPACEq-7N3deZug-1; Fri,
 21 Aug 2026 11:33:56 -0400
X-MC-Unique: KiE_D1SKPACEq-7N3deZug-1
X-Mimecast-MFC-AGG-ID: KiE_D1SKPACEq-7N3deZug_1787326432
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C5DD61802673;
	Fri, 21 Aug 2026 15:33:52 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5D04E7D6;
	Fri, 21 Aug 2026 15:33:52 +0000 (UTC)
Date: Fri, 21 Aug 2026 11:33:51 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
Cc: virtio-dev@lists.linux.dev, ebiggers@kernel.org,
	neeraj.soni@oss.qualcomm.com
Subject: Re: [PATCH v1] virtio-blk: Add inline encryption support
Message-ID: <20260821153351.GB564943@fedora>
References: <20260814142306.3934029-1-linlin.zhang@oss.qualcomm.com>
 <20260819211845.GB470114@fedora>
 <c66459c5-0207-4cc5-bea7-71fe0e600aa1@oss.qualcomm.com>
 <8ee0da17-1d2b-4465-8fd5-3f6ab401d729@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0rFnCPdFLm++KzGW"
Content-Disposition: inline
In-Reply-To: <8ee0da17-1d2b-4465-8fd5-3f6ab401d729@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

--0rFnCPdFLm++KzGW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 08:49:03PM +0800, Linlin Zhang wrote:
>=20
>=20
> On 8/21/2026 12:18 AM, Linlin Zhang wrote:
> >=20
> >=20
> > On 8/20/2026 5:18 AM, Stefan Hajnoczi wrote:
> >> On Fri, Aug 14, 2026 at 07:23:01AM -0700, Linlin Zhang wrote:
> >=20
> >>> +\field{enc_characteristics}, or that identifies a key slot into whic=
h no key
> >>> +has been provisioned.
> >>> +
> >>> +A driver MUST set \field{data_unit_size_bits} of a VIRTIO_BLK_T_CRYP=
TO_IN or
> >>> +VIRTIO_BLK_T_CRYPTO_OUT request's \field{crypto_msg} to $log_2$ of t=
he data
> >>> +unit size in bytes associated with the key provisioned in the virtua=
l key
> >>> +slot identified by \field{slot}. Since data unit sizes are reported =
by
> >>> +VIRTIO_BLK_T_GET_CRYPTO_MODES as a bitmask of \field{le32} elements,=
 a
> >>> +driver MUST NOT set \field{data_unit_size_bits} to a value greater t=
han 31.
> >>> +
> >>> +A driver MUST NOT submit a VIRTIO_BLK_T_CRYPTO_IN or VIRTIO_BLK_T_CR=
YPTO_OUT
> >>> +request with a zero length \field{data}.
> >>
> >> Does VIRTIO_BLK_T_WRITE_ZEROES need an equivalent
> >> VIRTIO_BLK_T_CRYPTO_WRITE_ZEROES request type? If the driver sends
> >> VIRTIO_BLK_T_WRITE_ZEROES then the device might write zeroes in
> >> plaintext, which isn't what we want.
> >>
> >=20
> > Yes, it's still cipher text that is flushed into disk even the driver s=
ends
> > VIRTIO_BLK_T_WRITE_ZEROES. Need add a VIRTIO_BLK_T_CRYPTO_WRITE_ZEROES =
request
> > type.
> >=20
>=20
> I double-checked VIRTIO_BLK_T_WRITE_ZEROES. Since a request may consist of
> multiple non-contiguous segments, handling DUN calculation becomes diffic=
ult
> if the backend needs to divide the request. Because both sector offset and
> data length per segment need be aligned with Data Unit Size, and only the=
 DUN
> for the first segment can be appended to the crypto message in the virtio=
 reqeust.
>=20
> For this reason, I would prefer not to introduce VIRTIO_BLK_T_CRYPTO_WRIT=
E_ZEROES,
> consistent with the treatment of discard/erase requests.
>=20
> I'm appreciated if you have any thoughts about it.

The storage stack supports devices that do not have write zeroes
operations, so I don't think there is any problem - except that the
performance benefits of write zeroes are lost.

It's worth adding a sentence to the spec as a reminder that only
VIRTIO_BLK_T_CRYPTO_WRITE/READ are encrypted so drivers must not reach
for write_zeroes, etc since they are not encrypted.

And the Linux driver implementation needs to be careful not to send
write zeroes.

Stefan

--0rFnCPdFLm++KzGW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqIb98ACgkQnKSrs4Gr
c8j2rwgAnihJbZErMOCDwsML7+fsr+2kjEhp3ONcJI+OQsbf1p7Yc0rdJ1VrUCvJ
WkbQyMX0jXforw1X2FTbTB0tQfmUC4C/fMSBa3G0Bm28UIwWb9dtzDtHS/P9Mt93
/fKREVBZ6lMZLEuaPRfDSgSDO3Kjs9oM+FapCaYdLJY232zIuog3R0vFElDkV/Hr
dtNDUeEG74BN8e7Y/rPE+CvjmtsDr4rg9Fq85lhSaCJN/lstJfCxbRQsLORyTq7x
xRFp4ec4lg9th7eambQ9xFtLUlKoW8jcBf+YQrTiIKRFlU5Mggvcv4fwk+VsFBMC
e+JSbJ284feN9v31CGrsPHY+53MLQg==
=mQKU
-----END PGP SIGNATURE-----

--0rFnCPdFLm++KzGW--

