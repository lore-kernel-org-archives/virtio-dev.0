Return-Path: virtio-dev-return-4033-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id E3C72581916B
	for <virtio-dev@lists.oasis-open.org>; Wed,  2 May 2018 10:51:16 -0700 (PDT)
References: <1524848820-42258-1-git-send-email-sridhar.samudrala@intel.com>
 <1524848820-42258-3-git-send-email-sridhar.samudrala@intel.com>
 <20180428090601.GL5632@nanopsycho.orion> <20180502161542.GI19250@nanopsycho>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <052e2c60-dc4c-d6a0-0159-fc1821cb4365@intel.com>
Date: Wed, 2 May 2018 10:51:12 -0700
MIME-Version: 1.0
In-Reply-To: <20180502161542.GI19250@nanopsycho>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH net-next v9 2/4] net: Introduce generic failover module
To: Jiri Pirko <jiri@resnulli.us>
Cc: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, aaron.f.brown@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 5/2/2018 9:15 AM, Jiri Pirko wrote:
> Sat, Apr 28, 2018 at 11:06:01AM CEST, jiri@resnulli.us wrote:
>> Fri, Apr 27, 2018 at 07:06:58PM CEST, sridhar.samudrala@intel.com wrote:
> [...]
>
>
>>> +
>>> +	err = netdev_rx_handler_register(slave_dev, net_failover_handle_frame,
>>> +					 failover_dev);
>>> +	if (err) {
>>> +		netdev_err(slave_dev, "can not register failover rx handler (err = %d)\n",
>>> +			   err);
>>> +		goto err_handler_register;
>>> +	}
>>> +
>>> +	err = netdev_upper_dev_link(slave_dev, failover_dev, NULL);
>> Please use netdev_master_upper_dev_link().
> Don't forget to fillup struct netdev_lag_upper_info - NETDEV_LAG_TX_TYPE_ACTIVEBACKUP
>
>
> Also, please call netdev_lower_state_changed() when the active slave
> device changes from primary->backup of backup->primary and whenever link
> state of a slave changes
>
Sure. will look into it.  Do you think this will help with the issue
you saw with having to change mac on standy twice to get the init scripts
working? We are now going to block changing the mac on both standby and
failover.

Also, i was wondering if we should set dev->flags to IFF_MASTER on failover
and IFF_SLAVE on primary and standby. netvsc does this.
Does this help with the init scripts and network manager to skip slave
devices for dhcp requests?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

