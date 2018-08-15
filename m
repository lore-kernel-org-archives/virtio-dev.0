Return-Path: virtio-dev-return-4780-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 41182985C1F
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Aug 2018 15:12:25 +0000 (UTC)
From: Jakub Jermar <jakub.jermar@kernkonzept.com>
Message-ID: <f9a2a8b4-440a-cdb7-87c3-0b2ea7a66c90@kernkonzept.com>
Date: Wed, 15 Aug 2018 17:12:22 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Clarifications for the new DISCARD and WRITE ZEROES commands
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hello,

I am working on a virtio-blk device that implements the newly added
DISCARD and WRITE ZEROES commands [1] and would like to ask for a couple
of clarifications.

Is there a Linux patch that implements the approved change? Having such
a patch would most likely provide the clarifications that I am seeking.
I know of a patch sent to the LKML [2], but that one predates [1] by a
year and does not conform to it.

In the absence of such a conforming patch, I would kindly ask someone to
clarify the relationship between the virtio_blk_discard_write_zeroes
structures and the virtio descriptor. [1] seems to indicate that there
is always one struct virtio_blk_discard_write_zeroes per descriptor, but
the wording is not very clear. If the containing descriptor must be a
multiple of 512 in size (because of u8 data[][512]), there is no way to
figure out how many of these structs it contains. So there must be only
one and the only way to add a segment is to chain descriptors. Unless
the descriptor size is somehow allowed to be a multiple of sizeof(struct
virtio_blk_discard_write_zeroes) in which case it could be determined
and there may be several of these structures per descriptor.

Also, why is it that there is discard_sector_alignment but no
write_zeroes_sector_alignment?

Thanks,
Jakub

[1] https://lists.oasis-open.org/archives/virtio-dev/201803/msg00132.html
[2] http://lkml.iu.edu/hypermail/linux/kernel/1703.3/01525.html

-- 
Kernkonzept GmbH at Dresden, Germany, HRB 31129, CEO Dr.-Ing. Michael
Hohmuth

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

