Return-Path: <virtio-dev-return-10344-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4D42A9863D8
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Dec 2022 19:16:06 +0000 (UTC)
Date: Wed, 21 Dec 2022 14:15:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20221221141451-mutt-send-email-mst@kernel.org>
References: <20221221145433.254805-1-lstoakes@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20221221145433.254805-1-lstoakes@gmail.com>
Subject: [virtio-dev] Re: [PATCH v2] virtio-blk: avoid kernel panic on VIRTIO_BLK_F_ZONED
 check
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: linux-block@vger.kernel.org, Dmitry Fomichev <dmitry.fomichev@wdc.com>, Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jens Axboe <axboe@kernel.dk>, Damien Le Moal <damien.lemoal@opensource.wdc.com>, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>, Sam Li <faithilikerun@gmail.com>, Steven Rostedt <rostedt@goodmis.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Dec 21, 2022 at 02:54:33PM +0000, Lorenzo Stoakes wrote:
> virtio zoned block device support is added by commit 0562d7bf1604
> ("virtio-blk: add support for zoned block devices") which adds
> VIRTIO_BLK_F_ZONED to the features array in virtio_blk.c but makes it
> conditional on CONFIG_BLK_DEV_ZONED.
> 
> In it virtblk_probe() calls virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)
> unconditionally, which invokes virtio_check_driver_offered_feature().
> This function checks whether virtio_blk.feature_table (assigned to
> the static features array) contains the specified feature enum, and if not
> _causes a kernel panic_ via BUG().
> 
> This therefore means that failing to enable CONFIG_BLK_DEV_ZONED while
> using virtio is a guaranteed kernel panic. Fix the issue by making the
> feature test also conditional on CONFIG_BLK_DEV_ZONED.
> 
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

I think this was fixed by
Message-ID: <20221220112340.518841-1-mst@redhat.com>


> ---
>  drivers/block/virtio_blk.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index ff49052e26f7..94d210b10ebb 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1580,7 +1580,8 @@ static int virtblk_probe(struct virtio_device *vdev)
>  	virtblk_update_capacity(vblk, false);
>  	virtio_device_ready(vdev);
>  
> -	if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
> +	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
> +	    virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
>  		err = virtblk_probe_zoned_device(vdev, vblk, q);
>  		if (err)
>  			goto out_cleanup_disk;
> -- 
> 2.39.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

