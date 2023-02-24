Return-Path: <jiri@nvidia.com>
Date: Fri, 24 Feb 2023 11:06:22 +0100
From: Jiri Pirko <jiri@nvidia.com>
Subject: Re: [virtio-dev] [PATCH 2/3] transport-mmio: Rename QueueNum register
Message-ID: <Y/iMHsSWc7aaB/1Z@nanopsycho>
References: <20230223054624.168042-1-parav@nvidia.com>
 <20230223054624.168042-3-parav@nvidia.com>
In-Reply-To: <20230223054624.168042-3-parav@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

Thu, Feb 23, 2023 at 06:46:23AM CET, parav@nvidia.com wrote:
>Currently, the specification uses virtqueue index and number
>interchangeably to refer to the virtqueue.
>
>It is better to identify it using one terminology.
>
>Two registers QueueNumMax and QueueNum actually reflect the queue size
>or queue depth indicating max and actual number of entries in the queue.
>Equivalent register in PCI transport is named differently as queue_size.
>
>To bring consistency between pci and mmio transport, and to avoid
>confusion between number and index, rename the QueueNumMax and QueueNum
>registers to QueueSizeMax and QueueSize respectively.
>
>[1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00527.html
>
>Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
>Signed-off-by: Parav Pandit <parav@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

