Return-Path: virtio-dev-return-3067-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 43FC35818120
	for <virtio-dev@lists.oasis-open.org>; Thu, 25 Jan 2018 08:27:27 -0800 (PST)
From: Sameeh Jubran <sameeh@daynix.com>
Date: Thu, 25 Jan 2018 18:27:08 +0200
Message-Id: <20180125162709.370-1-sameeh@daynix.com>
Subject: [virtio-dev] [RFC virtio-net 0/1] introducing RSS into virtio-net
To: virtio-dev@lists.oasis-open.org
Cc: Amnon Ilan <ailan@redhat.com>, Yan Vugenfirer <yan@daynix.com>
List-ID: <virtio-dev.lists.oasis-open.org>

From: Sameeh Jubran <sjubran@redhat.com>

Hi all,

Most modern high end network devices today support configurable hash functions,
the following commit introduces RSS - Receive Side Scaling - [1] into virtio net
device. RSS is a technology developed by Microsoft that boosts network device
performance by efficiently distributing the traffic among the CPUs in a
multiprocessor system.

This feature is supported in most of the modern network cards as well as most
modern OSes including Linux and Windows. It is worth mentioning that both DPDK
and Hyper-v support RSS too.

Currently in NetKVM - the Windows driver for virtio-net - RSS is supported in
the driver (software implementation) this adds extra overhead to the driver
that's reflected in unneeded IPIs and TLB flushes, adding this support to the
backend should enhance the performance and help avoid these overheads.

For all the reasons I mentioned above I think it is time for virtio-net to
support this feature, please share your thoughts.

[1] https://docs.microsoft.com/en-us/windows-hardware/drivers/network/ndis-receive-side-scaling2

Thanks,
Sameeh


Sameeh Jubran (1):
  content: net: Add VIRTIO_NET_F_CTRL_RSS feature

 content.tex | 133 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

-- 
2.13.6


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

