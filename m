Return-Path: virtio-dev-return-5367-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AAC27985A3D
	for <virtio-dev@lists.oasis-open.org>; Mon,  4 Feb 2019 10:13:21 +0000 (UTC)
Date: Mon, 4 Feb 2019 11:13:16 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
References: <CAOGAQepUKjQuqJ9o4_bTwCjT-dJO9=eMBevvrULUW3KgieoXHg@mail.gmail.com>
 <20190204054053.GE29758@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204054053.GE29758@stefanha-x1.localdomain>
Subject: Re: [virtio-dev] Memory sharing device
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Roman Kiryanov <rkir@google.com>, virtio-dev@lists.oasis-open.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 04, 2019 at 01:40:53PM +0800, Stefan Hajnoczi wrote:
> On Fri, Feb 01, 2019 at 12:34:07PM -0800, Roman Kiryanov wrote:
> > for our purposes we need to access host's memory (e.g. Vulkan buffers,
> > but we also considering other things, like running all drivers in
> > userspace) directly from a linux guest (Android). I implemented a
> > device in QEMU and a linux driver for it:
> > 
> > https://android.googlesource.com/kernel/goldfish/+/android-goldfish-4.14-dev/drivers/misc/goldfish_address_space.c
> > 
> > https://android.googlesource.com/platform/external/qemu/+/emu-master-dev/hw/pci/goldfish_address_space.c
> > 
> > during upstreaming the driver it was suggested that developing a
> > virtio spec could be a better approach than inventing our specific
> > driver and device.
> > 
> > Could you please advise how to start?
> 
> Hi Roman,
> David Gilbert, Gerd Hoffmann, and I have discussed adding shared memory
> resources to VIRTIO.  That means memory made available by the device to
> the driver instead of the usual other way around.
> 
> virtio-gpu needs this and perhaps that use case overlaps with yours too.

virtio-gpu specifically needs that to support vulkan and opengl
extensions for coherent buffers, which must be allocated by the host gpu
driver.  It's WIP still.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

