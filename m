Return-Path: <mgurtovoy@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH v2 3/4] virtio-net: add support for VIRTIO_F_ADMIN_VQ
Date: Mon, 24 Jan 2022 11:39:17 +0200
Message-ID: <20220124093918.34371-4-mgurtovoy@nvidia.com>
In-Reply-To: <20220124093918.34371-1-mgurtovoy@nvidia.com>
References: <20220124093918.34371-1-mgurtovoy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
To: virtio-comment@lists.oasis-open.org, mst@redhat.com, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, jasowang@redhat.com
Cc: parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Set the relevant index in case of VIRTIO_F_ADMIN_VQ negotiation.

Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
---
 content.tex | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/content.tex b/content.tex
index f5f95fb..18a5c66 100644
--- a/content.tex
+++ b/content.tex
@@ -3033,6 +3033,7 @@ \subsection{Virtqueues}\label{sec:Device Types / Network Device / Virtqueues}
 \item[2(N-1)] receiveqN
 \item[2(N-1)+1] transmitqN
 \item[2N] controlq
+\item[2N + 1] adminq (or \textbf{2N} in case VIRTIO_NET_F_CTRL_VQ is not set)
 \end{description}
 
  N=1 if neither VIRTIO_NET_F_MQ nor VIRTIO_NET_F_RSS are negotiated, otherwise N is set by
@@ -3040,6 +3041,8 @@ \subsection{Virtqueues}\label{sec:Device Types / Network Device / Virtqueues}
 
  controlq only exists if VIRTIO_NET_F_CTRL_VQ set.
 
+ adminq only exists if VIRTIO_F_ADMIN_VQ set.
+
 \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits}
 
 \begin{description}
-- 
2.21.0

