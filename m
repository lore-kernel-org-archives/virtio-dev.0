Return-Path: virtio-dev-return-5771-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 00810985A99
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Jun 2019 06:55:10 +0000 (UTC)
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Tue, 11 Jun 2019 14:53:04 +0800
Message-Id: <20190611065304.16880-1-tiwei.bie@intel.com>
Subject: [virtio-dev] [PATCH] content: fix typo in feature bit name
To: mst@redhat.com, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 content.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/content.tex b/content.tex
index 193b6e1..a143d91 100644
--- a/content.tex
+++ b/content.tex
@@ -3523,7 +3523,7 @@ \subsubsection{Control Virtqueue}\label{sec:Device Types / Network Device / Devi
 
 \paragraph{VLAN Filtering}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / VLAN Filtering}
 
-If the driver negotiates the VIRTION_NET_F_CTRL_VLAN feature, it
+If the driver negotiates the VIRTIO_NET_F_CTRL_VLAN feature, it
 can control a VLAN filter table in the device.
 
 \begin{lstlisting}
-- 
2.17.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

