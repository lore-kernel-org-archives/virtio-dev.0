Return-Path: virtio-dev-return-6659-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 22788985F6B
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Jan 2020 11:00:52 +0000 (UTC)
MIME-Version: 1.0
References: <20191218130214.170703-1-keiichiw@chromium.org>
 <7740094.NyiUUSuA9g@os-lin-dmo> <20200113095636.blov62o4gbf27om5@sirius.home.kraxel.org>
 <12433898.dW097sEU6C@os-lin-dmo> <20200113110521.5ogc3fcy4zq32yzg@sirius.home.kraxel.org>
 <CAAFQd5D16G0E85BCZVx1LXd1TauQH8Lbgs5-0gLv7tNpm4sp_A@mail.gmail.com> <20200113132654.r4lhspfx2z7zse2v@sirius.home.kraxel.org>
In-Reply-To: <20200113132654.r4lhspfx2z7zse2v@sirius.home.kraxel.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 15 Jan 2020 20:00:31 +0900
Message-ID: <CAAFQd5A3=4JC+3bRf2iw8RwsoB1jJz8p5afi6KaHO6ML2LC0Rg@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH v2 0/1] VirtIO video device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Dmitry Sepp <dmitry.sepp@opensynergy.com>, spice-devel@lists.freedesktop.org, Keiichi Watanabe <keiichiw@chromium.org>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, David Stevens <stevensd@chromium.org>, uril@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 13, 2020 at 10:27 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > Well, no.  Tomasz Figa had splitted the devices into three groups:
> > >
> > >   (1) requires single buffer.
> > >   (2) allows any layout (including the one (1) devices want).
> > >   (3) requires per-plane buffers.
> > >
> > > Category (3) devices are apparently rare and old.  Both category (1)+=
(2)
> > > devices can handle single buffers just fine.  So maybe support only
> > > that?
> >
> > From the guest implementation point of view, Linux V4L2 currently
> > supports 2 cases, if used in allocation-mode (i.e. the buffers are
> > allocated locally by V4L2):
> >
> > i) single buffer with plane offsets predetermined by the format, (can
> > be handled by devices from category 1) and 2))
> > ii) per-plane buffers with planes at the beginning of their own
> > buffers. (can be handled by devices from category 2) and 3))
> >
> > Support for ii) is required if one wants to be able to import buffers
> > with arbitrary plane offsets, so I'd consider it unavoidable.
>
> If you have (1) hardware you simply can't import buffers with arbitrary
> plane offsets, so I'd expect software would prefer the single buffer
> layout (i) over (ii), even when using another driver + dmabuf
> export/import, to be able to support as much hardware as possible.
> So (ii) might end up being unused in practice.
>
> But maybe not, was just an idea, feel free to scratch it.

That's true, simple user space would often do that. However, if more
devices are in the game, often some extra alignment or padding between
planes is needed and that is not allowed by (1), even though all the
planes are in the same buffer.

My suggestion, based on the latest V4L2 discussion on unifying the
UAPI of i) and ii), is that we may want to instead always specify
buffers on a per-plane basis. Any additional requirements would be
then validated by the host, which could check if the planes end up in
the same buffer (or different buffers for (3)) and/or at the right
offsets.

WDYT?

Best regards,
Tomasz

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

