Return-Path: virtio-dev-return-4856-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EA53F985CF1
	for <virtio-dev@lists.oasis-open.org>; Tue, 18 Sep 2018 13:35:51 +0000 (UTC)
Date: Tue, 18 Sep 2018 09:35:48 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180918093310-mutt-send-email-mst@kernel.org>
References: <1534358955-35869-1-git-send-email-sridhar.samudrala@intel.com>
 <20180907173251-mutt-send-email-mst@kernel.org>
 <9bc2db49-77ea-1391-b964-a29da44ff617@intel.com>
 <20180912111819-mutt-send-email-mst@kernel.org>
 <20180918122052.349ba42e.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180918122052.349ba42e.cohuck@redhat.com>
Subject: Re: [virtio-dev] [PATCH v4] content: Introduce VIRTIO_NET_F_STANDBY
 feature
To: Cornelia Huck <cohuck@redhat.com>
Cc: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Sep 18, 2018 at 12:20:52PM +0200, Cornelia Huck wrote:
> On Wed, 12 Sep 2018 11:22:12 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Wed, Sep 12, 2018 at 08:17:45AM -0700, Samudrala, Sridhar wrote:
> > > 
> > > 
> > > On 9/7/2018 2:34 PM, Michael S. Tsirkin wrote:  
> > > > On Wed, Aug 15, 2018 at 11:49:15AM -0700, Sridhar Samudrala wrote:  
> > > > > VIRTIO_NET_F_STANDBY feature enables hypervisor to indicate virtio_net
> > > > > device to act as a standby for another device with the same MAC address.
> > > > > 
> > > > > Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> > > > > Acked-by: Cornelia Huck <cohuck@redhat.com>
> > > > > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/18  
> > > > Applied but when do you plan to add documentation as pointed
> > > > out by Jan and Halil?  
> > > 
> > > I thought additional documentation will be done as part of the Qemu enablement
> > > patches and i hope someone in RH is looking into it.
> > > 
> > > Does it make sense to add a link to to the kernel documentation of this feature in
> > > the spec
> > >  https://www.kernel.org/doc/html/latest/networking/net_failover.html  
> > 
> > 
> > I do not think this will address the comments posted.  Specifically we
> > should probably include documentation for what is a standby and primary:
> > what is expected of driver (maintain configuration on standby, support
> > primary coming and going, transmit on standby only if there is no
> > primary) and of device (have same mac for standby as for standby).
> 
> Yes, we need some definitive statements of what a driver and a device
> is supposed to do in order to conform; it might make sense to discuss
> this in conjunction with discussion on any QEMU patches (have not
> checked whether anything has been posted, just returned from vacation).
> 
> I assume that we still stick with the plan to implement/document
> MAC-based handling first and then enhance with other methods later?

I'm fine with that at least. If someone wants to work on
other methods straight away, that's also fine by me.

-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

