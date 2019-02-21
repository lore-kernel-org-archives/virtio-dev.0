Return-Path: virtio-dev-return-5489-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4A97C9860C6
	for <virtio-dev@lists.oasis-open.org>; Thu, 21 Feb 2019 16:38:21 +0000 (UTC)
From: Jakub Jermar <jakub.jermar@kernkonzept.com>
Message-ID: <bd73e7d3-b9ed-24bb-a22d-cd81f0239acd@kernkonzept.com>
Date: Thu, 21 Feb 2019 17:38:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] virtio-blk: the nature of discard_sector_alignment
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hello,

my device enforces the discard_sector_alignment on the request (both
sector and num_sectors), but for some reason the blkdiscard command and
Linux driver issue requests that do not honor this alignment.

Does discard_sector_alignment represent a strict requirement that must
be always honored or is it rather a hint to the driver? The wording in
the spec seems to be more lenient while in Linux the field is documented
rather strictly:

/* Discard commands must be aligned to this number of sectors. */
__u32 discard_sector_alignment;

Also, is it reasonable to assume that discard_sector_alignment should be
enforced also on request's num_sectors. It seems to me like one can
theoretically have requests that have num_sectors aligned to
sector-size, but not to discard_sector_alignment.

Thanks in advance,
Jakub

-- 
Kernkonzept GmbH at Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael
Hohmuth

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

