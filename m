Return-Path: <mst@redhat.com>
Date: Wed, 23 Nov 2022 16:08:34 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH RFC v9 10/10] ccw: document more reserved features
Message-ID: <20221123210706.21476-11-mst@redhat.com>
References: <20221123210706.21476-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20221123210706.21476-1-mst@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

vq reset and shared memory are unsupported, too.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---


This is not strictly part of this patchset, but just to
give you the idea of how we can expand this down the road.

 content.tex | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/content.tex b/content.tex
index 6c3758d..bfcf9fe 100644
--- a/content.tex
+++ b/content.tex
@@ -2983,6 +2983,8 @@ \subsection{Features reserved for future use}\label{sec:Virtio Transport Options
 \begin{itemize}
 
 \item VIRTIO_F_ADMIN_VQ
+\item VIRTIO_F_RING_RESET
+\item Shared memory regions including VIRTIO_PMEM_F_SHMEM_REGION
 
 \end{itemize}
 
-- 
MST

