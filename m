Return-Path: virtio-dev-return-6310-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7DE89985D79
	for <virtio-dev@lists.oasis-open.org>; Mon, 11 Nov 2019 03:04:37 +0000 (UTC)
MIME-Version: 1.0
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org> <20191106084344.GB189998@stefanha-x1.localdomain>
In-Reply-To: <20191106084344.GB189998@stefanha-x1.localdomain>
From: David Stevens <stevensd@chromium.org>
Date: Mon, 11 Nov 2019 12:04:25 +0900
Message-ID: <CAD=HUj41r8wHZ2-By8tLftkoqC5r_Bw=pr=zX2aZ7GTs1ESWhg@mail.gmail.com>
Subject: [virtio-dev] Re: guest / host buffer sharing ...
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Keiichi Watanabe <keiichiw@chromium.org>, geoff@hostfission.com, virtio-dev@lists.oasis-open.org, Alex Lau <alexlau@chromium.org>, Alexandre Courbot <acourbot@chromium.org>, qemu-devel@nongnu.org, Tomasz Figa <tfiga@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Dylan Reid <dgreid@chromium.org>, Gurchetan Singh <gurchetansingh@chromium.org>, Dmitry Morozov <dmitry.morozov@opensynergy.com>, Pawel Osciak <posciak@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

> My question would be "what is the actual problem you are trying to
> solve?".

One problem that needs to be solved is sharing buffers between
devices. With the out-of-tree Wayland device, to share virtio-gpu
buffers we've been using the virtio resource id. However, that
approach isn't necessarily the right approach, especially once there
are more devices allocating/sharing buffers. Specifically, this issue
came up in the recent RFC about adding a virtio video decoder device.

Having a centralized buffer allocator device is one way to deal with
sharing buffers, since it gives a definitive buffer identifier that
can be used by all drivers/devices to refer to the buffer. That being
said, I think the device as proposed is insufficient, as such a
centralized buffer allocator should probably be responsible for
allocating all shared buffers, not just linear guest ram buffers.

-David

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

