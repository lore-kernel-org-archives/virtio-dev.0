Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91861E3769
	for <virtio-dev@lists.linux.dev>; Mon, 31 Mar 2025 12:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743423619; cv=none; b=m7vMMz8RmximQlctyaJA4j09OA54qw/EenhWwILsHoML8u+RkakU7tIA0tfxzK3izwLZ9lC34V/vS0ff/BO+xyIWcYUD7ufdo7qyBAOY9FxT8cu3gTwstbsgyZZ5tlJ05NEs/4/85l+T1IVKNdDt5lDG0x48zxqd6+PyWrvoIv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743423619; c=relaxed/simple;
	bh=Mcuo82e3bedOnkYCnMSto9KYztISX1z5XNXm5/fMziA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rqfmDENnbN8UFnfnjztu93HcfNgZ5XI5ar/PsQPow28e+gWOTmU4aHgSVeqC1eSUvNOOwS/Dugyqeq1Vd6Z8xUpVoCvOmSb+E2icbYojtr3XuHCXLaatRk1Df4X0Zan7vNva2cbBHR93pDkR/uABL4ByEfiLdUUOUTtjAtVp+A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TS5rsKj0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TS5rsKj0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743423615;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CRakDc7PqzvR6cPiRlYWPeF36XguxfG77r5itvmH1Js=;
	b=TS5rsKj0+geijYtxuYrel7F549LkQAMOT0Q9xIu8TF4qJjDqgZ+AluGhV7m/cKMS8dW1AL
	Z70Vo7xQ4Gu/RNSJdzAi3/nQAcN8urubXjlc1W23R3aacaERH+XOz+bXp7AcX5hJ43lpXk
	D11ihgmcjM27EsLBvFMRUuP835nAPxc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-RMo1IX2kPyq0ehHLdWCLJg-1; Mon,
 31 Mar 2025 08:20:13 -0400
X-MC-Unique: RMo1IX2kPyq0ehHLdWCLJg-1
X-Mimecast-MFC-AGG-ID: RMo1IX2kPyq0ehHLdWCLJg_1743423611
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DF6DA195608A;
	Mon, 31 Mar 2025 12:20:10 +0000 (UTC)
Received: from localhost (unknown [10.2.16.29])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DE5571956094;
	Mon, 31 Mar 2025 12:20:09 +0000 (UTC)
Date: Mon, 31 Mar 2025 08:20:08 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Rust VMM <rust-vmm@lists.opendev.org>,
	QEMU Devel <qemu-devel@nongnu.org>, virtio-comment@lists.linux.dev,
	VirtIO Dev List <virtio-dev@lists.linux.dev>,
	Bill Mills <bill.mills@linaro.org>,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Matias Vara Larsen <mvaralar@redhat.com>,
	Sergio Lopez <slp@redhat.com>
Subject: Re: Central repo for VirtIO conformance tests?
Message-ID: <20250331122008.GA190936@fedora>
References: <87semtpjrt.fsf@draig.linaro.org>
 <CAJSP0QXX-hpOJ_E1oaR6NcyvBnC2mVAwfd8NYUWTDqPrtctAuQ@mail.gmail.com>
 <Z-qHKUveoHc85koj@redhat.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1UzjfE4LHL1iuGco"
Content-Disposition: inline
In-Reply-To: <Z-qHKUveoHc85koj@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15


--1UzjfE4LHL1iuGco
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 01:14:33PM +0100, Daniel P. Berrang=C3=A9 wrote:
> On Mon, Mar 31, 2025 at 07:52:33AM -0400, Stefan Hajnoczi wrote:
> > On Mon, Mar 31, 2025 at 6:39=E2=80=AFAM Alex Benn=C3=A9e <alex.bennee@l=
inaro.org> wrote:
> > > So what do people think? Where would be a good place for common test
> > > repository to live?
> >=20
> > Maintaining the tests alongside the VIRTIO spec seems like a good fit
> > to me. Here is information on how to create a GitHub repo under the
> > OASIS VIRTIO Technical Committee:
> > https://www.oasis-open.org/open-repositories/
> >=20
> > I don't see a reason to maintain the tests under QEMU or rust-vmm
> > unless they provide some unique project infrastructure that an
> > independent project would lack or need to reinvent.
>=20
> IMHO opening that very link above illustrates the reason why *NOT* to
> host this under OASIS. Any potential contributor is faced with a 4 page
> long blurb of all sorts of rules & legal requirements, including
>=20
>   "Each TC Open Repository shall be subject to a Contributor
>    License Agreement (=E2=80=9CCLA=E2=80=9D) by which all persons making =
repo
>    contributions into it are bound."
>=20
> Hosting anywhere else would be better from the POV of removing barriers
> to potential contribution.

I didn't notice the CLA requirement. I agree, it's better to host it
elsewhere.

Stefan

--1UzjfE4LHL1iuGco
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmfqiHgACgkQnKSrs4Gr
c8imawgAupoyqxCLxGFaH4fb9FOtzqOvMBpqPWfWZ+2v3WsDyUGU2aVaWS01EwUp
nGP8qqrN7OO0ykPLqKPlLdNi5KT4reRDC00lZMU5dSmRUjiWpns8GzTvTsI2VLof
9vih/PdJ5NUPpSvpWfSHVJh6WGKeaqWb1lm03hDx/c4Ce9GUpTbGiGOqlkrDGcNK
YDe0f9qjGnpHAZB3aa2OPGWj6AAFrRuJn+DLFGsAsi8qJRdZk5ExEkys2s9QjL6y
l9V697MvY1v6qqUau5maQqUu0+tlIXRST2Y22xJRexwlguivjWDpuJEwGuMS6eBE
S84Y9haeM5aG78cmjMmBDLJCn01nWw==
=l7dj
-----END PGP SIGNATURE-----

--1UzjfE4LHL1iuGco--

