Return-Path: virtio-dev-return-3378-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 6964F5818EFF
	for <virtio-dev@lists.oasis-open.org>; Fri,  2 Mar 2018 10:38:13 -0800 (PST)
Date: Fri, 2 Mar 2018 20:37:49 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180302203557-mutt-send-email-mst@kernel.org>
References: <1519980450-3404-1-git-send-email-wei.w.wang@intel.com>
 <1519980450-3404-3-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519980450-3404-3-git-send-email-wei.w.wang@intel.com>
Subject: [virtio-dev] Re: [PATCH v3 2/3] virtio-balloon: VIRTIO_BALLOON_F_FREE_PAGE_HINT
To: Wei Wang <wei.w.wang@intel.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, quintela@redhat.com, dgilbert@redhat.com, pbonzini@redhat.com, liliang.opensource@gmail.com, yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com, riel@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Mar 02, 2018 at 04:47:29PM +0800, Wei Wang wrote:
> diff --git a/include/sysemu/balloon.h b/include/sysemu/balloon.h
> index af49e19..16a2aae 100644
> --- a/include/sysemu/balloon.h
> +++ b/include/sysemu/balloon.h

...

> +typedef void (QEMUBalloonFreePageStart)(void *opaque);
> +typedef void (QEMUBalloonFreePageStop)(void *opaque);

So I think the rule is that no bitmap sync must happen
between these two, otherwise a hint might arrive and
override the sync output.

Should be documented I think.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

