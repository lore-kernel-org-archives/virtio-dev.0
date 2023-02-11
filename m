Return-Path: <virtio-comment-return-4153-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
MIME-Version: 1.0
References: <20230210070130.21811-1-hengqi@linux.alibaba.com>
 <PH0PR12MB548155EF2CB09C6C88B75C44DCDE9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJs=3_Dy5HrQs0PaPjNvwCUe0oYs0AhsEMKHVyXyYujfaeacUw@mail.gmail.com>
 <601ef040-bac2-dd6d-b32c-2029be17c071@linux.alibaba.com> <CAJs=3_Az-v8dm3NO6hgEm27zPfk2=6PMu93rzzvinnuD7MHUKQ@mail.gmail.com>
 <PH0PR12MB548169C04642C7C7585FF7FFDCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CAJs=3_BmSzMYn7OtB9EY4+D9oo11PV5__GtCxy+arbeWHgZZ6A@mail.gmail.com> <PH0PR12MB548128F8E4E3E0B032C5D694DCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB548128F8E4E3E0B032C5D694DCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Sat, 11 Feb 2023 18:13:55 +0200
Message-ID: <CAJs=3_B6SZ1YTGc-2KzhYOpnxQ9rX8SKX3xQoD2EmaDTvT8psQ@mail.gmail.com>
Subject: Re: [virtio-comment] Re: [PATCH v2] virtio-net: support the virtqueue
 coalescing moderation
Content-Type: text/plain; charset="UTF-8"
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

I think that I wasn't clear enough.

I'm not saying that we should not define in the spec how to handle a
situation when a device receives both  RX_SET and VQ_SET (or a driver
sends both).
I'm saying that I don't think that the driver should handle the
situation the way you described it:

> When the driver prefers to use per virtqueue notifications coalescing, and if queue group (transmit or receive) level notification coalescing is enabled, driver SHOULD first disable device level notification coalescing.
> Or it should be,
>
> Virtqueue level notifications coalescing, and device level notifications can be enabled together.
> When both of them are enabled, per virtqueue notifications coalescing take priority over queue group level.

This implies that we have 2 modes and have priorities.

I think that if we want to refer to this situation in the spec, it
should be something like:
"A Device should use the last coalescing parameters received for a
virtqueue, regardless of the command used to deliver the parameters."
(just an example to make the point).

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

