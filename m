Return-Path: <virtio-comment-return-2745-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Tue, 8 Feb 2022 16:02:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20220208160121-mutt-send-email-mst@kernel.org>
References: <20220208014039-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548104AB80FA36544DB3D7D0DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <878rulv6kq.fsf@redhat.com>
 <PH0PR12MB54816EBF061770CC91E0435DDC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220208084022-mutt-send-email-mst@kernel.org>
 <875yppv1z2.fsf@redhat.com>
 <20220208102341-mutt-send-email-mst@kernel.org>
 <PH0PR12MB548176C6907729FA956FB81DDC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220208103637-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54818E39CB898C7BCC29C221DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54818E39CB898C7BCC29C221DC2D9@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-comment] Re: [PATCH v3 1/4] Add virtio Admin virtqueue
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "jasowang@redhat.com" <jasowang@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, "stefanha@redhat.com" <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 08, 2022 at 03:48:42PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, February 8, 2022 9:08 PM
> 
> 
> > On Tue, Feb 08, 2022 at 03:35:58PM +0000, Parav Pandit wrote:
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Tuesday, February 8, 2022 8:56 PM
> > >
> > > > > I might have been a bit too vague about what I had been thinking
> > > > > about. Let's do a sketch (intentionally without concrete sizes):
> > > > >
> > > > > +-------------------------------------------------------+
> > > > > | command                                               |
> > > > > +-------------------------------------------------------+
> > > > > | target type (0 - self, 1 - dev id, 2 - group id, ...  |
> > > > > +-------------------------------------------------------+
> > > > > | dev id                                                |
> > > > > +-------------------------------------------------------+
> > > > > | group id                                              |
> > > > > +-------------------------------------------------------+
> > > > > | command-specific data                                 |
> > > > > +-------------------------------------------------------+
> > > > > | response part                                         |
> > > > > +-------------------------------------------------------+
> > > > >
> > > > > 'dev id' would be valid for 'target type' == 1, 'group id' would
> > > > > be valid for 'target type' == 2. Alternatively, 'dev id' and 'group id'
> > > > > could be a single 'target id' field; if there's nothing better to
> > > > > use, it can simply contain a uuid.
> > > >
> > > > I am not sure why do we have both dev id and group id.
> > > > They are never used together right?
> > > > Maybe just have an id length field if we can't agree on how much
> > > > space to reserve.
> > > This is what I propose in a previous email.
> > > A device id can be duplicate in different groups.
> > > So to build hierarchy group id will be desired.
> > >
> > > So id[] array can contain nested one or multiple fields.
> > 
> > I guess nesting is for when there's like an SF within a VF?
> That is one case, but I imagine that if SF is on top of VF, than VF will directly manage it. PF should not get involved in nested management.
> 
> Nesting is for the case, where there is explicit group. A simple example is,
> A NIC has two PCI functions, both support SR-IOV and VFs.
> But only one PF is managing the VFs for msix, mac etc configuration.

Or maybe that's the case of "it hurts when I do this - then don't do that".


> In this case there are two groups g0, g1.
> grp0 belongs to PF0.
> grp1 belongs to PF1.
> 
> So a id definition looks like below.
> 
> struct pf_identifier {
> 	u8 device; /* pci device of bdf */
> 	u8 function;	/* pci function of bdf */
> } __attribute__(packed);
> 
> struct pci_vf_grouped_id {
> 	struct pf_identifier pf_id;
> 	u16 vf_num;
> };
> 
> struct device_identfier {
> 	u8 id_type;	/* below id type enum */
> 	u16 id_len;
> 	union {
> 		u8 raw[0];
> 		struct pci_vf_grouped_id gvf_id;
> 	} id_data;	
> };
> 
> enum id_type {
> 	VIRTIO_PCI_VF = 0,	/* implicitly grouped VF */
> 	VIRTIO_PCI_REMOTE_VF = 1, /* part of hirechical group */
> 	VIRTIO_SF,
> 	VIRTIO_PCI_REMOTE_SF, /* part of hirechical group */
> 	VIRTIO_MMIO,
> 	/* more */
> };


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

