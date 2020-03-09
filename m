Return-Path: virtio-dev-return-6906-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 231AC985BF2
	for <virtio-dev@lists.oasis-open.org>; Mon,  9 Mar 2020 17:27:41 +0000 (UTC)
MIME-Version: 1.0
References: <874kv15o4q.fsf@linaro.org> <20200309154637.GJ7668@stefanha-x1.localdomain>
In-Reply-To: <20200309154637.GJ7668@stefanha-x1.localdomain>
From: Srivatsa Vaddagiri <vatsa.ml@gmail.com>
Date: Mon, 9 Mar 2020 22:57:01 +0530
Message-ID: <CAMHO8so2zuDS5BjATchFpYk_4Qy4aG76L51qmCg7qkPPfNwmFA@mail.gmail.com>
Subject: Re: [virtio-dev] Backend libraries for VirtIO device emulation
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Mar 9, 2020 at 9:16 PM Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> That already exists today.  Pick a vhost-user device implementation from
> QEMU, DPDK/SPDK, or rust-vmm and run it with your VMM of choice.
>
> > backend be emulated purely with some shared memory and some sockets for
> > passing messages/kicks from/to the VMM which then deals with the hyperv=
isor
> > specifics of the virtio-transport?
>
> Yes, that is what vhost-user does.

Are there vhost-user based backends that emulates block and console devices=
?

From my quick read, vhost-user seems to depend on having backend complete a=
ccess
to front-end's memory. Is that true? We are looking for a backend solution =
that
does not assume access to whole of front-end memory. Only the memory region=
s
hosting IO buffers need to be ideally shared between the two VMs. Also the
mechanism of memory sharing and signalling between VMs could be very
hypervisor specific.
Does vhost-user allow for such hyp-specific memory sharing and
signalling interfaces?

- vatsa

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

