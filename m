Return-Path: <mgurtovoy@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v3 1/4] Add virtio Admin virtqueue
Date: Thu, 3 Feb 2022 09:57:13 +0200
Message-ID: <20220203075716.11684-2-mgurtovoy@nvidia.com>
In-Reply-To: <20220203075716.11684-1-mgurtovoy@nvidia.com>
References: <20220203075716.11684-1-mgurtovoy@nvidia.com>
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
admin virtqueue interface. Admin virtqueue is proposed as one of the
interfaces to issue admin commands that have the same command format for
all type of virtio devices.

Manipulate features via admin virtqueue is asynchronous, scalable, easy
to extend and doesn't require additional and expensive on-die resources
to be allocated for every new feature that will be added in the future.

Subsequent patches make use of this admin virtqueue.

Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 admin.tex       | 94 +++++++++++++++++++++++++++++++++++++++++++++++++
 conformance.tex |  1 +
 content.tex     |  8 +++--
 3 files changed, 101 insertions(+), 2 deletions(-)
 create mode 100644 admin.tex

diff --git a/admin.tex b/admin.tex
new file mode 100644
index 0000000..fa9c993
--- /dev/null
+++ b/admin.tex
@@ -0,0 +1,94 @@
+\section{Admin Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Admin Virtqueues}
+
+Admin virtqueue is one of the management interface that used to send administrative
+commands to manipulate various features of the device and/or to manipulate
+various features, if possible, of another device within the same group (e.g. PCI VFs
+of a parent PCI PF device are grouped together. These devices can be optionally
+managed by its parent PCI PF using its admin virtqueue.).
+
+An admin virtqueue exists for a certain device if VIRTIO_F_ADMIN_VQ is
+negotiated. The index of the admin virtqueue exposed by the device in a
+transport specific manner.
+
+When VIRTIO_F_ADMIN_VQ is negotiated with the device, driver will send all admin commands
+through the admin virtqueue.
+
+\section{Admin command set}\label{sec:Basic Facilities of a Virtio Device / Admin command set}
+
+The Admin command set defines the commands that can be issued to a well defined management
+interface, such as the admin virtqueue. All commands are of the following form:
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
+\devicenormative{\subsection}{Admin command set}{Basic Facilities of a Virtio Device / Admin command set}
+A device that advertises VIRTIO_F_ADMIN_VQ capability MUST support all the mandatory admin commands.
+
+A device that advertises VIRTIO_F_ADMIN_VQ capability MAY support one or more optional admin commands.
+
+
+\subsection{VIRTIO ADMIN CAPS IDENTIFY command}\label{sec:Basic Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN CAPS IDENTIFY command}
+
+The VIRTIO_ADMIN_CAPS_IDENTIFY command has no command specific data set by the driver.
+This command upon success, returns a data buffer that describes information about the supported
+admin capabilities by the device. This information is of form:
+\begin{lstlisting}
+struct virtio_admin_caps_identify_result {
+       /*
+        * caps[0] - Bit 0 - Bit 7 are reserved
+        * caps[1] - Bit 0 - Bit 7 are reserved
+        * caps[2] - Bit 0 - Bit 7 are reserved
+        * ....
+        * caps[8191] - Bit 0 - Bit 7 are reserved
+        */
+       u8 caps[8192];
+};
+\end{lstlisting}
diff --git a/conformance.tex b/conformance.tex
index 42f8537..2e5d7e0 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -341,6 +341,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{devicenormative:Basic Facilities of a Virtio Device / Virtqueues / Available Buffer Notification Suppression}
 \item \ref{devicenormative:Basic Facilities of a Virtio Device / Shared Memory Regions}
 \item \ref{devicenormative:Reserved Feature Bits}
+\item \ref{devicenormative:Basic Facilities of a Virtio Device / Admin command set}
 \end{itemize}
 
 \conformance{\subsection}{PCI Device Conformance}\label{sec:Conformance / Device Conformance / PCI Device Conformance}
diff --git a/content.tex b/content.tex
index c6f116c..163cb34 100644
--- a/content.tex
+++ b/content.tex
@@ -99,10 +99,10 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
 \begin{description}
 \item[0 to 23, and 50 to 127] Feature bits for the specific device type
 
-\item[24 to 40] Feature bits reserved for extensions to the queue and
+\item[24 to 41] Feature bits reserved for extensions to the queue and
   feature negotiation mechanisms
 
-\item[41 to 49, and 128 and above] Feature bits reserved for future extensions.
+\item[42 to 49, and 128 and above] Feature bits reserved for future extensions.
 \end{description}
 
 \begin{note}
@@ -449,6 +449,8 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
 types. It is RECOMMENDED that devices generate version 4
 UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
 
+\input{admin.tex}
+
 \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
 
 We start with an overview of device initialization, then expand on the
@@ -6847,6 +6849,8 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
   that the driver can reset a queue individually.
   See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}.
 
+  \item[VIRTIO_F_ADMIN_VQ (41)] This feature indicates that an administration virtqueue is supported.
+
 \end{description}
 
 \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
-- 
2.21.0

