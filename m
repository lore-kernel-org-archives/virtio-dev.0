Return-Path: virtio-dev-return-7570-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9822E98607B
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Jul 2020 09:41:48 +0000 (UTC)
Date: Thu, 16 Jul 2020 11:41:36 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20200716114136.6ccf6bb7.cohuck@redhat.com>
In-Reply-To: <20200715220457.65cb98c1.pasic@linux.ibm.com>
References: <87r1tdydpz.fsf@linaro.org>
	<20200715114855.GF18817@stefanha-x1.localdomain>
	<877dv4ykin.fsf@linaro.org>
	<20200715154732.GC47883@stefanha-x1.localdomain>
	<20200715190147.05e71272.cohuck@redhat.com>
	<87tuy8wv0l.fsf@linaro.org>
	<20200715220457.65cb98c1.pasic@linux.ibm.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] On doorbells (queue notifications)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, Zha Bin <zhabin@linux.alibaba.com>, Jing Liu <jing2.liu@linux.intel.com>, Chao Peng <chao.p.peng@linux.intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 15 Jul 2020 22:04:57 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Wed, 15 Jul 2020 18:25:14 +0100
> Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>=20
> >=20
> > Cornelia Huck <cohuck@redhat.com> writes:
> >  =20
> > > On Wed, 15 Jul 2020 16:47:32 +0100
> > > Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > > =20
> > >> On Wed, Jul 15, 2020 at 02:29:04PM +0100, Alex Benn=C3=A9e wrote: =
=20
> > >> > Stefan Hajnoczi <stefanha@redhat.com> writes:   =20
> > >> > > On Tue, Jul 14, 2020 at 10:43:36PM +0100, Alex Benn=C3=A9e wrote=
:   =20
> > >> > >> Finally I'm curious if this is just a problem avoided by the s3=
90
> > >> > >> channel approach? Does the use of messages over a channel just =
avoid the
> > >> > >> sort of bouncing back and forth that other hypervisors have to =
do when
> > >> > >> emulating a device?   =20
> > >> > >
> > >> > > What does "bouncing back and forth" mean exactly?   =20
> > >> >=20
> > >> > Context switching between guest and hypervisor.   =20
> > >>=20
> > >> I have CCed Cornelia Huck, who can explain the lifecycle of an I/O
> > >> request on s390 channel I/O. =20
> > >
> > > Having read through this thread, I think this is mostly about
> > > notifications? =20
> >=20
> > Yes - as I understand it they are the only things that really cause a
> > context switch between guest/hypervisor/host.
> >  =20
> > > These are not using channel programs (which are only
> > > used for things like feature negotiation, or emulating reading/writin=
g
> > > a config space, which does not really exist for channel devices.)
> > >
> > > First, I/O and interrupts are highly abstracted on s390; much of the
> > > register accesses or writes done on other architectures is just not
> > > seen on s390.
> > >
> > > Traditionally, I/O interrupts on s390 are tied to a subchannel; you
> > > have a rather heavyweight process for that:
> > >
> > > guest=09=09=09=09=09=09=09=09host
> > >
> > > =09=09=09=09=09put status into subchannel
> > > =09=09=09=09=09queue interrupt
> > > open up for I/O interrupt
> > > =09=09=09=09=09store some data into lowcore
> > > =09=09=09=09=09do PSW swap
> > > interrupt handler called
> > > read from lowcore
> > > call tsch for subchannel
> > > =09=09=09=09=09store subchannel status into
> > > =09=09=09=09=09control block
> > > process control block
> > > look at subchannel indicators
> > > virtio queue processing
> > >
> > > This is only used for configuration change notifications, or for very
> > > old legacy virtio implementations.
> > >
> > > There's an alternative mechanism not tied to a subchannel, called
> > > 'adapter interrupts'. (It is even used to implement MSI-X on s390x,
> > > which is why only virtio-pci devices using MSI-X are supported on
> > > s390x.) It uses two-staged indicators: a global indicator to show
> > > whether any secondary indicator is set, and secondary indicators (whi=
ch
> > > are per virtqueue in the virtio case.)
> > >
> > > guest=09=09=09=09=09=09=09=09host
> > >
> > > =09=09=09=09=09set queue indicator(s)
> > > =09=09=09=09=09set global indicator
> > > =09=09=09=09=09queue interrupt iff global
> > > =09=09=09=09=09indicator had not been set
> > > open up for I/O interrupt
> > > =09=09=09=09=09store some data into lowcore
> > > =09=09=09=09=09do PSW swap
> > > interrupt handler called
> > > read from lowcore
> > > look at indicators
> > > virtio queue processing
> > >
> > > This has less context switches than traditional I/O interrupts; but I
> > > think the main benefit comes from the ability to batch notifications:
> > > as long as the guest is still processing indicators, the host does no=
t
> > > need to notify again, it can just set indicators (which is why the
> > > guest always needs to do two passes at processing.) We can already
> > > batch per-device indicators with the classic approach, but adapter
> > > interrupts allow to batch even across many devices. =20
> >=20
> > Thanks for the explanation.
> >=20
> > I'm curious why the data that's going to be read from lowcore isn't
> > loaded before the guest opens up (is this the same as unmasking?) for =
=20
>=20
> You mean stored and not loaded, or?
>=20
> > the interrupt? Is this because the host has to set up the guest IRQ
> > itself?
> >  =20
>=20
> Hi Alex! IMHO Connie provided a detailed jet simplified and a little
> confusing description  of the process of taking an IO interrupt on s390,
> which is also called the interruption action.

