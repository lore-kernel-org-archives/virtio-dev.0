Return-Path: virtio-dev-return-5466-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9F95C985D01
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Feb 2019 06:52:00 +0000 (UTC)
Date: Wed, 20 Feb 2019 07:51:52 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190220065152.44xv26wjtopkdnu2@sirius.home.kraxel.org>
References: <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
 <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com>
 <20190211092943-mutt-send-email-mst@kernel.org>
 <CAEkmjvVzmfUmu3DDXSSPqTBqXNMyp65sy28xhSiigRGftGiyXw@mail.gmail.com>
 <CAEkmjvVXMZFBopDX8U67bBsr+XVv2LPCjKwzPaqTktYF_KR5LA@mail.gmail.com>
 <20190212131638.GF2715@work-vm>
 <20190212082555-mutt-send-email-mst@kernel.org>
 <CAEkmjvX=qMWNr2v-fELh5VFRhfFHcjQpmYPUMSTT6QNFfmLqbQ@mail.gmail.com>
 <20190219071756.f5qayejwls66jjhb@sirius.home.kraxel.org>
 <CAEkmjvXpAc1KZpYvfQa8jPzrh0MxpHNGPZ1LAH=5nQyRNCaTUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEkmjvXpAc1KZpYvfQa8jPzrh0MxpHNGPZ1LAH=5nQyRNCaTUw@mail.gmail.com>
Subject: Re: [virtio-dev] Memory sharing device
To: Frank Yang <lfy@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Roman Kiryanov <rkir@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> However, dma-buf seems to require either a Linux kernel or a Linux host.

Sure.  They allow passing buffers from one linux driver to another
without copying the data.

> Dma-bufs aren't also 1:1 with Vulkan host visible memory pointers,
> or v4l2 codec buffers, or ffmpeg codec buffers, etc.

Some v4l2 drivers have dma-buf support, so you can pass buffers from
v4l2 to (for example) gpu drivers that way.

> The proposed device would be able to expose memory for direct access in a
> way that
> does not couple to dma-buf which is highly desirable for our use case.
> Using the ping/event messages, even win32 handles and general opaque fds
> can be passed from host to guest and back.
> 
> You can think of the proposed device as a 'virtio-dmabuf' that
> tries to expose shareable memory in a way that disregards implementation
> details of
> guest and host kernels.

That would probably look alot like virtio-gpu with only the resource
handling.  virtio-gpu fundamentally are just buffers.

Also virtio-dmabuf would be a pretty bad name.  dma-bufs are not a
virtio concept, they are a linux concept.  They can be used by linux
guests, to pass buffers from/to virtio-gpu (note: I'm still busy adding
driver support for that).  They can be used by linux hosts, to pass
buffers (with udmabuf help) from qemu to other processes/devices
(details are still to be hashed out).

Non-linux systems obviously need something else for the job.  The
guest/host implementation details don't affect the virtio-gpu specs
though.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

