Return-Path: virtio-dev-return-4942-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 81EAD985D9F
	for <virtio-dev@lists.oasis-open.org>; Thu,  8 Nov 2018 12:16:36 +0000 (UTC)
References: <0f4e7431-3c87-f783-579a-7e9fe6bc20d2@solarflare.com>
 <20181105085337.GA9934@stefanha-x1.localdomain>
From: David Riddoch <driddoch@solarflare.com>
Message-ID: <6795ebb5-4f21-1274-fa35-b8354bc65049@solarflare.com>
Date: Thu, 8 Nov 2018 12:16:28 +0000
MIME-Version: 1.0
In-Reply-To: <20181105085337.GA9934@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [virtio-dev] Device-to-driver notification management for
 hardware implementations
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, Steve Pope <spope@solarflare.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 05/11/18 08:53, Stefan Hajnoczi wrote:
> On Wed, Sep 12, 2018 at 05:41:07PM +0100, David Riddoch wrote:
>> The VIRTIO_F_NOTIFICATION_DATA feature helps hardware implementations by
>> telling them directly how many descriptors are available in the ring, sa=
ving
>> speculative reads.=A0 There is a related issue with interrupts: As things
>> stand, after writing 'used' descriptors into the ring (packed or split) =
the
>> device has to read the event idx to determine whether a device-to-driver
>> notification (interrupt) is needed.
>>
>> It would be very helpful to a hardware implementation if the event idx c=
ould
>> be written directly to the device.=A0 Has anyone proposed an extension to
>> address this already?=A0 (I have some thoughts on how to do this if we d=
on't
>> have a proposal yet).
> Hi David,
> Has there been any further discussion on this topic?  It seems like a
> useful feature to have in VIRTIO.
Hi Stefan,

Thanks for the nudge, no further discussion.=A0 So here are my thoughts:

To provide context here is an outline of how drivers typically process=20
completions from a device.=A0 This applies to both para-virtualised and=20
real hardware.=A0 (I think we only need to worry about packed-ring).

 =A0=A0 disable_cb();
 =A0again:
 =A0=A0 while( budget_left && desc_is_used() )
 =A0=A0 =A0 handle_used();
 =A0=A0 if( budget_left &&enable_cb() )
 =A0=A0=A0=A0 goto again;

The budget stuff relates to napi polling, and isn't always there. But if=20
it is, and budget is exhausted, then an outer loop will invoke this code=20
again and so we don't want an interrupt.

In our current packed-ring design enable_cb() does roughly this:

 =A0=A0 enable_cb_packed() {
 =A0 =A0=A0 guest_mem->event_suppress =3D last_used_idx;
 =A0=A0=A0=A0 virtio_mb();
 =A0=A0=A0=A0 return desc_is_used();
 =A0=A0 }

This tells the device to raise an interrupt when moving used_idx over=20
the given idx.=A0 (And you can set that idx to a position further in the=20
ring if you're not interested in getting woken until a bunch of=20
descriptors have been consumed).

This design is unpleasant for hardware devices, because it forces them=20
to issue a read over the PCIe bus after writing used descriptors, in=20
order to determine whether an interrupt is needed. Such a read adds=20
complexity, adds overhead to the PCIe bus and memory system, and adds=20
latency.

In hardware devices interrupts are typically enabled like this:

 =A0=A0 enable_cb_hw() {
 =A0=A0 =A0 writel(last_used_idx, &dev_bar->int_en_doorbell);
 =A0=A0=A0=A0 return 0;
 =A0=A0 }

This tells the device to raise an interrupt once the descriptor at the=20
given index has been used.=A0 If it has already been used, then an=20
interrupt is raised immediately, else the interrupt is enabled and=20
raised after the used descriptor has been written.=A0 The race condition=20
is handled without having to check the ring again.=A0 Note that interrupts =

are fire-once: For each write to int_en_doorbell you get a single=20
interrupt, and disable_cb() is therefore a no-op.

When you emulate a device using this model, you get a vmexit every time=20
int_en_doorbell is written, which is expensive.=A0 Therefore this approach =

is not desirable when emulated.

So perhaps we should introduce an option to use this hardware-oriented=20
model.=A0 The problem is that with vDPA the implementation of a device can =

shift under the feet of a driver between hardware and emulation.=A0 We'd=20
like to get the best performance we can in both cases.

My proposal is that we add an option to use both models at the same=20
time.=A0 enable_cb() would become:

30 =A0 enable_cb_new() {
31 =A0 =A0 if( int_en_doorbell_enabled )
32 writel(last_used_idx, p_int_en_doorbell);
33 guest_mem->event_suppress =3D last_used_idx;
34 =A0=A0=A0 virtio_mb();
35 =A0=A0=A0 return desc_is_used();
36 =A0 }

p_int_en_doorbell it notionally a pointer into a memory mapping onto a=20
device BAR, and when backed by hardware that is exactly what it is (and=20
the information in the event suppression structure is ignored).=A0 But=20
when backed by an emulated device the p_int_en_doorbell mapping should=20
just point at normal host memory (which is otherwise unused).=A0 This=20
means that we avoid vmexits in the emulated case.

Comments?

David

--=20
David Riddoch  <driddoch@solarflare.com> -- Chief Architect, Solarflare


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

