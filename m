Return-Path: <virtio-dev-return-10717-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2E58F98636C
	for <virtio-dev@lists.oasis-open.org>; Mon,  6 Feb 2023 08:02:18 +0000 (UTC)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Mon,  6 Feb 2023 10:02:10 +0200
Message-Id: <20230206080210.37758-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v3] virtio-net: Mention VIRTIO_NET_F_HASH_REPORT dependency on VIRTIO_NET_F_CTRL_VQ
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: jasowang@redhat.com, mst@redhat.com, Alvaro Karsz <alvaro.karsz@solid-run.com>
List-ID: <virtio-dev.lists.oasis-open.org>

If the VIRTIO_NET_F_HASH_REPORT feature is negotiated, the driver may
send VIRTIO_NET_CTRL_MQ_HASH_CONFIG commands, thus, the control VQ
feature should be negotiated.

---
v2: Use SHOULD instead of Feature bit requirement, version 1.2 is already
    out and doesn't include this depencency.

v3: Explain the dependency in a less confusing way.

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>

 device-types/net/description.tex | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/device-types/net/description.tex b/device-types/net/descriptio=
n.tex
index 700a1cb..1741c79 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -256,6 +256,9 @@ \subsection{Device configuration layout}\label{sec:Devi=
ce Types / Network Device
 \field{duplex} fields as long as VIRTIO_NET_S_LINK_UP is set in
 the \field{status}.
=20
+The device SHOULD NOT offer VIRTIO_NET_F_HASH_REPORT if it
+does not offer VIRTIO_NET_F_CTRL_VQ.
+
 \drivernormative{\subsubsection}{Device configuration layout}{Device Types=
 / Network Device / Device configuration layout}
=20
 A driver SHOULD negotiate VIRTIO_NET_F_MAC if the device offers it.
@@ -289,6 +292,9 @@ \subsection{Device configuration layout}\label{sec:Devi=
ce Types / Network Device
 SHOULD re-read \field{speed} and \field{duplex} after a
 configuration change notification.
=20
+A driver SHOULD NOT negotiate VIRTIO_NET_F_HASH_REPORT if it
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

