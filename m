Return-Path: <virtio-dev-return-9402-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0DDE8986523
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 Apr 2022 17:44:59 +0000 (UTC)
From: Usama Arif <usama.arif@bytedance.com>
Date: Fri,  8 Apr 2022 18:44:40 +0100
Message-Id: <20220408174441.1002578-4-usama.arif@bytedance.com>
In-Reply-To: <20220408174441.1002578-1-usama.arif@bytedance.com>
References: <20220408174441.1002578-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH v2 3/4] content: Introduce driver/device auxiliary notifications for MMIO
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: virtio-dev@lists.oasis-open.org
Cc: mst@redhat.com, stefanha@redhat.com, ndragazis@arrikto.com, fam.zheng@bytedance.com, liangma@liangbit.com, Usama Arif <usama.arif@bytedance.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This includes the additions to the corresponding device and driver
conformances.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
---
 content.tex | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/content.tex b/content.tex
index 18e7d9a..fcc6636 100644
--- a/content.tex
+++ b/content.tex
@@ -2053,6 +2053,8 @@ \subsection{MMIO Device Register Layout}\label{sec:Vi=
rtio Transport Options / Vi
         in at least one of the active virtual queues.
       \item [Configuration Change Notification] - bit 1 - the interrupt wa=
s
         asserted because the configuration of the device has changed.
+      \item [Device-specific Driver Auxiliary Notification] - bit 2 - the =
interrupt was
+        asserted because a device-specific event occurred to notify the dr=
iver.
     \end{description}
   }
   \hline=20
@@ -2125,6 +2127,19 @@ \subsection{MMIO Device Register Layout}\label{sec:V=
irtio Transport Options / Vi
     apply to the queue selected by writing to \field{QueueSel}.
   }
   \hline
+  \mmioreg{DeviceAuxNotificationIndex}{Device Auxiliary Notifier}{0xd0}{W}=
{
+    Writing to this register selects the device auxiliary
+    notification index to which \field{DeviceAuxiliaryNotificationData} ap=
ply to.
+    The number of device auxiliary notifications and their purpose is
+    device-specific.
+  }
+  \mmioreg{DeviceAuxNotificationData}{Device Auxiliary Notification Data}{=
0xd4}{W}{
+    Writing to this register notifies the device that a device auxiliary
+    notification has occured corresponding to the index indicated by
+    \field{DeviceAuxNotificationIndex}. The value written to this register=
 has
+    a device-specific meaning.
+  }
+  \hline
   \mmioreg{ConfigGeneration}{Configuration atomicity value}{0x0fc}{R}{
     Reading from this register returns a value describing a version of the=
 device-specific configuration space (see \field{Config}).
     The driver can then access the configuration space and, when finished,=
 read \field{ConfigGeneration} again.
@@ -2160,6 +2175,9 @@ \subsection{MMIO Device Register Layout}\label{sec:Vi=
rtio Transport Options / Vi
=20
 The device MUST NOT access virtual queue contents when \field{QueueReady} =
is zero (0x0).
=20
+The device MUST ignore device auxiliary notifications for invalid device a=
uxiliary notification
+indices.
+
 If VIRTIO_F_RING_RESET has been negotiated, the device MUST present a 0 in
 \field{QueueReady} after the driver has reset the virtqueue via
 \field{QueueReset}.
@@ -2242,6 +2260,8 @@ \subsubsection{Device Initialization}\label{sec:Virti=
o Transport Options / Virti
 Drivers not expecting shared memory MUST NOT use the shared
 memory registers.
=20
+Drivers not expecting device auxiliary notifications MUST NOT use the devi=
ce auxiliary notification register.
+
 Further initialization MUST follow the procedure described in
 \ref{sec:General Initialization And Device Operation / Device Initializati=
on}~\nameref{sec:General Initialization And Device Operation / Device Initi=
alization}.
=20
@@ -2295,8 +2315,9 @@ \subsubsection{Notifications From The Device}\label{s=
ec:Virtio Transport Options
 The memory mapped virtio device is using a single, dedicated
 interrupt signal, which is asserted when at least one of the
 bits described in the description of \field{InterruptStatus}
-is set. This is how the device sends a used buffer notification
-or a configuration change notification to the device.
+is set. This is how the device sends a
+used buffer/configuration change/device-specific notification to the
+device.
=20
 \drivernormative{\paragraph}{Notifications From The Device}{Virtio Transpo=
rt Options / Virtio Over MMIO / MMIO-specific Initialization And Device Ope=
ration / Notifications From The Device}
 After receiving an interrupt, the driver MUST read
--=20
2.25.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

