Return-Path: virtio-comment-return-1296-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 26 May 2020 21:06:50 -0700
Message-ID: <159055240999.209072.325801657165111674.stgit@ahduyck-workstation>
In-Reply-To: 
 <159055235065.209072.12017445428967301686.stgit@ahduyck-workstation>
References: 
 <159055235065.209072.12017445428967301686.stgit@ahduyck-workstation>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH v4 1/3] content: Document balloon feature page poison
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: mst@redhat.com, david@redhat.com, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, wei.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Page poison provides a way for the guest to notify the host that it is
initializing or poisoning freed pages with some specific poison value. As a
result of this we can infer a couple traits about the guest:

1. Free pages will contain a specific pattern within the guest.
2. Modifying free pages from this value may cause an error in the guest.
3. Pages will be immediately written to by the driver when deflated.

There are currently no existing features that make use of this data. In the
upcoming feature free page reporting we will need to make use of this to
identify if we can evict pages from the guest without causing data
corruption.

Add documentation for the page poison feature describing the basic
functionality and requirements.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 conformance.tex |    2 ++
 content.tex     |   59 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/conformance.tex b/conformance.tex
index b6fdec090383..4ed9d62e8088 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -149,6 +149,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{drivernormative:Device Types / Memory Balloon Device / Feature bits}
 \item \ref{drivernormative:Device Types / Memory Balloon Device / Device Operation}
 \item \ref{drivernormative:Device Types / Memory Balloon Device / Device Operation / Memory Statistics}
+\item \ref{drivernormative:Device Types / Memory Balloon Device / Device Operation / Page Poison}
 \end{itemize}
 
 \conformance{\subsection}{SCSI Host Driver Conformance}\label{sec:Conformance / Driver Conformance / SCSI Host Driver Conformance}
@@ -331,6 +332,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{devicenormative:Device Types / Memory Balloon Device / Feature bits}
 \item \ref{devicenormative:Device Types / Memory Balloon Device / Device Operation}
 \item \ref{devicenormative:Device Types / Memory Balloon Device / Device Operation / Memory Statistics}
+\item \ref{devicenormative:Device Types / Memory Balloon Device / Device Operation / Page Poison}
 \end{itemize}
 
 \conformance{\subsection}{SCSI Host Device Conformance}\label{sec:Conformance / Device Conformance / SCSI Host Device Conformance}
diff --git a/content.tex b/content.tex
index 91735e3eb018..4a0ab90260ff 100644
--- a/content.tex
+++ b/content.tex
@@ -5019,6 +5019,9 @@ \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Featu
     memory statistics is present.
 \item[VIRTIO_BALLOON_F_DEFLATE_ON_OOM (2) ] Deflate balloon on
     guest out of memory condition.
+\item[ VIRTIO_BALLOON_F_PAGE_POISON(4) ] A hint to the device, that the driver
+    will immediately write \field{poison_val} to pages after deflating them.
+    Configuration field \field{poison_val} is valid.
 
 \end{description}
 
@@ -5026,6 +5029,10 @@ \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Featu
 The driver SHOULD accept the VIRTIO_BALLOON_F_MUST_TELL_HOST
 feature if offered by the device.
 
+The driver SHOULD clear the VIRTIO_BALLOON_F_PAGE_POISON flag if it will
+not immediately write \field{poison_val} to deflated pages (e.g., to
+initialize them, or fill them with a poison value).
+
 \devicenormative{\subsubsection}{Feature bits}{Device Types / Memory Balloon Device / Feature bits}
 If the device offers the VIRTIO_BALLOON_F_MUST_TELL_HOST feature
 bit, and if the driver did not accept this feature bit, the
@@ -5042,13 +5049,17 @@ \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Featu
 VIRTIO_BALLOON_F_MUST_TELL_HOST is not negotiated.
 
 \subsection{Device configuration layout}\label{sec:Device Types / Memory Balloon Device / Device configuration layout}
-  Both fields of this configuration
-  are always available.
+  \field{num_pages} and \field{actual} are always available.
+
+  \field{poison_val} is available if VIRTIO_BALLOON_F_PAGE_POISON has been
+    negotiated.
 
 \begin{lstlisting}
 struct virtio_balloon_config {
         le32 num_pages;
         le32 actual;
+        le32 free_page_hint_cmd_id;
+        le32 poison_val;
 };
 \end{lstlisting}
 
@@ -5072,9 +5083,15 @@ \subsection{Device Initialization}\label{sec:Device Types / Memory Balloon Devic
   \begin{enumerate}
   \item Identify the stats virtqueue.
   \item Add one empty buffer to the stats virtqueue.
-  \item DRIVER_OK is set: device operation begins.
-  \item Notify the device about the stats virtqueue buffer.
   \end{enumerate}
+
+\item If the VIRTIO_BALLOON_F_PAGE_POISON feature bit is negotiated, the
+  driver updates the \field{poison_val} configuration field.
+
+\item DRIVER_OK is set: device operation begins.
+
+\item If the VIRTIO_BALLOON_F_STATS_VQ feature bit is negotiated, then
+  notify the device about the stats virtqueue buffer.
 \end{enumerate}
 
 \subsection{Device Operation}\label{sec:Device Types / Memory Balloon Device / Device Operation}
@@ -5345,6 +5362,40 @@ \subsubsection{Memory Statistics Tags}\label{sec:Device Types / Memory Balloon D
   allocations in the guest.
 \end{description}
 
+\subsubsection{Page Poison}\label{sec:Device Types / Memory Balloon Device / Device Operation / Page Poison}
+
+Page Poison provides a way to notify the host that the guest is initializing
+free pages with \field{poison_val}. When the feature is enabled, pages will
+be immediately written to by the driver after deflating.
+
+If the guest is not initializing freed pages the driver should reject the
+VIRTIO_BALLOON_F_PAGE_POISON feature.
+
+If VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated, the driver
+will place the initialization value into the \field{poison_val}
+configuration field data.
+
+\drivernormative{\paragraph}{Page Poison}{Device Types / Memory Balloon Device / Device Operation / Page Poison}
+
+Normative statements in this section apply if the
+VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated.
+
+The driver MUST initialize the deflated pages with \field{poison_val} when
+they are reused by the driver.
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

