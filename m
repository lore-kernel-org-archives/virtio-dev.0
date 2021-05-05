Return-Path: virtio-dev-return-8151-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BC306985EDB
	for <virtio-dev@lists.oasis-open.org>; Wed,  5 May 2021 20:11:03 +0000 (UTC)
Date: Wed, 5 May 2021 16:10:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20210505161022-mutt-send-email-mst@kernel.org>
References: <20210420162556.217350-1-egranata@google.com>
 <20210505054314.GA4179527@infradead.org>
MIME-Version: 1.0
In-Reply-To: <20210505054314.GA4179527@infradead.org>
Subject: [virtio-dev] Re: [PATCH] Provide detailed specification of virtio-blk lifetime
 metrics
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Christoph Hellwig <hch@infradead.org>
Cc: Enrico Granata <egranata@google.com>, virtio-dev@lists.oasis-open.org, linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, May 05, 2021 at 06:43:14AM +0100, Christoph Hellwig wrote:
> On Tue, Apr 20, 2021 at 04:25:56PM +0000, Enrico Granata wrote:
> > In the course of review, some concerns were surfaced about the
> > original virtio-blk lifetime proposal, as it depends on the eMMC
> > spec which is not open
> > 
> > Add a more detailed description of the meaning of the fields
> > added by that proposal to the virtio-blk specification, as to
> > make it feasible to understand and implement the new lifetime
> > metrics feature without needing to refer to JEDEC's specification
> > 
> > This patch does not change the meaning of those fields nor add
> > any new fields, but it is intended to provide an open and more
> > clear description of the meaning associated with those fields.
> > 
> > Signed-off-by: Enrico Granata <egranata@google.com>
> 
> Still not a fan of the encoding, but at least it is properly documented
> now:
> 
> Acked-by: Christoph Hellwig <hch@lst.de>

With that, would you like to ack the virtip-blk patch too?
The format didn't actually change ...

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

