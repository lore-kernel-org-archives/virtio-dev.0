Return-Path: virtio-dev-return-5322-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2986998437F
	for <virtio-dev@lists.oasis-open.org>; Mon, 14 Jan 2019 18:42:03 +0000 (UTC)
Date: Mon, 14 Jan 2019 13:41:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190114133709-mutt-send-email-mst@kernel.org>
References: <1542104867-11143-1-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1542104867-11143-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] Re: [PATCH v1 0/2] Virtio-balloon Updates
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Nov 13, 2018 at 06:27:45PM +0800, Wei Wang wrote:
> This patch series adds 2 features to the virtio-balloon spec.
> The VIRTIO_BALLOON_F_FREE_PAGE_HINT feature supports guest to report
> free page hints to host.
> The VIRTIO_BALLOON_F_PAGE_POISON feature supports guest to report the
> memory poison value to host.

So spec comments/patches should go to virtio-comment not virtio-dev really.
And we normally want a github issue to track it,
with the patch including a link to it in a Fixes: tag.

Then once you feel there's a rough concensus you can open
ask the TC to vote on a change proposal.

Another minor suggestion, I think two patches is an overkill, one would
be ok here.
Thanks!


> Wei Wang (2):
>   content/virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
>   content/virtio-balloon: VIRTIO_BALLOON_F_PAGE_POISON
> 
>  content.tex | 140 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 134 insertions(+), 6 deletions(-)
> 
> -- 
> 2.7.4

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

