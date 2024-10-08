Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DD11E104B
	for <virtio-dev@lists.linux.dev>; Tue,  8 Oct 2024 20:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728418514; cv=none; b=dwuydSkYXKwDnT9roOWuOrGqIeFHsm6NsQ1L3LS+z8nX4CaBNB5CR+Qu0UWjcirNYAY6siN5veMeEnGufS8Te3/dJbep3XxqvTyk5EGU1+QfSOQZAWxQjd3Rouqzoq3VVc/qtwp4CehYPU4oQgXOmteToHBp6ELt+doUqapPiZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728418514; c=relaxed/simple;
	bh=n+CUlPNPx2z6+pnA6FdPeLT3nmurZQrgxNfdRVP7mXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPYXaVGDfYElNgkK47ApkkewSMRTy72YFhp8imbtaSA4+EQkc2yWZ95cfmeTNA3sX5BfRj/Pt2pJhIfRJLkq1yZSHqmcz5mfVctiBJgMx+WgGAEb3MBcz0d94RbPoAzTgK+WCyGFRmpGcQxEf+ZdCPFNewYUTF6LvrJYZ7FPzHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K0TsmXsz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K0TsmXsz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728418512;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=STkEiMy0KOLXDf5+bitrurF+JXm5oWzJODSZy5skj4g=;
	b=K0TsmXszY7jYEck9DHQ65eawJTD6X69pQPf+o0H6HCpRwZjnO+7IxAgSdcDKQJJ9D9o7V6
	lv6s5i/fsB7vZ9FokMQWQMEjwS5vdtbGF9kwKtkhPKFEU2Y9fBE1wkZ7NqE+YXPfWnoZn4
	M87gnnCmm+Uicsz6PsgydSY3mhbbQQM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-543-bI643tgBOqWmnp4Av3vxMw-1; Tue,
 08 Oct 2024 16:15:06 -0400
X-MC-Unique: bI643tgBOqWmnp4Av3vxMw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EBC10195608D;
	Tue,  8 Oct 2024 20:15:04 +0000 (UTC)
Received: from localhost (unknown [10.2.17.11])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4E64419560A2;
	Tue,  8 Oct 2024 20:15:04 +0000 (UTC)
Date: Tue, 8 Oct 2024 16:15:02 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: dverkamp@chromium.org, mst@redhat.com,
	virtualization@lists.linux-foundation.org,
	virtio-dev@lists.linux.dev, oren@nvidia.com, parav@nvidia.com
Subject: Re: [PATCH v2 1/1] virtio-blk: Add description for blk_size field
Message-ID: <20241008201502.GB22682@fedora.redhat.com>
References: <20241006165609.34953-1-mgurtovoy@nvidia.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PxkOAYrNr9r6RLXN"
Content-Disposition: inline
In-Reply-To: <20241006165609.34953-1-mgurtovoy@nvidia.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


--PxkOAYrNr9r6RLXN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 06, 2024 at 07:56:09PM +0300, Max Gurtovoy wrote:
> This field is only valid when the VIRTIO_BLK_F_BLK_SIZE feature bit is
> offered by the device.
>=20
> The blk_size field actually represents the logical block size of the
> device. It is always a power of two and typically ranges from 512 bytes
> to larger values such as 4 KB.
>=20
> Add description for this field to provide clarity on its constraints.
>=20
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> ---
>=20
> changes from V1:
>  - Addressed Stefan's and Daniel's comments:
>        1. use SHOULD instead of MUST
>        2. Add a note that devices may return IOERR upon misaligned IO
>  - Add a note that devices may return IOERR if IO size is not following
>    the block size granularity.
> ---
>  device-types/blk/description.tex | 34 ++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--PxkOAYrNr9r6RLXN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmcFksYACgkQnKSrs4Gr
c8ikhAgAit8y7aFS+7DibQvnVBTTrhgSWXcZg7fw43Sq25c4GEX4RW2aQfvacE3j
d/S9ikvH4vhev5r+mvUP1j5ZvQ5PLQr8AW+ZgCPLAHMW7+xAf0QJDhjtCZL49tqn
EqKfmzph5t5tHt3TEKWla5c8rbtk6r/lLLtvC0mp6HTw8EcNwdc3PFiMReujLNax
b5zxEvnaPy91BRFOadWOaxes0rsX7P46WrSUpQpQGcLn8NEpxXegDuPpYwJI5vKL
AQkK3RmdQMTvcMJaU8Xt/WGaBiH1qjraK2p3s1kD1Y3Fa8P0XYdkbUsRhMIgYvIF
SpwS7RNjZJyduIqZZY/AuLr1j72VcQ==
=bfln
-----END PGP SIGNATURE-----

--PxkOAYrNr9r6RLXN--

