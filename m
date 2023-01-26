Return-Path: <virtio-comment-return-3915-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Thu, 26 Jan 2023 00:07:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230126000221-mutt-send-email-mst@kernel.org>
References: <20230112212550.763889-1-parav@nvidia.com>
 <20230125190454.043e54e0.pasic@linux.ibm.com>
 <20230125155204-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54810534C4518320B28BC9D6DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB54819A070E3D374E0BDBCEA2DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54819A070E3D374E0BDBCEA2DCCE9@PH0PR12MB5481.namprd12.prod.outlook.com>
Subject: Re: [virtio-comment] [PATCH v10] virtio-net: Clarify VLAN filter
 table configuration
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "si-wei.liu@oracle.com" <si-wei.liu@oracle.com>, Tiwei Bie <tiwei.bie@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 25, 2023 at 11:46:58PM +0000, Parav Pandit wrote:
> > > but vlans are different aren't they? Anyway changing that will need a
> > > new feature bit.
> > I do not the history for about "Note" on why it was made best effort.
> > To best of my knowledge, it should not be best effort.
> > Device should not overflow the table. It should fail the ADD call.

For the MAC table?  Failing commands generally is
a bad way to communicate to drivers. If we do there needs to also
be a way to report our limits. In this case it's enough to
look at qemu to see an implementation that just sets a "table
overflow" flag and stops filtering.

Similarly a populat vhost+bridge+tap combo does not keep
the copy of the mac table at all and instead realies on
guest sending announcement packets and bridge learning from these.


> > If the above claim of "Note" is not strong enough, we can probably run a
> > different issue to make it "MUST".
> > I am not sure we really need feature bit it we fix the note.
> 
> I clicked too early while typing.
> Since DEL operation doesn't synchronize with the data path of device and driver, at some point a packet in pipe can be still received with removed VLAN.
> So may be the note was added.
> But for sure ADD should not be best effort basis.

So for VLANs this was added by Tiwei. I guess it looked sane then
but now I don't remember the motivation. Tiwei CC'd.

-- 
MST


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

