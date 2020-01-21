Return-Path: virtio-dev-return-6672-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B054E985F02
	for <virtio-dev@lists.oasis-open.org>; Tue, 21 Jan 2020 06:19:50 +0000 (UTC)
From: Jing Liu <jing2.liu@linux.intel.com>
Date: Tue, 21 Jan 2020 21:54:29 +0800
Message-Id: <1579614873-21907-2-git-send-email-jing2.liu@linux.intel.com>
In-Reply-To: <1579614873-21907-1-git-send-email-jing2.liu@linux.intel.com>
References: <1579614873-21907-1-git-send-email-jing2.liu@linux.intel.com>
Subject: [virtio-dev] [PATCH v2 1/5] virtio-mmio: Add feature bit for MMIO notification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, Jing Liu <jing2.liu@linux.intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Liu Jiang <gerry@linux.alibaba.com>, Zha Bin <zhabin@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

All the queues notifications use the same register on MMIO transport
layer. Add a feature bit (39) for enhancing the notification capability.
The detailed mechanism would be in next patch.

Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Co-developed-by: Liu Jiang <gerry@linux.alibaba.com>
Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
---
 content.tex | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/content.tex b/content.tex
index d68cfaf..826bc7d 100644
--- a/content.tex
+++ b/content.tex
@@ -5810,6 +5810,9 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Fe=
ature Bits}
   in its device notifications.
   See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueues =
/ Driver notifications}.
 \end{description}
+  \item[VIRTIO_F_MMIO_NOTIFICATION(39)] This feature indicates
+  that the device supports enhanced notification mechanism on
+  MMIO transport layer.
=20
 \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
=20
@@ -5843,6 +5846,8 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Fe=
ature Bits}
 or partially reset, and even without re-negotiating
 VIRTIO_F_SR_IOV after the reset.
=20
+A driver SHOULD accept VIRTIO_F_MMIO_NOTIFICATION if it is offered.
+
 \devicenormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
=20
 A device MUST offer VIRTIO_F_VERSION_1.  A device MAY fail to operate furt=
her
@@ -5872,6 +5877,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved F=
eature Bits}
 and presents a PCI SR-IOV capability structure, otherwise
 it MUST NOT offer VIRTIO_F_SR_IOV.
=20
+If VIRTIO_F_MMIO_NOTIFICATION has been negotiated, a device
+MUST support handling the notification from driver at the
+calculated location.
+
 \section{Legacy Interface: Reserved Feature Bits}\label{sec:Reserved Featu=
re Bits / Legacy Interface: Reserved Feature Bits}
=20
 Transitional devices MAY offer the following:
--=20
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

