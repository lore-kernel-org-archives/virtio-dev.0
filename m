Return-Path: <jasowang@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Subject: [PATCH V2 2/2] virtio: introduce STOP status bit
Date: Tue,  6 Jul 2021 12:33:34 +0800
Message-Id: <20210706043334.36359-3-jasowang@redhat.com>
In-Reply-To: <20210706043334.36359-1-jasowang@redhat.com>
References: <20210706043334.36359-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
To: mst@redhat.com, jasowang@redhat.com, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: stefanha@redhat.com, mgurtovoy@nvidia.com, cohuck@redhat.com, eperezma@redhat.com, oren@nvidia.com, shahafs@nvidia.com, parav@nvidia.com, bodong@nvidia.com, amikheev@nvidia.com, pasic@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

This patch introduces a new status bit STOP. This will be
used by the driver to stop the device in order to safely fetch the
device state (virtqueue state) from the device.

This is a must for supporting migration.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 content.tex | 69 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 66 insertions(+), 3 deletions(-)

diff --git a/content.tex b/content.tex
index 8877b6f..284ead0 100644
--- a/content.tex
+++ b/content.tex
@@ -47,6 +47,10 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
 \item[DRIVER_OK (4)] Indicates that the driver is set up and ready to
   drive the device.
 
+\item[STOP (32)] When VIRTIO_F_STOP is negotiated, indicates that the
+  device has been stopped by the driver. This status bit is different
+  from the reset since the device state is preserved.
+
 \item[DEVICE_NEEDS_RESET (64)] Indicates that the device has experienced
   an error from which it can't recover.
 \end{description}
@@ -70,12 +74,38 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
 recover by issuing a reset.
 \end{note}
 
+If VIRTIO_F_STOP has been negotiated, the driver MUST NOT set STOP if
+DRIVER_OK is not set.
+
+If VIRTIO_F_STOP has been negotiated, to stop a device, after setting
+STOP, the driver MUST re-read the device status to ensure the STOP bit
+is set to synchronize with the device.
+
 \devicenormative{\subsection}{Device Status Field}{Basic Facilities of a Virtio Device / Device Status Field}
 The device MUST initialize \field{device status} to 0 upon reset.
 
 The device MUST NOT consume buffers or send any used buffer
 notifications to the driver before DRIVER_OK.
 
+If VIRTIO_F_STOP has not been negotiated, the device MUST ignore the
+write of STOP.
+
+If VIRTIO_F_STOP has been negotiated, after the driver writes STOP,
+the device MUST finish any pending operations like in flight requests
+or have its device specific way for driver to save the pending
+operations like in flight requests before setting the STOP status bit.
+
+If VIRTIO_F_STOP has been negotiated, the device MUST NOT consume
+buffers or send any used buffer notifications to the driver after
+STOP. The device MUST keep the configuration space unchanged and MUST
+NOT send configuration space change notification to the driver after
+STOP.
+
+If VIRTIO_F_STOP has been negotiated, after STOP, the device MUST
+preserve all the necessary state (the virtqueue states with the
+possible device specific states) that is required for restoring in the
+future.
+
 \label{sec:Basic Facilities of a Virtio Device / Device Status Field / DEVICENEEDSRESET}The device SHOULD set DEVICE_NEEDS_RESET when it enters an error state
 that a reset is needed.  If DRIVER_OK is set, after it sets DEVICE_NEEDS_RESET, the device
 MUST send a device configuration change notification to the driver.
@@ -474,8 +504,8 @@ \subsection{\field{Used State} Field}
 \begin{itemize}
 \item A driver MUST NOT set the virtqueue state before setting the
   FEATURE_OK status bit.
-\item A driver MUST NOT set the virtqueue state after setting the
-  DRIVER_OK status bit.
+\item A driver MUST NOT set the virtqueue state if DRIVER_OK status
+  bit is set without STOP status bit.
 \end{itemize}
 
 \devicenormative{\subsection}{Virtqueue State}{Basic Facilities of a Virtio Device / Virtqueue State}
@@ -488,7 +518,7 @@ \subsection{\field{Used State} Field}
 \item A device SHOULD ignore the write to the virtqueue state if the
 FEATURE_OK status bit is not set.
 \item A device SHOULD ignore the write to the virtqueue state if the
-DRIVER_OK status bit is set.
+DRIVER_OK status bit is set without STOP status bit.
 \end{itemize}
 
 If VIRTIO_F_RING_STATE has been negotiated, a device MAY has its
@@ -623,6 +653,36 @@ \section{Device Cleanup}\label{sec:General Initialization And Device Operation /
 
 Thus a driver MUST ensure a virtqueue isn't live (by device reset) before removing exposed buffers.
 
+\section{Virtqueue State Saving}
+
+If both VIRTIO_F_RING_STATE and VIRTIO_F_STOP have been negotiated. A
+driver MAY save the internal virtqueue state.
+
+\drivernormative{\subsection}{Virtqueue State Saving}{General Initialization And Device Operation / Virtqueue State Saving}
+
+Assuming the device is 'live'. The driver MUST follow this sequence to
+stop the device and save the virtqueue state:
+
+\begin{enumerate}
+\item Set the STOP status bit.
+
+\item Re-read \field{device status} until the STOP bit is set to
+  synchronize with the device.
+
+\item Read \field{available state} and save it.
+
+\item Read \field{used state} and save it.
+
+\item Read device specific virtqueue states if needed.
+
+\item Reset the device.
+\end{enumerate}
+
+The driver MAY perform device specific steps to save device specific sate.
+
+The driver MAY 'resume' the device by redoing the device initialization
+with the saved virtqueue state. See ref\{sec:General Initialization and Device Operation / Device Initialization}
+
 \chapter{Virtio Transport Options}\label{sec:Virtio Transport Options}
 
 Virtio can use various different buses, thus the standard is split
@@ -6713,6 +6773,9 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved Feature Bits}
   can set and get the device internal virtqueue state.
   See \ref{sec:Virtqueues / Virtqueue State}~\nameref{sec:Virtqueues / Virtqueue State}.
 
+  \item[VIRTIO_F_STOP(41)] This feature indicates that the driver can
+  stop the device.
+  See \ref{sec:Basic Facilities of a Virtio Device / Device Status Field}
 \end{description}
 
 \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
-- 
2.25.1

