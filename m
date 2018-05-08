Return-Path: virtio-dev-return-4053-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 5C1385818EFF
	for <virtio-dev@lists.oasis-open.org>; Mon,  7 May 2018 17:11:33 -0700 (PDT)
References: <1525731046-10989-1-git-send-email-sridhar.samudrala@intel.com>
 <1525731046-10989-3-git-send-email-sridhar.samudrala@intel.com>
 <20180507165911.45b14c58@xeon-e3>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <d4b8dcae-3d21-3b8b-5881-1fc15617d18a@intel.com>
Date: Mon, 7 May 2018 17:11:21 -0700
MIME-Version: 1.0
In-Reply-To: <20180507165911.45b14c58@xeon-e3>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH net-next v10 2/4] net: Introduce generic failover module
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: mst@redhat.com, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us, aaron.f.brown@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 5/7/2018 4:59 PM, Stephen Hemminger wrote:
> On Mon,  7 May 2018 15:10:44 -0700
> Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
>
>> +	if (netif_running(failover_dev)) {
>> +		err = dev_open(slave_dev);
>> +		if (err && (err != -EBUSY)) {
>> +			netdev_err(failover_dev, "Opening slave %s failed err:%d\n",
>> +				   slave_dev->name, err);
>> +			goto err_dev_open;
>> +		}
>> +	}
>> +
>> +	netif_addr_lock_bh(failover_dev);
>> +	dev_uc_sync_multiple(slave_dev, failover_dev);
>> +	dev_uc_sync_multiple(slave_dev, failover_dev);
>> +	netif_addr_unlock_bh(failover_dev);
>> +
> The order of these is backwards, you want to sync addresses before bringing up.
> Also, doing it this way does not allow udev/systemd the chance to rename VF devices.

During my testing, i noticed that dev_open() may fail with EBUSY in certain scenarios,
If so, the opening of the slave is handled after the rename via the NETDEV_CHANGENAME
event handler.

>
> The complexity of this whole failover mechanism does not make life easier,
> more reliable, or safer for netvsc. I though that was the whole reason for having
> common code.

netvsc doesn't go through this code.

	if (nfo_ops && nfo_ops->slave_register)
                 return nfo_ops->slave_register(slave_dev, failover_dev);

So there is no change in event handling for netvsc 2-netdev model.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

