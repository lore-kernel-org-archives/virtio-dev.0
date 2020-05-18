Return-Path: virtio-dev-return-7366-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 484AE985F4C
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 May 2020 20:38:37 +0000 (UTC)
From: Nikos Dragazis <ndragazis@arrikto.com>
Date: Mon, 18 May 2020 23:37:15 +0300
Message-Id: <20200518203721.7625-5-ndragazis@arrikto.com>
In-Reply-To: <20200518203721.7625-1-ndragazis@arrikto.com>
References: <20200518203721.7625-1-ndragazis@arrikto.com>
Subject: [virtio-dev] [PATCH v5 04/10] vhost-user: update shared memory capability
Content-Type: text/plain; charset=US-ASCII
To: virtio-dev@lists.oasis-open.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The virtio vhost-user device has shared memory resources. Therefore, it
uses the VIRTIO_PCI_CAP_SHARED_MEMORY_CFG capability to standardize
those resources through the PCI Configuration Space. This patch
synchronizes the virtio vhost-user device spec with the following shared
memory resources PATCH:

https://lists.oasis-open.org/archives/virtio-dev/201902/msg00142.html

Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
---
 virtio-vhost-user.tex | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
index 7a8cd9c..d1305dd 100644
--- a/virtio-vhost-user.tex
+++ b/virtio-vhost-user.tex
@@ -320,7 +320,22 @@ \subsubsection{Notification structure layout}\label{sec:Device Types / Vhost-use
 \subsubsection{Shared memory capability}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Shared Memory capability}
 
 The shared memory location is found using the VIRTIO_PCI_CAP_SHARED_MEMORY_CFG
-capability.
+capability. Using the additional \field{offset_hi} and \field{length_hi}
+fields following the SHARED_MEMORY_CFG capability structure, the shared
+memory region's 64-bit BAR offset is calculated as follows:
+
+\begin{lstlisting}
+        offset_hi << 32 + cap.offset
+\end{lstlisting}
+
+and the shared memory region's 64-bit length is calculated as follows:
+
+\begin{lstlisting}
+        length_hi << 32 + cap.length
+\end{lstlisting}
+
+The \field{cap.offset} and \field{cap.length} fields are taken from the
+SHARED_MEMORY_CFG capability structure.
 
 \devicenormative{\paragraph}{Shared Memory capability}{Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Shared Memory capability}
 The device MUST present exactly one shared memory capability.
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

