Return-Path: virtio-dev-return-6653-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 40F0D985CD4
	for <virtio-dev@lists.oasis-open.org>; Mon, 13 Jan 2020 13:27:05 +0000 (UTC)
Date: Mon, 13 Jan 2020 14:26:54 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200113132654.r4lhspfx2z7zse2v@sirius.home.kraxel.org>
References: <20191218130214.170703-1-keiichiw@chromium.org>
 <7740094.NyiUUSuA9g@os-lin-dmo>
 <20200113095636.blov62o4gbf27om5@sirius.home.kraxel.org>
 <12433898.dW097sEU6C@os-lin-dmo>
 <20200113110521.5ogc3fcy4zq32yzg@sirius.home.kraxel.org>
 <CAAFQd5D16G0E85BCZVx1LXd1TauQH8Lbgs5-0gLv7tNpm4sp_A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAAFQd5D16G0E85BCZVx1LXd1TauQH8Lbgs5-0gLv7tNpm4sp_A@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH v2 0/1] VirtIO video device specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Tomasz Figa <tfiga@chromium.org>
Cc: Dmitry Sepp <dmitry.sepp@opensynergy.com>, spice-devel@lists.freedesktop.org, Keiichi Watanabe <keiichiw@chromium.org>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, David Stevens <stevensd@chromium.org>, uril@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> > Well, no.  Tomasz Figa had splitted the devices into three groups:
> >
> >   (1) requires single buffer.
> >   (2) allows any layout (including the one (1) devices want).
> >   (3) requires per-plane buffers.
> >
> > Category (3) devices are apparently rare and old.  Both category (1)+(2=
)
> > devices can handle single buffers just fine.  So maybe support only
> > that?
>=20
> From the guest implementation point of view, Linux V4L2 currently
> supports 2 cases, if used in allocation-mode (i.e. the buffers are
> allocated locally by V4L2):
>=20
> i) single buffer with plane offsets predetermined by the format, (can
> be handled by devices from category 1) and 2))
> ii) per-plane buffers with planes at the beginning of their own
> buffers. (can be handled by devices from category 2) and 3))
>=20
> Support for ii) is required if one wants to be able to import buffers
> with arbitrary plane offsets, so I'd consider it unavoidable.

If you have (1) hardware you simply can't import buffers with arbitrary
plane offsets, so I'd expect software would prefer the single buffer
layout (i) over (ii), even when using another driver + dmabuf
export/import, to be able to support as much hardware as possible.
So (ii) might end up being unused in practice.

But maybe not, was just an idea, feel free to scratch it.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

