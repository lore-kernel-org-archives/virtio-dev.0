Return-Path: virtio-dev-return-6348-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 176EA985E6F
	for <virtio-dev@lists.oasis-open.org>; Wed, 20 Nov 2019 10:12:13 +0000 (UTC)
MIME-Version: 1.0
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <20191106084344.GB189998@stefanha-x1.localdomain> <20191106095122.jju7eo57scfoat6a@sirius.home.kraxel.org>
 <CAJSP0QUJBkqtVJq17tfX5O-JuvEGcZQviP0C3tv9qSDy-P-hcg@mail.gmail.com>
 <20191106125023.uhdhtqisybilxasr@sirius.home.kraxel.org> <CAJSP0QXG5Z3zCnPL+Y7EQfCeey2Fb9OdPdx531Jz2Ofk63wndg@mail.gmail.com>
 <20191108072210.ywyneaoc2y4slth6@sirius.home.kraxel.org> <CAJSP0QWZc=z56CHEKa8WVe9Cw2-EhDFU+7NeGgL+g-Go5q3K5Q@mail.gmail.com>
 <CADMs+9ZrfEt4QfCM9pC243KTejvbORQ-Nzo0eHjU0FJ8y-2kwQ@mail.gmail.com>
 <CAJSP0QUF1YA0c7b2ENeDLo1T9OsfeTJbonOYug5Fc56--YqZJQ@mail.gmail.com>
 <CAAFQd5C6mVEUQUP8-=GevM+rV1ksFg68kyWAjCj+cjB-iQiXaA@mail.gmail.com>
 <CAJSP0QXk9XkrOeiMZ=yQCbStkXATv+AUwqqGDfcSbqL05j1kbg@mail.gmail.com>
 <CAAFQd5DBiUta9HWYZX3N06J8bSqa=zBQvL5kdCLfWUfsf9s9Vw@mail.gmail.com> <CAJSP0QX6ajvKpU6k6i6uBFwc9gFWoYGa6HZn7AfbGr9+975=WQ@mail.gmail.com>
In-Reply-To: <CAJSP0QX6ajvKpU6k6i6uBFwc9gFWoYGa6HZn7AfbGr9+975=WQ@mail.gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Wed, 20 Nov 2019 19:11:56 +0900
Message-ID: <CAAFQd5B5t-2-3PfEfUe8DPvDKabfUnnK_svhcKExPRYUavx1yA@mail.gmail.com>
Subject: [virtio-dev] Re: guest / host buffer sharing ...
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Gerd Hoffmann <kraxel@redhat.com>, geoff@hostfission.com, virtio-dev@lists.oasis-open.org, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Alexandre Courbot <acourbot@chromium.org>, qemu-devel <qemu-devel@nongnu.org>, Keiichi Watanabe <keiichiw@chromium.org>, David Stevens <stevensd@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Dylan Reid <dgreid@chromium.org>, Gurchetan Singh <gurchetansingh@chromium.org>, Dmitry Morozov <dmitry.morozov@opensynergy.com>, Pawel Osciak <posciak@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Stefan,

On Mon, Nov 18, 2019 at 7:21 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Sat, Nov 9, 2019 at 3:12 PM Tomasz Figa <tfiga@chromium.org> wrote:
> >
> > On Sat, Nov 9, 2019 at 9:08 PM Stefan Hajnoczi <stefanha@gmail.com> wro=
te:
> > >
> > > On Sat, Nov 9, 2019 at 12:17 PM Tomasz Figa <tfiga@chromium.org> wrot=
e:
> > > > On Sat, Nov 9, 2019 at 7:12 PM Stefan Hajnoczi <stefanha@gmail.com>=
 wrote:
