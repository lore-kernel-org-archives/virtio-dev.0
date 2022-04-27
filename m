Return-Path: <xuanzhuo@linux.alibaba.com>
Message-ID: <1651051543.7111266-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v1] virtio: Improve queue_reset polarity to match to default reset state
Date: Wed, 27 Apr 2022 17:25:43 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220426000657.289786-1-parav@nvidia.com>
In-Reply-To: <20220426000657.289786-1-parav@nvidia.com>
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: Parav Pandit <parav@nvidia.com>
Cc: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org, xuanzhuo@linux.alibaba.com, jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 26 Apr 2022 03:06:57 +0300, Parav Pandit <parav@nvidia.com> wrote:
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
> C) 1, 1 -> driver started q reset
> D) 1, 1 -> q_reset stays 1 until device is busy resetting vq
> (device communicates that its working on resetting VQ, consistent with #C)
> E) 0, 0 -> q_reset by device is completed, q got disabled
> (consistent with device init time #A)
>
> Hence, this patch proposes a simple change to have reset register
> polarity to be same as that of initial reset value.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/139
> Fixes: 12998e738621 ("virtio: pci support virtqueue reset")
> Fixes: a4ce81a83780 ("virtio: mmio support virtqueue reset")
> Fixes: 3b5378d70a42 ("virtio: introduce virtqueue reset as basic facility")
> Signed-off-by: Parav Pandit <parav@nvidia.com>
>
> ---
> changelog:
> v0->v1:
> - Removed example device side pseudo code for old and new polarity
> - Removed unwanted articles 'a' and 'the'
> - Dropped extra empty line
> ---
>  content.tex | 26 ++++++++++++++++----------
>  1 file changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/content.tex b/content.tex
> index 060bdab..fc314ed 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -1039,7 +1039,7 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>  \field{queue_reset} after the virtqueue is enabled with \field{queue_enable}.
>
>  The device MUST reset the queue when 1 is written to \field{queue_reset}, and
> -present a 1 in \field{queue_reset} after the queue has been reset, until the
> +present 1 in \field{queue_reset} after the queue has been reset, until the

1 -> 0?

>  driver re-enables the queue via \field{queue_enable} or the device is reset.
>  The device MUST present consistent default values after queue reset.
>  (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
> @@ -1069,10 +1069,13 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>  The driver MUST NOT write a 0 to \field{queue_enable}.
>
>  If VIRTIO_F_RING_RESET has been negotiated, after the driver writes 1 to
> -\field{queue_reset} to reset the queue, it MUST verify that the queue
> -has been reset by reading back \field{queue_reset} and ensuring that it
> -is 1. The driver MAY re-enable the queue by writing a 1 to
> -\field{queue_enable} after ensuring that the other virtqueue fields have
> +\field{queue_reset} to reset the queue, driver MUST verify that the queue
> +has been reset by reading back \field{queue_reset} until device returns a value of 0.
> +Device continue to report value of 1 for the \field{queue_reset} until device finishes
> +the queue reset request. When the device completes the queue reset, \field{queue_reset}
> +and \field{queue_enable} set to zero, indicating
> +that specified queue is ready to be enabled again. The driver MAY re-enable the queue by writing 1 to
> +\field{queue_enable} after ensuring that other virtqueue fields have
>  been set up correctly. The driver MAY set driver-writeable queue configuration
>  values to different values than those that were used before the queue reset.
>  (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
> @@ -2015,7 +2018,7 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>  \field{QueueReset} after the virtqueue is enabled with \field{QueueReady}.
>
>  The device MUST reset the queue when 1 is written to \field{QueueReset}, and
> -present a 1 in \field{QueueReset} after the queue has been reset, until the
> +present 1 in \field{QueueReset} after the queue has been reset, until the

1 -> 0?

Thanks.

>  driver re-enables the queue via \field{QueueReady} or until the device is reset.
>  The device MUST present consistent default values after queue reset.
>  (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
> @@ -2063,10 +2066,13 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>  it finishes handling an interrupt and MUST NOT set any of the undefined bits in the value.
>
>  If VIRTIO_F_RING_RESET has been negotiated, after the driver writes 1 to
> -\field{QueueReset} to reset the queue, it MUST verify that the queue
> -has been reset by reading back \field{QueueReset} and ensuring that it
> -is 1. The driver MAY re-enable the queue by writing a 1 to
> -\field{QueueReady} after ensuring that the other virtqueue fields have
> +\field{QueueReset} to reset the queue, driver MUST verify that the queue
> +has been reset by reading back \field{QueueReset} until device returns a value of 0.
> +Device continue to report value of 1 for the \field{QueueReset} until device finishes
> +the reset. When the device completes the queue reset, \field{QueueReset} and
> +\field{QueueReady} set to zero, indicating that specified queue is ready to be
> +enabled again. The driver MAY re-enable the queue by writing 1 to
> +\field{QueueReady} after ensuring that other virtqueue fields have
>  been set up correctly. The driver MAY set driver-writeable queue configuration
>  values to different values than those that were used before the queue reset.
>  (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
> --
> 1.8.3.1
>

