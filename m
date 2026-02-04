Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E19233B945
	for <virtio-dev@lists.linux.dev>; Wed,  4 Feb 2026 17:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770226077; cv=none; b=nP0D17XlCB/fJpubi9Jdyp+t8NZ683vkL+gw49moNwFNkdsUNDYTO1aa8A9vMudYWYPG0sqvB65yEdbXP3Qlchn7CBgwiynsfXBLscpoddsSmCa3H0yA2XTeuzExfmHwJCekN3WbZSYhvz5Huit6CB7DU0T/fzneJnqqrKWxpo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770226077; c=relaxed/simple;
	bh=3WDPPcW0t3uuz2gtuvDiad5AuZ6E7ucyYEKiyJGoWaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tk7oJ0ceqcZmYTp61Gyd/5htEA3MnGzQnAATqhzCTJH/rsLgJ05wa3spJIGCy5urfVi/6pq7rWPY6EP/AhTaN6sSH/QCN0VYCX5md1+JNQIEnKpt5mYxAInWZqzFT2CZesz3nBUWQNqYQP+Rg2oox97ZdPBese0tV1xjDm3NQtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JCKPB2B6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JCKPB2B6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770226075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=obFqLT37vB6Whx+5XEtz0A6Zvg73fF7Hy/f8a6eg7ao=;
	b=JCKPB2B6V1mwOgv0odF4i6Vqw4eJgmy+1WpqXibBXKfMv26JzRi0+0805Y31UQoEqpA40y
	7Pb/xzEUy0he+OCY/nDCOHJeOvAvUwctE0eUCrWufd7MTf8fK2dRDr7CI2xFjuOGg3WJsx
	Z5qLIjXWdIxZz2G9wQGKruCNoSW8xNM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-510-kSWG2_gXP0Orp0KPPwKh1A-1; Wed,
 04 Feb 2026 12:27:52 -0500
X-MC-Unique: kSWG2_gXP0Orp0KPPwKh1A-1
X-Mimecast-MFC-AGG-ID: kSWG2_gXP0Orp0KPPwKh1A_1770226071
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1F78E19560B2;
	Wed,  4 Feb 2026 17:27:51 +0000 (UTC)
Received: from localhost (unknown [10.2.16.153])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9174A19560B4;
	Wed,  4 Feb 2026 17:27:50 +0000 (UTC)
Date: Wed, 4 Feb 2026 12:27:49 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Linlin Zhang <quic_linlzhan@quicinc.com>
Cc: virtio-dev@lists.linux.dev, quic_dshaikhu@quicinc.com
Subject: Re: [PATCH v1] virtio-blk: Add inline encryption support
Message-ID: <20260204172749.GA610283@fedora>
References: <20260127141432.2617357-1-quic_linlzhan@quicinc.com>
 <20260127142032.2619551-1-quic_linlzhan@quicinc.com>
 <20260127210951.GA96301@fedora>
 <b95cf6c4-db73-49e4-969e-fa7735a07527@quicinc.com>
 <20260202155622.GA405548@fedora>
 <a704fabe-c4cb-4aa0-8460-2c57980650be@quicinc.com>
 <20260203144321.GA445116@fedora>
 <694c4abd-b86b-4bc4-8d84-588bfb059d6c@quicinc.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="iTqlhHCyo41V/Nv2"
Content-Disposition: inline
In-Reply-To: <694c4abd-b86b-4bc4-8d84-588bfb059d6c@quicinc.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


