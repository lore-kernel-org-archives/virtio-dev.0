Return-Path: virtio-return-2847-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 30 Jan 2018 11:16:59 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180130111659.007465ec.cohuck@redhat.com>
In-Reply-To: <1516665617-30748-4-git-send-email-mst@redhat.com>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
	<1516665617-30748-4-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio] [PATCH v7 04/11] content: replace mentions of len with
 used length
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 23 Jan 2018 02:01:03 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Document buffer used len and use that terminology everywhere in the
> generic section.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  content.tex | 39 ++++++++++++++++++++-------------------
>  1 file changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/content.tex b/content.tex
> index 3b4579e..4350ecf 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -242,7 +242,8 @@ a used buffer to the queue - i.e. lets the driver
>  know by marking the buffer as used. Device can then trigger
>  a device event - i.e. send an interrupt to the driver.
>  
> -For queue operation detail, see \ref{sec:Basic Facilities of a Virtio Device / Split Virtqueues}~\nameref{sec:Basic Facilities of a Virtio Device / Split Virtqueues}.

Why are you dropping this?

> +Device reports the number of bytes it has written to memory for
> +each buffer it uses. This is referred to as ``used length''.
>  
>  \input{split-ring.tex}
>  

Otherwise, using the term "used length" looks good.

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

