Return-Path: virtio-return-3036-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Thu, 29 Mar 2018 16:10:30 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180329160753-mutt-send-email-mst@kernel.org>
References: <1522168507-58698-1-git-send-email-mst@redhat.com>
 <94d79449-4d96-82b5-f046-f5bf6c47a7bb@linux.vnet.ibm.com>
 <20180328200739-mutt-send-email-mst@kernel.org>
 <20180329110555.708a88b9.cohuck@redhat.com>
 <20180329154839-mutt-send-email-mst@kernel.org>
 <20180329150455.179fe87c.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180329150455.179fe87c.cohuck@redhat.com>
Subject: Re: [virtio] [PATCH v12] VIRTIO_F_NOTIFICATION_DATA: extra data to
 devices
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Mar 29, 2018 at 03:04:55PM +0200, Cornelia Huck wrote:
> On Thu, 29 Mar 2018 15:52:34 +0300
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Thu, Mar 29, 2018 at 11:05:55AM +0200, Cornelia Huck wrote:
> > > On Wed, 28 Mar 2018 20:21:47 +0300
> > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > >   
> > > > On Wed, Mar 28, 2018 at 06:56:13PM +0200, Halil Pasic wrote:  
> 
> > > > > The notifications *sent by the device to the driver (virtqueue or
> > > > > configuration change)* are often referred to as *interrupts* but occasionally
> > > > > also as notifications (e.g. 'host->guest notification').  
> > > 
> > > I think 'notifications' is a better term for these. I'm thinking of a
> > > driver polling for outstanding notifications from the device, no
> > > interrupts involved.  
> > 
> > In this context when polling there are no notifications - rememeber we are
> > talking about notification suppression.
> 
> OK, that's my s390 background again. We can easily make notification
> status available (setting indicators, making a subchannel status
> pending), but not deliver an interrupt because the guest has not
> enabled interrupts and polls instead. (In fact, such an operation mode
> is not uncommon for the traditional s390 OSs.)
> 
> But we can also just keep this as-is, it's probably not confusing for
> most people anyway.

Oh I see. In theory MSI also has on-device bits to signal events. They
are still called "interrupt pending" there.

It's up to you guys then.

-- 
MST

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

