Return-Path: virtio-dev-return-5548-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 890C3983BFA
	for <virtio-dev@lists.oasis-open.org>; Wed, 27 Feb 2019 23:50:50 +0000 (UTC)
Date: Wed, 27 Feb 2019 18:50:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190227184601-mutt-send-email-mst@kernel.org>
References: <20190221203808-mutt-send-email-mst@kernel.org>
 <581e4399-3969-aecd-e923-03bbc0880733@oracle.com>
 <91d4cbb1-be7a-b53c-6b2a-99bef07e7c53@intel.com>
 <d9ef40a2-237b-0cce-4401-ecaeac4c602a@oracle.com>
 <20190222100753-mutt-send-email-mst@kernel.org>
 <e6a53bd1-83ab-f170-406a-03276e8c87e2@oracle.com>
 <20190225210529-mutt-send-email-mst@kernel.org>
 <d1060c75-eaba-ab6f-ff31-38cb3a47c711@oracle.com>
 <20190227173710-mutt-send-email-mst@kernel.org>
 <c72ce9eb-254c-cc3e-1969-f7f108506d5e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c72ce9eb-254c-cc3e-1969-f7f108506d5e@oracle.com>
Subject: Re: [virtio-dev] Re: net_failover slave udev renaming (was Re: [RFC
 PATCH net-next v6 4/4] netvsc: refactor notifier/event handling code to use
 the bypass framework)
