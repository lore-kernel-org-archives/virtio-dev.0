Return-Path: virtio-dev-return-3128-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 6BC4B5818F5C
	for <virtio-dev@lists.oasis-open.org>; Thu,  1 Feb 2018 11:28:11 -0800 (PST)
From: Jonathan Helman <jonathan.helman@oracle.com>
Message-ID: <54682ab5-73c3-1631-563a-9337acc00be0@oracle.com>
Date: Thu, 1 Feb 2018 11:28:05 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] virtio balloon Spec Question
To: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

I see that an email sent 2 years ago contains a change that, from what I 
can tell, never made it into the virtio specification: 
https://lists.oasis-open.org/archives/virtio-comment/201602/msg00004.html

This makes the spec inconsistent with the Linux kernel:

Spec (Section 5.5.6.3): 
http://docs.oasis-open.org/virtio/virtio/v1.0/cs04/virtio-v1.0-cs04.html#x1-2520006
Kernel: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/virtio_balloon.h?h=v4.15

I am working on a change which will add #defines for 7 and 8 to the 
virtio_balloon.h header file in the Linux kernel, and am hence planning 
to submit spec changes to virtio. My change requires the change in the 
email above to be applied to the spec (since that has the #define for 6).

Am I missing this change somewhere?  And if not, could the spec be 
updated with the change from the email above?

Thank you,
Jon Helman

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

