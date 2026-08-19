Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB09221D96
	for <virtio-dev@lists.linux.dev>; Wed, 19 Aug 2026 19:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787168164; cv=none; b=AgG+dBryaggA55piYV3Zo31gibyVgVpzoeMOlgnV4fo+fW3qzFfWeGD13LxUpWOJHYAjmE7Z9d3pF3hmWIVqVrzcRMdnw02pJFiZ5OKwBEbm+WKHPnnPjmMxzAmJ4DACMulsUlXDVQA04FkcnQ68nZLMEhhvkveMRHKCvKqYleg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787168164; c=relaxed/simple;
	bh=NnynFENmHaDzUgvSiA6mMe4SzPH0P3x+FBkdNrsyJUk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9aT8eXzRrTCP7urH8HHUWp5f/IYvhu2XEtHLp8MJ1epsz3RyqgAfBd5yXcgzM/OPR/WaCmBrGX7eCwv0T45+H/TUehWkMbF8L2+IwohEsz/TCID6biV92jjvQUcxmdet9Cb8MkM7j9iOeG17zjZYZQ8QC4Fvl61bRSyFdBL75U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K7xtOJ+/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7xtOJ+/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787168162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SOz//3xITEqlXioUI+IQ9OWVIIPdrdNSP6BnF8A0DTY=;
	b=K7xtOJ+/nbTvcIZuLbohWxZLnDnuiK9HN7U/8JZbKe5mlwlPJG06M5ZW51NMnb3lsgzLre
	Hx5Rl6AKiL528QLKqg0Ejgtlo5/QQAUnbmadx6O7VI+W/pgUTOR3BOGOKV0HhKqJsQAPty
	jX+MiB9r+eohxki7JVf1nlcpak8+qAA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-xqVW6E36Ou6Rcj4g0dsUqg-1; Wed,
 19 Aug 2026 15:35:58 -0400
X-MC-Unique: xqVW6E36Ou6Rcj4g0dsUqg-1
X-Mimecast-MFC-AGG-ID: xqVW6E36Ou6Rcj4g0dsUqg_1787168157
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DCE231800847;
	Wed, 19 Aug 2026 19:35:56 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6B6F3423;
	Wed, 19 Aug 2026 19:35:56 +0000 (UTC)
Date: Wed, 19 Aug 2026 15:35:55 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
Cc: Eric Biggers <ebiggers@kernel.org>, virtio-dev@lists.linux.dev,
	neeraj.soni@oss.qualcomm.com
Subject: Re: [PATCH v1] virtio-blk: Add inline encryption support
Message-ID: <20260819193555.GA470114@fedora>
References: <20260814142306.3934029-1-linlin.zhang@oss.qualcomm.com>
 <20260819043321.GB9971@sol>
 <97c80fa6-2e04-490a-8b38-c951d7c80486@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="33qZcbMcDXFPkrJW"
Content-Disposition: inline
In-Reply-To: <97c80fa6-2e04-490a-8b38-c951d7c80486@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

--33qZcbMcDXFPkrJW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 07:30:15PM +0800, Linlin Zhang wrote:
>=20
>=20
> On 8/19/2026 12:33 PM, Eric Biggers wrote:
> > On Fri, Aug 14, 2026 at 07:23:01AM -0700, Linlin Zhang wrote:
> >> When the feature is negotiated, the device reports inline encryption
> >> characteristics through virtio_blk_enc_characteristics. Add
> >> VIRTIO_BLK_T_GET_CRYPTO_MODES, VIRTIO_BLK_T_CRYPTO_IN, and
> >> VIRTIO_BLK_T_CRYPTO_OUT so that the driver can discover supported
> >> crypto modes and submit inline-encrypted I/O requests.
> >=20
> > How is the driver expected to program and evict keyslots?
>=20
> There are 2 new added drivers, one is virtio blk extension driver which is
> generic, and the other is crypto virtualization driver which is vendor
> specific.
>=20
> The virtio blk extension driver manages the initialization of blk-crypto-=
profile,
> and implements the interfaces of blk_crypto_ll_ops.
>=20
> The crypto virtualization driver performs similar operation like the key =
handling
> part in ufs-qcom and ice drivers. It forwards the key program/eviction re=
quest to
> Trust Zone via SMC call.
>=20
> For QCOM, the whole flow of key program/eviction is like
>   - block layer passes the request to virtio_blk extension driver via blk=
_crypto_ll_ops
>   - virtio_blk extension -> crypto virtualization -> qcom_scm -> SCM -> H=
YP ->TZ

Can you annotate this with "guest" and "host"? Here is my guess:
- virtio_blk + extension driver: guest
- crypto virtualization + qcom_scm + SCM: guest
- HYP: host
- TZ: host

If this is correct, then it's unclear to me why a vendor-specific guest
component is involved?

What is the advantage of shipping qcom_scm inside the guest versus
defining a standard virtio-blk interface for blk_crypto_ll_ops that the
hypervisor's virtio-blk device implements via TZ on the host?

(We talked about this in the past, but I am still not familiar enough
with the Qualcomm hypervisor architecture to understand.)

Thanks,
Stefan

--33qZcbMcDXFPkrJW
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqGBZsACgkQnKSrs4Gr
c8in/wf+I4fXSV2EaNp08gyugaqzan2sNnB+Nsl7vq40fzaUqvYCare8m8Cz/WLs
x+A6CS4DXNjUPE42UZvuCVtzMe1bb5S0yl+Q7J3qb3X6YplZkVSiNB4zKAmGmRdI
IanccMxYJVtEiSeGSEDiGSHwUJ8UTdOQ2lKfs48NVKs0e66bua/SFEez9GPErzfZ
6uLG38KiTTzCertlf2fnBS6Vc4KTN9EalYx0x6w+RW3Zx8ZnCkyBJjmogEvDFFu+
3O6NXBFkJtENCiE63pQ9bd8YiUr3lqQ9vFLAphSa23M4boARICZL0brW82C8owc8
ItsNRhYLPi98eV4+C7lsmujphTVhWw==
=60/4
-----END PGP SIGNATURE-----

--33qZcbMcDXFPkrJW--

