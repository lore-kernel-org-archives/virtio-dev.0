Return-Path: virtio-dev-return-5369-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4298C985B81
	for <virtio-dev@lists.oasis-open.org>; Tue,  5 Feb 2019 07:42:40 +0000 (UTC)
MIME-Version: 1.0
References: <CAOGAQepUKjQuqJ9o4_bTwCjT-dJO9=eMBevvrULUW3KgieoXHg@mail.gmail.com>
 <20190204054053.GE29758@stefanha-x1.localdomain> <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
In-Reply-To: <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
From: Roman Kiryanov <rkir@google.com>
Date: Mon, 4 Feb 2019 23:42:25 -0800
Message-ID: <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [virtio-dev] Memory sharing device
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Lingfeng Yang <lfy@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Gerd,

> virtio-gpu specifically needs that to support vulkan and opengl
> extensions for coherent buffers, which must be allocated by the host gpu
> driver.  It's WIP still.

the proposed spec says:

+Shared memory regions MUST NOT be used to control the operation
+of the device, nor to stream data; those should still be performed
+using virtqueues.

Is there a strong reason to prohibit using memory regions for control purposes?
Our long term goal is to have as few kernel drivers as possible and to move
"drivers" into userspace. If we go with the virtqueues, is there
general a purpose
device/driver to talk between our host and guest to support custom hardware
(with own blobs)? Could you please advise if we can use something else to
achieve this goal?

I saw there were registers added, could you please elaborate how new address
regions are added and associated with the host memory (and backwards)?

We allocate a region from the guest first and pass its offset to the
host to plug
real RAM into it and then we mmap this offset:

https://photos.app.goo.gl/NJvPBvvFS3S3n9mn6

Thank you.

Regards,
Roman.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

