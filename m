Return-Path: virtio-dev-return-6701-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D2C709860FB
	for <virtio-dev@lists.oasis-open.org>; Thu,  6 Feb 2020 10:21:39 +0000 (UTC)
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Thu,  6 Feb 2020 19:20:58 +0900
Message-Id: <20200206102058.247258-3-keiichiw@chromium.org>
In-Reply-To: <20200206102058.247258-1-keiichiw@chromium.org>
References: <20200206102058.247258-1-keiichiw@chromium.org>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v3 2/2] virtio-video: Define a feature for exported objects from different virtio devices
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: linux-media@vger.kernel.org, acourbot@chromium.org, alexlau@chromium.org, daniel@ffwll.ch, dgreid@chromium.org, dstaessens@chromium.org, dmitry.sepp@opensynergy.com, egranata@google.com, fziglio@redhat.com, hverkuil@xs4all.nl, keiichiw@chromium.org, kraxel@redhat.com, marcheu@chromium.org, posciak@chromium.org, spice-devel@lists.freedesktop.org, stevensd@chromium.org, tfiga@chromium.org, uril@redhat.com, samiullah.khawaja@opensynergy.com, kiran.pawar@opensynergy.com
List-ID: <virtio-dev.lists.oasis-open.org>

Define a new feature in the virtio-video protocol to use objects
exported from different virtio devices as video buffers.

Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>
---
 virtio-video.tex | 58 +++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 8 deletions(-)

diff --git a/virtio-video.tex b/virtio-video.tex
index 2eeee53..5d7451f 100644
--- a/virtio-video.tex
+++ b/virtio-video.tex
@@ -30,12 +30,16 @@ \subsection{Feature bits}
   non-contiguous memories for video buffers. Without this flag, the
   driver and device MUST use video buffers that are contiguous in the
   device-side.
+\item[VIRTIO_VIDEO_F_RESOURCE_VIRTIO_OBJECT (2)] Object exported by
+  another virtio device can be used for video buffers.
 \end{description}
=20
 \devicenormative{\subsubsection}{Feature bits}{Device Types / Video
   Device / Feature bits}
=20
-The device MUST offer VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES.
+The device MUST offer at least either
+VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES or
+VIRTIO_VIDEO_F_RESOURCE_VIRTIO_OBJECT.
=20
 \subsection{Device configuration layout}
 \label{sec:Device Types / Video Device / Device configuration layout}
@@ -182,8 +186,9 @@ \subsubsection{Command Virtqueue}
 The device MUST return its capability with \field{
   virtio_video_capability_resp} that includes the following fields:
 \begin{description}
-\item[\field{num_descs}] is a number of \field{virtio_video_format_desc}
-  that follow. The value MUST not exceed 64.
+\item[\field{num_descs}] is a number of
+  \field{virtio_video_format_desc} that follow. The value MUST not
+  exceed 64.
 \end{description}
=20
 The format description \field{virtio_video_format_desc} is defined as
@@ -299,6 +304,7 @@ \subsubsection{Command Virtqueue}
 \begin{lstlisting}
 enum virtio_video_mem_type {
         VIRTIO_VIDEO_MEM_TYPE_GUEST_PAGES,
+        VIRTIO_VIDEO_MEM_TYPE_VIRTIO_OBJECT,
 };
=20
 struct virtio_video_stream_create {
@@ -310,13 +316,19 @@ \subsubsection{Command Virtqueue}
         u8 tag[64];
 };
 \end{lstlisting}
+
 \begin{description}
 \item[\field{in_mem_type, out_mem_type}] is a type of buffer
-  management for input /output buffers. The driver MUST set a value in
+  management for input/output buffers. The driver MUST set a value in
   \field{enum virtio_video_mem_type} that the device reported a
   corresponding feature bit.
 \begin{description}
-\item[\field{VIRTIO_VIDEO_MEM_TYPE_GUEST_PAGES}] Use guest pages.
+\item[\field{VIRTIO_VIDEO_MEM_TYPE_GUEST_PAGES}] Use guest pages. The
+  driver MUST not set this value if a feature bit
+  VIRTIO_VIDEO_F_RESOURCE_GUEST_PAGES is not set.
+\item[\field{VIRTIO_VIDEO_MEM_TYPE_VIRTIO_OBJECT}] Use object exported
+  by another virtio device. The driver MUST not set this value if a
+  feature bit VIRTIO_VIDEO_F_RESOURCE_VIRTIO_OBJECT is not set.
 \end{description}
 \item[\field{coded_format}] is the encoded format that will be
   processed.
@@ -365,7 +377,13 @@ \subsubsection{Command Virtqueue}
         le32 num_planes;
         le32 plane_offsets[VIRTIO_VIDEO_MAX_PLANES];
         le32 num_entries[VIRTIO_VIDEO_MAX_PLANES];
-        /* Followed by struct virtio_video_mem_entry entries[] */
+        /*
+         * Followed by either
+         * - struct virtio_video_mem_entry entries[]
+         *   for VIRTIO_VIDEO_MEM_TYPE_GUEST_PAGES
+         * - struct virtio_video_object_entry entries[]
+         *   for VIRTIO_VIDEO_MEM_TYPE_VIRTIO_OBJECT
+         */
 };
 \end{lstlisting}
 \begin{description}
@@ -387,8 +405,13 @@ \subsubsection{Command Virtqueue}
   used.
 \end{description}
=20
-The \field{virtio_video_resource_create} is followed by an array of
-\field{virtio_video_mem_entry} defined as follows:
+The data following \field{virtio_video_resource_create} depend on a
+type of \field{virtio_video_mem_type} specified in
+\field{virtio_video_stream_create}.
+\begin{itemize*}
+\item When \field{VIRTIO_VIDEO_MEM_TYPE_GUEST_PAGES} was specified,
+  \field{virtio_video_resource_create} is followed by an array of
+  \field{virtio_video_mem_entry} defined as follows:
 \begin{lstlisting}
 struct virtio_video_mem_entry {
         le64 addr;
@@ -403,6 +426,25 @@ \subsubsection{Command Virtqueue}
 The number of \field{virtio_video_mem_entry} MUST be equal to the sum
 of integers in the array \field{num_entries}.
=20
+\item When \field{VIRTIO_VIDEO_MEM_TYPE_VIRTIO_OBJECT} was specified,
+  \field{virtio_video_resource_create} is followed by an array of
+  \field{virtio_video_object_entry} defined as follows:
+
+\begin{lstlisting}
+struct virtio_video_object_entry {
+        le64 uuid_low;
+        le64 uuid_high;
+};
+\end{lstlisting}
+\begin{description}
+\item[\field{uuid_low, uuid_high}] is a UUID of the resource.
+\end{description}
+If \field{planes_layout} is VIRTIO_VIDEO_PLANES_LAYOUT_SINGLE_BUFFER,
+the number of \field{virtio_video_object_entry} MUST be one. If it is
+VIRTIO_VIDEO_PLANES_LAYOUT_PER_PLANE, the number MUST be equal to
+\field{num_planes}.
+\end{itemize*}
+
 \item[VIRTIO_VIDEO_CMD_RESOURCE_DESTROY_ALL] Invalidate all the
   resource descriptor created so far.
 \begin{lstlisting}
--=20
2.25.0.341.g760bfbb309-goog


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

