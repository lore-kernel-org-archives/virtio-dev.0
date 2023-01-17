Return-Path: <virtio-dev-return-10633-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4B295986461
	for <virtio-dev@lists.oasis-open.org>; Tue, 17 Jan 2023 00:28:06 +0000 (UTC)
Date: Mon, 16 Jan 2023 19:27:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230116191559-mutt-send-email-mst@kernel.org>
References: <20230111152123.148889-1-alvaro.karsz@solid-run.com>
 <PH0PR12MB5481A88FBABF45BC2736AC56DCC19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230116152504-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548176D1EC760DB15826B08DDCC19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230116160634-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481A96FAA7E7C032363D944DCC69@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481A96FAA7E7C032363D944DCC69@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: Re: [virtio-dev] [PATCH v2] virtio_net: support low and high rate of
 notification coalescing
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Alvaro Karsz <alvaro.karsz@solid-run.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 17, 2023 at 12:07:59AM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Monday, January 16, 2023 4:30 PM
> 
> > > > > So, can you please describe the motivation, what problem does the
> > > > > new
> > > > command solve?
> > > > > It is likely that control entity which want to set different
> > > > > coalescing
> > > > parameters likely wants to more than just two values.
> > > > > This is something already supported today.
> > > >
> > > > Interesting. Parav can you give some examples?
> > >
> > > In a Linux OS based system, following drivers [1] uses the interrupt coalescing
> > parameters by using net dim [2].
> > >
> > > Net dim is the control entity which enables to use more than 2 moderation
> > parameters based on the workload instead of two low and high static values.
> > >
> > > [1] list of drivers
> > > a. drivers/net/ethernet/amazon/ena/ena_netdev.c
> > > b. drivers/net/ethernet/broadcom/bcmsysport.c
> > > c. drivers/net/ethernet/broadcom/bnxt/bnxt.c
> > > d. drivers/net/ethernet/broadcom/genet/bcmgenet.c
> > > e. drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
> > > f. drivers/net/ethernet/intel/ice/ice_txrx.c
> > > g. drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
> > > and more...
> > >
> > > [2] https://docs.kernel.org/networking/net_dim.html
> > 
> > But this is net-dim. IIUC it's a software mechanism which tweaks coalescing
> > parameters depending on traffic, right?
> >
> It is more than tweak.
> It adjusts the parameters to avoid system oscillate and constant manual tuning.
>  
> > Consider for example bnxt_dim_work: all this does is set a single set of
> > usecs/packets parameters.
> > IOW it's need already seem to be addressed in the spec.
> > 
> > By comparison this patch is an attempt to offload ethtool's --coalesce
> > parameters to the card. IMO what it misses is completeness, e.g. sample-
> > interval is not specified.
> Yes. fallback rate above low and below high are also missing.

I think what author meant is just mirroring ethtool here.

> > Also, introspection is missing and it's useful to avoid keeping all state in the
> > driver.
> > 
> > Now clearly net dim has potential to make more clever decisions, but OTOH it's
> > clearly heavier weight.
> > 
> Its heavy weight that already exists in one OS.
> OTOH constantly invoking ethtool from user space for a admin/sw is heavy weight too.
> 
> > So I personally see potential for both to be useful.
> > If no why not?
> >
> Lets describe the problem, value and its usefulness to begin.
> I am not against it. I just fail to find its good use with the existence of net dim.
> So lets explain how it is better.

If all you want is what ethtool provides the new interface will
do exactly that completely on the card without involving scheduler.
That seems pretty clear.


> > > > > They are best to be handled a pre-patch to this one.
> > > > > Please split them so that spec improvement work can progress while
> > > > > new
> > > > features are under review.
> > > >
> > > > Yea it's not a bad idea. I figured it out but
> > > >
> > > > > >
> > > > > > +\item[VIRTIO_NET_F_NOTF_COAL_LOW_HIGH(50)] Device supports
> > > > > > notifications coalescing low rate and high rate sets.
> > > > > > +
> > > > > Even though historically, many feature bits exists, adding more
> > > > > feature bits is
> > > > not scalable.
> > > >
> > > > I disagree here. We have unlimited feature bits and I see no problem
> > > > with their scalability. Devices (such as SIOV as opposed to SRIOV)
> > > > which have very limited memory need to use the proposed vq transport
> > > > that intel's working on, pci transport is wasting too much memory
> > > > anyway. I hope we are not going to repeat this discussion for each
> > > > and every new feature :)
> > > >
> > > Pci transport of the virtio in current form asks to put things in device memory.
> > > And it doesn't need to continue this way regardless of SIOV.
> > > It doesn't have any relation to SR-IOV either.
> > >
> > > There are even PF devices too.
> > >
> > > And putting things in feature bit limits the way these devices are composed.
> > > So lets discuss to use control vq for get and set both.
> > >
> > > Feature bit doesn't even cut what is needed. Software doesn't even know
> > what the valid range is.
> > > It needs to be discovered through cvq.
> > 
> > 
> > All well and good but let's not have this discussion in the thread please.
> >
> Ok. This feature bit trying to do multiple features under single bit and all commands are not always useful.
> It needs two feature bits.
> And things start not to scale.
> But fine. 

Which bits? For high and low? Maybe. It's really a single feature
just for 2 thresholds. Which looks like a trivial generalization of one.
But I wonder whether any devices have more than 2 thresholds, or just one.
Do we want N thresholds? How about taking a look at some other
OS-es? I never looked at net dim internal logic to see whether
it can reasonably be offloaded to a card.

All these are valid concerns that need research to address. Any input here?
Feature bits, use of cvq are all cosmetic issues by comparison.



> > 
> > 
> > > > > It is also limits to enable such functionality at very early stage
> > > > > in the device
> > > > configuration.
> > > >
> > > > Not really, it just handles compatibility and enables the commands.
> > > >
> > > Command is nothing but a functionality.
> > 
> > No, during init time it is useful to know whether to hook up to OS mechanisms
> > dealing with specific offloads.
> > 
> It doesn't make sense to register a net device and set its feature bits without really enumerating it fully.
> And if that requires CVQ, it is more efficient anyway.
>
> > > > > So, if at all this proceeds, we want the new admin q to discover
> > > > > and negotiate
> > > > the new features.
> > > > > (Instead of features bits).
> > > >
> > > > Sounds like a new transport. I wouldn't make it gate this proposal.
> > > >
> > > I am not gating the proposal.
> > 
> > what you are however doing is bringing issues unrealted to the patch in
> > question. Let's focus on discussing coalescing here please.
> >
> It is proposing and even modifying the existing feature bit without describing how better it is.
> If one feature requires to extend cvq, it is not a problem. We can surely extend it.
>  
> > 
> > > Ctrl vq only does set.
> > > Control VQ needs the ability to do get also on deciding what to control.
> > > Hence, new things like this can be discovered by net specific ctrol vq.
> > > No need for involving generic device feature bits framework here.
> > 
> > I see even less value in moving compatibility machinery over to a device specific
> > mechanism such as cvq.
> 
> There is lot more to discuss, but I am avoid here in this thread.
> we need to first establish a generic mechanism for discovering net specific features and its value (more than Boolean) in generic cvq way.
> This pave the way forward for more complex things to come in including this.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

