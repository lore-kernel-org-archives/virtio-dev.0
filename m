Return-Path: virtio-dev-return-6489-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 27569985D78
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Dec 2019 09:26:33 +0000 (UTC)
Date: Wed, 11 Dec 2019 10:26:25 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191211092625.jzqx2ukphhggwavo@sirius.home.kraxel.org>
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <CAD=HUj7EsxrkSubmY6HE4aYJOykVKtmGXjMjeGqnoJw1KZUc5Q@mail.gmail.com>
 <20191106124101.fsfxibdkypo4rswv@sirius.home.kraxel.org>
 <72712fe048af1489368f7416faa92c45@hostfission.com>
 <CAAFQd5Cpb=3HRL3NbgxP+S259nkNEuA=u75ew1JQTzvVUU5NeQ@mail.gmail.com>
 <d65bec5074eda5f389668e28922c1609@hostfission.com>
 <CAAFQd5AWqYaNWfYQ2hepjg7OD8y8ehHn0guusAR8JYefc+BNaw@mail.gmail.com>
 <CAEUnVG77y2DrV5kLTHDy1xio+yzMGv9j=M0c4388vH_LUaiXLg@mail.gmail.com>
 <CAD=HUj40Jb2cy8EP=24coO-CPUvq6ib+01bvXHn1G9GD8KuenA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAD=HUj40Jb2cy8EP=24coO-CPUvq6ib+01bvXHn1G9GD8KuenA@mail.gmail.com>
Subject: [virtio-dev] Re: guest / host buffer sharing ...
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: David Stevens <stevensd@chromium.org>
Cc: Dylan Reid <dgreid@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Zach Reizner <zachr@chromium.org>, Geoffrey McRae <geoff@hostfission.com>, Keiichi Watanabe <keiichiw@chromium.org>, Dmitry Morozov <dmitry.morozov@opensynergy.com>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>, Gurchetan Singh <gurchetansingh@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, virtio-dev@lists.oasis-open.org, qemu-devel <qemu-devel@nongnu.org>
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> None of the proposals directly address the use case of sharing host
> allocated buffers between devices, but I think they can be extended to
> support it. Host buffers can be identified by the following tuple:
> (transport type enum, transport specific device address, shmid,
> offset). I think this is sufficient even for host-allocated buffers
> that aren't visible to the guest (e.g. protected memory, vram), since
> they can still be given address space in some shared memory region,
> even if those addresses are actually inaccessible to the guest. At
> this point, the host buffer identifier can simply be passed in place
> of the guest ram scatterlist with either proposed buffer sharing
> mechanism.

> I think the main question here is whether or not the complexity of
> generic buffers and a buffer sharing device is worth it compared to
> the more implicit definition of buffers.

Here are two issues mixed up.  First is, whenever we'll go define a
buffer sharing device or not.  Second is how we are going to address
buffers.

I think defining (and addressing) buffers implicitly is a bad idea.
First the addressing is non-trivial, especially with the "transport
specific device address" in the tuple.  Second I think it is a bad idea
from the security point of view.  When explicitly exporting buffers it
is easy to restrict access to the actual exports.

Instead of using a dedicated buffer sharing device we can also use
virtio-gpu (or any other driver which supports dma-buf exports) to
manage buffers.  virtio-gpu would create an identifier when exporting a
buffer (dma-buf exports inside the guest), attach the identifier to the
dma-buf so other drivers importing the buffer can see and use it.  Maybe
add an ioctl to query, so guest userspace can query the identifier too.
Also send the identifier to the host so it can also be used on the host
side to lookup and access the buffer.

With no central instance (buffer sharing device) being there managing
the buffer identifiers I think using uuids as identifiers would be a
good idea, to avoid clashes.  Also good for security because it's pretty
much impossible to guess buffer identifiers then.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

