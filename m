Return-Path: virtio-dev-return-2668-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id BB6B51CB807E
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Nov 2017 21:33:14 -0800 (PST)
From: "Tan, Jianfeng" <jianfeng.tan@intel.com>
Message-ID: <1d6a84dd-946b-840f-d04c-f786c900ce88@intel.com>
Date: Thu, 9 Nov 2017 13:33:11 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Propose to report the offset addr back from vhost to virtio
To: virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Liang, Cunming" <cunming.liang@intel.com>, "Gasparakis, Joseph" <joseph.gasparakis@intel.com>, 'Jason Wang' <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

This proposal will be from virtio-net perspective, not sure if it helps 
for other device types.

Current status:
VIRTIO-net "rx" path will rearm buffers for packets receiving, put the 
start addr and len on the descriptor table (or the single ring for 
virtio 1.1 draft spec), vhost backend will put the packet exactly on the 
start addr, and report the real packet len back. This way does not allow 
the vhost backend to put the packet somewhere offset to the start addr.

Use case:
When we look at vhost rx zero copy problem, we would like the NIC to put 
the packets directly onto VM memory, but this raw packet (tunnel packet) 
always contains a outer header which should be decap before VM starts 
receiving the packet. And unfortunately, not all NICs support decap. 
After the whole tunnel packet be put on the VM buffer (starting with the 
start addr), and after the vswitch's decap, we can report an "offset" 
back to VIRTIO frontend, and of course, the frontend shall honor this 
offset and adjust accordingly.

The proposal:
We can add a new feature like, VIRTIO_NET_F_OFFSET and add a new filed 
in virtio_net_header; if this feature is negotiated, the vhost side can 
report the "offset" in virtio_net_header, and the frontend side will 
recognize this value and adjust the packet buffer accordingly.

Any comments?

Thanks,
Jianfeng


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

