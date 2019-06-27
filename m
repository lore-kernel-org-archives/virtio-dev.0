Return-Path: virtio-comment-return-770-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 27 Jun 2019 20:28:27 +0100
Message-Id: <20190627192830.5285-3-dgilbert@redhat.com>
In-Reply-To: <20190627192830.5285-1-dgilbert@redhat.com>
References: <20190627192830.5285-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-comment] [PATCH v5 2/5] pci: Define id field
To: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, stefanha@redhat.com, cohuck@redhat.com
Cc: vgoyal@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

For the virtio-fs device we require multiple large shared memory
regions.  Differentiate these by an 'id' field in the base capability.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 content.tex | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/content.tex b/content.tex
index 6433226..41926c0 100644
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
@@ -716,6 +717,11 @@ \subsection{Virtio Structure PCI Capabilities}\label{sec:Virtio Transport Option
 
         Any other value is reserved for future use.
 
+\item[\field{id}]
+        Multiple capabilities of the same type can exist as long
+        as they each have a unique \field{id}.  The specific
+        meaning of the field is different for each device type.
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

