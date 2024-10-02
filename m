Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DD81D0491
	for <virtio-dev@lists.linux.dev>; Wed,  2 Oct 2024 13:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876547; cv=none; b=n8yZoIE9FYIFKrSRPG4cRA0W7X2O6TRG7VruxnExapfuewtt4URtiihXiAhaEzD6Axp/Nf8Az/g82k+VoMu9avnWoEoYW2z1zubu58zYjIxJGcy826ZlXleQAkBDAm3Jt+XuefnNxp0dU2Q2kLkQFFoq7mS0XFkoqfpSJ3eBnk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876547; c=relaxed/simple;
	bh=vdAKlYOM3etBiXRue4uJvjZIi/kLJzu/QfNFqhk9ZBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+TiyoxxuCiFhmYP/t+Mtd+qwiH4ZcNzZMOTESQ/PfIvBEEwMeS15AIPC49fYHiv7b5jGDd9AoJwlrarzC0oMZ1nc4KzehRTqHYG3JjvdQBS8wXF/AgJju7oaGBG/IJCMkY+AHzrMt6FQTjD6o26rJASz7PuLOe6FoXsxfv/Wxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vs0gnrsn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vs0gnrsn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727876544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vdAKlYOM3etBiXRue4uJvjZIi/kLJzu/QfNFqhk9ZBQ=;
	b=Vs0gnrsnsv5Nm4h3D8K6lz4TEnmVpjnjovegtfj9e9kVwV4f7UZ7cUIyTHKpeSa2ZAq1zS
	rWSu80ABlUbCmDI2o2TPQNbqDeWqlabfJkxonzfPopqFOaE7C/g8CUl50jdPAi9DRVIZLq
	of+SiVevnLHTKXC0IZ/wU3tSpKHVe9M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-338-2d7h7rZBMfSDFeQxRVUrYQ-1; Wed,
 02 Oct 2024 09:42:22 -0400
X-MC-Unique: 2d7h7rZBMfSDFeQxRVUrYQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 545621955F3C;
	Wed,  2 Oct 2024 13:42:20 +0000 (UTC)
Received: from localhost (unknown [10.2.16.122])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 417931956088;
	Wed,  2 Oct 2024 13:42:19 +0000 (UTC)
Date: Wed, 2 Oct 2024 09:42:17 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel Verkamp <dverkamp@chromium.org>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, mst@redhat.com,
	virtualization@lists.linux-foundation.org,
	virtio-dev@lists.linux.dev, oren@nvidia.com, parav@nvidia.com
Subject: Re: [PATCH 1/1] virtio-blk: Add description for blk_size field
Message-ID: <20241002134217.GA1362405@fedora.redhat.com>
References: <20240925145228.27953-1-mgurtovoy@nvidia.com>
 <CABVzXAntBt+5L4a1ntud_7j_EHiB4yG6FuskNaPBirOfLJ7i6w@mail.gmail.com>
 <ca954af2-4c61-41f5-8cf0-69a1233704ba@nvidia.com>
 <CABVzXAma4T+=meTSRNKhq70w4imc=A5imy2zofX2ndJz-XVByg@mail.gmail.com>
 <adf195c4-6d7e-47ff-ac62-dc4c0f463f21@nvidia.com>
 <CABVzXA=wov8OgADXbDiVVnhncc=zgET4MAGd3H1pr26XS38JBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="/GfPDIWRVRf+fPhY"
Content-Disposition: inline
In-Reply-To: <CABVzXA=wov8OgADXbDiVVnhncc=zgET4MAGd3H1pr26XS38JBw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15


--/GfPDIWRVRf+fPhY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 06:45:23PM -0700, Daniel Verkamp wrote:
> From my point of view, it would be fine to clarify a few things:
> - blk_size should (not must) be the logical block size of the
> underlying storage device
> - data should (not must) be a multiple of blk_size for best performance
>=20
> And maybe:
> - devices may choose to return IOERR if a driver submits an I/O
> request that does not conform to the above recommendations (but this
> conflicts with the "performance"-related wording that exists now)

QEMU's virtio-blk implementation returns IOERR when the driver submits
VIRTIO_BLK_T_IN/VIRTIO_BLK_T_OUT requests that are not aligned to the
logical block size:
https://gitlab.com/qemu-project/qemu/-/blob/master/hw/block/virtio-blk.c#L3=
67

Although I interpret the virtio-blk spec in the same way as you
(blk_size is just a hint for optimal performance), I guess in practice
drivers align requests to blk_size.

Adding a note that devices may return IOERR is worthwhile. It will tell
driver authors not to expect device implementations to accept misaligned
requests.

Stefan

--/GfPDIWRVRf+fPhY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmb9TbkACgkQnKSrs4Gr
c8hVXwf/XRz+4IQYbND7w3zKaqA2UAKcd0tOkCNArVI/HjDh9w2iwGRJbpJYyfU7
5uU4pebhzlOU4jXQ1lpeYUgC5cCOa6bqb7SgGkJi1eDlgCNP1nTfSdo+6t9GfNe9
yo7Ue+E/2GsyyPDRJOheDuZ9J4CuZke3nSegR9+HwoVYYrPcbN4OaW53KwAtA45v
epkUJwfkKgqvPtwH98Y3bz9ZH/6t/AnC86OMrmUcMYnIFQAGO3kkY56uUWpdy7AL
bDFt3TjGf4D9EqtNPPZ2upoU0OBg0sxrmV6Fx0LUhUbZVgSA31U2DnQ+Ns32FT6h
x/kJlNxseGdYlOs4RuG5cKqACAQ5UA==
=wAnB
-----END PGP SIGNATURE-----

--/GfPDIWRVRf+fPhY--

