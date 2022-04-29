Return-Path: <virtio-dev-return-9509-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7A4479865F1
	for <virtio-dev@lists.oasis-open.org>; Fri, 29 Apr 2022 08:07:32 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20220428221637.348443-1-parav@nvidia.com>
References: <20220428221637.348443-1-parav@nvidia.com>
Date: Fri, 29 Apr 2022 10:07:04 +0200
Message-ID: <87fslwl3dj.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v4] virtio: Improve queue_reset polarity to match to
 default reset state
Content-Type: text/plain
To: Parav Pandit <parav@nvidia.com>, virtio-dev@lists.oasis-open.org, xuanzhuo@linux.alibaba.com, jasowang@redhat.com, mst@redhat.com, virtio-comment@lists.oasis-open.org
Cc: stefanha@redhat.com, Parav Pandit <parav@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Apr 29 2022, Parav Pandit <parav@nvidia.com> wrote:

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
> d) 0,0 -> queue reset is ongoing
>    conflicts with #a, because queue is still enabled in device
>    whose reset is in progress.
>    External entity has no knowledge if VQ is undergoing reset or
>    VQ is never enabled.
> e) 0,1 -> queue reset is completed (conflicts with #a initial value)
>
> On next iteration, when queue_select selects the same VQ again,
> without enablement, device is confused to return 1 or 0 because
> it was reset once before via queue_reset register.
>
> This demands complex device implementation to understand what
> should be returned for a VQ that is reset using queue_reset register
> vs other means.
>
> Additionally, external entity that may have to manage a virtio device
> cannot distinguish between #a and #d, whether a VQ is not yet enabled
> or it is in use and undergoing a reset.
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
> v3->v4:
> - removed incorrect requirement to read queue_enable on resetting
>   the queue
> v2->v3:
> - Updated the commit log to capture the problem more accurately
> - Fixed below comments from Michael and Cornelia
> - Fixed adding article 'the' before driver
> - Change wording in driver requirements section to reflect driver
>   requirements reflecting device behavior
> - Added device compliance statement on what to return for queue_reset
>   register to indicate ongoing reset in progress
> - Moved device specific description adjacent to other device related
>   queue reset description
> v1->v2:
> - Fixed below comment from Xuan Zhuo
> - Fixed the configuration and register layout text to reflect the polarity
> v0->v1:
> - Fixed below comments from Michael
> - Removed example device side pseudo code for old and new polarity
> - Removed unwanted articles 'a' and 'the'
> - Dropped extra empty line
> ---
>  content.tex | 48 ++++++++++++++++++++----------------------------
>  1 file changed, 20 insertions(+), 28 deletions(-)
>
> diff --git a/content.tex b/content.tex
> index 060bdab..fdd255d 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -1029,19 +1029,15 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>  The device MUST present a 0 in \field{queue_enable} on reset.
>  
>  If VIRTIO_F_RING_RESET has been negotiated, the device MUST present a 0 in
> -\field{queue_enable} after the driver has reset the virtqueue via
> -\field{queue_reset}.
> -
> -If VIRTIO_F_RING_RESET has been negotiated, the device MUST present a 0 in
>  \field{queue_reset} on reset.
>  
>  If VIRTIO_F_RING_RESET has been negotiated, the device MUST present a 0 in
>  \field{queue_reset} after the virtqueue is enabled with \field{queue_enable}.
>  
> -The device MUST reset the queue when 1 is written to \field{queue_reset}, and
> -present a 1 in \field{queue_reset} after the queue has been reset, until the
> -driver re-enables the queue via \field{queue_enable} or the device is reset.
> -The device MUST present consistent default values after queue reset.
> +The device MUST reset the queue when 1 is written to \field{queue_reset}. The
> +device MUST continue to present 1 in \field{queue_reset} when the queue reset

s/when/as long as/

> +is ongoing. The device MUST present 0 in \field{queue_reset} and \field{queue_enable}

s/in/in both/

> +when queue reset completes.

Maybe "when queue reset has completed"?

>  (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
>  
>  The device MUST present a 0 in \field{queue_size} if the virtqueue
> @@ -1069,12 +1065,12 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>  The driver MUST NOT write a 0 to \field{queue_enable}.
>  
>  If VIRTIO_F_RING_RESET has been negotiated, after the driver writes 1 to
> -\field{queue_reset} to reset the queue, it MUST verify that the queue
> -has been reset by reading back \field{queue_reset} and ensuring that it
> -is 1. The driver MAY re-enable the queue by writing a 1 to
> -\field{queue_enable} after ensuring that the other virtqueue fields have
> -been set up correctly. The driver MAY set driver-writeable queue configuration
> -values to different values than those that were used before the queue reset.
> +\field{queue_reset} to reset the queue, the driver MUST NOT consider queue
> +reset to be complete until it reads back 0 in \field{queue_reset}. The driver
> +MAY re-enable the queue by writing 1 to \field{queue_enable} after ensuring
> +that other virtqueue fields have been set up correctly. The driver MAY set
> +driver-writeable queue configuration values to different values than those that
> +were used before the queue reset.
>  (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
>  
>  \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
> @@ -2005,19 +2001,15 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>  The device MUST NOT access virtual queue contents when \field{QueueReady} is zero (0x0).
>  
>  If VIRTIO_F_RING_RESET has been negotiated, the device MUST present a 0 in
> -\field{QueueReady} after the driver has reset the virtqueue via
> -\field{QueueReset}.
> -
> -If VIRTIO_F_RING_RESET has been negotiated, the device MUST present a 0 in
>  \field{QueueReset} on reset.
>  
>  If VIRTIO_F_RING_RESET has been negotiated, The device MUST present a 0 in
>  \field{QueueReset} after the virtqueue is enabled with \field{QueueReady}.
>  
> -The device MUST reset the queue when 1 is written to \field{QueueReset}, and
> -present a 1 in \field{QueueReset} after the queue has been reset, until the
> -driver re-enables the queue via \field{QueueReady} or until the device is reset.
> -The device MUST present consistent default values after queue reset.
> +The device MUST reset the queue when 1 is written to \field{QueueReset}. The
> +device MUST continue to present 1 in \field{QueueReset} when the queue reset

s/when/as long as/

> +is ongoing. The device MUST present 0 in \field{QueueReset} and \field{QueueReady}

s/in/in both/

> +when queue reset completes.

Maybe "has completed" here as well.

>  (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
>  
>  \drivernormative{\subsubsection}{MMIO Device Register Layout}{Virtio Transport Options / Virtio Over MMIO / MMIO Device Register Layout}
> @@ -2063,12 +2055,12 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>  it finishes handling an interrupt and MUST NOT set any of the undefined bits in the value.
>  
>  If VIRTIO_F_RING_RESET has been negotiated, after the driver writes 1 to
> -\field{QueueReset} to reset the queue, it MUST verify that the queue
> -has been reset by reading back \field{QueueReset} and ensuring that it
> -is 1. The driver MAY re-enable the queue by writing a 1 to
> -\field{QueueReady} after ensuring that the other virtqueue fields have
> -been set up correctly. The driver MAY set driver-writeable queue configuration
> -values to different values than those that were used before the queue reset.
> +\field{QueueReset} to reset the queue, the driver MUST NOT consider queue
> +reset to be complete until it reads back 0 in \field{QueueReset}. The driver
> +MAY re-enable the queue by writing 1 to \field{QueueReady} after ensuring
> +that other virtqueue fields have been set up correctly. The driver MAY set
> +driver-writeable queue configuration values to different values than those
> +that were used before the queue reset.
>  (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
>  
>  \subsection{MMIO-specific Initialization And Device Operation}\label{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation}


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