> > > > > On Sat, Nov 9, 2019 at 2:41 AM St=C3=A9phane Marchesin <marcheu@c=
hromium.org> wrote:
> > > > > > On Thu, Nov 7, 2019 at 11:35 PM Stefan Hajnoczi <stefanha@gmail=
.com> wrote:
> > > > > > > On Fri, Nov 8, 2019 at 8:22 AM Gerd Hoffmann <kraxel@redhat.c=
om> wrote:
> > > > > > > > > > Adding a list of common properties to the spec certainl=
y makes sense,
> > > > > > > > > > so everybody uses the same names.  Adding struct-ed pro=
perties for
> > > > > > > > > > common use cases might be useful too.
> > > > > > > > >
> > > > > > > > > Why not define VIRTIO devices for wayland and friends?
> > > > > > > >
> > > > > > > > There is an out-of-tree implementation of that, so yes, tha=
t surely is
> > > > > > > > an option.
> > > > > > > >
> > > > > > > > Wayland needs (a) shared buffers, mostly for gfx data, and =
(b) a stream
> > > > > > > > pipe as control channel.  Pretty much the same for X11, exc=
ept that
> > > > > > > > shared buffers are optional because the X protocol can also=
 squeeze all
> > > > > > > > display updates through the stream pipe.
> > > > > > > >
> > > > > > > > So, if you want allow guests talk to the host display serve=
r you can run
> > > > > > > > the stream pipe over vsock.  But there is nothing for the s=
hared
> > > > > > > > buffers ...
> > > > > > > >
> > > > > > > > We could replicate vsock functionality elsewhere.  I think =
that happened
> > > > > > > > in the out-of-tree virtio-wayland implementation.  There al=
so was some
> > > > > > > > discussion about adding streams to virtio-gpu, slightly pim=
ped up so you
> > > > > > > > can easily pass around virtio-gpu resource references for b=
uffer
> > > > > > > > sharing.  But given that getting vsock right isn't exactly =
trivial
> > > > > > > > (consider all the fairness issues when multiplexing multipl=
e streams
> > > > > > > > over a virtqueue for example) I don't think this is a good =
plan.
> > > > > > >
> > > > > > > I also think vsock isn't the right fit.
> > > > > > >
> > > > > >
> > > > > > +1 we are using vsock right now and we have a few pains because=
 of it.
> > > > > >
> > > > > > I think the high-level problem is that because it is a side cha=
nnel,
> > > > > > we don't see everything that happens to the buffer in one place
> > > > > > (rendering + display) and we can't do things like reallocate th=
e
> > > > > > format accordingly if needed, or we can't do flushing etc. on t=
hat
> > > > > > buffer where needed.
> > > > >
> > > > > Do you think a VIRTIO device designed for your use case is an
> > > > > appropriate solution?
> > > > >
> > > > > I have been arguing that these use cases should be addressed with
> > > > > dedicated VIRTIO devices, but I don't understand the use cases of
> > > > > everyone on the CC list so maybe I'm missing something :).  If th=
ere
> > > > > are reasons why having a VIRTIO device for your use case does not=
 make
> > > > > sense then it would be good to discuss them.  Blockers like "VIRT=
IO is
> > > > > too heavyweight/complex for us because ...", "Our application can=
't
> > > > > make use of VIRTIO devices because ...", etc would be important t=
o
> > > > > hear.
> > > >
> > > > Do you have any idea on how to model Wayland as a VIRTIO device?
> > > >
> > > > Stephane mentioned that we use vsock, but in fact we have our own
> > > > VIRTIO device, except that it's semantically almost the same as vso=
ck,
> > > > with a difference being the ability to pass buffers and pipes acros=
s
> > > > the VM boundary.
> > >
> > > I know neither Wayland nor your use case :).
> > >
> > > But we can discuss the design of your VIRTIO device.  Please post a
> > > link to the code.
> >
> > The guest-side driver:
> > https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chrom=
eos-4.19/drivers/virtio/virtio_wl.c
> >
> > Protocol definitions:
> > https://chromium.googlesource.com/chromiumos/third_party/kernel/+/chrom=
eos-4.19/include/uapi/linux/virtio_wl.h
> >
> > crosvm device implementation:
> > https://chromium.googlesource.com/chromiumos/platform/crosvm/+/refs/hea=
ds/master/devices/src/virtio/wl.rs
>
> Thanks, Tomasz!
>
> Unfortunately I haven't had a chance to look or catch up on this email
> thread due to other work that will keep me away for at least another
> week :(.

Thanks for the note. Waiting patiently. :)

Best regards,
Tomasz

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

