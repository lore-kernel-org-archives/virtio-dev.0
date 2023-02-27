Return-Path: <mst@redhat.com>
Date: Mon, 27 Feb 2023 12:39:39 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 0/3] Rename queue index to queue number
Message-ID: <20230227123751-mutt-send-email-mst@kernel.org>
References: <20230223054624.168042-1-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230223054624.168042-1-parav@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com, virtio-comment@lists.oasis-open.org, shahafs@nvidia.com, Yuri Benditovich <yuri.benditovich@daynix.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 23, 2023 at 07:46:21AM +0200, Parav Pandit wrote:
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

What about RSS description in net? That says:

description.tex:Field \field{unclassified_queue} contains the 0-based index of

is the index same as vq number? or something different?





> ---
> Cornelia:
> I was not sure about ccw for vq_config_block and vq_info_block structures
> index field refers to the queue number or not.
> Can you please clarify?
> 
> If it vqn, I will send v1 by replacing index to vqn to be
> consistent with other part of the spec which also uses vqn.
> 
> Parav Pandit (3):
>   transport-pci: Refer to the vq by its number
>   transport-mmio: Rename QueueNum register
>   transport-mmio: Refer to the vq by its number
> 
>  transport-mmio.tex | 16 ++++++++--------
>  transport-pci.tex  |  6 +++---
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> -- 
> 2.26.2

