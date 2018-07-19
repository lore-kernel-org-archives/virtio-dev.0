Return-Path: virtio-dev-return-4709-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B81C9985C5E
	for <virtio-dev@lists.oasis-open.org>; Thu, 19 Jul 2018 21:29:52 +0000 (UTC)
From: Sridhar Samudrala <sridhar.samudrala@intel.com>
Date: Thu, 19 Jul 2018 14:29:40 -0700
Message-Id: <1532035780-38883-1-git-send-email-sridhar.samudrala@intel.com>
Subject: [virtio-dev] [PATCH] content: Introduce VIRTIO_NET_F_STANDBY feature
To: mst@redhat.com, virtio-dev@lists.oasis-open.org
Cc: Sridhar@lists.oasis-open.org, "Samudrala <sridhar.samudrala"@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

VIRTIO_NET_F_STANDBY feature enables hypervisor to indicate virtio_net
driver to act as a standby for another device with the same MAC address.

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com
---
 content.tex | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/content.tex b/content.tex
index be18234..010b6ee 100644
--- a/content.tex
+++ b/content.tex
@@ -2525,6 +2525,9 @@ features.
 
 \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
     channel.
+
+\item[VIRTIO_NET_F_STANDBY(62)] Driver acts as standby for another
+    device with the same MAC
 \end{description}
 
 \subsubsection{Feature bit requirements}\label{sec:Device Types / Network Device / Feature bits / Feature bit requirements}
@@ -2636,6 +2639,13 @@ If the driver negotiates VIRTIO_NET_F_MTU, it MUST NOT transmit packets of
 size exceeding the value of \field{mtu} (plus low level ethernet header length)
 with \field{gso_type} NONE or ECN.
 
+A driver SHOULD negotiate VIRTIO_NET_F_STANDBY feature if the device offers it.
+
+If the driver negotiates VIRTIO_NET_F_STANDBY, it should act as a standby for
+another device with the same MAC address when available. The hypervisor can
+hot-plug a primary device with same MAC address if the feature is successfully
+negotiated with the driver.
+
 \subsubsection{Legacy Interface: Device configuration layout}\label{sec:Device Types / Network Device / Device configuration layout / Legacy Interface: Device configuration layout}
 \label{sec:Device Types / Block Device / Feature bits / Device configuration layout / Legacy Interface: Device configuration layout}
 When using the legacy interface, transitional devices and drivers
-- 
2.14.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

