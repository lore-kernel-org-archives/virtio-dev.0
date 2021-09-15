Return-Path: <virtio-dev-return-8666-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 058FB98637F
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Sep 2021 05:53:56 +0000 (UTC)
Date: Wed, 15 Sep 2021 07:53:50 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20210915055350.sgfadzktcl5bngtq@sirius.home.kraxel.org>
References: <20210909013717.861-1-gurchetansingh@chromium.org>
 <20210909013717.861-9-gurchetansingh@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20210909013717.861-9-gurchetansingh@chromium.org>
Subject: [virtio-dev] Re: [PATCH v1 08/12] drm/virtio: implement context init: stop using
 drv->context when creating fence
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Gurchetan Singh <gurchetansingh@chromium.org>
Cc: dri-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Sep 08, 2021 at 06:37:13PM -0700, Gurchetan Singh wrote:
> The plumbing is all here to do this.  Since we always use the
> default fence context when allocating a fence, this makes no
> functional difference.
> 
> We can't process just the largest fence id anymore, since it's
> it's associated with different timelines.  It's fine for fence_id
> 260 to signal before 259.  As such, process each fence_id
> individually.

I guess you need to also update virtio_gpu_fence_event_process()
then?  It currently has the strict ordering logic baked in ...

take care,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

