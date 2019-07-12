Return-Path: virtio-comment-return-804-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 12 Jul 2019 13:19:59 +0100
Message-Id: <20190712122002.10793-3-dgilbert@redhat.com>
In-Reply-To: <20190712122002.10793-1-dgilbert@redhat.com>
References: <20190712122002.10793-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-comment] [PATCH v7 2/5] pci: Define id field
To: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, stefanha@redhat.com, cohuck@redhat.com
Cc: vgoyal@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

For the virtio-fs device we require multiple large shared memory
regions.  Differentiate these by an 'id' field in the base capability.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 content.tex | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/content.tex b/content.tex
index 6433226..fafa532 100644
--- a/content.tex
+++ b/content.tex
@@ -651,7 +651,8 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
         u8 cap_len;     /* Generic PCI field: capability length */
         u8 cfg_type;    /* Identifies the structure. */
         u8 bar;         /* Where to find it. */
-        u8 padding[3];  /* Pad to full dword. */
+        u8 id;          /* Multiple capabilities of the same type */
+        u8 padding[2];  /* Pad to full dword. */
         le32 offset;    /* Offset within bar. */
         le32 length;    /* Length of the structure, in bytes. */
 };
@@ -697,7 +698,8 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
         The device MAY offer more than one structure of any type - this makes it
         possible for the device to expose multiple interfaces to drivers.  The order of
         the capabilities in the capability list specifies the order of preference
-        suggested by the device.
+        suggested by the device.  A device may specify that this ordering mechanism be
+        overridden by the use of the \field{id} field.
         \begin{note}
           For example, on some hypervisors, notifications using IO accesses are
         faster than memory accesses. In this case, the device would expose two
@@ -716,6 +718,12 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
 
         Any other value is reserved for future use.
 
+\item[\field{id}]
+        Used by some device types to uniquely identify multiple capabilities
+        of a certain type. If the device type does not specify the meaning of
+        this field, its contents are undefined.
+
+
 \item[\field{offset}]
         indicates where the structure begins relative to the base address associated
         with the BAR.  The alignment requirements of \field{offset} are indicated
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