--iTqlhHCyo41V/Nv2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 04, 2026 at 09:57:11PM +0800, Linlin Zhang wrote:
> On 2/3/2026 10:43 PM, Stefan Hajnoczi wrote:
> > On Tue, Feb 03, 2026 at 06:06:33PM +0800, Linlin Zhang wrote:
> >> On 2/2/2026 11:56 PM, Stefan Hajnoczi wrote:
> >>> On Fri, Jan 30, 2026 at 06:23:55PM +0800, Linlin Zhang wrote:
> >>>> On 1/28/2026 5:09 AM, Stefan Hajnoczi wrote:
> >>>>> On Tue, Jan 27, 2026 at 10:20:32PM +0800, Linlin Zhang wrote:
> >>>>>> +  starting block of the request.
> >>>>>> +\end{itemize}
> >>>>>> +
> >>>>>>  VIRTIO_BLK_T_IN requests populate \field{data} with the contents =
of sectors
> >>>>>>  read from the block device (in multiples of 512 bytes).  VIRTIO_B=
LK_T_OUT
> >>>>>>  requests write the contents of \field{data} to the block device (=
in multiples
> >>>>>> @@ -912,6 +979,8 @@ \subsection{Device Operation}\label{sec:Device=
 Types / Block Device / Device Ope
> >>>>>>  successfully, failed, or were processed by the device at all if t=
he request
> >>>>>>  failed with VIRTIO_BLK_S_IOERR.
> >>>>>> =20
> >>>>>> +A driver MUST set \field{activate} to 0 for a non VIRTIO_BLK_F_IC=
E request.
> >>>>>
> >>>>> Please explicitly list request types where the payload field is pre=
sent
> >>>>> and where activate is optional.
> >>>>
> >>>> How about adding the following supplement?
> >>>>
> >>>>   \begin{itemize}
> >>>>   \item only when the block request contains crypto context and the =
request type
> >>>
> >>> I'm not sure what "when the block request contains crypto context"
> >>> means. Is that the same as "when VIRTIO_BLK_F_ICE has been negotiated=
"?
> >>
> >> No, crypto context means bio_crypt_ctx in BIO struct.
> >>   struct bio {
> >>   ...
> >>   #ifdef CONFIG_BLK_INLINE_ENCRYPTION
> >> 	  struct bio_crypt_ctx	*bi_crypt_context;
> >>   #endif
> >>   ...
> >>   }
> >>
> >> When VIRTIO_BLK_F_ICE has been negotiated, virtio block backend receiv=
es crypto
> >> payload from virtio block frontend, and the crypto payload, together w=
ith I/O
> >> transaction, is sent to block layer of the host finally. The crypto pa=
yload is
> >> used to construct the bio_crypt_ctx filed of BIO.
> >=20
> > Is that equivalent to struct virtio_blk_crypto_payload in this patch? If
> > yes, then I suggest only talking about the payload or slots - concepts
> > that are part of the virtio-blk inline crypto interface - instead of
> > Linux's bio_crypt_ctx.
> >=20
> > If that's not possible, then the crypto context needs to be defined in
> > the spec so that readers know what it means.
>=20
> Crypto context - bio_crypt_ctx structure - is different with virtio_blk_c=
rypto_payload.
> bio_crypt_ctx is the struct bound to BIO and request structs in Linux to =
imply this is
> a inline encryption bio/request. While virtio_blk_crypto_payload is a new=
 struct in this
> patch, it is used to issue the inline encryption metadata (slot, activate=
, DUN) to the
> virtio backend, so that the backend virtio device can use such inline enc=
ryption metadata
> to initialized the crypto info of Storage protocol. For instance, the CCI=
 in DW0 of UTP
> Transfer Request Descriptor.
>=20
> Change it to the following.
>   \begin{itemize}
>   \item only when the block request contains a valid bio_crypt_ctx and th=
e request type
>   is one of VIRTIO_BLK_T_IN, VIRTIO_BLK_T_OUT and VIRTIO_BLK_T_FLUSH,\fie=
ld{activate} MUST
>   be set to 1. bio_crypt_ctx is defined in linux/blk-crypto.h.
>     \begin{lstlisting}
>     struct bio_crypt_ctx {
>         const struct blk_crypto_key     *bc_key;
>         u64                             bc_dun[BLK_CRYPTO_DUN_ARRAY_SIZE];
>     };
>     \end{lstlisting}

bio_crypt_ctx is Linux-specific. Can you phrase this in a way that does
not rely on Linux block layer concepts?

For example:

  The \field{activate} field is set to 1 on VIRTIO_BLK_T_IN,
  VIRTIO_BLK_T_OUT, and VIRTIO_BLK_T_FLUSH requests that require inline
  encryption. For other request types or when inline encryption is not
  required, it is set to 0.

Thanks,
Stefan

--iTqlhHCyo41V/Nv2
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmmDgZUACgkQnKSrs4Gr
c8hrrwgAxk6twn/r30jNrLVg7ma5ZFK2Y6AkFbLySPrq8ArAfTBGANfLkc3EKu52
O5XQpAotbU+w1QKwbhEX9/yacLswP2cRFmzDg0r3ncHNCqdPjQCi8P0YGW3ZtTu6
nm3WHNxps35Sih40SOS1DVt/K6f7jHJCvWgOEG2Kzh9BJ3F3Lin5jpSNdwWcCybh
zCx7UFKlQyyCfuyyMSxBQY4fPb+caB5ThoGFgvoDBCDRqZHduufLDMT6YGsVtmkx
Ot3JwNJJMQdjZNqtxQm9aGWz5j5YGVkkHFK7F++O1Z6yEvSpL973fmbBTNbiVvz1
FBYcw0FswrSybLZfK+Bsk2VIKpOH3g==
=2mn1
-----END PGP SIGNATURE-----

--iTqlhHCyo41V/Nv2--

