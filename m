Return-Path: <virtio-comment-return-3910-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
Date: Wed, 25 Jan 2023 15:55:55 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20230125155204-mutt-send-email-mst@kernel.org>
References: <20230112212550.763889-1-parav@nvidia.com>
 <20230125190454.043e54e0.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20230125190454.043e54e0.pasic@linux.ibm.com>
Subject: Re: [virtio-comment] [PATCH v10] virtio-net: Clarify VLAN filter
 table configuration
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, si-wei.liu@oracle.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 25, 2023 at 07:04:54PM +0100, Halil Pasic wrote:
> > +
> > +When VIRTIO_NET_F_CTRL_VLAN is negotiated, the device MUST
> > +accept all VLAN tagged packets whose VLAN tag is present in
> > +the VLAN filter table and SHOULD drop all VLAN tagged packets
> > +whose VLAN tag is absent in the VLAN filter table.
> 
> We could also add "as per device configuration" here as well...
> 
> >From the other thread
> 
> On Mon, 23 Jan 2023 12:41:16 +0000
> Parav Pandit <parav@nvidia.com> wrote:
> 
> > > BTW why SHOULD drop?  
> > This is the offload feature to drop such packets so that OS driver doesn't need to do the filtering work. :)
> 
> Why not MUST drop? If the device is allowed to produce false negatives,
> then I think the OS probably wants to check again to filter out those.
> Can we change SHOULD to MUST, so the conforming device is guaranteed to
> do the filtering, and the OS can rely on it?

Well the spec says:
	Similar to the MAC address based filtering, the VLAN filtering
	is also best-effort: unwanted packets could still arrive.

 am not sure why - IIRC MAC filtering is best effort because
a. we don't expose table size to guests so the table can always overflow.
b. we like to rely on bridge to filter for performance and *that* is
   best effort.

but vlans are different aren't they? Anyway changing that will need
a new feature bit.

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

