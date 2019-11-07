Return-Path: virtio-dev-return-6297-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8FECC985EFA
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 Nov 2019 11:16:34 +0000 (UTC)
Date: Thu, 7 Nov 2019 11:16:18 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20191107111618.GE2816@work-vm>
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <20191106084344.GB189998@stefanha-x1.localdomain>
 <20191106095122.jju7eo57scfoat6a@sirius.home.kraxel.org>
 <20191106101057.GC2802@work-vm>
 <20191107111119.qgr2qxgdf64jurin@sirius.home.kraxel.org>
MIME-Version: 1.0
In-Reply-To: <20191107111119.qgr2qxgdf64jurin@sirius.home.kraxel.org>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: guest / host buffer sharing ...
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, geoff@hostfission.com, virtio-dev@lists.oasis-open.org, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Alexandre Courbot <acourbot@chromium.org>, qemu-devel@nongnu.org, Tomasz Figa <tfiga@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>, David Stevens <stevensd@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, Dylan Reid <dgreid@chromium.org>, Gurchetan Singh <gurchetansingh@chromium.org>, Dmitry Morozov <dmitry.morozov@opensynergy.com>, Pawel Osciak <posciak@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

* Gerd Hoffmann (kraxel@redhat.com) wrote:
>   Hi,
>=20
> > > This is not about host memory, buffers are in guest ram, everything e=
lse
> > > would make sharing those buffers between drivers inside the guest (as
> > > dma-buf) quite difficult.
> >=20
> > Given it's just guest memory, can the guest just have a virt queue on
> > which it places pointers to the memory it wants to share as elements in
> > the queue?
>=20
> Well, good question.  I'm actually wondering what the best approach is
> to handle long-living, large buffers in virtio ...
>=20
> virtio-blk (and others) are using the approach you describe.  They put a
> pointer to the io request header, followed by pointer(s) to the io
> buffers directly into the virtqueue.  That works great with storage for
> example.  The queue entries are tagged being "in" or "out" (driver to
> device or visa-versa), so the virtio transport can set up dma mappings
> accordingly or even transparently copy data if needed.
>=20
> For long-living buffers where data can potentially flow both ways this
> model doesn't fit very well though.  So what virtio-gpu does instead is
> transferring the scatter list as virtio payload.  Does feel a bit
> unclean as it doesn't really fit the virtio architecture.  It assumes
> the host can directly access guest memory for example (which is usually
> the case but explicitly not required by virtio).  It also requires
> quirks in virtio-gpu to handle VIRTIO_F_IOMMU_PLATFORM properly, which
> in theory should be handled fully transparently by the virtio-pci
> transport.
>=20
> We could instead have a "create-buffer" command which adds the buffer
> pointers as elements to the virtqueue as you describe.  Then simply
> continue using the buffer even after completing the "create-buffer"
> command.  Which isn't exactly clean either.  It would likewise assume
> direct access to guest memory, and it would likewise need quirks for
> VIRTIO_F_IOMMU_PLATFORM as the virtio-pci transport tears down the dma
> mappings for the virtqueue entries after command completion.
>=20
> Comments, suggestions, ideas?

What about not completing the command while the device is using the
memory?

Dave

> cheers,
>   Gerd
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

