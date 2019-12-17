Return-Path: virtio-dev-return-6521-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DBDAB985ED9
	for <virtio-dev@lists.oasis-open.org>; Tue, 17 Dec 2019 12:59:41 +0000 (UTC)
MIME-Version: 1.0
References: <d65bec5074eda5f389668e28922c1609@hostfission.com>
 <CAAFQd5AWqYaNWfYQ2hepjg7OD8y8ehHn0guusAR8JYefc+BNaw@mail.gmail.com>
 <CAEUnVG77y2DrV5kLTHDy1xio+yzMGv9j=M0c4388vH_LUaiXLg@mail.gmail.com>
 <CAD=HUj40Jb2cy8EP=24coO-CPUvq6ib+01bvXHn1G9GD8KuenA@mail.gmail.com>
 <20191211092625.jzqx2ukphhggwavo@sirius.home.kraxel.org> <CAD=HUj7d3SWqCH=57ymy-BVd6xdJWc=WSqHAFyQXt-3MjchEAA@mail.gmail.com>
 <20191212094121.by7w7fywlzdfoktn@sirius.home.kraxel.org> <CAD=HUj6YYupjdxxz2mgMmE2DcKhXP-qdhRORvUNTmzcORRrLzg@mail.gmail.com>
 <20191212133048.4nbmuwhbq5z2ai6o@sirius.home.kraxel.org> <CAD=HUj623MyeZ7VmrYTfig9oiyNhipidpvhuuurs3VgGBgjZpQ@mail.gmail.com>
 <20191216134728.czulyb6yvrkokrqv@sirius.home.kraxel.org>
In-Reply-To: <20191216134728.czulyb6yvrkokrqv@sirius.home.kraxel.org>
From: David Stevens <stevensd@chromium.org>
Date: Tue, 17 Dec 2019 21:59:29 +0900
Message-ID: <CAD=HUj4us6_cEv40EVRLd5K5cGW7GsN10EFWifmog-pq9_RC8Q@mail.gmail.com>
Subject: Re: [virtio-dev] Re: guest / host buffer sharing ...
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Dylan Reid <dgreid@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Zach Reizner <zachr@chromium.org>, Geoffrey McRae <geoff@hostfission.com>, Keiichi Watanabe <keiichiw@chromium.org>, Dmitry Morozov <dmitry.morozov@opensynergy.com>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>, Gurchetan Singh <gurchetansingh@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, virtio-dev@lists.oasis-open.org, qemu-devel <qemu-devel@nongnu.org>
List-ID: <virtio-dev.lists.oasis-open.org>

> > > Of course only virtio drivers would try step (2), other drivers (when
> > > sharing buffers between intel gvt device and virtio-gpu for example)
> > > would go straight to (3).
> >
> > For virtio-gpu as it is today, it's not clear to me that they're
> > equivalent. As I read it, the virtio-gpu spec makes a distinction
> > between the guest memory and the host resource. If virtio-gpu is
> > communicating with non-virtio devices, then obviously you'd just be
> > working with guest memory. But if it's communicating with another
> > virtio device, then there are potentially distinct guest and host
> > buffers that could be used. The spec shouldn't leave any room for
> > ambiguity as to how this distinction is handled.
>
> Yep.  It should be the host side buffer.

I agree that it should be the host side buffer. I just want to make
sure that the meaning of 'import' is clear, and to establish the fact
that importing a buffer by uuid is not necessarily the same thing as
creating a new buffer in a different device from the same sglist (for
example, sharing a guest sglist might require more flushes).

-David

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

