Return-Path: <mst@redhat.com>
Date: Mon, 27 Feb 2023 12:36:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 2/3] transport-mmio: Rename QueueNum register
Message-ID: <20230227123423-mutt-send-email-mst@kernel.org>
References: <20230223054624.168042-1-parav@nvidia.com>
 <20230223054624.168042-3-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230223054624.168042-3-parav@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com, virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 23, 2023 at 07:46:23AM +0200, Parav Pandit wrote:
> Currently, the specification uses virtqueue index and number
> interchangeably to refer to the virtqueue.
> 
> It is better to identify it using one terminology.
> 
> Two registers QueueNumMax and QueueNum actually reflect the queue size
> or queue depth indicating max and actual number of entries in the queue.
> Equivalent register in PCI transport is named differently as queue_size.
> 
> To bring consistency between pci and mmio transport, and to avoid
> confusion between number and index, rename the QueueNumMax and QueueNum
> registers to QueueSizeMax and QueueSize respectively.
> 
> [1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00527.html
> 
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/163
> Signed-off-by: Parav Pandit <parav@nvidia.com>

I think this is a good change but it will confuse people
who have e.g. a driver source and are trying to match
it to te spec. Suggestions below


> ---
>  transport-mmio.tex | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/transport-mmio.tex b/transport-mmio.tex
> index 65bae54..c59975e 100644
> --- a/transport-mmio.tex
> +++ b/transport-mmio.tex
> @@ -104,14 +104,14 @@ \subsection{MMIO Device Register Layout}\label{sec:Virtio Transport Options / Vi
>      number of the first queue is zero (0x0).
>    }
>    \hline
> -  \mmioreg{QueueNumMax}{Maximum virtual queue size}{0x034}{R}{%
> +  \mmioreg{QueueSizeMax}{Maximum virtual queue size}{0x034}{R}{%

I would add something like "Note: this was previously known as QueueNumMax"
and same elsewhere.

>      Reading from the register returns the maximum size (number of
>      elements) of the queue the device is ready to process or
>      zero (0x0) if the queue is not available. This applies to the
>      queue selected by writing to \field{QueueSel}.

>    }
>    \hline
> -  \mmioreg{QueueNum}{Virtual queue size}{0x038}{W}{%
> +  \mmioreg{QueueSize}{Virtual queue size}{0x038}{W}{%
>      Queue size is the number of elements in the queue.
>      Writing to this register notifies the device what size of the
>      queue the driver will use. This applies to the queue selected by
> @@ -459,7 +459,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
>  .
>    }
>    \hline
> -  \mmioreg{QueueNumMax}{Maximum virtual queue size}{0x034}{R}{%
> +  \mmioreg{QueueSizeMax}{Maximum virtual queue size}{0x034}{R}{%
>      Reading from the register returns the maximum size of the queue
>      the device is ready to process or zero (0x0) if the queue is not
>      available. This applies to the queue selected by writing to

Same here.

> @@ -467,7 +467,7 @@ \subsection{Legacy interface}\label{sec:Virtio Transport Options / Virtio Over M
>      (0x0), so when the queue is not actively used.
>    }
>    \hline
> -  \mmioreg{QueueNum}{Virtual queue size}{0x038}{W}{%
> +  \mmioreg{QueueSize}{Virtual queue size}{0x038}{W}{%
>      Queue size is the number of elements in the queue.
>      Writing to this register notifies the device what size of the
>      queue the driver will use. This applies to the queue selected by

And here.

> -- 
> 2.26.2

