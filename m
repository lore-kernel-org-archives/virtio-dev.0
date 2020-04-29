Return-Path: virtio-comment-return-1198-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Wed, 29 Apr 2020 11:57:45 -0700
Message-ID: <20200429185745.1248.48298.stgit@localhost.localdomain>
In-Reply-To: <20200429184122.1248.4817.stgit@localhost.localdomain>
References: <20200429184122.1248.4817.stgit@localhost.localdomain>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH RFC 1/3] content: Document balloon feature free page hints
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: cohuck@redhat.com, david@redhat.com, mst@redhat.com
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

From: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Free page hints allow the balloon driver to provide information on what
pages are not currently in use so that we can avoid the cost of copying
them in migration scenarios. Add a feature description for free page hints
describing basic functioning and requirements.

Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
---
 content.tex |  113 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 110 insertions(+), 3 deletions(-)

diff --git a/content.tex b/content.tex
index b91a132df146..796901e83a71 100644
--- a/content.tex
+++ b/content.tex
@@ -5006,9 +5006,12 @@ \subsection{Virtqueues}\label{sec:Device Types / Memory Balloon Device / Virtque
 \item[0] inflateq
 \item[1] deflateq
 \item[2] statsq.
+\item[3] free_page_vq.
 \end{description}
 
-  Virtqueue 2 only exists if VIRTIO_BALLOON_F_STATS_VQ set.
+  statsq only exists if VIRTIO_BALLOON_F_STATS_VQ set.
+
+  free_page_vq only exists if VIRTIO_BALLOON_F_FREE_PAGE_HINT set.
 
 \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Feature bits}
 \begin{description}
@@ -5019,6 +5022,10 @@ \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Featu
     memory statistics is present.
 \item[VIRTIO_BALLOON_F_DEFLATE_ON_OOM (2) ] Deflate balloon on
     guest out of memory condition.
+\item[ VIRTIO_BALLOON_F_FREE_PAGE_HINT(3) ] Device has support for free
+    page hinting. A virtqueue for providing hints as to what memory is
+    currently free is present. Configuration field free_page_hint_cmd_id
+    is valid.
 
 \end{description}
 
