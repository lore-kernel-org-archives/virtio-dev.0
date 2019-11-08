Return-Path: virtio-dev-return-6300-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8D1C2985F34
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 Nov 2019 06:46:02 +0000 (UTC)
Date: Fri, 8 Nov 2019 07:45:52 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191108064552.hel54p6vvdpir2dp@sirius.home.kraxel.org>
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <20191106084344.GB189998@stefanha-x1.localdomain>
 <20191106095122.jju7eo57scfoat6a@sirius.home.kraxel.org>
 <20191106101057.GC2802@work-vm>
 <20191107111119.qgr2qxgdf64jurin@sirius.home.kraxel.org>
 <20191107111618.GE2816@work-vm>
MIME-Version: 1.0
In-Reply-To: <20191107111618.GE2816@work-vm>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: guest / host buffer sharing ...
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, geoff@hostfission.com, virtio-dev@lists.oasis-open.org, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Alexandre Courbot <acourbot@chromium.org>, qemu-devel@nongnu.org, Tomasz Figa <tfiga@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>, David Stevens <stevensd@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Dylan Reid <dgreid@chromium.org>, Gurchetan Singh <gurchetansingh@chromium.org>, Dmitry Morozov <dmitry.morozov@opensynergy.com>, Pawel Osciak <posciak@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Nov 07, 2019 at 11:16:18AM +0000, Dr. David Alan Gilbert wrote:
> * Gerd Hoffmann (kraxel@redhat.com) wrote:
> >   Hi,
> >=20
> > > > This is not about host memory, buffers are in guest ram, everything=
 else
> > > > would make sharing those buffers between drivers inside the guest (=
as
> > > > dma-buf) quite difficult.
> > >=20
> > > Given it's just guest memory, can the guest just have a virt queue on
> > > which it places pointers to the memory it wants to share as elements =
in
> > > the queue?
> >=20
> > Well, good question.  I'm actually wondering what the best approach is
> > to handle long-living, large buffers in virtio ...
> >=20
> > virtio-blk (and others) are using the approach you describe.  They put =
a
> > pointer to the io request header, followed by pointer(s) to the io
> > buffers directly into the virtqueue.  That works great with storage for
> > example.  The queue entries are tagged being "in" or "out" (driver to
> > device or visa-versa), so the virtio transport can set up dma mappings
> > accordingly or even transparently copy data if needed.
> >=20
> > For long-living buffers where data can potentially flow both ways this
> > model doesn't fit very well though.  So what virtio-gpu does instead is
> > transferring the scatter list as virtio payload.  Does feel a bit
> > unclean as it doesn't really fit the virtio architecture.  It assumes
> > the host can directly access guest memory for example (which is usually
> > the case but explicitly not required by virtio).  It also requires
> > quirks in virtio-gpu to handle VIRTIO_F_IOMMU_PLATFORM properly, which
> > in theory should be handled fully transparently by the virtio-pci
> > transport.
> >=20
> > We could instead have a "create-buffer" command which adds the buffer
> > pointers as elements to the virtqueue as you describe.  Then simply
> > continue using the buffer even after completing the "create-buffer"
> > command.  Which isn't exactly clean either.  It would likewise assume
> > direct access to guest memory, and it would likewise need quirks for
> > VIRTIO_F_IOMMU_PLATFORM as the virtio-pci transport tears down the dma
> > mappings for the virtqueue entries after command completion.
> >=20
> > Comments, suggestions, ideas?
>=20
> What about not completing the command while the device is using the
> memory?

Thought about that too, but I don't think this is a good idea for
buffers which exist for a long time.

Example #1:  A video decoder would setup a bunch of buffers and use
them robin-round, so they would exist until the video playback is
finished.

Example #2:  virtio-gpu creates a framebuffer for fbcon which exists
forever.  And virtio-gpu potentially needs lots of buffers.  With 3d
active there can be tons of objects.  Although they typically don't
stay around that long we would still need a pretty big virtqueue to
store them all I guess.

And it also doesn't fully match the virtio spirit, it still assumes
direct guest memory access.  Without direct guest memory access
updates to the fbcon object would never reach the host for example.
In case a iommu is present we might need additional dma map flushes
for updates happening after submitting the lingering "create-buffer"
command.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

