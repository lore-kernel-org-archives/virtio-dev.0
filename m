Return-Path: virtio-dev-return-6496-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2A547980EB1
	for <virtio-dev@lists.oasis-open.org>; Thu, 12 Dec 2019 13:30:58 +0000 (UTC)
Date: Thu, 12 Dec 2019 14:30:48 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191212133048.4nbmuwhbq5z2ai6o@sirius.home.kraxel.org>
References: <72712fe048af1489368f7416faa92c45@hostfission.com>
 <CAAFQd5Cpb=3HRL3NbgxP+S259nkNEuA=u75ew1JQTzvVUU5NeQ@mail.gmail.com>
 <d65bec5074eda5f389668e28922c1609@hostfission.com>
 <CAAFQd5AWqYaNWfYQ2hepjg7OD8y8ehHn0guusAR8JYefc+BNaw@mail.gmail.com>
 <CAEUnVG77y2DrV5kLTHDy1xio+yzMGv9j=M0c4388vH_LUaiXLg@mail.gmail.com>
 <CAD=HUj40Jb2cy8EP=24coO-CPUvq6ib+01bvXHn1G9GD8KuenA@mail.gmail.com>
 <20191211092625.jzqx2ukphhggwavo@sirius.home.kraxel.org>
 <CAD=HUj7d3SWqCH=57ymy-BVd6xdJWc=WSqHAFyQXt-3MjchEAA@mail.gmail.com>
 <20191212094121.by7w7fywlzdfoktn@sirius.home.kraxel.org>
 <CAD=HUj6YYupjdxxz2mgMmE2DcKhXP-qdhRORvUNTmzcORRrLzg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAD=HUj6YYupjdxxz2mgMmE2DcKhXP-qdhRORvUNTmzcORRrLzg@mail.gmail.com>
Subject: Re: [virtio-dev] Re: guest / host buffer sharing ...
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: David Stevens <stevensd@chromium.org>
Cc: Dylan Reid <dgreid@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Zach Reizner <zachr@chromium.org>, Geoffrey McRae <geoff@hostfission.com>, Keiichi Watanabe <keiichiw@chromium.org>, Dmitry Morozov <dmitry.morozov@opensynergy.com>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>, Gurchetan Singh <gurchetansingh@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, virtio-dev@lists.oasis-open.org, qemu-devel <qemu-devel@nongnu.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Dec 12, 2019 at 09:26:32PM +0900, David Stevens wrote:
> > > > Second I think it is a bad idea
> > > > from the security point of view.  When explicitly exporting buffers=
 it
> > > > is easy to restrict access to the actual exports.
> > >
> > > Restricting access to actual exports could perhaps help catch bugs.
> > > However, I don't think it provides any security guarantees, since the
> > > guest can always just export every buffer before using it.
> >
> > Probably not on the guest/host boundary.
> >
> > It's important for security inside the guest though.  You don't want
> > process A being able to access process B private resources via buffer
> > sharing support, by guessing implicit buffer identifiers.
>=20
> At least for the linux guest implementation, I wouldn't think the
> uuids would be exposed from the kernel. To me, it seems like something
> that should be handled internally by the virtio drivers.

That would be one possible use case, yes.  The exporting driver attaches
a uuid to the dma-buf.  The importing driver can see the attached uuid
and use it (if supported, otherwise run with the scatter list).  That
will be transparent to userspace, apps will just export/import dma-bufs
as usual and not even notice the uuid.

I can see other valid use cases though:  A wayland proxy could use
virtio-gpu buffer exports for shared memory and send the buffer uuid
to the host over some stream protocol (vsock, tcp, ...).  For that to
work we have to export the uuid to userspace, for example using a ioctl
on the dma-buf file handle.

> If you use some other guest with untrusted
> userspace drivers, or if you're pulling the uuids out of the kernel to
> give to some non-virtio transport, then I can see it being a concern.

I strongly prefer a design where we don't have to worry about that
concern in the first place instead of discussing whenever we should be
worried or not.

> > Without buffer sharing support the driver importing a virtio-gpu dma-bu=
f
> > can send the buffer scatter list to the host.  So both virtio-gpu and
> > the other device would actually access the same guest pages, but they
> > are not aware that the buffer is shared between devices.
>=20
> With the uuid approach, how should this case be handled? Should it be
> equivalent to exporting and importing the buffer which was created
> first? Should the spec say it's undefined behavior that might work as
> expected but might not, depending on the device implementation? Does
> the spec even need to say anything about it?

Using the uuid is an optional optimization.  I'd expect the workflow be
roughly this:

  (1) exporting driver exports a dma-buf as usual, additionally attaches
      a uuid to it and notifies the host (using device-specific commands).
  (2) importing driver will ask the host to use the buffer referenced by
      the given uuid.
  (3) if (2) fails for some reason use the dma-buf scatter list instead.

Of course only virtio drivers would try step (2), other drivers (when
sharing buffers between intel gvt device and virtio-gpu for example)
would go straight to (3).

> > With buffer sharing virtio-gpu would attach a uuid to the dma-buf, and
> > the importing driver can send the uuid (instead of the scatter list) to
> > the host.  So the device can simply lookup the buffer on the host side
> > and use it directly.  Another advantage is that this enables some more
> > use cases like sharing buffers between devices which are not backed by
> > guest ram.
>=20
> Not just buffers not backed by guest ram, but things like fences. I
> would suggest the uuids represent 'exported resources' rather than
> 'exported buffers'.

Hmm, I can't see how this is useful.  Care to outline how you envision
this to work in a typical use case?

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

