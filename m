Return-Path: virtio-dev-return-2712-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 7C8635818F4D
	for <virtio-dev@lists.oasis-open.org>; Tue, 28 Nov 2017 17:24:08 -0800 (PST)
Date: Wed, 29 Nov 2017 03:24:02 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171129032348-mutt-send-email-mst@kernel.org>
References: <2e8c12f5242bcf755a33ee3a0e9ef94339d1808c.1510487579.git.tgolembi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2e8c12f5242bcf755a33ee3a0e9ef94339d1808c.1510487579.git.tgolembi@redhat.com>
Subject: [virtio-dev] Re: [PATCH v3] virtio_balloon: include disk/file caches memory
 statistics
To: =?utf-8?B?VG9tw6HFoSBHb2xlbWJpb3Zza8O9?= <tgolembi@redhat.com>
Cc: linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, Huang Ying <ying.huang@intel.com>, Gal Hammer <ghammer@redhat.com>, Jason Wang <jasowang@redhat.com>, Amnon Ilan <ailan@redhat.com>, Wei Wang <wei.w.wang@intel.com>, Shaohua Li <shli@fb.com>, Rik van Riel <riel@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Nov 12, 2017 at 01:05:38PM +0100, Tomáš Golembiovský wrote:
> Add a new field VIRTIO_BALLOON_S_CACHES to virtio_balloon memory
> statistics protocol. The value represents all disk/file caches.
> 
> In this case it corresponds to the sum of values
> Buffers+Cached+SwapCached from /proc/meminfo.
> 
> Signed-off-by: Tomáš Golembiovský <tgolembi@redhat.com>


I parked this on vhost branch, part of linux next.

> ---
>  drivers/virtio/virtio_balloon.c     | 4 ++++
>  include/uapi/linux/virtio_balloon.h | 3 ++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index f0b3a0b9d42f..d2bd13bbaf9f 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -244,11 +244,13 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
>  	struct sysinfo i;
>  	unsigned int idx = 0;
>  	long available;
> +	unsigned long caches;
>  
>  	all_vm_events(events);
>  	si_meminfo(&i);
>  
>  	available = si_mem_available();
> +	caches = global_node_page_state(NR_FILE_PAGES);
>  
>  #ifdef CONFIG_VM_EVENT_COUNTERS
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_SWAP_IN,
> @@ -264,6 +266,8 @@ static unsigned int update_balloon_stats(struct virtio_balloon *vb)
>  				pages_to_bytes(i.totalram));
>  	update_stat(vb, idx++, VIRTIO_BALLOON_S_AVAIL,
>  				pages_to_bytes(available));
> +	update_stat(vb, idx++, VIRTIO_BALLOON_S_CACHES,
> +				pages_to_bytes(caches));
>  
>  	return idx;
>  }
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index 343d7ddefe04..4e8b8304b793 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -52,7 +52,8 @@ struct virtio_balloon_config {
>  #define VIRTIO_BALLOON_S_MEMFREE  4   /* Total amount of free memory */
>  #define VIRTIO_BALLOON_S_MEMTOT   5   /* Total amount of memory */
>  #define VIRTIO_BALLOON_S_AVAIL    6   /* Available memory as in /proc */
> -#define VIRTIO_BALLOON_S_NR       7
> +#define VIRTIO_BALLOON_S_CACHES   7   /* Disk caches */
> +#define VIRTIO_BALLOON_S_NR       8
>  
>  /*
>   * Memory statistics structure.
> -- 
> 2.15.0

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

