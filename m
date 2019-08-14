Return-Path: virtio-dev-return-5976-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6DC58985D15
	for <virtio-dev@lists.oasis-open.org>; Wed, 14 Aug 2019 10:30:10 +0000 (UTC)
Date: Wed, 14 Aug 2019 12:29:49 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190814122949.4946f438.cohuck@redhat.com>
In-Reply-To: <20190812131235.27244-3-nitesh@redhat.com>
References: <20190812131235.27244-1-nitesh@redhat.com>
	<20190812131235.27244-3-nitesh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [RFC][Patch v12 2/2] virtio-balloon: interface to support free
 page reporting
To: Nitesh Narayan Lal <nitesh@redhat.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, pbonzini@redhat.com, lcapitulino@redhat.com, pagupta@redhat.com, wei.w.wang@intel.com, yang.zhang.wz@gmail.com, riel@surriel.com, david@redhat.com, mst@redhat.com, dodgen@google.com, konrad.wilk@oracle.com, dhildenb@redhat.com, aarcange@redhat.com, alexander.duyck@gmail.com, john.starks@microsoft.com, dave.hansen@intel.com, mhocko@suse.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 12 Aug 2019 09:12:35 -0400
Nitesh Narayan Lal <nitesh@redhat.com> wrote:

> Enables the kernel to negotiate VIRTIO_BALLOON_F_REPORTING feature with
> the host. If it is available and page_reporting_flag is set to true,
> page_reporting is enabled and its callback is configured along with
> the max_pages count which indicates the maximum number of pages that
> can be isolated and reported at a time. Currently, only free pages of
> order >= (MAX_ORDER - 2) are reported. To prevent any false OOM
> max_pages count is set to 16.
> 
> By default page_reporting feature is enabled and gets loaded as soon
> as the virtio-balloon driver is loaded. However, it could be disabled
> by writing the page_reporting_flag which is a virtio-balloon parameter.
> 
> Signed-off-by: Nitesh Narayan Lal <nitesh@redhat.com>
> ---
>  drivers/virtio/Kconfig              |  1 +
>  drivers/virtio/virtio_balloon.c     | 64 ++++++++++++++++++++++++++++-
>  include/uapi/linux/virtio_balloon.h |  1 +
>  3 files changed, 65 insertions(+), 1 deletion(-)
> 

> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 226fbb995fb0..defec00d4ee2 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c

(...)

> +static void virtballoon_page_reporting_setup(struct virtio_balloon *vb)
> +{
> +	struct device *dev = &vb->vdev->dev;
> +	int err;
> +
> +	vb->page_reporting_conf.report = virtballoon_report_pages;
> +	vb->page_reporting_conf.max_pages = PAGE_REPORTING_MAX_PAGES;
> +	err = page_reporting_enable(&vb->page_reporting_conf);
> +	if (err < 0) {
> +		dev_err(dev, "Failed to enable reporting, err = %d\n", err);
> +		page_reporting_flag = false;

Should we clear the feature bit in this case as well?

> +		vb->page_reporting_conf.report = NULL;
> +		vb->page_reporting_conf.max_pages = 0;
> +		return;
> +	}
> +}
> +
>  static void set_page_pfns(struct virtio_balloon *vb,
>  			  __virtio32 pfns[], struct page *page)
>  {
> @@ -476,6 +524,7 @@ static int init_vqs(struct virtio_balloon *vb)
>  	names[VIRTIO_BALLOON_VQ_DEFLATE] = "deflate";
>  	names[VIRTIO_BALLOON_VQ_STATS] = NULL;
>  	names[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
> +	names[VIRTIO_BALLOON_VQ_REPORTING] = NULL;
>  
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
>  		names[VIRTIO_BALLOON_VQ_STATS] = "stats";
> @@ -487,11 +536,18 @@ static int init_vqs(struct virtio_balloon *vb)
>  		callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
>  	}
>  
> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
> +		names[VIRTIO_BALLOON_VQ_REPORTING] = "reporting_vq";
> +		callbacks[VIRTIO_BALLOON_VQ_REPORTING] = balloon_ack;

Do we even want to try to set up the reporting queue if reporting has
been disabled via module parameter? Might make more sense to not even
negotiate the feature bit in that case.

> +	}
>  	err = vb->vdev->config->find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX,
>  					 vqs, callbacks, names, NULL, NULL);
>  	if (err)
>  		return err;
>  
> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING))
> +		vb->reporting_vq = vqs[VIRTIO_BALLOON_VQ_REPORTING];
> +
>  	vb->inflate_vq = vqs[VIRTIO_BALLOON_VQ_INFLATE];
>  	vb->deflate_vq = vqs[VIRTIO_BALLOON_VQ_DEFLATE];
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
> @@ -924,6 +980,9 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  		if (err)
>  			goto out_del_balloon_wq;
>  	}
> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING) &&
> +	    page_reporting_flag)
> +		virtballoon_page_reporting_setup(vb);

In that case, you'd only need to check for the feature bit here.

>  	virtio_device_ready(vdev);
>  
>  	if (towards_target(vb))
> @@ -971,6 +1030,8 @@ static void virtballoon_remove(struct virtio_device *vdev)
>  		destroy_workqueue(vb->balloon_wq);
>  	}
>  
> +	if (page_reporting_flag)
> +		page_reporting_disable(&vb->page_reporting_conf);

I think you should not disable it if the feature bit was never offered
in the first place, right?

>  	remove_common(vb);
>  #ifdef CONFIG_BALLOON_COMPACTION
>  	if (vb->vb_dev_info.inode)

(...)

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

