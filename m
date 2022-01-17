Return-Path: <mst@redhat.com>
Date: Mon, 17 Jan 2022 17:14:22 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/5] Introduce
 VIRTIO_F_ADMIN_VQ_INDIRECT_DESC/VIRTIO_F_ADMIN_VQ_IN_ORDER
Message-ID: <20220117170442-mutt-send-email-mst@kernel.org>
References: <20220113145103.26894-1-mgurtovoy@nvidia.com>
 <20220113145103.26894-3-mgurtovoy@nvidia.com>
 <20220113102218-mutt-send-email-mst@kernel.org>
 <eaf88f9c-8b51-7758-90c0-c1a92df35061@nvidia.com>
 <20220113121203-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481B90FF747D56377A0A850DC579@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481B90FF747D56377A0A850DC579@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 17, 2022 at 01:59:29PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, January 13, 2022 10:56 PM
> > 
> > On Thu, Jan 13, 2022 at 07:07:53PM +0200, Max Gurtovoy wrote:
> > >
> > > On 1/13/2022 5:33 PM, Michael S. Tsirkin wrote:
> > > > On Thu, Jan 13, 2022 at 04:51:00PM +0200, Max Gurtovoy wrote:
> > > > > These new features are parallel to VIRTIO_F_INDIRECT_DESC and
> > > > > VIRTIO_F_IN_ORDER. Some devices might support these features only
> > > > > for admin virtqueues and some might support them for both admin
> > > > > virtqueues and request virtqueues or only for non-admin
> > > > > virtqueues. Some optimization can be made for each type of
> > > > > virtqueue, thus we separate these features for the different virtqueue
> > types.
> > > > >
> > > > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > > That seems vague as motivation.
> > > > Why do we need to optimize admin queues? Aren't they fundamentally a
> > > > control path feature?
> > > > Why would we want to special-case these features specifically?
> > > > Should we allow control of features per VQ generally?
> > >
> > > We would like to allow executing admins commands out of order and IO
> > > requests in order for efficiency.
> > 
> > It's a control queue. Why do we worry?
> It is used to control/manage the resource of a VF which is deployed usually to a VM.
> So higher the latency, higher the time it takes to deploy start the VM.

What are the savings here, in real terms? Boot times for smallest VMs
are in 10s of milliseconds. Is reordering of a queue somehow
going to save more than microseconds?

> Hence, it is better to have this basic functionality in place, being useful beyond MSI-X config.
> It is not functionally must. But riding AQ command ordering on VIRTIO_F_IN_ORDER for now and later on driving based on new field requires dual handling.
> Better to start with its AQ's own ordering and one scheme.

Sorry I'm still scratching my head.


> > 
> > 
> > >
> > > And also the other way around.
> > 
> > what exactly does this mean?
> > 
> IO commands out of order (for say block device), but AQ commands in order.
> May be AQ command execution can be always treated as out of order, even when VIRTIO_F_IN_ORDER is negotiated.
> This way it will be even more simpler design for driver and device.
> 
> > > IO cmds and admin cmds have different considerations in many cases.
> > 
> > That's still pretty vague.  so do other types of VQ, such as RX/TX.
> > 
> > E.g. I can see how a hardware vendor might want to avoid supporting indirect
> > with RX for virtio net with mergeable buffers, but still support it for TX.
> > 
> > 
> > I can vaguely see the usefulness of VIRTIO_F_ADMIN_VQ_IN_ORDER.
> I agree. It only helps driver to ensure that AQ commands are processed in order, so it doesn't need to serialize it.
> But yes, driver can always serialize it if needed when AQ is always out of order.
> I think we should word it that AQ is always out of order.
> 
> > I think you want to reorder admin commands dealing with unrelated VFs but
> > keep io vqs in order for speed.
> > Just guessing, you should spell the real motivation out.
> > However, I think a better way to do that is with finalizing the
> > VIRTIO_F_PARTIAL_ORDER proposal from august.
> I read the partial order proposal at [1].
> It still appears IN_ORDER from driver POV.
> So I am not sure if driver can complete AQ commands out of order. Can it?

complete commands == use buffers?
drivers do not use buffers.

> I think data path needs more plumbing that just PARTIAL_ORDER flag, for descriptor processing differently on tx and rx side.
> Not sure merging AQ to it is useful, given that we agree that AQ should always behave as out of order from beginning.
> 
> [1] https://lists.oasis-open.org/archives/virtio-dev/202008/msg00001.html

You mean *device*. Driver does not control the order.
The point of PARTIAL_ORDER is basically that some
descriptors are in order some out of order and its up to device. So it is
even finer resolution.


> > Pls review and let me know. If there's finally a use for it I'll prioritize finalizing
> > that idea.
> > Don't see much point in tweaking INDIRECT at all.
> Common negotiation of INDIRECT on AQ and other queues forces data path also to handle that.

I don't see why admin queue needs indirect descriptors.

> It is better to not impact the device to handler indirect descriptors on non AQ queues, just because AQ prefers to handle it.
> Often AQ and data path queues are not handled by same set of processing engines given they both do different tasks.

so for example, many guests want to use indirect for tx but not for rx.
if you are worrying about things like that, maybe a per-vq control
over indirect support makes sense.
adding complexity like that should really be much better motivated,
and maybe have some PoC code or back of the napkin math
showing the expected gains.


-- 
MST

