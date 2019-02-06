Return-Path: virtio-dev-return-5377-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BD277985DB0
	for <virtio-dev@lists.oasis-open.org>; Wed,  6 Feb 2019 20:14:42 +0000 (UTC)
Date: Wed, 6 Feb 2019 20:14:07 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190206201406.GG2670@work-vm>
References: <CAOGAQepUKjQuqJ9o4_bTwCjT-dJO9=eMBevvrULUW3KgieoXHg@mail.gmail.com>
 <20190204054053.GE29758@stefanha-x1.localdomain>
 <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
 <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com>
 <20190205100427.GA2693@work-vm>
 <CAOGAQeq-djsO=goRsHHz22Zrker8iDqucD30-cEXPt8pVQe1Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOGAQeq-djsO=goRsHHz22Zrker8iDqucD30-cEXPt8pVQe1Hg@mail.gmail.com>
Subject: Re: [virtio-dev] Memory sharing device
To: Roman Kiryanov <rkir@google.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, Lingfeng Yang <lfy@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

* Roman Kiryanov (rkir@google.com) wrote:
> Hi Dave,
> 
> > In virtio-fs we have two separate stages:
> >   a) A shared arena is setup (and that's what the spec Stefan pointed to is about) -
> >      it's statically allocated at device creation and corresponds to a chunk
> >      of guest physical address space
> 
> We do exactly the same:
> https://android.googlesource.com/platform/external/qemu/+/emu-master-dev/hw/pci/goldfish_address_space.c#659
> 
> >   b) During operation the guest kernel asks for files to be mapped into
> >      part of that arena dynamically, using commands sent over the queue
> >      - our queue carries FUSE commands, and we've added two new FUSE
> >      commands to perform the map/unmap.  They talk in terms of offsets
> >      within the shared arena, rather than GPAs.
> 
> In our case we have no files to map, only pointers returned from
> OpenGL or Vulkan.
> Do you have the approach to share for this use case?

I should say that the spec I'm talking aobut is my 1st virito spec
change; so take my ideas with a large pinch of salt!

> > How do you transmit the glMapBufferRange command from QEMU driver to
> > host?
> 
> In December we did this by passing these bits over our guest-host channel
> (another driver, goldfish_pipe). Frank is currently working on moving
> this into our memory
> mapping device as "something changed in the memory you shared".
> 
> Do you this it is possible to have virtio-pipe where we could send
> arbitrary blobs between
> guest and host? We want to move all our drivers into userspace so we
> could share memory
> using the device you are currently working on and this virtio-pipe to
> pass MMIOs and IRQs
> to control our devices to avoid dealing with kernel drivers at all.

It sounds to me like you want something like a virtio-pipe, with
a shared arena (like specified using the spec change I suggested)
but with either a separate queue, or commands in the queue to do the
mapping/unmapping of your GL pointers from your arena.

Dave

> Thank you.
> 
> Regards,
> Roman.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

