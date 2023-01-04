Return-Path: <virtio-comment-return-3678-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Wed, 4 Jan 2023 08:38:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230104083633-mutt-send-email-mst@kernel.org>
References: <20230104040205.360753-1-parav@nvidia.com>
 <20230104013612-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481AC6618719A63E6801190DCF59@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481AC6618719A63E6801190DCF59@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: [virtio-comment] Re: [PATCH v4] virtio-network: Clarify VLAN filter table
 configuration
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 04, 2023 at 01:28:55PM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, January 4, 2023 1:41 AM
> > 
> > On Wed, Jan 04, 2023 at 06:02:05AM +0200, Parav Pandit wrote:
> > > The filtering behavior of the VLAN filter commands is not very clear
> > > as discussed in thread [1].
> > >
> > > Hence, add the command description and device requirements for it.
> > >
> > > [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg912392.html
> > > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/147
> > > Suggested-by: Si-Wei Liu <si-wei.liu@oracle.com>
> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > 
> > Looks like we are going back to issues that we had in v1.
> > what happened here?
> > 
> I was missing text in v3 for the case of device behavior for handling vlan tagged packets when CTRL_VLAN is not negotiated.
> Which I added in v4. Parts of the v1 was taken care. More below.
> [..]
> > > +
> > > +VIRTIO_NET_CTRL_VLAN_DEL command removes specified VLAN from the
> > VLAN
> > 
> > the specified
> > 
> Ack.
> 
> > > +filtering table which was previously added using
> > > +VIRTIO_NET_CTRL_VLAN_ADD command.
> > 
> > bad ordering so it's unclear what was added. it's vlan not the table. So:
> > 	removes the specified VLAN - which was previously added using
> > 	VIRTIO_NET_CTRL_VLAN_ADD command - from the VLAN filtering
> > table.
> >
> Ack.
>  
> > > +
> > > +\devicenormative{\subparagraph}{VLAN Filtering}{Device Types /
> > > +Network Device / Device Operation / Control Virtqueue / VLAN
> > > +Filtering}
> > > +
> > > +When VIRTIO_NET_F_CTRL_VLAN is not negotiated, the device accepts all
> > > +VLAN tagged packets that matches the device's filter configuration.
> > 
> > bad grammar here and it's not a match.
> > 
> How about, 
> 
> When VIRTIO_NET_F_CTRL_VLAN is not negotiated, the device accepts 
> all VLAN tagged packets based on the device configuration.

We came up with a better wording e.g. in
20230103054736-mutt-send-email-mst@kernel.org .



> Above spec line covers 
> (a) existing mac filter table entries
> (b) promiscuous variations and 
> (c) future filtering rules.


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

