Return-Path: virtio-dev-return-2953-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Date: Wed, 10 Jan 2018 22:08:01 +0800
From: Tiwei Bie <tiwei.bie@intel.com>
Message-ID: <20180110140801.zbiwgs6jgo5ptjff@debian-xvivbkq.sh.intel.com>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
 <1515577653-9336-5-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1515577653-9336-5-git-send-email-mst@redhat.com>
Subject: Re: [virtio-dev] [PATCH v6 4/5] packed virtqueues: more efficient
 virtqueue layout
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 10, 2018 at 11:47:58AM +0200, Michael S. Tsirkin wrote:
> Performance analysis of this is in my kvm forum 2016 presentation.  The
> idea is to have a r/w descriptor in a ring structure, replacing the used
> and available ring, index and descriptor buffer.
> 
> This is also easier for devices to implement than the 1.0 layout.
> Several more enhancements will be necessary to actually make this
> efficient for devices to use.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  content.tex     |  36 ++-
>  packed-ring.tex | 668 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 701 insertions(+), 3 deletions(-)
>  create mode 100644 packed-ring.tex
> 
> diff --git a/content.tex b/content.tex
> index 3b4579e..3059bd3 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -242,10 +242,26 @@ a used buffer to the queue - i.e. lets the driver
>  know by marking the buffer as used. Device can then trigger
>  a device event - i.e. send an interrupt to the driver.
>  
> -For queue operation detail, see \ref{sec:Basic Facilities of a Virtio Device / Split Virtqueues}~\nameref{sec:Basic Facilities of a Virtio Device / Split Virtqueues}.
> +Device is not generally required to use buffers in
> +the same order in which they have been made available
> +by the driver.
> +
> +Some devices always use descriptors in the same order in which
> +they have been made available. These devices can offer the
> +VIRTIO_F_IN_ORDER feature. If negotiated, this knowledge
> +might allow optimizations or simplify driver code.

Does this mean that for "Split Virtqueues" if VIRTIO_F_IN_ORDER
feature is negotiated, drivers won't be required to access the
id field of used_elem to figure out the desc idx when processing
the used ring?

> +
> +Two formats are supported: Split Virtqueues (see \ref{sec:Basic
> +Facilities of a Virtio Device / Split
> +Virtqueues}~\nameref{sec:Basic Facilities of a Virtio Device /
> +Split Virtqueues}) and Packed Virtqueues (see \ref{sec:Basic
> +Facilities of a Virtio Device / Packed
> +Virtqueues}~\nameref{sec:Basic Facilities of a Virtio Device /
> +Packed Virtqueues}).
>  
>  \input{split-ring.tex}
>  
> +\input{packed-ring.tex}
[...]
> +Below is an example driver code. It does not attempt to reduce
> +the number of device interrupts, neither does it support
> +the VIRTIO_F_RING_EVENT_IDX feature.
> +
> +\begin{lstlisting}
> +
> +first = vq->next_avail;
> +id = alloc_id(vq);
> +
> +for (each buffer element b) {
> +        vq->desc[vq->next_avail].address = get_addr(b);
> +        vq->desc[vq->next_avail].len = get_len(b);
> +        init_desc(vq->next_avail, b);
> +        avail = vq->avail_wrap_count;
> +        used = !vq->avail_wrap_count;
> +        f = get_flags(b) | (avail << VIRTQ_DESC_F_AVAIL) | (used << VIRTQ_DESC_F_USED);
> +        if (vq->next_avail == first) {
> +                flags = f;

This is to implement the batching? I.e. don't make the first
desc available to the device before other descs are ready?

> +        } else {
> +                vq->desc[vq->next_avail].flags = f;
> +        }

The vq->next_avail updating is missing in the loop?

> +
> +}
> +vq->desc[vq->next_avail].id = id;
> +write_memory_barrier();
> +vq->desc[first].flags = flags;
> +
> +memory_barrier();
> +
> +if (vq->driver_event.flags != 0x3) {
> +        notify_device(vq, vq->next_avail, vq->avail_wrap_count);
> +}
> +
> +vq->next_avail++;
> +
> +if (vq->next_avail > vq->size) {

Should be (vq->next_avail >= vq->size)?

> +        vq->next_avail = 0;
> +        vq->avail_wrap_count \^= 1;
> +}
> +
> +\end{lstlisting}
> +
[...]
> +\begin{lstlisting}
> +vq->device_event.flags = 0x3;
> +
> +for (;;) {
> +        flags = vq->desc[vq->next_used].flags;
> +        bool avail = flags & (1 << VIRTQ_DESC_F_AVAIL);
> +        bool used = flags & (1 << VIRTQ_DESC_F_USED);
> +
> +        if (avail != used) {
> +                vq->device_event.flags = 0x1;
> +                mb();
> +
> +                flags = vq->desc[vq->next_used].flags;
> +                bool avail = flags & (1 << VIRTQ_DESC_F_AVAIL);
> +                bool used = flags & (1 << VIRTQ_DESC_F_USED);
> +                if (avail != used) {
> +                        break;
> +                }
> +
> +                vq->device_event.flags = 0x3;
> +        }
> +
> +        struct virtq_desc *d = vq->desc[vq->next_used];
> +        process_buffer(d);
> +        vq->next_used++;
> +        if (vq->next_used > vq->size) {

Should be (vq->next_used >= vq->size)?

> +                vq->next_used = 0;
> +        }
> +}
> +\end{lstlisting}
> -- 
> MST

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

