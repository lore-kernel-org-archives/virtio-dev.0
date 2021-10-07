Return-Path: <virtio-dev-return-8813-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A14F498655A
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 Oct 2021 16:39:00 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <PH0PR12MB5481990F6F33697BB2F9B6D4DCB19@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20211006141033.612283-1-parav@nvidia.com>
 <20211006111143-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54811E06DAED3F7D60955A84DCB09@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211006163309-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481990F6F33697BB2F9B6D4DCB19@PH0PR12MB5481.namprd12.prod.outlook.com>
Date: Thu, 07 Oct 2021 18:10:32 +0200
Message-ID: <87zgrkyfwn.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v2] Add device reset timeout field
Content-Type: text/plain
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Oct 07 2021, Parav Pandit <parav@nvidia.com> wrote:

>> From: Michael S. Tsirkin <mst@redhat.com>
>> Sent: Thursday, October 7, 2021 2:23 AM
>> On Wed, Oct 06, 2021 at 04:11:19PM +0000, Parav Pandit wrote:
>> >
>> > > From: Michael S. Tsirkin <mst@redhat.com>
>> > > Sent: Wednesday, October 6, 2021 8:52 PM

>> > > second, I don't see a story around compatibility here.
>> > Device reset timeout is supported only when device offers the new
>> VIRTIO_DEV_RESET_TIMEOUT.
>> > When such feature is not offered, driver follows the guidance provided in
>> this proposal.
>> > Compatibility is covered with the feature bit.
>> 
>> Well hmm. Problem is, devices need to be reset before feature bits are read.
>>
> Yeah, this means that we should remove the feature bit and instead follow your suggestion that if the register value is zero, the feature is not offered,
> If it is non zero, driver should follow the timeout.

What about old devices -- they don't provide the timeout value at all,
obviously; how can they stay compliant?

>  
>> > > previously pci drivers did wait, other drivers didn't.
>> > >
>> > The newer driver that implements updated spec, will adhere to newer
>> content of the spec.
>> 
>> right but we can't just unconditionally say driver must wait, this would declare
>> old driver non-compliant and we promised not to do that.
>> 
> It is not said unconditionally. It comes with spec version, isn't it?
> This change should increment the spec version so old driver are compliant to some older version of the spec.
> Hence, there is no breakage with some old driver.

We do not really say that a driver or a device is conforming to a
certain version of the spec, though. If it has been written to an older
version of the spec, I still expect it to be compliant, it's just not
implementing some newer things.

(...)

>> > > Third how about making e.g. 0 a special value meaning no limit wait
>> forever?
>> > The whole idea is to have some finite/deterministic behavior,
>> 
>> I guess I'm being dense, I just don't yet understand the motivation.
>> The cost is difficulty in migration since each and every piece of hardware will
>> have a different timeout.
>>
> Such timeout is already there. Advertising timeout doesn't change the LM flow.
> A migrating device at the destination is anyway out of the reset when migration occurs.

But it introduces values that may be different between different devices
of the same type, no? I guess the destination would need to re-read the
value to get the current one. Not an insurmountable problem, but still
needs some care.

>  
>> The idea is to have finite behaviour, I got that, but I don't really know where
>> does the requirement come from, in what sense it's deterministic and why do
>> we worry about reset specifically.
>> 
>> Recovering from failure when hardware is broken?
>>
> I provided few examples in previous email.
> Terminating a probe sequence of the device which is already on its path of hotunplug.

For that sequence, don't we need a timeout for *any* interaction with
the device? I thought this proposal was mainly about devices that take a
long time to "warm up"...

>  
>> Can we even trust timeout values hardware gives us then?
>> 
> Sure, why not. Device usually going to provide the reset timeout value based on its backend implementation.
> If its completely broken device (driver can always do min() of timeout value given by device and its own).
>
>> What about a ton of other stuff like command vq commands timing out?
>>
> VQ commands timeout handling is indeed needed but it is a separate enhancement in itself.
> This one is self-contained enough that doesn't need to combined with command timeout.

What about e.g. config writes; I think they might trigger some actions?

>  
>> > and hence the reasonable finite value.
>> > When value is not specified, driver is expected to choose reasonable value
>> terminate the reset operation.
>> 
>> No one has any idea what's reasonable.
> I am sure a finite timeout in driver is reasonable than current infinite one.
> This is because it is making system more resilient to occasional device errors.
>
>> There's no reason for a driver to choose any value - it has nothing else to do.
>>
> At least for the devices that we are seeing, driver choosing a default value of 2 to 3 minutes is good enough and of course useful.
>
>> > Do you propose 0 as no limit to follow current driver behavior?
>> 
>> Or maybe 0 will make driver poll.
> Poll infinitely? Didn't follow the suggestion of 0.

Isn't polling vs waiting something that's inherently an implementation
choice for the driver? It's not like it can do something different if
the operation just does not finish.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

