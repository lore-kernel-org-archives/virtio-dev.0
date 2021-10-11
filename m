Return-Path: <virtio-dev-return-8838-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DACF59862A3
	for <virtio-dev@lists.oasis-open.org>; Mon, 11 Oct 2021 16:22:27 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <PH0PR12MB5481502C480B6A7C1B61DFD6DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <PH0PR12MB54811E06DAED3F7D60955A84DCB09@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211006163309-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481990F6F33697BB2F9B6D4DCB19@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008063303-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481378DF0CE74777A5BEC90DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008071903-mutt-send-email-mst@kernel.org>
 <87lf33ybz7.fsf@redhat.com>
 <PH0PR12MB5481270F843DEC30A49972F3DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008085134-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816AD1011E3806A4A26B27DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211008185926-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54814DF6BE5016FB4D941847DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <871r4ry5do.fsf@redhat.com>
 <PH0PR12MB5481502C480B6A7C1B61DFD6DCB59@PH0PR12MB5481.namprd12.prod.outlook.com>
Date: Mon, 11 Oct 2021 18:22:15 +0200
Message-ID: <87y26zwmyw.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v2] Add device reset timeout field
Content-Type: text/plain
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Oct 11 2021, Parav Pandit <parav@nvidia.com> wrote:

>> From: Cornelia Huck <cohuck@redhat.com>
>> Sent: Monday, October 11, 2021 8:29 PM
>> 
>> On Mon, Oct 11 2021, Parav Pandit <parav@nvidia.com> wrote:

>> > I think read only device reset timeout is most elegant option during device
>> initialization phase that eliminates infinite loop of today.
>> 
>> Why can't a driver just go ahead and do a timeout regardless? 
> o.k. lets consider this thought exercise. What is the timeout value that driver will choose if device doesn't specify one?
> I explained in previous thread and you acked that actual fw based device may take longer to initialize than pure sw implementation backend.
> In second example a pre-boot device can take even longer initialization time.
> Sriov VF device may initialize lot faster.
> Instead of driver having such transport, and device specific checks, (or some very short or very long timeout), we propose, that let device mention such timeout value.

But does the driver really care in all cases? Say, I'm a virtio-blk
driver, and I drive all kinds of virtio-blk devices. If I choose a
timeout value that accommodates hardware devices, software devices will
just always breeze past, and nothing bad happens. If I know that I'm in
a pre-boot environment, I'll just add on a value that allows devices to
warm up. I'd say reasonable values depend way more on the driver
implementation and the environment it is running in than on the device.

>
>> This seems
>> pretty much to depend on the implementation. Nothing in the virtio spec forces
>> the driver to reset all devices serially and wait potentially forever. (If you deal
>> with a large amount of subdevices you cannot access concurrently, you likely
>> already have problems.)
> Sure, nothing in driver forces serial initialization.
> However in reality, PCI device scanning on the bus in hotplug driver, preboot env, sriov vf initialization is serial.

So, can't pci scan asynchronously? Is that a limitation in the pci spec?
The Linux ccw bus switched to asynchronous processing precisely because
of slow devices years ago, FWIW, so that may be why I don't really
understand the issue.

> In preboot case, even the order is defined, so it is sort of serial.

Again, is that somewhere in the hardware spec, and can it be fixed?
Serializing something that might take some time just seems troublesome.

> In other uses, concurrent access is fine and host does that today when it disables autoprobe on the PCI Bus and probes them in parallel after enabling sriov.
> I hope you understand that there are both use-cases exists which scan parallel and some serial.

Can at least some processing be made asynchronous? Like, you discover
the device, but then do the virtio setup out of band.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

