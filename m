Return-Path: virtio-dev-return-5864-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1BBB2985EE4
	for <virtio-dev@lists.oasis-open.org>; Thu, 18 Jul 2019 07:02:55 +0000 (UTC)
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Thu, 18 Jul 2019 15:00:47 +0800
Message-Id: <20190718070047.7402-1-tiwei.bie@intel.com>
Subject: [virtio-dev] [RFC] content: explicitly document the VLAN filtering as best-effort
To: virtio-dev@lists.oasis-open.org
Cc: mst@redhat.com, cohuck@redhat.com, stefanha@redhat.com, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Similar to the MAC address based filtering, the VLAN filtering
is also best-effort in implementations, but it's not quite clear
in the spec. So document this behaviour explicitly to reflect
the way implementations behave.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
This is a RFC for now (Comments would be appreciated!).
More details can be found here:
https://patchwork.ozlabs.org/patch/1113538/

 content.tex | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/content.tex b/content.tex
index 8f0498e..783322b 100644
--- a/content.tex
+++ b/content.tex
@@ -3530,6 +3530,11 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 If the driver negotiates the VIRTION_NET_F_CTRL_VLAN feature, it
 can control a VLAN filter table in the device.
 
+\begin{note}
+Similar to the MAC address based filtering, the VLAN filtering
+is also best-effort: unwanted packets could still arrive.
+\end{note}
+
 \begin{lstlisting}
 #define VIRTIO_NET_CTRL_VLAN       2
  #define VIRTIO_NET_CTRL_VLAN_ADD             0
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

