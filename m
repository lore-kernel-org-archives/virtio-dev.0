Return-Path: virtio-dev-return-6428-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6AACF985EF6
	for <virtio-dev@lists.oasis-open.org>; Fri, 29 Nov 2019 08:31:44 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 29 Nov 2019 09:31:30 +0100
Message-Id: <20191129083130.15353-1-kraxel@redhat.com>
Subject: [virtio-dev] [PATCH] virtio-gpu: add 3d command overview
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Add 3d commands to the command enumeration.
Add a section with a very short overview.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 virtio-gpu.tex | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/virtio-gpu.tex b/virtio-gpu.tex
index eced3095a494..631aaf24ea18 100644
--- a/virtio-gpu.tex
+++ b/virtio-gpu.tex
@@ -213,6 +213,16 @@ \subsubsection{Device Operation: Request header}\label=
{sec:Device Types / GPU De
         VIRTIO_GPU_CMD_GET_EDID,
         VIRTIO_GPU_CMD_RESOURCE_CREATE_2D_SHARED,
=20
+        /* 3d commands (OpenGL) */
+        VIRTIO_GPU_CMD_CTX_CREATE =3D 0x0200,
+        VIRTIO_GPU_CMD_CTX_DESTROY,
+        VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE,
+        VIRTIO_GPU_CMD_CTX_DETACH_RESOURCE,
+        VIRTIO_GPU_CMD_RESOURCE_CREATE_3D,
+        VIRTIO_GPU_CMD_TRANSFER_TO_HOST_3D,
+        VIRTIO_GPU_CMD_TRANSFER_FROM_HOST_3D,
+        VIRTIO_GPU_CMD_SUBMIT_3D,
+
         /* cursor commands */
         VIRTIO_GPU_CMD_UPDATE_CURSOR =3D 0x0300,
         VIRTIO_GPU_CMD_MOVE_CURSOR,
@@ -488,6 +498,31 @@ \subsubsection{Device Operation: controlq}\label{sec:D=
evice Types / GPU Device /
=20
 \end{description}
=20
+\subsubsection{Device Operation: controlq (3d)}\label{sec:Device Types / G=
PU Device / Device Operation / Device Operation: controlq (3d)}
+
+These commands are supported by the device if the VIRTIO_GPU_F_VIRGL
+feature flag is set.
+
+\begin{description}
+
+\item[VIRTIO_GPU_CMD_CTX_CREATE]
+\item[VIRTIO_GPU_CMD_CTX_DESTROY]
+\item[VIRTIO_GPU_CMD_CTX_ATTACH_RESOURCE]
+\item[VIRTIO_GPU_CMD_CTX_DETACH_RESOURCE]
+  Manage OpenGL contexts.
+
+\item[VIRTIO_GPU_CMD_RESOURCE_CREATE_3D]
+  Create OpenGL resources.
+
+\item[VIRTIO_GPU_CMD_TRANSFER_TO_HOST_3D]
+\item[VIRTIO_GPU_CMD_TRANSFER_FROM_HOST_3D]
+  Transfer data from and to OpenGL resources.
+
+\item[VIRTIO_GPU_CMD_SUBMIT_3D]
+  Submit rendering commands (mesa gallium command stream).
+
+\end{description}
+
 \subsubsection{Device Operation: cursorq}\label{sec:Device Types / GPU Dev=
ice / Device Operation / Device Operation: cursorq}
=20
 Both cursorq commands use the same command struct.
--=20
2.18.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

