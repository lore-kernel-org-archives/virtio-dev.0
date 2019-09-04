Return-Path: virtio-dev-return-6047-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 64AFF985EA1
	for <virtio-dev@lists.oasis-open.org>; Wed,  4 Sep 2019 19:28:52 +0000 (UTC)
Date: Wed, 4 Sep 2019 15:28:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190904152244-mutt-send-email-mst@kernel.org>
References: <20190904150920.13848.32271.stgit@localhost.localdomain>
 <20190904151055.13848.27351.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190904151055.13848.27351.stgit@localhost.localdomain>
Subject: [virtio-dev] Re: [PATCH v7 5/6] virtio-balloon: Pull page poisoning config out of
 free page hinting
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: nitesh@redhat.com, kvm@vger.kernel.org, david@redhat.com, dave.hansen@intel.com, linux-kernel@vger.kernel.org, willy@infradead.org, mhocko@kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, virtio-dev@lists.oasis-open.org, osalvador@suse.de, yang.zhang.wz@gmail.com, pagupta@redhat.com, riel@surriel.com, konrad.wilk@oracle.com, lcapitulino@redhat.com, wei.w.wang@intel.com, aarcange@redhat.com, pbonzini@redhat.com, dan.j.williams@intel.com, alexander.h.duyck@linux.intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Sep 04, 2019 at 08:10:55AM -0700, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> 
> Currently the page poisoning setting wasn't being enabled unless free page
> hinting was enabled. However we will need the page poisoning tracking logic
> as well for unused page reporting. As such pull it out and make it a
> separate bit of config in the probe function.
> 
> In addition we can actually wrap the code in a check for NO_SANITY. If we
> don't care what is actually in the page we can just default to 0 and leave
> it there.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> ---
>  drivers/virtio/virtio_balloon.c |   19 +++++++++++++------
>  mm/page_reporting.c             |    4 ++++
>  2 files changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 226fbb995fb0..2c19457ab573 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -842,7 +842,6 @@ static int virtio_balloon_register_shrinker(struct virtio_balloon *vb)
>  static int virtballoon_probe(struct virtio_device *vdev)
>  {
>  	struct virtio_balloon *vb;
> -	__u32 poison_val;
>  	int err;
>  
>  	if (!vdev->config->get) {
> @@ -909,11 +908,19 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  						  VIRTIO_BALLOON_CMD_ID_STOP);
>  		spin_lock_init(&vb->free_page_list_lock);
>  		INIT_LIST_HEAD(&vb->free_page_list);
> -		if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
> -			memset(&poison_val, PAGE_POISON, sizeof(poison_val));
> -			virtio_cwrite(vb->vdev, struct virtio_balloon_config,
> -				      poison_val, &poison_val);
> -		}
> +	}
> +	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
> +		__u32 poison_val = 0;
> +
> +#if !defined(CONFIG_PAGE_POISONING_NO_SANITY)
> +		/*
> +		 * Let hypervisor know that we are expecting a specific
> +		 * value to be written back in unused pages.
> +		 */
> +		memset(&poison_val, PAGE_POISON, sizeof(poison_val));
> +#endif
> +		virtio_cwrite(vb->vdev, struct virtio_balloon_config,
> +			      poison_val, &poison_val);
>  	}
>  	/*
>  	 * We continue to use VIRTIO_BALLOON_F_DEFLATE_ON_OOM to decide if a

I'm a bit confused by this part. Should we not just clear
VIRTIO_BALLOON_F_PAGE_POISON completely?

In my mind the value written should be what guest puts in
free pages - and possibly what it expects to find there later.

If it doesn't expect anything there then it makes sense
to clear VIRTIO_BALLOON_F_PAGE_POISON so that host does
not try to put the poison value there.
But I think that it does not make sense to lie to host about the poison
value - I think that if we do send poison value to
host it's reasonable for host to expect free pages
have that value - and even possibly to validate that.

So I think that the hack belongs in virtballoon_validate,
near the page_poisoning_enabled check.



> diff --git a/mm/page_reporting.c b/mm/page_reporting.c
> index 5006b08d5eec..35c0fe4c4471 100644
> --- a/mm/page_reporting.c
> +++ b/mm/page_reporting.c
> @@ -299,6 +299,10 @@ int page_reporting_startup(struct page_reporting_dev_info *phdev)
>  	struct zone *zone;
>  	int err = 0;
>  
> +	/* No point in enabling this if it cannot handle any pages */
> +	if (!phdev->capacity)
> +		return -EINVAL;
> +
>  	mutex_lock(&page_reporting_mutex);
>  
>  	/* nothing to do if already in use */

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

