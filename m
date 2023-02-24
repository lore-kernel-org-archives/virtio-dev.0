Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: [PATCH v5 6/6] transport-ccw: Fix spellings and white spaces
Date: Sat, 25 Feb 2023 00:22:15 +0200
Message-ID: <20230224222215.339715-7-parav@nvidia.com>
In-Reply-To: <20230224222215.339715-1-parav@nvidia.com>
References: <20230224222215.339715-1-parav@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
To: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Now that we have individual files, fix reported spelling errors.

While at it, remove extra white spaces.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/157
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v1->v2:
- remove trailing white spaces
---
 transport-ccw.tex | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/transport-ccw.tex b/transport-ccw.tex
index 93401a4..c492cb9 100644
--- a/transport-ccw.tex
+++ b/transport-ccw.tex
@@ -56,13 +56,13 @@ \subsection{Basic Concepts}\label{sec:Virtio Transport =
Options / Virtio over cha
 \end{tabular}
=20
 A virtio-ccw proxy device facilitates:
-\begin{itemize}=20
+\begin{itemize}
 \item Discovery and attachment of virtio devices (as described above).
 \item Initialization of virtqueues and transport-specific facilities (usin=
g
       virtio-specific channel commands).
 \item Notifications (via hypercall and a combination of I/O interrupts
       and indicator bits).
-\end{itemize}=20
+\end{itemize}
=20
 \subsubsection{Channel Commands for Virtio}\label{sec:Virtio Transport Opt=
ions / Virtio
 over channel I/O / Basic Concepts/ Channel Commands for Virtio}
@@ -107,7 +107,7 @@ \subsubsection{Notifications}\label{sec:Virtio Transpor=
t Options / Virtio
 Host->Guest Notification / Notification via Classic I/O Interrupts} and
 \ref{sec:Virtio Transport Options / Virtio over channel I/O / Device
 Operation / Host->Guest Notification / Notification via Adapter I/O
-Interrupts} respectively.=20
+Interrupts} respectively.
=20
 Configuration change notifications are done using so-called classic I/O
 interrupts. The initialization is described in section \ref{sec:Virtio
@@ -413,7 +413,7 @@ \subsubsection{Setting Up Indicators}\label{sec:Virtio =
Transport Options / Virti
 \begin{itemize}
 \item a summary indicator byte covering the virtqueues for one or more
   virtio-ccw proxy devices
-\item a set of contigous indicator bits for the virtqueues for a
+\item a set of contiguous indicator bits for the virtqueues for a
   virtio-ccw proxy device
 \end{itemize}
=20
@@ -563,7 +563,7 @@ \subsubsection{Guest->Host Notification}\label{sec:Virt=
io Transport Options / Vi
=20
 \drivernormative{\paragraph}{Guest->Host Notification}{Virtio Transport Op=
tions / Virtio over channel I/O / Device Operation / Guest->Host Notificati=
on}
=20
-For each notification, the driver SHOULD use GPR4 to pass the host cookie =
received in GPR2 from the previous notication.
+For each notification, the driver SHOULD use GPR4 to pass the host cookie =
received in GPR2 from the previous notification.
=20
 \begin{note}
 For example:
--=20
2.26.2

