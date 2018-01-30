Return-Path: virtio-return-2849-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 30 Jan 2018 11:31:18 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180130113118.78d9c2f3.cohuck@redhat.com>
In-Reply-To: <1516665617-30748-6-git-send-email-mst@redhat.com>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
	<1516665617-30748-6-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio] [PATCH v7 06/11] content: generalize rest of text
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 23 Jan 2018 02:01:05 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  content.tex | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/content.tex b/content.tex
> index 9fc9673..5634c7d 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -1467,8 +1467,7 @@ All register values are organized as Little Endian.
>    }
>    \hline 
>    \mmioreg{QueueNum}{Virtual queue size}{0x038}{W}{%
> -    Queue size is the number of elements in the queue, therefore in each
> -    of the Descriptor Table, the Available Ring and the Used Ring.
> +    Queue size is the number of elements in the queue.
>      Writing to this register notifies the device what size of the
>      queue the driver will use. This applies to the queue selected by
>      writing to \field{QueueSel}.
> @@ -1491,9 +1490,9 @@ All register values are organized as Little Endian.
>      caused the device interrupt to be asserted.
>      The following events are possible:
>      \begin{description}
> -      \item[Used Ring Update] - bit 0 - the interrupt was asserted
> -        because the device has updated the Used
> -        Ring in at least one of the active virtual queues.
> +      \item[Used Buffer Update] - bit 0 - the interrupt was asserted
> +        because the device has used a buffer
> +        in at least one of the active virtual queues.
>        \item [Configuration Change] - bit 1 - the interrupt was
>          asserted because the configuration of the device has changed.
>      \end{description}
> @@ -1642,9 +1641,8 @@ The driver will typically initialize the virtual queue in the following way:
>     \field{QueueNumMax}. If the returned value is zero (0x0) the
>     queue is not available.
>  
> -\item Allocate and zero the queue pages, making sure the memory
> -   is physically contiguous. It is recommended to align the
> -   Used Ring to an optimal boundary (usually the page size).
> +\item Allocate and zero the queue memory, making sure the memory
> +   is physically contiguous.

What about recommendations of that type? Will we want some kind of
"best practice" suggestions (layout and/or transport specific?)

>  
>  \item Notify the device about the queue size by writing the size to
>     \field{QueueNum}.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

