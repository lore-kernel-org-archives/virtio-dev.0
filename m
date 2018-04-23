Return-Path: virtio-dev-return-3937-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id B631F58191A7
	for <virtio-dev@lists.oasis-open.org>; Mon, 23 Apr 2018 10:21:59 -0700 (PDT)
References: <1524188524-28411-1-git-send-email-sridhar.samudrala@intel.com>
 <1524188524-28411-3-git-send-email-sridhar.samudrala@intel.com>
 <20180422200259-mutt-send-email-mst@kernel.org>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <c252fc18-51fb-e92c-c37b-55e91b42fdbc@intel.com>
Date: Mon, 23 Apr 2018 10:21:45 -0700
MIME-Version: 1.0
In-Reply-To: <20180422200259-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v7 net-next 2/4] net: Introduce generic failover module
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us
List-ID: <virtio-dev.lists.oasis-open.org>

On 4/22/2018 10:06 AM, Michael S. Tsirkin wrote:
> On Thu, Apr 19, 2018 at 06:42:02PM -0700, Sridhar Samudrala wrote:
>> +#if IS_ENABLED(CONFIG_NET_FAILOVER)
>> +
>> +int failover_create(struct net_device *standby_dev,
>> +		    struct failover **pfailover);
> Should we rename all these structs net_failover?
> It's possible to extend the concept to storage I think.

We could, the only downside is that the names become longer. i think we need
to change the filenames and the function names also to be consistent.


>
>> +void failover_destroy(struct failover *failover);
>> +
>> +int failover_register(struct net_device *standby_dev, struct failover_ops *ops,
>> +		      struct failover **pfailover);
>> +void failover_unregister(struct failover *failover);
>> +
>> +int failover_slave_unregister(struct net_device *slave_dev);
>> +
>> +#else
>> +
>> +static inline
>> +int failover_create(struct net_device *standby_dev,
>> +		    struct failover **pfailover);
>> +{
>> +	return 0;
> Does this make callers do something sane?
> Shouldn't these return an error?

Yes. i think i should return -EOPNOTSUPP here, so that we fail
when CONFIG_NET_FAILOVER is not enabled and the virtio-net driver is trying
to create a failover device.


>> +}
>> +
>> +static inline
>> +void failover_destroy(struct failover *failover)
>> +{
>> +}
>> +
>> +static inline
>> +int failover_register(struct net_device *standby_dev, struct failover_ops *ops,
>> +		      struct pfailover **pfailover);
>> +{
>> +	return 0;
>> +}
> struct pfailover seems like a typo.

yes. will also change the return to -EOPNOTSUPP

>
>> +
>> +static inline
>> +void failover_unregister(struct failover *failover)
>> +{
>> +}
>> +
>> +static inline
>> +int failover_slave_unregister(struct net_device *slave_dev)
>> +{
>> +	return 0;
>> +}
> Does anyone test return value of unregister?
> should this be void?

yes. can be changed to void.


>
>> +
>> +#endif
>> +
>> +#endif /* _NET_FAILOVER_H */


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

