Return-Path: virtio-dev-return-4903-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D3BB7985BBF
	for <virtio-dev@lists.oasis-open.org>; Tue, 23 Oct 2018 13:13:09 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 23 Oct 2018 15:06:24 +0200
Message-Id: <20181023130624.10593-1-kraxel@redhat.com>
Subject: [virtio-dev] [PATCH v2] Add VIRTIO_GPU_F_EDID to virtio-gpu.
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The feature allows the guest request an EDID blob (describing monitor
capabilities) for a given scanout (aka virtual monitor connector).

It brings a new command message, which has just a scanout field (beside
the standard virtio-gpu header) and a response message which carries the
EDID data.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 virtio-gpu.tex | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/virtio-gpu.tex b/virtio-gpu.tex
index 5d4709a..fbb7936 100644
--- a/virtio-gpu.tex
+++ b/virtio-gpu.tex
@@ -34,6 +34,7 @@ control queue.
 
 \begin{description}
 \item[VIRTIO_GPU_F_VIRGL (0)] virgl 3D mode is supported.
+\item[VIRTIO_GPU_F_EDID  (1)] EDID is supported.
 \end{description}
 
 \subsection{Device configuration layout}\label{sec:Device Types / GPU Device / Device configuration layout}
@@ -171,6 +172,9 @@ enum virtio_gpu_ctrl_type {
         VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D,
         VIRTIO_GPU_CMD_RESOURCE_ATTACH_BACKING,
         VIRTIO_GPU_CMD_RESOURCE_DETACH_BACKING,
+        VIRTIO_GPU_CMD_GET_CAPSET_INFO,
+        VIRTIO_GPU_CMD_GET_CAPSET,
+        VIRTIO_GPU_CMD_GET_EDID,
 
         /* cursor commands */
         VIRTIO_GPU_CMD_UPDATE_CURSOR = 0x0300,
@@ -179,6 +183,9 @@ enum virtio_gpu_ctrl_type {
         /* success responses */
         VIRTIO_GPU_RESP_OK_NODATA = 0x1100,
         VIRTIO_GPU_RESP_OK_DISPLAY_INFO,
+        VIRTIO_GPU_RESP_OK_CAPSET_INFO,
+        VIRTIO_GPU_RESP_OK_CAPSET,
+        VIRTIO_GPU_RESP_OK_EDID,
 
         /* error responses */
         VIRTIO_GPU_RESP_ERR_UNSPEC = 0x1200,
@@ -275,6 +282,28 @@ The \field{enabled} field is set when the user enabled the display.
 It is roughly the same as the connected state of a phyiscal display
 connector.
 
+\item[VIRTIO_GPU_CMD_GET_EDID] Retrieve the EDID data for a given
+  scanout.  Request data is \field{struct virtio_gpu_get_edid}).
+  Response type is VIRTIO_GPU_RESP_OK_EDID, response data is
+  \field{struct virtio_gpu_resp_edid}.  Support is optional and
+  negotiated using the VIRTIO_GPU_F_EDID feature flag.
+
+\begin{lstlisting}
+struct virtio_gpu_get_edid {
+        struct virtio_gpu_ctrl_hdr hdr;
+        le32 scanout;
+};
+
+struct virtio_gpu_resp_edid {
+        struct virtio_gpu_ctrl_hdr hdr;
+        le32 size;
+        u8 edid[1024];
+};
+\end{lstlisting}
+
+The response contains the EDID display data blob (as specified by
+VESA) for the scanout.
+
 \item[VIRTIO_GPU_CMD_RESOURCE_CREATE_2D] Create a 2D resource on the
   host.  Request data is \field{struct virtio_gpu_resource_create_2d}.
   Response type is VIRTIO_GPU_RESP_OK_NODATA.
-- 
2.9.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

