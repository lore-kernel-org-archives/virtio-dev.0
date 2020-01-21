Return-Path: virtio-dev-return-6675-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CA5E6985F08
	for <virtio-dev@lists.oasis-open.org>; Tue, 21 Jan 2020 06:19:52 +0000 (UTC)
From: Jing Liu <jing2.liu@linux.intel.com>
Date: Tue, 21 Jan 2020 21:54:31 +0800
Message-Id: <1579614873-21907-4-git-send-email-jing2.liu@linux.intel.com>
In-Reply-To: <1579614873-21907-1-git-send-email-jing2.liu@linux.intel.com>
References: <1579614873-21907-1-git-send-email-jing2.liu@linux.intel.com>
Subject: [virtio-dev] [PATCH v2 3/5] virtio-mmio: Add feature bit for MMIO MSI
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, Jing Liu <jing2.liu@linux.intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Liu Jiang <gerry@linux.alibaba.com>, Zha Bin <zhabin@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The current MMIO transport layer uses a single, dedicated interrupt
signal, which brings performance penalty. Add a feature bit (40)
for introducing MSI capability.

Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
Co-developed-by: Liu Jiang <gerry@linux.alibaba.com>
Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
---
 content.tex | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/content.tex b/content.tex
index 5881253..ff151ba 100644
--- a/content.tex
+++ b/content.tex
@@ -5840,6 +5840,9 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Fe=
ature Bits}
   \item[VIRTIO_F_MMIO_NOTIFICATION(39)] This feature indicates
   that the device supports enhanced notification mechanism on
   MMIO transport layer.
+  \item[VIRTIO_F_MMIO_MSI(40)] This feature indicates that the
+  device supports Message Signal Interrupts (MSI) mechanism on
+  MMIO transport layer.
=20
 \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
=20
@@ -5875,6 +5878,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved F=
eature Bits}
=20
 A driver SHOULD accept VIRTIO_F_MMIO_NOTIFICATION if it is offered.
=20
+A driver SHOULD accept VIRTIO_F_MMIO_MSI if it is offered.
+If VIRTIO_F_MMIO_MSI has been negotiated, a driver MUST try to
+set up MSI at first priority.
+
 \devicenormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
=20
 A device MUST offer VIRTIO_F_VERSION_1.  A device MAY fail to operate furt=
her
--=20
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

