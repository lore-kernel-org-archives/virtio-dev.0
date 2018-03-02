Return-Path: virtio-dev-return-3361-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id DFA8F58180E7
	for <virtio-dev@lists.oasis-open.org>; Thu,  1 Mar 2018 19:47:16 -0800 (PST)
From: Jason Baron <jbaron@akamai.com>
Date: Thu,  1 Mar 2018 22:46:34 -0500
Message-Id: <ee94e55496562390786ad924f750de1cf3472644.1519961667.git.jbaron@akamai.com>
In-Reply-To: <cover.1519961667.git.jbaron@akamai.com>
References: <cover.1519961667.git.jbaron@akamai.com>
In-Reply-To: <cover.1519961667.git.jbaron@akamai.com>
References: <cover.1519961667.git.jbaron@akamai.com>
Subject: [virtio-dev] [PATCH 2/4] rocker: drop local duplex definitions
To: mst@redhat.com
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, Jiri Pirko <jiri@resnulli.us>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Make use of duplex definitions from net/eth.h.

Signed-off-by: Jason Baron <jbaron@akamai.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: virtio-dev@lists.oasis-open.org
---
 hw/net/rocker/rocker_fp.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/hw/net/rocker/rocker_fp.c b/hw/net/rocker/rocker_fp.c
index 4b3c984..13a14a0 100644
--- a/hw/net/rocker/rocker_fp.c
+++ b/hw/net/rocker/rocker_fp.c
@@ -16,17 +16,13 @@
 
 #include "qemu/osdep.h"
 #include "net/clients.h"
+#include "net/eth.h"
 
 #include "rocker.h"
 #include "rocker_hw.h"
 #include "rocker_fp.h"
 #include "rocker_world.h"
 
-enum duplex {
-    DUPLEX_HALF = 0,
-    DUPLEX_FULL
-};
-
 struct fp_port {
     Rocker *r;
     World *world;
-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

