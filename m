Return-Path: virtio-dev-return-4054-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id DC5F15818EFF
	for <virtio-dev@lists.oasis-open.org>; Mon,  7 May 2018 17:24:38 -0700 (PDT)
References: <1525731046-10989-1-git-send-email-sridhar.samudrala@intel.com>
 <1525731046-10989-3-git-send-email-sridhar.samudrala@intel.com>
 <20180507165306.541bd1f2@xeon-e3>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <e8454b29-d66b-9e20-a887-cb312a63847e@intel.com>
Date: Mon, 7 May 2018 17:24:27 -0700
MIME-Version: 1.0
In-Reply-To: <20180507165306.541bd1f2@xeon-e3>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH net-next v10 2/4] net: Introduce generic failover module
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: mst@redhat.com, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us, aaron.f.brown@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 5/7/2018 4:53 PM, Stephen Hemminger wrote:
> On Mon,  7 May 2018 15:10:44 -0700
> Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
>
>> +static struct net_device *net_failover_get_bymac(u8 *mac,
>> +						 struct net_failover_ops **ops)
>> +{
>> +	struct net_device *failover_dev;
>> +	struct net_failover *failover;
>> +
>> +	spin_lock(&net_failover_lock);
>> +	list_for_each_entry(failover, &net_failover_list, list) {
>> +		failover_dev = rtnl_dereference(failover->failover_dev);
>> +		if (ether_addr_equal(failover_dev->perm_addr, mac)) {
>> +			*ops = rtnl_dereference(failover->ops);
>> +			spin_unlock(&net_failover_lock);
>> +			return failover_dev;
>> +		}
>> +	}
>> +	spin_unlock(&net_failover_lock);
>> +	return NULL;
>> +}
> This is broken if non-ethernet devices such as Infiniband are present.

There is check to make sure that a slave and failover devices are of the same type in
net_failover_slave_register()

	failover_dev = net_failover_get_bymac(slave_dev->perm_addr, &nfo_ops);
         if (!failover_dev)
                 goto done;

         if (failover_dev->type != slave_dev->type)
                 goto done;

Do you think this is not good enough? I had an explicit check for ARPHRD_ETHER in
earlier patchsets, but removed it based on Jiri's comment.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

