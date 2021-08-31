Return-Path: <quic_svaddagi@quicinc.com>
Date: Tue, 31 Aug 2021 19:27:53 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Subject: [PATCH v3] virtio-mmio: Specify wait needed in driver during reset
Message-ID: <20210831135753.GG9207@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
To: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, tsoni@quicinc.com
List-ID: <virtio-dev.lists.oasis-open.org>

Reset of a virtio-mmio device is initiated by writing 0 to its Status register.
In case of some devices, the reset operation itself may not be completed
by the time write instruction completes and hence such devices would require
drivers to wait on reset operation to complete before they proceed with
remaining steps of initialization.

Update the specification to indicate which devices would need driver to block on
reset completion.

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
---
v3->v2:
- Introduce a new status bit, DEVICE_RESET_IN_PROGRESS
- Limit driver need to poll for reset completion only for MMIO devices having
  Version = 0x3 

Previous version can be found at:

https://lists.oasis-open.org/archives/virtio-dev/202108/msg00065.html

 content.tex | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/content.tex b/content.tex
index 7cec1c3..e10f7d3 100644
--- a/content.tex
+++ b/content.tex
@@ -49,6 +49,8 @@ \section{\field{Device Status} Field}\label{sec:Basic Facilities of a Virtio Dev
 
 \item[DEVICE_NEEDS_RESET (64)] Indicates that the device has experienced
   an error from which it can't recover.
+
+\item[DEVICE_RESET_IN_PROGRESS (256)] Indicates that the device reset is in progress.
 \end{description}
 
 The \field{device status} field starts out as 0, and is reinitialized to 0 by
@@ -1730,9 +1732,9 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
   } 
   \hline
   \mmioreg{Version}{Device version number}{0x004}{R}{%
-    0x2.
+    0x3.
     \begin{note}
-      Legacy devices (see \ref{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}~\nameref{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}) used 0x1.
+      Legacy devices (see \ref{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}~\nameref{sec:Virtio Transport Options / Virtio Over MMIO / Legacy interface}) used 0x1. Devices that do not require drivers to poll for reset completion can use 0x2. See \ref{devicenormative:Virtio Transport Options / Virtio Over MMIO / MMIO Device Register Layout} for more details.
     \end{note}
   }
   \hline 
@@ -1916,7 +1918,15 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
 
 The device MUST return 0x74726976 in \field{MagicValue}.
 
-The device MUST return value 0x2 in \field{Version}.
+The device MUST return either value 0x3 or 0x2 in \field{Version} based on its reset behavior. Drivers trigger reset
+of a device by writing 0 to \field{Status}. The reset operation itself may or may not be completed by the time write
+operation is complete. Devices whose reset operation completes synchronously with the write operation are allowed to
+return value of 0x2 for \field{Version}. Other devices, whose reset operation can be incomplete by the time write
+operation completes MUST return value 0x3 as an indication for drivers to poll for reset completion. Such devices
+MUST indicate progress of reset operation in \field{Status}, with value of DEVICE_RESET_IN_PROGRESS indicating reset
+operation is still in progress, a value of 0x0 indicating reset operation is complete and a value of
+DEVICE_NEEDS_RESET indicating device has experienced an error and that reset operation could not be completed
+successfully.
 
 The device MUST present each event by setting the corresponding bit in \field{InterruptStatus} from the
 moment it takes place, until the driver acknowledges the interrupt
@@ -1947,9 +1957,14 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
 The driver MUST ignore a device with \field{MagicValue} which is not 0x74726976,
 although it MAY report an error.
 
-The driver MUST ignore a device with \field{Version} which is not 0x2,
+The driver MUST ignore a device with \field{Version} which is neither 0x2 nor 0x3,
 although it MAY report an error.
 
+When \field{Version} is 0x3, the driver, after initiating reset of device by
+writing 0 to \field{Status}, MUST wait for device reset operation to complete.
+Further, when \field{Version} is 0x3, the driver MUST not access any register other than
+reading \field{Status} while device reset is in progress.
+
 The driver MUST ignore a device with \field{DeviceID} 0x0,
 but MUST NOT report any error.
 


-- 
Qualcomm Innovation Center, Inc. is submitting the attached "feedback" as a
non-member to the virtio-dev mailing list for consideration and inclusion.

