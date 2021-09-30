Return-Path: <virtio-dev-return-8749-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5D5769865E9
	for <virtio-dev@lists.oasis-open.org>; Thu, 30 Sep 2021 09:18:19 +0000 (UTC)
From: Parav Pandit <parav@nvidia.com>
Date: Thu, 30 Sep 2021 12:17:59 +0300
Message-ID: <20210930091759.525267-1-parav@nvidia.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH] Add device reset timeout field
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: mgurtovoy@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, parav@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

Motivation:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Currently when driver initiates a device reset operation, a device may
not be able finish the reset operation immediately. In such case driver
waits for an arbitrary amount of time in a hope that device will finish
the reset. Depending on the device type and its backend implementation a
device timeout can be different. Trying to wait for all device type in
same value may not be efficient or adequate.

Proposal:
=3D=3D=3D=3D=3D=3D=3D=3D
Hence, enhance the specification to let device report a device reset
timeout value in milliseconds. Such hint helps driver to know how long
should it wait for device reset to finish.

This proposal introduces optional device reset timeout field for MMIO
and PCI transports. Such transports have a use case where virtio devices
are implemented in hardware and made available to the guest.

A device reset timeout field has following attributes.
(a) It is an optional field to maintain backward compatibility.
(b) It is valid only when device advertises a new feature bit
    VIRTIO_F_DEV_RESET_TO
(b) When it is not advertised, this field is invalid and driver should
    choose the reasonable reset timeout.
(c) It is a 16-bit field covering wide range of timeout from 10
milliseconds to several hundred seconds.

This proposal is an improvement over a past proposal [1].
Instead of just passing a flag for wait, this proposal offers upper bound
wait time making the device reset timeout and overall device initialization
more predictable.

[1] https://lists.oasis-open.org/archives/virtio-dev/202108/msg00161.html

Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Max Gurtovoy <mgurtovoy@nvidia.com>

---
changelog:
v1->v2:
- address comments from Max
- added comment that it is device specific for the new field
- added description to say that device reset timeout of zero is invalid
- fixed unit of the field in description
v0->v1:
- address comments from Shahaf, Max, Oren
- several grammar corrections
- changed timer granularity from 1msec to 10mec
- changed device reset timeout field from le32 to le16
- added VIRTIO_F_DEV_RESET_TO device feature bit
---
 content.tex | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/content.tex b/content.tex
index 37c45d3..d52daf9 100644
--- a/content.tex
+++ b/content.tex
@@ -73,6 +73,15 @@ \section{\field{Device Status} Field}\label{sec:Basic Fa=
cilities of a Virtio Dev
 recover by issuing a reset.
 \end{note}
=20
+Once the driver initiates a reset, the device may not be able to finish th=
e reset
+immediately. Such device provides a hint to the driver about how long a
+device may take to complete the reset. Driver should wait at least for the
+time specified by the device to let device finish the reset or if
+the device status field to become 0 within the specified time interval.
+Such driver initialization sequence specified in
+\ref{sec:General Initialization And Device Operation / Device
+Initialization}.
+
 \devicenormative{\subsection}{Device Status Field}{Basic Facilities of a V=
irtio Device / Device Status Field}
=20
 The device MUST NOT consume buffers or send any used buffer
@@ -210,11 +219,20 @@ \section{Device Reset}\label{sec:Basic Facilities of =
a Virtio Device / Device Re
 indicating completion of the reset by reinitializing \field{device status}
 to 0, until the driver re-initializes the device.
=20
+A device may not be able to complete reset action when the driver initiate=
s a reset operation.
+Such a device should provide the hint as to how long a device may take to =
finish the reset operation.
+This hint is provided by the device using device reset timeout field in un=
its of 10 milliseconds.
+
 \drivernormative{\subsection}{Device Reset}{Basic Facilities of a Virtio D=
evice / Device Reset}
=20
 The driver SHOULD consider a driver-initiated reset complete when it
 reads \field{device status} as 0.
=20
+When a device reports a non-zero device reset timeout value, the driver SH=
OULD wait for the device
+to finish the reset action during the initialization sequence before givin=
g up on the device. When
+device reset timeout is not provided by the device, driver SHOULD choose a=
 reasonable timeout
+value for reset operation to complete.
+
 \section{Device Configuration Space}\label{sec:Basic Facilities of a Virti=
o Device / Device Configuration Space}
=20
 Device configuration space is generally used for rarely-changing or
@@ -859,6 +877,8 @@ \subsubsection{Common configuration structure layout}\l=
abel{sec:Virtio Transport
         le64 queue_driver;              /* read-write */
         le64 queue_device;              /* read-write */
         le16 queue_notify_data;         /* read-only for driver */
+        /* About the whole device. */
+        le16 device_reset_timeout;      /* read-only for driver */
 };
 \end{lstlisting}
=20
@@ -938,6 +958,15 @@ \subsubsection{Common configuration structure layout}\=
label{sec:Virtio Transport
         may benefit from providing another value, for example an internal =
virtqueue
         identifier, or an internal offset related to the virtqueue number.
         \end{note}
+
+\item[\field{device_reset_timeout}]
+        This field exists only if the VIRTIO_F_DEV_RESET_TO is advertised =
by the device.
+        This field provides the hint to the driver indicating how much max=
imum time a
+        device can take to complete the reset once the driver initiates th=
e device reset
+        operation. This field unit is in 10 milliseconds. For example, a f=
ield value of
+        3 indicates device reset timeout is 30 milliseconds. When VIRTIO_F=
_DEV_RESET_TO
+=09feature is set by the device this field must contain a non zero value.
+
 \end{description}
=20
 \devicenormative{\paragraph}{Common configuration structure layout}{Virtio=
 Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common confi=
guration structure layout}
@@ -1804,6 +1833,15 @@ \subsection{MMIO Device Register Layout}\label{sec:V=
irtio Transport Options / Vi
     accesses apply to the queue selected by writing to \field{QueueSel}.
   }
   \hline=20
+  \mmioreg{DeviceResetTimeout}{Device reset timeout}{0x04c}{R}{%
+    This register exists only if the VIRTIO_F_DEV_RESET_TO is advertised b=
y the device.
+    It provides the hint to the driver indicating how much maximum time a
+    device can take to complete the reset once the driver initiates the de=
vice reset operation.
+    This field unit is in 10 milliseconds. For example, a field value of 3=
 indicates device
+    reset timeout is 30 milliseconds. When VIRTIO_F_DEV_RESET_TO feature i=
s set by the device
+    this field must contain a non zero value.
+  }
+  \hline
   \mmioreg{QueueNotify}{Queue notifier}{0x050}{W}{%
     Writing a value to this register notifies the device that
     there are new buffers to process in a queue.
@@ -6673,6 +6711,11 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved F=
eature Bits}
   transport specific.
   For more details about driver notifications over PCI see \ref{sec:Virtio=
 Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And =
Device Operation / Available Buffer Notifications}.
=20
+  \item[VIRTIO_F_DEV_RESET_TO(40)] This feature indicates that the device
+  advertises a maximum reset timeout which the driver should use during de=
vice reset stage.
+  For more details about device reset timeout over PCI see \ref{sec:Virtio=
 Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common confi=
guration structure layout}.
+  For more details about device reset timeout over MMIO see \ref{sec:Virti=
o Transport Options / Virtio Over MMIO / MMIO Device Register Layout}.
+
 \end{description}
=20
 \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bits}
--=20
2.31.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

