Return-Path: virtio-dev-return-6495-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 49A79980EB1
	for <virtio-dev@lists.oasis-open.org>; Thu, 12 Dec 2019 12:26:44 +0000 (UTC)
MIME-Version: 1.0
References: <CAD=HUj7EsxrkSubmY6HE4aYJOykVKtmGXjMjeGqnoJw1KZUc5Q@mail.gmail.com>
 <20191106124101.fsfxibdkypo4rswv@sirius.home.kraxel.org> <72712fe048af1489368f7416faa92c45@hostfission.com>
 <CAAFQd5Cpb=3HRL3NbgxP+S259nkNEuA=u75ew1JQTzvVUU5NeQ@mail.gmail.com>
 <d65bec5074eda5f389668e28922c1609@hostfission.com> <CAAFQd5AWqYaNWfYQ2hepjg7OD8y8ehHn0guusAR8JYefc+BNaw@mail.gmail.com>
 <CAEUnVG77y2DrV5kLTHDy1xio+yzMGv9j=M0c4388vH_LUaiXLg@mail.gmail.com>
 <CAD=HUj40Jb2cy8EP=24coO-CPUvq6ib+01bvXHn1G9GD8KuenA@mail.gmail.com>
 <20191211092625.jzqx2ukphhggwavo@sirius.home.kraxel.org> <CAD=HUj7d3SWqCH=57ymy-BVd6xdJWc=WSqHAFyQXt-3MjchEAA@mail.gmail.com>
 <20191212094121.by7w7fywlzdfoktn@sirius.home.kraxel.org>
In-Reply-To: <20191212094121.by7w7fywlzdfoktn@sirius.home.kraxel.org>
From: David Stevens <stevensd@chromium.org>
Date: Thu, 12 Dec 2019 21:26:32 +0900
Message-ID: <CAD=HUj6YYupjdxxz2mgMmE2DcKhXP-qdhRORvUNTmzcORRrLzg@mail.gmail.com>
Subject: Re: [virtio-dev] Re: guest / host buffer sharing ...
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Dylan Reid <dgreid@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Zach Reizner <zachr@chromium.org>, Geoffrey McRae <geoff@hostfission.com>, Keiichi Watanabe <keiichiw@chromium.org>, Dmitry Morozov <dmitry.morozov@opensynergy.com>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>, Gurchetan Singh <gurchetansingh@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, virtio-dev@lists.oasis-open.org, qemu-devel <qemu-devel@nongnu.org>
List-ID: <virtio-dev.lists.oasis-open.org>

> > > Second I think it is a bad idea
> > > from the security point of view.  When explicitly exporting buffers i=
t
> > > is easy to restrict access to the actual exports.
> >
> > Restricting access to actual exports could perhaps help catch bugs.
> > However, I don't think it provides any security guarantees, since the
> > guest can always just export every buffer before using it.
>
> Probably not on the guest/host boundary.
>
> It's important for security inside the guest though.  You don't want
> process A being able to access process B private resources via buffer
> sharing support, by guessing implicit buffer identifiers.

At least for the linux guest implementation, I wouldn't think the
uuids would be exposed from the kernel. To me, it seems like something
that should be handled internally by the virtio drivers. Especially
since the 'export' process would be very much a virtio-specific
action, so it's likely that it wouldn't fit nicely into existing
userspace software. If you use some other guest with untrusted
userspace drivers, or if you're pulling the uuids out of the kernel to
give to some non-virtio transport, then I can see it being a concern.

> > > Instead of using a dedicated buffer sharing device we can also use
> > > virtio-gpu (or any other driver which supports dma-buf exports) to
> > > manage buffers.

Ah, okay. I misunderstood the original statement. I read the sentence
as 'we can use virtio-gpu in place of the dedicated buffer sharing
device', rather than 'every device can manage its own buffers'. I can
agree with the second meaning.

> Without buffer sharing support the driver importing a virtio-gpu dma-buf
> can send the buffer scatter list to the host.  So both virtio-gpu and
> the other device would actually access the same guest pages, but they
> are not aware that the buffer is shared between devices.

With the uuid approach, how should this case be handled? Should it be
equivalent to exporting and importing the buffer which was created
first? Should the spec say it's undefined behavior that might work as
expected but might not, depending on the device implementation? Does
the spec even need to say anything about it?

> With buffer sharing virtio-gpu would attach a uuid to the dma-buf, and
> the importing driver can send the uuid (instead of the scatter list) to
> the host.  So the device can simply lookup the buffer on the host side
> and use it directly.  Another advantage is that this enables some more
> use cases like sharing buffers between devices which are not backed by
> guest ram.

Not just buffers not backed by guest ram, but things like fences. I
would suggest the uuids represent 'exported resources' rather than
'exported buffers'.

> Well, security-wise you want have buffer identifiers which can't be
> easily guessed.  And guessing uuid is pretty much impossible due to
> the namespace being huge.

I guess this depends on what you're passing around within the guest.
If you're passing around the raw uuids, sure. But I would argue it's
better to pass around unforgeable identifiers (e.g. fds), and to
restrict the uuids to when talking directly to the virtio transport.
But I guess there are likely situations where that's not possible.

-David

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

