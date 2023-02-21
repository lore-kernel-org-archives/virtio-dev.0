Return-Path: <david.edmondson@oracle.com>
References: <20230221083852.32764-1-hengqi@linux.alibaba.com>
From: David Edmondson <david.edmondson@oracle.com>
Subject: Re: [PATCH v5] virtio-net: support the virtqueue coalescing moderation
Date: Tue, 21 Feb 2023 11:48:26 +0000
In-reply-to: <20230221083852.32764-1-hengqi@linux.alibaba.com>
Message-ID: <m25ybvdyl7.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, "Michael S . Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tuesday, 2023-02-21 at 16:38:52 +08, Heng Qi wrote:
> ...
> +A device MAY set the coalescing parameter to a value close to a power of 2 value.

What is this about?

If it is intended to indicate that a device may use a value different to
that passed by the driver, more text to describe that would be
useful. If not, what does it mean?
-- 
Oh there ain't no way to say I love you more.

