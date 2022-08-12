Return-Path: <mst@redhat.com>
Date: Fri, 12 Aug 2022 13:19:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC v7 6/8] ccw: disallow ADMIN_VQ
Message-ID: <20220812171841.12183-7-mst@redhat.com>
References: <20220812171841.12183-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220812171841.12183-1-mst@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, eperezma@redhat.com, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 content.tex | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/content.tex b/content.tex
index 76b5a28..53be680 100644
--- a/content.tex
+++ b/content.tex
@@ -2668,6 +2668,16 @@ \subsubsection{Handling Device Features}\label{sec:Virtio Transport Options / Vi
 uses the CCW_CMD_WRITE_FEAT command, denoting a \field{features}/\field{index}
 combination.
 
+\devicenormative{\paragraph}{Handling Device Features}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Handling Device Features}
+
+Device MUST NOT set bit VIRTIO_F_ADMIN_VQ (bit 41) in
+DeviceFeatures.
+
+\drivernormative{\paragraph}{Handling Device Features}{Virtio Transport Options / Virtio over channel I/O / Device Initialization / Handling Device Features}
+
+Driver MUST NOT set bit VIRTIO_F_ADMIN_VQ (bit 41) in
+DriverFeatures even if offered by the device.
+
 \subsubsection{Device Configuration}\label{sec:Virtio Transport Options / Virtio over channel I/O / Device Initialization / Device Configuration}
 
 The device's configuration space is located in host memory.
-- 
MST

