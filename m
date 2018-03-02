Return-Path: virtio-dev-return-3360-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 499D358180E7
	for <virtio-dev@lists.oasis-open.org>; Thu,  1 Mar 2018 19:47:11 -0800 (PST)
From: Jason Baron <jbaron@akamai.com>
Date: Thu,  1 Mar 2018 22:46:33 -0500
Message-Id: <864430f2a613c4d3c82b591ed7bc27068ddad369.1519961667.git.jbaron@akamai.com>
In-Reply-To: <cover.1519961667.git.jbaron@akamai.com>
References: <cover.1519961667.git.jbaron@akamai.com>
In-Reply-To: <cover.1519961667.git.jbaron@akamai.com>
References: <cover.1519961667.git.jbaron@akamai.com>
Subject: [virtio-dev] [PATCH 1/4] eth: add speed and duplex definitions
To: mst@redhat.com
Cc: jasowang@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Pull in definitions for SPEED_UNKNOWN, DUPLEX_UNKNOWN, DUPLEX_HALF,
and DUPLEX_FULL.

Signed-off-by: Jason Baron <jbaron@akamai.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: virtio-dev@lists.oasis-open.org
---
 include/net/eth.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/net/eth.h b/include/net/eth.h
index 09054a5..9843678 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -417,4 +417,11 @@ bool
 eth_parse_ipv6_hdr(const struct iovec *pkt, int pkt_frags,
                    size_t ip6hdr_off, eth_ip6_hdr_info *info);
 
+/* ethtool defines - from linux/ethtool.h */
+#define SPEED_UNKNOWN           -1
+
+#define DUPLEX_HALF             0x00
+#define DUPLEX_FULL             0x01
+#define DUPLEX_UNKNOWN          0xff
+
 #endif
-- 
2.7.4


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

