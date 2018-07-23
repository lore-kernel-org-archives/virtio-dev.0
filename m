Return-Path: virtio-dev-return-4730-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 79E1B985C77
	for <virtio-dev@lists.oasis-open.org>; Mon, 23 Jul 2018 17:02:45 +0000 (UTC)
From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Mon, 23 Jul 2018 10:02:35 -0700
Message-Id: <1532365355-45245-1-git-send-email-sridhar.samudrala@intel.com>
Subject: [virtio-dev] [PATCH v2] content: Introduce VIRTIO_NET_F_STANDBY feature
To: mst@redhat.com, cohuck@redhat.com, virtio-dev@lists.oasis-open.org
Cc: Sridhar@lists.oasis-open.org, "Samudrala <sridhar.samudrala"@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

VIRTIO_NET_F_STANDBY feature enables hypervisor to indicate virtio_net
device to act as a standby for a primary device with the same MAC address.

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com
---
 content.tex | 8 ++++++++
 1 file changed, 8 insertions(+)

v2: updated standby description based on Cornelia's feedback.

diff --git a/content.tex b/content.tex
index be18234..b729857 100644
--- a/content.tex
+++ b/content.tex
@@ -2525,6 +2525,9 @@ features.
 
 \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
     channel.
+
+\item[VIRTIO_NET_F_STANDBY(62)] Device MAY act as a standby for a primary
+    device with the same MAC
 \end{description}
 
 \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device / Feature bits / Feature bit requirements}
@@ -2636,6 +2639,11 @@ If the driver negotiates VIRTIO_NET_F_MTU, it MUST NOT transmit packets of
 size exceeding the value of \field{mtu} (plus low level ethernet header length)
 with \field{gso_type} NONE or ECN.
 
+A driver SHOULD negotiate VIRTIO_NET_F_STANDBY feature if the device offers it.
+
+If the driver negotiates VIRTIO_NET_F_STANDBY, the device MAY act as a standby
+device for a primary device with the same MAC address.
+
 \subsubsection{Legacy Interface: Device configuration layout}\label{sec:Device Types / Network Device / Device configuration layout / Legacy Interface: Device configuration layout}
 \label{sec:Device Types / Block Device / Feature bits / Device configuration layout / Legacy Interface: Device configuration layout}
 When using the legacy interface, transitional devices and drivers
-- 
2.14.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

