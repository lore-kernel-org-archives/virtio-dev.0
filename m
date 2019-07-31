Return-Path: virtio-dev-return-5899-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DBBF3985BB5
	for <virtio-dev@lists.oasis-open.org>; Wed, 31 Jul 2019 01:36:52 +0000 (UTC)
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Wed, 31 Jul 2019 09:34:46 +0800
Message-Id: <20190731013446.23591-1-tiwei.bie@intel.com>
Subject: [virtio-dev] [PATCH v2] content: explicitly document the VLAN filtering as best-effort
To: virtio-dev@lists.oasis-open.org
Cc: mst@redhat.com, cohuck@redhat.com, stefanha@redhat.com, jasowang@redhat.com, tiwei.bie@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

Similar to the MAC address based filtering, the VLAN filtering
is also best-effort in implementations, but it's not quite clear
in the spec. So document this behaviour explicitly to reflect
the way implementations behave.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
v2:
- Drop "Fixes:" tag (will include it in the mail requesting the
  vote according to the github use documented in
  https://lists.oasis-open.org/archives/virtio-dev/201907/msg00044.html)

v1 link:
https://lists.oasis-open.org/archives/virtio-dev/201907/msg00037.html

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

