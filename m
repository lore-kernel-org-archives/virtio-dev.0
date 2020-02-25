Return-Path: virtio-dev-return-6780-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 232A6985D5F
	for <virtio-dev@lists.oasis-open.org>; Tue, 25 Feb 2020 15:55:17 +0000 (UTC)
References: <20200207182842.770bfb27@collabora.com>
 <20200225162105.1912fae0@collabora.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20200225162105.1912fae0@collabora.com>
Date: Tue, 25 Feb 2020 15:55:12 +0000
Message-ID: <87y2sqy84f.fsf@linaro.org>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [RFC] Upstreaming virtio-wayland (or an alternative)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Zach Reizner <zachr@chromium.org>, David Stevens <stevensd@chromium.org>, =?utf-8?Q?St=C3=A9phane?= Marchesin <marcheu@chromium.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Tomasz
 Figa <tfiga@chromium.org>, Alexandros Frantzis <alexandros.frantzis@collabora.co.uk>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


Boris Brezillon <boris.brezillon@collabora.com> writes:

> Hi all,
>
> On Fri, 7 Feb 2020 18:28:42 +0100
> Boris Brezillon <boris.brezillon@collabora.com> wrote:
>
>> Hello everyone,
>>=20
>> I recently took over Tomeu's task of upstreaming virtio-wayland. After
>> spending quite a bit of time collecting information from his different
>> attempts [1][2] I wanted to sync with all the people that were involved
>> in the previous discussions (if I missed some of them, feel free to add
>> them back).
>>=20
>> The goal here is to get a rough idea of the general direction this
>> should take so I can start implementing a PoC and see if it fits
>> everyone's needs.
>>=20
>> virtio-wayland [3] started as a solution to pass wayland messages
>> between host and guests so the guest can execute wayland apps whose
>> surface buffers are passed to the wayland compositor running on the
>> host. While this was its primary use case, I've heard it's been used to
>> transport other protocols. And that's not surprising, when looking at
>> the code I noticed it was providing a protocol-agnostic message passing
>> interface between host and guests, similar to what VSOCK provides but
>> with FD passing as an extra feature.
>>=20
>> Based on all previous discussions, I could identify 3 different
>> approaches:
>>=20
>>     1/ Use VSOCK and extend it to support passing (some) FDs
>>     2/ Use a user space VSOCK-based proxy that's in charge of
>>        a/ passing regular messages
>>        b/ passing specific handles to describe objects shared
>>           between host and guest (most focus has been on dmabufs as
>>           this is what we really care about for the gfx use case,
>>           but other kind of FDs can be emulated through a
>>           VSOCK <-> UNIX_SOCK bridging)
>>     3/ Have a dedicated kernel space solution that provides features
>>        exposed by #1 but through a virtio device interface (basically
>>        what virtio-wayland does today)
>>=20
<snip>

> Option #1 sounds like a good idea on
> the paper, but the fact that Google wants a solution that does not
> involve vhost and given Gerd's concern about being able to use vsock
> in some cases and do !vsock message-passing in others, it might not be
> possible to use vsock (there can only be one vsock implementation
> active).

Forgive me for jumping in but what is the concern about vhost here? Is
it purely the increased attack surface to the kernel or some more
fundamental issue? Is this something that can be addressed with a
vhost-user backend where all the complications of the host end are dealt
with in user-space?

> That leaves us with option #3: have a dedicated virtio device
> providing a message+FD passing interface.
>
> So, I'm about to start working on virtio-pipe (I realize the name is
> not that great since pipes are normally unidirectional, but I'm sure
> we'll have plenty of time to bikeshed on that particular aspect once
> the other bits are sorted out :)). This device would be a singleton
> (there can only be one per VM), and would provide the following
> features:
>
> * allow you to connect to named/public pipes (similar to named unix
>   sockets). That's an easy way to expose host services to guests, and
>   AFAICT, that's not so far from the virtio-wayland way of doing things
>   (VIRTWL_IOCTL_NEW_CTX_NAMED).
> * manage a central UUID <-> 'struct file' map that allows virtio-pipe
>   to convert FDs to UUIDs, pass UUIDs through a pipe and convert those
>   UUIDs back to FDs on the other end
>   - we need to expose an API to let each subsystem register/unregister
>     their UUID <-> FD mapping (subsystems are responsible for the UUID
>     creation/negotiation)
> * allow you to create private/unnamed pipes whose FDs can be passed to
>   the other end (that implies creating a UUID <-> FD mapping for each
>   unnamed pipe). This feature is here to allow unamed unix-socket <->
>   virtio-pipe bridging. AFAICT, that's what VIRTWL_IOCTL_NEW_CTX is
>   providing. Looks like virtio-wayland also provides support for actual
>   pipes (uni-directional msg-passing) with its VIRTWL_IOCTL_NEW_PIPE_*
>   ioctls, which we can always support at some point if we see the need.
>
> Once we have those basic building blocks in place, we can start
> patching virtio-gpu to create a UUID <-> FD mapping when a buffer is
> exported as a dmabuf (using the virtio-pipe public API). And this can
> easily be applied to any kind of FDs we want to share.
>
> Note that this solution could be extended to support FD passing on top
> of VSOCK if we ever need/want to. We'd only have to move the UUID <->
> FD map/API out of virtio-pipe (virtio-fd?) and let virtio-vsock use it.
>
> Gerd, Stefan, Zach, what do you think? Should I start looking into
> that, maybe work on a PoC and post it as an RFC, or do you see any
> problem making this proposal not possible/irrelevant.
>
> Any feedback is welcome!
>
> Thanks,
>
> Boris
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

