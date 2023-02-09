Return-Path: <piotr.uminski@intel.com>
From: "Uminski, Piotr" <Piotr.Uminski@intel.com>
Subject: RE: [PATCH v10 08/10] admin: command list discovery
Date: Thu, 9 Feb 2023 17:04:04 +0000
Message-ID: <SN6PR11MB351750EFF935414E4DC7B596FFD99@SN6PR11MB3517.namprd11.prod.outlook.com>
References: <20230209121221.15118-1-mst@redhat.com>
 <20230209121221.15118-9-mst@redhat.com>
In-Reply-To: <20230209121221.15118-9-mst@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Jani, Nrupal" <nrupal.jani@intel.com>, "Yuan, Hang" <hang.yuan@intel.com>
Cc: "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>



> -----Original Message-----
> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, February 9, 2023 1:14 PM
> To: virtio-comment@lists.oasis-open.org; virtio-dev@lists.oasis-open.org;
> jasowang@redhat.com; mst@redhat.com; cohuck@redhat.com;
> sgarzare@redhat.com; stefanha@redhat.com; Jani, Nrupal
> <nrupal.jani@intel.com>; Uminski, Piotr <Piotr.Uminski@intel.com>; Yuan,
> Hang <hang.yuan@intel.com>
> Cc: virtio@lists.oasis-open.org; Zhu, Lingshan <lingshan.zhu@intel.com>;
> pasic@linux.ibm.com; Shahaf Shuler <shahafs@nvidia.com>; Parav Pandit
> <parav@nvidia.com>; Max Gurtovoy <mgurtovoy@nvidia.com>
> Subject: [PATCH v10 08/10] admin: command list discovery
>=20
> Add commands to find out which commands does each group support, as
> well as enable their use by driver.
> This will be especially useful once we have multiple group types.
>=20
> An alternative is per-type VQs. This is possible but will require more pe=
r-
> transport work. Discovery through the vq helps keep things contained.
>=20
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  admin.tex | 90
> ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 89 insertions(+), 1 deletion(-)
>=20
> diff --git a/admin.tex b/admin.tex
> index 3026a79..4de606a 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -98,7 +98,9 @@ \subsection{Group administration
> commands}\label{sec:Basic Facilities of a Virti  \hline  opcode & Name &
> Command Description \\  \hline \hline
> -0x0000 - 0x7FFF & - &  Group administration commands    \\
> +0x0000 & VIRTIO_ADMIN_CMD_LIST_QUERY & Provides to driver list of
> commands supported for this group type    \\
> +0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of
> commands used for this group type \\
> +0x0002 - 0x7FFF & - &  Group administration commands    \\
>  \hline
>  0x8000 - 0xFFFF & - & Reserved    \\
>  \hline
> @@ -149,6 +151,92 @@ \subsection{Group administration
> commands}\label{sec:Basic Facilities of a Virti  \hline  \end{tabular}
>=20
> +Before sending any administration commands to the device, the driver
> +needs to communicate to the device which commands it is going to use.
> +Initially (after reset), only two commands are assumed to be used:
> +VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE.
> +
> +Before sending any other commands for any member of a specific group to
> +the device, the driver queries the supported commands via
> +VIRTIO_ADMIN_CMD_LIST_QUERY and sends the commands it will use via
> +VIRTIO_ADMIN_CMD_LIST_USE.
> +
> +Commands VIRTIO_ADMIN_CMD_LIST_QUERY and
> VIRTIO_ADMIN_CMD_LIST_USE both
> +use the following structure describing the command opcodes:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_list {
> +       /* Indicates which of the below fields were returned
> +       le64 device_admin_cmds[];
> +};
> +\end{lstlisting}
> +
> +This structure is an array of 64 bit values in little-endian byte
> +order, in which a bit is set if the specific command opcode is
> +supported. Thus, \field{device_admin_cmds[0]} refers to the first
> +32-bit value in this array corresponding to opcodes 0 to 63,
Probably should be "64-bit value"
> +\field{device_admin_cmds[1]} is the second 64-bit value corresponding
> +to opcodes 64 to 127, etc.
> +For example, the array of size 2 including the values 0x3 in
> +\field{device_admin_cmds[0]} and 0x1 in \field{device_admin_cmds[1]}
> +indicates that only opcodes 0, 1 and 64 are supported.
> +The length of the array depends on the supported opcodes - it is large
> +enough to include bits set for all supported opcodes, that is the
> +length can be calculated by starting with the largest supported opcode
> +adding one, dividing by 64 and rounding up.
> +The array is also allowed to be larger and to additionally include an
> +arbitrary number of all-zero entries.
> +
> +Accordingly, bits 0 and 1 corresponding to opcode 0
> +(VIRTIO_ADMIN_CMD_LIST_QUERY) and 1
> +(VIRTIO_ADMIN_CMD_LIST_USE) are
> +always set in \field{device_admin_cmds[0]} returned by
> VIRTIO_ADMIN_CMD_LIST_QUERY.
> +
> +For the command VIRTIO_ADMIN_CMD_LIST_QUERY, \field{opcode} is set
> to 0x0.
> +The \field{group_member_id} is unused. It is set to zero by driver.
> +This command has no command specific data.
> +The device, upon success, returns a result in
> +\field{command_specific_result} in the format \field{struct
> +virtio_admin_cmd_list} describing the list of administration commands
> +supported for the given group.
> +
> +
> +For the command VIRTIO_ADMIN_CMD_LIST_USE, \field{opcode} is set to
> +0x1.
> +The \field{group_member_id} is unused. It is set to zero by driver.
> +The \field{command_specific_data} is in the format \field{struct
> +virtio_admin_cmd_list} describing the list of administration commands
> +used by the driver.
> +This command has no command specific result.
> +
> +The driver issues the command VIRTIO_ADMIN_CMD_LIST_QUERY to
> query the
> +list of commands valid for this group and before sending any commands
> +for any member of a group.
> +
> +The driver then enables use of some of the opcodes by sending to the
> +device the command VIRTIO_ADMIN_CMD_LIST_USE with a subset of the
> list
> +returned by VIRTIO_ADMIN_CMD_LIST_QUERY that is both understood
> and
> +used by the driver.
> +
> +If the device supports the command list used by the driver, the device
> +completes the command with status VIRTIO_ADMIN_STATUS_OK.
> +If the device does not support the command list, the device completes
> +the command with status VIRTIO_ADMIN_STATUS_INVALID_FIELD.
> +
> +Note: drivers are assumed not to set bits in device_admin_cmds if they
> +are not familiar with how the command opcode is used, since devices
> +could have dependencies between command opcodes.
> +
> +It is assumed that all members in a group support and are used with the
> +same list of commands. However, for owner devices supporting multiple
> +group types, the list of supported commands might differ between
> +different group types.
> +
>  \section{Administration Virtqueues}\label{sec:Basic Facilities of a Virt=
io
> Device / Administration Virtqueues}
>=20
>  An administration virtqueue of an owner device is used to submit
> --
> MST

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydz=
ial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-31=
6 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu usta=
wy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w trans=
akcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata=
 i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wi=
adomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiek=
olwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the s=
ole use of the intended recipient(s). If you are not the intended recipient=
, please contact the sender and delete all copies; any review or distributi=
on by others is strictly prohibited.

