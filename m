Return-Path: virtio-return-3017-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 14 Mar 2018 15:46:17 +0000
Message-Id: <20180314154618.13069-7-stefanha@redhat.com>
In-Reply-To: <20180314154618.13069-1-stefanha@redhat.com>
References: <20180314154618.13069-1-stefanha@redhat.com>
Subject: [virtio] [PATCH 6/7] packed-ring: fix "the descriptor flags +field+ is updated"
To: virtio@lists.oasis-open.org
Cc: virtio-dev@lists.oasis-open.org, Tiwei Bie <tiwei.bie@intel.com>, Cornelia Huck <cohuck@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Either it needs to be "the descriptors flags are update" (since "flags"
is plural) or "the descriptor flags field is updated".  Since "flags" is
a name of a specific field, I chose the latter solution.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 packed-ring.tex | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/packed-ring.tex b/packed-ring.tex
index 00befae..60b5559 100644
--- a/packed-ring.tex
+++ b/packed-ring.tex
@@ -567,8 +567,8 @@ the descriptor flags for the first descriptor
 (and the previous memory barrier) until after the rest of
 the descriptors have been initialized.
 
-Once the descriptor \field{flags} is updated by the driver, this exposes the
-descriptor and its contents.  The device MAY
+Once the descriptor \field{flags} field is updated by the driver, this exposes
+the descriptor and its contents.  The device MAY
 access the descriptor and any following descriptors the driver created and the
 memory they refer to immediately.
 
-- 
2.14.3


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

