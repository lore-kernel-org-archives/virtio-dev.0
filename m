Return-Path: virtio-return-3270-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 11 Mar 2019 11:59:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190311155947.29822-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio] [PATCH] editorial: explain each structure before use
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Several structures are listed before they are
introduced in some way. Add a sentence before each one
so they don't appear prior to any prose.

VIRTIO-166

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 content.tex       |  3 +++
 split-ring.tex    |  4 ++++
 virtio-crypto.tex |  2 ++
 virtio-gpu.tex    | 10 ++++++++--
 virtio-vsock.tex  |  2 ++
 5 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/content.tex b/content.tex
index f40d4fc..05fcb7b 100644
--- a/content.tex
+++ b/content.tex
@@ -3660,6 +3660,9 @@ send control commands for dynamic offloads state configuration.
 
 \subparagraph{Setting Offloads State}\label{sec:Device Types / Network Device / Device Operation / Control Virtqueue / Offloads State Configuration / Setting Offloads State}
 
+To configure the offloads, the following layout structure and
+definitions are used:
+
 \begin{lstlisting}
 le64 offloads;
 
diff --git a/split-ring.tex b/split-ring.tex
index 4e373d6..123ac9f 100644
--- a/split-ring.tex
+++ b/split-ring.tex
@@ -292,6 +292,8 @@ layout is valid.
 
 \subsection{The Virtqueue Available Ring}\label{sec:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Available Ring}
 
+The available ring has the following layout structure:
+
 \begin{lstlisting}
 struct virtq_avail {
 #define VIRTQ_AVAIL_F_NO_INTERRUPT      1
@@ -385,6 +387,8 @@ For example, if \field{used_event} is 0, then a device using
 
 \subsection{The Virtqueue Used Ring}\label{sec:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Used Ring}
 
+The used ring has the following layout structure:
+
 \begin{lstlisting}
 struct virtq_used {
 #define VIRTQ_USED_F_NO_NOTIFY  1
diff --git a/virtio-crypto.tex b/virtio-crypto.tex
index 4ae4933..4a15e14 100644
--- a/virtio-crypto.tex
+++ b/virtio-crypto.tex
@@ -183,6 +183,8 @@ operation requests, see \ref{sec:Device Types / Crypto Device / Device Operation
 
 \subsection{Device configuration layout}\label{sec:Device Types / Crypto Device / Device configuration layout}
 
+Crypto device configuration uses the following layout structure:
+
 \begin{lstlisting}
 struct virtio_crypto_config {
     le32 status;
diff --git a/virtio-gpu.tex b/virtio-gpu.tex
index 992d4e6..8687231 100644
--- a/virtio-gpu.tex
+++ b/virtio-gpu.tex
@@ -39,6 +39,9 @@ control queue.
 
 \subsection{Device configuration layout}\label{sec:Device Types / GPU Device / Device configuration layout}
 
+GPU device configuration uses the following layout structure and
+definitions:
+
 \begin{lstlisting}
 #define VIRTIO_GPU_EVENT_DISPLAY (1 << 0)
 
@@ -160,6 +163,9 @@ the shape use VIRTIO_GPU_CMD_MOVE_CURSOR instead.
 
 \subsubsection{Device Operation: Request header}\label{sec:Device Types / GPU Device / Device Operation / Device Operation: Request header}
 
+All requests and responses on the virt queues have a fixed header
+using the following layout structure and definitions:
+
 \begin{lstlisting}
 enum virtio_gpu_ctrl_type {
 
@@ -207,8 +213,8 @@ struct virtio_gpu_ctrl_hdr {
 };
 \end{lstlisting}
 
-All requests and responses on the virt queues have the fixed header
-\field{struct virtio_gpu_ctrl_hdr}.
+The fixed header \field{struct virtio_gpu_ctrl_hdr} in each
+request includes the following fields:
 
 \begin{description}
 \item[\field{type}] specifies the type of the driver request
diff --git a/virtio-vsock.tex b/virtio-vsock.tex
index 1a3ad19..da7e641 100644
--- a/virtio-vsock.tex
+++ b/virtio-vsock.tex
@@ -20,6 +20,8 @@ There are currently no feature bits defined for this device.
 
 \subsection{Device configuration layout}\label{sec:Device Types / Socket Device / Device configuration layout}
 
+Socket device configuration uses the following layout structure:
+
 \begin{lstlisting}
 struct virtio_vsock_config {
 	le64 guest_cid;
-- 
MST

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

