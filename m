Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5636949F132
	for <virtio-dev@lists.linux.dev>; Mon, 21 Sep 2026 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789997862; cv=none; b=uAt1jBf5trK2Z55F0scstIQAK9Idayr6TUBidCOHtkXBppKHFIAce9whszsrwQB9PnFueSnIxOuiQKJcF/PiIIRihJrKafv1YGUjUFQ3HYDsHeB09DUuPmhwIaZiW6a7oKiDccYEjCcZzZbK/V9e+Eq92+7fJ7AiVXyBZIF42K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789997862; c=relaxed/simple;
	bh=JJvuXgsyWQnhE6/D4hcD09fe2iRYYA1iafR64razHP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yo4pI/RU38QDfP7d+HfGDwF2kc0atoQcuWKHmBB8N1uziZOsbVz2EfT4ZXgU32DyS939C0NGDD0+69+mkL9vLutlm4yAhTHCtgQ3FfNQyLom2/RyjGI5OYdQa3rww4DqZcdtHRTJSFTKcivf0ERrdAvI9hVC6GWmMyn8Jif1kEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=doqOKmEL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="doqOKmEL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789997858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fWvnhYdxS4vABJWdrqOvm4tQmhNKFJYQ5ZGmgK/uzJA=;
	b=doqOKmELybqk4PMR1YzYuirnxhv2MwO0rLQe9E5V9jXdrWuVbGBW81e/u+IPNOqSt3h+Qf
	g6n1bNghoucTWsTWU4zVitkUgITiEMYKrOeYLrQ+LXloRVZGF/k71KRrnvTAYBkOt8P+XR
	WFsZUsPhCbpu+eDzINUSTr/KP/gi0yU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-BckJjA_TOcCHBfGZfuNBZw-1; Mon,
 21 Sep 2026 09:37:32 -0400
X-MC-Unique: BckJjA_TOcCHBfGZfuNBZw-1
X-Mimecast-MFC-AGG-ID: BckJjA_TOcCHBfGZfuNBZw_1789997851
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D01CA19540EC;
	Mon, 21 Sep 2026 13:37:30 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 66EC11800577;
	Mon, 21 Sep 2026 13:37:30 +0000 (UTC)
Date: Thu, 17 Sep 2026 16:16:47 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Linlin Zhang <linlin.zhang@oss.qualcomm.com>
Cc: virtio-dev@lists.linux.dev, ebiggers@kernel.org,
	neeraj.soni@oss.qualcomm.com
Subject: Re: [PATCH v3 1/2] virtio-blk: Add the control virtqueue
Message-ID: <20260917201647.GB331587@fedora>
References: <20260913161628.368484-1-linlin.zhang@oss.qualcomm.com>
 <20260913161628.368484-2-linlin.zhang@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DTqIocp5ru1PttRG"
Content-Disposition: inline
In-Reply-To: <20260913161628.368484-2-linlin.zhang@oss.qualcomm.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

