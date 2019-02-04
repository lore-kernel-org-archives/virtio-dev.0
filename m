Return-Path: virtio-dev-return-5368-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CD4CD985A3D
	for <virtio-dev@lists.oasis-open.org>; Mon,  4 Feb 2019 10:18:44 +0000 (UTC)
MIME-Version: 1.0
References: <CAOGAQepUKjQuqJ9o4_bTwCjT-dJO9=eMBevvrULUW3KgieoXHg@mail.gmail.com>
 <20190204054053.GE29758@stefanha-x1.localdomain> <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
In-Reply-To: <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
From: Roman Kiryanov <rkir@google.com>
Date: Mon, 4 Feb 2019 02:18:31 -0800
Message-ID: <CAOGAQeosJL2_P5kU0b4F-gbZZxpPW+=abFj3yDKDRBZ5WMRbQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [virtio-dev] Memory sharing device
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> > David Gilbert, Gerd Hoffmann, and I have discussed adding shared memory
> > resources to VIRTIO.  That means memory made available by the device to
> > the driver instead of the usual other way around.
> >
> > virtio-gpu needs this and perhaps that use case overlaps with yours too.
>
> virtio-gpu specifically needs that to support vulkan and opengl
> extensions for coherent buffers, which must be allocated by the host gpu
> driver.  It's WIP still.

Thank you, Stefan and Gerd for looking into it. Yes, Vulkan is our
first use case
for the memory sharing device.

I will take a look to the draft Stefan provided to see how it is
different from what we
are thinking about.

Regards,
Roman.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

