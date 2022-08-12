Return-Path: <mst@redhat.com>
Date: Fri, 12 Aug 2022 13:19:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC v7 8/8] admin command list discovery
Message-ID: <20220812171841.12183-9-mst@redhat.com>
References: <20220812171841.12183-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220812171841.12183-1-mst@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, eperezma@redhat.com, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

From: Max Gurtovoy <mgurtovoy@nvidia.com>

Add commands to find out which commands does each group support.
This will be useful once we have multiple group types.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 admin.tex | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/admin.tex b/admin.tex
index 99b6c2a..5956c48 100644
--- a/admin.tex
+++ b/admin.tex
@@ -96,9 +96,11 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 
 \begin{tabular}{|l|l|}
 \hline
-opcode & Command Description \\
+opcode & Name & Command Description \\
 \hline \hline
-0000h - 7FFFh   & Group administration commands    \\
+0000h & VIRTIO_ADMIN_CMD_LIST_QUERY & Provides to driver list of commands supported for this group type    \\
+0001h & VIRTIO_ADMIN_CMD_LIST_ACCEPT & Provides to device list of commands used for this group type \\
+0002h - 7FFFh & - &  Group administration commands    \\
 \hline
 8000h - FFFFh   & Reserved    \\
 \hline
@@ -142,6 +144,72 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 structures to the shorter of the two (submitted by driver and
 described in this specification).
 
+Before sending any other commands for any member of a specific
+group to the device, the driver issues the commands
+VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_ACCEPT.
+
+
+Commands VIRTIO_ADMIN_CMD_LIST_QUERY and VIRTIO_ADMIN_CMD_LIST_ACCEPT
+both use the following structure describing the
+command opcodes:
+
+\begin{lstlisting}
+struct virtio_admin_cmd_list {
+       /* Indicates which of the below fields were returned
+       le32 device_admin_cmds[];
+};
+\end{lstlisting}
+
+This structure is an array of 32 bit values in little-endian byte
+order, in which a bit is set if the specific command opcode
+is supported. For example, the array of size 2 including
+the values 0x3 and 0x1 indicates that only opcodes 0, 1 and 32
+are supported.
+
+Accordingly, bits 0 and 1 corresponding to opcode 0
+(VIRTIO_ADMIN_CMD_LIST_QUERY) and 1 (VIRTIO_ADMIN_CMD_LIST_ACCEPT) must
+always be set in \field{device_admin_cmds}.
+
+
+For the command VIRTIO_ADMIN_CMD_LIST_QUERY, \field{opcode} is set to 0x0.
+The \field{group_member_id} is unused. It must be set to zero by driver.
+This command has no command specific data.
+The device, upon success, returns a result in the format
+\field{struct virtio_admin_cmd_list} describing the
+list of administration commands supported for the given group.
+
+
+For the command VIRTIO_ADMIN_CMD_LIST_ACCEPT, \field{opcode}
+is set to 0x1.
+The \field{group_member_id} is unused. It must be set to zero by driver.
+The command specific data is in the format
+\field{struct virtio_admin_cmd_list} describing the
+list of administration commands used by the driver.
+This command has no command specific result.
+
+The driver issues the command VIRTIO_ADMIN_CMD_LIST_QUERY to
+query the list of commands valid for this group.  before sending
+any commands for any member of a group.
+
+The driver then accepts some of the opcodes by sending to
+the device the command VIRTIO_ADMIN_CMD_LIST_ACCEPT with a subset
+of the list returned by VIRTIO_ADMIN_CMD_LIST_QUERY that is
+both understood and used by the driver.
+
+If the device supports the command list used by the driver, the
+device completes the command with status VIRTIO_ADMIN_STATUS_OK.
+If the device does not support the command list, the device
+completes the command with status
+VIRTIO_ADMIN_STATUS_INVALID_FIELD.
+
+Note: drivers SHOULD NOT set bits in device_admin_cmds
+if they are not familiar with how the command opcode
+is used, since devices MAY have dependencies between
+command opcodes.
+
+It is assumed that all members in a group support and are used
+with the same list of commands.
+
 \section{Administration Virtqueue}\label{sec:Basic Facilities of a Virtio Device / Group Administration Virtqueues}
 
 An administration virtqueue of a parent device is used to submit
-- 
MST

