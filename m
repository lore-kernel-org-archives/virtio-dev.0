Return-Path: <virtio-dev-return-10570-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 192989865B2
	for <virtio-dev@lists.oasis-open.org>; Thu, 12 Jan 2023 07:02:57 +0000 (UTC)
Date: Thu, 12 Jan 2023 02:02:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230112020204-mutt-send-email-mst@kernel.org>
References: <20221121162756.350032-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20221121162756.350032-1-mst@redhat.com>
Subject: [virtio-dev] Re: [PATCH RFC 0/3] virtio-rng based entropy leak reporting
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Cali, Marco" <xmarcalx@amazon.co.uk>, "Graf (AWS), Alexander" <graf@amazon.de>, "Chalios, Babis" <bchalios@amazon.es>, "Jason A. Donenfeld" <Jason@zx2c4.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Nov 21, 2022 at 11:30:19AM -0500, Michael S. Tsirkin wrote:
> Generally, entropy only grows. However, there are cases where
> it goes down - for example, consider generating a one time
> pad where someone managed to use a side channel to
> steal its contents. By combining the seemingly random
> pad with the stolen contents we have reversed the entropy.
> 
> This actually happens within VMs e.g. when time is reversed due
> to snapshoting. Existing approaches for VMs include Microsoft's
> VM GEN ID.
> 
> This draft proposes a feature in virtio rng for reporting such
> leaks.
> 
> Patches 1,2 refactor existing draft text. Patch 3 adds new functionality.
> 
> TODO:
> 	document theory of operation
> 	add conformance clauses

Guys any input on this? Anyone going to use this?

> 
> Michael S. Tsirkin (3):
>   rng: move to a file of its own
>   rng: be specific about the virtqueue
>   rng: leak detection support
> 
>  content.tex    |  43 +--------------------
>  virtio-rng.tex | 102 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 103 insertions(+), 42 deletions(-)
>  create mode 100644 virtio-rng.tex
> 
> -- 
> MST
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

