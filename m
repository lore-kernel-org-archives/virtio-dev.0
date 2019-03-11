Return-Path: virtio-return-3284-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 11 Mar 2019 15:06:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190311190545.10816-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio] [PATCH] editorial: upgrade links to https
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Several links have been upgraded and now redirect to the https
version. Upgrade our version accordingly.

Note that some other links use the status 301 - moved permanently
apparently in error (e.g. for a language specific redirect), not
updating these.

VIRTIO-173

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 title.tex      | 6 +++---
 virtio-gpu.tex | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/title.tex b/title.tex
index 5b42e76..180b21f 100644
--- a/title.tex
+++ b/title.tex
@@ -33,12 +33,12 @@ N/A
 \end{oasistitlesection}
 
 \begin{oasistitlesection}{Chair}
-Michael S. Tsirkin (\href{mailto:mst@redhat.com}{mst@redhat.com}), \href{http://www.redhat.com/}{Red Hat}\newline
+Michael S. Tsirkin (\href{mailto:mst@redhat.com}{mst@redhat.com}), \href{https://www.redhat.com/}{Red Hat}\newline
 \end{oasistitlesection}
 
 \begin{oasistitlesection}{Editors}
-Michael S. Tsirkin (\href{mailto:mst@redhat.com}{mst@redhat.com}), \href{http://www.redhat.com/}{Red Hat}\newline
-Cornelia Huck (\href{mailto:cohuck@redhat.com}{cohuck@redhat.com}), \href{http://www.redhat.com/}{Red Hat}\newline
+Michael S. Tsirkin (\href{mailto:mst@redhat.com}{mst@redhat.com}), \href{https://www.redhat.com/}{Red Hat}\newline
+Cornelia Huck (\href{mailto:cohuck@redhat.com}{cohuck@redhat.com}), \href{https://www.redhat.com/}{Red Hat}\newline
 \end{oasistitlesection}
 
 
diff --git a/virtio-gpu.tex b/virtio-gpu.tex
index 8687231..af4ca61 100644
--- a/virtio-gpu.tex
+++ b/virtio-gpu.tex
@@ -515,4 +515,4 @@ into vga compatibility mode.
 
 Note: qemu implementation also provides bochs dispi interface io ports
 and mmio bar at pci region 1 and is therefore fully compatible with
-the qemu stdvga (see \href{http://git.qemu-project.org/?p=qemu.git;a=blob;f=docs/specs/standard-vga.txt;hb=HEAD}{docs/specs/standard-vga.txt} in the qemu source tree).
+the qemu stdvga (see \href{https://git.qemu-project.org/?p=qemu.git;a=blob;f=docs/specs/standard-vga.txt;hb=HEAD}{docs/specs/standard-vga.txt} in the qemu source tree).
-- 
MST

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

