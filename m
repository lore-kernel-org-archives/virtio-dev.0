Return-Path: virtio-comment-return-1279-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 19 May 2020 19:02:27 -0700
Message-ID: <158994014779.397236.836253101843237605.stgit@ahduyck-workstation>
In-Reply-To: 
 <158994007522.397236.7536927155973222190.stgit@ahduyck-workstation>
References: 
 <158994007522.397236.7536927155973222190.stgit@ahduyck-workstation>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH v3 2/3] content: Document balloon feature page poison
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
 conformance.tex |    2 ++
 content.tex     |   44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/conformance.tex b/conformance.tex
index a14e26edfcb2..5038b36324ac 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -150,6 +150,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{drivernormative:Device Types / Memory Balloon Device / Device Operation}
 \item \ref{drivernormative:Device Types / Memory Balloon Device / Device Operation / Memory Statistics}
 \item \ref{drivernormative:Device Types / Memory Balloon Device / Device Operation / Free Page Hinting}
+\item \ref{drivernormative:Device Types / Memory Balloon Device / Device Operation / Page Poison}
 \end{itemize}
 
 \conformance{\subsection}{SCSI Host Driver Conformance}\label{sec:Conformance / Driver Conformance / SCSI Host Driver Conformance}
@@ -333,6 +334,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{devicenormative:Device Types / Memory Balloon Device / Device Operation}
 \item \ref{devicenormative:Device Types / Memory Balloon Device / Device Operation / Memory Statistics}
 \item \ref{devicenormative:Device Types / Memory Balloon Device / Device Operation / Free Page Hinting}
+\item \ref{devicenormative:Device Types / Memory Balloon Device / Device Operation / Page Poison}
 \end{itemize}
 
 \conformance{\subsection}{SCSI Host Device Conformance}\label{sec:Conformance / Device Conformance / SCSI Host Device Conformance}
diff --git a/content.tex b/content.tex
index 816b6c1b052e..89e9948b7399 100644
--- a/content.tex
+++ b/content.tex
@@ -5026,6 +5026,9 @@ \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Featu
     page hinting. A virtqueue for providing hints as to what memory is
     currently free is present. Configuration field \field{free_page_hint_cmd_id}
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
@@ -5473,6 +5486,37 @@ \subsubsection{Free Page Hinting}\label{sec:Device Types / Memory Balloon Device
 \field{free_page_hint_cmd_id} once it no longer has need for the
 previously hinted pages.
 
+\subsubsection{Page Poison}\label{sec:Device Types / Memory Balloon Device / Device Operation / Page Poison}
+
+Page Poison provides a way to notify the host that the guest is initializing
+and/or poisoning free pages. When the feature is enabled pages that are
+deflated might be immediately written to by the guest.
+
+If the guest is not initializing or poisoning freed pages it should reject
+the VIRTIO_BALLOON_F_PAGE_POISON feature.
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
+The driver MUST populate the \field{poison_val} configuration data before
+setting the DRIVER_OK bit.
+
+The driver MUST NOT modify \field{poison_val} while the DRIVER_OK bit is set.
+
+\devicenormative{\paragraph}{Page Poison}{Device Types / Memory Balloon Device / Device Operation / Page Poison}
+
+Normative statements in this section apply if the
+VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated.
+
+The device MAY use the content of \field{poison_val} as a hint to guest
+behavior.
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