Yeah, I tried to make this understandable by people without an s390
background. Not sure if I simplified too much while doing so :)

>=20
> A prerequisite for a CPU accepting an I/O interruption request is of
> course  the CPU being open for it (controls: PSW, CR6). And yes this is
> the masking/unmasking. The unmasking may or may not happen at the point
> indicated in the ascii figures by Connie, what is important the cpu is
> unmasked at that point. Right after the interruption action the
> execution resumes at the interruption handler, whose address was read
> (as a part of the interruption action) from the lowcore.

Right, the unmasking at that point was only to be able to explain what
is happening when I/O interrupts open up.

>=20
> In that sense, there is only one interrupt handler for IO, as there
> is only one new PSW slot in the lowcore. To figure out what sort of
> event or events correspond to the interruption. This IO interrupt handler
> looks at the so called IO interruption code. The IO interruption code
> tells us if this is a subchannel associated, or an adapter IO
> interruption.

To compare to unmasking on other platforms:

- The guest controls per vcpu whether it currently masks I/O interrupts
  in general or not. (The "interruption subclass" can give slightly
  more fine-grained control, including where interrupts for a specific
  device may go; I'm ignoring this for brevity.)
- The guest can register one I/O interrupt handler per vcpu. If an I/O
  interrupt arrives, more information is available in a fixed per-cpu
  location.
- The guest can enable/disable any subchannel (and therefore, the
  device), but while it is enabled, interrupts/status pending for it
  are always possible, they cannot be masked off.

The guest can certainly set up different handlers for different vcpus,
and it may decide to never enable I/O interrupts for a certain vcpu
(e.g. to limit interrupt processing to a single vcpu); Linux uses the
same handler everywhere, and any vcpu may be enabled for I/O interrupts.

Another thing that might not be obvious: The host can pick *any* vcpu
currently enabled for I/O interrupts, but a specific interrupt will
only be delivered once.

>=20
> If subchannel associated then, the interruption code also tells us which
> subchannel is asking for attention.
>=20
> If adapter interruption, further information is found (e.g.
> interruption subclass) that may allow us (the guest) to limit the amount
> of processing needed in order to figure out what events are associated
> with this interruption. We may not need to scan all the indicator bits
> (used by the
> guest).

The guest has quite a high level of control on how it wants to set up
adapter interrupts, this may vary from OS to OS. I think the important
point is that it can reduce interrupts by not asking for them as long
it is still processing the last one -- and that this processing may
include looking at many places that might create events, like many
virtqueues that the host notifies for.

>=20
> The interruption code is in turn stored by the interruption action,
> might be executed by the hypervisor (is executed by the hypervisor for
> subchannel interrupts, and may or may not be for adapter interrupts), and
> must not happen if the cpu can not take the interruption, because it is
> masked.
>=20
> Regarding the number of context switches, if adapter interrupts are used,
> if everything goes well even host->guest queue notifications that involve
> an interrupt are done without getting a VCPU out of SIE (roughly
> corresponds to VM EXIT) thanks to the mechanism
> called GISA. But that is very s390 specific.

ISTR that there has been work on exitless interrupts for other
architectures as well. If you have any possibility to request hardware
support for this, it is probably a good idea to do so :)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

