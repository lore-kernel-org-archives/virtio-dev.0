Return-Path: <mst@redhat.com>
Date: Wed, 26 Jan 2022 02:02:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 4/5] virtio-net: add support for VIRTIO_F_ADMIN_VQ
Message-ID: <20220126015630-mutt-send-email-mst@kernel.org>
References: <38c7b7a3-e0d8-d242-8723-11cabbbcb47d@nvidia.com>
 <PH0PR12MB54812553884E5791B8A69DE8DC579@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220117171459-mutt-send-email-mst@kernel.org>
 <631d8512-6a28-a714-4a71-dded3ef9ce3c@redhat.com>
 <20220118002309-mutt-send-email-mst@kernel.org>
 <CACGkMEucTZSOq=yZ6-DjksW_Z_pg9vcA+pM6+iWWiGdpmM8u0Q@mail.gmail.com>
 <20220119042012-mutt-send-email-mst@kernel.org>
 <CACGkMEsjYycB_BVP6SGSEt_E1U+Ri7d25_9hc=ei-6_-JJCsSg@mail.gmail.com>
 <20220125021456-mutt-send-email-mst@kernel.org>
 <CACGkMEuHcJws-KcSufEtG=Xp==fN9w-X_9o_2c-LG=gDYV1=pw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuHcJws-KcSufEtG=Xp==fN9w-X_9o_2c-LG=gDYV1=pw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 26, 2022 at 01:49:05PM +0800, Jason Wang wrote:
> On Tue, Jan 25, 2022 at 3:20 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Tue, Jan 25, 2022 at 11:53:35AM +0800, Jason Wang wrote:
> > > On Wed, Jan 19, 2022 at 5:26 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Wed, Jan 19, 2022 at 12:16:47PM +0800, Jason Wang wrote:
> > > > > > We also need
> > > > > > - something like injecting cvq commands to control rx mode from the admin device
> > > > > > - page fault / dirty page handling
> > > > > >
> > > > > > these two seem to call for a vq.
> > > > >
> > > > > Right, but vq is not necessarily for PF if we had PASID. And with
> > > > > PASID we don't even need a dedicated new cvq.
> > > >
> > > > I don't think it's a good idea to mix transactions from
> > > > multiple PASIDs on the same vq.
> > >
> > > To be clear, I don't mean to let a single vq use multiple PASIDs.
> > >
> > > >
> > > > Attaching a PASID to a queue seems more reasonable.
> > > > cvq is under guest control, so yes I think a separate
> > > > vq is preferable.
> > >
> > > Sorry, I don't get here. E.g in the case of virtio-net, it's more than
> > > sufficient to assign a dedicated PASID to cvq, any reason for yet
> > > another one?
> >
> > Well I'm not sure how cheap it is to have an extra PASID.
> > In theory you can share page tables making it not that
> > expensive.
> 
> I think it should not be expensive since PASID is per RID according to
> the PCIe spec.
> 
> > In practice is it hard for the MMU to do so?
> > If page tables are not shared extra PASIDs become expensive.
> 
> Why? For CVQ, we don't need sharing page tables, just maintaining one
> dedicated buffer for command forwarding is sufficient.

I am talking about the IOMMU page tables, these are not part of PCIe
spec. You need to map all of guest memory to the device, this needs a
set of PTEs. If two PASIDs map same memory you might be able to share
PTEs but I am guessing that this will need some kind of reference
counting to track their usage. I am not sure how complex/expensive that
will turn out to be. In absence of that, we are doubling the amount of
PTEs by using two PASIDs for the same device.


> >
> >
> > > >
> > > > What is true is that with subfunctions you would have
> > > > PASID per subfunction and then one subfunction for control.
> > >
> > > Well, it's possible, but it's also possible to have everything self
> > > contained in a single subfucntion. Then cvq can be assigned to a PASID
> > > that is used only for the hypervisor.
> > >
> > > >
> > > > I think a sketch of how things will work with scalable iov can't hurt as
> > > > part of this proposal.  And, I'm not sure we should have so much
> > > > flexibility: if there's an interface that works for SRIOV and SIOV then
> > > > that seems preferable than having distinct transports for SRIOV and
> > > > SIOV.
> > >
> > > Some of my understanding of SR-IOV vs SIOV:
> > >
> > > 1) SR-IOV doesn't requires a transport, VF use PCI config space; But
> > > SIOV requires one
> > > 2) SR-IOV doesn't support dynamic on demand provisioning where SIOV can
> > >
> > > So I'm not sure how hard it is if we want to unify the management
> > > plane of the above two.
> > >
> > > Thanks
> >
> > Interesting. So are you fine with a proposal which ignores the PASID
> > things completely then?
> 
> I'm fine, just a note that:
> 
> The main advantages of using admin virtqueue in another device (PF) is
> that the DMA is isolated,

Right

> but with the help of PASID, there's no need
> to do that

In that you can make the AQ part of the VF itself?

> and we will have a better interface for nesting.
> 
> Thanks

In fact, nesting is an interesting use case. I have not
thought about this too much, it is worth thinking about
how this interface will virtualize.

> > If yes can we take that discussion to
> > a different thread then? This one is already too long ...
> >
> >
> > >
> > > >
> > > >
> > > > --
> > > > MST
> > > >
> >

