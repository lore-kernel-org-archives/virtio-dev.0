Return-Path: virtio-dev-return-4214-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 8E6681CB8078
	for <virtio-dev@lists.oasis-open.org>; Wed, 30 May 2018 19:58:33 -0700 (PDT)
References: <1527180917-39737-1-git-send-email-sridhar.samudrala@intel.com>
 <1527180917-39737-2-git-send-email-sridhar.samudrala@intel.com>
 <20180525153843.503ee052@xeon-e3>
 <00d34f67-f26f-0b20-af3f-2add24ae8a5c@intel.com>
 <20180530225259.2cf3f7be@shemminger-XPS-13-9360>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <32eb5af0-d052-5e30-e065-e362df31ba4a@intel.com>
Date: Wed, 30 May 2018 19:58:30 -0700
MIME-Version: 1.0
In-Reply-To: <20180530225259.2cf3f7be@shemminger-XPS-13-9360>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH net-next v12 1/5] net: Introduce generic failover module
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: mst@redhat.com, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com, jiri@resnulli.us, aaron.f.brown@intel.com, anjali.singhai@intel.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 5/30/2018 7:52 PM, Stephen Hemminger wrote:
> On Fri, 25 May 2018 16:06:58 -0700
> "Samudrala, Sridhar" <sridhar.samudrala@intel.com> wrote:
>
>> On 5/25/2018 3:38 PM, Stephen Hemminger wrote:
>>> On Thu, 24 May 2018 09:55:13 -0700
>>> Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:
>>>   
>>>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>>>> index 03ed492c4e14..0f4ba52b641d 100644
>>>> --- a/include/linux/netdevice.h
>>>> +++ b/include/linux/netdevice.h
>>>> @@ -1421,6 +1421,8 @@ struct net_device_ops {
>>>>     *	entity (i.e. the master device for bridged veth)
>>>>     * @IFF_MACSEC: device is a MACsec device
>>>>     * @IFF_NO_RX_HANDLER: device doesn't support the rx_handler hook
>>>> + * @IFF_FAILOVER: device is a failover master device
>>>> + * @IFF_FAILOVER_SLAVE: device is lower dev of a failover master device
>>>>     */
>>>>    enum netdev_priv_flags {
>>>>    	IFF_802_1Q_VLAN			= 1<<0,
>>>> @@ -1450,6 +1452,8 @@ enum netdev_priv_flags {
>>>>    	IFF_PHONY_HEADROOM		= 1<<24,
>>>>    	IFF_MACSEC			= 1<<25,
>>>>    	IFF_NO_RX_HANDLER		= 1<<26,
>>>> +	IFF_FAILOVER			= 1<<27,
>>>> +	IFF_FAILOVER_SLAVE		= 1<<28,
>>>>    };
>>> Why is FAILOVER any different than other master/slave relationships.
>>> I don't think you need to take up precious netdev flag bits for this.
>> These are netdev priv flags.
>> Jiri says that IFF_MASTER/IFF_SLAVE are bonding specific flags and cannot be used
>> with other failover mechanisms. Team also doesn't use this flags and it has its own
>> priv_flags.
>>
> This change breaks userspace.
> We already have worked with partners to ignore devices marked as IFF_SLAVE,
> and IFF_SLAVE is visible to user space API's.

I specifically made sure not to remove IFF_SLAVE in the netvsc patch.


>
> NAK


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

