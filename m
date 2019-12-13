Return-Path: virtio-dev-return-6511-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EE7D4985EEC
	for <virtio-dev@lists.oasis-open.org>; Fri, 13 Dec 2019 03:21:15 +0000 (UTC)
MIME-Version: 1.0
References: <72712fe048af1489368f7416faa92c45@hostfission.com>
 <CAAFQd5Cpb=3HRL3NbgxP+S259nkNEuA=u75ew1JQTzvVUU5NeQ@mail.gmail.com>
 <d65bec5074eda5f389668e28922c1609@hostfission.com> <CAAFQd5AWqYaNWfYQ2hepjg7OD8y8ehHn0guusAR8JYefc+BNaw@mail.gmail.com>
 <CAEUnVG77y2DrV5kLTHDy1xio+yzMGv9j=M0c4388vH_LUaiXLg@mail.gmail.com>
 <CAD=HUj40Jb2cy8EP=24coO-CPUvq6ib+01bvXHn1G9GD8KuenA@mail.gmail.com>
 <20191211092625.jzqx2ukphhggwavo@sirius.home.kraxel.org> <CAD=HUj7d3SWqCH=57ymy-BVd6xdJWc=WSqHAFyQXt-3MjchEAA@mail.gmail.com>
 <20191212094121.by7w7fywlzdfoktn@sirius.home.kraxel.org> <CAD=HUj6YYupjdxxz2mgMmE2DcKhXP-qdhRORvUNTmzcORRrLzg@mail.gmail.com>
 <20191212133048.4nbmuwhbq5z2ai6o@sirius.home.kraxel.org>
In-Reply-To: <20191212133048.4nbmuwhbq5z2ai6o@sirius.home.kraxel.org>
From: David Stevens <stevensd@chromium.org>
Date: Fri, 13 Dec 2019 12:21:03 +0900
Message-ID: <CAD=HUj623MyeZ7VmrYTfig9oiyNhipidpvhuuurs3VgGBgjZpQ@mail.gmail.com>
Subject: Re: [virtio-dev] Re: guest / host buffer sharing ...
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Dylan Reid <dgreid@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Zach Reizner <zachr@chromium.org>, Geoffrey McRae <geoff@hostfission.com>, Keiichi Watanabe <keiichiw@chromium.org>, Dmitry Morozov <dmitry.morozov@opensynergy.com>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>, Gurchetan Singh <gurchetansingh@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, virtio-dev@lists.oasis-open.org, qemu-devel <qemu-devel@nongnu.org>
List-ID: <virtio-dev.lists.oasis-open.org>

> > > Without buffer sharing support the driver importing a virtio-gpu dma-=
buf
> > > can send the buffer scatter list to the host.  So both virtio-gpu and
> > > the other device would actually access the same guest pages, but they
> > > are not aware that the buffer is shared between devices.
> >
> > With the uuid approach, how should this case be handled? Should it be
> > equivalent to exporting and importing the buffer which was created
> > first? Should the spec say it's undefined behavior that might work as
> > expected but might not, depending on the device implementation? Does
> > the spec even need to say anything about it?
>
> Using the uuid is an optional optimization.  I'd expect the workflow be
> roughly this:
>
>   (1) exporting driver exports a dma-buf as usual, additionally attaches
>       a uuid to it and notifies the host (using device-specific commands)=
.
>   (2) importing driver will ask the host to use the buffer referenced by
>       the given uuid.
>   (3) if (2) fails for some reason use the dma-buf scatter list instead.
>
> Of course only virtio drivers would try step (2), other drivers (when
> sharing buffers between intel gvt device and virtio-gpu for example)
> would go straight to (3).

For virtio-gpu as it is today, it's not clear to me that they're
equivalent. As I read it, the virtio-gpu spec makes a distinction
between the guest memory and the host resource. If virtio-gpu is
communicating with non-virtio devices, then obviously you'd just be
working with guest memory. But if it's communicating with another
virtio device, then there are potentially distinct guest and host
buffers that could be used. The spec shouldn't leave any room for
ambiguity as to how this distinction is handled.

> > Not just buffers not backed by guest ram, but things like fences. I
> > would suggest the uuids represent 'exported resources' rather than
> > 'exported buffers'.
>
> Hmm, I can't see how this is useful.  Care to outline how you envision
> this to work in a typical use case?

Looking at the spec again, it seems like there's some more work that
would need to be done before this would be possible. But the use case
I was thinking of would be to export a fence from virtio-gpu and share
it with a virtio decoder, to set up a decode pipeline that doesn't
need to go back into the guest for synchronization. I'm fine dropping
this point for now, though, and revisiting it as a separate proposal.

-David

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