To: si-wei liu <si-wei.liu@oracle.com>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, Siwei Liu <loseweigh@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Stephen Hemminger <stephen@networkplumber.org>, David Miller <davem@davemloft.net>, Netdev <netdev@vger.kernel.org>, virtualization@lists.linux-foundation.org, virtio-dev <virtio-dev@lists.oasis-open.org>, "Brandeburg, Jesse" <jesse.brandeburg@intel.com>, Alexander Duyck <alexander.h.duyck@intel.com>, Jakub Kicinski <kubakici@wp.pl>, Jason Wang <jasowang@redhat.com>, liran.alon@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 27, 2019 at 03:34:56PM -0800, si-wei liu wrote:
> 
> 
> On 2/27/2019 2:38 PM, Michael S. Tsirkin wrote:
> > On Tue, Feb 26, 2019 at 04:17:21PM -0800, si-wei liu wrote:
> > > 
> > > On 2/25/2019 6:08 PM, Michael S. Tsirkin wrote:
> > > > On Mon, Feb 25, 2019 at 04:58:07PM -0800, si-wei liu wrote:
> > > > > On 2/22/2019 7:14 AM, Michael S. Tsirkin wrote:
> > > > > > On Thu, Feb 21, 2019 at 11:55:11PM -0800, si-wei liu wrote:
> > > > > > > On 2/21/2019 11:00 PM, Samudrala, Sridhar wrote:
> > > > > > > > On 2/21/2019 7:33 PM, si-wei liu wrote:
> > > > > > > > > On 2/21/2019 5:39 PM, Michael S. Tsirkin wrote:
> > > > > > > > > > On Thu, Feb 21, 2019 at 05:14:44PM -0800, Siwei Liu wrote:
> > > > > > > > > > > Sorry for replying to this ancient thread. There was some remaining
> > > > > > > > > > > issue that I don't think the initial net_failover patch got addressed
> > > > > > > > > > > cleanly, see:
> > > > > > > > > > > 
> > > > > > > > > > > https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1815268
> > > > > > > > > > > 
> > > > > > > > > > > The renaming of 'eth0' to 'ens4' fails because the udev userspace was
> > > > > > > > > > > not specifically writtten for such kernel automatic enslavement.
> > > > > > > > > > > Specifically, if it is a bond or team, the slave would typically get
> > > > > > > > > > > renamed *before* virtual device gets created, that's what udev can
> > > > > > > > > > > control (without getting netdev opened early by the other part of
> > > > > > > > > > > kernel) and other userspace components for e.g. initramfs,
> > > > > > > > > > > init-scripts can coordinate well in between. The in-kernel
> > > > > > > > > > > auto-enslavement of net_failover breaks this userspace convention,
> > > > > > > > > > > which don't provides a solution if user care about consistent naming
> > > > > > > > > > > on the slave netdevs specifically.
> > > > > > > > > > > 
> > > > > > > > > > > Previously this issue had been specifically called out when IFF_HIDDEN
> > > > > > > > > > > and the 1-netdev was proposed, but no one gives out a solution to this
> > > > > > > > > > > problem ever since. Please share your mind how to proceed and solve
> > > > > > > > > > > this userspace issue if netdev does not welcome a 1-netdev model.
> > > > > > > > > > Above says:
> > > > > > > > > > 
> > > > > > > > > >        there's no motivation in the systemd/udevd community at
> > > > > > > > > >        this point to refactor the rename logic and make it work well with
> > > > > > > > > >        3-netdev.
> > > > > > > > > > 
> > > > > > > > > > What would the fix be? Skip slave devices?
> > > > > > > > > > 
> > > > > > > > > There's nothing user can get if just skipping slave devices - the
> > > > > > > > > name is still unchanged and unpredictable e.g. eth0, or eth1 the
> > > > > > > > > next reboot, while the rest may conform to the naming scheme (ens3
> > > > > > > > > and such). There's no way one can fix this in userspace alone - when
> > > > > > > > > the failover is created the enslaved netdev was opened by the kernel
> > > > > > > > > earlier than the userspace is made aware of, and there's no
> > > > > > > > > negotiation protocol for kernel to know when userspace has done
> > > > > > > > > initial renaming of the interface. I would expect netdev list should
> > > > > > > > > at least provide the direction in general for how this can be
> > > > > > > > > solved...
> > > > > > I was just wondering what did you mean when you said
> > > > > > "refactor the rename logic and make it work well with 3-netdev" -
> > > > > > was there a proposal udev rejected?
> > > > > No. I never believed this particular issue can be fixed in userspace alone.
> > > > > Previously someone had said it could be, but I never see any work or
> > > > > relevant discussion ever happened in various userspace communities (for e.g.
> > > > > dracut, initramfs-tools, systemd, udev, and NetworkManager). IMHO the root
> > > > > of the issue derives from the kernel, it makes more sense to start from
> > > > > netdev, work out and decide on a solution: see what can be done in the
> > > > > kernel in order to fix it, then after that engage userspace community for
> > > > > the feasibility...
> > > > > 
> > > > > > Anyway, can we write a time diagram for what happens in which order that
> > > > > > leads to failure?  That would help look for triggers that we can tie
> > > > > > into, or add new ones.
> > > > > > 
> > > > > See attached diagram.
> > > > > 
> > > > > > 
> > > > > > 
> > > > > > > > Is there an issue if slave device names are not predictable? The user/admin scripts are expected
> > > > > > > > to only work with the master failover device.
> > > > > > > Where does this expectation come from?
> > > > > > > 
> > > > > > > Admin users may have ethtool or tc configurations that need to deal with
> > > > > > > predictable interface name. Third-party app which was built upon specifying
> > > > > > > certain interface name can't be modified to chase dynamic names.
> > > > > > > 
> > > > > > > Specifically, we have pre-canned image that uses ethtool to fine tune VF
> > > > > > > offload settings post boot for specific workload. Those images won't work
> > > > > > > well if the name is constantly changing just after couple rounds of live
> > > > > > > migration.
> > > > > > It should be possible to specify the ethtool configuration on the
> > > > > > master and have it automatically propagated to the slave.
> > > > > > 
> > > > > > BTW this is something we should look at IMHO.
> > > > > I was elaborating a few examples that the expectation and assumption that
> > > > > user/admin scripts only deal with master failover device is incorrect. It
> > > > > had never been taken good care of, although I did try to emphasize it from
> > > > > the very beginning.
> > > > > 
> > > > > Basically what you said about propagating the ethtool configuration down to
> > > > > the slave is the key pursuance of 1-netdev model. However, what I am seeking
> > > > > now is any alternative that can also fix the specific udev rename problem,
> > > > > before concluding that 1-netdev is the only solution. Generally a 1-netdev
> > > > > scheme would take time to implement, while I'm trying to find a way out to
> > > > > fix this particular naming problem under 3-netdev.
> > > > > 
> > > > > > > > Moreover, you were suggesting hiding the lower slave devices anyway. There was some discussion
> > > > > > > > about moving them to a hidden network namespace so that they are not visible from the default namespace.
> > > > > > > > I looked into this sometime back, but did not find the right kernel api to create a network namespace within
> > > > > > > > kernel. If so, we could use this mechanism to simulate a 1-netdev model.
> > > > > > > Yes, that's one possible implementation (IMHO the key is to make 1-netdev
> > > > > > > model as much transparent to a real NIC as possible, while a hidden netns is
> > > > > > > just the vehicle). However, I recall there was resistance around this
> > > > > > > discussion that even the concept of hiding itself is a taboo for Linux
> > > > > > > netdev. I would like to summon potential alternatives before concluding
> > > > > > > 1-netdev is the only solution too soon.
> > > > > > > 
> > > > > > > Thanks,
> > > > > > > -Siwei
> > > > > > Your scripts would not work at all then, right?
> > > > > At this point we don't claim images with such usage as SR-IOV live
> > > > > migrate-able. We would flag it as live migrate-able until this ethtool
> > > > > config issue is fully addressed and a transparent live migration solution
> > > > > emerges in upstream eventually.
> > > > > 
> > > > > 
> > > > > Thanks,
> > > > > -Siwei
> > > > > > > > > -Siwei
> > > > > > > > > 
> > > > > > > > > 
> > > > > > ---------------------------------------------------------------------
> > > > > > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > > > > > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > > > > > 
> > > > >     net_failover(kernel)                            |    network.service (user)    |          systemd-udevd (user)
> > > > > --------------------------------------------------+------------------------------+--------------------------------------------
> > > > > (standby virtio-net and net_failover              |                              |
> > > > > devices created and initialized,                  |                              |
> > > > > i.e. virtnet_probe()->                            |                              |
> > > > >          net_failover_create()                      |                              |
> > > > > was done.)                                        |                              |
> > > > >                                                     |                              |
> > > > >                                                     |  runs `ifup ens3' ->         |
> > > > >                                                     |    ip link set dev ens3 up   |
> > > > > net_failover_open()                               |                              |
> > > > >     dev_open(virtnet_dev)                           |                              |
> > > > >       virtnet_open(virtnet_dev)                     |                              |
> > > > >     netif_carrier_on(failover_dev)                  |                              |
> > > > >     ...                                             |                              |
> > > > >                                                     |                              |
> > > > > (VF hot plugged in)                               |                              |
> > > > > ixgbevf_probe()                                   |                              |
> > > > >    register_netdev(ixgbevf_netdev)                  |                              |
> > > > >     netdev_register_kobject(ixgbevf_netdev)         |                              |
> > > > >      kobject_add(ixgbevf_dev)                       |                              |
> > > > >       device_add(ixgbevf_dev)                       |                              |
> > > > >        kobject_uevent(&ixgbevf_dev->kobj, KOBJ_ADD) |                              |
> > > > >         netlink_broadcast()                         |                              |
> > > > >     ...                                             |                              |
> > > > >     call_netdevice_notifiers(NETDEV_REGISTER)       |                              |
> > > > >      failover_event(..., NETDEV_REGISTER, ...)      |                              |
> > > > >       failover_slave_register(ixgbevf_netdev)       |                              |
> > > > >        net_failover_slave_register(ixgbevf_netdev)  |                              |
> > > > >         dev_open(ixgbevf_netdev)                    |                              |
> > > > >                                                     |                              |
> > > > >                                                     |                              |
> > > > >                                                     |                              |   received ADD uevent from netlink fd
> > > > >                                                     |                              |   ...
> > > > >                                                     |                              |   udev-builtin-net_id.c:dev_pci_slot()
> > > > >                                                     |                              |   (decided to renamed 'eth0' )
> > > > >                                                     |                              |     ip link set dev eth0 name ens4
> > > > > (dev_change_name() returns -EBUSY as              |                              |
> > > > > ixgbevf_netdev->flags has IFF_UP)                 |                              |
> > > > >                                                     |                              |
> > > > > 
> > > > Given renaming slaves does not work anyway:
> > > I was actually thinking what if we relieve the rename restriction just for
> > > the failover slave? What the impact would be? I think users don't care about
> > > slave being renamed when it's in use, especially the initial rename.
> > > Thoughts?
> > > 
> > > >    would it work if we just
> > > > hard-coded slave names instead?
> > > > 
> > > > E.g.
> > > > 1. fail slave renames
> > > > 2. rename of failover to XX automatically renames standby to XXnsby
> > > >      and primary to XXnpry
> > > That wouldn't help. The time when the failover master gets renamed, the VF
> > > may not be present.
> > In this scheme if VF is not there it will be renamed immediately after registration.
> Who will be responsible to rename the slave, the kernel?

That's the idea.

> Note the master's
> name may or may not come from the userspace. If it comes from the userspace,
> should the userspace daemon change their expectation not to name/rename
> _any_ slaves (today there's no distinction)?

Yes the idea would be to fail renaming slaves.

> How do users know which name to
> trust, depending on which wins the race more often? Say if kernel wants a
> ens3npry name while userspace wants it named as ens4.
> 
> -Siwei

With this approach kernel will deny attempts by userspace to rename
slaves.  Slaves will always be named XXXnsby and XXnpry. Master renames
will rename both slaves.

It seems pretty solid to me, the only issue is that in theory userspace
can use a name like XXXnsby for something else. But this seems unlikely.


> > 
> > > I don't like the idea to delay exposing failover master
> > > until VF is hot plugged in (probably subject to various failures) later.
> > > 
> > > Thanks,
> > > -Siwei
> > 
> > I agree, this was not what I meant.
> > 
> > > > 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

