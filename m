Return-Path: virtio-dev-return-6301-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3FEBD985F34
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 Nov 2019 07:22:30 +0000 (UTC)
Date: Fri, 8 Nov 2019 08:22:10 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191108072210.ywyneaoc2y4slth6@sirius.home.kraxel.org>
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <20191106084344.GB189998@stefanha-x1.localdomain>
 <20191106095122.jju7eo57scfoat6a@sirius.home.kraxel.org>
 <CAJSP0QUJBkqtVJq17tfX5O-JuvEGcZQviP0C3tv9qSDy-P-hcg@mail.gmail.com>
 <20191106125023.uhdhtqisybilxasr@sirius.home.kraxel.org>
 <CAJSP0QXG5Z3zCnPL+Y7EQfCeey2Fb9OdPdx531Jz2Ofk63wndg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJSP0QXG5Z3zCnPL+Y7EQfCeey2Fb9OdPdx531Jz2Ofk63wndg@mail.gmail.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [virtio-dev] Re: guest / host buffer sharing ...
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: geoff@hostfission.com, virtio-dev@lists.oasis-open.org, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Alexandre Courbot <acourbot@chromium.org>, qemu-devel <qemu-devel@nongnu.org>, Tomasz Figa <tfiga@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>, David Stevens <stevensd@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Dylan Reid <dgreid@chromium.org>, Gurchetan Singh <gurchetansingh@chromium.org>, Dmitry Morozov <dmitry.morozov@opensynergy.com>, Pawel Osciak <posciak@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> > Adding a list of common properties to the spec certainly makes sense,
> > so everybody uses the same names.  Adding struct-ed properties for
> > common use cases might be useful too.
>=20
> Why not define VIRTIO devices for wayland and friends?

There is an out-of-tree implementation of that, so yes, that surely is
an option.

Wayland needs (a) shared buffers, mostly for gfx data, and (b) a stream
pipe as control channel.  Pretty much the same for X11, except that
shared buffers are optional because the X protocol can also squeeze all
display updates through the stream pipe.

So, if you want allow guests talk to the host display server you can run
the stream pipe over vsock.  But there is nothing for the shared
buffers ...

We could replicate vsock functionality elsewhere.  I think that happened
in the out-of-tree virtio-wayland implementation.  There also was some
discussion about adding streams to virtio-gpu, slightly pimped up so you
can easily pass around virtio-gpu resource references for buffer
sharing.  But given that getting vsock right isn't exactly trivial
(consider all the fairness issues when multiplexing multiple streams
over a virtqueue for example) I don't think this is a good plan.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

