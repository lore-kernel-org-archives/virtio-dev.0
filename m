Return-Path: virtio-dev-return-8036-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 23388986174
	for <virtio-dev@lists.oasis-open.org>; Thu, 25 Feb 2021 09:36:03 +0000 (UTC)
Date: Thu, 25 Feb 2021 10:35:54 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20210225093554.lvuzsbfkmbhw37qi@sirius.home.kraxel.org>
References: <20210225082109.GA29537@lily.local>
MIME-Version: 1.0
In-Reply-To: <20210225082109.GA29537@lily.local>
Subject: Re: [virtio-dev] Is virtio-snd merged and upstreamed to qemu.org
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Veera <vlse@vkten.in>
Cc: Anton Yakovlev <anton.yakovlev@opensynergy.com>, virtio-dev@lists.oasis-open.org, chouhan.shreyansh2702@gmail.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 25, 2021 at 01:51:16PM +0530, Veera wrote:
> Hi,
> 
> Is virtio-snd patches merged and upstreamed to Qemu.org?

There are no qemu patches right now (there are other hypervisors beside
qemu/kvm ...).

Shreyansh Chouhan (added to Cc) is working on a qemu host
implementation.

> When Linux kernel virtio-snd driver will be upstreamed to kernel.org
> or Greg KH testing branch?

mst picked up the patches posted recently, they should land mainline
in 5.12 or 5.13.

take care,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

