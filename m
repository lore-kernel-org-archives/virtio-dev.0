Return-Path: <mst@redhat.com>
Date: Fri, 12 Aug 2022 13:19:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC v7 3/8] Introduce virtio admin virtqueue
Message-ID: <20220812171841.12183-4-mst@redhat.com>
References: <20220812171841.12183-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220812171841.12183-1-mst@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, eperezma@redhat.com, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

From: Max Gurtovoy <mgurtovoy@nvidia.com>

In one of the many use cases a user wants to manipulate features and
configuration of the virtio devices regardless of the device type
(net/block/console). For that the admin command set introduced. The
admin virtqueue will be the first management interface to issue admin
commands.

Currently virtio specification defines control virtqueue to manipulate
features and configuration of the device it operates on. However,
control virtqueue commands are device type specific, which makes it very
difficult to extend for device agnostic commands.

To support this requirement in elegant way, this patch introduces a new
admin virtqueue interface.

Manipulate features via admin virtqueue is asynchronous, scalable, easy
to extend and doesn't require additional and expensive on-die resources
to be allocated for every new feature that will be added in the future.

Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 admin.tex   | 9 +++++++++
 content.tex | 6 ++++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/admin.tex b/admin.tex
index 4840dd4..a0008c7 100644
--- a/admin.tex
+++ b/admin.tex
@@ -136,3 +136,12 @@ \subsection{Group administration commands}\label{sec:Basic Facilities of a Virti
 holds the command specific error. If \field{status} is not set to VIRTIO_ADMIN_STATUS_CS_ERR, the
 \field{command_specific_error} value is undefined and should be ignored by the driver.
 
+\section{Administration Virtqueue}\label{sec:Basic Facilities of a Virtio Device / Group Administration Virtqueues}
+
+An administration virtqueue of a parent device is used to submit
+group administration commands.
+
+An administration virtqueue exists for a certain parent device if
+VIRTIO_F_ADMIN_VQ feature has been negotiated. The index of the
+administration virtqueue is exposed by the parent device in a
+transport specific manner.
diff --git a/content.tex b/content.tex
index 6e26dff..6ce1c07 100644
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
@@ -6946,6 +6946,8 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
   that the driver can reset a queue individually.
   See \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}.
 
+  \item[VIRTIO_F_ADMIN_VQ (41)] This feature indicates that an administration virtqueue is supported.
+
 \end{description}
 
 \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
-- 
MST

