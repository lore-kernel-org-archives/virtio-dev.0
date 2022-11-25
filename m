Return-Path: <mst@redhat.com>
Date: Fri, 25 Nov 2022 07:08:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH v9 02/10] admin: introduce device group
 and related concepts
Message-ID: <20221125070700-mutt-send-email-mst@kernel.org>
References: <20221123210706.21476-1-mst@redhat.com>
 <20221123210706.21476-3-mst@redhat.com>
 <CACGkMEuuHgJ-yZmMAu0L=piUmZa8sY-v7e5FyTrpUSdZML5KUA@mail.gmail.com>
 <20221124020650-mutt-send-email-mst@kernel.org>
 <CACGkMEtF0WLEiDPQw5W7o0f+JvkFSbX++uOc-SPYHsnFMXyJgw@mail.gmail.com>
 <20221124031554-mutt-send-email-mst@kernel.org>
 <87h6yoh7pj.fsf@redhat.com>
 <5731c35c-f24d-3667-b3be-c2f86f849b92@redhat.com>
MIME-Version: 1.0
In-Reply-To: <5731c35c-f24d-3667-b3be-c2f86f849b92@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
To: Jason Wang <jasowang@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Nov 25, 2022 at 11:23:09AM +0800, Jason Wang wrote:
> 
> 在 2022/11/24 20:12, Cornelia Huck 写道:
> > On Thu, Nov 24 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > 
> > > On Thu, Nov 24, 2022 at 03:37:42PM +0800, Jason Wang wrote:
> > > > On Thu, Nov 24, 2022 at 3:08 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > On Thu, Nov 24, 2022 at 01:41:41PM +0800, Jason Wang wrote:
> > > > > > On Thu, Nov 24, 2022 at 5:08 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > +The following group types, and their identifiers, are currently specified):
> > > > > > > +\begin{description}
> > > > > > > +\item[SR-IOV group type (0x1)]
> > > > > > > +This device group has a PCI Single Root I/O Virtualization
> > > > > > > +(SR-IOV) physical function (PF) device as the owner and includes
> > > > > > > +all its SR-IOV virtual functions (VFs) as members (see
> > > > > > > +\hyperref[intro:PCIe]{[PCIe]}).
> > > > > > So I wonder what's the advantage of using a global identifier over the
> > > > > > transport specific one. There's almost no way for CCW/MMIO to use
> > > > > > SR-IOV. Limiting it to PCI seems much easier and avoids layer
> > > > > > violation.
> > > > > > 
> > > > > > Thanks
> > > > > So we burn up an identifier, ccw and mmio won't be able to use it.
> > > > > Big deal? Why?
> > > > Because it is transport specific. The basic facility should be
> > > > transport independent.
> > > I tried this but the result is spread all over the spec
> > > and does not result in a readable cohesive whole.
> 
> 
> I may miss something, but it looks to me it's just a subsection in the PCI
> transport to describe the SR-IOV group identifier.
> 


right so everything is in admin.tex except for the identifier
which is in pci. I find this split annoying - not enough material
here where splitting makes things cleaner.
But we can move it down the road.


> > > So we give up on the transport independent purity a bit and it
> > > seems worth it.
> > > Also explained this in the cover letter - have you seen that?
> 
> 
> Sorry, I don't.
> 
> 
> > > 
> > > 
> > > 
> > > > > And I think we might find a use for this with MMIO
> > > > > down the road with some kind of passthrough. Who knows.
> > > > Probably, but can it be modeled exactly as what SR-IOV looks like? Or
> > > > anyhow, it's not too late to define this for MMIO at that time. For
> > > > example, we know MSI-X may work for MMIO but we define it only for PCI
> > > > now.
> > > > 
> > > > Thanks
> > > Right. So if we reserve the id for all transports then it will
> > > be easy to do.
> > Also, if we go with transport-specific ids, we might end up with
> > different ids per transport when we add a future transport-independent
> > feature.
> 
> 
> I'm not sure this is a real problem:
> 
> 1) all the basic facilities are now transport-independent but they are
> implemented via different transport specific registers/commands/offsets etc.
> 2) I'm not quite sure there would be a transport-independent group
> identifier other than the virtqueue transport, so I wonder if it makes sense
> to split the id space into global ones as well as the transport specific
> ones
> 
> 
> >   The global id space really should be big enough to accommodate
> > even single-transport groups.
> 
> 
> Yes, so it's not about the space but about whether or it it's
> worth/correct/expensive to describe a transport specific identifier in the
> basic facility part.
> 
> Thanks
> 
> 
> > 
> > 
> > ---------------------------------------------------------------------
> > To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> > For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
> > 

