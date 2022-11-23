Return-Path: <mst@redhat.com>
Date: Wed, 23 Nov 2022 04:32:08 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v8 4/9] admin: introduce virtio admin virtqueues
Message-ID: <20221123043058-mutt-send-email-mst@kernel.org>
References: <20221121012419.317406-1-mst@redhat.com>
 <20221121012419.317406-5-mst@redhat.com>
 <8735abf7ww.fsf@redhat.com>
 <20221122142342-mutt-send-email-mst@kernel.org>
 <87mt8inhla.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87mt8inhla.fsf@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Nov 23, 2022 at 10:30:25AM +0100, Cornelia Huck wrote:
> On Tue, Nov 22 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Tue, Nov 22, 2022 at 02:14:23PM +0100, Cornelia Huck wrote:
> >> On Sun, Nov 20 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> > +Administration virtqueues exists for a certain owner device if
> >> > +VIRTIO_F_ADMIN_VQ feature has been negotiated. The index of the
> >> > +first administration virtqueue and their number is exposed by the
> >> > +owner device in a transport specific manner.
> >> 
> >> (Do we always expect admin virtqueues to use a range of indices, i.e. no
> >> holes? That seems a bit limiting.)
> >
> > For the device?
> > I frankly feel it's enough, yea.
> 
> About how many admin virtqueues per device are we thinking for current
> use cases, anyway? If it's usually just one or two, the range would not
> really be limiting.

I think it's one or two for now, yes. E.g. we could use
one for SRIOV and one for the (TBD) SIOV.


> >
> >> What about
> >> 
> >> "If VIRTIO_F_ADMIN_VQ has been negotiated, an owner device exposes one
> >> or more adminstration virtqueues. The number and locations of the
> >> administration virtqueues is exposed by the owner device in a transport
> >> specific manner."
> >
> >
> >
> >
> >> > +
> >> > +The driver submits commands by queueing them to an arbitrary
> >> > +administration virtqueue, and they are processed by the
> >> > +device in the order in which they are queued. It is the
> >> > +responsibility of the driver to ensure ordering for commands
> >> > +placed on different administration virtqueues, because they will
> >> > +be executed with no order constraints.
> >> 
> >> Are all admin vqs supposed to be equal? Could a device expose e.g. a
> >> high prio admin vq and a normal prio admin vq?
> >
> >
> > ATM yes, for priority we'll need a separate capability. Work on top?
> 
> Ok, if we don't need it now, we can add it later.

