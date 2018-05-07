Return-Path: virtio-dev-return-4043-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 7F0C358191D2
	for <virtio-dev@lists.oasis-open.org>; Mon,  7 May 2018 04:25:19 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Mon,  7 May 2018 14:24:53 +0300
Message-Id: <20180507112457.14134-1-sameeh@daynix.com>
Subject: [virtio-dev] [PATCH v5 0/4] Introducing RSS to virtio-net
To: virtio-dev@lists.oasis-open.org
Cc: Amnon Ilan <ailan@redhat.com>, Yan Vugenfirer <yan@daynix.com>
List-ID: <virtio-dev.lists.oasis-open.org>

From: Sameeh Jubran <sjubran@redhat.com>

Difference from v4:

* Added hash offload feature bit. This separates the hash offload from the
  steering mode feature as was suggested by Michael.

Sameeh Jubran (4):
  content: net: Add VIRTIO_NET_F_CTRL_STEERING_MODE feature
  conformance: net: Add steering mode
  content: net: Add VIRTIO_NET_F_HASH_OFFLOAD feature
  content: net: steering mode: Add RSS

 conformance.tex |   1 +
 content.tex     | 195 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 196 insertions(+)

-- 
2.13.6


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

