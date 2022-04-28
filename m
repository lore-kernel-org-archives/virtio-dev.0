Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v3] virtio: Improve queue_reset polarity to match to default reset state
Date: Thu, 28 Apr 2022 04:50:41 +0300
Message-ID: <20220428015041.333836-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: virtio-dev@lists.oasis-open.org, xuanzhuo@linux.alibaba.com, jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com, virtio-comment@lists.oasis-open.org
Cc: stefanha@redhat.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Currently when driver initiates a queue reset, device is expected
to communicate reset status to the driver by changing the value of the
queue_reset register twice. First to return value other than 1 when
reset is ongoing, later to return 1 when queue reset is completed.

However initially during the device reset time the queue reset value
is zero. queue_reset changes the value of the register to a different
value on reset completion. Yet another time queue_reset value is
expected to change when queue_select is reprogrammed.

For example in below flow, a created virtqueue, which is disabled
by driver leaves the queue state as
queue_enable =3D 0, queue_reset =3D 1.

example flow:
a) 0,0 -> device init time value
b) 1,0 -> vq is enabled by driver and working
c) 1,1 -> vq is enabled, driver initiated reset
d) 0,0 -> queue reset is ongoing
   conflicts with #a, because queue is still enabled in device
   whose reset is in progress.
   External entity has no knowledge if VQ is undergoing reset or
   VQ is never enabled.
