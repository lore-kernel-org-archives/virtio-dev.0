Return-Path: virtio-dev-return-4055-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 909B35818FAC
	for <virtio-dev@lists.oasis-open.org>; Wed,  9 May 2018 12:18:35 -0700 (PDT)
From: Thomas Tai <thomas.tai@oracle.com>
Date: Wed,  9 May 2018 15:53:04 -0400
Message-Id: <1525895585-79023-1-git-send-email-thomas.tai@oracle.com>
Subject: [virtio-dev] [PATCH V2 0/1] virtio-balloon: fix internal stat name array to match Linux kernel
To: mst@redhat.com
Cc: jasowang@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, rob.gardner@oracle.com, thomas.tai@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Michael,
As you have suggested I have imported the kernel header
file and use the new macro to create the string array.
Would you kindly review the patch for me? Please feel
free to comment.

Thank you,
Thomas



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

