Return-Path: virtio-dev-return-6677-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 30499985F08
	for <virtio-dev@lists.oasis-open.org>; Tue, 21 Jan 2020 08:56:22 +0000 (UTC)
MIME-Version: 1.0
References: <20200113095636.blov62o4gbf27om5@sirius.home.kraxel.org>
 <12433898.dW097sEU6C@os-lin-dmo> <20200113110521.5ogc3fcy4zq32yzg@sirius.home.kraxel.org>
 <CAAFQd5D16G0E85BCZVx1LXd1TauQH8Lbgs5-0gLv7tNpm4sp_A@mail.gmail.com>
 <20200113132654.r4lhspfx2z7zse2v@sirius.home.kraxel.org> <CAAFQd5A3=4JC+3bRf2iw8RwsoB1jJz8p5afi6KaHO6ML2LC0Rg@mail.gmail.com>
 <20200115112640.52kemwg4lncuvvir@sirius.home.kraxel.org> <CAD90VcaAaomTnwVESp9RaBwhjx+cKjXAJv4T7wSkFiCEhOUo5Q@mail.gmail.com>
 <20200120104755.3hhxlx6x6o32bagf@sirius.home.kraxel.org> <CAD90Vcak0iohLny9UjkqtBmM0px7Rz1mqQE6jw1wdu66QB4U3Q@mail.gmail.com>
 <20200121064437.jryf3lq72bucs6rr@sirius.home.kraxel.org>
In-Reply-To: <20200121064437.jryf3lq72bucs6rr@sirius.home.kraxel.org>
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Tue, 21 Jan 2020 17:56:05 +0900
Message-ID: <CAD90VcaTtCdrhnPhhDWrheF2xrgF-LXL94MPZy9BfHB-Wh9FwQ@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH v2 0/1] VirtIO video device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Tomasz Figa <tfiga@chromium.org>, Dmitry Sepp <dmitry.sepp@opensynergy.com>, spice-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, David Stevens <stevensd@chromium.org>, uril@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

On Tue, Jan 21, 2020 at 3:44 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> > > > Can't this problem be solved by adding "offset" field in virtio_vid=
eo_mem_entry?
> > > >
> > > > struct virtio_video_mem_entry {
> > > >   le64 addr;
> > > >   le32 length;
> > > >   le32 offset;
> > > >   u8 padding[4];
> > > > };
> > > >
> > > > Here, "addr" must be the same in every mem_entry for (1) hardware.
> > >
> > > No.  virtio_video_mem_entry is basically a scatter list entry, you us=
e
> > > an *array* of these entries to describe your buffer (unless you are
> > > using CMA due to hardware requirements, in this special case you have
> > > only one entry in your array).
> >
> > I see. I forgot about scatter list.
> > However, I'm still not sure about the usage for CMA.
> > if we're using CMA for a multiplanar format, how can the device know
> > where the second plane start from?
> > In my understanding, the number of entries in this case should be the
> > same with the number of planes and
> > "entries[0].addr + entries[0].length =3D=3D entries[1].addr" should hol=
d.
>
> With the one-buffer-per-frame model you could add a plane_offsets[4]
> field to virtio_video_resource_create.
>
> The virtio_video_mem_entry array describes the whole buffer for all
> planes, the plane_offsets array says where the individual planes start
> inside the buffer.

Got it. It makes sense to have plane_offsets[] separately.
Thanks!

Best regards,
Keiichi

>
> cheers,
>   Gerd
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

