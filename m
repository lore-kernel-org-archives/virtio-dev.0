Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v3 1/2] virtio-net: Describe dev cfg fields read only
Date: Fri, 17 Feb 2023 17:45:28 +0200
Message-ID: <20230217154529.33508-2-parav@nvidia.com>
In-Reply-To: <20230217154529.33508-1-parav@nvidia.com>
References: <20230217154529.33508-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Device configuration fields are read only. Avoid duplicating this
description for multiple fields.

Instead describe it one time and do it in the driver requirements
section.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/161
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v2->v3:
- split as new patch
---
 device-types/net/description.tex | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/device-types/net/description.tex b/device-types/net/descriptio=
n.tex
index a197e1a..81e1135 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -156,10 +156,10 @@ \subsubsection{Legacy Interface: Feature bits}\label{=
sec:Device Types / Network
 \subsection{Device configuration layout}\label{sec:Device Types / Network =
Device / Device configuration layout}
 \label{sec:Device Types / Block Device / Feature bits / Device configurati=
on layout}
=20
-Device configuration fields are listed below, they are read-only for a dri=
ver. The \field{mac} address field
+Device configuration fields are listed below. The \field{mac} address fiel=
d
 always exists (though is only valid if VIRTIO_NET_F_MAC is set), and
 \field{status} only exists if VIRTIO_NET_F_STATUS is set. Two
-read-only bits (for the driver) are currently defined for the status field=
:
+bits (for the driver) are currently defined for the status field:
 VIRTIO_NET_S_LINK_UP and VIRTIO_NET_S_ANNOUNCE.
=20
 \begin{lstlisting}
@@ -167,14 +167,14 @@ \subsection{Device configuration layout}\label{sec:De=
vice Types / Network Device
 #define VIRTIO_NET_S_ANNOUNCE    2
 \end{lstlisting}
=20
-The following driver-read-only field, \field{max_virtqueue_pairs} only exi=
sts if
+The following field, \field{max_virtqueue_pairs} only exists if
 VIRTIO_NET_F_MQ or VIRTIO_NET_F_RSS is set. This field specifies the maxim=
um number
 of each of transmit and receive virtqueues (receiveq1\ldots receiveqN
 and transmitq1\ldots transmitqN respectively) that can be configured once =
at least one of these features
 is negotiated.
=20
-The following driver-read-only field, \field{mtu} only exists if
-VIRTIO_NET_F_MTU is set. This field specifies the maximum MTU for the driv=
er to
+The following field, \field{mtu} only exists if VIRTIO_NET_F_MTU
+is set. This field specifies the maximum MTU for the driver to
 use.
=20
 The following two fields, \field{speed} and \field{duplex}, only
@@ -261,6 +261,8 @@ \subsection{Device configuration layout}\label{sec:Devi=
ce Types / Network Device
=20
 \drivernormative{\subsubsection}{Device configuration layout}{Device Types=
 / Network Device / Device configuration layout}
=20
+All the device configuration fields are read-only for the driver.
+
 A driver SHOULD negotiate VIRTIO_NET_F_MAC if the device offers it.
 If the driver negotiates the VIRTIO_NET_F_MAC feature, the driver MUST set
 the physical address of the NIC to \field{mac}.  Otherwise, it SHOULD
--=20
2.26.2

