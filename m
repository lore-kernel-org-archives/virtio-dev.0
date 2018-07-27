Return-Path: virtio-dev-return-4752-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1E4B5985CA6
	for <virtio-dev@lists.oasis-open.org>; Fri, 27 Jul 2018 14:06:32 +0000 (UTC)
Date: Fri, 27 Jul 2018 17:06:27 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180727170605-mutt-send-email-mst@kernel.org>
References: <1532683495-31974-1-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1532683495-31974-1-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] Re: [PATCH v2 0/2] virtio-balloon: some improvements
To: Wei Wang <wei.w.wang@intel.com>
Cc: virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, mhocko@kernel.org, akpm@linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jul 27, 2018 at 05:24:53PM +0800, Wei Wang wrote:
> This series is split from the "Virtio-balloon: support free page
> reporting" series to make some improvements.
> 
> v1->v2 ChangeLog:
> - register the shrinker when VIRTIO_BALLOON_F_DEFLATE_ON_OOM is negotiated.
> 
> Wei Wang (2):
>   virtio-balloon: remove BUG() in init_vqs
>   virtio_balloon: replace oom notifier with shrinker

Thanks!
Given it's very late in the release cycle, I'll merge this for
the next Linux release.

>  drivers/virtio/virtio_balloon.c | 125 +++++++++++++++++++++++-----------------
>  1 file changed, 72 insertions(+), 53 deletions(-)
> 
> -- 
> 2.7.4

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

