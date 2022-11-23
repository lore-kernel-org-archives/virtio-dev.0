Return-Path: <virtio-dev-return-10213-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 614BC9864B8
	for <virtio-dev@lists.oasis-open.org>; Wed, 23 Nov 2022 09:30:36 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20221122142342-mutt-send-email-mst@kernel.org>
References: <20221121012419.317406-1-mst@redhat.com>
 <20221121012419.317406-5-mst@redhat.com> <8735abf7ww.fsf@redhat.com>
 <20221122142342-mutt-send-email-mst@kernel.org>
Date: Wed, 23 Nov 2022 10:30:25 +0100
Message-ID: <87mt8inhla.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v8 4/9] admin: introduce virtio admin virtqueues
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com, hang.yuan@intel.com, virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Nov 22 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Tue, Nov 22, 2022 at 02:14:23PM +0100, Cornelia Huck wrote:
>> On Sun, Nov 20 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> > +Administration virtqueues exists for a certain owner device if
>> > +VIRTIO_F_ADMIN_VQ feature has been negotiated. The index of the
>> > +first administration virtqueue and their number is exposed by the
>> > +owner device in a transport specific manner.
>> 
>> (Do we always expect admin virtqueues to use a range of indices, i.e. no
>> holes? That seems a bit limiting.)
>
> For the device?
> I frankly feel it's enough, yea.

About how many admin virtqueues per device are we thinking for current
use cases, anyway? If it's usually just one or two, the range would not
really be limiting.

>
>> What about
>> 
>> "If VIRTIO_F_ADMIN_VQ has been negotiated, an owner device exposes one
>> or more adminstration virtqueues. The number and locations of the
>> administration virtqueues is exposed by the owner device in a transport
>> specific manner."
>
>
>
>
>> > +
>> > +The driver submits commands by queueing them to an arbitrary
>> > +administration virtqueue, and they are processed by the
>> > +device in the order in which they are queued. It is the
>> > +responsibility of the driver to ensure ordering for commands
>> > +placed on different administration virtqueues, because they will
>> > +be executed with no order constraints.
>> 
>> Are all admin vqs supposed to be equal? Could a device expose e.g. a
>> high prio admin vq and a normal prio admin vq?
>
>
> ATM yes, for priority we'll need a separate capability. Work on top?

Ok, if we don't need it now, we can add it later.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

