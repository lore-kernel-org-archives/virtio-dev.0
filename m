Return-Path: virtio-comment-return-640-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 22 Feb 2019 11:54:31 +0000
Message-Id: <20190222115433.7160-2-dgilbert@redhat.com>
In-Reply-To: <20190222115433.7160-1-dgilbert@redhat.com>
References: <20190222115433.7160-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-comment] [PATCH v2 1/3] shared memory: Define shared memory regions
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: stefanha@redhat.com, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Define the requirements and idea behind shared memory regions.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 content.tex    |  2 ++
 shared-mem.tex | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)
 create mode 100644 shared-mem.tex

diff --git a/content.tex b/content.tex
index 836ee52..3dd504c 100644
--- a/content.tex
+++ b/content.tex
@@ -371,6 +371,8 @@ making any more buffers available. When VIRTIO_F_NOTIFICATION_DATA
 has been negotiated, these notifications would then have
 identical \field{next_off} and \field{next_wrap} values.
 
+\input{shared-mem.tex}
+
 \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
 
 We start with an overview of device initialization, then expand on the
diff --git a/shared-mem.tex b/shared-mem.tex
new file mode 100644
index 0000000..85b0c55
--- /dev/null
+++ b/shared-mem.tex
@@ -0,0 +1,33 @@
+\section{Shared Memory Regions}\label{sec:Basic Facilities of a Virtio Device / Shared Memory Regions}
+
+Shared memory regions are an additional facility
+available to devices that need a region of memory that's
+continuously shared between the host and the guest, rather
+than passed between them in the way virtqueue elements are.
+
+Example uses include shared caches and version pools for versioned
+data structures.
+
+The region is chosen by the host and presented to the guest, as
+such it is useful in situations where the memory is accessed on
+the host by other libraries that can't safely access guest RAM.
+
+Shared memory regions MUST NOT be used to control the operation
+of the device, nor to stream data; those should still be performed
+using virtqueues.
+
+A device may have multiple shared memory regions associated with
+it.  Each region has a \field{shmid} to identify it, the meaning
+of which is device-specific.
+
+Enumeration and location of shared memory regions is performed
+using a transport-specific data structure and mechanism.
+
+Memory consistency rules vary depending on the region and the
+device.  Devices MUST define the required behaviour for each
+region.
+
+The guest physical address and the host virtual address MUST NOT
+be used to identify structures within the memory regions; all
+addressing MUST be relative to the start of a particular region.
+
-- 
2.20.1


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

