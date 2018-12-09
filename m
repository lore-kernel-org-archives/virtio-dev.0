Return-Path: virtio-return-3209-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Sun, 9 Dec 2018 09:10:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181209090352-mutt-send-email-mst@kernel.org>
References: <20181206191808.15691-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181206191808.15691-1-mst@redhat.com>
Subject: [virtio] Re: [PATCH] split-ring: document in-order operation
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: Jason Wang <jasowang@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Dec 06, 2018 at 02:18:16PM -0500, Michael S. Tsirkin wrote:
> The point of in-order for the device is to be able to skip
> writing out some used descriptors, but the documentation
> that we have was put in the packed ring section and
> written in a way specific to the packed ring.
> 
> Writing it in a generic way is tricky, for now this patch just copies
> the text from the packed ring to the split ring section, with minor
> tweaks.
> 
> Suggested-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/30

> ---
>  split-ring.tex | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/split-ring.tex b/split-ring.tex
> index 6f4a0a6..4e373d6 100644
> --- a/split-ring.tex
> +++ b/split-ring.tex
> @@ -466,6 +466,34 @@ that uninitialized memory has been overwritten when it has not.
>  The driver MUST NOT make assumptions about data in device-writable buffers
>  beyond the first \field{len} bytes, and SHOULD ignore this data.
>  
> +\subsection{In-order use of descriptors}
> +\label{sec:Basic Facilities of a Virtio Device / Virtqueues / In-order use of descriptors}
> +
> +Some devices always use descriptors in the same order in which
> +they have been made available. These devices can offer the
> +VIRTIO_F_IN_ORDER feature. If negotiated, this knowledge allows
> +devices to notify the use of a batch of buffers to the driver by
> +only writing out a single used ring entry with the \field{id}
> +corresponding to the head entry of the
> +descriptor chain describing the last buffer in the batch.
> +
> +The device then skips forward in the ring according to the size of
> +the batch. Accordingly, it increments the used \field{idx} by the
> +size of the batch.
> +
> +The driver needs to look up the used \field{id} and
> +calculate the batch size to be able to advance to where the next
> +used ring entry will be written by the device.
> +
> +This will result in the used ring entry at an offset matching the
> +first available ring entry in the batch, the used ring entry for
> +the next batch at an offset matching the first available ring
> +entry in the next batch, etc.
> +
> +The skipped buffers (for which no used ring entry was written)
> +are assumed to have been used (read or written) by the
> +device completely.
> +
>  \subsection{Available Buffer Notification Suppression}\label{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Notification Suppression}
>  
>  The device can suppress available buffer notifications in a manner
> -- 
> MST

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

