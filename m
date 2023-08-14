Return-Path: <virtio-dev-return-13525-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C1EAC001DB
	for <virtio-dev@archiver.kernel.org>; Mon, 14 Aug 2023 16:29:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7F37845B4C
	for <virtio-dev@archiver.kernel.org>; Mon, 14 Aug 2023 16:28:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7297498634B
	for <virtio-dev@archiver.kernel.org>; Mon, 14 Aug 2023 16:28:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 649ED983F78; Mon, 14 Aug 2023 16:28:58 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3D6C698638A
	for <virtio-dev@lists.oasis-open.org>; Mon, 14 Aug 2023 16:28:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: NW-uW-0ePVarhffE-o1F1A-1
Date: Mon, 14 Aug 2023 11:15:10 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
	cohuck@redhat.com, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org
Message-ID: <20230814151510.GG3146793@fedora>
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
 <20230814192904.30062-5-lingshan.zhu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WLsu4S8TLnNtsKjf"
Content-Disposition: inline
In-Reply-To: <20230814192904.30062-5-lingshan.zhu@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Subject: Re: [virtio-dev] [RFC PATCH 4/5] virtqueue: constraints for
 virtqueue state

--WLsu4S8TLnNtsKjf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 03:29:03AM +0800, Zhu Lingshan wrote:
> This commit specifies the constraints of the virtqueue state,
> and the actions should be taken by the device when SUSPEND
> and DRIVER_OK is set
>=20
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  content.tex | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>=20
> diff --git a/content.tex b/content.tex
> index 43bd5de..f6ac581 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -587,6 +587,37 @@ \subsection{\field{Used State} Field}
> =20
>  See also \ref{sec:Packed Virtqueues / Driver and Device Ring Wrap Counte=
rs}.
> =20
> +\drivernormative{\subsection}{Virtqueue State}{Basic Facilities of a Vir=
tio Device / Virtqueue State}
> +
> +If VIRTIO_F_QUEUE_STATE has been negotiated, the driver MUST set SUSPEND=
 in \field{device status}
> +first before getting or setting Virtqueue State of any virtqueues.
> +
> +If VIRTIO_F_QUEUE_STATE has been negotiaged but VIRTIO_RING_F_PACKED not=
 been negotiated,

"negotiated"

Please run a spell checker.

> +the driver MUST NOT access \field{Used State} of any virtqueues, it shou=
ld use the
> +used index in the used ring.
> +
> +\devicenormative{\subsection}{Virtqueue State}{Basic Facilities of a Vir=
tio Device / Virtqueue State}
> +
> +If VIRTIO_F_QUEUE_STATE has been negotiated but SUSPEND is not set in \f=
ield{device status},
> +the device MUST ignore any accesses against Virtqueue State of any virtq=
ueues.

"accesses against" is not commonly used in English. "accesses to" is more n=
atural.

> +
> +When VIRTIO_F_QUEUE_STATE has been negotiated but VIRTIO_RING_F_PACKED i=
s not,
> +the device MUST ignore any accesses against \field{Used State}.

Same here.

> +
> +If VIRTIO_F_QUEUE_STATE has been negotiaged, the device MUST reset
> +the Virtqueue State of every virtqueue upon a reset.

I'm not sure if this statement is necessary since Virtqueue State
becomes inaccessible when the device is reset. By definition, Virtqueue
State is the device-internal state of the virtqueue, so it follows
logically that next time the driver can access the Virtqueue State after
reset, it contains the current state and not previous state from before
reset.

> +
> +If VIRTIO_F_QUEUE_STATE and VIRTIO_RING_F_PACKED have been negotiaged, w=
hen SUSPEND is set,
> +the device MUST record the Virtqueue State of every enabled virtqueue
> +in \field{Available State} and \field{Used State} respectively,
> +and correspondingly restore the Virtqueue State of every enabled virtque=
ue
> +from \field{Avaiable State} and \field{Used State} when DRIVER_OK is set.

"Available State"

> +
> +If VIRTIO_F_QUEUE_STATE has been negotiated but VIRTIO_RING_F_PACKED has=
 been not, when SUSPEND is set,
> +the device MUST record the available state of every enabled virtqueue in=
 \field{Available State},
> +and restore the available state of every enabled virtqueue from \field{A=
vaiable State}

"Available State"

> +when DRIVER_OK is set.
> +
>  \input{admin.tex}
> =20
>  \chapter{General Initialization And Device Operation}\label{sec:General =
Initialization And Device Operation}
> --=20
> 2.35.3
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>=20

--WLsu4S8TLnNtsKjf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTaRP4ACgkQnKSrs4Gr
c8jzEQgArmt5HSguzlaNVEIUBkIDH4opsmwYnXJ+sjGlLbG+s8mXF4G8K6bHiPMq
WroWc2S7H4rLam4fI/6XMNhURZD0n63y8v1xIfZsOiGx5SIUI1OgQAsfx0DHzre+
f4Gq0Vx9AJgdO9wCPHI8nhJ6OFwMOMta2dM4QMAj1N1YocnBDDHgql9QeAGeXQcI
y6gYAP4n/NvXyKTzCi7iMzzbQnFB+lYdPMjuhXZyt8eD02pASfEbYBfSOfPjxR2T
DZpcSM5M2ifSMNI+qOQT5e6PkDxECsqWgWjpmnQxMq/Gxt5XcpEITKm22cNrizGo
S4p4Aj8tng2PBz9Ag7O1/VB+OCi1QQ==
=SbOj
-----END PGP SIGNATURE-----

--WLsu4S8TLnNtsKjf--

