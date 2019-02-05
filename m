Return-Path: virtio-dev-return-5370-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4BB1D985BAF
	for <virtio-dev@lists.oasis-open.org>; Tue,  5 Feb 2019 10:04:39 +0000 (UTC)
Date: Tue, 5 Feb 2019 10:04:27 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190205100427.GA2693@work-vm>
References: <CAOGAQepUKjQuqJ9o4_bTwCjT-dJO9=eMBevvrULUW3KgieoXHg@mail.gmail.com>
 <20190204054053.GE29758@stefanha-x1.localdomain>
 <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
 <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com>
Subject: Re: [virtio-dev] Memory sharing device
To: Roman Kiryanov <rkir@google.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, Lingfeng Yang <lfy@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

* Roman Kiryanov (rkir@google.com) wrote:
> Hi Gerd,
> 
> > virtio-gpu specifically needs that to support vulkan and opengl
> > extensions for coherent buffers, which must be allocated by the host gpu
> > driver.  It's WIP still.
> 

Hi Roman,

> the proposed spec says:
> 
> +Shared memory regions MUST NOT be used to control the operation
> +of the device, nor to stream data; those should still be performed
> +using virtqueues.

Yes, I put that in.

> Is there a strong reason to prohibit using memory regions for control purposes?
> Our long term goal is to have as few kernel drivers as possible and to move
> "drivers" into userspace. If we go with the virtqueues, is there
> general a purpose
> device/driver to talk between our host and guest to support custom hardware
> (with own blobs)? Could you please advise if we can use something else to
> achieve this goal?

My reason for that paragraph was to try and think about what should
still be in the virtqueues; after all a device that *just* shares a
block of memory and does everything in the block of memory itself isn't
really a virtio device - it's the standardised queue structure that
makes it a virtio device.
However, I'd be happy to accept the 'MUST NOT' might be a bit strong for
some cases where there's stuff that makes sense in the queues and
stuff that makes sense differently.

> I saw there were registers added, could you please elaborate how new address
> regions are added and associated with the host memory (and backwards)?

In virtio-fs we have two separate stages:
  a) A shared arena is setup (and that's what the spec Stefan pointed to is about) -
     it's statically allocated at device creation and corresponds to a chunk
     of guest physical address space

  b) During operation the guest kernel asks for files to be mapped into
     part of that arena dynamically, using commands sent over the queue
     - our queue carries FUSE commands, and we've added two new FUSE
     commands to perform the map/unmap.  They talk in terms of offsets
     within the shared arena, rather than GPAs.

So I'd tried to start by doing the spec for (a).

> We allocate a region from the guest first and pass its offset to the
> host to plug
> real RAM into it and then we mmap this offset:
> 
> https://photos.app.goo.gl/NJvPBvvFS3S3n9mn6

How do you transmit the glMapBufferRange command from QEMU driver to
host?

Dave

> Thank you.
> 
> Regards,
> Roman.
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

