Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v2] Add device reset timeout field
Date: Wed, 6 Oct 2021 17:10:33 +0300
Message-ID: <20211006141033.612283-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: cohuck@redhat.com, virtio-dev@lists.oasis-open.org, mst@redhat.com
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
- v1: https://lists.oasis-open.org/archives/virtio-dev/202110/msg00027.html
- Addressed below comments from Cornelia Huck
- fixed article 'the' addition before driver
- removed maximum from reset timeout
- fixed removed article 'the' from unwanted places
- changed 'feature is set' to 'feature offered'
- rewrote device reset timeout paragraph for driver handling
v0->v1:
- v0: https://lists.oasis-open.org/archives/virtio-dev/202109/msg00133.html
- Addressed below comments from Cornelia Huck
- renamed VIRTIO_F_DEV_RESET_TO to VIRTIO_F_DEV_RESET_TIMEOUT
- removed references to device initialization sequence during device
  reset flow
- rewrote 'giving up on device'
---
 content.tex | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/content.tex b/content.tex
index 37c45d3..9b1399f 100644
--- a/content.tex
+++ b/content.tex
@@ -73,6 +73,12 @@ \section{\field{Device Status} Field}\label{sec:Basic Fa=
cilities of a Virtio Dev
 recover by issuing a reset.
 \end{note}
=20
+Once the driver initiates a reset, the device may not be able to finish th=
e reset
+immediately. To accommodate that situation, the device can provide a hint =
to the
+driver about how long it might take the device to complete the reset. The =
driver should
+wait at least for the time specified by the device to let device finish th=
e reset or if
+the device status field to become 0 within the specified time interval.
+
 \devicenormative{\subsection}{Device Status Field}{Basic Facilities of a V=
irtio Device / Device Status Field}
=20
 The device MUST NOT consume buffers or send any used buffer
@@ -210,11 +216,23 @@ \section{Device Reset}\label{sec:Basic Facilities of =
a Virtio Device / Device Re
 indicating completion of the reset by reinitializing \field{device status}
 to 0, until the driver re-initializes the device.
=20
+A device may not be able to complete reset action immediately when the dri=
ver initiates a reset operation.
+Such a device should provide a hint as to how long a device may take to fi=
nish the reset operation.
+This hint is provided by the device via a device reset timeout value in un=
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
+to finish the reset action before considering the reset operation to have =
failed.
+When a device reports a non-zero device reset timeout value, the driver SH=
OULD wait for the device
+to finish the reset action. Once the specified timeout has expired, the dr=
iver should consider that reset
+operation has failed. When device reset timeout is not provided by the dev=
ice, the driver SHOULD choose a
+reasonable timeout value for reset operation to complete.
+
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
+        This field exists only if VIRTIO_F_DEV_RESET_TIMEOUT is advertised=
 by the device.
+        This field provides a hint to the driver indicating how much maxim=
um time a
+        device can take to complete the reset once the driver initiates th=
e device reset
+        operation. This field unit is in 10 milliseconds. For example, a f=
ield value of
+        3 indicates device reset timeout is 30 milliseconds. When VIRTIO_F=
_DEV_RESET_TIMEOUT
+=09feature is offered by the device this field must contain a non zero val=
ue.
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
+    This register exists only if VIRTIO_F_DEV_RESET_TIMEOUT is advertised =
by the device.
+    It provides the hint to the driver indicating how much maximum time a =
device can take
+    to complete the reset once the driver initiates the device reset opera=
tion.
+    This field unit is in 10 milliseconds. For example, a field value of 3=
 indicates device
+    reset timeout is 30 milliseconds. When VIRTIO_F_DEV_RESET_TIMEOUT feat=
ure is offered by the device
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
+  \item[VIRTIO_F_DEV_RESET_TIMEOUT(40)] This feature indicates that the de=
vice
+  advertises a reset timeout which the driver should use during device res=
et stage.
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

