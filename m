Return-Path: virtio-dev-return-5379-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0FF59985E70
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 Feb 2019 12:11:08 +0000 (UTC)
Date: Thu, 7 Feb 2019 13:10:17 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190207131017.2f54d830.cohuck@redhat.com>
In-Reply-To: <CAEkmjvWA=kVjL-9BX=c+jBFmoUfJB7KjLgYNdKmG1dEC2wb2Qg@mail.gmail.com>
References: <CAOGAQepUKjQuqJ9o4_bTwCjT-dJO9=eMBevvrULUW3KgieoXHg@mail.gmail.com>
	<20190204054053.GE29758@stefanha-x1.localdomain>
	<20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
	<CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com>
	<20190205100427.GA2693@work-vm>
	<CAOGAQeq-djsO=goRsHHz22Zrker8iDqucD30-cEXPt8pVQe1Hg@mail.gmail.com>
	<20190206201406.GG2670@work-vm>
	<CAEkmjvWA=kVjL-9BX=c+jBFmoUfJB7KjLgYNdKmG1dEC2wb2Qg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio-dev] Memory sharing device
To: Frank Yang <lfy@google.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Roman Kiryanov <rkir@google.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

[Jumping into the discussion here; I have read through the discussion
so far, but I might have misunderstood things, as I'm not really
familiar with Vulkan et al.]

On Wed, 6 Feb 2019 12:27:48 -0800
Frank Yang <lfy@google.com> wrote:

> On Wed, Feb 6, 2019 at 12:14 PM Dr. David Alan Gilbert <dgilbert@redhat.com>
> wrote:
> 
> > * Roman Kiryanov (rkir@google.com) wrote:  
> > > Hi Dave,
> > >  
> > > > In virtio-fs we have two separate stages:
> > > >   a) A shared arena is setup (and that's what the spec Stefan pointed  
> > to is about) -  
> > > >      it's statically allocated at device creation and corresponds to a  
> > chunk  
> > > >      of guest physical address space  
> > >
> > > We do exactly the same:
> > >  
> > https://android.googlesource.com/platform/external/qemu/+/emu-master-dev/hw/pci/goldfish_address_space.c#659  
> > >  
> > > >   b) During operation the guest kernel asks for files to be mapped into
> > > >      part of that arena dynamically, using commands sent over the queue
> > > >      - our queue carries FUSE commands, and we've added two new FUSE
> > > >      commands to perform the map/unmap.  They talk in terms of offsets
> > > >      within the shared arena, rather than GPAs.  
> > >
> > > In our case we have no files to map, only pointers returned from
> > > OpenGL or Vulkan.
> > > Do you have the approach to share for this use case?  
> >
> > I should say that the spec I'm talking aobut is my 1st virito spec
> > change; so take my ideas with a large pinch of salt!
> >  
> > > > How do you transmit the glMapBufferRange command from QEMU driver to
> > > > host?  
> > >
> > > In December we did this by passing these bits over our guest-host channel
> > > (another driver, goldfish_pipe). Frank is currently working on moving
> > > this into our memory
> > > mapping device as "something changed in the memory you shared".
> > >
> > > Do you this it is possible to have virtio-pipe where we could send
> > > arbitrary blobs between
> > > guest and host? We want to move all our drivers into userspace so we
> > > could share memory
> > > using the device you are currently working on and this virtio-pipe to
> > > pass MMIOs and IRQs
> > > to control our devices to avoid dealing with kernel drivers at all.  
> >
> > It sounds to me like you want something like a virtio-pipe, with
> > a shared arena (like specified using the spec change I suggested)
> > but with either a separate queue, or commands in the queue to do the
> > mapping/unmapping of your GL pointers from your arena.
> >  
> 
> This sounds close to what we want, but the current suggestions to use
> virtio-serial/virtio-vsock are difficult to deal with as they add on the
> req of console forwarding/hard limits on the number of queues, or coupling
> to unix sockets on the host.

If existing devices don't work for your use case, adding a new type is
completely fine; however, I'm worried that it might end up too generic.
A lose specification might not have enough information to write either
a device or a driver that interacts with an existing driver or device;
if it relies on both device and driver being controlled by the same
instance, it's not a good fit for the virtio spec IMHO.

> 
> What about this:
> 
> A new spec, called "virtio-pipe". It only sends control messages. It's
> meant to work in tandem with the current virtio host memory proposal. It's
> not specialized to anything; it doesn't use sockets on the host either,
> instead, it uses dlopen/dlsym on the host to load a library implementing
> the wanted userspace devices, together with a minimal ioctl in the guest to
> capture everything:
> 
> There is one ioctl:
> 
> ioctl_ping:
> u64 offset (to the virtio host memory object)
> u64 size
> u64 metadata (driver-dependent data)
> u32 wait (whether the guest is waiting for the host to be done with
> something)
> 
> These are sent over virtqueue.

One thing you need to keep in mind is that the virtio spec does not
specify anything like ioctls; what the individual device and driver
implementations do is up to the specific environment they're run in.
IOW, if you want your user space driver to be able to submit and
receive some information, you must make sure that everything it needs
is transmitted via virtqueues and shared regions; how it actually
accessed it is up to the implementation.

If you frame your ioctl structure as "this is the format of the buffers
that are transmitted via the virtqueue", it seems like something that
we can build upon.

> 
> On the host, these pings arrive and call some dlsym'ed functions:
> 
> u32 on_context_create - when guest userspace open()'s the virtio-pipe, this
> returns a new id.
> on_context_destroy(u32 id) - on last close of the pipe
> on_ioctl_ping(u32 id, u64 physaddr, u64 size, u64 metadata, u32 wait) -
> called when the guest ioctl ping's.

Same here: If the information transmitted in the virtqueue buffers is
sufficient, the host side can implement whatever it needs.

> 
> There would need to be some kind of IRQ-like mechanism (either done with
> actual virtual irqs, or polling, or a mprotect/mwait-like mechanism) that
> tells the guest the host is done with something.

If you frame the virtqueue buffers nicely, the generic virtqueue
notifications should probably be sufficient, I guess.

> 
> This would be the absolute minimum and most general way to send anything
> to/from the host with explicit control messages; any device can be defined
> on top of this with no changes to virtio or qemu.

Ok, this brings me back to my "too generic" concern.

If you do everything in user space on the host and guest sides and the
virtio device is basically only a dumb pipe, correct functioning
depends entirely on correct implementations in the user space
components. What you're throwing away are some nice features of virtio
like feature bit negotiation. If, for some reason, the user space
implementations on guest and host side run out of sync, or you
accidentally pair up two incompatible types, virtio will continue to
cheerfully shuffle around data until it goes boom.

I'm not sure about all of the future use cases for this, but I'd advise
to specify some way for:
- the driver to find out what kind of blobs the device supports (can
  maybe be done via feature bits)
- some kind of versioning, so you can extend the control messages
  should they turn out to be missing something

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

