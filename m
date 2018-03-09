Return-Path: virtio-return-2993-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Fri, 9 Mar 2018 23:23:35 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1520629942-36324-10-git-send-email-mst@redhat.com>
References: <1520629942-36324-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520629942-36324-1-git-send-email-mst@redhat.com>
Subject: [virtio] [PATCH v10 09/13] split-ring: typo: aligment
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

---
 split-ring.tex | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/split-ring.tex b/split-ring.tex
index a594d41..87ecee2 100644
--- a/split-ring.tex
+++ b/split-ring.tex
@@ -23,7 +23,7 @@ Each virtqueue consists of three parts:
 where each part is physically-contiguous in guest memory,
 and has different alignment requirements.
 
-The memory aligment and size requirements, in bytes, of each part of the
+The memory alignment and size requirements, in bytes, of each part of the
 virtqueue are summarized in the following table:
 
 \begin{tabular}{|l|l|l|}
-- 
MST


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

