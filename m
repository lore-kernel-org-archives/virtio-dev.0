Return-Path: <virtio-dev-return-8773-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8BB599862D3
	for <virtio-dev@lists.oasis-open.org>; Mon,  4 Oct 2021 15:39:00 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <PH0PR12MB548116BD0816E447A3F2CDDDDCAB9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20210930091759.525267-1-parav@nvidia.com>
 <87y27d2bup.fsf@redhat.com>
 <PH0PR12MB548116BD0816E447A3F2CDDDDCAB9@PH0PR12MB5481.namprd12.prod.outlook.com>
Date: Mon, 04 Oct 2021 17:38:47 +0200
Message-ID: <8735pg3im0.fsf@redhat.com>
MIME-Version: 1.0
Subject: RE: [virtio-dev] [PATCH] Add device reset timeout field
Content-Type: text/plain
To: Parav Pandit <parav@nvidia.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Oct 01 2021, Parav Pandit <parav@nvidia.com> wrote:

>> From: Cornelia Huck <cohuck@redhat.com>
>> Sent: Friday, October 1, 2021 5:31 PM
>> 
>> On Thu, Sep 30 2021, Parav Pandit <parav@nvidia.com> wrote:
>> 
> [..]
>
>> > +Once the driver initiates a reset, the device may not be able to
>> > +finish the reset immediately. Such device provides a hint to the
>> > +driver about how long a device may take to complete the reset. Driver
>> > +should wait at least for the time specified by the device to let
>> > +device finish the reset or if the device status field to become 0 within the
>> specified time interval.
>> 
>> Would such a timeout also apply to the virtqueue reset that is discussed
>> elsewhere on the virtio lists?
>> 
> No. I haven't read that thread fully but device reset timeout is not intent to solve all the timeouts.
> It is intent to have the specific purpose described in this proposal.

Ok. I guess if we want to specify some more generic timeout handling in
the future, the device is free to use the same timeout everywhere it
makes sense.

>
>> Can transports specify what can actually time out? For example, for an
>> asynchronous transport like ccw, it might make sense to have the timeout
>> apply to the interrupt that is supposed to come in for the RESET command (the
>> driver then can try to terminate the running command, if desired.)
>> 
>> > +Such driver initialization sequence specified in \ref{sec:General
>> > +Initialization And Device Operation / Device Initialization}.
>> 
>> I'm sorry, I don't parse that statement.
> It is similar statement that exists in "Driver Requirements" section as first line.
> Do you mean I should rewrite above sentence or?

The sentence seems to be missing a verb?

>
>> 
>> > +
>> >  \devicenormative{\subsection}{Device Status Field}{Basic Facilities
>> > of a Virtio Device / Device Status Field}
>> >
>> >  The device MUST NOT consume buffers or send any used buffer @@
>> > -210,11 +219,20 @@ \section{Device Reset}\label{sec:Basic Facilities
>> > of a Virtio Device / Device Re  indicating completion of the reset by
>> > reinitializing \field{device status}  to 0, until the driver re-initializes the
>> device.
>> >
>> > +A device may not be able to complete reset action when the driver initiates
>> a reset operation.
>> > +Such a device should provide the hint as to how long a device may take to
>> finish the reset operation.
>> > +This hint is provided by the device using device reset timeout field in units
>> of 10 milliseconds.
>> 
>> Is this supposed to go into the device config space? Or can each transport
>> decide how to expose the value?
>>
> Isn't each transport define how a config space is accessible?
> In this proposal for PCI it is part of the struct virtio_pci_common_cfg.

Yes; therefore my question. Should we agree about putting it into the
config space, or does it make more sense to leave the actual mechanism
to the transport?

>
>  > > +
>> >  \drivernormative{\subsection}{Device Reset}{Basic Facilities of a
>> > Virtio Device / Device Reset}
>> >
>> >  The driver SHOULD consider a driver-initiated reset complete when it
>> > reads \field{device status} as 0.
>> >
>> > +When a device reports a non-zero device reset timeout value, the
>> > +driver SHOULD wait for the device to finish the reset action during
>> > +the initialization sequence before giving up on the device. When
>> > +device reset timeout is not provided by the device, driver SHOULD choose a
>> reasonable timeout value for reset operation to complete.
>> 
>> Is the driver allowed to not time the reset action out at all?
>> 
> Which is what is being done by the Linux driver today.
> Not sure I follow the question.
> As virtio spec follows RFC 2119, driver is recommended to time the reset with above text description.

Yes, it does make sense use a timeout; but should we note explicitly
that there's no requirement for the driver to use any kind of timeout
mechanism if it didn't negotiate the feature? Or drop that statement
completely, and let the driver continue to do whatever it is doing right
now?

>
>> What does "giving up on the device" imply? 
> I should probably better write it as " action during the initialization sequence before declaring the device as unable_to_reset".

Maybe "before considering the reset operation to have failed"?

>
>> Can the driver perform some
>> recovery actions (e.g for ccw, the driver may be able to terminate the running
>> reset command and re-try)?
>>
> Will that retry help to recover the device? If so, what is the new operation that helps in recovery?

It is about the communication mechanism, not the action; we can abort
the communication mechanism for the command and re-try the same command
again, if there's anything that caused the command to not be properly
transmitted or so. The mechanism for that is probably different enough
from the read/write operations used by pci or mmio.

>  
>> What about a reset that is done outside of the initialization sequence?
> In general reset leads to device re-initialization. Isn't it?
> Can a virtio device be reset without initialization or re-initialization?

I don't think we say anywhere that the driver must start to
re-initialize the device again if it did a reset. It's probably best to
simply drop any references to the initialization sequence; the timeout
should apply to any reset initiated by the driver, regardless of its
purpose/usefulness.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

