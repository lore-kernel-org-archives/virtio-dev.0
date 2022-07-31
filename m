Return-Path: <mgurtovoy@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v6 2/5] Introduce admin command set
Date: Sun, 31 Jul 2022 18:43:51 +0300
Message-ID: <20220731154354.15698-3-mgurtovoy@nvidia.com>
In-Reply-To: <20220731154354.15698-1-mgurtovoy@nvidia.com>
References: <20220731154354.15698-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
To: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, virtio-dev@lists.oasis-open.org
Cc: oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org, eperezma@redhat.com, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This command set is used for essential administrative and management
operations.

Admin commands should be submitted to a well defined management
interface.

Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 admin.tex   | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 content.tex |  2 ++
 2 files changed, 84 insertions(+)
 create mode 100644 admin.tex

diff --git a/admin.tex b/admin.tex
new file mode 100644
index 0000000..d14f8f7
--- /dev/null
+++ b/admin.tex
@@ -0,0 +1,82 @@
+\section{Administration command set}\label{sec:Basic Facilities of a Virtio Device / Administration command set}
+
+The Administration command set (also known as Admin command set) defines the commands that can be issued using a management interface.
+This mechanism, for example, can be used by a system administrator that wants to configure a device before it is initialized by its driver.
+
+All the Admin commands are of the following form:
+
+\begin{lstlisting}
+struct virtio_admin_cmd {
+        /* Device-readable part */
+        le16 command;
+        /*
+         * 0 - Self
+         * 1 - SR-IOV
+         * 2 - 65535 are reserved
+         */
+        le16 group_id;
+        le64 group_member_id;
+        /* reserved for common cmd fields */
+        u8 reserved[12];
+        u8 command_specific_data[];
+
+        /* Device-writable part */
+        u8 status;
+        u8 command_specific_error;
+        u8 command_specific_result[];
+};
+\end{lstlisting}
+
+The following table describes the generic Admin status codes:
+
+\begin{tabular}{|l|l|l|}
+\hline
+Opcode & Status & Description \\
+\hline \hline
+00h   & VIRTIO_ADMIN_STATUS_OK    & successful completion  \\
+\hline
+01h   & VIRTIO_ADMIN_STATUS_CS_ERR    & command specific error  \\
+\hline
+02h   & VIRTIO_ADMIN_STATUS_COMMAND_UNSUPPORTED    & unsupported or invalid opcode  \\
+\hline
+03h   & VIRTIO_ADMIN_STATUS_INVALID_FIELD    & invalid field was set  \\
+\hline
+04h   & VIRTIO_ADMIN_STATUS_INVALID_GROUP    & invalid group identifier was set  \\
+\hline
+05h   & VIRTIO_ADMIN_STATUS_INVALID_MEM    & invalid group member identifier was set  \\
+\hline
+\end{tabular}
+
+The \field{command}, \field{group_id}, \field{group_member_id} and \field{command_specific_data} are
+set by the driver, and the device sets the \field{status}, the
+\field{command_specific_error} and the \field{command_specific_result},
+if needed.
+
+Reserved common fields are ignored by the device and to be zeroed by the driver.
+
+The mandatory fields to be set by the driver, for all admin commands, are the \field{command}, \field{group_id} and \field{group_member_id}.
+
+The optional unused fields to be zeroed by the driver.
+
+The \field{command} defines the opcode for the command. The value for each command can be found in each command section.
+
+The \field{group_id} defines the designated device group for the command.
+The \field{group_member_id} defines the designated device within the device group for the command.
+See section \ref{sec:Introduction / Terminology / Device group} for group identifier and group member identifier numbering for various device groups.
+
+The \field{command_specific_error} should be inspected by the driver only if \field{status} is set to
+VIRTIO_ADMIN_STATUS_CS_ERR by the device. In this case, the content of \field{command_specific_error}
+holds the command specific error. If \field{status} is not set to VIRTIO_ADMIN_STATUS_CS_ERR, the
+\field{command_specific_error} value is undefined and should be ignored by the driver.
+
+The following table describes the Admin command set:
+
+\begin{tabular}{|l|l|}
+\hline
+Opcode & Command \\
+\hline \hline
+0000h - 7FFFh   & Generic admin cmds    \\
+\hline
+8000h - FFFFh   & Reserved    \\
+\hline
+\end{tabular}
diff --git a/content.tex b/content.tex
index 7508dd1..caab298 100644
--- a/content.tex
+++ b/content.tex
@@ -449,6 +449,8 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
 types. It is RECOMMENDED that devices generate version 4
 UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
 
+\input{admin.tex}
+
 \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
 
 We start with an overview of device initialization, then expand on the
-- 
2.21.0

