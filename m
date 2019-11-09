Return-Path: virtio-dev-return-6308-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5A791985F38
	for <virtio-dev@lists.oasis-open.org>; Sat,  9 Nov 2019 11:17:10 +0000 (UTC)
MIME-Version: 1.0
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <20191106084344.GB189998@stefanha-x1.localdomain> <20191106095122.jju7eo57scfoat6a@sirius.home.kraxel.org>
 <CAJSP0QUJBkqtVJq17tfX5O-JuvEGcZQviP0C3tv9qSDy-P-hcg@mail.gmail.com>
 <20191106125023.uhdhtqisybilxasr@sirius.home.kraxel.org> <CAJSP0QXG5Z3zCnPL+Y7EQfCeey2Fb9OdPdx531Jz2Ofk63wndg@mail.gmail.com>
 <20191108072210.ywyneaoc2y4slth6@sirius.home.kraxel.org> <CAJSP0QWZc=z56CHEKa8WVe9Cw2-EhDFU+7NeGgL+g-Go5q3K5Q@mail.gmail.com>
 <CADMs+9ZrfEt4QfCM9pC243KTejvbORQ-Nzo0eHjU0FJ8y-2kwQ@mail.gmail.com> <CAJSP0QUF1YA0c7b2ENeDLo1T9OsfeTJbonOYug5Fc56--YqZJQ@mail.gmail.com>
In-Reply-To: <CAJSP0QUF1YA0c7b2ENeDLo1T9OsfeTJbonOYug5Fc56--YqZJQ@mail.gmail.com>
From: Tomasz Figa <tfiga@chromium.org>
Date: Sat, 9 Nov 2019 20:16:52 +0900
Message-ID: <CAAFQd5C6mVEUQUP8-=GevM+rV1ksFg68kyWAjCj+cjB-iQiXaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: guest / host buffer sharing ...
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Gerd Hoffmann <kraxel@redhat.com>, geoff@hostfission.com, virtio-dev@lists.oasis-open.org, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Alexandre Courbot <acourbot@chromium.org>, qemu-devel <qemu-devel@nongnu.org>, Keiichi Watanabe <keiichiw@chromium.org>, David Stevens <stevensd@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Dylan Reid <dgreid@chromium.org>, Gurchetan Singh <gurchetansingh@chromium.org>, Dmitry Morozov <dmitry.morozov@opensynergy.com>, Pawel Osciak <posciak@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Sat, Nov 9, 2019 at 7:12 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Sat, Nov 9, 2019 at 2:41 AM St=C3=A9phane Marchesin <marcheu@chromium.=
org> wrote:
> >
> > On Thu, Nov 7, 2019 at 11:35 PM Stefan Hajnoczi <stefanha@gmail.com> wr=
ote:
> > >
> > > On Fri, Nov 8, 2019 at 8:22 AM Gerd Hoffmann <kraxel@redhat.com> wrot=
e:
> > > > > > Adding a list of common properties to the spec certainly makes =
sense,
> > > > > > so everybody uses the same names.  Adding struct-ed properties =
for
> > > > > > common use cases might be useful too.
> > > > >
> > > > > Why not define VIRTIO devices for wayland and friends?
> > > >
> > > > There is an out-of-tree implementation of that, so yes, that surely=
 is
> > > > an option.
> > > >
> > > > Wayland needs (a) shared buffers, mostly for gfx data, and (b) a st=
ream
> > > > pipe as control channel.  Pretty much the same for X11, except that
> > > > shared buffers are optional because the X protocol can also squeeze=
 all
> > > > display updates through the stream pipe.
> > > >
> > > > So, if you want allow guests talk to the host display server you ca=
n run
> > > > the stream pipe over vsock.  But there is nothing for the shared
> > > > buffers ...
> > > >
> > > > We could replicate vsock functionality elsewhere.  I think that hap=
pened
> > > > in the out-of-tree virtio-wayland implementation.  There also was s=
ome
> > > > discussion about adding streams to virtio-gpu, slightly pimped up s=
o you
> > > > can easily pass around virtio-gpu resource references for buffer
> > > > sharing.  But given that getting vsock right isn't exactly trivial
> > > > (consider all the fairness issues when multiplexing multiple stream=
s
> > > > over a virtqueue for example) I don't think this is a good plan.
> > >
> > > I also think vsock isn't the right fit.
> > >
> >
> > +1 we are using vsock right now and we have a few pains because of it.
> >
> > I think the high-level problem is that because it is a side channel,
> > we don't see everything that happens to the buffer in one place
> > (rendering + display) and we can't do things like reallocate the
> > format accordingly if needed, or we can't do flushing etc. on that
> > buffer where needed.
>
> Do you think a VIRTIO device designed for your use case is an
> appropriate solution?
>
> I have been arguing that these use cases should be addressed with
> dedicated VIRTIO devices, but I don't understand the use cases of
> everyone on the CC list so maybe I'm missing something :).  If there
> are reasons why having a VIRTIO device for your use case does not make
> sense then it would be good to discuss them.  Blockers like "VIRTIO is
> too heavyweight/complex for us because ...", "Our application can't
> make use of VIRTIO devices because ...", etc would be important to
> hear.

Do you have any idea on how to model Wayland as a VIRTIO device?

Stephane mentioned that we use vsock, but in fact we have our own
VIRTIO device, except that it's semantically almost the same as vsock,
with a difference being the ability to pass buffers and pipes across
the VM boundary.

Best regards,
Tomasz

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

