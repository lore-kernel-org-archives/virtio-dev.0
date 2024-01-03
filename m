Return-Path: <virtio-dev-return-14209-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0E70C47079
	for <virtio-dev@archiver.kernel.org>; Wed,  3 Jan 2024 06:35:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 00CF126A56
	for <virtio-dev@archiver.kernel.org>; Wed,  3 Jan 2024 06:35:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E83FF986595
	for <virtio-dev@archiver.kernel.org>; Wed,  3 Jan 2024 06:35:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id DC5A198656F; Wed,  3 Jan 2024 06:35:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BF21998656D;
	Wed,  3 Jan 2024 06:35:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R291e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0VzsvWJU_1704263702;
From: Heng Qi <hengqi@linux.alibaba.com>
To: virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org
Cc: Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cornelia Huck <cohuck@redhat.com>
Date: Wed,  3 Jan 2024 14:35:02 +0800
Message-Id: <1704263702-50528-1-git-send-email-hengqi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Subject: [virtio-dev] [PATCH v8] virtio-net: correct conditions for devices to validate packet checksum

There is a historical error in virtio spec:
  "If VIRTIO_NET_F_GUEST_CSUM is not negotiated, the device *MUST* set flags
   to zero and SHOULD supply a fully checksummed packet to the driver."

Currently in Linux and virtio-related implementations, the device validates
the packet checksum and sets DATA_VALID regardless of whether
VIRTIO_NET_F_GUEST_CSUM is negotiated.

Please refer to the following summary and thread[1] for details and reasons:

Summary
=============
1. GUEST_CSUM at virtio spec 0.95 is intended to be compatible with partially
checksummed packets (NEEDS_CSUM <-> CHECKSUM_PARTIAL). So GUEST_CSUM is mapped
to NETIF_F_RXCSUM.
GUEST_CSUM only indicates whether the driver handles partially checksummed packets.
When XDP is loaded, the GUEST_CSUM's offload will be disabled, which means that
packets have NEEDS_CSUM set will be dropped, and packets have DATA_VALID set will
still be received.

2. When DATA_VALID was added to Linux in 2011[2] and virtio1.0, it was actually
expected that rx checksum offload (the driver can set CHECKSUM_UNNECESSARY) had
nothing to do with whether GUEST_CSUM was negotiated. But due to an error, below
desctiption was added incorrectly:
  "If VIRTIO_NET_F_GUEST_CSUM is not negotiated, the device *MUST* set flags
   to zero and SHOULD supply a fully checksummed packet to the driver."

3. We now hope to correct this error. Let the setting of DATA_VALID not be
controlled by whether GUEST_CSUM is negotiated, but only controlled by whether
rx checksum offload is enabled on the OS side. The state of this rx checksum
offload is not aware of the device.

4. [Optional] NETIF_F_RXCSUM corresponding to rx checksum offload should be
added to dev->hw_features. When the user turns off rx checksum offload through
ethtool -K, neither NEEDS_CSUM nor DATA_VALID should be taken care of, that is,
all packets will be marked as CHECKSUM_NONE.

Related Link
=============
[1] https://lists.oasis-open.org/archives/virtio-comment/202312/msg00135.html
[2] 10a8d94a9574 ("virtio_net: introduce VIRTIO_NET_HDR_F_DATA_VALID")

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/185

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
---
v7->v8:
- Drop the new FULLY_CSUM feature and optimize the description. @Jason

v6->v7:
- FULLY_CSUM no longer depends on GUEST_CSUM.
- The description related to DATA_VALID has nothing to do with
  whether GUEST_CSUM is negotiated or not. @Jason

v5->v6:
- Rewrite and clarify patch description. @Michael

v4->v5:
- Remove the modification to the GUEST_CSUM. @Jason
- The description of this feature has been reorganized for greater clarity. @Michael

v3->v4:
- Streamline some repetitive descriptions. @Jason
- Add how features should work, when to be enabled, and overhead. @Jason @Michael

v2->v3:
- Add a section named "Driver Handles Fully Checksummed Packets"
  and more descriptions. @Michael

v1->v2:
- Modify full checksum functionality as a configurable offload
  that is initially turned off. @Jason

 device-types/net/description.tex | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/device-types/net/description.tex b/device-types/net/description.tex
index aff5e08..14978c0 100644
--- a/device-types/net/description.tex
+++ b/device-types/net/description.tex
@@ -723,8 +723,7 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
   \field{num_buffers} is one, then the entire packet will be
   contained within this buffer, immediately following the struct
   virtio_net_hdr.
-\item If the VIRTIO_NET_F_GUEST_CSUM feature was negotiated, the
-  VIRTIO_NET_HDR_F_DATA_VALID bit in \field{flags} can be
+\item The VIRTIO_NET_HDR_F_DATA_VALID bit in \field{flags} can be
   set: if so, device has validated the packet checksum.
   In case of multiple encapsulated protocols, one level of checksums
   has been validated.
@@ -783,9 +782,8 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 packet together, such that at least \field{num_buffers} are
 observed by driver as used.
 
-If VIRTIO_NET_F_GUEST_CSUM is not negotiated, the device MUST set
-\field{flags} to zero and SHOULD supply a fully checksummed
-packet to the driver.
+If VIRTIO_NET_F_GUEST_CSUM is not negotiated, the device SHOULD supply
+a fully checksummed packet to the driver.
 
 If VIRTIO_NET_F_GUEST_TSO4 is not negotiated, the device MUST NOT set
 \field{gso_type} to VIRTIO_NET_HDR_GSO_TCPV4.
@@ -842,12 +840,6 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
 not less than the length of the headers, including the transport
 header.
 
-If the VIRTIO_NET_F_GUEST_CSUM feature has been negotiated, the
-device MAY set the VIRTIO_NET_HDR_F_DATA_VALID bit in
-\field{flags}, if so, the device MUST validate the packet
-checksum (in case of multiple encapsulated protocols, one level
-of checksums is validated).
-
 \drivernormative{\paragraph}{Processing of Incoming
 Packets}{Device Types / Network Device / Device Operation /
 Processing of Incoming Packets}
-- 
1.8.3.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

