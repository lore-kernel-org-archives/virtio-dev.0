Return-Path: <mst@redhat.com>
Date: Wed, 23 Nov 2022 16:08:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v9 03/10] admin: introduce group administration commands
Message-ID: <20221123210706.21476-4-mst@redhat.com>
References: <20221123210706.21476-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20221123210706.21476-1-mst@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This introduces a general structure for group administration commands,
used to control device groups through their owner.

Following patches will introduce specific commands and an interface for
submitting these commands to the owner.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 admin.tex | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/admin.tex b/admin.tex
index 6ebdd05..1dca136 100644
--- a/admin.tex
+++ b/admin.tex
@@ -42,4 +42,102 @@ \section{Device groups}\label{sec:Basic Facilities of a Virtio Device / Device g
 PCI transport (see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus}).
 \end{description}
 
+\subsection{Group administration commands}\label{sec:Basic Facilities of a Virtio Device / Device groups / Group administration commands}
 
+Group administration commands can be issued through an owner
+device to control member devices of a group.  This mechanism can
+be used, for example, to configure a member device before it is
+initialized by its driver.
+
+All the group administration commands are of the following form:
+
+\begin{lstlisting}
+struct virtio_admin_cmd {
+        /* Device-readable part */
+        le16 opcode;
+        /*
+         * 1 - SR-IOV
+         * 2 - 65535 reserved
+         */
+        le16 group_type;
+        /* unused, reserved for future extensions */
+        u8 reserved1[12];
+        le64 group_member_id;
+        u8 command_specific_data[];
+
+        /* Device-writable part */
+        le16 status;
+        le16 status_qualifier;
+        /* unused, reserved for future extensions */
+        u8 reserved2[4];
+        u8 command_specific_result[];
+};
+\end{lstlisting}
+
+For all commands, \field{opcode}, \field{group_type} and if
+necessary \field{group_member_id} and \field{command_specific_data} are
+set by the driver, and the owner device sets \field{status} and if
+needed \field{status_qualifier} and
+\field{command_specific_result}.
+
+As a rule, any unused device-readable fields are set to zero by the driver
+and ignored by the device.  Any unused device-writeable fields are set to zero
+by the device and ignored by the driver.
+
+\field{opcode} specifies the command. The valid
+values for \field{opcode} can be found in the following table:
+
+\begin{tabular}{|l|l|}
+\hline
+opcode & Name & Command Description \\
+\hline \hline
+0x0000 - 0x7FFF & - &  Group administration commands    \\
+\hline
+0x8000 - 0xFFFF & - & Reserved    \\
+\hline
+\end{tabular}
+
+The \field{group_type} specifies the group type identifier.
+The \field{group_member_id} specifies the member identifier within the group.
+See section \ref{sec:Introduction / Terminology / Device group}
+for the definition of the group type identifier and group member
+identifier.
+
+The following table describes possible \field{status} values;
+to simplify common implementations, they are intentionally
+matching common Linux names and error numbers:
+
+\begin{tabular}{|l|l|l|}
+\hline
+Status (decimal) & Name & Description \\
+\hline \hline
+00   & VIRTIO_ADMIN_STATUS_OK    & successful completion  \\
+\hline
+22   & VIRTIO_ADMIN_STATUS_EINVAL    & invalid command \\
+\hline
+other   & -    & group administration command error  \\
+\hline
+\end{tabular}
+
+When \field{status} is VIRTIO_ADMIN_STATUS_OK, \field{status_qialifier}
+is reserved and set to zero by the device.
+
+When \field{status} is VIRTIO_ADMIN_STATUS_EINVAL,
+the following table describes possible \field{status_qialifier} values:
+\begin{tabular}{|l|l|l|}
+\hline
+Status & Name & Description \\
+\hline \hline
+0x00   & VIRTIO_ADMIN_STATUS_Q_INVALID_COMMAND   & command error: no additional information  \\
+\hline
+0x01   & VIRTIO_ADMIN_STATUS_Q_INVALID_OPCODE    & unsupported or invalid \field{opcode}  \\
+\hline
+0x02   & VIRTIO_ADMIN_STATUS_Q_INVALID_FIELD    & unsupported or invalid field within \field{command_specific_data}  \\
+\hline
+0x03   & VIRTIO_ADMIN_STATUS_Q_INVALID_GROUP    & unsupported or invalid \field{group_type} \\
+\hline
+0x04   & VIRTIO_ADMIN_STATUS_Q_INVALID_MEM    & unsupported or invalid \field{group_member_id} \\
+\hline
+0x05-0xFFFF   & -    & reserved for future use \\
+\hline
+\end{tabular}
-- 
MST

