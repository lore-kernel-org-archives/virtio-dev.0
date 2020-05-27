Return-Path: virtio-comment-return-1297-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Tue, 26 May 2020 21:06:56 -0700
Message-ID: <159055241638.209072.264568276038756294.stgit@ahduyck-workstation>
In-Reply-To: 
 <159055235065.209072.12017445428967301686.stgit@ahduyck-workstation>
References: 
 <159055235065.209072.12017445428967301686.stgit@ahduyck-workstation>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH v4 2/3] content: Document balloon feature free page reporting
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: mst@redhat.com, david@redhat.com, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, wei.w.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Free page reporting is a feature that allows the guest to proactively
report unused pages to the host. By making use of this feature is is
possible to reduce the overall memory footprint of the guest in cases where
some significant portion of the memory is idle. Add documentation for the
free page reporting feature describing the functionality and requirements.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 conformance.tex |    2 +
 content.tex     |   89 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 87 insertions(+), 4 deletions(-)

diff --git a/conformance.tex b/conformance.tex
index 4ed9d62e8088..18a5a94a72aa 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -150,6 +150,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{drivernormative:Device Types / Memory Balloon Device / Device Operation}
 \item \ref{drivernormative:Device Types / Memory Balloon Device / Device Operation / Memory Statistics}
 \item \ref{drivernormative:Device Types / Memory Balloon Device / Device Operation / Page Poison}
+\item \ref{drivernormative:Device Types / Memory Balloon Device / Device Operation / Free Page Reporting}
 \end{itemize}
 
 \conformance{\subsection}{SCSI Host Driver Conformance}\label{sec:Conformance / Driver Conformance / SCSI Host Driver Conformance}
@@ -333,6 +334,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{devicenormative:Device Types / Memory Balloon Device / Device Operation}
 \item \ref{devicenormative:Device Types / Memory Balloon Device / Device Operation / Memory Statistics}
 \item \ref{devicenormative:Device Types / Memory Balloon Device / Device Operation / Page Poison}
+\item \ref{devicenormative:Device Types / Memory Balloon Device / Device Operation / Free Page Reporting}
 \end{itemize}
 
 \conformance{\subsection}{SCSI Host Device Conformance}\label{sec:Conformance / Device Conformance / SCSI Host Device Conformance}
diff --git a/content.tex b/content.tex
index 4a0ab90260ff..403651d1413b 100644
--- a/content.tex
+++ b/content.tex
@@ -5005,10 +5005,13 @@ \subsection{Virtqueues}\label{sec:Device Types / Memory Balloon Device / Virtque
 \begin{description}
 \item[0] inflateq
 \item[1] deflateq
-\item[2] statsq.
+\item[2] statsq
+\item[4] reporting_vq
 \end{description}
 
-  Virtqueue 2 only exists if VIRTIO_BALLOON_F_STATS_VQ set.
+  statsq only exists if VIRTIO_BALLOON_F_STATS_VQ is set.
+
+  reporting_vq only exists if VIRTIO_BALLOON_F_PAGE_REPORTING is set.
 
 \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Feature bits}
 \begin{description}
@@ -5022,6 +5025,8 @@ \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Featu
 \item[ VIRTIO_BALLOON_F_PAGE_POISON(4) ] A hint to the device, that the driver
     will immediately write \field{poison_val} to pages after deflating them.
     Configuration field \field{poison_val} is valid.
+\item[ VIRTIO_BALLOON_F_PAGE_REPORTING(5) ] The device has support for free
+    page reporting. A virtqueue for reporting free guest memory is present.
 
 \end{description}
 
@@ -5033,6 +5038,10 @@ \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Featu
 not immediately write \field{poison_val} to deflated pages (e.g., to
 initialize them, or fill them with a poison value).
 
+If the driver is expecting the pages to retain some initialized value,
+it MUST NOT accept VIRTIO_BALLOON_F_PAGE_REPORTING unless it also
+negotiates VIRTIO_BALLOON_F_PAGE_POISON.
+
 \devicenormative{\subsubsection}{Feature bits}{Device Types / Memory Balloon Device / Feature bits}
 If the device offers the VIRTIO_BALLOON_F_MUST_TELL_HOST feature
 bit, and if the driver did not accept this feature bit, the
