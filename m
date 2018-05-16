Return-Path: virtio-dev-return-4088-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id D41AB5818F2F
	for <virtio-dev@lists.oasis-open.org>; Wed, 16 May 2018 18:03:54 -0700 (PDT)
Resent-Message-ID: <20180517010342.GA21128@redhat.com>
Resent-To: virtio-dev@lists.oasis-open.org
Date: Wed, 16 May 2018 22:42:26 +0200
From: Christoffer Dall <christoffer.dall@arm.com>
Message-ID: <20180516204226.GC55598@C02W217FHV2R.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Virtio Spec question: Who modifies the used ring?
To: virtio-comments@lists.oasis-open.org
Cc: mst@redhat.com, Pawel.Moll@arm.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

I was looking at the virtio spec (v1.0-cs04) and I'm confused
about section 2.4.8 "Virtqueue Used Ring".

It says, "idx field indicates where the driver would put the
next descriptor entry in the ring...".

Since this is the used ring, and is only supposed to be written by the
device, shouldn't the text say "...where the device would put..." ?

Or am I missing something fundamental?

Many thanks,
-Christoffer

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

