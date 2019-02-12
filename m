Return-Path: virtio-dev-return-5399-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8FD82985B32
	for <virtio-dev@lists.oasis-open.org>; Tue, 12 Feb 2019 13:16:49 +0000 (UTC)
Date: Tue, 12 Feb 2019 13:16:39 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190212131638.GF2715@work-vm>
References: <CAOGAQepUKjQuqJ9o4_bTwCjT-dJO9=eMBevvrULUW3KgieoXHg@mail.gmail.com>
 <20190204054053.GE29758@stefanha-x1.localdomain>
 <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
 <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com>
 <20190211092943-mutt-send-email-mst@kernel.org>
 <CAEkmjvVzmfUmu3DDXSSPqTBqXNMyp65sy28xhSiigRGftGiyXw@mail.gmail.com>
 <CAEkmjvVXMZFBopDX8U67bBsr+XVv2LPCjKwzPaqTktYF_KR5LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEkmjvVXMZFBopDX8U67bBsr+XVv2LPCjKwzPaqTktYF_KR5LA@mail.gmail.com>
Subject: Re: [virtio-dev] Memory sharing device
To: Frank Yang <lfy@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Roman Kiryanov <rkir@google.com>, Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

* Frank Yang (lfy@google.com) wrote:
> BTW, I have a few concerns about the upcoming shared-mem virtio type. This
> is mostly directed at David and kraxel.
> 
> We've found that for many applications, simply telling the guest to create
> a new host pointer of Vulkan or OpenGL has quite some overhead in just
> telling the hypervisor to map it, and in fact, it's easy to run out of KVM
> slots by doing so. So for Vulkan, we rely on having one large host visible
> region on the host that is a single region of host shared memory. That, is
> then sub-allocated for the guest. So there is no Vulkan host pointer that
> is being shared to the guest 1:1; we suballocate, then generate the right
> 'underlying' Vulkan device memory offset and size parameters for the host.

That's the same for our DAX in virtio-fs; we just allocate a big 'arena'
and then map stuff within that arena; it's the arena that's described as
one of the shared regions in the spec that I presented.  All the
requests to map/unmap in that arena then happen as commands over the
virtqueue.

> In general though, this means that the ideal usage of host pointers would
> be to set a few regions up front for certain purposes, then share that out
> amongst other device contexts. This also facilitates sharing the memory
> between guest processes, which is useful for implementing things like
> compositors. This also features heavily for our "virtio userspace" thing.

Yes, that makes sense.

> Since this is a common pattern, should this sharing concept be standardized
> somehow? I.e., should there be a standard way to send Shmid/offset/size to
> other devices, or have that be a standard struct in the hypervisor?

That I don't know how to do - because then you need a way to
associate different devices.

Dave

> On Mon, Feb 11, 2019 at 7:14 AM Frank Yang <lfy@google.com> wrote:
> 
> >
> >
> > On Mon, Feb 11, 2019 at 6:49 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> >> On Mon, Feb 04, 2019 at 11:42:25PM -0800, Roman Kiryanov wrote:
> >> > Hi Gerd,
> >> >
> >> > > virtio-gpu specifically needs that to support vulkan and opengl
> >> > > extensions for coherent buffers, which must be allocated by the host
> >> gpu
> >> > > driver.  It's WIP still.
> >> >
> >> > the proposed spec says:
> >> >
> >> > +Shared memory regions MUST NOT be used to control the operation
> >> > +of the device, nor to stream data; those should still be performed
> >> > +using virtqueues.
> >> >
> >> > Is there a strong reason to prohibit using memory regions for control
> >> purposes?
> >>
> >> That's in order to make virtio have portability implications, such that if
> >> people see a virtio device in lspci they know there's
> >> no lock-in, their guest can be moved between hypervisors
> >> and will still work.
> >>
> >> > Our long term goal is to have as few kernel drivers as possible and to
> >> move
> >> > "drivers" into userspace. If we go with the virtqueues, is there
> >> > general a purpose
> >> > device/driver to talk between our host and guest to support custom
> >> hardware
> >> > (with own blobs)?
> >>
> >> The challenge is to answer the following question:
> >> how to do this without losing the benefits of standartization?
> >>
> >> Draft spec is incoming, but the basic idea is to standardize how to
> > enumerate, discover, and operate (with high performance) such userspace
> > drivers/devices; the basic operations would be standardized, and userspace
> > drivers would be constructed out of the resulting primitives.
> >
> > > Could you please advise if we can use something else to
> >> > achieve this goal?
> >>
> >> I am not sure what the goal is though. Blobs is a means I guess
> >> or it should be :) E.g. is it about being able to iterate quickly?
> >>
> >> Maybe you should look at vhost-user-gpu patches on qemu?
> >> Would this address your need?
> >> Acks for these patches would be a good thing.
> >>
> >>
> > Is this it:
> >
> > https://patchwork.kernel.org/patch/10444089/ ?
> >
> > I'll check it out and try to discuss. Is there a draft spec for it as well?
> >
> >
> >>
> >> --
> >> MST
> >>
> >
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

