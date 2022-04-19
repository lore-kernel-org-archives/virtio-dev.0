Return-Path: <virtio-comment-return-2948-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Tue, 19 Apr 2022 10:34:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220419143435.126705-1-mst@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] [PATCH] packed-ring.tex: link conformance statements
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Link conformance statements into conformance chapter.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 conformance.tex |  9 +++++++++
 packed-ring.tex | 16 +++++-----------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/conformance.tex b/conformance.tex
index 9807c30..663e7c3 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -85,6 +85,12 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / Available Buffer Notification Suppression}
 \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / Supplying Buffers to The Device / Updating idx}
 \item \ref{drivernormative:Basic Facilities of a Virtio Device / Virtqueues / Supplying Buffers to The Device / Notifying The Device}
+\item \ref{drivernormative:Basic Facilities of a Virtio Device / Packed Virtqueues}
+\item \ref{drivernormative:Basic Facilities of a Virtio Device / PAcked Virtqueues / The Virtqueue Descriptor Table}
+\item \ref{drivernormative:Basic Facilities of a Virtio Device / Packed Virtqueues / Scatter-Gather Support}
+\item \ref{drivernormative:Basic Facilities of a Virtio Device / Packed Virtqueues / The Virtqueue Descriptor Table / Indirect Descriptors}
+\item \ref{drivernormative:Basic Facilities of a Virtio Device / Packed Virtqueues / Supplying Buffers to The Device / Updating flags}
+\item \ref{drivernormative:Basic Facilities of a Virtio Device / Packed Virtqueues / Supplying Buffers to The Device / Sending Available Buffer Notifications}
 \item \ref{drivernormative:General Initialization And Device Operation / Device Initialization}
 \item \ref{drivernormative:General Initialization And Device Operation / Device Cleanup}
 \item \ref{drivernormative:Reserved Feature Bits}
@@ -340,6 +346,9 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{devicenormative:Basic Facilities of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}
 \item \ref{devicenormative:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Used Ring}
 \item \ref{devicenormative:Basic Facilities of a Virtio Device / Virtqueues / Available Buffer Notification Suppression}
+\item \ref{devicenormative:Basic Facilities of a Virtio Device / Packed Virtqueues}
+\item \ref{devicenormative:Basic Facilities of a Virtio Device / Packed Virtqueues / The Virtqueue Descriptor Table}
+\item \ref{devicenormative:Basic Facilities of a Virtio Device / Packed Virtqueues / Scatter-Gather Support}
 \item \ref{devicenormative:Basic Facilities of a Virtio Device / Shared Memory Regions}
 \item \ref{devicenormative:Reserved Feature Bits}
 \end{itemize}
diff --git a/packed-ring.tex b/packed-ring.tex
index 2accc23..47f58a8 100644
--- a/packed-ring.tex
+++ b/packed-ring.tex
@@ -407,14 +407,12 @@ \subsubsection{Structure Size and Alignment}
 can be queued at any given time.}.  The Queue Size value does not
 have to be a power of 2.
 
-\drivernormative{\subsection}{Virtqueues}{Basic Facilities of a
-Virtio Device / Packed Virtqueues}
+\drivernormative{\subsection}{Virtqueues}{Basic Facilities of a Virtio Device / Packed Virtqueues}
 The driver MUST ensure that the physical address of the first byte
 of each virtqueue part is a multiple of the specified alignment value
 in the above table.
 
-\devicenormative{\subsection}{Virtqueues}{Basic Facilities of a
-Virtio Device / Packed Virtqueues}
+\devicenormative{\subsection}{Virtqueues}{Basic Facilities of a Virtio Device / Packed Virtqueues}
 The device MUST start processing driver descriptors in the order
 in which they appear in the ring.
 The device MUST start writing device descriptors into the ring in
@@ -485,8 +483,7 @@ \subsection{Event Suppression Structure Format}\label{sec:Basic
 A driver MAY send multiple available buffer notifications without making
 any new descriptors available to the device.
 
-\drivernormative{\subsection}{Scatter-Gather Support}{Basic Facilities of a
-Virtio Device / Packed Virtqueues / Scatter-Gather Support}
+\drivernormative{\subsection}{Scatter-Gather Support}{Basic Facilities of a Virtio Device / Packed Virtqueues / Scatter-Gather Support}
 A driver MUST NOT create a descriptor list longer than allowed
 by the device.
 
@@ -508,8 +505,7 @@ \subsection{Event Suppression Structure Format}\label{sec:Basic
 before all subsequent descriptors comprising the list are made
 available.
 
-\devicenormative{\subsection}{Scatter-Gather Support}{Basic Facilities of a
-Virtio Device / Packed Virtqueues / Scatter-Gather Support}
+\devicenormative{\subsection}{Scatter-Gather Support}{Basic Facilities of a Virtio Device / Packed Virtqueues / Scatter-Gather Support}
 The device MUST use descriptors in a list chained by the
 VIRTQ_DESC_F_NEXT flag in the same order that they
 were made available by the driver.
@@ -591,9 +587,7 @@ \subsubsection{Placing Available Buffers Into The Descriptor Ring}\label{sec:Bas
 access the descriptor and any following descriptors the driver created and the
 memory they refer to immediately.
 
-\drivernormative{\paragraph}{Updating flags}{Basic Facilities of
-a Virtio Device / Packed Virtqueues / Supplying Buffers to The
-Device / Updating flags}
+\drivernormative{\paragraph}{Updating flags}{Basic Facilities of a Virtio Device / Packed Virtqueues / Supplying Buffers to The Device / Updating flags}
 The driver MUST perform a suitable memory barrier before the
 \field{flags} update, to ensure the
 device sees the most up-to-date copy.
-- 
MST


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

