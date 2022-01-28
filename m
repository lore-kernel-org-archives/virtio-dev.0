Return-Path: <virtio-comment-return-2665-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20220128074613-mutt-send-email-mst@kernel.org>
References: <20220124093918.34371-1-mgurtovoy@nvidia.com>
 <20220124093918.34371-2-mgurtovoy@nvidia.com> <87wnikys4p.fsf@redhat.com>
 <20220128074613-mutt-send-email-mst@kernel.org>
Date: Fri, 28 Jan 2022 16:49:34 +0100
Message-ID: <87tudnzwq9.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH v2 1/4] Add virtio Admin Virtqueue
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jan 28 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Jan 28, 2022 at 01:14:14PM +0100, Cornelia Huck wrote:
>> On Mon, Jan 24 2022, Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>> > +\section{Admin Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Admin Virtqueues}
>> > +
>> > +Admin virtqueue is used to send administrative commands to manipulate
>> > +various features of the device and/or to manipulate various features,
>> > +if possible, of another device within the same group (e.g. PCI VFs of
>> > +a parent PCI PF device are grouped together. These devices can be
>> > +optionally managed by its parent PCI PF using its admin virtqueue.).
>> > +
>> > +Use of Admin virtqueue is negotiated by the VIRTIO_F_ADMIN_VQ
>> > +feature bit.
>> > +
>> > +Admin virtqueue index may vary among different device types.
>> 
>> So, my understanding is:
>> - any device type may or may not support the admin vq
>> - if the device type wants to be able to accommodate the admin vq, it
>>   also needs to specify where it shows up when the feature is negotiated
>> 
>> Do we expect that eventually all device types will need to support the
>> admin vq (if some use case comes along that will require all devices to
>> participate, for example?)
>
> I suspect yes. And that's one of the reasons why I'd rather we had a
> device independent way to locate the admin queue. There are less
> transports than device types.

So, do we want to bite the bullet now and simply say that every device
type has the admin vq as the last vq if the feature is negotiated?
Should be straightforward for the device types that have a fixed number
of vqs, and doable for those that have a variable amount (two device
types are covered by this series anyway.) I think we need to put it with
the device types, as otherwise the numbering of virtqueues could change
in unpredictable ways with the admin vq off/on.


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

