Return-Path: virtio-dev-return-5373-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2AB56985C1E
	for <virtio-dev@lists.oasis-open.org>; Tue,  5 Feb 2019 21:06:56 +0000 (UTC)
MIME-Version: 1.0
References: <CAOGAQepUKjQuqJ9o4_bTwCjT-dJO9=eMBevvrULUW3KgieoXHg@mail.gmail.com>
 <20190204054053.GE29758@stefanha-x1.localdomain> <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
 <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com> <20190205100427.GA2693@work-vm>
In-Reply-To: <20190205100427.GA2693@work-vm>
From: Roman Kiryanov <rkir@google.com>
Date: Tue, 5 Feb 2019 13:06:42 -0800
Message-ID: <CAOGAQeq-djsO=goRsHHz22Zrker8iDqucD30-cEXPt8pVQe1Hg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [virtio-dev] Memory sharing device
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, Lingfeng Yang <lfy@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Dave,

> In virtio-fs we have two separate stages:
>   a) A shared arena is setup (and that's what the spec Stefan pointed to is about) -
>      it's statically allocated at device creation and corresponds to a chunk
>      of guest physical address space

We do exactly the same:
https://android.googlesource.com/platform/external/qemu/+/emu-master-dev/hw/pci/goldfish_address_space.c#659

>   b) During operation the guest kernel asks for files to be mapped into
>      part of that arena dynamically, using commands sent over the queue
>      - our queue carries FUSE commands, and we've added two new FUSE
>      commands to perform the map/unmap.  They talk in terms of offsets
>      within the shared arena, rather than GPAs.

In our case we have no files to map, only pointers returned from
OpenGL or Vulkan.
Do you have the approach to share for this use case?

> How do you transmit the glMapBufferRange command from QEMU driver to
> host?

In December we did this by passing these bits over our guest-host channel
(another driver, goldfish_pipe). Frank is currently working on moving
this into our memory
mapping device as "something changed in the memory you shared".

Do you this it is possible to have virtio-pipe where we could send
arbitrary blobs between
guest and host? We want to move all our drivers into userspace so we
could share memory
using the device you are currently working on and this virtio-pipe to
pass MMIOs and IRQs
to control our devices to avoid dealing with kernel drivers at all.

Thank you.

Regards,
Roman.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

