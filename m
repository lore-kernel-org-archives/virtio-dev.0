Return-Path: virtio-dev-return-5374-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2CCE0985C31
	for <virtio-dev@lists.oasis-open.org>; Wed,  6 Feb 2019 07:03:59 +0000 (UTC)
Date: Wed, 6 Feb 2019 08:03:50 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190206070350.vaonutyqljccuh5y@sirius.home.kraxel.org>
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, Lingfeng Yang <lfy@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 05, 2019 at 01:06:42PM -0800, Roman Kiryanov wrote:
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

Fundamentally the same:  The memory region (PCI bar in case of
virtio-pci) reserves address space.  The guest manages the address
space, it can ask the host to map host gpu resources there.

Well, that is at least the plan.  Some incomplete WIP patches exist, I'm
still busy hammering virtio-gpu ttm code into shape so it can support
different kinds of gpu objects.

> Do you this it is possible to have virtio-pipe where we could send
> arbitrary blobs between
> guest and host?

Well, there are virtio-serial and virtio-vsock which both give you a
pipe between host and guest, simliar to a serial line / tcp socket.
Dunno how good they are at handling larger blobs though.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

