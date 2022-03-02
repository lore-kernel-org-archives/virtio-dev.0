Return-Path: <virtio-comment-return-2773-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Date: Wed, 2 Mar 2022 17:56:05 +0200
Message-ID: <20220302155608.24189-3-mgurtovoy@nvidia.com>
In-Reply-To: <20220302155608.24189-1-mgurtovoy@nvidia.com>
References: <20220302155608.24189-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH v1 2/5] Introduce Admin Command Set
Content-Type: text/plain
To: virtio-comment@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com
Cc: parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This command set is used for essential administrative and management
operations such as identify and resource management.

Admin commands should be submitted to a well defined management
interface.

Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 admin.tex        | 129 +++++++++++++++++++++++++++++++++++++++++++++++
 content.tex      |   2 +
 introduction.tex |   2 +
 3 files changed, 133 insertions(+)
 create mode 100644 admin.tex

diff --git a/admin.tex b/admin.tex
new file mode 100644
index 0000000..1e30e01
--- /dev/null
+++ b/admin.tex
@@ -0,0 +1,129 @@
+\section{Admin command set}\label{sec:Basic Facilities of a Virtio Device / Admin command set}
+
+The Admin command set defines the commands that can be issued to a well defined management
+interface. All the Admin commands are of the following form:
+
+\begin{lstlisting}
+struct virtio_admin_cmd {
+        /* Device-readable part */
+        le16 command;
+        /*
+         * 0 - self
+         * 1 - 65535 are reserved
+         */
+        le16 dst_type;
+        /* reserved for common cmd fields */
+        u8 reserved[20];
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
+\end{tabular}
+
+The \field{command}, \field{dst_type} and \field{command_specific_data} are
+set by the driver, and the device sets the \field{status}, the
+\field{command_specific_error} and the \field{command_specific_result},
+if needed.
+
+Reserved common fields are ignored by the device and to be zeroed by the driver.
+
+The mandatory fields to be set by the driver, for all admin commands, are \field{command} and \field{dst_type}.
+
+The \field{command} defines the opcode for the command. The value for each command can be found in each command section.
+
+The \field{dst_type} defines the target virtio device for the command. This value should be set to 0 (self).
+
+The \field{command_specific_error} should be inspected by the driver only if \field{status} is set to
+VIRTIO_ADMIN_STATUS_CS_ERR by the device. In this case, the content of \field{command_specific_error}
+holds the command specific error. If \field{status} is not set to VIRTIO_ADMIN_STATUS_CS_ERR, the
+\field{command_specific_error} value is undefined.
+
+The following table describes the Admin command set:
+
+\begin{tabular}{|l|l|l|}
+\hline
+Opcode & Command & M/O \\
+\hline \hline
+0000h   & VIRTIO_ADMIN_DEVICE_IDENTIFY    & M  \\
+\hline
+0001h   & VIRTIO_ADMIN_SUBSYSTEM_IDENTIFY    & O  \\
+\hline
+0002h - 7FFFh   & Generic admin cmds    & -  \\
+\hline
+8000h - FFFFh   & Reserved    & - \\
+\hline
+\end{tabular}
+
+\subsection{VIRTIO ADMIN DEVICE IDENTIFY command}\label{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN DEVICE IDENTIFY command}
+
+The VIRTIO_ADMIN_DEVICE_IDENTIFY command has no command specific data set by the driver.
+The \field{command} is set to VIRTIO_ADMIN_DEVICE_IDENTIFY.
+Other common fields are reserved for this command and zeroed.
+
+This command upon success, returns a data buffer that describes information about the target virtio device.
+This returned data buffer is of form:
+\begin{lstlisting}
+struct virtio_admin_device_identify_result {
+       /* For compatibility - indicates which of the below fields were returned
+        * (1 means that field was returned):
+        * Bit 0 - vdev_id
+        * Bit 1 - optional_caps_support
+        * Bits 2 - 63 - reserved for future fields
+        */
+       le64 attrs_mask;
+       le64 vdev_id;
+       /* This field indicates which of the below optional admin
+        * capabilities are supported by the device:
+        * Bit 0 - if set, VIRTIO_ADMIN_SUBSYSTEM_IDENTIFY supported
+        * Bits 1 - 63 - reserved for future capabilities.
+        */
+       le64 optional_caps_support;
+       u8 reserved[4072];
+};
+\end{lstlisting}
+
+\subsection{VIRTIO ADMIN SUBSYSTEM IDENTIFY command}\label{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN SUBSYSTEM IDENTIFY command}
+
+The VIRTIO_ADMIN_SUBSYSTEM_IDENTIFY command has no command specific data set by the driver.
+The \field{command} is set to VIRTIO_ADMIN_SUBSYSTEM_IDENTIFY.
+Other common fields are reserved for this command and zeroed.
+
+This command upon success, returns a data buffer that describes information about the target virtio device subsystem.
+This returned data buffer is of form:
+\begin{lstlisting}
+struct virtio_admin_subsystem_identify_result {
+       /* For compatibility - indicates which of the below fields were returned
+        * (1 means that field was returned):
+        * Bit 0 - vqn
+        * Bit 1 - num_supported_vdevs
+        * Bit 2 - max_vdev_id
+        * Bits 3 - 63 - reserved for future fields
+        */
+       le64 attrs_mask;
+       u8 vqn[16];
+       /* Number of supported virtio devices by the subsystem */
+       le64 num_supported_vdevs;
+       /* Maximum value of a valid vdev_id for the subsystem */
+       le64 max_vdev_id;
+       u8 reserved[4056];
+};
+\end{lstlisting}
diff --git a/content.tex b/content.tex
index c6f116c..2e1df84 100644
--- a/content.tex
+++ b/content.tex
@@ -449,6 +449,8 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
 types. It is RECOMMENDED that devices generate version 4
 UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
 
+\input{admin.tex}
+
 \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
 
 We start with an overview of device initialization, then expand on the
diff --git a/introduction.tex b/introduction.tex
index 8e6611e..94dd7a2 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -258,5 +258,7 @@ \subsection{virtio subsystem}\label{sec:Introduction / Definitions / virtio subs
 
 The vdev_id value when combined with the VQN forms a globally unique value that identifies the virtio device.
 
+VQN and vdev_id are exposed via Admin Command Set.
+
 \newpage
 
-- 
2.21.0


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

