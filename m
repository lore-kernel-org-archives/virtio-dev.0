Return-Path: virtio-dev-return-8174-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6BF26986060
	for <virtio-dev@lists.oasis-open.org>; Mon, 24 May 2021 18:45:56 +0000 (UTC)
MIME-Version: 1.0
References: <CABATKF9Vjf1NE0EjToKfp=1aPcGieeny1k8rkfVv6BFZ=+b4sw@mail.gmail.com>
 <YJ07vrCt3thO5MM/@stefanha-x1.localdomain> <CABATKF_vRfnkybEyj-PejKYPud0=FNPscRJ9=ztKzWiySnyHVQ@mail.gmail.com>
 <YKu6IZjRlLUun6TJ@stefanha-x1.localdomain>
In-Reply-To: <YKu6IZjRlLUun6TJ@stefanha-x1.localdomain>
From: Hao Chen <chenhaosjtuacm@google.com>
Date: Mon, 24 May 2021 11:45:43 -0700
Message-ID: <CABATKF-a+V5CjBTANS-xW-zuC3zVpPcWiXkrfNFr1EaFGkdZhg@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] Add virtio parameter server device specification
Content-Type: text/plain; charset="UTF-8"
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Enrico Granata <egranata@google.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> Thanks for explaining. Would publishing a k-v store protocol spec for
> use with vsock?

Does "standard protocol over vsock" exist in virtio-spec? We can say
"we use this protocol on vsock for this device, and it works very
well", but I guess it is still different than writing it somewhere in
the spec.

On Mon, May 24, 2021 at 7:38 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Mon, May 17, 2021 at 12:28:14PM -0700, Hao Chen wrote:
> > > Can you share a bit about the reason for defining a new VIRTIO device
> > > instead of running an existing key-value store over virtio-vsock or
> > > virtio-net?
> >
> > The reason for defining a virtio-parameter-server device is we are interacting
> > with some devices in a "key-value store" pattern. For example, we interact with
> > "vehicle device" in Android using this pattern.
> >
> > Ad-hoc protocol over vsock to a k-v store works, but we want to
> > standardize these
> > types of devices so that the VM doesn't need to know the
> > vendor-specific key-value
> > protocols for a specific device implementation.
>
> Thanks for explaining. Would publishing a k-v store protocol spec for
> use with vsock? That way it's a well-known protocol that anyone wishing
> to use k-v store functionality can use.
>
> One nice effect of defining a protocol over vsock instead of a new
> VIRTIO device is that implementation could be as simple as a
> Python/Go/Rust/etc library that's easy to integrate into applications. A
> VIRTIO device is more low-level and complex, making it more costly for
> others to implement.
>
> Stefan

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

