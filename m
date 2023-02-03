Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH] virtio-net: Define configuration field layout before its description
Date: Fri, 3 Feb 2023 16:43:49 +0200
Message-ID: <20230203144349.34471-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Currently some fields of the virtio_net_config structure are defined
before introducing the structure and some are defined after
introducing virtio_net_config.
Better to define the configuration layout first followed by
description of all the fields.

Device configuration fields are described in the section. Change wording
from 'listed' to 'described' as suggested in patch [1].

[1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00004.html

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 device-types/net/description.tex | 39 +++++++++++++++++---------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/device-types/net/description.tex b/device-types/net/descriptio=
n.tex
index dedd6b1..d4f598b 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -154,11 +154,27 @@ \subsubsection{Legacy Interface: Feature bits}\label{=
sec:Device Types / Network
 \subsection{Device configuration layout}\label{sec:Device Types / Network =
Device / Device configuration layout}
 \label{sec:Device Types / Block Device / Feature bits / Device configurati=
on layout}
=20
-Device configuration fields are listed below, they are read-only for a dri=
ver. The \field{mac} address field
-always exists (though is only valid if VIRTIO_NET_F_MAC is set), and
-\field{status} only exists if VIRTIO_NET_F_STATUS is set. Two
-read-only bits (for the driver) are currently defined for the status field=
:
-VIRTIO_NET_S_LINK_UP and VIRTIO_NET_S_ANNOUNCE.
+Device configuration fields are described below, they are read-only for a =
driver.
+
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
+The \field{mac} address field always exists (though is only valid
+if VIRTIO_NET_F_MAC is set), and \field{status} only exists if
+VIRTIO_NET_F_STATUS is set. Two read-only bits (for the driver)
+are currently defined for the status field: VIRTIO_NET_S_LINK_UP
+and VIRTIO_NET_S_ANNOUNCE.
=20
 \begin{lstlisting}
 #define VIRTIO_NET_S_LINK_UP     1
@@ -188,19 +204,6 @@ \subsection{Device configuration layout}\label{sec:Dev=
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

