Return-Path: virtio-dev-return-7368-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 240EF986136
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 May 2020 20:38:39 +0000 (UTC)
From: Nikos Dragazis <ndragazis@arrikto.com>
Date: Mon, 18 May 2020 23:37:20 +0300
Message-Id: <20200518203721.7625-10-ndragazis@arrikto.com>
In-Reply-To: <20200518203721.7625-1-ndragazis@arrikto.com>
References: <20200518203721.7625-1-ndragazis@arrikto.com>
Subject: [virtio-dev] [PATCH v5 09/10] vhost-user: intercept slave's reply to VHOST_USER_GET_PROTOCOL_FEATURES
Content-Type: text/plain; charset=US-ASCII
To: virtio-dev@lists.oasis-open.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
---
 virtio-vhost-user.tex | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
index a673526..328baec 100644
--- a/virtio-vhost-user.tex
+++ b/virtio-vhost-user.tex
@@ -142,10 +142,15 @@ \subsubsection{Device Operation: RX/TX Queues}\label{sec:Device Types / Vhost-us
 message that is too large for an rxq buffer, then DEVICE_NEEDS_RESET is set and
 the driver must reset the device.
 
-File descriptor passing is handled differently by the vhost-user device
-backend.  When a message is received that carries one or more file descriptors
-according to the vhost-user protocol, additional device resources become
-available to the driver.
+File descriptor passing is handled differently by the vhost-user device backend.
+When a master-initiated message is received that carries one or more file
+descriptors according to the vhost-user protocol, additional device resources
+become available to the driver.
+
+On the contrary, the slave cannot pass file descriptors to the master. For this
+reason, the vhost-user device backend MUST be intercepting the slave's reply to
+the VHOST_USER_GET_PROTOCOL_FEATURES vhost-user message and clearing these
+feature bits that allow the slave to send messages that pass file descriptors.
 
 \subsection{Additional Device Resources}\label{sec:Device Types / Vhost-user Device Backend / Additional Device Resources}
 
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

