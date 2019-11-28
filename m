Return-Path: virtio-dev-return-6422-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0B1EF985ECB
	for <virtio-dev@lists.oasis-open.org>; Thu, 28 Nov 2019 11:42:52 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 28 Nov 2019 12:42:43 +0100
Message-Id: <20191128114243.23511-1-kraxel@redhat.com>
Subject: [virtio-dev] [PATCH] virtio-gpu: some edid clarifications
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Add some notes about fetching the EDID information.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 virtio-gpu.tex | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/virtio-gpu.tex b/virtio-gpu.tex
index af4ca610d235..15dbf9f2ec82 100644
--- a/virtio-gpu.tex
+++ b/virtio-gpu.tex
@@ -70,16 +70,21 @@ \subsubsection{Events}
 \begin{description}
 \item[VIRTIO_GPU_EVENT_DISPLAY] Display configuration has changed.
   The driver SHOULD use the VIRTIO_GPU_CMD_GET_DISPLAY_INFO command to
-  fetch the information from the device.
+  fetch the information from the device.  In case EDID support is
+  negotiated (VIRTIO_GPU_F_EDID feature flag) the device SHOULD also
+  fetch the updated EDID blobs using the VIRTIO_GPU_CMD_GET_EDID
+  command.
 \end{description}
=20
 \devicenormative{\subsection}{Device Initialization}{Device Types / GPU De=
vice / Device Initialization}
=20
 The driver SHOULD query the display information from the device using
 the VIRTIO_GPU_CMD_GET_DISPLAY_INFO command and use that information
-for the initial scanout setup.  In case no information is available or
-all displays are disabled the driver MAY choose to use a fallback,
-such as 1024x768 at display 0.
+for the initial scanout setup.  In case EDID support is negotiated
+(VIRTIO_GPU_F_EDID feature flag) the device SHOULD also fetch the EDID
+information using the VIRTIO_GPU_CMD_GET_EDID command.  If no
+information is available or all displays are disabled the driver MAY
+choose to use a fallback, such as 1024x768 at display 0.
=20
 \subsection{Device Operation}\label{sec:Device Types / GPU Device / Device=
 Operation}
=20
--=20
2.18.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

