Return-Path: <parav@nvidia.com>
From: Parav Pandit <parav@nvidia.com>
Subject: RE: [PATCH 2/5] Introduce
 VIRTIO_F_ADMIN_VQ_INDIRECT_DESC/VIRTIO_F_ADMIN_VQ_IN_ORDER
Date: Mon, 17 Jan 2022 13:59:29 +0000
Message-ID: <PH0PR12MB5481B90FF747D56377A0A850DC579@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220113145103.26894-1-mgurtovoy@nvidia.com>
 <20220113145103.26894-3-mgurtovoy@nvidia.com>
 <20220113102218-mutt-send-email-mst@kernel.org>
 <eaf88f9c-8b51-7758-90c0-c1a92df35061@nvidia.com>
 <20220113121203-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220113121203-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>


> From: Michael S. Tsirkin <mst@redhat.com>
> Sent: Thursday, January 13, 2022 10:56 PM
>=20
> On Thu, Jan 13, 2022 at 07:07:53PM +0200, Max Gurtovoy wrote:
> >
> > On 1/13/2022 5:33 PM, Michael S. Tsirkin wrote:
> > > On Thu, Jan 13, 2022 at 04:51:00PM +0200, Max Gurtovoy wrote:
> > > > These new features are parallel to VIRTIO_F_INDIRECT_DESC and
> > > > VIRTIO_F_IN_ORDER. Some devices might support these features only
> > > > for admin virtqueues and some might support them for both admin
> > > > virtqueues and request virtqueues or only for non-admin
> > > > virtqueues. Some optimization can be made for each type of
> > > > virtqueue, thus we separate these features for the different virtqu=
eue
> types.
> > > >
> > > > Reviewed-by: Parav Pandit <parav@nvidia.com>
> > > > Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
> > > That seems vague as motivation.
> > > Why do we need to optimize admin queues? Aren't they fundamentally a
> > > control path feature?
> > > Why would we want to special-case these features specifically?
> > > Should we allow control of features per VQ generally?
> >
> > We would like to allow executing admins commands out of order and IO
> > requests in order for efficiency.
>=20
> It's a control queue. Why do we worry?
It is used to control/manage the resource of a VF which is deployed usually=
 to a VM.
So higher the latency, higher the time it takes to deploy start the VM.
Hence, it is better to have this basic functionality in place, being useful=
 beyond MSI-X config.
It is not functionally must. But riding AQ command ordering on VIRTIO_F_IN_=
ORDER for now and later on driving based on new field requires dual handlin=
g.
Better to start with its AQ's own ordering and one scheme.

>=20
>=20
> >
> > And also the other way around.
>=20
> what exactly does this mean?
>=20
IO commands out of order (for say block device), but AQ commands in order.
May be AQ command execution can be always treated as out of order, even whe=
n VIRTIO_F_IN_ORDER is negotiated.
This way it will be even more simpler design for driver and device.

> > IO cmds and admin cmds have different considerations in many cases.
>=20
> That's still pretty vague.  so do other types of VQ, such as RX/TX.
>=20
> E.g. I can see how a hardware vendor might want to avoid supporting indir=
ect
> with RX for virtio net with mergeable buffers, but still support it for T=
X.
>=20
>=20
> I can vaguely see the usefulness of VIRTIO_F_ADMIN_VQ_IN_ORDER.
I agree. It only helps driver to ensure that AQ commands are processed in o=
rder, so it doesn't need to serialize it.
But yes, driver can always serialize it if needed when AQ is always out of =
order.
I think we should word it that AQ is always out of order.

> I think you want to reorder admin commands dealing with unrelated VFs but
> keep io vqs in order for speed.
> Just guessing, you should spell the real motivation out.
> However, I think a better way to do that is with finalizing the
> VIRTIO_F_PARTIAL_ORDER proposal from august.
I read the partial order proposal at [1].
It still appears IN_ORDER from driver POV.
So I am not sure if driver can complete AQ commands out of order. Can it?
I think data path needs more plumbing that just PARTIAL_ORDER flag, for des=
criptor processing differently on tx and rx side.
Not sure merging AQ to it is useful, given that we agree that AQ should alw=
ays behave as out of order from beginning.

[1] https://lists.oasis-open.org/archives/virtio-dev/202008/msg00001.html

> Pls review and let me know. If there's finally a use for it I'll prioriti=
ze finalizing
> that idea.
> Don't see much point in tweaking INDIRECT at all.
Common negotiation of INDIRECT on AQ and other queues forces data path also=
 to handle that.
It is better to not impact the device to handler indirect descriptors on no=
n AQ queues, just because AQ prefers to handle it.
Often AQ and data path queues are not handled by same set of processing eng=
ines given they both do different tasks.

