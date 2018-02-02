Return-Path: virtio-return-2861-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Fri, 2 Feb 2018 12:06:52 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180202120652.38ef480e.cohuck@redhat.com>
In-Reply-To: <1516665617-30748-11-git-send-email-mst@redhat.com>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
	<1516665617-30748-11-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio] [PATCH v7 11/11] split-ring: in order feature
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 23 Jan 2018 02:01:09 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> For a split ring, require that drivers use descriptors in order too.
> This allows devices to skip reading the available ring.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  split-ring.tex | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/split-ring.tex b/split-ring.tex
> index f976e45..43c496c 100644
> --- a/split-ring.tex
> +++ b/split-ring.tex

> @@ -218,6 +222,12 @@ purposes).
>  Drivers MUST NOT add a descriptor chain over than $2^{32}$ bytes long in total;
>  this implies that loops in the descriptor chain are forbidden!
>  
> +If VIRTIO_F_IN_ORDER has been negotiated, and when making a
> +descriptor with VRING_DESC_F_NEXT set in \field{flags} at offset
> +$x$ in the table available to the device, driver MUST set
> +\field{next} to $0$ for the last descriptor in the table
> +(where $x = queue_size - 1$) and to $x + 1$ for the rest of the descriptors.

The underscore in queue_size makes this a subscript s, which is
probably not what you want :)

> +
>  \subsubsection{Indirect Descriptors}\label{sec:Basic Facilities of a Virtio Device / Virtqueues / The Virtqueue Descriptor Table / Indirect Descriptors}
>  
>  Some devices benefit by concurrently dispatching a large number

Otherwise,

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