--DTqIocp5ru1PttRG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 09:16:14AM -0700, Linlin Zhang wrote:
> From: linlzhan <linlin.zhang@oss.qualcomm.com>
>=20
> Add VIRTIO_BLK_F_CTRL_VQ to advertise control virtqueue support.
>=20
> Define the control virtqueue location, driver queue discovery,
> and common control request buffer layout. This provides a
> standard framework for block-device control commands.
>=20
> Signed-off-by: linlzhan <linlin.zhang@oss.qualcomm.com>
> ---
>  device-types/blk/description.tex | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/device-types/blk/description.tex b/device-types/blk/descript=
ion.tex
> index 3b3a4e7..9bfdc4a 100644
> --- a/device-types/blk/description.tex
> +++ b/device-types/blk/description.tex
> @@ -13,11 +13,16 @@ \subsection{Virtqueues}\label{sec:Device Types / Bloc=
k Device / Virtqueues}
>  \item[0] requestq1
>  \item[\ldots]
>  \item[N-1] requestqN
> +\item[N] controlq, if VIRTIO_BLK_F_CTRL_VQ is negotiated
>  \end{description}
> =20
>   N=3D1 if VIRTIO_BLK_F_MQ is not negotiated, otherwise N is set by
>   \field{num_queues}.
> =20
> +If VIRTIO_BLK_F_CTRL_VQ is negotiated, the control virtqueue is appended
> +after the request virtqueues. The control virtqueue is reserved for cont=
rol
> +requests defined by this specification.
> +
>  \subsection{Feature bits}\label{sec:Device Types / Block Device / Featur=
e bits}
> =20
>  \begin{description}
> @@ -73,6 +78,8 @@ \subsection{Feature bits}\label{sec:Device Types / Bloc=
k Device / Feature bits}
>      VIRTIO_BLK_REQ_FLAG_OUT_FUA flag in the \field{flags} bitfield of the
>      \field{virtio_blk_req} structure for VIRTIO_BLK_T_OUT requests.
> =20
> +\item[VIRTIO_BLK_F_CTRL_VQ (22)] Device supports a control virtqueue.
> +
>  \end{description}
> =20
>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / =
Block Device / Feature bits / Legacy Interface: Feature bits}
> @@ -274,6 +281,9 @@ \subsection{Device Initialization}\label{sec:Device T=
ypes / Block Device / Devic
>  \item If the VIRTIO_BLK_F_MQ feature is negotiated, \field{num_queues} f=
ield
>      can be read to determine the number of queues.
> =20
> +\item If the VIRTIO_BLK_F_CTRL_VQ feature is negotiated, the driver MUST
> +    identify the control virtqueue as queue N, after all request virtque=
ues.
> +
>  \item If the VIRTIO_BLK_F_SECURE_ERASE feature is negotiated,
>      \field{max_secure_erase_sectors} and \field{max_secure_erase_seg} ca=
n be read
>      to determine the maximum secure erase sectors and maximum number of
> @@ -327,6 +337,10 @@ \subsection{Device Initialization}\label{sec:Device =
Types / Block Device / Devic
>  The driver MUST NOT negotiate VIRTIO_BLK_F_REQ_FLAGS_OUT_FUA without
>  VIRTIO_BLK_F_REQ_FLAGS.
> =20
> +If the VIRTIO_BLK_F_CTRL_VQ feature is negotiated, the driver MUST NOT s=
ubmit
> +any request to the control virtqueue unless the request is defined by th=
is
> +specification.
> +
>  \devicenormative{\subsubsection}{Device Initialization}{Device Types / B=
lock Device / Device Initialization}
> =20
>  Devices SHOULD always offer VIRTIO_BLK_F_FLUSH, and MUST offer it
> @@ -454,6 +468,11 @@ \subsection{Device Operation}\label{sec:Device Types=
 / Block Device / Device Ope
>  };
>  \end{lstlisting}
> =20
> +Control virtqueue requests consist of a type field in an output buffer,

Please move this paragraph to a separate subsection dedicate the control
virtqueue (like virtio-net's 5.1.9.5 Control Virtqueue in VIRTIO 1.4,
https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.4.html#x1-2850009:=
~:text=3D5%2E1%2E9%2E5%20Control%20Virtqueue).

I recommend defining a separate struct virtio_blk_ctrl similar to
virtio-net's struct virtio_net_ctrl to illustrate the layout more
clearly than a paragraph of text could.

> +followed by an optional command-specific output buffer, an optional
> +command-specific input buffer, and a status byte in an input buffer. The
> +type field and status byte MUST each be in their own buffer.

Message framing is up to the driver and the device spec cannot dictate
specific framing:
https://docs.oasis-open.org/virtio/virtio/v1.4/virtio-v1.4.html#x1-390004

> +
>  The type of the request is either a read (VIRTIO_BLK_T_IN), a write
>  (VIRTIO_BLK_T_OUT), a discard (VIRTIO_BLK_T_DISCARD), a write zeroes
>  (VIRTIO_BLK_T_WRITE_ZEROES), a flush (VIRTIO_BLK_T_FLUSH), a get device =
ID
> --=20
> 2.34.1
>=20

--DTqIocp5ru1PttRG
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmqsSq8ACgkQnKSrs4Gr
c8hTfQf/cwNC801CHOlu4KYQx8Z+3Mi3rHFAKvkGsYdJ/M/2JgOfiHAlgAilDwsZ
wK00tNjbxh2IsmEnOitVQD2GQDjwR+VG88xYqVOjiLKbfboZuisWTrjdbnRe0HMU
EQMoYBKnAU9gQZHKYll5Bhiip+/9Jg4LsAdjjqTMRclooRnpuF4x+hP0WJI9R/IJ
bk+sQqh31zCDMqJBaUBltHEPkwy1Zeqwu7qibepZQVo3cCsAteJwtWkr/nFfNrbw
jz6JmVRfu4zGvJqEh9/n+/xUdtW5QnmpLacQOozh4KxMGzt8iOIWPDCBYOQpC/gO
kW+YrOh5mG47QU75Fc0+csHpv/FAIw==
=nqTu
-----END PGP SIGNATURE-----

--DTqIocp5ru1PttRG--

