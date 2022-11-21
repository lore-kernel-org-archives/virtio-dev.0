Return-Path: <piotr.uminski@intel.com>
From: "Uminski, Piotr" <Piotr.Uminski@intel.com>
Subject: RE: [PATCH v8 8/9] admin: command list discovery
Date: Mon, 21 Nov 2022 11:06:14 +0000
Message-ID: <SN6PR11MB3517ECBE658C18BD9B7E355CFF0A9@SN6PR11MB3517.namprd11.prod.outlook.com>
References: <20221121012419.317406-1-mst@redhat.com>
 <20221121012419.317406-9-mst@redhat.com>
In-Reply-To: <20221121012419.317406-9-mst@redhat.com>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com" <cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Jani, Nrupal" <nrupal.jani@intel.com>, "Yuan, Hang" <hang.yuan@intel.com>
Cc: "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Instead of a bit-coded list of supported commands, can we just use an array=
 of supported command values? It allows us to use non-contiguous command co=
ding and checking how big  is an array:       le32 device_admin_cmds[];


-----Original Message-----
From: Michael S. Tsirkin <mst@redhat.com>=20
Sent: Monday, November 21, 2022 2:26 AM
To: virtio-comment@lists.oasis-open.org; virtio-dev@lists.oasis-open.org; j=
asowang@redhat.com; mst@redhat.com; cohuck@redhat.com; sgarzare@redhat.com;=
 stefanha@redhat.com; Jani, Nrupal <nrupal.jani@intel.com>; Uminski, Piotr =
<Piotr.Uminski@intel.com>; Yuan, Hang <hang.yuan@intel.com>
Cc: virtio@lists.oasis-open.org; Zhu, Lingshan <lingshan.zhu@intel.com>; pa=
sic@linux.ibm.com; Shahaf Shuler <shahafs@nvidia.com>; Parav Pandit <parav@=
nvidia.com>; Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v8 8/9] admin: command list discovery

Add commands to find out which commands does each group support, as well as=
 enable their use by driver.
This will be especially useful once we have multiple group types.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 admin.tex | 130 +++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 114 insertions(+), 16 deletions(-)

diff --git a/admin.tex b/admin.tex
index bfa63a2..589e06a 100644
--- a/admin.tex
+++ b/admin.tex
@@ -72,13 +72,14 @@ \subsection{Group administration commands}\label{sec:Ba=
sic Facilities of a Virti
=20
         /* Device-writable part */
         le16 status;
+        le16 status_qualifier;
         /* unused, reserved for future extensions */
-        u8 reserved2[6];
+        u8 reserved2[4];
         u8 command_specific_result[];
 };
 \end{lstlisting}
=20
-For all commands, \field{opcode}, \field{group_id} and if
+For all commands, \field{opcode}, \field{group_type} and if
 necessary \field{group_member_id} and \field{command_specific_data} are  s=
