Return-Path: virtio-dev-return-3855-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id C76A25818F92
	for <virtio-dev@lists.oasis-open.org>; Wed, 18 Apr 2018 03:47:31 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Wed, 18 Apr 2018 13:46:54 +0300
Message-Id: <20180418104656.1450-1-sameeh@daynix.com>
Subject: [virtio-dev] [PATCH v3 0/2] Introducing RSS to virtio-net
To: virtio-dev@lists.oasis-open.org
Cc: Amnon Ilan <ailan@redhat.com>, Yan Vugenfirer <yan@daynix.com>
List-ID: <virtio-dev.lists.oasis-open.org>

From: Sameeh Jubran <sjubran@redhat.com>

Please ignore the feature number value (60) in the patch, it is not final for now.

Difference from v2:

* Dropped RSS_HASH_FUNCTION_NONE flag from RSS as it seems to be
  useless.
* Added more comments to the code.
* Beautifications.
* Fixed some sentences to make them clearer.


Sameeh Jubran (2):
  content: net: Add VIRTIO_NET_F_CTRL_STEERING_MODE feature
  content: net: steering mode: Add RSS

 content.tex | 170 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 170 insertions(+)

-- 
2.13.6


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

