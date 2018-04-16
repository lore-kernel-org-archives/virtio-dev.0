Return-Path: virtio-dev-return-3840-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 3C0515819042
	for <virtio-dev@lists.oasis-open.org>; Mon, 16 Apr 2018 06:05:49 -0700 (PDT)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Mon, 16 Apr 2018 16:05:24 +0300
Message-Id: <20180416130526.6233-1-sameeh@daynix.com>
Subject: [virtio-dev] [PATCH v2 0/2] Introducing RSS virtio-net
To: virtio-dev@lists.oasis-open.org, Jason Wang <jasowang@redhat.com>, Vijayabhaskar Balakrishna <vijay.balakrishna@oracle.com>
Cc: Yan Vugenfirer <yan@daynix.com>
List-ID: <virtio-dev.lists.oasis-open.org>

From: Sameeh Jubran <sjubran@redhat.com>

Hi all,

This patch series introduces an infrastructure into virtio-net for
adding steering modes while introducing RSS as one.

Please take a look and share your thoughts.

Difference from v1:

* generic steering mode introduced and RSS is defined as part of the steering
  feature by Jason request

v1:
https://lists.oasis-open.org/archives/virtio-dev/201801/msg00177.html

Sameeh Jubran (2):
  content: net: Add VIRTIO_NET_F_CTRL_STEERING_MODE feature
  content: net: steering mode: Add RSS

 content.tex | 173 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 173 insertions(+)

-- 
2.13.6


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

