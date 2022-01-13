Return-Path: <mgurtovoy@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 1/5] Add virtio Admin Virtqueue specification
Date: Thu, 13 Jan 2022 16:50:59 +0200
Message-ID: <20220113145103.26894-2-mgurtovoy@nvidia.com>
In-Reply-To: <20220113145103.26894-1-mgurtovoy@nvidia.com>
References: <20220113145103.26894-1-mgurtovoy@nvidia.com>
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
difficult to extend for device agnostic commands. Control virtqueue is
also limited to follow in order completion for the device which
negotiates VIRTIO_F_IN_ORDER feature. This feature limits the use of
control virtqueue for feature manipulation in out of order manner for
unrelated commands.

To support these requirements which overcome above two limitations in
elegant way, this patch introduces a new admin virtqueue. Admin
virtqueue will use the same command format for all types of virtio
devices.

Subsequent patches make use of this admin virtqueue.

Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 admin-virtq.tex | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 content.tex     |  9 +++++++--
 2 files changed, 56 insertions(+), 2 deletions(-)
 create mode 100644 admin-virtq.tex

diff --git a/admin-virtq.tex b/admin-virtq.tex
new file mode 100644
index 0000000..ad20f89
--- /dev/null
+++ b/admin-virtq.tex
@@ -0,0 +1,49 @@
+\section{Admin Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Admin Virtqueues}
+
+Admin virtqueue is used to send administrative commands to manipulate
+various features of the device which would not easily map into the
+configuration space.
+
+Use of Admin virtqueue is negotiated by the VIRTIO_F_ADMIN_VQ
+feature bit.
+
+Admin virtqueue index may vary among different device types.
+
+The Admin command set defines the commands that may be issued only to the admin
+virtqueue. Each virtio device that advertises the VIRTIO_F_ADMIN_VQ feature, MUST
+support all the mandatory admin commands. A device MAY support also one or more
+optional admin commands. All commands are of the following form:
+
+\begin{lstlisting}
+struct virtio_admin_cmd {
+        /* Device-readable part */
+        u8 command;
+        u8 command-specific-data[];
+
+        /* Device-writable part */
+        u8 status;
+        u8 command-specific-result[];
+};
+
+/* status values */
+#define VIRTIO_ADMIN_STATUS_OK 0
+#define VIRTIO_ADMIN_STATUS_ERR 1
+#define VIRTIO_ADMIN_STATUS_COMMAND_UNSUPPORTED 2
+\end{lstlisting}
+
+The \field{command} and \field{command-specific-data} are
+set by the driver, and the device sets the \field{status} and the
+\field{command-specific-result}, if needed.
+
+The following table describes the Admin command set:
+
+\begin{tabular}{|l|l|l|l|}
+\hline
+Opcode (bits) & Opcode (hex) & Command & M/O \\
+\hline \hline
+ -  & 00h - 7Fh   & Generic admin cmds    & -  \\
+\hline
+ -  & 80h - FFh   & Reserved    & - \\
+\hline
+\end{tabular}
+
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

