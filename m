Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8695213EFC
	for <virtio-dev@lists.linux.dev>; Tue,  8 Oct 2024 20:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728418189; cv=none; b=F1ekm0umg+qFZGkRu4fJ8zcSnohBHVC9UuP0w2MMEcNbTZmNqjowFVFclffZubaInt6ughcuSOrXozqOXZcuF8+NE1O7X+Oftr/pLQNLK9DHToZQY/KeLTaXc8kNMNspPJuoW7B/oLf4Th+KVT5dAwiStYg3zQAIRQ17rxim+n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728418189; c=relaxed/simple;
	bh=/Eo5GR3F2EuVxfpd26kcMlFXxmpNRe5glMFWaKdfHgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KI8O/PabNSpgGipGv82tmV+Vb4uevxyyYklfL2bxwEiYhFcAmYwTUxgPHX1JpFRS7+Az4MnEPkoZwOMxmeDw/DrxNc+tQQddFuJy47emBiWNYlHlHSb2EOpRzuhtl1yRK0mnquMxk+YJAlrZmdDXiuI1VSD50gbPmt9HYit2j4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aJSASDvH; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJSASDvH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728418186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/Eo5GR3F2EuVxfpd26kcMlFXxmpNRe5glMFWaKdfHgU=;
	b=aJSASDvHbbk9EioX8Wdpc9AZRrvw7kc2h7ZNg7klmC2pTYeKNtNYzC1hU/rErkf56kkPaW
	ijsthbsoyWcOboY4KhOf6GbmE3xIOHc5fEG54f9wsBYGVQDelna0vtZBhIKItJd9DWTyj2
	pJfZUjraCMMPxxq6TInyWZxE/FSocBA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-219-QKPEucZ-MVazibRosLH3Fg-1; Tue,
 08 Oct 2024 16:09:43 -0400
X-MC-Unique: QKPEucZ-MVazibRosLH3Fg-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 15EC61956088;
	Tue,  8 Oct 2024 20:09:42 +0000 (UTC)
Received: from localhost (unknown [10.2.17.11])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1C7341956088;
	Tue,  8 Oct 2024 20:09:40 +0000 (UTC)
Date: Tue, 8 Oct 2024 16:09:34 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel Verkamp <dverkamp@chromium.org>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, mst@redhat.com,
	virtualization@lists.linux-foundation.org,
	virtio-dev@lists.linux.dev, oren@nvidia.com, parav@nvidia.com
Subject: Re: [PATCH 1/1] virtio-blk: Add description for blk_size field
Message-ID: <20241008200934.GA22682@fedora.redhat.com>
References: <20240925145228.27953-1-mgurtovoy@nvidia.com>
 <CABVzXAntBt+5L4a1ntud_7j_EHiB4yG6FuskNaPBirOfLJ7i6w@mail.gmail.com>
 <ca954af2-4c61-41f5-8cf0-69a1233704ba@nvidia.com>
 <CABVzXAma4T+=meTSRNKhq70w4imc=A5imy2zofX2ndJz-XVByg@mail.gmail.com>
 <adf195c4-6d7e-47ff-ac62-dc4c0f463f21@nvidia.com>
 <CABVzXA=wov8OgADXbDiVVnhncc=zgET4MAGd3H1pr26XS38JBw@mail.gmail.com>
 <CABVzXAmxuVngKjNvc9AsnkuNcOK+7JeEuBE9CDaMxAA=b3f=fw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="M2LY8j4i0WTGHdhM"
Content-Disposition: inline
In-Reply-To: <CABVzXAmxuVngKjNvc9AsnkuNcOK+7JeEuBE9CDaMxAA=b3f=fw@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15


--M2LY8j4i0WTGHdhM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 02, 2024 at 04:56:10PM -0700, Daniel Verkamp wrote:
> (Perhaps u-boot's driver does not work with the QEMU's virtio-blk
> device with certain storage configurations, per Stefan's note, but
> that is again just one device implementation.)

Yes, IOERR only happens under certain conditions: when --device
virtio-blk-pci,logical_block_size=<size> is configured. When that's not
the case, QEMU buffers as necessary to adjust for guest block size vs
host block size differences without errors.

Stefan

--M2LY8j4i0WTGHdhM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmcFkX4ACgkQnKSrs4Gr
c8g8Nwf+NxswDd6552kXJThCUN341HElsAmWxGplhSgPyYC52apw3sMVP2t/ML5L
QKSi+eJt91MGD/yJjDgD6uA/YFgN4sLEoEP2FqAKD+PFQzkPr23UWQl4hkhUwPxD
azluLJqTxLcbLBxR+/wibfFPkRo+c5TzKtsbDAk5fpbmc4/FMB0c/nWUXVuge7Oz
lumhBipb+ia4p76sOZEQuU5GBYgsLEbwaTUjMd3Rvzh3CrY6Bk7S6GOVpgmsKQ3N
znKsBK0ico0Nf7aMp/olbJtZ4aIoqjA4pFemaYeqriMnnp5Qpe2Q0St/hoRSi2J0
WrK8gIJ5WwiyTWDZMAC/v4jjvSG4Zw==
=WbGt
-----END PGP SIGNATURE-----

--M2LY8j4i0WTGHdhM--

