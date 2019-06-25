Return-Path: virtio-dev-return-5810-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6ED8B985A41
	for <virtio-dev@lists.oasis-open.org>; Tue, 25 Jun 2019 07:13:52 +0000 (UTC)
Date: Tue, 25 Jun 2019 23:15:35 +0800
From: Conghui Chen <conghui.chen@intel.com>
Message-ID: <20190625151535.GB25390@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Subject: [virtio-dev] [RFC] Add polling mode feature bit
To: virtio-dev@lists.oasis-open.org
Cc: shuo.a.liu@intel.com, yu1.wang@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

We are working on enable VIRTIO on RTVMs. For RT requirements and some
security reasons, the VIRTIO interrupts are not allowed to inject to
guest OS, and the notify flow may bring some uncertain delay, so the
polling mode for VIRTIO device is taken into consideration. And in some
open source projects, like DPDK and OVMF, the polling mode is
implemented on device level, but if a system need all the VIRTIO devices
work on polling mode, then we should support it for each VIRTIO device
type. That will take lots of effort and may not able to upstream, such
as in RT-Linux. So, we wonder that, if we could support polling mode on
VIRTIO framework level?

We have a proposal:
Add a new feature bit: VIRTIO_F_PMD(39)
This feature indicates that the driver should work in polling mode, and
the device will not inject interrupt to Guest OS.

Regards,
Conghui.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

