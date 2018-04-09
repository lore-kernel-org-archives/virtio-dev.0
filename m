Return-Path: virtio-dev-return-3753-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id B82D358191E2
	for <virtio-dev@lists.oasis-open.org>; Mon,  9 Apr 2018 11:47:17 -0700 (PDT)
References: <1522962503-3963-1-git-send-email-sridhar.samudrala@intel.com>
 <1522962503-3963-4-git-send-email-sridhar.samudrala@intel.com>
 <20180406124814.GA24525@nanopsycho>
 <bb4f0821-246f-1052-de8b-d96be3388ed3@intel.com>
 <20180409080751.GE19345@nanopsycho>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <16b2e531-7bfa-7f25-2702-f3f8069663ee@intel.com>
Date: Mon, 9 Apr 2018 11:47:06 -0700
MIME-Version: 1.0
In-Reply-To: <20180409080751.GE19345@nanopsycho>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [virtio-dev] Re: [RFC PATCH net-next v5 3/4] virtio_net: Extend virtio to use VF
 datapath when available
To: Jiri Pirko <jiri@resnulli.us>
Cc: mst@redhat.com, stephen@networkplumber.org, davem@davemloft.net, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, kubakici@wp.pl, jasowang@redhat.com, loseweigh@gmail.com
List-ID: <virtio-dev.lists.oasis-open.org>

On 4/9/2018 1:07 AM, Jiri Pirko wrote:
> Sat, Apr 07, 2018 at 12:59:14AM CEST, sridhar.samudrala@intel.com wrote:
>> On 4/6/2018 5:48 AM, Jiri Pirko wrote:
>>> Thu, Apr 05, 2018 at 11:08:22PM CEST, sridhar.samudrala@intel.com wrote:
> [...]
>
>>>> +static int virtnet_bypass_join_child(struct net_device *bypass_netdev,
>>>> +				     struct net_device *child_netdev)
>>>> +{
>>>> +	struct virtnet_bypass_info *vbi;
>>>> +	bool backup;
>>>> +
>>>> +	vbi = netdev_priv(bypass_netdev);
>>>> +	backup = (child_netdev->dev.parent == bypass_netdev->dev.parent);
>>>> +	if (backup ? rtnl_dereference(vbi->backup_netdev) :
>>>> +			rtnl_dereference(vbi->active_netdev)) {
>>>> +		netdev_info(bypass_netdev,
>>>> +			    "%s attempting to join bypass dev when %s already present\n",
>>>> +			    child_netdev->name, backup ? "backup" : "active");
>>> Bypass module should check if there is already some other netdev
>>> enslaved and refuse right there.
>> This will work for virtio-net with 3 netdev model, but this check has to be done by netvsc
>> as its bypass_netdev is same as the backup_netdev.
>> Will add a flag while registering with the bypass module to indicate if the driver is doing
>> a 2 netdev or 3 netdev model and based on that flag this check can be done in bypass module
>> for 3 netdev scenario.
> Just let me undestand it clearly. What I expect the difference would be
> between 2netdev and3 netdev model is this:
> 2netdev:
>    bypass_master
>       /
>      /
> VF_slave
>
> 3netdev:
>    bypass_master
>       /     \
>      /       \
> VF_slave   backup_slave
>
> Is that correct? If not, how does it look like?
>
>
Looks correct.
VF_slave and backup_slave are the original netdevs and are present in both the models.
In the 3 netdev model, bypass_master netdev is created and VF_slave and backup_slave are
marked as the 2 slaves of this new netdev.

In the 2 netdev model, backup_slave acts as bypass_master and the bypass module doesn't
have access to netdev_priv of the backup_slave.

Once i moved all the ndo_ops of the master netdev to bypass module, i realized that we can
move the create/destroy of the upper netdev also to bypass.c.
That way the changes to virtio_net become very minimal.

With these updates, bypass module now supports both the models by exporting 2 sets of
functions.
3 netdev:
    int bypass_master_create(struct net_device *backup_netdev,
                             struct bypass_master **pbypass_master);
    void bypass_master_destroy(struct bypass_master *bypass_master);


2 netdev:
    int bypass_master_register(struct net_device *backup_netdev, struct bypass_ops *ops,
                               struct bypass_master **pbypass_master);
    void bypass_master_unregister(struct bypass_master *bypass_master);

Will send the next revision in a day or two.

Thanks
Sridhar


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

