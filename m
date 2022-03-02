Return-Path: <mgurtovoy@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v1 1/5] virtio: Introduce virtio subsystem
Date: Wed, 2 Mar 2022 17:56:04 +0200
Message-ID: <20220302155608.24189-2-mgurtovoy@nvidia.com>
In-Reply-To: <20220302155608.24189-1-mgurtovoy@nvidia.com>
References: <20220302155608.24189-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
To: virtio-comment@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com
Cc: parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

A virtio subsystem may contain one or more virtio devices. All of the
devices that make up a virtio subsystem share the same virtio subsystem
unique identifier. This identifier is the virtio qualified name (VQN).
Each device within a virtio subsystem has a unique identifier. This
identifier is the virtio device id (vdev_id). The combination of these
identifiers forms a globally unique value identifies a virtio device.

Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 introduction.tex | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/introduction.tex b/introduction.tex
index 6d52717..8e6611e 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -240,5 +240,23 @@ \section{Constant Specifications}
 refer to values 1 and 2 of Fld respectively. Further, VIRTIO_FLD_XXX refers to
 either VIRTIO_FLD_A or VIRTIO_FLD_B.
 
+\section{Definitions}\label{sec:Introduction / Definitions}
+
+\subsection{virtio device}\label{sec:Introduction / Definitions / virtio device}
+
+An entity that implements virtio specification.
+
+\subsection{virtio subsystem}\label{sec:Introduction / Definitions / virtio subsystem}
+
+A virtio subsystem includes one or more virtio devices.
+Each virtio subsystem has a unique virtio qualified name (VQN) that is permanent for the lifetime of the virtio subsystem.
+The VQN is a 128-bit UUID. It is RECOMMENDED to use UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
+Virtio devices within one virtio subsystem share the same VQN. Each virtio device has a unique virtio
+device id (vdev_id) within a virtio subsystem. A valid vdev_id is a 64-bit field in the range of
+0x0 - 0xFFFFFFFFFFFFFFF0. Vdev_id 0xFFFFFFFFFFFFFFFF is a broadcast value that is used to specify all the
+virtio devices in a virtio subsystem and isn't a valid vdev_id.
+
+The vdev_id value when combined with the VQN forms a globally unique value that identifies the virtio device.
+
 \newpage
 
-- 
2.21.0

