Return-Path: virtio-dev-return-3029-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 2233358191C6
	for <virtio-dev@lists.oasis-open.org>; Tue, 23 Jan 2018 02:34:23 -0800 (PST)
References: <1515736720-39368-1-git-send-email-sridhar.samudrala@intel.com>
 <1515736720-39368-3-git-send-email-sridhar.samudrala@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <afd11f19-6906-2a7e-1b82-e3138c4d9530@redhat.com>
Date: Tue, 23 Jan 2018 18:33:59 +0800
MIME-Version: 1.0
In-Reply-To: <1515736720-39368-3-git-send-email-sridhar.samudrala@intel.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [RFC PATCH net-next v2 2/2] virtio_net: Extend virtio to use VF
 datapath when available
To: Sridhar Samudrala <sridhar.samudrala@intel.com>, mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl
List-ID: <virtio-dev.lists.oasis-open.org>



On 2018年01月12日 13:58, Sridhar Samudrala wrote:
>   static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>   {
>   	struct virtnet_info *vi = netdev_priv(dev);
>   	int qnum = skb_get_queue_mapping(skb);
>   	struct send_queue *sq = &vi->sq[qnum];
> +	struct net_device *vf_netdev;
>   	int err;
>   	struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
>   	bool kick = !skb->xmit_more;
>   	bool use_napi = sq->napi.weight;
>   
> +	/* If VF is present and up then redirect packets
> +	 * called with rcu_read_lock_bh
> +	 */
> +	vf_netdev = rcu_dereference_bh(vi->vf_netdev);
> +	if (vf_netdev && netif_running(vf_netdev) &&
> +	    !netpoll_tx_running(dev) &&
> +	    is_unicast_ether_addr(eth_hdr(skb)->h_dest))
> +		return virtnet_vf_xmit(dev, vf_netdev, skb);
> +

A question here.

If I read the code correctly, all features were validated against virtio 
instead VF before transmitting. This assumes VF's feature is a superset 
of virtio, does this really work? Do we need to sanitize the feature 
before joining? (e.g at last NETIF_R_GSO_ROBUST needs to be removed).

Thanks

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

