Return-Path: <virtio-comment-return-4151-cohuck=redhat.com@lists.oasis-open.org>
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
In-Reply-To: <PH0PR12MB548169C04642C7C7585FF7FFDCDF9@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Sat, 11 Feb 2023 17:46:40 +0200
Message-ID: <CAJs=3_BmSzMYn7OtB9EY4+D9oo11PV5__GtCxy+arbeWHgZZ6A@mail.gmail.com>
Subject: Re: [virtio-comment] Re: [PATCH v2] virtio-net: support the virtqueue
 coalescing moderation
Content-Type: text/plain; charset="UTF-8"
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

You write "both are configured", "try to configure both", "disable one
and switch to other" "mixed mode" etc..

But no modes/levels are mentioned in the patch, not once.

I totally agree that *if* we define 2 modes, we should have strict
rules on how to switch between modes and how to operate with both
modes.

But if we decide to have modes, your suggestion is not enough IMO, we
should explicitly define the modes.

In my POV, we should have no modes at all, everything is per queue,
and VIRTIO_NET_CTRL_NOTF_COAL_RX_SET is exactly the same as iterating
through the RX queues and issuing a VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
command.

Every queue will use the last coalescing parameters it received from
the driver, regardless to the command used to deliver the parameters.

No modes at all.

I really don't see what we gain from having different operation modes.

I thought that we agreed not to have operation modes in v1.

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

