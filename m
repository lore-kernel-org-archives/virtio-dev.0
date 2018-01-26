Return-Path: virtio-dev-return-3084-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id D82AA1CB807A
	for <virtio-dev@lists.oasis-open.org>; Fri, 26 Jan 2018 10:15:25 -0800 (PST)
References: <1515736720-39368-1-git-send-email-sridhar.samudrala@intel.com>
 <1515736720-39368-3-git-send-email-sridhar.samudrala@intel.com>
 <20180126185617-mutt-send-email-mst@kernel.org>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <dcebb89c-dff9-c499-a5ff-39aee79ce985@intel.com>
Date: Fri, 26 Jan 2018 10:15:13 -0800
MIME-Version: 1.0
In-Reply-To: <20180126185617-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [RFC PATCH net-next v2 2/2] virtio_net: Extend virtio to use VF
 datapath when available
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl
List-ID: <virtio-dev.lists.oasis-open.org>



On 1/26/2018 8:58 AM, Michael S. Tsirkin wrote:
> On Thu, Jan 11, 2018 at 09:58:39PM -0800, Sridhar Samudrala wrote:
>> @@ -2859,6 +3123,42 @@ static struct virtio_driver virtio_net_driver = {
>>   #endif
>>   };
>>   
>> +static int virtio_netdev_event(struct notifier_block *this,
>> +			       unsigned long event, void *ptr)
>> +{
>> +	struct net_device *event_dev = netdev_notifier_info_to_dev(ptr);
>> +
>> +	/* Skip our own events */
>> +	if (event_dev->netdev_ops == &virtnet_netdev)
>> +		return NOTIFY_DONE;
>> +
>> +	/* Avoid non-Ethernet type devices */
>> +	if (event_dev->type != ARPHRD_ETHER)
>> +		return NOTIFY_DONE;
>> +
>> +	/* Avoid Vlan dev with same MAC registering as VF */
>> +	if (is_vlan_dev(event_dev))
>> +		return NOTIFY_DONE;
>> +
>> +	/* Avoid Bonding master dev with same MAC registering as VF */
>> +	if ((event_dev->priv_flags & IFF_BONDING) &&
>> +	    (event_dev->flags & IFF_MASTER))
>> +		return NOTIFY_DONE;
>> +
>> +	switch (event) {
>> +	case NETDEV_REGISTER:
>> +		return virtnet_register_vf(event_dev);
>> +	case NETDEV_UNREGISTER:
>> +		return virtnet_unregister_vf(event_dev);
>> +	default:
>> +		return NOTIFY_DONE;
>> +	}
>> +}
>> +
>> +static struct notifier_block virtio_netdev_notifier = {
>> +	.notifier_call = virtio_netdev_event,
>> +};
>> +
>>   static __init int virtio_net_driver_init(void)
>>   {
>>   	int ret;
>> @@ -2877,6 +3177,8 @@ static __init int virtio_net_driver_init(void)
>>           ret = register_virtio_driver(&virtio_net_driver);
>>   	if (ret)
>>   		goto err_virtio;
>> +
>> +	register_netdevice_notifier(&virtio_netdev_notifier);
>>   	return 0;
>>   err_virtio:
>>   	cpuhp_remove_multi_state(CPUHP_VIRT_NET_DEAD);
>> @@ -2889,6 +3191,7 @@ module_init(virtio_net_driver_init);
>>   
>>   static __exit void virtio_net_driver_exit(void)
>>   {
>> +	unregister_netdevice_notifier(&virtio_netdev_notifier);
>>   	unregister_virtio_driver(&virtio_net_driver);
>>   	cpuhp_remove_multi_state(CPUHP_VIRT_NET_DEAD);
>>   	cpuhp_remove_multi_state(virtionet_online);
> I have a question here: what if PT device driver module loads
> and creates a device before virtio?
>
>
Initially i also had this question if we get NETDEV_REGISTER events for 
netdevs
that are already present. But it looks like 
register_netdevice_notifier() will cause
replay of all the registration and up events of existing devices.

/**
  * register_netdevice_notifier - register a network notifier block
  * @nb: notifier
  *
  * Register a notifier to be called when network device events occur.
  * The notifier passed is linked into the kernel structures and must
  * not be reused until it has been unregistered. A negative errno code
  * is returned on a failure.
  *
  * When registered all registration and up events are replayed
  * to the new notifier to allow device to have a race free
  * view of the network device list.
  */

Thanks
Sridhar

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

