Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ED419ABB4
	for <virtio-dev@lists.linux.dev>; Wed,  9 Oct 2024 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728486640; cv=none; b=mYFIgcuNx1PCxg4wtJBCrqdHBeYalIyffENgHzbCanz1x2u1A1F0tlffv7wYLJ7K0j40lu73nHdMceO0Cz2HbN2or1obbcezUinbtY3y9K4GCRamKr4FChWCAYrvr6ivLpZ+Ej1mi+2BqbjaEmU1UlSg+yKawgS36XktsGtgsQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728486640; c=relaxed/simple;
	bh=wWb76VitBSStfqv1z9LLk+iqqyYHXd2+1MYeZq9n/Fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nWGwrBUOghQ6buVsr39twNMBkSLOLZruePHfL56PUvqAtd71tZrUb2dsCRpDMAldRzQIH4u9Io8vhyiGtrp0Y1yjHsTD2Ew8GoXFxMRiL6Wq7kq05udckQZHFupEgNyWfhqAirApTGkwq1c51VBLb9g/RT0aH+Bo7M2qliJ46Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gU9kxWCm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gU9kxWCm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728486638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9m/alfM29a3UUcEhOir6FOHIK40dS3QONXOJymAw7CU=;
	b=gU9kxWCmFuo3cruC48CrBDzL4iAvK0Cwcfgprn4UeFCdxflHJjzuXLte4HyBNf/YBtUSOK
	D2n2amrVB1ECktlpofhG81xTb7DYWkpKz5lqDQnHje6yOzrz5G2CoUOTKHqglsuOQ8/y70
	EWR9JO6FW/gWJIuY2N1Iko2T13hRuqQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-622-w3kpA6exOhmd_Phw6w4sbQ-1; Wed,
 09 Oct 2024 11:10:34 -0400
X-MC-Unique: w3kpA6exOhmd_Phw6w4sbQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4044319560BF;
	Wed,  9 Oct 2024 15:10:32 +0000 (UTC)
Received: from localhost (unknown [10.2.16.253])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 64D7819560A2;
	Wed,  9 Oct 2024 15:10:31 +0000 (UTC)
Date: Wed, 9 Oct 2024 11:10:24 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: dverkamp@chromium.org, mst@redhat.com,
	virtualization@lists.linux-foundation.org,
	virtio-dev@lists.linux.dev, oren@nvidia.com, parav@nvidia.com
Subject: Re: [PATCH v2 1/1] virtio-blk: Add description for blk_size field
Message-ID: <20241009151024.GB45445@fedora.redhat.com>
References: <20241006165609.34953-1-mgurtovoy@nvidia.com>
 <20241008201502.GB22682@fedora.redhat.com>
 <1389ad0b-89b0-4e50-b07d-02bd6141fc7d@nvidia.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vDnmv+mMksfPPYWs"
Content-Disposition: inline
In-Reply-To: <1389ad0b-89b0-4e50-b07d-02bd6141fc7d@nvidia.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12


--vDnmv+mMksfPPYWs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 09, 2024 at 01:46:17AM +0300, Max Gurtovoy wrote:
>=20
> On 08/10/2024 23:15, Stefan Hajnoczi wrote:
> > On Sun, Oct 06, 2024 at 07:56:09PM +0300, Max Gurtovoy wrote:
> > > This field is only valid when the VIRTIO_BLK_F_BLK_SIZE feature bit is
> > > offered by the device.
> > >=20
> > > The blk_size field actually represents the logical block size of the
> > > device. It is always a power of two and typically ranges from 512 byt=
es
> > > to larger values such as 4 KB.
> > >=20
> > > Add description for this field to provide clarity on its constraints.
> > >=20
> > > Signed-off-by: Max Gurtovoy<mgurtovoy@nvidia.com>
> > > ---
> > >=20
> > > changes from V1:
> > >   - Addressed Stefan's and Daniel's comments:
> > >         1. use SHOULD instead of MUST
> > >         2. Add a note that devices may return IOERR upon misaligned IO
> > >   - Add a note that devices may return IOERR if IO size is not follow=
ing
> > >     the block size granularity.
> > > ---
> > >   device-types/blk/description.tex | 34 +++++++++++++++++++++++++++++=
+++
> > >   1 file changed, 34 insertions(+)
> > Reviewed-by: Stefan Hajnoczi<stefanha@redhat.com>
>=20
> I'll add both yours and Daniel's Reviewed-by signatures and fix a small
> comment from Daniel.
>=20
> Can you please remind me the next step I should do ?
>=20
> Should I open an issue at the oasis github and mention it as "Fixes: " in
> the commit message ?

The GitHub repo is here:
https://github.com/oasis-tcs/virtio-spec

The instructions for requesting a vote on a spec patch are:

  To request a TC vote on resolving a specific comment:

  1. Create a github issue, or edit an existing issue, with a short summary=
 of the comment. The issue MUST specify the link to the latest proposal in =
the TC mailing list archives. Note: the link MUST be in the issue descripti=
on itself - not in the comments.
  2. Reply by email to the comment email, requesting that the TC vote on re=
solving the issue. The mail requesting the vote should include the followin=
g, on a line by itself:

    Fixes: https://github.com/oasis-tcs/virtio-spec/issues/NNN
    (NNN is the issue number)
  3. Please make sure to allow time for review between posting a comment an=
d asking for a vote.

Thanks,
Stefan

--vDnmv+mMksfPPYWs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmcGnOAACgkQnKSrs4Gr
c8gU8AgAjFIH6XzL/B9NQvcoUTRC73DB4sC89GA4oNVmv8t/G2nNNChX6Q6zfIpV
tqUmVOOedXmgnRm6Ni4lotxZH8Rz7pzAGfMuc0/YxQHbRzvm/yrAOMp7EJJSnbJB
BqkNR221dJbggHprzlbiVYIprMjtYChMXRNv8+1S70zUJ2Q8eO54K+Ohqhz2cI76
s79EBZOTdpa9vYGnyRBmlmlVRC1MoSTWMLS4/Ztz6rTcc8zGT5LbfKwtB/36Ps+H
AlOCChxjRuQBtmvDWdKnt3ut5GQJPBFALnEPPA/5UqW/z2vvLCHL2+qx9hfB2eVW
PzocjzeQmkajgq+N22E77woNBgqHAw==
=F0Qh
-----END PGP SIGNATURE-----

--vDnmv+mMksfPPYWs--

