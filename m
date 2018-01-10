Return-Path: virtio-return-2823-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 10 Jan 2018 13:45:22 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180110134522.6436758d.cohuck@redhat.com>
In-Reply-To: <1515577653-9336-2-git-send-email-mst@redhat.com>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
	<1515577653-9336-2-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio] [PATCH v6 1/5] content: move 1.0 queue format out to a
 separate section
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 10 Jan 2018 11:47:55 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  content.tex | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/content.tex b/content.tex
> index c7ef7fd..4483a4b 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -230,7 +230,30 @@ result.
>  The mechanism for bulk data transport on virtio devices is
>  pretentiously called a virtqueue. Each device can have zero or more
>  virtqueues\footnote{For example, the simplest network device has one virtqueue for
> -transmit and one for receive.}.  Each queue has a 16-bit queue size
> +transmit and one for receive.}.
> +
> +Driver makes requests available to device by adding
> +an available buffer to the queue - i.e. adding a buffer
> +describing the request to a virtqueue, and optionally triggering
> +a driver event - i.e. sending a notification to the device.
> +
> +Device executes the requests and - when complete - adds
> +a used buffer to the queue - i.e. lets the driver
> +know by marking the buffer as used. Device can then trigger
> +a device event - i.e. send an interrupt to the driver.
> +
> +For queue operation detail, see \ref{sec:Basic Facilities of a Virtio Device / Split Virtqueues}~\nameref{sec:Basic Facilities of a Virtio Device / Split Virtqueues}.
> +
> +\section{Split Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Split Virtqueues}
> +The split virtqueue format is the original format used by legacy
> +virtio devices.  

I think the term 'legacy' is a bit confusing here. Elsewhere, 'legacy'
refers to pre-standard devices, and while they use a variant of this
layout, I don't think we should mix this up with 1.0 devices.

What about:

"The split virtqueue format is the original format used by devices
conforming to the 1.0 version of this standard (and a variant thereof
by legacy virtio devices)."

> The split virtqueue format separates the
> +virtqueue into several parts, where each part is write-able by
> +either the driver or the device, but not both. Multiple
> +locations need to be updated when making a buffer available
> +and when marking it as used.
> +
> +
> +Each queue has a 16-bit queue size
>  parameter, which sets the number of entries and implies the total size
>  of the queue.
>  


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

