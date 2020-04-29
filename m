Return-Path: virtio-comment-return-1200-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 29 Apr 2020 11:57:57 -0700
Message-ID: <20200429185757.1248.69725.stgit@localhost.localdomain>
In-Reply-To: <20200429184122.1248.4817.stgit@localhost.localdomain>
References: <20200429184122.1248.4817.stgit@localhost.localdomain>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH RFC 3/3] content: Document balloon feature free page
 reporting
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: cohuck@redhat.com, david@redhat.com, mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Free page reporting is a feature that allows the guest to proactively
report unused pages to the host. By making use of this feature is is
possible to reduce the overall memory footprint of the guest in cases where
some significant portion of the memory is idle. Add documentation for the
free page reporting feature describing the functionality and requirements.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 content.tex |   74 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/content.tex b/content.tex
index c98b8ea9526a..52955c8ff007 100644
--- a/content.tex
+++ b/content.tex
@@ -5007,12 +5007,15 @@ \subsection{Virtqueues}\label{sec:Device Types / Memory Balloon Device / Virtque
 \item[1] deflateq
 \item[2] statsq.
 \item[3] free_page_vq.
+\item[4] reporting_vq.
 \end{description}
 
   statsq only exists if VIRTIO_BALLOON_F_STATS_VQ set.
 
   free_page_vq only exists if VIRTIO_BALLOON_F_FREE_PAGE_HINT set.
 
+  reporting_vq only exists if VIRTIO_BALLOON_F_PAGE_REPORTING set.
+
 \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Feature bits}
 \begin{description}
 \item[VIRTIO_BALLOON_F_MUST_TELL_HOST (0)] Host has to be told before
@@ -5029,6 +5032,8 @@ \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Featu
 \item[ VIRTIO_BALLOON_F_PAGE_POISON(4) ] Host has to be notified if guest
     is expecting reported pages to contain a certain value when returned.
     Configuration field poison_val is valid.
+\item[ VIRTIO_BALLOON_F_PAGE_REPORTING(5) ] Device has support for free
+    page reporting. A virtqueue for reporting free guest memory is present.
 
 \end{description}
 
@@ -5039,6 +5044,10 @@ \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Featu
 The driver SHOULD clear the VIRTIO_BALLOON_F_PAGE_POISON flag if it is not
 expecting any specific value to be stored in the page.
 
+The driver MUST NOT accept VIRTIO_BALLOON_F_PAGE_REPORTING if it is expecting
+the pages to retain some initialized value and it has not negotiated
+VIRTIO_BALLOON_F_PAGE_POISON as a feature.
+
 \devicenormative{\subsubsection}{Feature bits}{Device Types / Memory Balloon Device / Feature bits}
 If the device offers the VIRTIO_BALLOON_F_MUST_TELL_HOST feature
 bit, and if the driver did not accept this feature bit, the
@@ -5097,6 +5106,13 @@ \subsection{Device Initialization}\label{sec:Device Types / Memory Balloon Devic
 
 \item If the VIRTIO_BALLOON_F_PAGE_POISON feature bit is negotiated then
   the driver MUST update the poison_val configuration field.
+
+\item If the VIRTIO_BALLOON_F_PAGE_REPORTING feature bit is negotiated:
+  \begin{enumerate}
+  \item Identify the reporting virtqueue.
+  \item DRIVER_OK is set: device operation begins.
+  \item Begin reporting free pages to device.
+  \end{enumerate}
 \end{enumerate}
 
 \subsection{Device Operation}\label{sec:Device Types / Memory Balloon Device / Device Operation}
@@ -5497,6 +5513,64 @@ \subsubsection{Page Poison}\label{sec:Device Types / Memory Balloon Device / Dev
 free page hinting as this feature did not exist prior to those features being
 added.
 
+\subsubsection{Free Page Reporting}\label{sec:Device Types / Memory Balloon Device / Device Operation / Free Page Reporting}
+
+Free Page Reporting provides a mechanism similar to balloon inflation,
+however it does not provide a deflation queue. The expectation is that the
+device will have a means by which it can detect the guest page access and
+fault in such pages with some initial value, likely a zero page.
+
+The driver will respond to to memory conditions and begin reporting free
+pages when some number of pages are available.
+
+\begin{enumerate}
+
+\item The driver determines it has enough pages available to begin
+  reporting pages.
+
+\item The driver gathers pages into a scatter-gather list and adds them to
+  the reporting_vq.
+
+\item The device acknowledges the reporting request.
+
+\item Once the device has acknowledged the report, the pages can be
+  returned to the location from which they were pulled.
+
+\item The driver can then continue to gather and report pages until it
+  has determined it has reported a suffcient quantity of pages.
+
+\end{enumerate}
+
+\drivernormative{\paragraph}{Free Page Reporting}{Device Types / Memory Balloon Device / Device Operation / Free Page Reporting}
+
+Normative statements in this section apply if and only if  the
+VIRTIO_BALLOON_F_PAGE_REPORTING feature has been negotiated.
+
+If the guest is expecting the free page to contain some initial value it
+MUST make use of the VIRTIO_BALLOON_F_PAGE_POISON feature to notify the
+device of this expectation via \field{poison_val}.
+
+The driver MUST NOT use the reported pages until the device has
+acknowledged the reporting request.
+
+The driver MAY report free pages any time after DRIVER_OK is set.
+
+It is RECOMMENDED that the driver avoid unecessary reads or writes to the
+page contents as this could reduce the performance for free page reporting.
+
+\devicenormative{\paragraph}{Free Page Reporting}{Device Types / Memory Balloon Device / Device Operation / Free Page Reporting}
+
+Normative statements in this section apply if and only if  the
+VIRTIO_BALLOON_F_PAGE_REPORTING feature has been negotiated.
+
+The device MAY modify the contents of a page in the report after detecting
+its physical number in an report request and before acknowledging the
+reporting request by using the reporting_vq descriptor.
+
+If the VIRTIO_BALLOON_F_PAGE_POISON feature is negotiated, the device
+SHALL NOT modify the the page if this will result in the page containing a
+value other than \field{poison_val}.
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

