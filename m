Return-Path: virtio-return-3401-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Sun, 24 Nov 2019 07:44:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20191124124344.262655-1-mst@redhat.com>
MIME-Version: 1.0
Subject: [virtio] [PATCH] virtio-rng: fix device/driver confusion
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

The point of rng is to give data to driver so of course
all buffers are driver readable. What shouldn't be there
is device readable buffers - this matches our terminology
elsewhere too (read/write-ability is from POV of device).

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/55
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 content.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/content.tex b/content.tex
index 678afbe..72e832e 100644
--- a/content.tex
+++ b/content.tex
@@ -4721,7 +4721,7 @@ \subsection{Device Operation}\label{sec:Device Types =
/ Entropy Device / Device O
=20
 \drivernormative{\subsubsection}{Device Operation}{Device Types / Entropy =
Device / Device Operation}
=20
-The driver MUST NOT place driver-readable buffers into the queue.
+The driver MUST NOT place device-readable buffers into the queue.
=20
 The driver MUST examine the length written by the device to determine
 how many random bytes were received.
--=20
MST


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that=20
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php=20

