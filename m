Return-Path: virtio-return-2883-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 12 Feb 2018 14:00:24 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180212140024.356a869d.cohuck@redhat.com>
In-Reply-To: <1518206354-29610-3-git-send-email-pasic@linux.vnet.ibm.com>
References: <1518206354-29610-1-git-send-email-pasic@linux.vnet.ibm.com>
	<1518206354-29610-3-git-send-email-pasic@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [PATCH 2/2] introduction: simplify the designation of legacy
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael
 S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri,  9 Feb 2018 20:59:14 +0100
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> The sentence designating the documents defining what later
> became known as the legacy virtio interface had the most
> important piece of information placed in parenthesis.
> 
> Let's reword this sentence so we avoid using an ambiguous designation
> based on a relative anchor (i.e. 'earlier drafts of this specification')
> and just use the absolute anchor (version 1.0).
> 
> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> ---
>  introduction.tex |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/introduction.tex b/introduction.tex
> index 979881e..78c340d 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -78,8 +78,8 @@ The key words ``MUST'', ``MUST NOT'', ``REQUIRED'', ``SHALL'', ``SHALL NOT'', ``
>  \subsection{Legacy Interface: Terminology}\label{intro:Legacy
>  Interface: Terminology}
>  
> -Earlier drafts of this specification (i.e. revisions before 1.0,
> -see e.g. \hyperref[intro:Virtio PCI Draft]{[Virtio PCI Draft]})
> +Specification drafts preceding version 1.0 of this specification
> +(e.g. see \hyperref[intro:Virtio PCI Draft]{[Virtio PCI Draft]})
>  defined a similar, but different
>  interface between the driver and the device.
>  Since these are widely deployed, this specification

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

