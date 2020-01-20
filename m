Return-Path: virtio-dev-return-6666-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E03A3985DF6
	for <virtio-dev@lists.oasis-open.org>; Mon, 20 Jan 2020 07:20:20 +0000 (UTC)
MIME-Version: 1.0
References: <20191218130214.170703-1-keiichiw@chromium.org>
 <7740094.NyiUUSuA9g@os-lin-dmo> <20200113095636.blov62o4gbf27om5@sirius.home.kraxel.org>
 <12433898.dW097sEU6C@os-lin-dmo> <20200113110521.5ogc3fcy4zq32yzg@sirius.home.kraxel.org>
 <CAAFQd5D16G0E85BCZVx1LXd1TauQH8Lbgs5-0gLv7tNpm4sp_A@mail.gmail.com>
 <20200113132654.r4lhspfx2z7zse2v@sirius.home.kraxel.org> <CAAFQd5A3=4JC+3bRf2iw8RwsoB1jJz8p5afi6KaHO6ML2LC0Rg@mail.gmail.com>
 <20200115112640.52kemwg4lncuvvir@sirius.home.kraxel.org>
In-Reply-To: <20200115112640.52kemwg4lncuvvir@sirius.home.kraxel.org>
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Mon, 20 Jan 2020 16:20:03 +0900
Message-ID: <CAD90VcaAaomTnwVESp9RaBwhjx+cKjXAJv4T7wSkFiCEhOUo5Q@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH v2 0/1] VirtIO video device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Tomasz Figa <tfiga@chromium.org>, Dmitry Sepp <dmitry.sepp@opensynergy.com>, spice-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, David Stevens <stevensd@chromium.org>, uril@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

On Wed, Jan 15, 2020 at 8:26 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > If you have (1) hardware you simply can't import buffers with arbitra=
ry
> > > plane offsets, so I'd expect software would prefer the single buffer
> > > layout (i) over (ii), even when using another driver + dmabuf
> > > export/import, to be able to support as much hardware as possible.
> > > So (ii) might end up being unused in practice.
> > >
> > > But maybe not, was just an idea, feel free to scratch it.
> >
> > That's true, simple user space would often do that. However, if more
> > devices are in the game, often some extra alignment or padding between
> > planes is needed and that is not allowed by (1), even though all the
> > planes are in the same buffer.
> >
> > My suggestion, based on the latest V4L2 discussion on unifying the
> > UAPI of i) and ii), is that we may want to instead always specify
> > buffers on a per-plane basis. Any additional requirements would be
> > then validated by the host, which could check if the planes end up in
> > the same buffer (or different buffers for (3)) and/or at the right
> > offsets.
>
> Hmm, using (ii) the API, then check whenever your three plane buffers
> happen to have the correct layout for (1) hardware looks somewhat
> backwards to me.

Can't this problem be solved by adding "offset" field in virtio_video_mem_e=
ntry?

struct virtio_video_mem_entry {
  le64 addr;
  le32 length;
  le32 offset;
  u8 padding[4];
};

Here, "addr" must be the same in every mem_entry for (1) hardware.

>
> I'd suggest to use (i) API and allow the device specify alignment
> requirements.  So (1) hardware would say "need_align=3D0", whereas (3)
> hardware would probably say "need_align=3DPAGE_SIZE" so it can easily
> split the single buffer into three per-plane buffers.

Just to confirm, is "need_align" a field added in virtio_video_format_desc?
It sounds workable, too.

Best regards,
Keiichi


>
> cheers,
>   Gerd
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

