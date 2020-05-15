Return-Path: virtio-comment-return-1254-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Fri, 15 May 2020 10:33:24 -0700
Message-ID: 
 <158956400429.246123.15328266658164976911.stgit@ahduyck-workstation>
In-Reply-To: 
 <158956393696.246123.9443729217250549606.stgit@ahduyck-workstation>
References: 
 <158956393696.246123.9443729217250549606.stgit@ahduyck-workstation>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH v2 3/3] content: Document balloon feature free page reporting
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
 content.tex |   84 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+), 1 deletion(-)

diff --git a/content.tex b/content.tex
index 3d30fd5bb6fa..3cb38105f794 100644
--- a/content.tex
+++ b/content.tex
@@ -5007,12 +5007,15 @@ \subsection{Virtqueues}\label{sec:Device Types / Memory Balloon Device / Virtque
 \item[1] deflateq
 \item[2] statsq
 \item[3] free_page_vq
+\item[4] reporting_vq
 \end{description}
 
   statsq only exists if VIRTIO_BALLOON_F_STATS_VQ is set.
 
   free_page_vq only exists if VIRTIO_BALLOON_F_FREE_PAGE_HINT is set.
 
+  reporting_vq only exists if VIRTIO_BALLOON_F_PAGE_REPORTING is set.
+
 \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Feature bits}
 \begin{description}
 \item[VIRTIO_BALLOON_F_MUST_TELL_HOST (0)] Host has to be told before
@@ -5029,6 +5032,8 @@ \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Featu
 \item[ VIRTIO_BALLOON_F_PAGE_POISON(4) ] The device has to be notified if
     the driver is expecting balloon pages to contain a certain value when
     returned. Configuration field poison_val is valid.
+\item[ VIRTIO_BALLOON_F_PAGE_REPORTING(5) ] The device has support for free
+    page reporting. A virtqueue for reporting free guest memory is present.
 
 \end{description}
 
@@ -5039,6 +5044,10 @@ \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Featu
 The driver SHOULD clear the VIRTIO_BALLOON_F_PAGE_POISON flag if it is not
 expecting any specific value to be stored in the page.
 
+If the driver is expecting the pages to retain some initialized value,
+it MUST NOT accept VIRTIO_BALLOON_F_PAGE_REPORTING unless it also
+negotiates VIRTIO_BALLOON_F_PAGE_POISON.
+
 \devicenormative{\subsubsection}{Feature bits}{Device Types / Memory Balloon Device / Feature bits}
 If the device offers the VIRTIO_BALLOON_F_MUST_TELL_HOST feature
 bit, and if the driver did not accept this feature bit, the
@@ -5101,10 +5110,16 @@ \subsection{Device Initialization}\label{sec:Device Types / Memory Balloon Devic
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
+  begin reporting free pages to device.
 \end{enumerate}
 
 \subsection{Device Operation}\label{sec:Device Types / Memory Balloon Device / Device Operation}
@@ -5478,7 +5493,9 @@ \subsubsection{Page Poison}\label{sec:Device Types / Memory Balloon Device / Dev
 
 Page Poison provides a way to notify the host of the contents that are
 currently in the balloon pages, and those that are expected to be in the
-pages when they are pulled from the balloon.
+pages when they are pulled from the balloon. It is used for in-place
+reporting of pages without needing to pull them from the memory allocator
+of the guest.
 
 If VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated, the guest
 will place the expected poison value into the \field{poison_val}
@@ -5504,6 +5521,71 @@ \subsubsection{Page Poison}\label{sec:Device Types / Memory Balloon Device / Dev
 page hinting, the device MAY ignore the content of \field{poison_val}
 for those operations.
 
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
+\item The device acknowledges the reporting request by using the
+  reporting_vq descriptor.
+
+\item Once the device has acknowledged the report, the pages can be
+  returned to the location from which they were pulled.
+
+\item The driver can then continue to gather and report pages until it
+  has determined it has reported a sufficient quantity of pages.
+
+\end{enumerate}
+
+\drivernormative{\paragraph}{Free Page Reporting}{Device Types / Memory Balloon Device / Device Operation / Free Page Reporting}
+
+Normative statements in this section apply if the
+VIRTIO_BALLOON_F_PAGE_REPORTING feature has been negotiated.
+
+If the driver is expecting the free page to contain some initial value it
+MUST NOT negotiate this feature without negotiating the
+VIRTIO_BALLOON_F_PAGE_POISON feature as well and supply this value via
+\field{poison_val}.
+
+If the driver is expecting the pages to retain some initialized value,
+it MUST NOT accept VIRTIO_BALLOON_F_PAGE_REPORTING unless it also
+negotiates the VIRTIO_BALLOON_F_PAGE_POISON feature and supplies this
+value via \field{poison_val}.
+
+The driver MUST NOT use the reported pages until the device has
+acknowledged the reporting request.
+
+The driver MAY report free pages any time after DRIVER_OK is set.
+
+It is RECOMMENDED that the driver avoid unnecessary reads or writes to the
+page contents as this could reduce the performance for free page reporting.
+
+\devicenormative{\paragraph}{Free Page Reporting}{Device Types / Memory Balloon Device / Device Operation / Free Page Reporting}
+
+Normative statements in this section apply if the
+VIRTIO_BALLOON_F_PAGE_REPORTING feature has been negotiated.
+
+The device MAY modify the contents of any page supplied in a report
+request even before acknowledging that request by using the
+reporting_vq descriptor.
+
+If the VIRTIO_BALLOON_F_PAGE_POISON feature has been negotiated, the device
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

