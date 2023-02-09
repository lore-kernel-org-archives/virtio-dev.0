Return-Path: <virtio-comment-return-4112-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <20230209014108.209950-1-parav@nvidia.com>
 <m2cz6j2gbz.fsf@oracle.com>
 <PH0PR12MB548195947918089961CEE699DCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
From: David Edmondson <david.edmondson@oracle.com>
Date: Thu, 09 Feb 2023 13:16:22 +0000
In-reply-to: <PH0PR12MB548195947918089961CEE699DCD99@PH0PR12MB5481.namprd12.prod.outlook.com>
Message-ID: <m28rh72d0k.fsf@oracle.com>
MIME-Version: 1.0
Subject: Re: [virtio-comment] [PATCH v3] virtio-net: Improve introductory
 description
Content-Type: text/plain
To: Parav Pandit <parav@nvidia.com>
Cc: "mst@redhat.com" <mst@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, Shahaf Shuler <shahafs@nvidia.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>


On Thursday, 2023-02-09 at 12:45:09 UTC, Parav Pandit wrote:
>> From: David Edmondson <david.edmondson@oracle.com>
>> Sent: Thursday, February 9, 2023 7:03 AM
>> 
>
> [..]
>> > +to the Ethernet network. The device has transmit and receive queues.
>> > +The driver posts empty buffers in the receive virtqueue.
>> > +The device receives the incoming packets from the link; the device
>> > +places these incoming packets in the receive virtqueue buffers.
>> > +The driver enqueues outgoing packets to the transmit virtqueue. The
>> >  device
>> 
>> We "post" receive buffers, yet "enqueue" transmit buffers. These actions seem
>> the same.
>> 
>> Maybe "submits" in both cases?
>> 
> At virtqueue level it is same.
> In context of virtio net device, transmit operation is queued that awaits processing (to send) by device.
> While receive side, its unsolicited operation done by driver that doesn't await processing by device.
> Whenever/if in future when a packet arrives, the posted buffer is consumed.
>
> So enqueue and post were capturing this contextual detail.
> But maybe I am trying to be too precise here but above wording were more natural to me at net level. :)
> Let me know..

I'm not too bothered. The operations are functionally the same, so using
different words seemed odd.
-- 
Please don't stand so close to me.

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

