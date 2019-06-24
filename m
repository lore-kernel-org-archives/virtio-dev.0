Return-Path: virtio-dev-return-5805-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2D1ED985AF7
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 Jun 2019 23:30:07 +0000 (UTC)
From: Nikos Dragazis <ndragazis@arrikto.com>
Date: Tue, 25 Jun 2019 02:29:54 +0300
Message-Id: <1561418997-24608-3-git-send-email-ndragazis@arrikto.com>
In-Reply-To: <1561418997-24608-1-git-send-email-ndragazis@arrikto.com>
References: <1561418997-24608-1-git-send-email-ndragazis@arrikto.com>
Subject: [virtio-dev] [PATCH v4 2/5] vhost-user: minor fixes
To: virtio-dev@lists.oasis-open.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Vangelis Koukis <vkoukis@arrikto.com>
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
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

