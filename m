Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH] content.tex Fix Driver notifications label
Date: Fri, 3 Feb 2023 20:35:32 +0200
Message-ID: <20230203183532.90685-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Driver notifications section is under "Basic Facilities of a Virtio
Device". However, the label is placed under "Virtqueues" section.

Fix the label references.

Signed-off-by: Parav Pandit <parav@nvidia.com>
---
 content.tex | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/content.tex b/content.tex
index df5ce16..874714f 100644
--- a/content.tex
+++ b/content.tex
@@ -396,7 +396,7 @@ \subsubsection{Virtqueue Re-enable}\label{sec:Basic Fac=
ilities of a Virtio Devic
=20
 \input{packed-ring.tex}
=20
-\section{Driver Notifications} \label{sec:Virtqueues / Driver notification=
s}
+\section{Driver Notifications} \label{sec:Basic Facilities of a Virtio Dev=
ice / Driver notifications}
 The driver is sometimes required to send an available buffer
 notification to the device.
=20
@@ -1624,7 +1624,7 @@ \subsubsection{Available Buffer Notifications}\label{=
sec:Virtio Transport Option
 the following 32-bit value to the Queue Notify address:
 \lstinputlisting{notifications-le.c}
=20
-See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueues / =
Driver notifications}
+See \ref{sec:Basic Facilities of a Virtio Device / Driver notifications}~\=
nameref{sec:Basic Facilities of a Virtio Device / Driver notifications}
 for the definition of the components.
=20
 See \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device L=
ayout / Notification capability}
@@ -1879,7 +1879,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Vi=
rtio Transport Options / Vi
=20
     \lstinputlisting{notifications-le.c}
=20
-    See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueue=
s / Driver notifications}
+    See \ref{sec:Basic Facilities of a Virtio Device / Driver notification=
s}~\nameref{sec:Basic Facilities of a Virtio Device / Driver notifications}
     for the definition of the components.
   }
   \hline=20
@@ -2123,7 +2123,7 @@ \subsubsection{Available Buffer Notifications}\label{=
sec:Virtio Transport Option
 the following 32-bit value to \field{QueueNotify}:
 \lstinputlisting{notifications-le.c}
=20
-See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueues / =
Driver notifications}
+See \ref{sec:Basic Facilities of a Virtio Device / Driver notifications}~\=
nameref{sec:Basic Facilities of a Virtio Device / Driver notifications}
 for the definition of the components.
=20
 \subsubsection{Notifications From The Device}\label{sec:Virtio Transport O=
ptions / Virtio Over MMIO / MMIO-specific Initialization And Device Operati=
on / Notifications From The Device}
@@ -2845,7 +2845,7 @@ \subsubsection{Guest->Host Notification}\label{sec:Vi=
rtio Transport Options / Vi
 the value has the following format:
 \lstinputlisting{notifications-be.c}
=20
-See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueues / =
Driver notifications}
+See \ref{sec:Basic Facilities of a Virtio Device / Driver notifications}~\=
nameref{sec:Basic Facilities of a Virtio Device / Driver notifications}
 for the definition of the components.
=20
 \devicenormative{\paragraph}{Guest->Host Notification}{Virtio Transport Op=
tions / Virtio over channel I/O / Device Operation / Guest->Host Notificati=
on}
@@ -3091,12 +3091,12 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved =
Feature Bits}
   \item[VIRTIO_F_NOTIFICATION_DATA(38)] This feature indicates
   that the driver passes extra data (besides identifying the virtqueue)
   in its device notifications.
-  See \ref{sec:Virtqueues / Driver notifications}~\nameref{sec:Virtqueues =
/ Driver notifications}.
+  See \ref{sec:Basic Facilities of a Virtio Device / Driver notifications}=
~\nameref{sec:Basic Facilities of a Virtio Device / Driver notifications}.
=20
   \item[VIRTIO_F_NOTIF_CONFIG_DATA(39)] This feature indicates that the dr=
iver
   uses the data provided by the device as a virtqueue identifier in availa=
ble
   buffer notifications.
-  As mentioned in section \ref{sec:Virtqueues / Driver notifications}, whe=
n the
+  As mentioned in section \ref{sec:Basic Facilities of a Virtio Device / D=
river notifications}, when the
   driver is required to send an available buffer notification to the devic=
e, it
   sends the virtqueue number to be notified. The method of delivering
   notifications is transport specific.
--=20
2.26.2

