Return-Path: virtio-dev-return-6652-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5228F985CD4
	for <virtio-dev@lists.oasis-open.org>; Mon, 13 Jan 2020 12:00:00 +0000 (UTC)
MIME-Version: 1.0
References: <20191218130214.170703-1-keiichiw@chromium.org>
 <7740094.NyiUUSuA9g@os-lin-dmo> <20200113095636.blov62o4gbf27om5@sirius.home.kraxel.org>
 <12433898.dW097sEU6C@os-lin-dmo> <20200113110521.5ogc3fcy4zq32yzg@sirius.home.kraxel.org>
In-Reply-To: <20200113110521.5ogc3fcy4zq32yzg@sirius.home.kraxel.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Mon, 13 Jan 2020 20:59:42 +0900
Message-ID: <CAAFQd5D16G0E85BCZVx1LXd1TauQH8Lbgs5-0gLv7tNpm4sp_A@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH v2 0/1] VirtIO video device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Dmitry Sepp <dmitry.sepp@opensynergy.com>, spice-devel@lists.freedesktop.org, Keiichi Watanabe <keiichiw@chromium.org>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, David Stevens <stevensd@chromium.org>, uril@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 13, 2020 at 8:05 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Mon, Jan 13, 2020 at 11:41:45AM +0100, Dmitry Sepp wrote:
> > Hi Gerd,
> >
> > Thanks for reviewing!
> >
> > On Montag, 13. Januar 2020 10:56:36 CET Gerd Hoffmann wrote:
> > >   Hi,
> > >
> > > > This also means that we cannot have unspec for planes layout. Devic=
e
> > > > either
> > > > expects planes in separate buffers or in one buffer with some offse=
ts,
> > > > there cannot be mixed cases.
> > >
> > > Hmm.  Is it useful to support both?  Or maybe support the "one buffer=
 +
> > > offsets" case only?  Splitting one buffer into multiple smaller ones
> > > internally if needed shouldn't be a problem, and it would simplify th=
e
> > > interface a bit ...
> > >
> >
> > Ok, let's consider the following case:
> >  - the device expects planes in separate buffers.
> >  - say, Android on the guest side also imports planes in separate buffe=
rs into the driver.
> >  - but he driver only supports one buffer + offsets.
> >
> > Do you mean the driver then can join the underlying page lists and set =
offsets then? Yes,
> > this would probably make sense.
>
> Well, no.  Tomasz Figa had splitted the devices into three groups:
>
>   (1) requires single buffer.
>   (2) allows any layout (including the one (1) devices want).
>   (3) requires per-plane buffers.
>
> Category (3) devices are apparently rare and old.  Both category (1)+(2)
> devices can handle single buffers just fine.  So maybe support only
> that?

From the guest implementation point of view, Linux V4L2 currently
supports 2 cases, if used in allocation-mode (i.e. the buffers are
allocated locally by V4L2):

i) single buffer with plane offsets predetermined by the format, (can
be handled by devices from category 1) and 2))
ii) per-plane buffers with planes at the beginning of their own
buffers. (can be handled by devices from category 2) and 3))

Support for ii) is required if one wants to be able to import buffers
with arbitrary plane offsets, so I'd consider it unavoidable.

Given that, I'd suggest going with per-plane buffer specifiers. I feel
like it doesn't have much cost associated, but gives the most
flexibility.

Best regards,
Tomasz

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

