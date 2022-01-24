Return-Path: <mgurtovoy@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v2 1/4] Add virtio Admin Virtqueue
Date: Mon, 24 Jan 2022 11:39:15 +0200
Message-ID: <20220124093918.34371-2-mgurtovoy@nvidia.com>
In-Reply-To: <20220124093918.34371-1-mgurtovoy@nvidia.com>
References: <20220124093918.34371-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
To: virtio-comment@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com
Cc: parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

In one of the many use cases a user wants to manipulate features and
configuration of the virtio devices regardless of the device type
(net/block/console). Some of this configuration is generic enough. i.e
Number of MSI-X vectors of a virtio PCI VF device. There is a need to do
such features query and manipulation by its parent PCI PF.

Currently virtio specification defines control virtqueue to manipulate
features and configuration of the device it operates on. However,
control virtqueue commands are device type specific, which makes it very
difficult to extend for device agnostic commands.

To support this requirement in elegant way, this patch introduces a new
admin virtqueue. Admin virtqueue will use the same command format for all
types of virtio devices.

Manipulate features via admin virtqueue is asynchronous, scalable, easy
to extend and doesn't require additional and expensive on-die resources
to be allocated for every new feature that will be added in the future.

Subsequent patches make use of this admin virtqueue.

Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 admin-virtq.tex | 89 +++++++++++++++++++++++++++++++++++++++++++++++++
 content.tex     |  9 +++--
 2 files changed, 96 insertions(+), 2 deletions(-)
 create mode 100644 admin-virtq.tex

diff --git a/admin-virtq.tex b/admin-virtq.tex
new file mode 100644
index 0000000..1a41c22
--- /dev/null
+++ b/admin-virtq.tex
@@ -0,0 +1,89 @@
+\section{Admin Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Admin Virtqueues}
+
+Admin virtqueue is used to send administrative commands to manipulate
+various features of the device and/or to manipulate various features,
+if possible, of another device within the same group (e.g. PCI VFs of
+a parent PCI PF device are grouped together. These devices can be
+optionally managed by its parent PCI PF using its admin virtqueue.).
+
+Use of Admin virtqueue is negotiated by the VIRTIO_F_ADMIN_VQ
+feature bit.
+
+Admin virtqueue index may vary among different device types.
+
+Regardless of device offering VIRTIO_F_IN_ORDER, admin queue command buffers
+are used by the device in out of order manner.
+
+The Admin command set defines the commands that may be issued only to the admin
+virtqueue. Each virtio device that advertises the VIRTIO_F_ADMIN_VQ feature, MUST
+support all the mandatory admin commands. A device MAY support also one or more
+optional admin commands. All commands are of the following form:
+
+\begin{lstlisting}
+struct virtio_admin_cmd {
+        /* Device-readable part */
+        u16 command;
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
+\end{tabular}
+
+The \field{command} and \field{command_specific_data} are
+set by the driver, and the device sets the \field{status}, the
+\field{command_specific_error} and the \field{command_specific_result},
+if needed.
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
+0000h   & VIRTIO_ADMIN_CAPS_IDENTIFY    & M  \\
+\hline
+0001h - 7FFFh   & Generic admin cmds    & -  \\
+\hline
+8000h - FFFFh   & Reserved    & - \\
+\hline
+\end{tabular}
+
+\subsection{VIRTIO ADMIN CAPS IDENTIFY command}\label{sec:Basic Facilities of a Virtio Device / Admin Virtqueues / VIRTIO ADMIN CAPS IDENTIFY command}
+
+The VIRTIO_ADMIN_CAPS_IDENTIFY command has no command specific data set by the driver.
+This command upon success, returns a data buffer that describes information about the supported
+admin capabilities by the device. This information is of form:
+\begin{lstlisting}
+struct virtio_admin_caps_identify_result {
+       /*
+        * caps[0] - Bit 0x0 - Bit 0x7 are reserved
+        * caps[1] - Bit 0x0 - Bit 0x7 are reserved
+        * caps[2] - Bit 0x0 - Bit 0x7 are reserved
+        * ....
+        * caps[8191] - Bit 0x0 - Bit 0x7 are reserved
+        */
+       u8 caps[8192];
+};
+\end{lstlisting}
diff --git a/content.tex b/content.tex
index 32de668..c524fab 100644
--- a/content.tex
+++ b/content.tex
@@ -99,10 +99,10 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
 \begin{description}
 \item[0 to 23] Feature bits for the specific device type
 
-\item[24 to 40] Feature bits reserved for extensions to the queue and
+\item[24 to 41] Feature bits reserved for extensions to the queue and
   feature negotiation mechanisms
 
-\item[41 and above] Feature bits reserved for future extensions.
+\item[42 and above] Feature bits reserved for future extensions.
 \end{description}
 
 \begin{note}
@@ -449,6 +449,8 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
 types. It is RECOMMENDED that devices generate version 4
 UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
 
+\input{admin-virtq.tex}
+
 \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
 
 We start with an overview of device initialization, then expand on the
@@ -6847,6 +6849,9 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
   that the driver can reset a queue individually.
   See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}.
 
+  \item[VIRTIO_F_ADMIN_VQ (41)] This feature indicates that
+  the device supports administration virtqueue negotiation.
+
 \end{description}
 
 \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
-- 
2.21.0

