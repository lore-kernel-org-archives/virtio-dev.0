Return-Path: <jasowang@redhat.com>
MIME-Version: 1.0
References: <20220425204225.288309-1-parav@nvidia.com>
In-Reply-To: <20220425204225.288309-1-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Apr 2022 12:01:45 +0800
Message-ID: <CACGkMEu1hZvBvi5wY8_rCzB3zJ7q_qOWgSNZiOBWuW69p_T+Nw@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] virtio: Improve queue_reset polarity to
 match to default reset state
Content-Type: text/plain; charset="UTF-8"
To: Parav Pandit <parav@nvidia.com>
Cc: Virtio-Dev <virtio-dev@lists.oasis-open.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, mst <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Apr 26, 2022 at 4:43 AM Parav Pandit <parav@nvidia.com> wrote:
>
> Currently when driver initiates a queue reset, device is expected
> to communicate reset status to the driver by changing the value of the
> queue_reset register twice. First to return value other than 1 when
> reset is ongoing, later to return 1 when queue reset is completed.
>
> However initially during the device reset time the queue reset value
> is zero. queue_reset changes the value of the register to a different
> value on reset completion. Yet another time queue_reset value is
> expected to change when queue_select is reprogrammed.
>
> For example in below flow, a created virtqueue, which is disabled
> by driver leaves the queue state as
> queue_enable = 0, queue_reset = 1.
>
> example flow:
> a) 0,0 -> device init time value
> b) 1,0 -> vq is enabled by driver and working
> c) 1,1 -> vq is enabled, driver initiated reset
> d) 1,0 -> vq is enabled, but device is busy doing the reset
> e) 0,1 -> vq reset is completed in the device and VQ is now disabled
> (conflict with initial queue reset state #a above)
>
> On next iteration, when queue_select selects the same VQ again,
> without enablement, device is confused to return 1 or 0 because
> it was reset once before via queue_reset register.
>
> This demands complex device implementation to understand what
> should be returned for a VQ that is reset using queue_reset register
> vs other means.
>
> Instead, it is better and efficient to maintain the same VQ state
> on the device when queue reset is completed.
>
> new proposed flow:
> q_enable, q_reset
> A) 0, 0 -> default, device init time
> B) 1, 0 -> driver has enabled vq

I wonder whether we it's more consistent with device reset than using
write to clear if we do

B) 1, 1 -> driver has enabled vq
C) 1, 1 -> driver starts q rest by writing 0
D) 1, 1 -> device is resetting vq
E) 0, 0 -> vq is rest and disabled

> C) 1, 1 -> driver started q reset
> D) 1, 1 -> q_reset stays 1 until device is busy resetting vq
> (device communicates that its working on resetting VQ, consistent with #C)
> E) 0, 0 -> q_reset by device is completed, q got disabled
> (consistent with device init time #A)

Is it too late to simply use a single queue_enable rather than
introducing queue_rest?

Thanks

>
> Otherwise a device needs to maintain complex state as,
>
> Current device side implementation requires something like,
> device.vq_reset_register_read()
> {
>   if (vq.reset_started) {
>     if (vq.reset_completed)
>       return queue_reset = 1;
>     else if (vq.reset_in_progress)
>       return queue_reset = 0;
>   } else {
>       when vq.queue_select, and vq.queue_enable = 1,
>       and if vq.reset_completed. {
>         do extra queue_reset = 0;
>         vq.reset_completed = 0; /* so that it can go back to original state */
>       }
>      return queue_reset = 0;
>   }
> }
>
> Compare to above, it is more efficient for device to do:
>
> device.vq_reset_register_read()
> {
>   /* return current state of queue_reset;
>    * if reset is ongoing, return 1.
>    * if reset is completed or not done ever, return 0.
>    */
>   return vq.queue_reset;
> }
>
> Hence, this patch proposes a simple change to have reset register
> polarity to be same as that of initial reset value.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/139
> Fixes: 12998e738621 ("virtio: pci support virtqueue reset")
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> ---
>  content.tex | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>
> diff --git a/content.tex b/content.tex
> index 060bdab..77c1c66 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -1069,14 +1069,18 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>  The driver MUST NOT write a 0 to \field{queue_enable}.
>
>  If VIRTIO_F_RING_RESET has been negotiated, after the driver writes 1 to
> -\field{queue_reset} to reset the queue, it MUST verify that the queue
> -has been reset by reading back \field{queue_reset} and ensuring that it
> -is 1. The driver MAY re-enable the queue by writing a 1 to
> +\field{queue_reset} to reset the queue, driver MUST verify that the queue
> +has been reset by reading back \field{queue_reset} until device returns a value of 0.
> +Device continue to report value of 1 for the \field{queue_reset} until device finishes
> +the queue reset request. When the device completes the queue reset, \field{queue_reset}
> +and \field{queue_enable} set to zero, indicating
> +that specified queue is ready to be enabled again. The driver MAY re-enable the queue by writing a 1 to
>  \field{queue_enable} after ensuring that the other virtqueue fields have
>  been set up correctly. The driver MAY set driver-writeable queue configuration
>  values to different values than those that were used before the queue reset.
>  (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
>
> +
>  \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
>
>  The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
> @@ -2063,9 +2067,12 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>  it finishes handling an interrupt and MUST NOT set any of the undefined bits in the value.
>
>  If VIRTIO_F_RING_RESET has been negotiated, after the driver writes 1 to
> -\field{QueueReset} to reset the queue, it MUST verify that the queue
> -has been reset by reading back \field{QueueReset} and ensuring that it
> -is 1. The driver MAY re-enable the queue by writing a 1 to
> +\field{QueueReset} to reset the queue, driver MUST verify that the queue
> +has been reset by reading back \field{QueueReset} until device returns a value of 0.
> +Device continue to report value of 1 for the \field{QueueReset} until device finishes
> +the reset. When the device completes the queue reset, \field{QueueReset} and
> +\field{QueueReady} set to zero, indicating that specified queue is ready to be
> +enabled again. The driver MAY re-enable the queue by writing a 1 to
>  \field{QueueReady} after ensuring that the other virtqueue fields have
>  been set up correctly. The driver MAY set driver-writeable queue configuration
>  values to different values than those that were used before the queue reset.
> --
> 1.8.3.1
>
>
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

