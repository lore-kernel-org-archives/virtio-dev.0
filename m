Return-Path: <virtio-dev-return-12775-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26CCDC77B73
	for <virtio-dev@archiver.kernel.org>; Mon, 22 May 2023 12:12:16 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6183615B66D
	for <virtio-dev@archiver.kernel.org>; Mon, 22 May 2023 12:12:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4B5C19863E3
	for <virtio-dev@archiver.kernel.org>; Mon, 22 May 2023 12:12:15 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3C23B986300; Mon, 22 May 2023 12:12:15 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 26D1E9862FF;
	Mon, 22 May 2023 12:12:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R501e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VjFKLUJ_1684757520;
From: Heng Qi <hengqi@linux.alibaba.com>
To: virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Parav Pandit <parav@nvidia.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date: Mon, 22 May 2023 20:12:00 +0800
Message-Id: <20230522121200.40939-1-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [Proposal] Relationship between XDP and rx-csum in virtio-net


Currently, the VIRTIO_NET_F_GUEST_CSUM(NETIF_F_RXCSUM) feature of the virtio-net
driver conflicts with the loading of the XDP program, which is caused by the
problem described in [1][2], that is, XDP may cause errors in partial csumed-related
fields and resulting in packet dropping. rx CHECKSUM_PARTIAL mainly exists in the
virtualized environment, and its purpose is to save computing resource overhead.

The *goal* of this proposal is to enable the coexistence of XDP and VIRTIO_NET_F_GUEST_CSUM.

1. We need to understand why the device driver receives the rx CHECKSUM_PARTIAL packet.

Drivers related to the virtualized environment, such as virtio-net/veth/loopback,
etc., may receive partial csumed packets.

When the tx device finds that the destination rx device of the packet is
located on the same host, it is clear that the packet may not pass through
the physical link, so the tx device sends the packet with csum_{start, offset}
directly to the rx side to save computational resources without computing a fully csum
(depends on the specific implementation, some virtio-net backend devices are known to
behave like this currently). From [3], the stack trusts such packets.

However, veth still has NETIF_F_RXCSUM turned on when loading XDP. This may cause
packet dropping as [1][2] stated. But currently the veth community does not seem to
have reported such problems, can we guess that the coexistence of XDP and
rx CHECKSUM_PARTIAL has less negative impact?

2. About rx CHECKSUM_UNECESSARY:

We have just seen that in a virtualized environment a packet may flow between the
same host, so not computing the complete csum for the packet saves some cpu resources.

The purpose of the checksum is to verify that packets passing through the
physical link are correct. Of course, it is also reasonable to do a fully csum for
packets of the virtualized environment, which is exactly what we need.

rx CHECKSUM_UNECESSARY indicates that the packet has been fully checked,
that is, it is a credible packet. If such a packet is modified by the XDP program,
the user should recalculate the correct checksum using bpf_csum_diff() and
bpf_{l3,l4}_csum_replace().

Therefore, for those drivers(physical nic drivers?), such as atlantic/bnxt/mlx,
etc., XDP and NETIF_F_RXCSUM coexist, because their packets will be fully checked
at the tx side.

AWS's ena driver is also designed to be in this fully checksum mode
(we also mentioned below that a feature bit can be provided for virtio-net,
telling the sender that a fully checksum must be calculated to implement similar
behavior to other drivers), although it is in a virtualized environment.

3. To sum up:

It seems that only virtio-net sets XDP and VIRTIO_NET_F_GUEST_CSUM as mutually
exclusive, which may cause the following problems:

When XDP loads,

1) For packets that are fully checked by the sender, packets are marked as CHECKSUM_UNECESSARY
by the rx csum hw offloading.

virtio-net driver needs additional CPU resources to compute the checksum for any packet.

When testing with the following command in Aliyun ECS:
    qperf dst_ip -lp 8989 -m 64K -t 20 tcp_bw
    (mtu = 1500, dev layer GRO is on)

The csum-related overhead we tested on X86 is 11.7%, and on ARM is 15.8%.

2)
One of the main functions of the XDP prog is to be used as a monitoring and
firewall, etc., which means that the XDP prog may not modify the packet.
This is applicable to both rx CHECKSUM_PARTIAL and rx CHECKSUM_UNECESSARY,
but we ignore the rx csum hw offloading capability for both cases.

4. How we try to solve:

1) Add a feature bit to the virtio specification to tell the sender that a fully
csumed packet must be sent. Then XDP can coexist with VIRTIO_NET_F_GUEST_CSUM when this
feature bit is negotiated. (similar to ENA behavior)

2) Modify the current virtio-net driver

No longer filter the VIRTIO_NET_F_GUEST_CSUM feature in virtnet_xdp_set().
Then we can immediately get the ability from VIRTIO_NET_F_GUEST_CSUM and enjoy the software
CPU resources saved by rx csum hw offloading.
(This method is a bit rude)

5. Ending 

This is a proposal and does not represent a formal solution. Looking forward to feedback
from the community and exploring a possible/common solution to the problem described in
this proposal.

6. Quote

[1] 18ba58e1c234

    virtio-net: fail XDP set if guest csum is negotiated

    We don't support partial csumed packet since its metadata will be lost
    or incorrect during XDP processing. So fail the XDP set if guest_csum
    feature is negotiated.

[2] e59ff2c49ae1

    virtio-net: disable guest csum during XDP set

    We don't disable VIRTIO_NET_F_GUEST_CSUM if XDP was set. This means we
    can receive partial csumed packets with metadata kept in the
    vnet_hdr. This may have several side effects:

    - It could be overridden by header adjustment, thus is might be not
      correct after XDP processing.
    - There's no way to pass such metadata information through
      XDP_REDIRECT to another driver.
    - XDP does not support checksum offload right now.

    So simply disable guest csum if possible in this the case of XDP.

[3] static inline int skb_csum_unnecessary(const struct sk_buff *skb)
    {
        return ((skb->ip_summed == CHECKSUM_UNNECESSARY) ||
            skb->csum_valid ||
            (skb->ip_summed == CHECKSUM_PARTIAL &&
            skb_checksum_start_offset(skb) >= 0));
    }


Thanks a lot!
-- 
2.19.1.6.gb485710b


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

