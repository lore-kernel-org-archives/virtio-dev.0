Return-Path: <virtio-comment-return-4556-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20230223054624.168042-1-parav@nvidia.com>
References: <20230223054624.168042-1-parav@nvidia.com>
Date: Mon, 27 Feb 2023 09:45:31 +0100
Message-ID: <87a60z5wes.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH 0/3] Rename queue index to queue number
Content-Type: text/plain
To: Parav Pandit <parav@nvidia.com>, mst@redhat.com, virtio-dev@lists.oasis-open.org
Cc: virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 23 2023, Parav Pandit <parav@nvidia.com> wrote:

> 1. Currently, virtqueue is identified between driver and device
> interchangeably using either number of index terminology.
>
> 2. Between PCI and MMIO transport the queue size (depth) is
> defined as queue_size and QueueNum respectively.
>
> To avoid confusion and to have consistency, unify them to use as Number.
>
> Solution:
> Use virtqueue number description, and rename MMIO register as QueueSize.
>
> Patch summary:
> patch-1 renames index to number for pci transport
> patch-2 renames mmio register from Num to Size
> patch-3 renames index to number for mmio transport
>
> Please review.
> This series fixes the issue [1].
>
> This series is on top of [2].
>
> [1] https://github.com/oasis-tcs/virtio-spec/issues/163
> [2] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00527.html
>
> ---
> Cornelia:
> I was not sure about ccw for vq_config_block and vq_info_block structures
> index field refers to the queue number or not.
> Can you please clarify?
>
> If it vqn, I will send v1 by replacing index to vqn to be
> consistent with other part of the spec which also uses vqn.

The vq_*_block structures use "index" for the vq index/number and "num"
for the number of buffers (queue size).

I'm wondering what terminology we should standardize on. For the size of
the queue, we have queue_size, QueueNum, and num. Calling it some
variation of "queue size" and mentioning that it refers to the number of
buffers makes sense.

For the vq index/number, I'm not that sure that "virtqueue number" is
better that "virtqueue index" -- actually, I'd prefer the latter. We'd
need some renaming either way.


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

