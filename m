Return-Path: <virtio-dev-return-13522-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A459C001DB
	for <virtio-dev@archiver.kernel.org>; Mon, 14 Aug 2023 16:28:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D30FF157EF3
	for <virtio-dev@archiver.kernel.org>; Mon, 14 Aug 2023 16:28:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B931F986659
	for <virtio-dev@archiver.kernel.org>; Mon, 14 Aug 2023 16:28:49 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id AA844986423; Mon, 14 Aug 2023 16:28:49 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 69614986660
	for <virtio-dev@lists.oasis-open.org>; Mon, 14 Aug 2023 16:28:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: V-ZgLa50OEei6NhDbud1XQ-1
Date: Mon, 14 Aug 2023 11:18:20 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, mst@redhat.com, eperezma@redhat.com,
	cohuck@redhat.com, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org
Message-ID: <20230814151820.GH3146793@fedora>
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
 <20230814192904.30062-6-lingshan.zhu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4MQh3bjgVVTmxlSH"
Content-Disposition: inline
In-Reply-To: <20230814192904.30062-6-lingshan.zhu@intel.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Subject: Re: [virtio-dev] [RFC PATCH 5/5] virtio-pci: implement
 VIRTIO_F_QUEUE_STATE

--4MQh3bjgVVTmxlSH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 15, 2023 at 03:29:04AM +0800, Zhu Lingshan wrote:
> This patch adds two new le16 fields to common configruation structure
> to support VIRTIO_F_QUEUE_STATE in PCI tranport layer.
>=20
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> ---
>  transport-pci.tex | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>=20
> diff --git a/transport-pci.tex b/transport-pci.tex
> index a5c6719..d9bccb0 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -321,6 +321,8 @@ \subsubsection{Common configuration structure layout}=
\label{sec:Virtio Transport
>          le64 queue_device;              /* read-write */
>          le16 queue_notif_config_data;   /* read-only for driver */
>          le16 queue_reset;               /* read-write */
> +        le16 queue_avail_state;         /* read-write */
> +        le16 queue_used_state;          /* read-write */
> =20
>          /* About the administration virtqueue. */
>          le16 admin_queue_index;         /* read-only for driver */

This is an incompatible change to the register layout. Please add new
registers at the end of struct virtio_pci_common_cfg so field offsets
don't change for existing drivers and devices.

> @@ -415,6 +417,16 @@ \subsubsection{Common configuration structure layout=
}\label{sec:Virtio Transport
>          This field exists only if VIRTIO_F_RING_RESET has been
>          negotiated. (see \ref{sec:Basic Facilities of a Virtio Device / =
Virtqueues / Virtqueue Reset}).
> =20
> +\item[\field{queue_avail_state}]
> +        This field is vaild only if VIRTIO_F_QUEUE_STATE has been

"valid"

> +        negotiated. The driver sets and gets the available state of
> +        the virtqueue here (see \ref{sec:Virtqueues / Virtqueue State}).
> +
> +\item[\field{queue_used_state}]
> +        This field is vaild only if VIRTIO_F_QUEUE_STATE has been

"valid"

> +        negotiated. The driver sets and gets the used state of the
> +        virtqueue here (see \ref{sec:Virtqueues / Virtqueue State}).
> +
>  \item[\field{admin_queue_index}]
>          The device uses this to report the index of the first administra=
tion virtqueue.
>          This field is valid only if VIRTIO_F_ADMIN_VQ has been negotiate=
d.
> @@ -488,6 +500,9 @@ \subsubsection{Common configuration structure layout}=
\label{sec:Virtio Transport
>  present either a value of 0 or a power of 2 in
>  \field{queue_size}.
> =20
> +If VIRTIO_F_QUEUE_STATE has not been negotiated, the device MUST ignore
> +any accesses against \field{queue_avail_state} and \field{queue_used_sta=
te}.

"accesses to"

> +
>  If VIRTIO_F_ADMIN_VQ has been negotiated, the value
>  \field{admin_queue_index} MUST be equal to, or bigger than
>  \field{num_queues}; also, \field{admin_queue_num} MUST be
> --=20
> 2.35.3
>=20
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>=20

--4MQh3bjgVVTmxlSH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmTaRbwACgkQnKSrs4Gr
c8hs/wf/W4pKLue0gsz947V6M3XGgnLFmEjEhPNUQNvD1PWGCcYRSMKJkKj4baQL
L8fSn/6E7weH4xxmS/iJjmLo8LoyEIkE8LocrY/urVssoVI3v5UriwLf7jOaggRN
vBD1V5yd+iwLgnLNn2XJe6bBHeCKRIhTwbnOil14J+jT21F/bF9XC5ZL5sgVsvht
g4BYuUsPS0ErOD3NnCxeo2f/Nh/iPlcui4yPfSsMb9+ORa9d8VD/nQ01r1/qnE+i
lI56ST91abRO0P/mcznx9Ywlw6cxHkRrlPvm4Kc51u+JMS51x1E8oQgqT4Ky2L59
4jRgro5OuyYck/Ebin6P/mTjMSV/iw==
=xZMf
-----END PGP SIGNATURE-----

--4MQh3bjgVVTmxlSH--

