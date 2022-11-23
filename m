Return-Path: <mst@redhat.com>
Date: Wed, 23 Nov 2022 16:08:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v9 04/10] admin: introduce virtio admin virtqueues
Message-ID: <20221123210706.21476-5-mst@redhat.com>
References: <20221123210706.21476-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20221123210706.21476-1-mst@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The admin virtqueues will be the first interface to issue admin commands.

Currently virtio specification defines control virtqueue to manipulate
features and configuration of the device it operates on. However,
control virtqueue commands are device type specific, which makes it very
difficult to extend for device agnostic commands.

To support this requirement in a more generic way, this patch introduces
a new admin virtqueue interface.

We also support more than one admin virtqueue, for QoS and
scalability requirements.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 admin.tex   | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 content.tex |  7 +++++--
 2 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/admin.tex b/admin.tex
index 1dca136..eeccd2e 100644
--- a/admin.tex
+++ b/admin.tex
@@ -141,3 +141,57 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 0x05-0xFFFF   & -    & reserved for future use \\
 \hline
 \end{tabular}
+
+\section{Administration Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Administration Virtqueues}
+
+An administration virtqueue of an owner device is used to submit
+group administration commands. An owner device can have more
+than one administration virtqueue.
+
+If VIRTIO_F_ADMIN_VQ has been negotiated, an owner device exposes one
+or more adminstration virtqueues. The number and locations of the
+administration virtqueues are exposed by the owner device in a transport
+specific manner.
+
+The driver submits commands by queueing them to an arbitrary
+administration virtqueue, and they are processed by the
+device in the order in which they are queued. It is the
+responsibility of the driver to ensure ordering for commands
+placed on different administration virtqueues, because they will
+be executed with no order constraints.
+
+Administration virtqueues are used as follows:
+\begin{itemize}
+\item The driver submits the command using the \field{struct virtio_admin_cmd}
+structure using two buffers: a device-readable one followed by a
+device-writable one.
+\item the device-readable buffer includes fields from \field{opcode}
+through \field{command_specific_data}.
+\item the device-writeable buffer includes fields from \field{status}
+through \field{command_specific_result} inclusive.
+\end{itemize}
+
+It is legal for the driver to submit commands with
+device-writeable and device-readable structures with buffer
+length both shorter or longer than the length of the
+\field{command_specific_data} structure described in this
+specification. The device silently truncates the structures
+to either the length submitted by the driver, or the length
+described in this specification, whichever is shorter.
+The device silently ignores any data falling outside
+the shorter of the two lengths. Any missing fields are assumed to be
+set to zero.
+
+Similarly, it is legal for the device to use, for a specific
+command, a shorter part of the \field{command_specific_result}
+buffer than the length of the structure described in this
+specification. The driver silently ignores any data falling outside
+the used buffer length reported by the device.  Any missing
+fields are assumed to be set to zero.
+
+This simplifies driver implementations since the driver can
+simply maintain a single large C structure for a command and its
+result. As new versions of the specification are designed,
+new fields can be added to the tail of a structure,
+with the driver using the full structure without concern
+for versioning.
diff --git a/content.tex b/content.tex
index 3f3585d..04235da 100644
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
@@ -6990,6 +6990,9 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
   that the driver can reset a queue individually.
   See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}.
 
+  \item[VIRTIO_F_ADMIN_VQ(41)] This feature indicates that the device exposes one or more
+  administration virtqueues.
+
 \end{description}
 
 \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
-- 
MST

