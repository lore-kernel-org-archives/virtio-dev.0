Return-Path: <jiri@nvidia.com>
Date: Fri, 24 Feb 2023 11:05:52 +0100
From: Jiri Pirko <jiri@nvidia.com>
Subject: Re: [virtio-dev] [PATCH 1/3] transport-pci: Refer to the vq by its
 number
Message-ID: <Y/iMABJUSa+XL4Q8@nanopsycho>
References: <20230223054624.168042-1-parav@nvidia.com>
 <20230223054624.168042-2-parav@nvidia.com>
In-Reply-To: <20230223054624.168042-2-parav@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: mst@redhat.com, virtio-dev@lists.oasis-open.org, cohuck@redhat.com, virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

Thu, Feb 23, 2023 at 06:46:22AM CET, parav@nvidia.com wrote:
>Currently specification uses virtqueue index and
>number interchangeably to refer to the virtqueue.
>
>Instead refer to it by its number.
>
>This patch is on top of [1].
>
>[1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00527.html
>
>Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
>Signed-off-by: Parav Pandit <parav@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

