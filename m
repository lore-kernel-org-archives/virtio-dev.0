Return-Path: <hengqi@linux.alibaba.com>
Date: Sat, 18 Feb 2023 01:17:04 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
Subject: Re: [virtio-dev] Re: [PATCH v3] virtio-net: support the virtqueue
 coalescing moderation
Message-ID: <20230217171704.GB117623@h68b04307.sqa.eu95>
References: <20230216144301.57728-1-hengqi@linux.alibaba.com>
 <20230216111552-mutt-send-email-mst@kernel.org>
 <20230217052404.GA114259@h68b04307.sqa.eu95>
 <20230217053039-mutt-send-email-mst@kernel.org>
 <CAJs=3_B7snyMbjfL3vaKKe3wfx2XomLeVzCiCPNxFpy_ZTbepA@mail.gmail.com>
 <20230217062539-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815528B92662843B750D3ADCA19@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54815528B92662843B750D3ADCA19@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Yuri Benditovich <yuri.benditovich@daynix.com>, Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Feb 17, 2023 at 04:12:34PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Friday, February 17, 2023 6:35 AM
> 
> > > We mention the device reset case, but nothing about VQ reset.
> > >
> > > I feel that no matter how we handle this, we break something.
> > >
> > > Having default coalescing values may collide with "Upon reset, a
> > > device MUST initialize all coalescing parameters to 0."
> > 
> > No this is after device reset.
> > 
> > > We can say that VQ reset doesn't affect the "global parameters" and a
> > > device reset does, but this collides with "Device Requirements:
> > > Virtqueue Reset".
> > >
> Not really.
> When the device resets, VQ objects are destroyed in the device.
> So VQ's notifications parameters doesn't exists on device reset.
> 
> And so the same case with VQ reset.
> When a VQ is reset (disabled), VQ's notifications configuration is removed in the device too.
> Just like its desc ring and other addresses are invalid.

Yes, but there seems to be such a situation: when the device is reactivated, as the specification says,
all parameters are set to 0 (use parameters as the default configuration on the device).
When CTRL_COAL_SET and CTRL_COAL_VQ_SET are sent, the configuration is updated (the parameters of each vq may be different,
but the global parameter configuration may be recorded), at this time, if vq is reset,
should the parameters be 0 or a recorded global parameters after it is re-enabled?

> 
> > > In fact, resetting coalescing values after vq reset may be derived
> > > from "Upon reset, a device MUST initialize all coalescing parameters
> > > to 0".
> > > This is consistent with "Device Requirements: Virtqueue Reset".
> > >
> > > I can add in my patch some clarifications.
> > >
> > > This will break the linux virtio_net ethtool implementation a little,
> > > we'll need to fix it.
> > 
> > Not good. I feel we must come up with spec that is backwards compatible.
> > Hmm, maybe this is why Parav kept talking about modes.
> > I did not realize at the time, sorry Parav.
> > 
> > I still feel modes are not the best way to describe things so I propose this:
> > - in addition to per vq parameters, device that supports global TX/RX
> >   commands and ring reset maintains two sets of default parameters: for RX and
> > TX
> > - existing commands change default and change all enabled vqs
> >   of the correct type (RX/TX) to the same value
> > - vq reset changes a vq to the default
> > - device reset changes defaults to 0 and changes all vqs to  0
> > 
> > note how defaults are only used for ring reset.  is "vq reset parameter"
> > a better name? I feel we will repeat "reset" too many times in a sentence if we
> > call it that though.
> > 
> > So fundamentally the only change is with RING_RESET, then default is not
> > always 0, it can be set by the global command.
> 
> True default is not zero when global are configured.
> It is ok to report VQ parameters on GET command when globals are configured.