@@ -5042,13 +5049,15 @@ \subsection{Feature bits}\label{sec:Device Types / Memory Balloon Device / Featu
 VIRTIO_BALLOON_F_MUST_TELL_HOST is not negotiated.
 
 \subsection{Device configuration layout}\label{sec:Device Types / Memory Balloon Device / Device configuration layout}
-  Both fields of this configuration
-  are always available.
+  The first two fields of this configuration are always present. The
+  availability of the others all depend on various feature bits as
+  indicated above.
 
 \begin{lstlisting}
 struct virtio_balloon_config {
         le32 num_pages;
         le32 actual;
+        le32 free_page_hint_cmd_id;
 };
 \end{lstlisting}
 
@@ -5075,6 +5084,9 @@ \subsection{Device Initialization}\label{sec:Device Types / Memory Balloon Devic
   \item DRIVER_OK is set: device operation begins.
   \item Notify the device about the stats virtqueue buffer.
   \end{enumerate}
+
+\item If the VIRTIO_BALLOON_F_FREE_PAGE_HINT feature bit is negotiated the
+  free_page_vq is identified.
 \end{enumerate}
 
 \subsection{Device Operation}\label{sec:Device Types / Memory Balloon Device / Device Operation}
@@ -5345,6 +5357,101 @@ \subsubsection{Memory Statistics Tags}\label{sec:Device Types / Memory Balloon D
   allocations in the guest.
 \end{description}
 
+\subsubsection{Free Page Hinting}\label{sec:Device Types / Memory Balloon Device / Device Operation / Free Page Hinting}
+
+Free page hinting is used during migration to determine what pages within
+the guest are current unused so that they can be skipped over when it comes
+time for migration. The device will indicate that it is ready to start
+performing hinting by setting the \field{free_page_hint_cmd_id} to one of the
+non-reserved values that can be used as a command ID:
+
+\begin{description}
+\item[VIRTIO_BALLOON_CMD_ID_STOP (0)] Any previous command ID is invalid.
+  All hinting SHOULD halt until a new command ID is supplied.
+
+\item[VIRTIO_BALLOON_CMD_ID_DONE (1)] Any previous command ID is invalid.
+  All hinting SHOULD halt and pages returned to the guest for use.
+\end{description}
+
+A request for free page hintings proceeds as follows:
+
+\begin{enumerate}
+
+\item \field{free_page_hint_cmd_id} configuration field is examined. If it
+  contains a non-reserved value then inflation of the balloon will begin.
+
+\item To supply memory to the hinting balloon:
+  \begin{enumerate}
+  \item The driver constructs an output descriptor containing the new value
+    from \field{free_page_hint_cmd_id} configuration field and adds it to
+    the free_page_hint_vq.
+  \item The driver driver maps a series of pages and adds them to the
+    free_page_hint_vq as individual scatter-gather entries.
+  \item When the driver is no longer able to fetch additional pages to add
+    to the free_page_hint_vq it will construct an output descriptor
+    containing the command ID VIRTIO_BALLOON_CMD_ID_STOP.
+  \end{enumerate}
+
+\item A round of hinting ends either when the driver is no longer able to
+  add more pages to the balloon as described above, or when the device
+  updates \field{free_page_hint_cmd_id} configuration field contain either
+  VIRTIO_BALLOON_CMD_ID_STOP or VIRTIO_BALLOON_CMD_ID_DONE.
+
+\item The device may follow VIRTIO_BALLOON_CMD_ID_STOP with a new
+  non-reserved value for \field{free_page_hint_cmd_id} configuration field
+  in which case it will resume supplying the hinting balloon.
+
+\item Otherwise, if the device provides VIRTIO_BALLOON_CMD_ID_DONE then
+  hinting is complete and the guest may begin to re-use pages preivously
+  given to the balloon.
+
+\end{enumerate}
+
+\drivernormative{\paragraph}{Free Page Hinting}{Device Types / Memory Balloon Device / Device Operation / Free Page Hinting}
+
+Normative statements in this section apply if and only if  the
+VIRTIO_BALLOON_F_FREE_PAGE_HINT feature has been negotiated.
+
+The driver SHOULD supply pages to the hinting balloon when
+\field{free_page_hint_cmd_id} reports a value of 2 or greater.
+
+The driver MUST start hinting by providing an output descriptor
+containing the current command ID for the given block of pages.
+
+The driver SHOULD stop supplying pages to the hinting balloon when
+\field{free_page_hint_cmd_id} reports a value of VIRTIO_BALLOON_CMD_ID_STOP.
+
+If the driver is unable to supply pages it MUST complete hinting by adding
+an output descriptor containing the command ID VIRTIO_BALLOON_CMD_ID_STOP.
+
+The driver MAY use pages from the balloon after adding them to the balloon,
+including when the device has not acknowledged the hinting request.
+
+The driver SHOULD return pages for use once \field{free_page_hint_cmd_id}
+reports a value of VIRTIO_BALLOON_CMD_ID_DONE.
+
+\devicenormative{\paragraph}{Free Page Hinting}{Device Types / Memory Balloon Device / Device Operation / Free Page Hinting}
+
+Normative statements in this section apply if and only if  the
+VIRTIO_BALLOON_F_FREE_PAGE_HINT feature has been negotiated.
+
+The device MUST set \field{free_page_hint_cmd_id} to
+VIRTIO_BALLOON_CMD_ID_STOP any time that the host dirty bits for the given
+guest are being recorded.
+
+The device MUST guarantee that command ID is not reused until it has
+received an output descriptor containing VIRTIO_BALLOON_CMD_ID_STOP from
+the driver.
+
+The device MUST not perform hinting on pages that are provided with a
+command ID that does not match the current value in
+\field{free_page_hint_cmd_id}.
+
+The device MAY modify the contents of the page in the balloon at any time
+after detecting its physical number until it has either been written to by
+the guest or \field{free_page_hint_cmd_id} is set to
+VIRTIO_BALLOON_CMD_ID_DONE.
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