et by the driver, and the owner device sets \field{status} and if  needed \=
field{status_qualifier} and @@ -93,18 +94,20 @@ \subsection{Group administr=
ation commands}\label{sec:Basic Facilities of a Virti
=20
 \begin{tabular}{|l|l|}
 \hline
-opcode & Command Description \\
+opcode & Name & Command Description \\
 \hline \hline
-0000h - 7FFFh   & Group administration commands    \\
+0000h & VIRTIO_ADMIN_CMD_LIST_QUERY & Provides to driver list of commands =
supported for this group type    \\
+0001h & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of commands us=
ed for this group type \\
+0002h - 7FFFh & - &  Group administration commands    \\
 \hline
 8000h - FFFFh   & Reserved    \\
 \hline
 \end{tabular}
=20
-The \field{group_id} specifies the device group.
-The \field{group_member_id} specifies the member device within the group.
+The \field{group_type} specifies the group type identifier.
+The \field{group_member_id} specifies the member identifier within the gro=
up.
 See section \ref{sec:Introduction / Terminology / Device group} -for the d=
efinition of the group identifier and group member
+for the definition of the group type identifier and group member
 identifier.
=20
 The following table describes possible \field{status} values, @@ -113,22 +=
116,117 @@ \subsection{Group administration commands}\label{sec:Basic Facil=
ities of a Virti
=20
 \begin{tabular}{|l|l|l|}
 \hline
-Status & Name & Description \\
+Status (decimal) & Name & Description \\
 \hline \hline
-00h   & VIRTIO_ADMIN_STATUS_OK    & successful completion  \\
+00   & VIRTIO_ADMIN_STATUS_OK    & successful completion  \\
 \hline
-01h   & VIRTIO_ADMIN_STATUS_INVALID_OPCODE    & unsupported or invalid \fi=
eld{opcode}  \\
-\hline
-02h   & VIRTIO_ADMIN_STATUS_INVALID_FIELD    & invalid field within comman=
d specific data  \\
-\hline
-03h   & VIRTIO_ADMIN_STATUS_INVALID_GROUP    & invalid group identifier wa=
s set  \\
-\hline
-04h   & VIRTIO_ADMIN_STATUS_INVALID_MEM    & invalid group member identifi=
er was set  \\
+22   & VIRTIO_ADMIN_STATUS_EINVAL    & invalid command \\
 \hline
 other   & -    & group administration command error  \\
 \hline
 \end{tabular}
=20
+When \field{status} is VIRTIO_ADMIN_STATUS_OK, \field{status_qialifier}=20
+is reserved and set to zero by the device.
+
+When \field{status} is VIRTIO_ADMIN_STATUS_EINVAL, the following table=20
+describes possible \field{status_qialifier} values:
+\begin{tabular}{|l|l|l|}
+\hline
+Status & Name & Description \\
+\hline \hline
+00h   & VIRTIO_ADMIN_STATUS_Q_INVALID_COMMAND   & command error: no additi=
onal information  \\
+\hline
+01h   & VIRTIO_ADMIN_STATUS_Q_INVALID_OPCODE    & unsupported or invalid \=
field{opcode}  \\
+\hline
+02h   & VIRTIO_ADMIN_STATUS_Q_INVALID_FIELD    & unsupported or invalid fi=
eld within \field{command_specific_data}  \\
+\hline
+03h   & VIRTIO_ADMIN_STATUS_Q_INVALID_GROUP    & unsupported or invalid \f=
ield{group_type} was set  \\
+\hline
+04h   & VIRTIO_ADMIN_STATUS_Q_INVALID_MEM    & unsupported or invalid \fie=
ld{group_member_id} was set  \\
+\hline
+other   & -    & group administration command error  \\
+\hline
+\end{tabular}
+
+Before sending any administration commands to the device, the commands=20
+in question are reported to the device as used by the driver.
+Initially (after reset), only two commands are assumed to be used:
+VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE.
+
+Accordingly,
+before sending any other commands for any member of a specific group to=20
+the device, the driver issues the commands VIRTIO_ADMIN_CMD_LIST_QUERY=20
+and VIRTIO_ADMIN_CMD_LIST_USE.
+
+Commands VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_USE both=20
+use the following structure describing the command opcodes:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_list {
+       /* Indicates which of the below fields were returned
+       le32 device_admin_cmds[];
+};
+\end{lstlisting}
+
+This structure is an array of 32 bit values in little-endian byte=20
+order, in which a bit is set if the specific command opcode is=20
+supported. Thus, \field{device_admin_cmds[0]} refers to the first=20
+32-bit value in this array corresponding to opcodes 0 to 31,=20
+\field{device_admin_cmds[1]} is the second 32-bit value corresponding=20
+to opcodes 32 to 63, etc.
+For example, the array of size 2 including the values 0x3 in=20
+\field{device_admin_cmds[0]} and 0x1 in \field{device_admin_cmds[1]}=20
+indicates that only opcodes 0, 1 and 32 are supported.
+
+Accordingly, bits 0 and 1 corresponding to opcode 0
+(VIRTIO_ADMIN_CMD_LIST_QUERY) and 1
+(VIRTIO_ADMIN_CMD_LIST_USE) are
+always set in \field{device_admin_cmds[0]} returned by VIRTIO_ADMIN_CMD_LI=
ST_QUERY.
+
+For the command VIRTIO_ADMIN_CMD_LIST_QUERY, \field{opcode} is set to 0x0.
+The \field{group_member_id} is unused. It is set to zero by driver.
+This command has no command specific data.
+The device, upon success, returns a result in=20
+\field{command_specific_result} in the format \field{struct=20
+virtio_admin_cmd_list} describing the list of administration commands=20
+supported for the given group.
+
+
+For the command VIRTIO_ADMIN_CMD_LIST_USE, \field{opcode} is set to=20
+0x1.
+The \field{group_member_id} is unused. It is set to zero by driver.
+The \field{command_specific_data} is in the format \field{struct=20
+virtio_admin_cmd_list} describing the list of administration commands=20
+used by the driver.
+This command has no command specific result.
+
+The driver issues the command VIRTIO_ADMIN_CMD_LIST_QUERY to query the=20
+list of commands valid for this group and before sending any commands=20
+for any member of a group.
+
+The driver then enables use of some of the opcodes by sending to the=20
+device the command VIRTIO_ADMIN_CMD_LIST_USE with a subset of the list=20
+returned by VIRTIO_ADMIN_CMD_LIST_QUERY that is both understood and=20
+used by the driver.
+
+If the device supports the command list used by the driver, the device=20
+completes the command with status VIRTIO_ADMIN_STATUS_OK.
+If the device does not support the command list, the device completes=20
+the command with status VIRTIO_ADMIN_STATUS_INVALID_FIELD.
+
+Note: drivers are assumed not to set bits in device_admin_cmds if they=20
+are not familiar with how the command opcode is used, since devices=20
+could have dependencies between command opcodes.
+
+It is assumed that all members in a group support and are used with the=20
+same list of commands.
+
 \section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio=
 Device / Administration Virtqueues}
=20
 An administration virtqueue of an owner device is used to submit
--
MST

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

