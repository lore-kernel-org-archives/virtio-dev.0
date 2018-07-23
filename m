Return-Path: virtio-dev-return-4726-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0CD68985C74
	for <virtio-dev@lists.oasis-open.org>; Mon, 23 Jul 2018 09:31:03 +0000 (UTC)
Date: Mon, 23 Jul 2018 11:30:59 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180723113059.17fe64e0.cohuck@redhat.com>
In-Reply-To: <20180723122205-mutt-send-email-mst@kernel.org>
References: <1532035780-38883-1-git-send-email-sridhar.samudrala@intel.com>
	<20180720094450.2f2978f9.cohuck@redhat.com>
	<20180722182834-mutt-send-email-mst@kernel.org>
	<20180723110311.5a36f56a.cohuck@redhat.com>
	<20180723122205-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] [PATCH] content: Introduce VIRTIO_NET_F_STANDBY
 feature
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 23 Jul 2018 12:22:38 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Jul 23, 2018 at 11:03:11AM +0200, Cornelia Huck wrote:
> > On Sun, 22 Jul 2018 18:37:42 +0300
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> > > On Fri, Jul 20, 2018 at 09:44:50AM +0200, Cornelia Huck wrote:  
> > > > On Thu, 19 Jul 2018 14:29:40 -0700
> > > > Sridhar Samudrala <sridhar.samudrala@intel.com> wrote:

> > > > > +
> > > > > +If the driver negotiates VIRTIO_NET_F_STANDBY, it should act as a standby    
> > > > for    
> > > > > +another device with the same MAC address when available. The hypervisor can
> > > > > +hot-plug a primary device with same MAC address if the feature is successfully
> > > > > +negotiated with the driver.    
> > > > 
> > > > I don't think you should add implementation details like hotplugging
> > > > into the spec.
> > > > 
> > > > What about:
> > > > 
> > > > "If the driver negotiates VIRTIO_NET_F_STANDBY, the device MAY act as a
> > > > standby device for another device with the same MAC address, the
> > > > 'failover device'.    
> > > 
> > > I find the name "failover device" confusing. Linux came up with
> > > names primary and standby.  
> > 
> > "...the device MAY act as a standby device for a primary device with
> > the same MAC address."
> > 
> > ?  
> 
> Right. But I agree we need a section that defines failover operation.

The basics for VIRTIO_NET_F_STANDBY are probably the most pressing
right now, we can still fill in the detailed description when we have
figured out whether the suggested approach actually works (it seems
there haven't been any QEMU patches implementing the visibility
handling yet?)

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

