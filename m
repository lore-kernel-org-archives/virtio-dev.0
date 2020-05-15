Return-Path: virtio-comment-return-1255-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 15 May 2020 10:33:15 -0700
Message-ID: 
 <158956399556.246123.11500291500368854742.stgit@ahduyck-workstation>
In-Reply-To: 
 <158956393696.246123.9443729217250549606.stgit@ahduyck-workstation>
References: 
 <158956393696.246123.9443729217250549606.stgit@ahduyck-workstation>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH v2 2/3] content: Document balloon feature page poison
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: mst@redhat.com, david@redhat.com, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, wei.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Page poison provides a way for the guest to notify the host of the content
expected to be found in pages when they are added back to the guest after
being discarded. The feature currently doesn't apply to the existing
balloon features, however it will apply to an upcoming feature, free page
reporting. Add documentation for the page poison feature describing the
basic functionality and requirements.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 content.tex |   43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/content.tex b/content.tex
index ec0abf177526..3d30fd5bb6fa 100644
--- a/content.tex
+++ b/content.tex
@@ -5026,6 +5026,9 @@ \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Featu
     page hinting. A virtqueue for providing hints as to what memory is
     currently free is present. Configuration field free_page_hint_cmd_id
     is valid.
+\item[ VIRTIO_BALLOON_F_PAGE_POISON(4) ] The device has to be notified if
+    the driver is expecting balloon pages to contain a certain value when
+    returned. Configuration field poison_val is valid.
 
 \end{description}
 
@@ -5033,6 +5036,9 @@ \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Featu
 The driver SHOULD accept the VIRTIO_BALLOON_F_MUST_TELL_HOST
 feature if offered by the device.
 
+The driver SHOULD clear the VIRTIO_BALLOON_F_PAGE_POISON flag if it is not
+expecting any specific value to be stored in the page.
+
 \devicenormative{\subsubsection}{Feature bits}{Device Types / Memory Balloon Device / Feature bits}
 If the device offers the VIRTIO_BALLOON_F_MUST_TELL_HOST feature
 bit, and if the driver did not accept this feature bit, the
@@ -5055,11 +5061,15 @@ \subsection{Device configuration layout}\label{sec:Device Types / Memory Balloon
     VIRTIO_BALLOON_F_FREE_PAGE_HINT has been negotiated and is read-only by
     the driver.
 
+  \field{poison_val} is available if VIRTIO_BALLOON_F_PAGE_POISON has been
+    negotiated.
+
 \begin{lstlisting}
 struct virtio_balloon_config {
         le32 num_pages;
         le32 actual;
         le32 free_page_hint_cmd_id;
+        le32 poison_val;
 };
 \end{lstlisting}
 
@@ -5088,6 +5098,9 @@ \subsection{Device Initialization}\label{sec:Device Types / Memory Balloon Devic
 \item If the VIRTIO_BALLOON_F_FREE_PAGE_HINT feature bit is negotiated, the
   free_page_vq is identified.
 
+\item If the VIRTIO_BALLOON_F_PAGE_POISON feature bit is negotiated, the
+  driver updates the \field{poison_val} configuration field.
+
 \item DRIVER_OK is set: device operation begins.
 
 \item If the VIRTIO_BALLOON_F_STATS_VQ feature bit is negotiated, then
@@ -5461,6 +5474,36 @@ \subsubsection{Free Page Hinting}\label{sec:Device Types / Memory Balloon Device
 The device MAY NOT modify the contents of the balloon after
 \field{free_page_hint_cmd_id} is set to VIRTIO_BALLOON_CMD_ID_DONE.
 
+\subsubsection{Page Poison}\label{sec:Device Types / Memory Balloon Device / Device Operation / Page Poison}
+
+Page Poison provides a way to notify the host of the contents that are
+currently in the balloon pages, and those that are expected to be in the
+pages when they are pulled from the balloon.
+
+If VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated, the guest
+will place the expected poison value into the \field{poison_val}
+configuration field data.
+
+\drivernormative{\paragraph}{Page Poison}{Device Types / Memory Balloon Device / Device Operation / Page Poison}
+
+Normative statements in this section apply if the
+VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated.
+
+The driver MUST populate the \field{poison_val} configuration data if it is
+expecting the page to contain some fixed value when free.
+
+The driver MAY opt to reject the feature if it will take care of
+re-initializing pages when first accessing them.
+
+\devicenormative{\paragraph}{Page Poison}{Device Types / Memory Balloon Device / Device Operation / Page Poison}
+
+Normative statements in this section apply if the
+VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated.
+
+As page poisoning is optional for normal balloon operations and free
+page hinting, the device MAY ignore the content of \field{poison_val}
+for those operations.
+
 \section{SCSI Host Device}\label{sec:Device Types / SCSI Host Device}
 
 The virtio SCSI host device groups together one or more virtual



This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

