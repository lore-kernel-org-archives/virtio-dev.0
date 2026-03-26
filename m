Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC3034D4E2
	for <virtio-dev@lists.linux.dev>; Thu, 26 Mar 2026 19:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774553082; cv=none; b=npg68+yiwnSC1tC2m1u/LusUweql11Z3aiEt3jq4JSgE+/cLvclGQTgb8dV1ynsKyYIgFHfvxxpKvIx6hsm+pNIqp6rpK8uiEJuzovdcCvl9nfPpfqdDjh95Lcam5Ndg8mwpI2jNdvFz5R+tIDd7K02JdIrba17b/o17wi1u0A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774553082; c=relaxed/simple;
	bh=oOJ3eVGibN8OlT6PkIhU5GaopqoZ5LPghwkuFMRPoE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M2f1l2sAcBMKIMzu9reO2aVZiGZqbHO0+XmulRtd1JpYjbiMXzVMtPTWOD9/DAxjikIE3wBynP2LK1+6mAeg2NclD0N2Pb3XXVHQHZVZPeLWiEu4ZmbZWL1OKf4VZP9OmVIKFflL3xWiSz/iTeFHrUnM3bNSTFvKC1xLBgS34Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bc0nhGDG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bc0nhGDG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774553079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oOJ3eVGibN8OlT6PkIhU5GaopqoZ5LPghwkuFMRPoE4=;
	b=bc0nhGDG6z2iPclGNINliQFm02X509RA35P/VIfFzL7z8ZY6U06tN6byqHHREn2nuwqied
	NqEZga56TXKyuJAAWZsXmEB8kyKyomZx6fj2Db/nivEi3yAsxI8pWTe/2kv4sVG3xUmXjk
	P/xKBrvNmTjftfGh9T/yrz9CMHgoB8s=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-3T6YRX9MPB65T1kcxowbiQ-1; Thu,
 26 Mar 2026 15:24:35 -0400
X-MC-Unique: 3T6YRX9MPB65T1kcxowbiQ-1
X-Mimecast-MFC-AGG-ID: 3T6YRX9MPB65T1kcxowbiQ_1774553074
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DD4C1800344;
	Thu, 26 Mar 2026 19:24:34 +0000 (UTC)
Received: from localhost (unknown [10.45.224.109])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1A54B1800673;
	Thu, 26 Mar 2026 19:24:32 +0000 (UTC)
Date: Thu, 26 Mar 2026 15:24:30 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
Cc: Sebastian Mauritsson <sma@napatech.com>, virtio-dev@lists.linux.dev,
	quic_dshaikhu@quicinc.com
Subject: Re: [PATCH v2 1/1] virtio-blk: Add inline encryption support
Message-ID: <20260326192430.GE6926@fedora>
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
	protocol="application/pgp-signature"; boundary="+ErcjnBbtgUsnAxl"
Content-Disposition: inline
In-Reply-To: <112986be-3f22-45fe-ac68-6a2c172f629b@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93


--+ErcjnBbtgUsnAxl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 02, 2026 at 10:35:13PM +0800, Linlin Zhang wrote:
>=20
> Appreciate your review in detail. I attached the slide <FBE_virtualizatio=
n_proposal.pptx>. Please have a look and
> let me know if you have any concern. Thanks!

Sorry that I have been unresponsive. I've been swamped with work but
have scheduled time next week to look into this again.

Stefan

--+ErcjnBbtgUsnAxl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmnFh+4ACgkQnKSrs4Gr
c8icfgf/V7/l6AJ7S0cSCF+Td02GfKPcv94a8iEbngooWPzs7sLubewV4cLzpqwB
d9JfYQqE8OPxgXfqVVIPecjACRzbHlfpl2oWxBleGAes78WJnArMidKjKwc64wj1
B8e/Cb08LdLJVUOMlz8qlUBFCX214v9gsfRKugDeW9MJqpC5gMtiEsRQnJNYpkNT
byrz0qheUI3w9pjaN9ENS6V6olsOrq7ngAKRGsSrgMFN6fI8CkAHaIDK3DBPbD0E
2shMumivn15EFl9hfOi+NqdC+41JknQg0rx0MtEf5HVmvdupffn4n79vRozgoJqd
7b+OFfRPKGM5/qBsUkHOz+3AncKGNA==
=wMiA
-----END PGP SIGNATURE-----

--+ErcjnBbtgUsnAxl--

