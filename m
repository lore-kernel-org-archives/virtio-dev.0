Return-Path: virtio-dev-return-6668-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9B381985EFF
	for <virtio-dev@lists.oasis-open.org>; Tue, 21 Jan 2020 02:47:34 +0000 (UTC)
MIME-Version: 1.0
References: <20191218130214.170703-1-keiichiw@chromium.org>
 <7740094.NyiUUSuA9g@os-lin-dmo> <20200113095636.blov62o4gbf27om5@sirius.home.kraxel.org>
 <12433898.dW097sEU6C@os-lin-dmo> <20200113110521.5ogc3fcy4zq32yzg@sirius.home.kraxel.org>
 <CAAFQd5D16G0E85BCZVx1LXd1TauQH8Lbgs5-0gLv7tNpm4sp_A@mail.gmail.com>
 <20200113132654.r4lhspfx2z7zse2v@sirius.home.kraxel.org> <CAAFQd5A3=4JC+3bRf2iw8RwsoB1jJz8p5afi6KaHO6ML2LC0Rg@mail.gmail.com>
 <20200115112640.52kemwg4lncuvvir@sirius.home.kraxel.org> <CAD90VcaAaomTnwVESp9RaBwhjx+cKjXAJv4T7wSkFiCEhOUo5Q@mail.gmail.com>
 <20200120104755.3hhxlx6x6o32bagf@sirius.home.kraxel.org>
In-Reply-To: <20200120104755.3hhxlx6x6o32bagf@sirius.home.kraxel.org>
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Tue, 21 Jan 2020 11:47:20 +0900
Message-ID: <CAD90Vcak0iohLny9UjkqtBmM0px7Rz1mqQE6jw1wdu66QB4U3Q@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH v2 0/1] VirtIO video device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Tomasz Figa <tfiga@chromium.org>, Dmitry Sepp <dmitry.sepp@opensynergy.com>, spice-devel@lists.freedesktop.org, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, David Stevens <stevensd@chromium.org>, uril@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

On Mon, Jan 20, 2020 at 7:48 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > Hmm, using (ii) the API, then check whenever your three plane buffers
> > > happen to have the correct layout for (1) hardware looks somewhat
> > > backwards to me.
> >
> > Can't this problem be solved by adding "offset" field in virtio_video_m=
em_entry?
> >
> > struct virtio_video_mem_entry {
> >   le64 addr;
> >   le32 length;
> >   le32 offset;
> >   u8 padding[4];
> > };
> >
> > Here, "addr" must be the same in every mem_entry for (1) hardware.
>
> No.  virtio_video_mem_entry is basically a scatter list entry, you use
> an *array* of these entries to describe your buffer (unless you are
> using CMA due to hardware requirements, in this special case you have
> only one entry in your array).

I see. I forgot about scatter list.
However, I'm still not sure about the usage for CMA.
if we're using CMA for a multiplanar format, how can the device know
where the second plane start from?
In my understanding, the number of entries in this case should be the
same with the number of planes and
"entries[0].addr + entries[0].length =3D=3D entries[1].addr" should hold.

>
> > > I'd suggest to use (i) API and allow the device specify alignment
> > > requirements.  So (1) hardware would say "need_align=3D0", whereas (3=
)
> > > hardware would probably say "need_align=3DPAGE_SIZE" so it can easily
> > > split the single buffer into three per-plane buffers.
> >
> > Just to confirm, is "need_align" a field added in virtio_video_format_d=
esc?
>
> Given that different formats might have different alignment
> requirements this looks like a good place to me.  Maybe rename to
> plane_align to make clear what kind of alignment this is.

"plane_align" sounds better. Thanks.

Best regards,
Keiichi

>
> cheers,
>   Gerd
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

