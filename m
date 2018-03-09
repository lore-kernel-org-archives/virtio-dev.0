Return-Path: virtio-return-2990-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Fri, 9 Mar 2018 23:23:29 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1520629942-36324-2-git-send-email-mst@redhat.com>
References: <1520629942-36324-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520629942-36324-1-git-send-email-mst@redhat.com>
Subject: [virtio] [PATCH v10 01/13] introduction: document bitfield notation
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Bitfields are a useful and familiar way to specify sub-byte structure
layout. The only issue is that bitfield order isn't portable across
architectures.  Document that we list bitfields from least to
most significant one, and warn about portability issues.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 introduction.tex | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/introduction.tex b/introduction.tex
index 979881e..a4ac01d 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -157,5 +157,46 @@ in little-endian byte order.
 in big-endian byte order.
 \end{description}
 
+Some of the fields to be defined in this specification don't
+start or don't end on a byte boundary. Such fields are called bit-fields.
+A set of bit-fields is always a sub-division of an integer typed field.
+
+Bit-fields within integer fields are always listed in order,
+from the least significant to the most significant bit.  The
+bit-fields are considered unsigned integers of the specified
+width with the next in significance relationship of the bits
+preserved.
+
+For example:
+\begin{lstlisting}
+struct S {
+        be16 {
+                A : 15;
+                B : 1;
+        } x;
+        be16 y;
+};
+\end{lstlisting}
+documents the value A stored in the low 15 bit of \field{x} and
+the value B stored in the high bit of \field{x}, the 16-bit
+integer \field{x} in turn stored using the big-endian byte order
+at the beginning of the structure S,
+and being followed immediately by an unsigned integer \field{y}
+stored in big-endian byte order at an offset of 2 bytes (16 bits)
+from the beginning of the structure.
+
+Note that this notation somewhat resembles the C bitfield syntax but
+should not be naively converted to a bitfield notation for portable
+code: it matches the way bitfields are packed by C compilers on
+little-endian architectures but not the way bitfields are packed by C
+compilers on big-endian architectures.
+
+Assuming that CPU_TO_BE16 converts a 16-bit integer from a native
+CPU to the big-endian byte order, the following is the equivalent
+portable C code to generate a value to be stored into \field{x}:
+\begin{lstlisting}
+CPU_TO_BE16(B << 15 | A)
+\end{lstlisting}
+
 \newpage
 
-- 
MST


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

