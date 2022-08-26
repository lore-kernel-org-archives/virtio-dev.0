Return-Path: <virtio-dev-return-9840-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AE79098656D
	for <virtio-dev@lists.oasis-open.org>; Fri, 26 Aug 2022 18:05:52 +0000 (UTC)
Message-ID: <784140bb-53d1-e00b-f79a-7b95b0c1052f@oracle.com>
Date: Fri, 26 Aug 2022 11:05:09 -0700
References: <20220825123840.20239-1-gavinl@nvidia.com>
 <20220825123840.20239-3-gavinl@nvidia.com>
 <27204c1c-1767-c968-0481-c052370875d8@oracle.com>
 <PH0PR12MB5481BB5F85A7115A07FBC315DC759@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Si-Wei Liu <si-wei.liu@oracle.com>
In-Reply-To: <PH0PR12MB5481BB5F85A7115A07FBC315DC759@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH RESEND v2 2/2] virtio-net: use mtu size as
 buffer length for big packets
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Parav Pandit <parav@nvidia.com>, Gavin Li <gavinl@nvidia.com>, "stephen@networkplumber.org" <stephen@networkplumber.org>, "davem@davemloft.net" <davem@davemloft.net>, "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>, "alexander.h.duyck@intel.com" <alexander.h.duyck@intel.com>, "kuba@kernel.org" <kuba@kernel.org>, "sridhar.samudrala@intel.com" <sridhar.samudrala@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "loseweigh@gmail.com" <loseweigh@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>
Cc: Gavi Teitz <gavi@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 8/26/2022 9:41 AM, Parav Pandit wrote:
> 	
> 
> From: Si-Wei Liu <si-wei.liu@oracle.com>
> Sent: Friday, August 26, 2022 4:52 AM
> 
>> Sorry for the delay. Didn't notice as this thread was not addressed to my work email. Please copy to my work email if it needs my immediate attention.
> 
> Can you please setup your mail client to post plain text mail as required by mailing list.
> Conversation without it is close to impossible to track.

Fixed.

> +	/* If we can receive ANY GSO packets, we must allocate large ones. */
> +	if (mtu > ETH_DATA_LEN || guest_gso) {
> +		vi->big_packets = true;
> +		/* if the guest offload is offered by the device, user can modify
> +		 * offload capability. In such posted buffers may short fall of size.
> +		 * Hence allocate for max size.
> +		 */
> +		if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS))
> +			vi->big_packets_sg_num = MAX_SKB_FRAGS;
>> MAX_SKB_FRAGS is needed when any of the guest_gso capability is offered. This is per spec regardless if VIRTIO_NET_F_CTRL_GUEST_OFFLOADS is negotiated or not. Quoting spec:
> 
> 
>> If VIRTIO_NET_F_MRG_RXBUF is not negotiated:
>> If VIRTIO_NET_F_GUEST_TSO4, VIRTIO_NET_F_GUEST_TSO6 or VIRTIO_NET_F_GUEST_UFO are negotiated, the driver SHOULD populate the receive queue(s) with buffers of at least 65562 bytes.
> 
> Spec recommendation is good here, but Linux driver knows that such offload settings cannot change if the above feature is not offered.
> So I think we should add the comment and reference to the code to have this optimization.

I don't get what you mean by optimization here. Say if 
VIRTIO_NET_F_GUEST_TSO4 is negotiated while 
VIRTIO_NET_F_CTRL_GUEST_OFFLOADS is not offered, why you consider it an 
optimization to post only MTU sized (with roundup to page) buffers? 
Wouldn't it be an issue if the device is passing up aggregated GSO 
packets of up to 64KB? Noted, GUEST_GSO is implied on when the 
corresponding feature bit is negotiated, regardless the presence of 
VIRTIO_NET_F_CTRL_GUEST_OFFLOADS bit.

-Siwei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

