Return-Path: virtio-dev-return-6907-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9988A985BF2
	for <virtio-dev@lists.oasis-open.org>; Mon,  9 Mar 2020 17:42:43 +0000 (UTC)
References: <874kv15o4q.fsf@linaro.org>
 <20200309154637.GJ7668@stefanha-x1.localdomain>
 <CAMHO8so2zuDS5BjATchFpYk_4Qy4aG76L51qmCg7qkPPfNwmFA@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAMHO8so2zuDS5BjATchFpYk_4Qy4aG76L51qmCg7qkPPfNwmFA@mail.gmail.com>
Date: Mon, 09 Mar 2020 17:42:39 +0000
Message-ID: <87v9ndifw0.fsf@linaro.org>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Backend libraries for VirtIO device emulation
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Srivatsa Vaddagiri <vatsa.ml@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>


Srivatsa Vaddagiri <vatsa.ml@gmail.com> writes:

> On Mon, Mar 9, 2020 at 9:16 PM Stefan Hajnoczi <stefanha@redhat.com> wrot=
e:
>>
>> That already exists today.  Pick a vhost-user device implementation from
>> QEMU, DPDK/SPDK, or rust-vmm and run it with your VMM of choice.
>>
>> > backend be emulated purely with some shared memory and some sockets fo=
r
>> > passing messages/kicks from/to the VMM which then deals with the hyper=
visor
>> > specifics of the virtio-transport?
>>
>> Yes, that is what vhost-user does.
>
> Are there vhost-user based backends that emulates block and console devic=
es?
>
> From my quick read, vhost-user seems to depend on having backend complete=
 access
> to front-end's memory. Is that true? We are looking for a backend solutio=
n that
> does not assume access to whole of front-end memory. Only the memory regi=
ons
> hosting IO buffers need to be ideally shared between the two VMs.

I think it currently is true because generally the pointers passed in
the virtqueues are directly into the various internal structures of the
kernel (e.g. pagecache, skb etc.).

Now for linux the are ways of declaring particular buffers to be in
specific locations - ostensibly for things like DMA-ability. But AFAICT
there is no mechanism to communicate the particular locations to be used
to the VMM and backend daemon.

> Also the
> mechanism of memory sharing and signalling between VMs could be very
> hypervisor specific.
> Does vhost-user allow for such hyp-specific memory sharing and
> signalling interfaces?

The daemons I've looked at so far are passed a shm fd and a control fd
from the VMM. From their point of view it's just posix shared memory and
a event queue via a socket. Setting that up is the VMMs problem.

>
> - vatsa


--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

