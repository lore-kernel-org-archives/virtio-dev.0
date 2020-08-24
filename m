Return-Path: virtio-comment-return-1425-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 24 Aug 2020 07:10:30 -0700
Message-ID: 
 <159827823015.192353.5798620534696342668.stgit@ahduyck-workstation>
In-Reply-To: 
 <159827814858.192353.8993077724330545555.stgit@ahduyck-workstation>
References: 
 <159827814858.192353.8993077724330545555.stgit@ahduyck-workstation>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH v7 2/3] content: Document balloon feature page poison
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

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 conformance.tex |    2 ++
 content.tex     |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

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
index 76dfce919b97..0569d633e3ba 100644
--- a/content.tex
+++ b/content.tex
@@ -5026,6 +5026,9 @@ \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Featu
     page hinting. A virtqueue for providing hints as to what memory is
     currently free is present. Configuration field \field{free_page_hint_cmd_id}
     is valid.
+\item[ VIRTIO_BALLOON_F_PAGE_POISON(4) ] A hint to the device, that the driver
+    will immediately write \field{poison_val} to pages after deflating them.
+    Configuration field \field{poison_val} is valid.
 
 \end{description}
 
@@ -5033,6 +5036,10 @@ \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Featu
 The driver SHOULD accept the VIRTIO_BALLOON_F_MUST_TELL_HOST
 feature if offered by the device.
 
+The driver SHOULD clear the VIRTIO_BALLOON_F_PAGE_POISON flag if it will
+not immediately write \field{poison_val} to deflated pages (e.g., to
+initialize them, or fill them with a poison value).
+
 \devicenormative{\subsubsection}{Feature bits}{Device Types / Memory Balloon Device / Feature bits}
 If the device offers the VIRTIO_BALLOON_F_MUST_TELL_HOST feature
 bit, and if the driver did not accept this feature bit, the
@@ -5054,12 +5061,15 @@ \subsection{Device configuration layout}\label{sec:Device Types / Memory Balloon
   \field{free_page_hint_cmd_id} is available if
     VIRTIO_BALLOON_F_FREE_PAGE_HINT has been negotiated and is read-only by
     the driver.
+  \field{poison_val} is available if VIRTIO_BALLOON_F_PAGE_POISON has been
+    negotiated.
 
 \begin{lstlisting}
 struct virtio_balloon_config {
         le32 num_pages;
         le32 actual;
         le32 free_page_hint_cmd_id;
+        le32 poison_val;
 };
 \end{lstlisting}
 
@@ -5087,6 +5097,8 @@ \subsection{Device Initialization}\label{sec:Device Types / Memory Balloon Devic
 
 \item If the VIRTIO_BALLOON_F_FREE_PAGE_HINT feature bit is negotiated,
   identify the free_page_vq.
+\item If the VIRTIO_BALLOON_F_PAGE_POISON feature bit is negotiated, update
+  the \field{poison_val} configuration field.
 
 \item DRIVER_OK is set: device operation begins.
 
@@ -5494,6 +5506,40 @@ \subsubsection{Free Page Hinting}\label{sec:Device Types / Memory Balloon Device
 endian of the guest rather than (necessarily when not using the legacy
 interface) little-endian.
 
+\subsubsection{Page Poison}\label{sec:Device Types / Memory Balloon Device / Device Operation / Page Poison}
+
+Page Poison provides a way to notify the host that the guest is initializing
+free pages with \field{poison_val}. When the feature is enabled, pages will
+be immediately written to by the driver after deflating.
+
+If the guest is not initializing freed pages, the driver should reject the
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

