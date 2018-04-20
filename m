Return-Path: virtio-dev-return-3906-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 14E8D581916B
	for <virtio-dev@lists.oasis-open.org>; Thu, 19 Apr 2018 19:46:19 -0700 (PDT)
Date: Fri, 20 Apr 2018 05:46:15 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180420054538-mutt-send-email-mst@kernel.org>
References: <1524188524-28411-1-git-send-email-sridhar.samudrala@intel.com>
 <1524188524-28411-4-git-send-email-sridhar.samudrala@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524188524-28411-4-git-send-email-sridhar.samudrala@intel.com>
Subject: [virtio-dev] Re: [PATCH v7 net-next 3/4] virtio_net: Extend virtio to use VF
 datapath when available
To: Sridhar Samudrala <sridhar.samudrala@intel.com>
Cc: stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Apr 19, 2018 at 06:42:03PM -0700, Sridhar Samudrala wrote:
> @@ -3010,6 +3043,7 @@ static __init int virtio_net_driver_init(void)
>          ret = register_virtio_driver(&virtio_net_driver);
>  	if (ret)
>  		goto err_virtio;
> +
>  	return 0;
>  err_virtio:
>  	cpuhp_remove_multi_state(CPUHP_VIRT_NET_DEAD);

I'd rather you didn't let's not mix in whitespace changes.

> -- 
> 2.14.3

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

