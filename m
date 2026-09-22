Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C9E4F30C1
	for <virtio-dev@lists.linux.dev>; Tue, 22 Sep 2026 13:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790082889; cv=none; b=P1XEBOL0lcA8J/n0ic+J9nJpI8gAzk7hufxM0xiHRFTNa59zLdCWqzF2hE2tZWWcvA/mY8FXRKsW5rqfn0zOSN43CSAIgbqhshLMEP6eUtbsG+NsSsb3mslzm8pLDW252PUkzBN29kx670+1G120awqe7RTVHmZQECc6zDHEcdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790082889; c=relaxed/simple;
	bh=9IgM1eYnEqKwKIl+zdqLN16bxfAIZrMCwdGtbyQOUOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fEcNPafXzHYTus/UvEREvBw/JdkCE1t10FwqNfbeWICXK0XBDWFbFaSNoj8XqquUMCKNc+m++WHkVDVETL2vXOXGiTc3CLgEXdBsL2P1SgMnerSpW/ZhpTKmmWqDhu0/GLsUupZKmO7V4UbPphIzgiu0cGQHEvb2yBpmbDPU+eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zng3yBG+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zng3yBG+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790082887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2dEyCn5r6H1peiIvkfzjUX+HYs7SXwZbtAXam6b9Avc=;
	b=Zng3yBG+ukRrZibclnRwr4/Xd3aves7c1v9s5HRr7FLQ9sx2NU/CydIc/oHxRYudCojXVn
	YC+sM20GgiEuksMP4SKgXG5UdsvxYVpWiaCnvhyXA7mCuQEXcO0xghjE9KA/QZLFVQ39mn
	nUc0p3FIprkXSjhJs3CuOxAiVaKFw4w=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-128--dhqDe7_MGu8L6wctjduWQ-1; Tue,
 22 Sep 2026 09:14:45 -0400
X-MC-Unique: -dhqDe7_MGu8L6wctjduWQ-1
X-Mimecast-MFC-AGG-ID: -dhqDe7_MGu8L6wctjduWQ_1790082884
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0DDC31954AF3;
	Tue, 22 Sep 2026 13:14:44 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8CAB4195604F;
	Tue, 22 Sep 2026 13:14:43 +0000 (UTC)
Date: Tue, 22 Sep 2026 09:14:42 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
Cc: virtio-dev@lists.linux.dev, ebiggers@kernel.org,
	neeraj.soni@oss.qualcomm.com
Subject: Re: [PATCH v3 0/2] virtio-blk: Add inline encryption support
Message-ID: <20260922131442.GB18339@fedora>
References: <20260913161628.368484-1-linlin.zhang@oss.qualcomm.com>
 <20260917210841.GD331587@fedora>
 <2f9affb3-0d1b-4469-9a66-ba052d2d1b6a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bYw1C5cVYBx5NH1W"
Content-Disposition: inline
In-Reply-To: <2f9affb3-0d1b-4469-9a66-ba052d2d1b6a@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

--bYw1C5cVYBx5NH1W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 12:29:37PM +0800, Linlin Zhang wrote:
>=20
>=20
> On 9/18/2026 5:08 AM, Stefan Hajnoczi wrote:
> > On Sun, Sep 13, 2026 at 09:16:13AM -0700, Linlin Zhang wrote:
> >> From: linlzhan <linlin.zhang@oss.qualcomm.com>
> >>
> >> This series adds virtio-blk inline encryption support for devices back=
ed
> >> by storage hardware with an inline crypto engine.
> >>
> >> The protocol exposes device capabilities such as keyslot count, maximum
> >> DUN size, and supported key types. Encrypted requests identify a
> >> provisioned keyslot and carry a 256-bit DUN. Key management and crypto
> >> capability discovery use the block device control virtqueue.
> >>
> >> The control virtqueue is defined as a generic framework so that its
> >> buffer layout and queue placement are independent of any particular
> >> control command. Inline encryption then builds on this framework with
> >> explicit crypto command formats, capability validation, and keyslot
> >> state semantics.
> >>
> >> All key related operatios are handled in the control virtqueue, and
> >> the crypto I/O request is handled in the request queue.
> >>
> >> For background on inline encryption in UFS and eMMC storage, see:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tre=
e/Documentation/block/inline-encryption.rst
> >>
> >> changes in v3:
> >>  - Add a control virtqueue
> >>  - Move key program/evict/derive_sw_secret/generate/prepare/import to
> >>    the control virtqueue
> >=20
> > Thank you. This was a big change, especially if you already have an
> > implementation. I appreciate it!
> >=20
> > My main feedback is that the new control virtqueue commands are not yet
> > documented in enough detail so that implementors could implement them.
> > Once you've decided on the precise semantics, error codes, etc and added
> > them to the spec, then this will round off the inline encryption
> > feature. I look forward to reviewing that in the future.
> >=20
> Thanks a lot for your comment!
>=20
> Would you please help clarify what the precise semantics are about? detail
> introduction of the filed in the inline encryption control command struct?
> like struct virtio_blk_crypto_key_desc?

By precise semantics, I mean specifying not just the constants and
structs, but documenting what each command does and how it can fail.
Each of the key slot programming commands needs this. There should be at
least one paragraph for each of VIRTIO_BLK_T_CRYPTO_KEYSLOT_PROGRAM,
VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT, VIRTIO_BLK_T_CRYPTO_DERIVE_SW_SECRET,
VIRTIO_BLK_T_CRYPTO_GENERATE_KEY, VIRTIO_BLK_T_CRYPTO_IMPORT_KEY, or
VIRTIO_BLK_T_CRYPTO_PREPARE_KEY.

For example:

The VIRTIO_BLK_T_CRYPTO_KEYSLOT_EVICT command empties a key slot so that
key information is removed and the key slot cannot be used until it is
programmed again. The key slot index is specified by struct
virtio_blk_crypto_key_desc \field{slot} and all other fields in the
struct are ignored. The command succeeds with VIRTIO_BLK_S_OK if the key
slot index is valid, including if the slot is already empty. If the key
slot index is invalid, the command fails with VIRTIO_BLK_S_IOERR.

Stefan

--bYw1C5cVYBx5NH1W
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqyf0IACgkQnKSrs4Gr
c8gqcgf/Vbr3ITU65xbQKWYAttW5vY4cvXYZn+aQqEwJzLZSwdz29YRcY0ljmjOA
Q1u2moFQlRbJ4w2KpiSINL+Fajem1DQbFYrj2afEY6cOlhCYKm3ZiiDAdWElbjKQ
N3syDDcv8PDI/ieNFB2q5C7sfJqr6ffpSue2ICk2Y1wdBpg0MTy4/gBdoaVxuXy5
FXd2KyJyTYHTrIuQBGgJb0KetdyVHockaLMQtxZtyxgzBatU9djswwSl5fXdx9or
qhX0XSAVE6xR2mRaRYY7ey9/ugnN5mNNGqxoYDBTZNPxejyRrp6pQsyiRcTo3zLm
g5kbvVXopkoVzHuJyQQnqmKabt8ANw==
=xkIx
-----END PGP SIGNATURE-----

--bYw1C5cVYBx5NH1W--

