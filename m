Return-Path: virtio-return-2938-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Thu, 1 Mar 2018 01:31:19 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1519860484-7936-2-git-send-email-mst@redhat.com>
References: <1519860484-7936-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519860484-7936-1-git-send-email-mst@redhat.com>
Subject: [virtio] [PATCH v9 01/16] introduction: document bitfield notation
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Bitfields are a useful and familiar way to specify sub-byte structure
layout. The only issue is that bitfield order isn't portable across
architectures.  Document that we list bitfields from least to
most significant one, and warn about portability issues.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 introduction.tex | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/introduction.tex b/introduction.tex
index 979881e..3cb7a70 100644
--- a/introduction.tex
+++ b/introduction.tex
@@ -157,5 +157,23 @@ in little-endian byte order.
 in big-endian byte order.
 \end{description}
 
+When documenting sub-byte data fields, C-like bitfield notation
+is used. Fields within an integer are always listed in order,
+from the least significant to the most significant bit.
+
+For example:
+\begin{lstlisting}
+be16 A : 15;
+be16 B : 1;
+\end{lstlisting}
+documents the value A stored in the low 15 bit of a 16 bit
+integer and the value B stored in the high bit of the 16 bit
+integer, the integer in turn using the big-endian byte order.
+
+Note that this notation typically matches the way bitfields are
+packed by C compilers on little-endian architectures but not the
+way bitfields are packed by C compilers on big-endian
+architectures.
+
 \newpage
 
-- 
MST


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

