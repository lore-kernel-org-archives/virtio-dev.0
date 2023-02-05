Return-Path: <virtio-dev-return-10711-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 858339862CB
	for <virtio-dev@lists.oasis-open.org>; Sun,  5 Feb 2023 12:08:08 +0000 (UTC)
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Sun,  5 Feb 2023 14:08:01 +0200
Message-Id: <20230205120801.1419067-1-alvaro.karsz@solid-run.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH] virtio-net: Mention that VIRTIO_NET_F_HASH_REPORT requires VIRTIO_NET_F_CTRL_VQ
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: jasowang@redhat.com, mst@redhat.com, Alvaro Karsz <alvaro.karsz@solid-run.com>
List-ID: <virtio-dev.lists.oasis-open.org>

If the VIRTIO_NET_F_HASH_REPORT feature is negotiated, the driver may
send VIRTIO_NET_CTRL_MQ_HASH_CONFIG commands, thus, the control VQ
feature must be negotiated.

Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>
---
 device-types/net/description.tex | 1 +
 1 file changed, 1 insertion(+)

diff --git a/device-types/net/description.tex b/device-types/net/descriptio=
n.tex
index 700a1cb..83cfe94 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -139,6 +139,7 @@ \subsubsection{Feature bit requirements}\label{sec:Devi=
ce Types / Network Device
 \item[VIRTIO_NET_F_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
 \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NET_=
F_HOST_TSO6.
 \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
+\item[VIRTIO_NET_F_HASH_REPORT] Requires VIRTIO_NET_F_CTRL_VQ.
 \end{description}
=20
 \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Ne=
twork Device / Feature bits / Legacy Interface: Feature bits}
--=20
2.34.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

