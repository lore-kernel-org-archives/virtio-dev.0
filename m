Return-Path: <eperezma@redhat.com>
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
Subject: [PATCH v3 2/2] virtio: introduce STOP status bit
Date: Thu, 11 Nov 2021 19:58:12 +0100
Message-Id: <20211111185812.2326093-3-eperezma@redhat.com>
In-Reply-To: <20211111185812.2326093-1-eperezma@redhat.com>
References: <20211111185812.2326093-1-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, mst@redhat.com, jasowang@redhat.com
Cc: amikheev@nvidia.com, stefanha@redhat.com, shahafs@nvidia.com, oren@nvidia.com, pasic@linux.ibm.com, cohuck@redhat.com, bodong@nvidia.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, parav@nvidia.com, mgurtovoy@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: Jason Wang <jasowang@redhat.com>

This patch introduces a new status bit STOP. This can be used by the
driver to stop the device in order to safely fetch used descriptors
status, making sure the device will not fetch new available ones.

Its main use case is live migration, although it has other orthogonal
use cases. It can be used to safely discard requests that have not been
used: in other words, to rewind available descriptors.

Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 content.tex | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/content.tex b/content.tex
index 2aa3006..9ed0d09 100644
--- a/content.tex
+++ b/content.tex
@@ -47,6 +47,13 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
 \item[DRIVER_OK (4)] Indicates that the driver is set up and ready to
   drive the device.
 
+\item[STOP (16)] When VIRTIO_F_STOP is negotiated, indicates that the
+  device has been stopped by the driver. This status bit is different
+  from the reset since the device state is preserved.
+
+\item[STOP_FAILED (32)] When VIRTIO_F_STOP is negotiated, indicates that the
+  device could not stop the STOP request.
+
 \item[DEVICE_NEEDS_RESET (64)] Indicates that the device has experienced
   an error from which it can't recover.
 \end{description}
@@ -74,11 +81,83 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
 recover by issuing a reset.
 \end{note}
 
+If VIRTIO_F_STOP has been negotiated, the driver MUST NOT set or clear STOP if
+DRIVER_OK is not set.
+
+If VIRTIO_F_STOP has been negotiated the driver MUST re-read the device status
+to ensure the STOP or STOP_FAILED bit is set after the write. The device
+acknowledges the new paused status setting the first, or the failure setting
+the last. Since this change may not be instantaneous, the driver MAY wait for
+the configuration change notification that the device must send after the
+change. If the device sets the STOP_FAILED bit, the driver MUST clear it before
+try new STOP attempts.
+
+If VIRTIO_F_STOP has been negotiated and the device has confirmed its stop,
+the driver MAY change avail_idx in the case of split virtqueue, but the new
+avail_idx MUST be within used_idx and used_idx plus virtqueue size.
+
+If VIRTIO_F_STOP has been negotiated and the device has confirmed its stop,
+the driver MAY change any descriptor.
+
+If VIRTIO_F_STOP has been negotiated and the device has confirmed its stopped,
+the driver can resume it clearing the STOP status bit. It MUST re-read the
+device status to ensure the STOP bit is clear after the write. The device
+acknowledges the new status clearing it. Since this change may not be
+instantaneous, the driver MAY wait for the configuration change notification
+that the device must send after the change.
+
 \devicenormative{\subsection}{Device Status Field}{Basic Facilities of a Virtio Device / Device Status Field}
 
 The device MUST NOT consume buffers or send any used buffer
 notifications to the driver before DRIVER_OK.
 
+If VIRTIO_F_STOP has not been negotiated the device MUST ignore the write of
+STOP. If the DRIVER_OK status bit is not set the device SHOULD ignore the write
+or clear of STOP.
+
+If VIRTIO_F_STOP has been negotiated, the device MUST finish any in flight
+operations after the driver writes STOP.  Depending on the device, it can do it
+in many ways as long as the driver can recover its normal operation if it
+resumes the device without the need of resetting it:
+\begin{itemize}
+\item Drain and wait for the completion of all pending requests until a
+convenient avail descriptor. Ignore any other posterior descriptor.
+\item Return a device-specific failure for these descriptors, so the driver
+can choose to retry or to cancel them.
+\item Mark them as done even if they are not, if the kind of device can
+assume to lose them.
+\end{itemize}
+
+If VIRTIO_F_STOP has been negotiated and it needs to fail the device stop after
+a guest's request, the device MUST set the STOP_FAILED bit for the guest to
+read it. The device MUST ignore new writes to the STOP bit until the guest
+clears STOP_FAILED.
+
+If VIRTIO_F_STOP has been negotiated and the guest has written the STOP bit,
+and the device can pause its operation, the device MUST set the descriptors
+that it has done with them as used before exposing the STOP status bit as set.
+
+If VIRTIO_F_STOP has been negotiated, the device MUST NOT perform these actions
+after exposing the STOP bit set:
+\begin{itemize}
+\item Read updates on the descriptor or driver area, or consume more buffers.
+\item Send any used buffer notifications to the driver.
+\end{itemize}
+
+The device MUST send a configuration space change right after exposing the STOP
+or STOP_FAILED as set to the driver, and MUST NOT change configuration space or
+send another configuration space change notification to the driver afterwards
+until the guest clears it.
+
+If VIRTIO_F_STOP has been negotiated and STOP device status flag is set,
+the device MUST resume operation when the driver clears the STOP bit. The
+device MUST continue reading available descriptors as if an available buffer
+notification has reach it, starting from the last descriptor it marked as used,
+and continue the regular operation after that. The device MUST read again
+descriptor and driver area beyond the last descriptor it marked as used when it
+stopped, because the driver can change it. Device MUST set DEVICE_NEEDS_RESET
+if for some reason it cannot continue.
+
 \label{sec:Basic Facilities of a Virtio Device / Device Status Field / DEVICENEEDSRESET}The device SHOULD set DEVICE_NEEDS_RESET when it enters an error state
 that a reset is needed.  If DRIVER_OK is set, after it sets DEVICE_NEEDS_RESET, the device
 MUST send a device configuration change notification to the driver.
@@ -6694,6 +6773,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
   transport specific.
   For more details about driver notifications over PCI see \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Available Buffer Notifications}.
 
+\item[VIRTIO_F_STOP(41)] This feature indicates that the driver can
+  stop the device.
+  See \ref{sec:Basic Facilities of a Virtio Device / Device Status Field}.
+
 \end{description}
 
 \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
-- 
2.27.0

