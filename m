Return-Path: virtio-dev-return-5682-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CC319985CB1
	for <virtio-dev@lists.oasis-open.org>; Tue, 23 Apr 2019 15:18:34 +0000 (UTC)
From: Nikos Dragazis <ndragazis@arrikto.com>
Date: Tue, 23 Apr 2019 18:18:17 +0300
Message-Id: <1556032699-22135-3-git-send-email-ndragazis@arrikto.com>
In-Reply-To: <1556032699-22135-1-git-send-email-ndragazis@arrikto.com>
References: <1556032699-22135-1-git-send-email-ndragazis@arrikto.com>
Subject: [virtio-dev] [PATCH 2/4] vhost-user: minor fixes
To: virtio-dev@lists.oasis-open.org
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Vangelis Koukis <vkoukis@arrikto.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
---
 virtio-vhost-user.tex | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
index 48be7e7..0bfc48d 100644
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

