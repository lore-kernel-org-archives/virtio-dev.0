Return-Path: virtio-dev-return-5386-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 120AF985C57
	for <virtio-dev@lists.oasis-open.org>; Mon, 11 Feb 2019 14:49:37 +0000 (UTC)
Date: Mon, 11 Feb 2019 09:49:31 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190211092943-mutt-send-email-mst@kernel.org>
References: <CAOGAQepUKjQuqJ9o4_bTwCjT-dJO9=eMBevvrULUW3KgieoXHg@mail.gmail.com>
 <20190204054053.GE29758@stefanha-x1.localdomain>
 <20190204101316.4e3e6rj32suwdmur@sirius.home.kraxel.org>
 <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOGAQeq3psE=FxnU9+T1G79Y8_9mb3H8LKXWXnzY5-kGcX6RBA@mail.gmail.com>
Subject: Re: [virtio-dev] Memory sharing device
To: Roman Kiryanov <rkir@google.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Lingfeng Yang <lfy@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 04, 2019 at 11:42:25PM -0800, Roman Kiryanov wrote:
> Hi Gerd,
> 
> > virtio-gpu specifically needs that to support vulkan and opengl
> > extensions for coherent buffers, which must be allocated by the host gpu
> > driver.  It's WIP still.
> 
> the proposed spec says:
> 
> +Shared memory regions MUST NOT be used to control the operation
> +of the device, nor to stream data; those should still be performed
> +using virtqueues.
> 
> Is there a strong reason to prohibit using memory regions for control purposes?

That's in order to make virtio have portability implications, such that if
people see a virtio device in lspci they know there's
no lock-in, their guest can be moved between hypervisors
and will still work.

> Our long term goal is to have as few kernel drivers as possible and to move
> "drivers" into userspace. If we go with the virtqueues, is there
> general a purpose
> device/driver to talk between our host and guest to support custom hardware
> (with own blobs)?

The challenge is to answer the following question:
how to do this without losing the benefits of standartization?

> Could you please advise if we can use something else to
> achieve this goal?

I am not sure what the goal is though. Blobs is a means I guess
or it should be :) E.g. is it about being able to iterate quickly?

Maybe you should look at vhost-user-gpu patches on qemu?
Would this address your need?
Acks for these patches would be a good thing.


-- 
MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

