Return-Path: virtio-dev-return-7364-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 73304986065
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 May 2020 20:38:38 +0000 (UTC)
From: Nikos Dragazis <ndragazis@arrikto.com>
Date: Mon, 18 May 2020 23:37:18 +0300
Message-Id: <20200518203721.7625-8-ndragazis@arrikto.com>
In-Reply-To: <20200518203721.7625-1-ndragazis@arrikto.com>
References: <20200518203721.7625-1-ndragazis@arrikto.com>
Subject: [virtio-dev] [PATCH v5 07/10] vhost-user: minor fix on status register
Content-Type: text/plain; charset=US-ASCII
To: virtio-dev@lists.oasis-open.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Change the definitions of VIRTIO_VHOST_USER_STATUS_MASTER_UP and
VIRTIO_VHOST_USER_STATUS_SLAVE_UP so that they refer to different bits.
This is necessary because these two flags are orthogonal, i.e., they are
unrelated and so they must be set/cleared individually.

Mention explicitly who sets the VIRTIO_VHOST_USER_STATUS_MASTER_UP
status bit.

Fix typo:

VIRTIO_VHOST_USER_SLAVE_UP -> VIRTIO_VHOST_USER_STATUS_SLAVE_UP

Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
---
 virtio-vhost-user.tex | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/virtio-vhost-user.tex b/virtio-vhost-user.tex
index 29e7323..34f3126 100644
--- a/virtio-vhost-user.tex
+++ b/virtio-vhost-user.tex
@@ -42,13 +42,13 @@ \subsection{Feature bits}\label{sec:Device Types / Vhost-user Device Backend / F
 
 \subsection{Device configuration layout}\label{sec:Device Types / Vhost-user Device Backend / Device configuration layout}
 
-  All fields of this configuration are always available.
+All fields of this configuration are always available.
 
 \begin{lstlisting}
 struct virtio_vhost_user_config {
         le32 status;
-#define VIRTIO_VHOST_USER_STATUS_SLAVE_UP 0
-#define VIRTIO_VHOST_USER_STATUS_MASTER_UP 1
+#define VIRTIO_VHOST_USER_STATUS_SLAVE_UP (1 << 0)
+#define VIRTIO_VHOST_USER_STATUS_MASTER_UP (1 << 1)
         le32 max_vhost_queues;
         u8 uuid[16];
 };
@@ -62,8 +62,11 @@ \subsection{Device configuration layout}\label{sec:Device Types / Vhost-user Dev
     the vhost-user master to connect.  The vhost-user master cannot connect
     unless the driver has set this bit first.
 
-    When the driver clears VIRTIO_VHOST_USER_SLAVE_UP while the vhost-user
-    master is connected, the vhost-user master is disconnected.
+    The device sets VIRTIO_VHOST_USER_STATUS_MASTER_UP to indicate that the
+    vhost-user master is connected.
+
+    When the driver clears VIRTIO_VHOST_USER_STATUS_SLAVE_UP while the
+    vhost-user master is connected, the vhost-user master is disconnected.
 
     When the vhost-user master disconnects, both
     VIRTIO_VHOST_USER_STATUS_SLAVE_UP and VIRTIO_VHOST_USER_STATUS_MASTER_UP
@@ -99,7 +102,7 @@ \subsection{Device configuration layout}\label{sec:Device Types / Vhost-user Dev
 vhost-user slave programs to identify a specific device among many.
 
 The driver SHOULD place at least one buffer in rxq before setting the
-VIRTIO_VHOST_USER_SLAVE_UP bit in the \field{status} configuration field.
+VIRTIO_VHOST_USER_STATUS_SLAVE_UP bit in the \field{status} configuration field.
 
 The driver MUST handle rxq virtqueue notifications that occur before the
 configuration change notification.  It is possible that a vhost-user protocol
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

