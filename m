Return-Path: virtio-dev-return-4954-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E6A36985DD9
	for <virtio-dev@lists.oasis-open.org>; Tue, 13 Nov 2018 11:00:48 +0000 (UTC)
From: Wei Wang <wei.w.wang@intel.com>
Date: Tue, 13 Nov 2018 18:27:47 +0800
Message-Id: <1542104867-11143-3-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1542104867-11143-1-git-send-email-wei.w.wang@intel.com>
References: <1542104867-11143-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] [PATCH v1 2/2] content/virtio-balloon: VIRTIO_BALLOON_F_PAGE_POISON
To: virtio-dev@lists.oasis-open.org, mst@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

The VIRTIO_BALLOON_F_PAGE_POISON feature supports guest to report the
memory poison value to host.

Suggested-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 content.tex | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/content.tex b/content.tex
index 673c891..df3c6c2 100644
--- a/content.tex
+++ b/content.tex
@@ -4397,6 +4397,8 @@ memory pages to the host when the related features are negotiated.
     guest out of memory condition.
 \item[VIRTIO_BALLOON_F_FREE_PAGE_HINT(3) ] Guest reports free pages
     to host.
+\item[VIRTIO_BALLOON_F_PAGE_POISON(4) ] Indicate if guest is using
+    page poisoning.
 
 \end{description}
 
@@ -4404,6 +4406,10 @@ memory pages to the host when the related features are negotiated.
 The driver SHOULD accept the VIRTIO_BALLOON_F_MUST_TELL_HOST
 feature if offered by the device.
 
+The driver SHOULD accept the VIRTIO_BALLOON_F_PAGE_POISON feature
+only when the guest is using page poison and the feature is offered
+by the device.
+
 \devicenormative{\subsubsection}{Feature bits}{Device Types / Memory Balloon Device / Feature bits}
 If the device offers the VIRTIO_BALLOON_F_MUST_TELL_HOST feature
 bit, and if the driver did not accept this feature bit, the
@@ -4432,6 +4438,7 @@ struct virtio_balloon_config {
         le32 num_pages;
         le32 actual;
         le32 free_page_report_cmd_id;
+        le32 poison_val;
 };
 \end{lstlisting}
 
@@ -4440,12 +4447,20 @@ struct virtio_balloon_config {
 \field{free_page_report_cmd_id} is available if
 VIRTIO_BALLON_F_FREE_PAGE_HINT negotiated.
 
+\field{poison_val} is available if VIRTIO_BALLOON_F_PAGE_POISON
+negotiated.
+
 \devicenormative{\subsubsection}{Device configuration layout}{Device Types / Traditional Memory Balloon Device / Device configuration layout}
 
 The device MUST NOT set \field{free_page_report_cmd_id} to a value
 between \field{VIRTIO_BALLOON_CMD_ID_DONE} and
 \field{VIRTIO_BALLOON_CMD_ID_MIN} exclusive.
 
+\drivernormative{\subsubsection}{Device configuration layout}{Device Types / Traditional Memory Balloon Device / Device configuration layout}
+
+The driver SHOULD write the guest used poison value to
+\field{poison_val} if VIRTIO_BALLOON_F_PAGE_POISON negotiated.
+
 \subparagraph{Legacy Interface: Device configuration layout}\label{sec:Device Types / Memory Balloon Device / Device
 configuration layout / Legacy Interface: Device configuration layout}
 When using the legacy interface, transitional devices and drivers
@@ -4480,6 +4495,9 @@ The device initialization process is outlined below:
         migration agent) who will request for the free page reporting
         from the driver.
   \end{enumerate}
+
+\item If the VIRTIO_BALLOON_F_PAGE_POISON feature bit is negotiated,
+  write the guest used poison value to \field{poison_val}.
 \end{enumerate}
 
 
-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

