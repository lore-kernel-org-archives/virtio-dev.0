Return-Path: <virtio-dev-return-11394-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC672C6FA8E
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 20:52:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2771D330A3
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 20:52:03 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 10A849866D9
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 20:52:03 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 00BDA984091; Thu,  2 Mar 2023 20:52:03 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DD4FA9866AF
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 20:51:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: XxE7KvIiNHuRbRekPjhWHg-1
Date: Thu, 2 Mar 2023 15:51:48 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230302205148.GE2554028@fedora>
References: <cover.1677761896.git.mst@redhat.com>
 <33b3e85facaec6d92bff6a0f70afe0b084637591.1677761896.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1xmizuLpw0nNch+W"
Content-Disposition: inline
In-Reply-To: <33b3e85facaec6d92bff6a0f70afe0b084637591.1677761896.git.mst@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Subject: [virtio-dev] Re: [PATCH v10 05/10] pci: add admin vq registers to virtio over pci

--1xmizuLpw0nNch+W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 02, 2023 at 08:05:10AM -0500, Michael S. Tsirkin wrote:
> Add new registers to the PCI common configuration structure.
>=20
> These registers will be used for querying the indices of the admin
> virtqueues of the owner device. To configure, reset or enable the admin
> virtqueues, the driver should follow existing queue configuration/setup
> sequence.
>=20
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  content.tex | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>=20
> diff --git a/content.tex b/content.tex
> index c8647c9..1076125 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -946,6 +946,10 @@ \subsubsection{Common configuration structure layout=
}\label{sec:Virtio Transport
>          le64 queue_device;              /* read-write */
>          le16 queue_notify_data;         /* read-only for driver */
>          le16 queue_reset;               /* read-write */
> +
> +        /* About the administration virtqueue. */
> +        le16 admin_queue_index;         /* read-only for driver */
> +        le16 admin_queue_num;         /* read-only for driver */
>  };
>  \end{lstlisting}
> =20
> @@ -1031,6 +1035,20 @@ \subsubsection{Common configuration structure layo=
ut}\label{sec:Virtio Transport
>          This field exists only if VIRTIO_F_RING_RESET has been
>          negotiated. (see \ref{sec:Basic Facilities of a Virtio Device / =
Virtqueues / Virtqueue Reset}).
> =20
> +\item[\field{admin_queue_index}]
> +        The device uses this to report the index of the first administra=
tion virtqueue.
> +        This field is valid only if VIRTIO_F_ADMIN_VQ has been negotiate=
d.
> +\item[\field{admin_queue_num}]
> +	The device uses this to report the number of the
> +	supported administration virtqueues.
> +	This is a zero based value.  Virtqueues with index
> +	between \field{admin_queue_index} and (\field{admin_queue_index} +
> +	\field{admin_queue_num}) inclusive serve as administration
> +	virtqueues.
> +	Thus the number of administration virtqueues equals
> +	(\field{admin_queue_num} + 1).

Why is this value zero-based? virtio_pci_common_cfg's num_queues field
is le16 and not zero-based. It is not possible to have
admin_queue_index=3D0 admin_queue_num=3D0xffff because num_queues=3D0x10000
cannot be represented.

I suggest making this field behave the same as virtio_pci_common_cfg's
num_queues.

> +	This field is valid only if VIRTIO_F_ADMIN_VQ has been
> +	negotiated.
>  \end{description}
> =20
>  \devicenormative{\paragraph}{Common configuration structure layout}{Virt=
io Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common con=
figuration structure layout}
> @@ -1117,6 +1135,14 @@ \subsubsection{Common configuration structure layo=
ut}\label{sec:Virtio Transport
>  were used before the queue reset.
>  (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtque=
ue Reset}).
> =20
> +If VIRTIO_F_ADMIN_VQ has been negotiated, and if the driver
> +configures any administration virtqueues, the driver MUST
> +configure the administration virtqueues using the index
> +in the range \field{admin_queue_index} to
> +\field{admin_queue_index} + \field{admin_queue_num} inclusive.
> +The driver MAY configure less administration virtqueues than

s/less/fewer/

> +supported by the device.
> +
>  \subsubsection{Notification structure layout}\label{sec:Virtio Transport=
 Options / Virtio Over PCI Bus / PCI Device Layout / Notification capabilit=
y}
> =20
>  The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
> @@ -7684,6 +7710,15 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved=
 Feature Bits}
> =20
>    \item[VIRTIO_F_ADMIN_VQ(41)] This feature indicates that the device ex=
poses one or more
>    administration virtqueues.
> +  At the moment this feature is only supported for devices using
> +  \ref{sec:Virtio Transport Options / Virtio Over PCI
> +	  Bus}~\nameref{sec:Virtio Transport Options / Virtio Over PCI Bus}
> +	  as the transport and is reserved for future use for
> +	  devices using other transports (see
> +	  \ref{drivernormative:Basic Facilities of a Virtio Device / Feature Bi=
ts}
> +	and
> +	\ref{devicenormative:Basic Facilities of a Virtio Device / Feature Bits=
} for
> +	handling features reserved for future use.
> =20
>  \end{description}
> =20
> --=20
> MST
>=20

--1xmizuLpw0nNch+W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQBDGQACgkQnKSrs4Gr
c8gITAgAqIS7725USHyDcpDwQxLEzNWSQWhZxZpkq36kbo52edMvOSbIrggFV5J+
3gDjNNcH+KGfwDPdkgzOHT2udy8jCaLK1PImAs2wyn+JPkHffCRjFpcAsG6df6N2
k77Mj5y4coh8QIbHdu1dSg46+zkQalZbLWnCMC5MowbmFRcKOlY7J+q4AZytM1qM
4PjHwwnKM9Ay2wVaGOQvNhJYh+YrQ1sru4leL3C9gBm+NMkYm65BlIOFa2fsPPE8
iOf/oitpvK7+tk9VtG71SHhMhkinLfbzzC0EWKTqpP2kmSmYcS2SAcLx+qxfRwZ0
QOl4d3BsEOTc/AyKUdpSb2CILpwIyQ==
=y5aF
-----END PGP SIGNATURE-----

--1xmizuLpw0nNch+W--

