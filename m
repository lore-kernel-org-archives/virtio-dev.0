Return-Path: virtio-dev-return-4619-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id AB64958191D7
	for <virtio-dev@lists.oasis-open.org>; Fri, 29 Jun 2018 15:19:55 -0700 (PDT)
From: Venu Busireddy <venu.busireddy@oracle.com>
Date: Fri, 29 Jun 2018 17:19:07 -0500
Message-Id: <20180629221907.3662-5-venu.busireddy@oracle.com>
In-Reply-To: <20180629221907.3662-1-venu.busireddy@oracle.com>
References: <20180629221907.3662-1-venu.busireddy@oracle.com>
Subject: [virtio-dev] [PATCH v3 virtio 1/1] Add "Group Identifier" to virtio PCI capabilities.
To: venu.busireddy@oracle.com, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

Add VIRTIO_PCI_CAP_GROUP_ID_CFG (Group Identifier) capability to the
virtio PCI capabilities to allow for the grouping of devices.

Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
---
 content.tex | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/content.tex b/content.tex
index be18234..34627e5 100644
--- a/content.tex
+++ b/content.tex
@@ -599,6 +599,8 @@ The fields are interpreted as follows:
 #define VIRTIO_PCI_CAP_DEVICE_CFG        4
 /* PCI configuration access */
 #define VIRTIO_PCI_CAP_PCI_CFG           5
+/* Group Identifier */
+#define VIRTIO_PCI_CAP_GROUP_ID_CFG      6
 \end{lstlisting}
 
         Any other value is reserved for future use.
@@ -997,6 +999,34 @@ address \field{cap.length} bytes within a BAR range
 specified by some other Virtio Structure PCI Capability
 of type other than \field{VIRTIO_PCI_CAP_PCI_CFG}.
 
+\subsubsection{Group Identifier capability}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Group Identifier capability}
+
+The VIRTIO_PCI_CAP_GROUP_ID_CFG capability provides means for grouping
+devices together.
+
+The capability is immediately followed by an identifier of type u64
+as below:
+
+\begin{lstlisting}
+struct virtio_pci_group_id_cap {
+        struct virtio_pci_cap cap;
+        u64 group_id; /* Group Identifier */
+};
+\end{lstlisting}
+
+\devicenormative{\paragraph}{Group Identifier capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Group Identifier capability}
+
+The device MAY present the VIRTIO_PCI_CAP_GROUP_ID_CFG capability.
+
+When this capability is present, the device must set the fields
+\field{cap.bar}, \field{cap.offset} and \field{cap.length} to 0, and
+set the group_id to a unique identifier.
+
+\drivernormative{\paragraph}{Group Identifier capability}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Group Identifier capability}
+
+The fields \field{cap.bar}, \field{cap.offset}, \field{cap.length}
+and \field{group_id} are read-only for the driver.
+
 \subsubsection{Legacy Interfaces: A Note on PCI Device Layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Legacy Interfaces: A Note on PCI Device Layout}
 
 Transitional devices MUST present part of configuration

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

