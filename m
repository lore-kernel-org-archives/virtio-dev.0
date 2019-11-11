Return-Path: virtio-dev-return-6313-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0C46E985D79
	for <virtio-dev@lists.oasis-open.org>; Mon, 11 Nov 2019 15:36:48 +0000 (UTC)
Message-ID: <c8a6b6f35664ce036c2a48ec41eab97b0f40704d.camel@linux.intel.com>
From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Date: Mon, 11 Nov 2019 15:36:38 +0000
In-Reply-To: <CAD=HUj41r8wHZ2-By8tLftkoqC5r_Bw=pr=zX2aZ7GTs1ESWhg@mail.gmail.com>
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
	 <20191106084344.GB189998@stefanha-x1.localdomain>
	 <CAD=HUj41r8wHZ2-By8tLftkoqC5r_Bw=pr=zX2aZ7GTs1ESWhg@mail.gmail.com>
Mime-Version: 1.0
Subject: Re: [virtio-dev] Re: guest / host buffer sharing ...
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: David Stevens <stevensd@chromium.org>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Keiichi Watanabe <keiichiw@chromium.org>, geoff@hostfission.com, virtio-dev@lists.oasis-open.org, Alex Lau <alexlau@chromium.org>, Alexandre Courbot <acourbot@chromium.org>, qemu-devel@nongnu.org, Tomasz Figa <tfiga@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>, =?ISO-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, Dylan Reid <dgreid@chromium.org>, Gurchetan Singh <gurchetansingh@chromium.org>, Dmitry Morozov <dmitry.morozov@opensynergy.com>, Pawel Osciak <posciak@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 2019-11-11 at 12:04 +0900, David Stevens wrote:
> Having a centralized buffer allocator device is one way to deal with
> sharing buffers, since it gives a definitive buffer identifier that
> can be used by all drivers/devices to refer to the buffer. That being
> said, I think the device as proposed is insufficient, as such a
> centralized buffer allocator should probably be responsible for
> allocating all shared buffers, not just linear guest ram buffers.

This would work for audio. I need to be able to :-

1) Allocate buffers on guests that I can pass as SG physical pages to
DMA engine (via privileged VM driver) for audio data. Can be any memory
as long as it's DMA-able.

2) Export hardware mailbox memory (in a real device PCI BAR) as RO to
each guest to give guests low latency information on each audio stream.
To support use cases like voice calls, gaming, system notifications and
general audio processing.

Liam


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

