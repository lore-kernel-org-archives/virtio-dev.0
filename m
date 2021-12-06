Return-Path: <xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
message-id: <1638759805.4692223-1-xuanzhuo@linux.alibaba.com>
subject: Re: [virtio-dev] [PATCH v7 0/3] virtio: introduce VIRTIO_F_RING_RESET
 for reset queue
date: Mon, 06 Dec 2021 11:03:25 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
in-reply-to: <20211108062243.102360-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com, jasowang@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon,  8 Nov 2021 14:22:40 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> Hi All:
>
> This is a new version to support VIRTIO_F_RING_RESET. The feautre
> extends the basic facility to allow the driver to reset a virtqueue.
> This main motivation is to support the reset function of the queue of the
> network device.
>
> Please review.
>
> v7:
>     grammar correction
>
> v6:
>     The device MUST present consistent default values after queue reset.
>
> v5:
>     It is defined in the transports that the device can modify the default
>     value after reset, and the driver can use a different configuration to
>     re-enable the device.
>
> v4:
>     Cornelia Huck helped me more. Thanks.
>     MMIO support this.
>

Hi, everybody, is there anything else I need to do with this patch? When will
this patch be merged into, so that I can carry out follow-up work.

Thanks.

>
> Xuan Zhuo (3):
>   virtio: introduce virtqueue reset as basic facility
>   virtio: pci support virtqueue reset
>   virtio: mmio support virtqueue reset
>
>  content.tex | 111 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 110 insertions(+), 1 deletion(-)
>
> --
> 2.31.0
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

