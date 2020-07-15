Return-Path: virtio-dev-return-7556-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CB38698605B
	for <virtio-dev@lists.oasis-open.org>; Wed, 15 Jul 2020 17:25:18 +0000 (UTC)
References: <87r1tdydpz.fsf@linaro.org>
 <20200715114855.GF18817@stefanha-x1.localdomain>
 <877dv4ykin.fsf@linaro.org>
 <20200715154732.GC47883@stefanha-x1.localdomain>
 <20200715190147.05e71272.cohuck@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20200715190147.05e71272.cohuck@redhat.com>
Date: Wed, 15 Jul 2020 18:25:14 +0100
Message-ID: <87tuy8wv0l.fsf@linaro.org>
MIME-Version: 1.0
Subject: Re: [virtio-dev] On doorbells (queue notifications)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Cornelia Huck <cohuck@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, Zha Bin <zhabin@linux.alibaba.com>, Jing
 Liu <jing2.liu@linux.intel.com>, Chao Peng <chao.p.peng@linux.intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>


Cornelia Huck <cohuck@redhat.com> writes:

> On Wed, 15 Jul 2020 16:47:32 +0100
> Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
>> On Wed, Jul 15, 2020 at 02:29:04PM +0100, Alex Benn=C3=A9e wrote:
>> > Stefan Hajnoczi <stefanha@redhat.com> writes: =20
>> > > On Tue, Jul 14, 2020 at 10:43:36PM +0100, Alex Benn=C3=A9e wrote: =
=20
>> > >> Finally I'm curious if this is just a problem avoided by the s390
>> > >> channel approach? Does the use of messages over a channel just avoi=
d the
>> > >> sort of bouncing back and forth that other hypervisors have to do w=
hen
>> > >> emulating a device? =20
>> > >
>> > > What does "bouncing back and forth" mean exactly? =20
>> >=20
>> > Context switching between guest and hypervisor. =20
>>=20
>> I have CCed Cornelia Huck, who can explain the lifecycle of an I/O
>> request on s390 channel I/O.
>
> Having read through this thread, I think this is mostly about
> notifications?

Yes - as I understand it they are the only things that really cause a
context switch between guest/hypervisor/host.

> These are not using channel programs (which are only
> used for things like feature negotiation, or emulating reading/writing
> a config space, which does not really exist for channel devices.)
>
> First, I/O and interrupts are highly abstracted on s390; much of the
> register accesses or writes done on other architectures is just not
> seen on s390.
>
> Traditionally, I/O interrupts on s390 are tied to a subchannel; you
> have a rather heavyweight process for that:
>
> guest=09=09=09=09=09=09=09=09host
>
> =09=09=09=09=09put status into subchannel
> =09=09=09=09=09queue interrupt
> open up for I/O interrupt
> =09=09=09=09=09store some data into lowcore
> =09=09=09=09=09do PSW swap
> interrupt handler called
> read from lowcore
> call tsch for subchannel
> =09=09=09=09=09store subchannel status into
> =09=09=09=09=09control block
> process control block
> look at subchannel indicators
> virtio queue processing
>
> This is only used for configuration change notifications, or for very
> old legacy virtio implementations.
>
> There's an alternative mechanism not tied to a subchannel, called
> 'adapter interrupts'. (It is even used to implement MSI-X on s390x,
> which is why only virtio-pci devices using MSI-X are supported on
> s390x.) It uses two-staged indicators: a global indicator to show
> whether any secondary indicator is set, and secondary indicators (which
> are per virtqueue in the virtio case.)
>
> guest=09=09=09=09=09=09=09=09host
>
> =09=09=09=09=09set queue indicator(s)
> =09=09=09=09=09set global indicator
> =09=09=09=09=09queue interrupt iff global
> =09=09=09=09=09indicator had not been set
> open up for I/O interrupt
> =09=09=09=09=09store some data into lowcore
> =09=09=09=09=09do PSW swap
> interrupt handler called
> read from lowcore
> look at indicators
> virtio queue processing
>
> This has less context switches than traditional I/O interrupts; but I
> think the main benefit comes from the ability to batch notifications:
> as long as the guest is still processing indicators, the host does not
> need to notify again, it can just set indicators (which is why the
> guest always needs to do two passes at processing.) We can already
> batch per-device indicators with the classic approach, but adapter
> interrupts allow to batch even across many devices.

Thanks for the explanation.

I'm curious why the data that's going to be read from lowcore isn't
loaded before the guest opens up (is this the same as unmasking?) for
the interrupt? Is this because the host has to set up the guest IRQ
itself?

--=20
Alex Benn=C3=A9e

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

