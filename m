Return-Path: <virtio-dev-return-11397-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E08F4C678D4
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 21:09:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0F9DC2ACAC
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 21:09:39 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EFF5C9866B0
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 21:09:38 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E2647984091; Thu,  2 Mar 2023 21:09:38 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D26429866AF
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 21:09:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 2R_s-T5BPdS_peCxIJA2Kg-1
Date: Thu, 2 Mar 2023 16:09:29 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com,
	virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230302210929.GH2554028@fedora>
References: <cover.1677761896.git.mst@redhat.com>
 <80c4bc60c9119f68b66f5a003564cec719cc1487.1677761896.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6Yg/8aur/mGd+Erz"
Content-Disposition: inline
In-Reply-To: <80c4bc60c9119f68b66f5a003564cec719cc1487.1677761896.git.mst@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Subject: [virtio-dev] Re: [PATCH v10 08/10] admin: command list discovery

--6Yg/8aur/mGd+Erz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 02, 2023 at 08:05:22AM -0500, Michael S. Tsirkin wrote:
> Add commands to find out which commands does each group support,
> as well as enable their use by driver.
> This will be especially useful once we have multiple group types.
>=20
> An alternative is per-type VQs. This is possible but will
> require more per-transport work. Discovery through the vq
> helps keep things contained.
>=20
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  admin.tex | 97 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 96 insertions(+), 1 deletion(-)
>=20
> diff --git a/admin.tex b/admin.tex
> index 3ffac2e..1172054 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -99,7 +99,9 @@ \subsection{Group administration commands}\label{sec:Ba=
sic Facilities of a Virti
>  \hline
>  opcode & Name & Command Description \\
>  \hline \hline
> -0x0000 - 0x7FFF & - &  Group administration commands    \\
> +0x0000 & VIRTIO_ADMIN_CMD_LIST_QUERY & Provides to driver list of comman=
ds supported for this group type    \\
> +0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of commands=
 used for this group type \\
> +0x0002 - 0x7FFF & - &  Group administration commands    \\
>  \hline
>  0x8000 - 0xFFFF & - & Reserved    \\
>  \hline
> @@ -156,6 +158,99 @@ \subsection{Group administration commands}\label{sec=
:Basic Facilities of a Virti
>  depends on these structures and is described separately or is
>  implicit in the structure description.
> =20
> +Before sending any administration commands to the device, the driver
> +needs to communicate to the device which commands it is going to
> +use. Initially (after reset), only two commands are assumed to be used:
> +VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE.
> +
> +Before sending any other commands for any member of a specific group to
> +the device, the driver queries the supported commands via
> +VIRTIO_ADMIN_CMD_LIST_QUERY and sends the commands it will use via

"will use" probably means "is capable of using" rather than "is sure to
use"? It might be worth tweaking the language here to make that clear.

> +VIRTIO_ADMIN_CMD_LIST_USE.
> +
> +Commands VIRTIO_ADMIN_CMD_LIST_QUERY and
> +VIRTIO_ADMIN_CMD_LIST_USE
> +both use the following structure describing the
> +command opcodes:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_list {
> +       /* Indicates which of the below fields were returned
> +       le64 device_admin_cmds[];
> +};
> +\end{lstlisting}
> +
> +This structure is an array of 64 bit values in little-endian byte
> +order, in which a bit is set if the specific command opcode
> +is supported. Thus, \field{device_admin_cmds[0]} refers to the first 32-=
bit value
> +in this array corresponding to opcodes 0 to 63,
> +\field{device_admin_cmds[1]} is the second 64-bit value
> +corresponding to opcodes 64 to 127, etc.
> +For example, the array of size 2 including
> +the values 0x3 in \field{device_admin_cmds[0]}
> +and 0x1 in \field{device_admin_cmds[1]} indicates that only
> +opcodes 0, 1 and 64 are supported.
> +The length of the array depends on the supported opcodes - it is
> +large enough to include bits set for all supported opcodes,
> +that is the length can be calculated by starting with the largest
> +supported opcode adding one, dividing by 64 and rounding up.
> +In other words, for
> +VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE the
> +length of \field{command_specific_result} and
> +\field{command_specific_data} respectively will be
> +$DIV_ROUND_UP(max_cmd, 64) * 8$ where DIV_ROUND_UP is integer division
> +with round up and \field{max_cmd} is the largest available command opcod=
e.
> +
> +The array is also allowed to be larger and to additionally
> +include an arbitrary number of all-zero entries.
> +
> +Accordingly, bits 0 and 1 corresponding to opcode 0
> +(VIRTIO_ADMIN_CMD_LIST_QUERY) and 1
> +(VIRTIO_ADMIN_CMD_LIST_USE) are
> +always set in \field{device_admin_cmds[0]} returned by VIRTIO_ADMIN_CMD_=
LIST_QUERY.
> +
> +For the command VIRTIO_ADMIN_CMD_LIST_QUERY, \field{opcode} is set to 0x=
0.
> +The \field{group_member_id} is unused. It is set to zero by driver.
> +This command has no command specific data.
> +The device, upon success, returns a result in
> +\field{command_specific_result} in the format
> +\field{struct virtio_admin_cmd_list} describing the
> +list of administration commands supported for the given group.
> +
> +
> +For the command VIRTIO_ADMIN_CMD_LIST_USE, \field{opcode}
> +is set to 0x1.
> +The \field{group_member_id} is unused. It is set to zero by driver.
> +The \field{command_specific_data} is in the format
> +\field{struct virtio_admin_cmd_list} describing the
> +list of administration commands used by the driver.
> +This command has no command specific result.
> +
> +The driver issues the command VIRTIO_ADMIN_CMD_LIST_QUERY to
> +query the list of commands valid for this group and before sending
> +any commands for any member of a group.
> +
> +The driver then enables use of some of the opcodes by sending to
> +the device the command VIRTIO_ADMIN_CMD_LIST_USE with a subset
> +of the list returned by VIRTIO_ADMIN_CMD_LIST_QUERY that is
> +both understood and used by the driver.
> +
> +If the device supports the command list used by the driver, the
> +device completes the command with status VIRTIO_ADMIN_STATUS_OK.
> +If the device does not support the command list, the device
> +completes the command with status
> +VIRTIO_ADMIN_STATUS_INVALID_FIELD.
> +
> +Note: drivers are assumed not to set bits in device_admin_cmds
> +if they are not familiar with how the command opcode
> +is used, since devices could have dependencies between
> +command opcodes.
> +
> +It is assumed that all members in a group support and are used
> +with the same list of commands. However, for owner devices
> +supporting multiple group types, the list of supported commands
> +might differ between different group types.

Is the purpose of VIRTIO_ADMIN_CMD_LIST_USE so that new commands can be
added that are mandatory for device operation. Failure to include them
in the VIRTIO_ADMIN_CMD_LIST_USE command terminates device
initialization with an error?

Are commands evolved by defining flag/version bits in the command
specific data struct? For example, if a new field needs to be added to a
command and a 0 value carries a meaning (so it cannot simply be added to
the end of the existing struct with backwards compatibility).

Stefan

--6Yg/8aur/mGd+Erz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmQBEIkACgkQnKSrs4Gr
c8gvgwf/VJEUWUkCRkzZd+yBoZPt1XlsCmDn0RKwWRMo2wnvVwXSCS/joY5fy3lM
V3lZBTYO7DbebAHTrqxzOv8MWi6u9wBQ4QCV7Eun6av7R8V3F1fOakE+11oBLQvp
Ygk13wwwbLIMfVgKWU7H4NB2o0/wn6TNHcM6403t1opAcn6PoKzJ0v2puYjgjyWp
iyHLa7cHNQw8LhwBUeZgKz9kfJvPywaqy0LH9ksNApf3uKXypyuhe1ZeBn0ejyU/
GpXkCPSgGZ1tK7Dq6SuBMcuPUdVFB8HOrj5E+YnVn4DGFt3CfM5i1125ZPC36E7/
a+vaWOS31NjoNhKfkUZpTLJxHZNy0Q==
=9BSE
-----END PGP SIGNATURE-----

--6Yg/8aur/mGd+Erz--

