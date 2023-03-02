Return-Path: <virtio-dev-return-11393-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E1EEC6FA8E
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 20:40:21 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8CCAC2AC51
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 20:40:20 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7FC809866D5
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 20:40:20 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 677149866AC; Thu,  2 Mar 2023 20:40:20 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 530DF9866AF
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 20:40:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: wj7O-zN3PqudEDvFRsTkAA-1
Date: Thu, 2 Mar 2023 15:40:07 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230302204007.GD2554028@fedora>
References: <cover.1677761896.git.mst@redhat.com>
 <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aU9Ey68ySpf5ZT/8"
Content-Disposition: inline
In-Reply-To: <20c81b66f0b21b5bd646c24840ac3f8462c86acf.1677761896.git.mst@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Subject: [virtio-dev] Re: [PATCH v10 04/10] admin: introduce virtio admin virtqueues

--aU9Ey68ySpf5ZT/8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 02, 2023 at 08:05:06AM -0500, Michael S. Tsirkin wrote:
> The admin virtqueues will be the first interface to issue admin commands.
>=20
> Currently virtio specification defines control virtqueue to manipulate
> features and configuration of the device it operates on. However,
> control virtqueue commands are device type specific, which makes it very
> difficult to extend for device agnostic commands.
>=20
> To support this requirement in a more generic way, this patch introduces
> a new admin virtqueue interface.

Is this referring to the existing virtio-net, virtio-scsi, etc control
virtqueues?

I see the admin virtqueue as the virtqueue equivalent to transport
feature bits. The admin queue does nothing device type-specific (net,
scsi, etc) and instead focusses on transport and core virtio tasks.

Keeping the device-specific virtqueue separate from the admin virtqueue
is simpler and has fewer potential problems. I don't think creating
common infrastructure for device-specific control virtqueues across
device types worthwhile or within the scope of this patch series.

