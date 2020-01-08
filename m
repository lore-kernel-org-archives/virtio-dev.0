Return-Path: virtio-dev-return-6611-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3FAFD985E03
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Jan 2020 09:02:14 +0000 (UTC)
MIME-Version: 1.0
From: David Stevens <stevensd@chromium.org>
Date: Wed, 8 Jan 2020 18:02:02 +0900
Message-ID: <CAD=HUj5U-TxqbPJiRRbyMHON21sht75q3nisvwvKrO+Bf=n8ng@mail.gmail.com>
Subject: [virtio-dev][RFC PATCH v1 2/2] virtio-gpu: add the ability to export resources
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org, Gerd Hoffmann <kraxel@redhat.com>, Dylan Reid <dgreid@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Zach Reizner <zachr@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, Gurchetan Singh <gurchetansingh@chromium.org>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Signed-off-by: David Stevens <stevensd@chromium.org>
---
 virtio-gpu.tex | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/virtio-gpu.tex b/virtio-gpu.tex
index af4ca61..522f478 100644
--- a/virtio-gpu.tex
+++ b/virtio-gpu.tex
@@ -186,12 +186,16 @@ \subsubsection{Device Operation: Request
header}\label{sec:Device Types / GPU De
         VIRTIO_GPU_CMD_UPDATE_CURSOR =3D 0x0300,
         VIRTIO_GPU_CMD_MOVE_CURSOR,

+        /* misc commands */
+        VIRTIO_GPU_CMD_EXPORT_RESOURCE =3D 0x0400,
+
         /* success responses */
         VIRTIO_GPU_RESP_OK_NODATA =3D 0x1100,
         VIRTIO_GPU_RESP_OK_DISPLAY_INFO,
         VIRTIO_GPU_RESP_OK_CAPSET_INFO,
         VIRTIO_GPU_RESP_OK_CAPSET,
         VIRTIO_GPU_RESP_OK_EDID,
+        VIRTIO_GPU_RESP_OK_EXPORT_RESOURCE,

         /* error responses */
         VIRTIO_GPU_RESP_ERR_UNSPEC =3D 0x1200,
@@ -454,6 +458,31 @@ \subsubsection{Device Operation:
controlq}\label{sec:Device Types / GPU Device /
 This detaches any backing pages from a resource, to be used in case of
 guest swapping or object destruction.

+\item[VIRTIO_GPU_CMD_EXPORT_RESOURCE] Exports a resource for use by other
+  virtio devices. Request data is \field{struct
+    virtio_gpu_export_resource}.  Response type is
+  VIRTIO_GPU_RESP_OK_EXPORT_RESOURCE, response data is \field{struct
+    virtio_gpu_resp_export_resource}.
+
+\begin{lstlisting}
+struct virtio_gpu_export_resource {
+        struct virtio_gpu_ctrl_hdr hdr;
+        le32 resource_id;
+        le32 padding;
+};
+
+struct virtio_gpu_resp_export_resource {
+        struct virtio_gpu_ctrl_hdr hdr;
+        le64 uuid_low;
+        le64 uuid_high;
+};
+\end{lstlisting}
+
+The response contains a uuid which identifies the host private resource to
+other virtio devices. Note that if the resource has an attached backing,
+modifications made to an exported resource by other devices are not visibl=
e
+in the attached backing until they are transferred into the backing.
+
 \end{description}

 \subsubsection{Device Operation: cursorq}\label{sec:Device Types /
GPU Device / Device Operation / Device Operation: cursorq}
--=20
2.24.1.735.g03f4e72817-goog

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