e) 0,1 -> queue reset is completed (conflicts with #a initial value)

On next iteration, when queue_select selects the same VQ again,
without enablement, device is confused to return 1 or 0 because
it was reset once before via queue_reset register.

This demands complex device implementation to understand what
should be returned for a VQ that is reset using queue_reset register
vs other means.

Additionally, external entity that may have to manage a virtio device
cannot distinguish between #a and #d, whether a VQ is not yet enabled
or it is in use and undergoing a reset.

Instead, it is better and efficient to maintain the same VQ state
on the device when queue reset is completed.

new proposed flow:
q_enable, q_reset
A) 0, 0 -> default, device init time
B) 1, 0 -> driver has enabled vq
C) 1, 1 -> driver started q reset
D) 1, 1 -> q_reset stays 1 until device is busy resetting vq
(device communicates that its working on resetting VQ, consistent with #C)
E) 0, 0 -> q_reset by device is completed, q got disabled
(consistent with device init time #A)

Hence, this patch proposes a simple change to have reset register
polarity to be same as that of initial reset value.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/139
Fixes: 12998e738621 ("virtio: pci support virtqueue reset")
Fixes: a4ce81a83780 ("virtio: mmio support virtqueue reset")
Fixes: 3b5378d70a42 ("virtio: introduce virtqueue reset as basic facility")
Signed-off-by: Parav Pandit <parav@nvidia.com>

---
changelog:
v2->v3:
- Updated the commit log to capture the problem more accurately
- Fixed below comments from Michael and Cornelia
- Fixed adding article 'the' before driver
- Change wording in driver requirements section to reflect driver
  requirements reflecting device behavior
- Added device compliance statement on what to return for queue_reset
  register to indicate ongoing reset in progress
- Moved device specific description adjacent to other device related
  queue reset description
v1->v2:
- Fixed below comment from Xuan Zhuo
- Fixed the configuration and register layout text to reflect the polarity
v0->v1:
- Fixed below comments from Michael
- Removed example device side pseudo code for old and new polarity
- Removed unwanted articles 'a' and 'the'
- Dropped extra empty line
---
 content.tex | 44 ++++++++++++++++++--------------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/content.tex b/content.tex
index 060bdab..c0b3f15 100644
--- a/content.tex
+++ b/content.tex
@@ -1029,19 +1029,15 @@ \subsubsection{Common configuration structure layou=
t}\label{sec:Virtio Transport
 The device MUST present a 0 in \field{queue_enable} on reset.
=20
 If VIRTIO_F_RING_RESET has been negotiated, the device MUST present a 0 in
-\field{queue_enable} after the driver has reset the virtqueue via
-\field{queue_reset}.
-
-If VIRTIO_F_RING_RESET has been negotiated, the device MUST present a 0 in
 \field{queue_reset} on reset.
=20
 If VIRTIO_F_RING_RESET has been negotiated, the device MUST present a 0 in
 \field{queue_reset} after the virtqueue is enabled with \field{queue_enabl=
e}.
=20
-The device MUST reset the queue when 1 is written to \field{queue_reset}, =
and
-present a 1 in \field{queue_reset} after the queue has been reset, until t=
he
-driver re-enables the queue via \field{queue_enable} or the device is rese=
t.
-The device MUST present consistent default values after queue reset.
+The device MUST reset the queue when 1 is written to \field{queue_reset}. =
The
+device MUST continue to present 1 in \field{queue_reset} when the queue re=
set
+is ongoing. The device MUST present 0 in \field{queue_reset} and \field{qu=
eue_enable}
+when queue reset completes.
 (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue=
 Reset}).
=20
 The device MUST present a 0 in \field{queue_size} if the virtqueue
@@ -1069,11 +1065,11 @@ \subsubsection{Common configuration structure layou=
t}\label{sec:Virtio Transport
 The driver MUST NOT write a 0 to \field{queue_enable}.
=20
 If VIRTIO_F_RING_RESET has been negotiated, after the driver writes 1 to
-\field{queue_reset} to reset the queue, it MUST verify that the queue
-has been reset by reading back \field{queue_reset} and ensuring that it
-is 1. The driver MAY re-enable the queue by writing a 1 to
-\field{queue_enable} after ensuring that the other virtqueue fields have
-been set up correctly. The driver MAY set driver-writeable queue configura=
tion
+\field{queue_reset} to reset the queue, the driver MUST NOT consider queue
+reset to be complete until it reads back 0 in both \field{queue_reset} and
+\field{queue_enable}. The driver MAY re-enable the queue by writing 1 to
+\field{queue_enable} after ensuring that other virtqueue fields have been
+set up correctly. The driver MAY set driver-writeable queue configuration
 values to different values than those that were used before the queue rese=
t.
 (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue=
 Reset}).
=20
@@ -2005,19 +2001,15 @@ \subsection{MMIO Device Register Layout}\label{sec:=
Virtio Transport Options / Vi
 The device MUST NOT access virtual queue contents when \field{QueueReady} =
is zero (0x0).
=20
 If VIRTIO_F_RING_RESET has been negotiated, the device MUST present a 0 in
-\field{QueueReady} after the driver has reset the virtqueue via
-\field{QueueReset}.
-
-If VIRTIO_F_RING_RESET has been negotiated, the device MUST present a 0 in
 \field{QueueReset} on reset.
=20
 If VIRTIO_F_RING_RESET has been negotiated, The device MUST present a 0 in
 \field{QueueReset} after the virtqueue is enabled with \field{QueueReady}.
=20
-The device MUST reset the queue when 1 is written to \field{QueueReset}, a=
nd
-present a 1 in \field{QueueReset} after the queue has been reset, until th=
e
-driver re-enables the queue via \field{QueueReady} or until the device is =
reset.
-The device MUST present consistent default values after queue reset.
+The device MUST reset the queue when 1 is written to \field{QueueReset}. T=
he
+device MUST continue to present 1 in \field{QueueReset} when the queue res=
et
+is ongoing. The device MUST present 0 in \field{QueueReset} and \field{Que=
ueReady}
+when queue reset completes.
 (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue=
 Reset}).
=20
 \drivernormative{\subsubsection}{MMIO Device Register Layout}{Virtio Trans=
port Options / Virtio Over MMIO / MMIO Device Register Layout}
@@ -2063,11 +2055,11 @@ \subsection{MMIO Device Register Layout}\label{sec:=
Virtio Transport Options / Vi
 it finishes handling an interrupt and MUST NOT set any of the undefined bi=
ts in the value.
=20
 If VIRTIO_F_RING_RESET has been negotiated, after the driver writes 1 to
-\field{QueueReset} to reset the queue, it MUST verify that the queue
-has been reset by reading back \field{QueueReset} and ensuring that it
-is 1. The driver MAY re-enable the queue by writing a 1 to
-\field{QueueReady} after ensuring that the other virtqueue fields have
-been set up correctly. The driver MAY set driver-writeable queue configura=
tion
+\field{QueueReset} to reset the queue, the driver MUST NOT consider queue
+reset to be complete until it reads back 0 in both \field{QueueReset} and
+\field{QueueReady}. The driver MAY re-enable the queue by writing 1 to
+\field{QueueReady} after ensuring that other virtqueue fields have been
+set up correctly. The driver MAY set driver-writeable queue configuration
 values to different values than those that were used before the queue rese=
t.
 (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue=
 Reset}).
=20
--=20
1.8.3.1