> We also support more than one admin virtqueue, for QoS and
> scalability requirements.
>=20
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  admin.tex   | 74 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  content.tex |  7 +++--
>  2 files changed, 79 insertions(+), 2 deletions(-)
>=20
> diff --git a/admin.tex b/admin.tex
> index 7e28b77..3ffac2e 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -155,3 +155,77 @@ \subsection{Group administration commands}\label{sec=
:Basic Facilities of a Virti
>  \field{command_specific_data} and \field{command_specific_result}
>  depends on these structures and is described separately or is
>  implicit in the structure description.
> +
> +\section{Administration Virtqueues}\label{sec:Basic Facilities of a Virt=
io Device / Administration Virtqueues}
> +
> +An administration virtqueue of an owner device is used to submit
> +group administration commands. An owner device can have more
> +than one administration virtqueue.
> +
> +If VIRTIO_F_ADMIN_VQ has been negotiated, an owner device exposes one
> +or more adminstration virtqueues. The number and locations of the
> +administration virtqueues are exposed by the owner device in a transport
> +specific manner.
> +
> +The driver submits commands by queueing them to an arbitrary
> +administration virtqueue, and they are processed by the
> +device in the order in which they are queued. It is the
> +responsibility of the driver to ensure ordering for commands
> +placed on different administration virtqueues, because they will
> +be executed with no order constraints.

Does "they are processed by the device in the order in which they are
queued" mean only 1 admin command can be running at any given time and
therefore they will complete in order? This would allow pipelining
dependent commands but prevent long-running commands because the
virtqueue is blocked while executing a command.

> +
> +Administration virtqueues are used as follows:
> +\begin{itemize}
> +\item The driver submits the command using the \field{struct virtio_admi=
n_cmd}
> +structure using a buffer consisting of two parts: a device-readable one =
followed by a
> +device-writable one.
> +\item the device-readable part includes fields from \field{opcode}
> +through \field{command_specific_data}.
> +\item the device-writeable buffer includes fields from \field{status}
> +through \field{command_specific_result} inclusive.
> +\end{itemize}
> +
> +For each command, this specification describes a distinct
> +format structure used for \field{command_specific_data} and
> +\field{command_specific_result}, the length of these fields
> +depends on the command.
> +
> +However, to ensure forward compatibility
> +\begin{itemize}
> +\item drivers are allowed to submit buffers that are longer
> +than what the device expects
> +(that is, longer than the length of
> +\field{opcode} through \field{command_specific_data}).
> +This allows the driver to maintain
> +a single format structure even if some structure fields are
> +unused by the device.
> +\item drivers are allowed to submit buffers that are shorter
> +than what the device expects
> +(that is, shorter than the length of \field{status} through
> +\field{command_specific_result}). This allows the device to maintain
> +a single format structure even if some structure fields are
> +unused by the driver.
> +\end{itemize}
> +
> +The device compares the length of each part (device-readable and
> +device-writeable) of the buffer as submitted by driver to what it
> +expects and then silently truncates the structures to either the
> +length submitted by the driver, or the length described in this
> +specification, whichever is shorter.  The device silently ignores
> +any data falling outside the shorter of the two lengths. Any
> +missing fields are interpreted as set to zero.
> +
> +Similarly, the driver compares the used buffer length
> +of the buffer to what it expects and then silently
> +truncates the structure to the used buffer length.
> +The driver silently ignores any data falling outside
> +the used buffer length reported by the device.  Any missing
> +fields are interpreted as set to zero.
> +
> +This simplifies driver and device implementations since the
> +driver/device can simply maintain a single large structure (such
> +as a C structure) for a command and its result. As new versions
> +of the specification are designed, new fields can be added to the
> +tail of a structure, with the driver/device using the full
> +structure without concern for versioning.
> +>>>>>>> 0edc690... admin: introduce virtio admin virtqueues

A merge conflict line crept into the patch?

> diff --git a/content.tex b/content.tex
> index ffe45c4..c8647c9 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -99,10 +99,10 @@ \section{Feature Bits}\label{sec:Basic Facilities of =
a Virtio Device / Feature B
>  \begin{description}
>  \item[0 to 23, and 50 to 127] Feature bits for the specific device type
> =20
> -\item[24 to 40] Feature bits reserved for extensions to the queue and
> +\item[24 to 41] Feature bits reserved for extensions to the queue and
>    feature negotiation mechanisms
> =20
> -\item[41 to 49, and 128 and above] Feature bits reserved for future exte=
nsions.
> +\item[42 to 49, and 128 and above] Feature bits reserved for future exte=
nsions.
>  \end{description}
> =20
>  \begin{note}
> @@ -7682,6 +7682,9 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved =
Feature Bits}
>    that the driver can reset a queue individually.
>    See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqu=
eue Reset}.
> =20
> +  \item[VIRTIO_F_ADMIN_VQ(41)] This feature indicates that the device ex=
poses one or more
> +  administration virtqueues.
> +
>  \end{description}
> =20
>  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
> --=20
> MST
>=20

--aU9Ey68ySpf5ZT/8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQBCacACgkQnKSrs4Gr
c8iyOwf8C5+BZHirOR/G59dXc4tD+gqH+n9R+XSCamxvf+XP3ARQbCpgeAChq02b
YhgI0tY0/MyL3L6b5GKo5nClRGIaV1sY1CQH1dHWtq+Ko6RnJMcmn2W8ibFgpUys
QnRiYwJ6ohNMa55HFC9osVm1QlQZ5wh0XsXNtdXbV4HFLoDaHeRlMzCH/MIEFsIQ
e4AKOp6j5qV2FP3OOx0O8IXO7aCtRypfUVnWvX2HLVLt3GBj9vSBkXJZP1UbE84C
u3xMO7YojrpQKYgesiwkhCOQ/ui2BCNLsTPGXb51WXixiaeHRRaO4hxF+nqgvMfj
T+qCxOfWG1Y0azZxbEAIpZwU7D3EOw==
=UxIV
-----END PGP SIGNATURE-----

--aU9Ey68ySpf5ZT/8--

