Return-Path: virtio-return-3051-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon,  9 Apr 2018 20:58:40 +0200
In-Reply-To: <1523300322-21989-1-git-send-email-pasic@linux.vnet.ibm.com>
References: <1523300322-21989-1-git-send-email-pasic@linux.vnet.ibm.com>
Message-Id: <1523300322-21989-4-git-send-email-pasic@linux.vnet.ibm.com>
Subject: [virtio] [PATCH 3/5] packed-packed: fix supplying buffers description
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

There was a discrepancy between the pseudo code and the
textual description of the algorithm describing how shall
a driver supply buffers to the device.

The textual description did not make sense to me, so I've
changed that one to be more in sync with the pseudo code.

Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
Still a bit shaky. Please review carefully! This patch
may as well be rooted in a terrible misunderstanding.
---
 packed-ring.tex |   64 ++++++++++++++++++++++++++++++-------------------------
 1 files changed, 35 insertions(+), 29 deletions(-)

diff --git a/packed-ring.tex b/packed-ring.tex
index e656fed..d93df3b 100644
--- a/packed-ring.tex
+++ b/packed-ring.tex
@@ -527,27 +527,12 @@ when using the packed virtqueue format in more detail.
 The driver offers buffers to one of the device's virtqueues as follows:
 
 \begin{enumerate}
-\item The driver places the buffer into free descriptor(s) in the Descriptor Ring.
-
-\item The driver performs a suitable memory barrier to ensure that it updates
-  the descriptor(s) before checking for notification suppression.
-
-\item If notifications are not suppressed, the driver notifies the device
-    of the new available buffers.
-\end{enumerate}
-
-What follows are the requirements of each stage in more detail.
-
-\subsubsection{Placing Available Buffers Into The Descriptor Ring}\label{sec:Basic Facilities of a Virtio Device / Virtqueues / Supplying Buffers to The Device / Placing Available Buffers Into The Descriptor Ring}
-
-For each buffer element, b:
-
-\begin{enumerate}
-\item Get the next descriptor ring entry, d
 \item Get the next free buffer id value
+\item For each buffer element, b:
+\begin{enumerate}
+\item Get the next free descriptor ring entry, d
 \item Set \field{d.addr} to the physical address of the start of b
 \item Set \field{d.len} to the length of b.
-\item Set \field{d.id} to the buffer id
 \item Calculate the flags as follows:
 \begin{enumerate}
 \item If b is device-writable, set the VIRTQ_DESC_F_WRITE bit to 1, otherwise 0
@@ -556,20 +541,41 @@ For each buffer element, b:
 \end{enumerate}
 \item Perform a memory barrier to ensure that the descriptor has
       been initialized
-\item Set \field{d.flags} to the calculated flags value
+\item If b is not the first buffer element set \field{d.flags} to the
+      calculated flags value, otherwise save it
 \item If d is the last descriptor in the ring, toggle the
-      Driver Ring Wrap Counter
+      Driver Ring Wrap Counter and reset d to the head of the ring
 \item Otherwise, increment d to point at the next descriptor
 \end{enumerate}
+\item Point d to the descriptor corresponding to the last buffer element
+      and set \field{d.id} to the buffer id
+\item Save some value associated with the buffer id that makes the
+      skipping forward described in section \ref{sec:Packed Virtqueues /
+      Indirect Flag: Scatter-Gather Support} and in section \ref{sec:Packed
+      Virtqueues / In-Order Use of Buffers}
+\item Point d to the descriptor corresponding to the first buffer element
+      and set \field{d.flags} to the value calculated and saved 
+\item The driver performs a suitable memory barrier to ensure that all
+      writes done up to this point precede  all writhes done after this
+      point as observed by the device.
+\item Point d to the descriptor corresponding to the first buffer element
+      and set \field{d.flags} to the value calculated and saved 
+\item The driver performs a suitable memory barrier to ensure that it updates
+  the descriptor(s) before checking for notification suppression.
+\item If notifications are not suppressed, the driver notifies the device
+    of the new available buffers.
+\end{enumerate}
 
-This makes a single descriptor buffer available. However, in
-general the driver MAY make use of a batch of descriptors as part
+This makes a single virtio buffer available. However, in
+general the driver MAY make use of a batch of buffers as part
 of a single request. In that case, it defers updating
-the descriptor flags for the first descriptor
-(and the previous memory barrier) until after the rest of
-the descriptors have been initialized.
+the descriptor flags for the first descriptor of the first
+virtio buffer (and the preceding memory barrier) until after the rest of
+the descriptors have been written. The notification steps are performed
+only after the after the flags of the first descriptor of the first
+virtio buffer are set.
 
-Once the descriptor \field{flags} field is updated by the driver, this exposes
+Once the \field{flags} field of the first descriptor is updated by the driver, this exposes
 the descriptor and its contents.  The device MAY
 access the descriptor and any following descriptors the driver created and the
 memory they refer to immediately.
@@ -577,9 +583,9 @@ memory they refer to immediately.
 \drivernormative{\paragraph}{Updating flags}{Basic Facilities of
 a Virtio Device / Packed Virtqueues / Supplying Buffers to The
 Device / Updating flags}
-The driver MUST perform a suitable memory barrier before the
-\field{flags} update, to ensure the
-device sees the most up-to-date copy.
+The driver MUST perform a suitable memory barrier before updating the
+\field{flags} of the first descriptor (to ensure the device sees
+all the previous changes) .
 
 \subsubsection{Notifying The Device}\label{sec:Basic Facilities
 of a Virtio Device / Packed Virtqueues / Supplying Buffers to The Device / Notifying The Device}
-- 
1.7.1


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

