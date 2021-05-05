Return-Path: virtio-dev-return-8149-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B53459864F1
	for <virtio-dev@lists.oasis-open.org>; Wed,  5 May 2021 19:37:39 +0000 (UTC)
MIME-Version: 1.0
References: <20210505193655.2414268-1-egranata@google.com>
In-Reply-To: <20210505193655.2414268-1-egranata@google.com>
From: Enrico Granata <egranata@google.com>
Date: Wed, 5 May 2021 13:37:26 -0600
Message-ID: <CAPR809ukYeThsPy4eg8A-G8b4Hwt7Prxh9P75=Vp9jnCKb6WqQ@mail.gmail.com>
Subject: [virtio-dev] Fwd: [PATCH v2] Provide detailed specification of virtio-blk lifetime metrics
Content-Type: text/plain; charset="UTF-8"
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

---------- Forwarded message ---------
From: Enrico Granata <egranata@google.com>
Date: Wed, May 5, 2021 at 1:37 PM
Subject: [PATCH v2] Provide detailed specification of virtio-blk
lifetime metrics
To: <virtio-dev@lists.oasis-open.org>
Cc: <egranata@google.com>, <hch@infradead.org>, <mst@redhat.com>,
<linux-block@vger.kernel.org>,
<virtualization@lists.linux-foundation.org>


In the course of review, some concerns were surfaced about the
original virtio-blk lifetime proposal, as it depends on the eMMC
spec which is not open

Add a more detailed description of the meaning of the fields
added by that proposal to the virtio-blk specification, as to
make it feasible to understand and implement the new lifetime
metrics feature without needing to refer to JEDEC's specification

This patch does not change the meaning of those fields nor add
any new fields, but it is intended to provide an open and more
clear description of the meaning associated with those fields.

Signed-off-by: Enrico Granata <egranata@google.com>
---
Changes in v2:
  - clarified JEDEC references;
  - added VIRTIO_BLK prefix and cleaned up comment syntax;
  - clarified reserved block references

 content.tex | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/content.tex b/content.tex
index 9232d5c..804383a 100644
--- a/content.tex
+++ b/content.tex
@@ -4668,14 +4668,28 @@ \subsection{Device Operation}\label{sec:Device
Types / Block Device / Device Ope
 };
 \end{lstlisting}

-The device lifetime metrics \field{pre_eol_info}, \field{device_lifetime_est_a}
-and \field{device_lifetime_est_b} have the semantics described by the
JESD84-B50
-specification for the extended CSD register fields \field{PRE_EOL_INFO}
-\field{DEVICE_LIFETIME_EST_TYP_A} and \field{DEVICE_LIFETIME_EST_TYP_B}
-respectively.
+The \field{pre_eol_info} specifies the percentage of reserved blocks
+that are consumed and will have one of these values:

-JESD84-B50 is available at the JEDEC website (https://www.jedec.org)
-pursuant to JEDEC's licensing terms and conditions.
+\begin{lstlisting}
+/* Value not available */
+#define VIRTIO_BLK_PRE_EOL_INFO_UNDEFINED    0
+/* < 80% of reserved blocks are consumed */
+#define VIRTIO_BLK_PRE_EOL_INFO_NORMAL       1
+/* 80% of reserved blocks are consumed */
+#define VIRTIO_BLK_PRE_EOL_INFO_WARNING      2
+/* 90% of reserved blocks are consumed */
+#define VIRTIO_BLK_PRE_EOL_INFO_URGENT       3
+/* All others values are reserved */
+\end{lstlisting}
+
+The \field{device_lifetime_est_typ_a} refers to wear of SLC cells and
is provided
+in increments of 10%, with 0 meaning undefined, 1 meaning up-to 10% of lifetime
+used, and so on, thru to 11 meaning estimated lifetime exceeded.
+All values above 11 are reserved.
+
+The \field{device_lifetime_est_typ_b} refers to wear of MLC cells and
is provided
+with the same semantics as \field{device_lifetime_est_typ_a}.

 The final \field{status} byte is written by the device: either
 VIRTIO_BLK_S_OK for success, VIRTIO_BLK_S_IOERR for device or driver
@@ -4812,7 +4826,17 @@ \subsection{Device Operation}\label{sec:Device
Types / Block Device / Device Ope
 or UFS persistent storage), the device SHOULD offer the VIRTIO_BLK_F_LIFETIME
 flag. The flag MUST NOT be offered if the device is backed by storage for which
 the lifetime metrics described in this document cannot be obtained or for which
-such metrics have no useful meaning.
+such metrics have no useful meaning. If the metrics are offered, the
device MUST NOT
+send any reserved values, as defined in this specification.
+
+\begin{note}
+  The device lifetime metrics \field{pre_eol_info},
\field{device_lifetime_est_a}
+  and \field{device_lifetime_est_b} are discussed in the JESD84-B50
specification.
+
+  The complete JESD84-B50 is available at the JEDEC website
(https://www.jedec.org)
+  pursuant to JEDEC's licensing terms and conditions. This
information is provided to
+  simplfy passthrough implementations from eMMC devices.
+\end{note}

 \subsubsection{Legacy Interface: Device Operation}\label{sec:Device
Types / Block Device / Device Operation / Legacy Interface: Device
Operation}
 When using the legacy interface, transitional devices and drivers
--
2.31.1.527.g47e6f16901-goog

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

