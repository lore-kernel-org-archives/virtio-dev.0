Return-Path: <virtio-dev-return-11193-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 42C2D9865AB
	for <virtio-dev@lists.oasis-open.org>; Wed, 22 Feb 2023 08:30:24 +0000 (UTC)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Wed, 22 Feb 2023 10:30:14 +0200
Message-Id: <20230222083014.2375727-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2] virtio-net: define the VIRTIO_NET_F_CTRL_RX_EXTRA feature bit
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: jasowang@redhat.com, mst@redhat.com, Alvaro Karsz <alvaro.karsz@solid-run.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The VIRTIO_NET_F_CTRL_RX_EXTRA feature bit is mentioned in the spec
since version 1.0, but it's not properly defined.

This patch defines the feature bit and defines the dependency on VIRTIO_NET=
_F_CTRL_VQ.

Since this dependency is missing in previous versions, we add it now as
a "SHOULD".

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/162

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
---
v2:
=09- Rephrase commit log, no changes to patch body.

 device-types/net/description.tex | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/device-types/net/description.tex b/device-types/net/descriptio=
n.tex
index 8487ccd..cf37da5 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -74,6 +74,8 @@ \subsection{Feature bits}\label{sec:Device Types / Networ=
k Device / Feature bits
=20
 \item[VIRTIO_NET_F_CTRL_VLAN (19)] Control channel VLAN filtering.
=20
+\item[VIRTIO_NET_F_CTRL_RX_EXTRA (20)]=09Control channel RX extra mode sup=
port.
+
 \item[VIRTIO_NET_F_GUEST_ANNOUNCE(21)] Driver can send gratuitous
     packets.
=20
@@ -259,6 +261,9 @@ \subsection{Device configuration layout}\label{sec:Devi=
ce Types / Network Device
 The device SHOULD NOT offer VIRTIO_NET_F_HASH_REPORT if it
 does not offer VIRTIO_NET_F_CTRL_VQ.
=20
+The device SHOULD NOT offer VIRTIO_NET_F_CTRL_RX_EXTRA if it
+does not offer VIRTIO_NET_F_CTRL_VQ.
+
 \drivernormative{\subsubsection}{Device configuration layout}{Device Types=
 / Network Device / Device configuration layout}
=20
 A driver SHOULD negotiate VIRTIO_NET_F_MAC if the device offers it.
@@ -295,6 +300,9 @@ \subsection{Device configuration layout}\label{sec:Devi=
ce Types / Network Device
 A driver SHOULD NOT negotiate VIRTIO_NET_F_HASH_REPORT if it
 does not negotiate VIRTIO_NET_F_CTRL_VQ.
=20
+A driver SHOULD NOT negotiate VIRTIO_NET_F_CTRL_RX_EXTRA if it
+does not negotiate VIRTIO_NET_F_CTRL_VQ.
+
 \subsubsection{Legacy Interface: Device configuration layout}\label{sec:De=
vice Types / Network Device / Device configuration layout / Legacy Interfac=
e: Device configuration layout}
 \label{sec:Device Types / Block Device / Feature bits / Device configurati=
on layout / Legacy Interface: Device configuration layout}
 When using the legacy interface, transitional devices and drivers
--=20
2.34.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

