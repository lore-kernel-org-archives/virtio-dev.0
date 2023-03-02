Return-Path: <virtio-dev-return-11391-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A17EC6FA8E
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 20:10:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5CABE77ED
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 20:10:25 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 413BB9866AC
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 20:10:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2E2FC984091; Thu,  2 Mar 2023 20:10:25 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 16F099866AF
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 20:10:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 1LIF23G4MU6sL3LtONnEIg-1
Date: Thu, 2 Mar 2023 15:10:11 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230302201011.GB2554028@fedora>
References: <cover.1677761896.git.mst@redhat.com>
 <910b3607a5f255134d30b3e1233e564f564eafb8.1677761896.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O8EmZxQ0wM/KxSAO"
Content-Disposition: inline
In-Reply-To: <910b3607a5f255134d30b3e1233e564f564eafb8.1677761896.git.mst@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Subject: [virtio-dev] Re: [PATCH v10 03/10] admin: introduce group administration commands

--O8EmZxQ0wM/KxSAO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 02, 2023 at 08:05:02AM -0500, Michael S. Tsirkin wrote:
> This introduces a general structure for group administration commands,
> used to control device groups through their owner.
>=20
> Following patches will introduce specific commands and an interface for
> submitting these commands to the owner.
>=20
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  admin.tex        | 108 +++++++++++++++++++++++++++++++++++++++++++++++
>  introduction.tex |   3 ++
>  2 files changed, 111 insertions(+)
>=20
> diff --git a/admin.tex b/admin.tex
> index 3dc47be..7e28b77 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -46,4 +46,112 @@ \section{Device groups}\label{sec:Basic Facilities of=
 a Virtio Device / Device g
>  PCI transport (see \ref{sec:Virtio Transport Options / Virtio Over PCI B=
us}).
>  \end{description}
> =20
> +\subsection{Group administration commands}\label{sec:Basic Facilities of=
 a Virtio Device / Device groups / Group administration commands}
> =20
> +The driver sends group administration commands to the owner device of

I notice that the terminology is simply "the driver". "Owner driver"
and "group member driver" might be clearer because there will be two
(possibly different) drivers involved.

> +a group to control member devices of the group.
> +This mechanism can
> +be used, for example, to configure a member device before it is
> +initialized by its driver.
> +\footnote{The term "administration" is intended to be interpreted
> +widely to include any kind of control. See specific commands
> +for detail.}
> +
> +All the group administration commands are of the following form:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd {
> +        /* Device-readable part */
> +        le16 opcode;
> +        /*
> +         * 1 - SR-IOV
> +         * 2 - 65535 reserved
> +         */
> +        le16 group_type;
> +        /* unused, reserved for future extensions */
> +        u8 reserved1[12];
> +        le64 group_member_id;
> +        u8 command_specific_data[];
> +
> +        /* Device-writable part */
> +        le16 status;
> +        le16 status_qualifier;
> +        /* unused, reserved for future extensions */
> +        u8 reserved2[4];
> +        u8 command_specific_result[];
> +};
> +\end{lstlisting}
> +
> +For all commands, \field{opcode}, \field{group_type} and if
> +necessary \field{group_member_id} and \field{command_specific_data} are
> +set by the driver, and the owner device sets \field{status} and if
> +needed \field{status_qualifier} and
> +\field{command_specific_result}.
> +
> +Generally, any unused device-readable fields are set to zero by the driv=
er
> +and ignored by the device.  Any unused device-writeable fields are set t=
o zero
> +by the device and ignored by the driver.
> +
> +\field{opcode} specifies the command. The valid
> +values for \field{opcode} can be found in the following table:
> +
> +\begin{tabular}{|l|l|}
> +\hline
> +opcode & Name & Command Description \\
> +\hline \hline
> +0x0000 - 0x7FFF & - &  Group administration commands    \\
> +\hline
> +0x8000 - 0xFFFF & - & Reserved    \\
> +\hline
> +\end{tabular}

I thought all commands are "group administration commands" but this
table makes it look like they are just a subset (0x0000 - 0x7FFF) of
group administration commands, which is a paradox.

> +
> +The \field{group_type} specifies the group type identifier.
> +The \field{group_member_id} specifies the member identifier within the g=
roup.
> +See section \ref{sec:Introduction / Terminology / Device group}
> +for the definition of the group type identifier and group member
> +identifier.
> +
> +The following table describes possible \field{status} values;
> +to simplify common implementations, they are intentionally
> +matching common \hyperref[intro:errno]{Linux error names and numbers}:
> +
> +\begin{tabular}{|l|l|l|}
> +\hline
> +Status (decimal) & Name & Description \\
> +\hline \hline
> +00   & VIRTIO_ADMIN_STATUS_OK    & successful completion  \\
> +\hline
> +22   & VIRTIO_ADMIN_STATUS_EINVAL    & invalid command \\
> +\hline
> +other   & -    & group administration command error  \\
> +\hline
> +\end{tabular}
> +
> +When \field{status} is VIRTIO_ADMIN_STATUS_OK, \field{status_qialifier}

s/qialifier/qualifier/

> +is reserved and set to zero by the device.
> +
> +When \field{status} is VIRTIO_ADMIN_STATUS_EINVAL,
> +the following table describes possible \field{status_qialifier} values:

s/qialifier/qualifier/

> +\begin{tabular}{|l|l|l|}
> +\hline
> +Status & Name & Description \\
> +\hline \hline
> +0x00   & VIRTIO_ADMIN_STATUS_Q_INVALID_COMMAND   & command error: no add=
itional information  \\
> +\hline
> +0x01   & VIRTIO_ADMIN_STATUS_Q_INVALID_OPCODE    & unsupported or invali=
d \field{opcode}  \\
> +\hline
> +0x02   & VIRTIO_ADMIN_STATUS_Q_INVALID_FIELD    & unsupported or invalid=
 field within \field{command_specific_data}  \\
> +\hline
> +0x03   & VIRTIO_ADMIN_STATUS_Q_INVALID_GROUP    & unsupported or invalid=
 \field{group_type} \\
> +\hline
> +0x04   & VIRTIO_ADMIN_STATUS_Q_INVALID_MEMBER    & unsupported or invali=
d \field{group_member_id} \\
> +\hline
> +0x05-0xFFFF   & -    & reserved for future use \\
> +\hline
> +\end{tabular}
> +
> +Each command uses a different \field{command_specific_data} and
> +\field{command_specific_result} structures and the length of
> +\field{command_specific_data} and \field{command_specific_result}
> +depends on these structures and is described separately or is
> +implicit in the structure description.

On more thing:

Does the owner device see commands in order but may complete them in any
order?

I think this information might be useful just to make it clear that
driver authors shouldn't make assumptions about ordering and completion
order, e.g. pipelining a bunch of dependent commands doesn't work
because the first command is not necessarily completed before the second
command is started.

--O8EmZxQ0wM/KxSAO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQBAqMACgkQnKSrs4Gr
c8gazAf/UtSaymfsHV+NSwe9KMyvr8FpY8vYHmmGl2OzqChXeB83vxTkuW57LRCo
2YrONqwv6Lk3C0juCVdONpQ8AtdS5sbIZZD6PxRYGEcJF2fwEK85YHRV4OKiVFx7
KXAeETLfTeVOIXfRjvgTASLPskM6RsQwymbhxJ4gP7zQ6aJNX7n+7MktBwH1zj/x
X1J2iFFe60Vt8oKphDbfwe0Tk0XZ8vgBBHe7hT3g8V80o1LM+1DpK6hp+WB351mw
fJSaqcrzTId8CPlDEKDbhuP2kwQVsg4nu5b7L6oYNuqegpwgi2gu7lJ3P3c2VROt
x7gObNa0uPgfMtHkgLwqhpEd91iK0w==
=pRl+
-----END PGP SIGNATURE-----

--O8EmZxQ0wM/KxSAO--

