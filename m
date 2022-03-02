Return-Path: <mgurtovoy@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v1 4/5] Add virtio Admin virtqueue
Date: Wed, 2 Mar 2022 17:56:07 +0200
Message-ID: <20220302155608.24189-5-mgurtovoy@nvidia.com>
In-Reply-To: <20220302155608.24189-1-mgurtovoy@nvidia.com>
References: <20220302155608.24189-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
To: virtio-comment@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com
Cc: parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

In one of the many use cases a user wants to manipulate features and
configuration of the virtio devices regardless of the device type
(net/block/console). Some of this configuration is generic enough. i.e
Number of MSI-X vectors of a virtio PCI VF device. There is a need to do
such features query and manipulation by its parent PCI PF. For that the
Admin Command Set introduced. The Admin virtqueue will be the first
management interface to issue Admin commands.

Currently virtio specification defines control virtqueue to manipulate
features and configuration of the device it operates on. However,
control virtqueue commands are device type specific, which makes it very
difficult to extend for device agnostic commands.

To support this requirement in elegant way, this patch introduces a new
admin virtqueue interface.

Manipulate features via admin virtqueue is asynchronous, scalable, easy
to extend and doesn't require additional and expensive on-die resources
to be allocated for every new feature that will be added in the future.

Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 admin.tex       | 17 +++++++++++++++++
 conformance.tex |  1 +
 content.tex     |  6 ++++--
 3 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/admin.tex b/admin.tex
index 9a8969b..ed9f6bd 100644
--- a/admin.tex
+++ b/admin.tex
@@ -158,3 +158,20 @@ \subsection{VIRTIO ADMIN DEVICE INFO command}\label{sec:Basic Facilities of a Vi
 specification and can't be equal to zero. If bit 0 is not set, the driver will ignore \field{vf_number}.}
 \end{note}
 
+\section{Admin Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Admin Virtqueues}
+
+An admin virtqueue is a management interface of a device that can be used to send administrative
+commands to manipulate various features of the device and/or to manipulate
+various features, if possible, of another device within the same virtio subsystem
+(see \ref{sec:Introduction / Definitions / virtio subsystem}).
+
+An admin virtqueue exists for a certain device if VIRTIO_F_ADMIN_VQ is
+negotiated. The index of the admin virtqueue is exposed by the device in a
+transport specific manner.
+
+If VIRTIO_F_ADMIN_VQ has been negotiated, the driver will use the admin virtqueue to send all admin commands.
+
+\devicenormative{\subsection}{Admin Virtqueues}{Basic Facilities of a Virtio Device / Admin Virtqueues}
+A device that advertises VIRTIO_F_ADMIN_VQ capability MUST support all the mandatory admin commands.
+
+A device that advertises VIRTIO_F_ADMIN_VQ capability MAY support one or more optional admin commands.
diff --git a/conformance.tex b/conformance.tex
index 42f8537..129831c 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -341,6 +341,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{devicenormative:Basic Facilities of a Virtio Device / Virtqueues / Available Buffer Notification Suppression}
 \item \ref{devicenormative:Basic Facilities of a Virtio Device / Shared Memory Regions}
 \item \ref{devicenormative:Reserved Feature Bits}
+\item \ref{devicenormative:Basic Facilities of a Virtio Device / Admin Virtqueues}
 \end{itemize}
 
 \conformance{\subsection}{PCI Device Conformance}\label{sec:Conformance / Device Conformance / PCI Device Conformance}
diff --git a/content.tex b/content.tex
index 2e1df84..163cb34 100644
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
@@ -6849,6 +6849,8 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
   that the driver can reset a queue individually.
   See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}.
 
+  \item[VIRTIO_F_ADMIN_VQ (41)] This feature indicates that an administration virtqueue is supported.
+
 \end{description}
 
 \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
-- 
2.21.0

