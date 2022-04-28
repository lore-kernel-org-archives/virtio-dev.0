Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <20220427102559.305669-1-parav@nvidia.com> <CACGkMEsDEJS0awDfFzR7a1aOr3+TQ6iDse5R=LRAYGxgNs4bpQ@mail.gmail.com>
 <PH0PR12MB5481FA61532231E61C96F692DCFA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220427111713-mutt-send-email-mst@kernel.org> <PH0PR12MB5481CBB7E506E3DCEB11A7BFDCFA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220427114055-mutt-send-email-mst@kernel.org> <PH0PR12MB5481AC52975356341A964314DCFA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB548121654DFF8442593FF26DDCFA9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <9a932876-1a5e-8166-57fd-f41bf4f153f5@redhat.com> <PH0PR12MB5481E73A95F36A3CE63EEA8FDCFD9@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481E73A95F36A3CE63EEA8FDCFD9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Apr 2022 14:13:42 +0800
Message-ID: <CACGkMEsWMxXEyNKue7f8cu4m5CkUmZNexbjzK6ha5eDFCmhR1w@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH v2] virtio: Improve queue_reset polarity to
 match to default reset state
Content-Type: text/plain; charset="UTF-8"
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Apr 28, 2022 at 12:00 PM Parav Pandit <parav@nvidia.com> wrote:
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Wednesday, April 27, 2022 11:41 PM
> >
> >
> > Hypervisor needs to trap the access to q_reset, otherwise there will be a
> > race anyhow. So it knows the device is being reset and only after the device
> > rest is finished, it can suspend a VM.
> >
> The state can come from the device directly without the trap via HV to device direct access.

So this complicates the implementation of the hardware:

1) it needs to track a state like busy resetting which seems unnecessary
2) in the case of nesting, we need to trap anyhow

>
> >
> > > VQ state returned
> > > q_enable=1, q_reset = 0.
> > >
> > > HV doesn't know what q_reset=0 mean here, is it 0 because it was never
> > reset?
> > > Or it is 0 because GVM Started the reset, but reset didn't finish?
> >
> >
> > If the device can change any register value (e.g q_reset), it's not stopped.
> > We can't do the migration anyhow. No?
> The state is in the device, so depending on the device type it may be able to store its internal state.
>
> >
> >
> > >
> > > When this virtio device is restored on the other side, HV and device doesn't
> > know how to deal with this.
> > >
> > > A WA that all devices will implement is, not returning 0, in step_2, but
> > return say q_reset = 0xa to indicate that its other than 1 and other than 0.
> > > But hey, the destination side needs to treat this special 0xa and convert to
> > internal q_yet_busy stage.
> > >
> > > And this answer Jason and myself why queue_enable shouldn't be
> > overloaded for this busy_wait register.
> >
> >
> > Well, we've already had busy waiting register that is device_status.
> >
> > """
> >
> > After writing 0 todevice_status, the driver MUST wait for a read
> > ofdevice_statusto return 0 before reinitializing the device.
> >
> I think yes, we can overload q_enable busy wait to register like device_status.
> Q_enable turns zero only when queue is disabled, till that time driver polls for it and gets 1.
>
> In this approach, external query entity will not be able to see ongoing queue reset.

Yes, this can simplify a lot, there's no much value in migrating
ongoing queue rest.

> This may be ok because device is anyway maintaining its internal state regardless.
>
> queue_reset removal has far more editorial changes.
> Before I update the v4 to incorporate, please discuss/sync with Michael or others what is best course of action from spec timing perspective.
>  I am ok either way to draft either by
> (a) removal of queue_reset register and allow queue_disable by replacing RING_RESET definition in v4
> Or
> (b) fixing the polarity as done in v3

Ok.

Thanks

