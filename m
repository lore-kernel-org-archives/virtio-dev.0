Return-Path: virtio-dev-return-7361-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7DCCC985F46
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 May 2020 20:38:36 +0000 (UTC)
From: Nikos Dragazis <ndragazis@arrikto.com>
Date: Mon, 18 May 2020 23:37:13 +0300
Message-Id: <20200518203721.7625-3-ndragazis@arrikto.com>
In-Reply-To: <20200518203721.7625-1-ndragazis@arrikto.com>
References: <20200518203721.7625-1-ndragazis@arrikto.com>
Subject: [virtio-dev] [PATCH v5 02/10] vhost-user: minor fixes
Content-Type: text/plain; charset=US-ASCII
To: virtio-dev@lists.oasis-open.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 virtio-vhost-user.tex | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
index ac96dc2..13ecd41 100644
--- a/virtio-vhost-user.tex
+++ b/virtio-vhost-user.tex
@@ -231,7 +231,7 @@ \subsubsection{Doorbell structure layout}\label{sec:Device Types / Vhost-user De
 \end{lstlisting}
 
 The \field{cap.offset} and \field{doorbell_off_multiplier} are taken from the
-notification capability structure above, and the \field{doorbell_idx} is the
+doorbell capability structure above, and the \field{doorbell_idx} is the
 doorbell number.
 
 \devicenormative{\paragraph}{Doorbell capability}{Device Types / Vhost-user Device Backend / Additional Device Resources over PCI / Doorbell capability}
@@ -260,7 +260,7 @@ \subsubsection{Notification structure layout}\label{sec:Device Types / Vhost-use
 notification interrupts.  If MSI-X is not available, bit 2 of the ISR status
 indicates that a notification occurred.
 
-The notification structure is found using the VIRTIO_PCI_CAP_DOORBELL_CFG
+The notification structure is found using the VIRTIO_PCI_CAP_NOTIFICATION_CFG
 capability.
 
 \begin{lstlisting}
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

