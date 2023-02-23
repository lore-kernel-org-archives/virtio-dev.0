Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v4 2/2] virtio-net: Define cfg fields before description
Date: Thu, 23 Feb 2023 04:35:21 +0200
Message-ID: <20230223023521.159959-3-parav@nvidia.com>
In-Reply-To: <20230223023521.159959-1-parav@nvidia.com>
References: <20230223023521.159959-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>, David Edmondson <david.edmondson@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Currently some fields of the virtio_net_config structure are defined
before introducing the structure and some are defined after
introducing virtio_net_config.
Better to define the configuration layout first followed by
description of all the fields.

Device configuration fields are described in the section. Change wording
from 'listed' to 'described' as suggested in patch [1].

[1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00004.html

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/161
Reviewed-by: David Edmondson <david.edmondson@oracle.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v2->v3:
- split the patch for read only description as prepration patch
- rebased
v1->v2:
- remove read-only wording from multiple places
v0->v1:
- Change wording about device configuration field introduction
- remove duplicate read-only wording for status field
- reword sentence to read it better
---
 device-types/net/description.tex | 42 +++++++++++++++++---------------
 1 file changed, 22 insertions(+), 20 deletions(-)

diff --git a/device-types/net/description.tex b/device-types/net/descriptio=
n.tex
index 821f7b0..7033594 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -156,14 +156,29 @@ \subsubsection{Legacy Interface: Feature bits}\label{=
sec:Device Types / Network
 \subsection{Device configuration layout}\label{sec:Device Types / Network =
Device / Device configuration layout}
 \label{sec:Device Types / Block Device / Feature bits / Device configurati=
on layout}
=20
-Device configuration fields are listed below. All the device
-configuration fields are read-only for the driver.
+The network device has the following device configuration layout. All the
+device configuration fields are read-only for the driver.
=20
-The \field{mac} address field always exists (though is only
-valid if VIRTIO_NET_F_MAC is set), and \field{status} only
-exists if VIRTIO_NET_F_STATUS is set. Two bits are currently
-defined for the status field: VIRTIO_NET_S_LINK_UP and
-VIRTIO_NET_S_ANNOUNCE.
+\begin{lstlisting}
+struct virtio_net_config {
+        u8 mac[6];
+        le16 status;
+        le16 max_virtqueue_pairs;
+        le16 mtu;
+        le32 speed;
+        u8 duplex;
+        u8 rss_max_key_size;
+        le16 rss_max_indirection_table_length;
+        le32 supported_hash_types;
+};
+\end{lstlisting}
+
+The \field{mac} address field always exists (although it is only
+valid if VIRTIO_NET_F_MAC is set).
+
+The \field{status} only exists if VIRTIO_NET_F_STATUS is set.
+Two bits are currently defined for the status field: VIRTIO_NET_S_LINK_UP
+and VIRTIO_NET_S_ANNOUNCE.
=20
 \begin{lstlisting}
 #define VIRTIO_NET_S_LINK_UP     1
@@ -193,19 +208,6 @@ \subsection{Device configuration layout}\label{sec:Dev=
ice Types / Network Device
 is expected to re-read these values after receiving a
 configuration change notification.
=20
-\begin{lstlisting}
-struct virtio_net_config {
-        u8 mac[6];
-        le16 status;
-        le16 max_virtqueue_pairs;
-        le16 mtu;
-        le32 speed;
-        u8 duplex;
-        u8 rss_max_key_size;
-        le16 rss_max_indirection_table_length;
-        le32 supported_hash_types;
-};
-\end{lstlisting}
 The following field, \field{rss_max_key_size} only exists if VIRTIO_NET_F_=
RSS or VIRTIO_NET_F_HASH_REPORT is set.
 It specifies the maximum supported length of RSS key in bytes.
=20
--=20
2.26.2

