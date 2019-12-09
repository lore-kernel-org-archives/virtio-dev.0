Return-Path: virtio-dev-return-6481-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D2D7C984345
	for <virtio-dev@lists.oasis-open.org>; Mon,  9 Dec 2019 13:18:07 +0000 (UTC)
MIME-Version: 1.0
References: <20191105191919.167345-1-dmitry.sepp@opensynergy.com>
 <CAD90VcY1QgJGYYXTWDFMVshtV0ZnwLjYUzf3uHcDR=FNA2mMEw@mail.gmail.com>
 <20191209104615.ulct6p34cn7ypvrz@sirius.home.kraxel.org> <1970145.L65FEUb58e@os-lin-dmo>
In-Reply-To: <1970145.L65FEUb58e@os-lin-dmo>
From: Keiichi Watanabe <keiichiw@chromium.org>
Date: Mon, 9 Dec 2019 22:17:54 +0900
Message-ID: <CAD90VcaeEti2BW4BoVfP9Qm9J7QtTVPp0wFJAMdgeiCFf2U-Ag@mail.gmail.com>
Subject: Re: [virtio-dev] [RFC RESEND] virtio-video: Add virtio video device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Enrico Granata <egranata@google.com>, virtio-dev@lists.oasis-open.org, Tomasz Figa <tfiga@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Dylan Reid <dgreid@chromium.org>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, David Stevens <stevensd@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

On Mon, Dec 9, 2019 at 8:38 PM Dmitry Sepp <dmitry.sepp@opensynergy.com> wr=
ote:
>
> Hi,
>
> On Montag, 9. Dezember 2019 11:46:15 CET Gerd Hoffmann wrote:
> >   Hi,
> >
> > > > For (1) you'll simply do a QUEUE_BUFFER.  The command carries refer=
ences
> > > > to the buffer pages.  No resource management needed.
> > > >
> > > > For (2) you'll have RESOURCE_CREATE + RESOURCE_DESTROY + QUEUE_RESO=
URCE,
> > > > where RESOURCE_CREATE passes the scatter list of buffer pages to th=
e
> > > > host and QUEUE_RESOURCE will carry just the resource id.
> > > >
> > > > For (3) you'll have RESOURCE_IMPORT + RESOURCE_DESTROY + QUEUE_RESO=
URCE.
> > >
> > > Thanks for the clarification.
> > > On second thought, however, I'm wondering if we should keep all
> > > RESOURCE controls.
> > > This should be an option (4).
> >
> > Well, that's actually (2), aka "we use RESOURCE_* commands to manage
> > resources".  With the commands in the latest draft that would be:
> >
> >   (1) RESOURCE_CREATE
> >   (2) RESOURCE_ATTACH_BACKING
> >   (3) RESOURCE_QUEUE (resource can be used multiple times here)
> >   (4) RESOURCE_DETACH_BACKING
> >   (5) RESOURCE_DESTROY
> >
> > I'm not sure we need the separate *_BACKING commands.  I think we could
> > also have RESOURCE_CREATE pass the buffer pages scatter list instead.
> >
> > Why it is done this way?  Just because the design was copied from
> > virtio-gpu?  Or is there some specific reason?
>
> Yes, the design was just derived from virtio-gpu at early stages.
>
> I do agree we should merge the two steps.

Thanks for the explanation.  Merging them sounds good to me.

-Keiichi

>
> >
> > cheers,
> >   Gerd
>
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

