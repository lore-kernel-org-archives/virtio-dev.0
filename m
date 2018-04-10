Return-Path: virtio-dev-return-3787-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 8A5075819205
	for <virtio-dev@lists.oasis-open.org>; Tue, 10 Apr 2018 08:59:06 -0700 (PDT)
References: <1522962503-3963-1-git-send-email-sridhar.samudrala@intel.com>
 <1522962503-3963-4-git-send-email-sridhar.samudrala@intel.com>
 <20180406124814.GA24525@nanopsycho>
 <bb4f0821-246f-1052-de8b-d96be3388ed3@intel.com>
 <20180409080751.GE19345@nanopsycho>
 <16b2e531-7bfa-7f25-2702-f3f8069663ee@intel.com>
 <20180410105504.GA2028@nanopsycho>
 <2ccfad76-589d-9dca-7e4b-9bafee41f844@intel.com>
 <20180410152205.GF2028@nanopsycho>
 <d08ed1e6-678a-7b34-cd2e-52788ceec919@intel.com>
 <20180410154304.GG2028@nanopsycho>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <82f741a2-2512-39de-84c6-874f126c27ea@intel.com>
Date: Tue, 10 Apr 2018 08:59:02 -0700
MIME-Version: 1.0
In-Reply-To: <20180410154304.GG2028@nanopsycho>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [virtio-dev] Re: [RFC PATCH net-next v5 3/4] virtio_net: Extend virtio to use VF
 datapath when available
To: Jiri Pirko <jiri@resnulli.us>
Cc: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 4/10/2018 8:43 AM, Jiri Pirko wrote:
> Tue, Apr 10, 2018 at 05:27:48PM CEST, sridhar.samudrala@intel.com wrote:
>> On 4/10/2018 8:22 AM, Jiri Pirko wrote:
>>> Tue, Apr 10, 2018 at 05:13:40PM CEST, sridhar.samudrala@intel.com wrote:
>>>> On 4/10/2018 3:55 AM, Jiri Pirko wrote:
>>>>> Mon, Apr 09, 2018 at 08:47:06PM CEST, sridhar.samudrala@intel.com wrote:
>>>>>> On 4/9/2018 1:07 AM, Jiri Pirko wrote:
>>>>>>> Sat, Apr 07, 2018 at 12:59:14AM CEST, sridhar.samudrala@intel.com wrote:
>>>>>>>> On 4/6/2018 5:48 AM, Jiri Pirko wrote:
>>>>>>>>> Thu, Apr 05, 2018 at 11:08:22PM CEST, sridhar.samudrala@intel.com wrote:
>>>>>>> [...]
>>>>>>>
>>>>>>>>>> +static int virtnet_bypass_join_child(struct net_device *bypass_netdev,
>>>>>>>>>> +				     struct net_device *child_netdev)
>>>>>>>>>> +{
>>>>>>>>>> +	struct virtnet_bypass_info *vbi;
>>>>>>>>>> +	bool backup;
>>>>>>>>>> +
>>>>>>>>>> +	vbi = netdev_priv(bypass_netdev);
>>>>>>>>>> +	backup = (child_netdev->dev.parent == bypass_netdev->dev.parent);
>>>>>>>>>> +	if (backup ? rtnl_dereference(vbi->backup_netdev) :
>>>>>>>>>> +			rtnl_dereference(vbi->active_netdev)) {
>>>>>>>>>> +		netdev_info(bypass_netdev,
>>>>>>>>>> +			    "%s attempting to join bypass dev when %s already present\n",
>>>>>>>>>> +			    child_netdev->name, backup ? "backup" : "active");
>>>>>>>>> Bypass module should check if there is already some other netdev
>>>>>>>>> enslaved and refuse right there.
>>>>>>>> This will work for virtio-net with 3 netdev model, but this check has to be done by netvsc
>>>>>>>> as its bypass_netdev is same as the backup_netdev.
>>>>>>>> Will add a flag while registering with the bypass module to indicate if the driver is doing
>>>>>>>> a 2 netdev or 3 netdev model and based on that flag this check can be done in bypass module
>>>>>>>> for 3 netdev scenario.
>>>>>>> Just let me undestand it clearly. What I expect the difference would be
>>>>>>> between 2netdev and3 netdev model is this:
>>>>>>> 2netdev:
>>>>>>>       bypass_master
>>>>>>>          /
>>>>>>>         /
>>>>>>> VF_slave
>>>>>>>
>>>>>>> 3netdev:
>>>>>>>       bypass_master
>>>>>>>          /     \
>>>>>>>         /       \
>>>>>>> VF_slave   backup_slave
>>>>>>>
>>>>>>> Is that correct? If not, how does it look like?
>>>>>>>
>>>>>>>
>>>>>> Looks correct.
>>>>>> VF_slave and backup_slave are the original netdevs and are present in both the models.
>>>>>> In the 3 netdev model, bypass_master netdev is created and VF_slave and backup_slave are
>>>>>> marked as the 2 slaves of this new netdev.
>>>>> You say it looks correct and in another sentence you provide completely
>>>>> different description. Could you please look again?
>>>>>
>>>> To be exact, 2 netdev model with netvsc looks like this.
>>>>
>>>>      netvsc_netdev
>>>>        /
>>>>       /
>>>> VF_slave
>>>>
>>>> With virtio_net, 3 netdev model
>>>>
>>>>    bypass_netdev
>>>>        /     \
>>>>       /       \
>>>> VF_slave   virtio_net netdev
>>> Could you also mark the original netdev which is there now? is it
>>> bypass_netdev or virtio_net_netdev ?
>> bypass_netdev
>>      /     \
>>     /       \
>> VF_slave   virtio_net netdev (original)
> That does not make sense.
> 1) You diverge from the behaviour of the netvsc, where the original
>     netdev is a master of the VF
> 2) If the original netdev is a slave, you cannot have any IP address
>     configured on it (well you could, but the rx_handler would eat every
>     incoming packet). So you will break the user bacause he would have to
>     move the configuration to the new master device.
> This only makes sense that the original netdev becomes the master for both
> netvsc and virtio_net.
Forgot to mention that bypass_netdev takes over the name of the original 
netdev and
virtio_net netdev will get the backup name.
So the userspace network configuration doesn't need to change.



---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

