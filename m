Return-Path: virtio-dev-return-4014-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id AD7145818F5E
	for <virtio-dev@lists.oasis-open.org>; Mon, 30 Apr 2018 08:58:33 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Mon, 30 Apr 2018 18:58:13 +0300
Message-Id: <20180430155816.4687-1-sameeh@daynix.com>
Subject: [virtio-dev] [PATCH v4 0/3] Introducing RSS to virtio-net
To: virtio-dev@lists.oasis-open.org
Cc: Amnon Ilan <ailan@redhat.com>, Yan Vugenfirer <yan@daynix.com>
List-ID: <virtio-dev.lists.oasis-open.org>

From: Sameeh Jubran <sjubran@redhat.com>

Difference from v3:

* Added steering mode to conformance
* Replaced should with SHOULD
* Rephrased few lines based on Vijayabhaskar's suggestions

Sameeh Jubran (3):
  content: net: Add VIRTIO_NET_F_CTRL_STEERING_MODE feature
  conformance: net: Add steering mode
  content: net: steering mode: Add RSS

 conformance.tex |   1 +
 content.tex     | 170 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 171 insertions(+)

-- 
2.13.6


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

