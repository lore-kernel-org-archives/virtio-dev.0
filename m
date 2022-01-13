Return-Path: <mgurtovoy@nvidia.com>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
Subject: [PATCH 4/5] virtio-net: add support for VIRTIO_F_ADMIN_VQ
Date: Thu, 13 Jan 2022 16:51:02 +0200
Message-ID: <20220113145103.26894-5-mgurtovoy@nvidia.com>
In-Reply-To: <20220113145103.26894-1-mgurtovoy@nvidia.com>
References: <20220113145103.26894-1-mgurtovoy@nvidia.com>
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
index 0ae4b68..e9c2383 100644
--- a/content.tex
+++ b/content.tex
@@ -3034,6 +3034,7 @@ \subsection{Virtqueues}\label{sec:Device Types / Network Device / Virtqueues}
 \item[2(N-1)] receiveqN
 \item[2(N-1)+1] transmitqN
 \item[2N] controlq
+\item[2N + 1] adminq (or \textbf{2N} in case VIRTIO_NET_F_CTRL_VQ is not set)
 \end{description}
 
  N=1 if neither VIRTIO_NET_F_MQ nor VIRTIO_NET_F_RSS are negotiated, otherwise N is set by
@@ -3041,6 +3042,8 @@ \subsection{Virtqueues}\label{sec:Device Types / Network Device / Virtqueues}
 
  controlq only exists if VIRTIO_NET_F_CTRL_VQ set.
 
+ adminq only exists if VIRTIO_F_ADMIN_VQ set.
+
 \subsection{Feature bits}\label{sec:Device Types / Network Device / Feature bits}
 
 \begin{description}
-- 
2.21.0

