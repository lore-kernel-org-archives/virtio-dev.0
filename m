Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4D73749E8
	for <virtio-dev@lists.linux.dev>; Mon, 21 Sep 2026 13:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789997862; cv=none; b=DIaUpGbP0sTTOZ8tXrw9gXECtnHT7A33UI5OxjjG375xBRemYBd/J6ZzkO8Sc/tuQGM1Id5XmER6jStkZqi0BNw2fOE+o+wJbFIE+KSxbZuO3RJFp5kNS1GcUymlImnjyejiUXZ+nAfOYe/Fow1qApvtPqhwiFaRh+NzqceOGa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789997862; c=relaxed/simple;
	bh=0YXMl/WYLha5XK1VuNuGe0bzltbRtk0j3j6Qmfhp9Xk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZZ8KlT3dQB9USVRkaIr+qae+UcxjPo95Befftd96YgYzg1DVJghF/30z9okvJXtl1N4B5c+kEa11rMvZq7mtpzqc67zqYzH2Xxg5JHMs+s5y0M6Yzej3hpzc+vpjTUEVPVnCqZywmDaElXmC+In5iKzkLflx58F6FGbjEsvjj2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FH1devwk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FH1devwk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789997860;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MARajJ/lr8UJOmoGfwR6eqPIORg/tP23NB115WnsQmU=;
	b=FH1devwk7nmnPJgpK7/XXqn4cAyKYqECJS+xdrUeKA9H91FUEE2e+I7wQkDl6iv18lXOod
	qbP/XU2vO8tdKuEPQj8znxNdst7HtYvxi53qpSzTsNDD+wz79cchmhWowBjVulurn8DT2N
	sQ/Pf2BkkPzzuR6mudsyc4VY9mPu+tI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-yRDSRJs2OFetQzEIPFvUdQ-1; Mon,
 21 Sep 2026 09:37:35 -0400
X-MC-Unique: yRDSRJs2OFetQzEIPFvUdQ-1
X-Mimecast-MFC-AGG-ID: yRDSRJs2OFetQzEIPFvUdQ_1789997854
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 215B61829E0E;
	Mon, 21 Sep 2026 13:37:34 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C335F1956041;
	Mon, 21 Sep 2026 13:37:33 +0000 (UTC)
Date: Thu, 17 Sep 2026 17:08:41 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
Cc: virtio-dev@lists.linux.dev, ebiggers@kernel.org,
	neeraj.soni@oss.qualcomm.com
Subject: Re: [PATCH v3 0/2] virtio-blk: Add inline encryption support
Message-ID: <20260917210841.GD331587@fedora>
References: <20260913161628.368484-1-linlin.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nmVHTvgKMAB8CVCH"
Content-Disposition: inline
In-Reply-To: <20260913161628.368484-1-linlin.zhang@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

--nmVHTvgKMAB8CVCH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 09:16:13AM -0700, Linlin Zhang wrote:
> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>=20
> This series adds virtio-blk inline encryption support for devices backed
> by storage hardware with an inline crypto engine.
>=20
> The protocol exposes device capabilities such as keyslot count, maximum
> DUN size, and supported key types. Encrypted requests identify a
> provisioned keyslot and carry a 256-bit DUN. Key management and crypto
> capability discovery use the block device control virtqueue.
>=20
> The control virtqueue is defined as a generic framework so that its
> buffer layout and queue placement are independent of any particular
> control command. Inline encryption then builds on this framework with
> explicit crypto command formats, capability validation, and keyslot
> state semantics.
>=20
> All key related operatios are handled in the control virtqueue, and
> the crypto I/O request is handled in the request queue.
>=20
> For background on inline encryption in UFS and eMMC storage, see:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/block/inline-encryption.rst
>=20
> changes in v3:
>  - Add a control virtqueue
>  - Move key program/evict/derive_sw_secret/generate/prepare/import to
>    the control virtqueue

Thank you. This was a big change, especially if you already have an
implementation. I appreciate it!

My main feedback is that the new control virtqueue commands are not yet
documented in enough detail so that implementors could implement them.
Once you've decided on the precise semantics, error codes, etc and added
them to the spec, then this will round off the inline encryption
feature. I look forward to reviewing that in the future.

Stefan

--nmVHTvgKMAB8CVCH
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqsVtkACgkQnKSrs4Gr
c8j0DAgAunhMnUhHHUk8OAbdUKGKiBQMFjDDgRT05yAIlnHxtfaO8CjhLrJdq63W
KZXGUeuGV5xO4HAxub/GY+GnQ7yWX8Zv7KDKRedU4SGpjHYpD6nJn7GW78b31gyf
NubsozuOieC0+ASHGfNFWAcnZNo98AaB56mmuvF1Kft9wFZMzDMZV4/avum2hsI3
HRx+b14snUWsarwBVBYUiSBFD5diZQpaQMjxZWC3rpsFQgYPV7vvlB2vD5y549PI
/DggtwSC3zulfCL4tDc+s08KEASpVgPoTahRYqiPRIQZvdjw474Q3Z+GWB7y47Jf
MoLCb55cb6+R4Cpq86vufROnkrpQdw==
=aE2I
-----END PGP SIGNATURE-----

--nmVHTvgKMAB8CVCH--

