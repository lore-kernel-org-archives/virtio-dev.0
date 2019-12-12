Return-Path: virtio-dev-return-6492-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 70236985EEB
	for <virtio-dev@lists.oasis-open.org>; Thu, 12 Dec 2019 06:40:56 +0000 (UTC)
MIME-Version: 1.0
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <CAD=HUj7EsxrkSubmY6HE4aYJOykVKtmGXjMjeGqnoJw1KZUc5Q@mail.gmail.com>
 <20191106124101.fsfxibdkypo4rswv@sirius.home.kraxel.org> <72712fe048af1489368f7416faa92c45@hostfission.com>
 <CAAFQd5Cpb=3HRL3NbgxP+S259nkNEuA=u75ew1JQTzvVUU5NeQ@mail.gmail.com>
 <d65bec5074eda5f389668e28922c1609@hostfission.com> <CAAFQd5AWqYaNWfYQ2hepjg7OD8y8ehHn0guusAR8JYefc+BNaw@mail.gmail.com>
 <CAEUnVG77y2DrV5kLTHDy1xio+yzMGv9j=M0c4388vH_LUaiXLg@mail.gmail.com>
 <CAD=HUj40Jb2cy8EP=24coO-CPUvq6ib+01bvXHn1G9GD8KuenA@mail.gmail.com> <20191211092625.jzqx2ukphhggwavo@sirius.home.kraxel.org>
In-Reply-To: <20191211092625.jzqx2ukphhggwavo@sirius.home.kraxel.org>
From: David Stevens <stevensd@chromium.org>
Date: Thu, 12 Dec 2019 15:40:44 +0900
Message-ID: <CAD=HUj7d3SWqCH=57ymy-BVd6xdJWc=WSqHAFyQXt-3MjchEAA@mail.gmail.com>
Subject: Re: [virtio-dev] Re: guest / host buffer sharing ...
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Dylan Reid <dgreid@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Zach Reizner <zachr@chromium.org>, Geoffrey McRae <geoff@hostfission.com>, Keiichi Watanabe <keiichiw@chromium.org>, Dmitry Morozov <dmitry.morozov@opensynergy.com>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>, Gurchetan Singh <gurchetansingh@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, virtio-dev@lists.oasis-open.org, qemu-devel <qemu-devel@nongnu.org>
List-ID: <virtio-dev.lists.oasis-open.org>

> First the addressing is non-trivial, especially with the "transport
> specific device address" in the tuple.

There is complexity here, but I think it would also be present in the
buffer sharing device case. With a buffer sharing device, the same
identifying information would need to be provided from the exporting
driver to the buffer sharing driver, so the buffer sharing device
would be able to identify the right device in the vmm. And then in
both import cases, the buffer is just identified by some opaque bytes
that need to be given to a buffer manager in the vmm to resolve the
actual buffer.

> Second I think it is a bad idea
> from the security point of view.  When explicitly exporting buffers it
> is easy to restrict access to the actual exports.

Restricting access to actual exports could perhaps help catch bugs.
However, I don't think it provides any security guarantees, since the
guest can always just export every buffer before using it. Using
implicit addresses doesn't mean that the buffer import actually has to
be allowed - it can be thought of as fusing the buffer export and
buffer import operations into a single operation. The vmm can still
perform exactly the same security checks.

> Instead of using a dedicated buffer sharing device we can also use
> virtio-gpu (or any other driver which supports dma-buf exports) to
> manage buffers.

I don't think adding generic buffer management to virtio-gpu (or any
specific device type) is a good idea, since that device would then
become a requirement for buffer sharing between unrelated devices. For
example, it's easy to imagine a device with a virtio-camera and a
virtio-encoder (although such protocols don't exist today). It
wouldn't make sense to require a virtio-gpu device to allow those two
devices to share buffers.

> With no central instance (buffer sharing device) being there managing
> the buffer identifiers I think using uuids as identifiers would be a
> good idea, to avoid clashes.  Also good for security because it's pretty
> much impossible to guess buffer identifiers then.

Using uuids to identify buffers would work. The fact that it provides
a single way to refer to both guest and host allocated buffers is
nice. And it could also directly apply to sharing resources other than
buffers (e.g. fences). Although unless we're positing that there are
different levels of trust within the guest, I don't think uuids really
provides much security.

If we're talking about uuids, they could also be used to simplify my
proposed implicit addressing scheme. Each device could be assigned a
uuid, which would simplify the shared resource identifier to
(device-uuid, shmid, offset).

In my opinion, the implicit buffer addressing scheme is fairly similar
to the uuid proposal. As I see it, the difference is that one is
referring to resources as uuids in a global namespace, whereas the
other is referring to resources with fully qualified names. Beyond
that, the implementations would be fairly similar.

-David

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

