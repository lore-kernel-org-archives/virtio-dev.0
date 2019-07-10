Return-Path: virtio-comment-return-791-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed, 10 Jul 2019 19:32:08 +0100
Message-Id: <20190710183212.29420-2-dgilbert@redhat.com>
In-Reply-To: <20190710183212.29420-1-dgilbert@redhat.com>
References: <20190710183212.29420-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-comment] [PATCH v6 1/5] shared memory: Define shared memory regions
To: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, stefanha@redhat.com, cohuck@redhat.com
Cc: vgoyal@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Define the requirements and idea behind shared memory regions.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 conformance.tex |  1 +
 content.tex     |  2 ++
 shared-mem.tex  | 42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)
 create mode 100644 shared-mem.tex

diff --git a/conformance.tex b/conformance.tex
index 42f702a..4524237 100644
--- a/conformance.tex
+++ b/conformance.tex
@@ -197,6 +197,7 @@ \section{Conformance Targets}\label{sec:Conformance / Conformance Targets}
 \item \ref{devicenormative:Basic Facilities of a Virtio Device / Virtqueues / Used Buffer Notification Suppression}
 \item \ref{devicenormative:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Used Ring}
 \item \ref{devicenormative:Basic Facilities of a Virtio Device / Virtqueues / Available Buffer Notification Suppression}
+\item \ref{devicenormative:Basic Facilities of a Virtio Device / Shared Memory Regions}
 \item \ref{devicenormative:Reserved Feature Bits}
 \end{itemize}
 
diff --git a/content.tex b/content.tex
index 8f0498e..6433226 100644
--- a/content.tex
+++ b/content.tex
@@ -371,6 +371,8 @@ \subsection{Driver notifications} \label{sec:Virtqueues / Driver notifications}
 has been negotiated, these notifications would then have
 identical \field{next_off} and \field{next_wrap} values.
 
+\input{shared-mem.tex}
+
 \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
 
 We start with an overview of device initialization, then expand on the
diff --git a/shared-mem.tex b/shared-mem.tex
new file mode 100644
index 0000000..6e6f6c4
--- /dev/null
+++ b/shared-mem.tex
@@ -0,0 +1,42 @@
+\section{Shared Memory Regions}\label{sec:Basic Facilities of a Virtio Device / Shared Memory Regions}
+
+Shared memory regions are an additional facility
+available to devices that need a region of memory that's
+continuously shared between the device and the driver, rather
+than passed between them in the way virtqueue elements are.
+
+Example uses include shared caches and version pools for versioned
+data structures.
+
+The memory region is allocated by the device and presented to the
+driver.  Where the device is implemented in software on a host,
+this arrangement allows the memory region to be allocated by
+a library on the host, which the device may not have full control
+over.
+
+A device may have multiple shared memory regions associated with
+it.  Each region has a \field{shmid} to identify it, the meaning
+of which is device-specific.
+
+Enumeration and location of shared memory regions is performed
+in a transport-specific way.
+
+Memory consistency rules vary depending on the region and the
+device and they will be specified as required by each device.
+
+\subsection{Addressing within regions}\label{sec:Basic Facilities of a Virtio Device / Shared Memory Regions / Addressing within regions }
+
+References into shared memory regions are represented as offsets from
+the beginning of the region instead of absolute memory addresses.
+Offsets are used both for references between structures stored
+within shared memory and for requests placed in virtqueues that
+refer to shared memory.
+The \field{shmid} may be explicit or may be inferred from the
+context of the reference.
+
+\devicenormative{\subsection}{Shared Memory Regions}{Basic Facilities of a Virtio
+Device / Shared Memory Regions}
+Shared memory regions MUST NOT expose shared memory regions which
+are used to control the operation of the device, nor to stream
+data.
+
-- 
2.21.0


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

