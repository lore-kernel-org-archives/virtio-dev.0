Return-Path: virtio-dev-return-2914-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 4E9D11CB8084
	for <virtio-dev@lists.oasis-open.org>; Thu,  4 Jan 2018 12:54:14 -0800 (PST)
References: <cover.1515041373.git.jbaron@akamai.com>
 <e185a03168d0ab68150d21770bf0d02c5ef537c2.1515041373.git.jbaron@akamai.com>
 <20180104182602-mutt-send-email-mst@kernel.org>
From: Jason Baron <jbaron@akamai.com>
Message-ID: <bda195e5-70a3-aecc-260b-7979522d471a@akamai.com>
Date: Thu, 4 Jan 2018 11:57:44 -0500
MIME-Version: 1.0
In-Reply-To: <20180104182602-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [PATCH net-next v3 1/3] virtio_net: propagate linkspeed/duplex
 settings from the hypervisor
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: davem@davemloft.net, jasowang@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>



On 01/04/2018 11:27 AM, Michael S. Tsirkin wrote:
> On Thu, Jan 04, 2018 at 12:16:44AM -0500, Jason Baron wrote:
>> The ability to set speed and duplex for virtio_net is useful in various
>> scenarios as described here:
>>
>> 16032be virtio_net: add ethtool support for set and get of settings
>>
>> However, it would be nice to be able to set this from the hypervisor,
>> such that virtio_net doesn't require custom guest ethtool commands.
>>
>> Introduce a new feature flag, VIRTIO_NET_F_SPEED_DUPLEX, which allows
>> the hypervisor to export a linkspeed and duplex setting. The user can
>> subsequently overwrite it later if desired via: 'ethtool -s'.
>>
>> Note that VIRTIO_NET_F_SPEED_DUPLEX is defined as bit 63, the intention
>> is that device feature bits are to grow down from bit 63, since the
>> transports are starting from bit 24 and growing up.
>>
>> Signed-off-by: Jason Baron <jbaron@akamai.com>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Cc: virtio-dev@lists.oasis-open.org
>> ---
>>  drivers/net/virtio_net.c        | 19 ++++++++++++++++++-
>>  include/uapi/linux/virtio_net.h | 13 +++++++++++++
>>  2 files changed, 31 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 6fb7b65..0b2d314 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -2146,6 +2146,22 @@ static void virtnet_config_changed_work(struct work_struct *work)
>>  
>>  	vi->status = v;
>>  
>> +	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX)) {
>> +		u32 speed;
>> +		u8 duplex;
>> +
>> +		speed = virtio_cread32(vi->vdev,
>> +				       offsetof(struct virtio_net_config,
>> +						speed));
>> +		if (ethtool_validate_speed(speed))
>> +			vi->speed = speed;
>> +		duplex = virtio_cread8(vi->vdev,
>> +				       offsetof(struct virtio_net_config,
>> +						duplex));
>> +		if (ethtool_validate_duplex(duplex))
>> +			vi->duplex = duplex;
>> +	}
>> +
>>  	if (vi->status & VIRTIO_NET_S_LINK_UP) {
>>  		netif_carrier_on(vi->dev);
>>  		netif_tx_wake_all_queues(vi->dev);
>> @@ -2796,7 +2812,8 @@ static struct virtio_device_id id_table[] = {
>>  	VIRTIO_NET_F_CTRL_RX, VIRTIO_NET_F_CTRL_VLAN, \
>>  	VIRTIO_NET_F_GUEST_ANNOUNCE, VIRTIO_NET_F_MQ, \
>>  	VIRTIO_NET_F_CTRL_MAC_ADDR, \
>> -	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS
>> +	VIRTIO_NET_F_MTU, VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, \
>> +	VIRTIO_NET_F_SPEED_DUPLEX
>>  
>>  static unsigned int features[] = {
>>  	VIRTNET_FEATURES,
> 
> Still missing the update from virtnet_config_changed_work, and I think
> it's important to reflex host changes within guest when the
> feature bit has been acked.
> 

I update vi->speed and vi->duplex in virtnet_config_changed_work(). And
I tested using the 'set_link' on/off from the qemu monitor.
Specifically, an 'off' sets the speed and link to 'unknown', and an 'on'
returns the speed and link to the configured speed and duplex. So they
are being updated dynamically now. What host changes are you referring
to that are not reflected?

Thanks,

-Jason


>> diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
>> index fc353b5..5de6ed3 100644
>> --- a/include/uapi/linux/virtio_net.h
>> +++ b/include/uapi/linux/virtio_net.h
>> @@ -57,6 +57,8 @@
>>  					 * Steering */
>>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
>>  
>> +#define VIRTIO_NET_F_SPEED_DUPLEX 63	/* Device set linkspeed and duplex */
>> +
>>  #ifndef VIRTIO_NET_NO_LEGACY
>>  #define VIRTIO_NET_F_GSO	6	/* Host handles pkts w/ any GSO type */
>>  #endif /* VIRTIO_NET_NO_LEGACY */
>> @@ -76,6 +78,17 @@ struct virtio_net_config {
>>  	__u16 max_virtqueue_pairs;
>>  	/* Default maximum transmit unit advice */
>>  	__u16 mtu;
>> +	/*
>> +	 * speed, in units of 1Mb. All values 0 to INT_MAX are legal.
>> +	 * Any other value stands for unknown.
>> +	 */
>> +	__u32 speed;
>> +	/*
>> +	 * 0x00 - half duplex
>> +	 * 0x01 - full duplex
>> +	 * Any other value stands for unknown.
>> +	 */
>> +	__u8 duplex;
>>  } __attribute__((packed));
>>  
>>  /*
>> -- 
>> 2.6.1

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

