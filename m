Return-Path: virtio-dev-return-2873-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 0ED055818F40
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Dec 2017 06:45:32 -0800 (PST)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Thu, 21 Dec 2017 16:45:04 +0200
Message-Id: <20171221144504.12747-1-sameeh@daynix.com>
Subject: [virtio-dev] [PATCH] virtio-net: Add missing flag define to struct
To: virtio-dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

From: sameehj <sameeh.j@gmail.com>

The flag VIRTIO_NET_HDR_F_DATA_VALID is aleady  mentioned in the virtio-net
spec however it is not defined in the struct. This flag is already defined
and used in virtio-net device in Qemu as well as some of it's drivers.
---
 content.tex | 1 +
 1 file changed, 1 insertion(+)

diff --git a/content.tex b/content.tex
index c840588..788d8b5 100644
--- a/content.tex
+++ b/content.tex
@@ -3305,6 +3305,7 @@ itself is preceded by a header:
 \begin{lstlisting}
 struct virtio_net_hdr {
 #define VIRTIO_NET_HDR_F_NEEDS_CSUM    1
+#define VIRTIO_NET_HDR_F_DATA_VALID    2
         u8 flags;
 #define VIRTIO_NET_HDR_GSO_NONE        0
 #define VIRTIO_NET_HDR_GSO_TCPV4       1
-- 
2.13.6


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

