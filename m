Return-Path: <virtio-dev-return-11968-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A4BC761A6
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 12:52:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0562C26A26
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 12:52:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id F294898640C
	for <virtio-dev@archiver.kernel.org>; Tue,  4 Apr 2023 12:52:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id EA1AF9863E5; Tue,  4 Apr 2023 12:52:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D633B9863E6
	for <virtio-dev@lists.oasis-open.org>; Tue,  4 Apr 2023 12:52:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: MaUOXY-UNmSX-imyXotpQA-1
Date: Tue, 4 Apr 2023 08:52:28 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230404125228.GD428487@fedora>
References: <cover.1680533760.git.mst@redhat.com>
 <fbf6f659974884f7430ec7ef68028305d7acee0c.1680533760.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="CBrKcojyhf/mdaKh"
Content-Disposition: inline
In-Reply-To: <fbf6f659974884f7430ec7ef68028305d7acee0c.1680533760.git.mst@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Subject: [virtio-dev] Re: [PATCH v11 05/10] pci: add admin vq registers to virtio over pci

--CBrKcojyhf/mdaKh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 03, 2023 at 11:03:29AM -0400, Michael S. Tsirkin wrote:
> @@ -1033,6 +1037,19 @@ \subsubsection{Common configuration structure layo=
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
> +	Virtqueues with index
> +	between \field{admin_queue_index} and (\field{admin_queue_index} +
> +	\field{admin_queue_num} - 1) inclusive serve as administration
> +	virtqueues.
> +	The value 0 indicates no supported administration virtqueues.
> +	This field is valid only if VIRTIO_F_ADMIN_VQ has been
> +	negotiated.
>  \end{description}

Maybe add a device-normative statement that [admin_queue_index,
admin_queue_index + admin_queue_num) must be located after
device-specific virtqueues?

That would remind implementers that the device-specific virtqueue layout
needs to be followed and cannot be modified by the presence of
Administration Virtqueues.

>  \devicenormative{\paragraph}{Common configuration structure layout}{Virt=
io Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common con=
figuration structure layout}
> @@ -1119,6 +1136,14 @@ \subsubsection{Common configuration structure layo=
ut}\label{sec:Virtio Transport
>  were used before the queue reset.
>  (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtque=
ue Reset}).
> =20
> +If VIRTIO_F_ADMIN_VQ has been negotiated, and if the driver
> +configures any administration virtqueues, the driver MUST
> +configure the administration virtqueues using the index
> +in the range \field{admin_queue_index} to
> +\field{admin_queue_index} + \field{admin_queue_num} - 1 inclusive.
> +The driver MAY configure less administration virtqueues than

s/less/fewer/

--CBrKcojyhf/mdaKh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQsHYwACgkQnKSrs4Gr
c8h+EAgAuMg+rpcKwmatwJWZWCRDaalOpsr0KPTdZRTlkHTXsVxCbrghT8txEaxt
dOXKZENCpDTD5GEDYa3MLwzL5MecP9PNIDnRPramW6l5RSLABXu1H6m4gWjk2gCP
A4nyH9W8TvUYLx7P4fEjDwBqgj3UkMmAE0L+JYMt2GdNrfSEBChdRK9l+z3Jgf7I
sUryDb1WShfF5MWoKiK8SW0EE+mEoR9sOxrhsmAJ40mmralBHqbdH4O74yTcCGqP
DELozVuyNE4mXLnwzH/u7acI41ADlu2aRpo+kGYtDdStpZ5U+3vzbIoyYpy/vfwN
NN69qxxbC5HXWaR85dJ9V38Wb65eKA==
=K1OP
-----END PGP SIGNATURE-----

--CBrKcojyhf/mdaKh--

