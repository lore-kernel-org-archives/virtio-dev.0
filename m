Return-Path: <pasic@linux.ibm.com>
Date: Wed, 10 Aug 2022 19:59:59 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [virtio-dev] Re: [PATCH 1/4] content: Introduce driver/device
 auxiliary notifications
Message-ID: <20220810195959.47fa9d3b.pasic@linux.ibm.com>
In-Reply-To: <20220810084320-mutt-send-email-mst@kernel.org>
References: <20220330152105.3770439-1-usama.arif@bytedance.com>
	<20220330152105.3770439-2-usama.arif@bytedance.com>
	<20220809160711-mutt-send-email-mst@kernel.org>
	<87r11octk4.fsf@redhat.com>
	<20220810084320-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Usama Arif <usama.arif@bytedance.com>, virtio-dev@lists.oasis-open.org, stefanha@redhat.com, ndragazis@arrikto.com, fam.zheng@bytedance.com, liangma@liangbit.com, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 10 Aug 2022 08:45:25 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Aug 10, 2022 at 11:54:35AM +0200, Cornelia Huck wrote:
> > On Tue, Aug 09 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >   
> > > On Wed, Mar 30, 2022 at 04:21:02PM +0100, Usama Arif wrote:  
> > >> Driver auxiliary notifications allow the device to send notifications
> > >> other than configuration changes and used buffer notifications to the
> > >> driver, these are optional and their meaning is device-specific.
> > >> 
> > >> Device auxiliary notifcations allow the driver to send notifcations
> > >> other than available buffer notifications to the device for example
> > >> through a device register, these are optional and their meaning is
> > >> device-specific.
> > >> 
> > >> These device-specific notifications are needed later when adding support
> > >> for virtio-vhost-user device.
> > >> 
> > >> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> > >> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > >> Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>  
> > >
> > > I see ccw is missing. Cornelia, any suggestions?  
> > 
> > Hmm... I seem to be really behind on ccw things :(
> > 
> > We can probably use the following:
> > 
> > - for device->driver notification, use the next bit in the secondary
> >   indicators (bit 0 is used for config change notification)
> > - for driver->device notification, maybe use a new subcode for diagnose
> >   0x500 (4 is probably the next free one?)
> > 
> > I have not looked at the requirements deeply, though.
> > 
> > This highlights another problem, however: When we introduce new features
> > that require a transport-specific implementation, we often end up with a
> > PCI implementation, but sometimes MMIO and more often ccw are left
> > behind -- which is understandable, as PCI is what most people use, and
> > ccw is something only a very few people are familiar with. This sadly
> > means that we have a backlog of features supported in PCI, but not in
> > ccw... requiring implementations for ccw would put an undue burden on
> > contributors, as most of them are unlikely to write anything for a
> > mainframe, ever. On the flip side, I do not have enough bandwith to deal
> > with all of this.
> > 
> > Halil, any thoughts (on any of the above)?  
> 
> Kind of depends. We Do we want to add a "universal config"
> structure shared between transports?
> Will help with some use-cases though not this one.

I'm for "unversal config"! Regarding this use case I have to dig a
little deeper to really understand!

Regards,
Halil 

