Return-Path: <quic_svaddagi@quicinc.com>
Date: Fri, 13 Aug 2021 20:23:51 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Subject: [PATCH v2] virtio-mmio: Specify wait needed in driver during reset
Message-ID: <20210813145351.GA5604@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
To: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, tsoni@quicinc.com, pratikp@quicinc.com
List-ID: <virtio-dev.lists.oasis-open.org>

Reset of a virtio-mmio device is initiated by writing 0 to its Status
register. The reset operation itself may or may not be completed by the time
write instruction completes. For devices that are emulated in software, writes
to Status register are trapped and resumed only after the reset operation is
complete. Thus a driver can be assured of reset completion as soon as its write
completes. That may not be however true in other cases, such as when virtio-mmio
devices implemented directly in hardware. Driver's write to Status register in
such case could complete before the device reset operation is completed.

Update the specification to indicate when a driver may need to poll for reset
completion before going ahead with the remaining initialization steps.
    
Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>

---
V2->V1:
- Use version 0x3 as an indication for drivers to poll for reset completion
  (rather than base it on a new feature bit)

Previous version can be found at:

https://lists.oasis-open.org/archives/virtio-dev/202107/msg00168.html

 content.tex | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/content.tex b/content.tex
index 7cec1c3..b6b30a0 100644
--- a/content.tex
+++ b/content.tex
@@ -1730,9 +1730,9 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
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
@@ -1916,7 +1916,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
 
 The device MUST return 0x74726976 in \field{MagicValue}.
 
-The device MUST return value 0x2 in \field{Version}.
+The device MUST return either value 0x3 or 0x2 in \field{Version} based on its reset behavior. Drivers trigger reset of a device by writing 0 to \field{Status}. The reset operation itself may or may not be completed by the time write operation is complete. Devices whose reset operation completes synchronously with the write operation are allowed to return value of 0x2 for \field{Version}. Other devices, whose reset operation can be incomplete by the time write operation completes MUST return value 0x3 as an indication for drivers to poll for reset completion.
 
 The device MUST present each event by setting the corresponding bit in \field{InterruptStatus} from the
 moment it takes place, until the driver acknowledges the interrupt
@@ -1947,12 +1947,15 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
 The driver MUST ignore a device with \field{MagicValue} which is not 0x74726976,
 although it MAY report an error.
 
-The driver MUST ignore a device with \field{Version} which is not 0x2,
+The driver MUST ignore a device with \field{Version} which is neither 0x2 nor 0x3,
 although it MAY report an error.
 
 The driver MUST ignore a device with \field{DeviceID} 0x0,
 but MUST NOT report any error.
 
+After writing 0 to \field{Status}, which triggers a reset of device, the driver MUST wait for a read of
+\field{Status} to return 0 before proceeding with the remaining steps of initializing the device.
+
 Before reading from \field{DeviceFeatures}, the driver MUST write a value to \field{DeviceFeaturesSel}.
 
 Before writing to the \field{DriverFeatures} register, the driver MUST write a value to the \field{DriverFeaturesSel} register.


---

Qualcomm Innovation Center, Inc. is submitting the attached "feedback" as a
non-member to the virtio-dev mailing list for consideration and inclusion.