@@ -5088,10 +5097,16 @@ \subsection{Device Initialization}\label{sec:Device Types / Memory Balloon Devic
 \item If the VIRTIO_BALLOON_F_PAGE_POISON feature bit is negotiated, the
   driver updates the \field{poison_val} configuration field.
 
+\item If the VIRTIO_BALLOON_F_PAGE_REPORTING feature bit is negotiated the
+  reporting_vq is identified.
+
 \item DRIVER_OK is set: device operation begins.
 
 \item If the VIRTIO_BALLOON_F_STATS_VQ feature bit is negotiated, then
   notify the device about the stats virtqueue buffer.
+
+\item If the VIRTIO_BALLOON_F_PAGE_REPORTING feature bit is negotiated then
+  begin reporting free pages to the device.
 \end{enumerate}
 
 \subsection{Device Operation}\label{sec:Device Types / Memory Balloon Device / Device Operation}
@@ -5365,8 +5380,9 @@ \subsubsection{Memory Statistics Tags}\label{sec:Device Types / Memory Balloon D
 \subsubsection{Page Poison}\label{sec:Device Types / Memory Balloon Device / Device Operation / Page Poison}
 
 Page Poison provides a way to notify the host that the guest is initializing
-free pages with \field{poison_val}. When the feature is enabled, pages will
-be immediately written to by the driver after deflating.
+free pages with \field{poison_val}. When the feature is enabled, pages will be
+immediately written to by the driver after deflating, and pages reported by
+free page reporting will retain the value indicated by \field{poison_val}.
 
 If the guest is not initializing freed pages the driver should reject the
 VIRTIO_BALLOON_F_PAGE_POISON feature.
@@ -5396,6 +5412,71 @@ \subsubsection{Page Poison}\label{sec:Device Types / Memory Balloon Device / Dev
 The device MAY use the content of \field{poison_val} as a hint to guest
 behavior.
 
+\subsubsection{Free Page Reporting}\label{sec:Device Types / Memory Balloon Device / Device Operation / Free Page Reporting}
+
+Free Page Reporting provides a mechanism similar to balloon inflation,
+however it does not provide a deflation queue. Reported free pages can
+be reused by the driver after the reporting request has been acknowledged
+without notifying the device.
+
+The driver will begin reporting free pages. When exactly and which free
+pages are reported is up to the driver.
+
+\begin{enumerate}
+
+\item The driver determines it has enough pages available to begin
+  reporting free pages.
+
+\item The driver gathers free pages into a scatter-gather list and adds
+  them to the reporting_vq.
+
+\item The device acknowledges the reporting request by using the
+  reporting_vq descriptor.
+
+\item Once the device has acknowledged the report, the driver can reuse the
+  reported free pages when needed (e.g., by putting them back to free page
+  lists in the guest operating system).
+
+\item The driver can then continue to gather and report free pages until it
+  has determined it has reported a sufficient quantity of pages.
+
+\end{enumerate}
+
+\drivernormative{\paragraph}{Free Page Reporting}{Device Types / Memory Balloon Device / Device Operation / Free Page Reporting}
+
+Normative statements in this section apply if the
+VIRTIO_BALLOON_F_PAGE_REPORTING feature has been negotiated.
+
+If the VIRTIO_BALLOON_F_PAGE_POISON feature has not been negotiated, then
+the driver MUST treat all reported pages as uninitialized memory.
+
+If the VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated, the
+driver MUST initialize all free pages with \field{poison_val} before
+reporting them.
+
+The driver MUST NOT use the reported pages until the device has
+acknowledged the reporting request.
+
+The driver MAY report free pages any time after DRIVER_OK is set.
+
+The driver SHOULD attempt to report large pages rather than smaller ones.
+
+The driver SHOULD avoid reading/writing reported pages if
+not strictly necessary.
+
+\devicenormative{\paragraph}{Free Page Reporting}{Device Types / Memory Balloon Device / Device Operation / Free Page Reporting}
+
+Normative statements in this section apply if the
+VIRTIO_BALLOON_F_PAGE_REPORTING feature has been negotiated.
+
+If the VIRTIO_BALLOON_F_PAGE_POISON feature has not been negotiated, the
+device MAY modify the contents of any page supplied in a report request
+before acknowledging that request by using the reporting_vq descriptor.
+
+If the VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated, the device
+MUST NOT modify the the content of a reported page to a value other than
+\field{poison_val}.
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

