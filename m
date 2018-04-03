Return-Path: virtio-dev-return-3704-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 672A85818F7C
	for <virtio-dev@lists.oasis-open.org>; Tue,  3 Apr 2018 05:20:41 -0700 (PDT)
Date: Tue, 3 Apr 2018 15:20:27 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180403151915-mutt-send-email-mst@kernel.org>
References: <1522573990-5242-1-git-send-email-si-wei.liu@oracle.com>
 <1522573990-5242-4-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522573990-5242-4-git-send-email-si-wei.liu@oracle.com>
Subject: [virtio-dev] Re: [RFC PATCH 3/3] virtio_net: make lower netdevs for virtio_bypass
 hidden
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: jiri@resnulli.us, stephen@networkplumber.org, alexander.h.duyck@intel.com, davem@davemloft.net, jesse.brandeburg@intel.com, kubakici@wp.pl, jasowang@redhat.com, sridhar.samudrala@intel.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Sun, Apr 01, 2018 at 05:13:10AM -0400, Si-Wei Liu wrote:
> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> index aa40664..0827b7e 100644
> --- a/include/uapi/linux/virtio_net.h
> +++ b/include/uapi/linux/virtio_net.h
> @@ -80,6 +80,8 @@ struct virtio_net_config {
>  	__u16 max_virtqueue_pairs;
>  	/* Default maximum transmit unit advice */
>  	__u16 mtu;
> +	/* Device at bus:slot.function backed up by virtio_net */
> +	__u16 bsf2backup;
>  } __attribute__((packed));

I'm not sure this is a good interface.  This isn't unique even on some
PCI systems, not to speak of non-PCI ones.

>  /*
> -- 
> 1.8.3.1

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

