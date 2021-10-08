Return-Path: <virtio-dev-return-8817-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B8482986560
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 Oct 2021 10:01:01 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <PH0PR12MB5481CEA27B18421BB8432AD6DCB19@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211006141033.612283-1-parav@nvidia.com>
 <20211006111143-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811E06DAED3F7D60955A84DCB09@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211006163309-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481990F6F33697BB2F9B6D4DCB19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87zgrkyfwn.fsf@redhat.com>
 <PH0PR12MB5481CEA27B18421BB8432AD6DCB19@PH0PR12MB5481.namprd12.prod.outlook.com>
Date: Fri, 08 Oct 2021 12:00:53 +0200
Message-ID: <87r1cvygx6.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v2] Add device reset timeout field
Content-Type: text/plain
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Oct 07 2021, Parav Pandit <parav@nvidia.com> wrote:

>> From: Cornelia Huck <cohuck@redhat.com>
>> Sent: Thursday, October 7, 2021 9:41 PM
>> On Thu, Oct 07 2021, Parav Pandit <parav@nvidia.com> wrote:
>> 
>> >> From: Michael S. Tsirkin <mst@redhat.com>
>> >> Sent: Thursday, October 7, 2021 2:23 AM On Wed, Oct 06, 2021 at
>> >> 04:11:19PM +0000, Parav Pandit wrote:
>> >> >
>> >> > > From: Michael S. Tsirkin <mst@redhat.com>
>> >> > > Sent: Wednesday, October 6, 2021 8:52 PM
>> 
>> >> > > second, I don't see a story around compatibility here.
>> >> > Device reset timeout is supported only when device offers the new
>> >> VIRTIO_DEV_RESET_TIMEOUT.
>> >> > When such feature is not offered, driver follows the guidance
>> >> > provided in
>> >> this proposal.
>> >> > Compatibility is covered with the feature bit.
>> >>
>> >> Well hmm. Problem is, devices need to be reset before feature bits are read.
>> >>
>> > Yeah, this means that we should remove the feature bit and instead
>> > follow your suggestion that if the register value is zero, the feature is not
>> offered, If it is non zero, driver should follow the timeout.
>> 
>> What about old devices -- they don't provide the timeout value at all,
>> obviously; how can they stay compliant?
>>
> If the old device which doesn't provide a timeout, the newer version of the spec suggests that driver chooses a reasonable value.

If we don't guard the new field via a feature bit, the driver will try
to access something that does not exist for older devices. If we say
that the field exists, older devices are simply not compliant.

Now, the interaction with the feature bit is obviously a problem... it
would mean that the driver can only find out what the device offers too
late in the initial startup sequence. We could specify that the field
may or may not exist, but that might lead to other problems down the
road.

>  
>> >
>> >> > > previously pci drivers did wait, other drivers didn't.
>> >> > >
>> >> > The newer driver that implements updated spec, will adhere to newer
>> >> content of the spec.
>> >>
>> >> right but we can't just unconditionally say driver must wait, this
>> >> would declare old driver non-compliant and we promised not to do that.
>> >>
>> > It is not said unconditionally. It comes with spec version, isn't it?
>> > This change should increment the spec version so old driver are compliant to
>> some older version of the spec.
>> > Hence, there is no breakage with some old driver.
>> 
>> We do not really say that a driver or a device is conforming to a certain version
>> of the spec, though. If it has been written to an older version of the spec, I still
>> expect it to be compliant, it's just not implementing some newer things.
>>
> The only way a older driver following older spec can be compliant to newer spec, if the new spec remains same as old spec. :-)

Eh, no. We just need to make new features optional. A driver written to
an older version of the spec that does not implement e.g. packed ring is
still compliant, since packed ring is guarded by a feature bit.

> However, the spec is suggesting to have finite timeout as "SHOULD".
> Timeout is not part of the conformance _must_ clause.
> So if old driver not following "SHOULD" suggestion of newer spec, does it make old driver non-compliant?
> Your input on this will help me understand the conformance part.

This depends upon how we introduce the new feature. If (as had been
suggested upthread) we ditch the feature bit, we specify that the driver
needs to do something (read the value) which an old driver simply won't
do. The only way that can work is if we make it optional for the driver
to read the timeout value. So yes, a driver not following a SHOULD
clause is still compliant. We need to be careful as to what we actually
require; normally, feature bits solve this neatly, but it seems
problematic here.

>
>> (...)
>> 
>> >> > > Third how about making e.g. 0 a special value meaning no limit
>> >> > > wait
>> >> forever?
>> >> > The whole idea is to have some finite/deterministic behavior,
>> >>
>> >> I guess I'm being dense, I just don't yet understand the motivation.
>> >> The cost is difficulty in migration since each and every piece of
>> >> hardware will have a different timeout.
>> >>
>> > Such timeout is already there. Advertising timeout doesn't change the LM
>> flow.
>> > A migrating device at the destination is anyway out of the reset when
>> migration occurs.
>> 
>> But it introduces values that may be different between different devices of the
>> same type, no? I guess the destination would need to re-read the value to get
>> the current one. Not an insurmountable problem, but still needs some care.
>>
> When a device migrates to destination, it starts from where the device left off on the source side.
> So yes, destination side, device must be usable (out of reset), and after that its current state will be overwritten by the migrating device.
> If you ask, does migration overwrite the reset timeout register value? I would say no, because how long device would take to reset is decided by the destination side implementation.

Agreed on that, but the driver would need to know that it has to re-read
the timeout value. IOW, migration would either not be fully transparent,
or the destination device would need to have a timeout value that would
not conflict with the timeout value on the source device (i.e. if it is
significantly different).

>
> And this is probably yet another good reason to define migratable bits of a virtio device in the live migration spec extension.

Well yes, live migration is certainly a problem we need to tackle.

>
>> >
>> >> The idea is to have finite behaviour, I got that, but I don't really
>> >> know where does the requirement come from, in what sense it's
>> >> deterministic and why do we worry about reset specifically.
>> >>
>> >> Recovering from failure when hardware is broken?
>> >>
>> > I provided few examples in previous email.
>> > Terminating a probe sequence of the device which is already on its path of
>> hotunplug.
>> 
>> For that sequence, don't we need a timeout for *any* interaction with the
>> device? 
> We do need a command timeout that will handle hotunplug scenario while under probe.
> But handling command timeout has wider use, even without non racing hotunplug and plug sequences.
> So it is better to drive it as separate extension in itself, which is self-contained.

So, why is reset special in that case? As...

>
>> I thought this proposal was mainly about devices that take a long time
>> to "warm up"...
>>
> Yes, certainly this proposal covers such device scenario.
> In general, this proposal covers reset timeout as the register suggests.

...I do not really understand this, then. We want reset timeouts,
because they cover a certain scenario, but we don't want something more
general?

>
>> > VQ commands timeout handling is indeed needed but it is a separate
>> enhancement in itself.
>> > This one is self-contained enough that doesn't need to combined with
>> command timeout.
>> 
>> What about e.g. config writes; I think they might trigger some actions?
>>
> A driver can do config writes to the PCI virtio device without reset is complete.
> This is very common practice that driver follows to discover device properties.
> It may trigger some action on the device, but PCI device is obligated to respond to it for host driver to function properly.

But isn't that in violation of the spec? I understand it needs to do
reset -> (wait until complete) -> set ACKNOWLEDGE status -> set DRIVER
status -> potentially *read* the config space -> set FEATURES_OK
and only then *write* to the config space?

As an aside, not all transports even allow accessing the config space
while reset is still in progress. I would naively have expected that to
be the norm.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

