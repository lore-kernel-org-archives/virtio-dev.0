Return-Path: virtio-return-2846-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Tue, 30 Jan 2018 11:12:14 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180130111214.342fdbfa.cohuck@redhat.com>
In-Reply-To: <1516665617-30748-3-git-send-email-mst@redhat.com>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
	<1516665617-30748-3-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [virtio] [PATCH v7 03/11] content: move virtqueue operation
 description
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, 23 Jan 2018 02:01:02 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> virtqueue operation description is specific to the virtqueue
> format. Move it out to split-ring.tex and update all
> references.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  conformance.tex |   4 +-
>  content.tex     | 171 +++---------------------------------------------------
>  split-ring.tex  | 175 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 182 insertions(+), 168 deletions(-)

> diff --git a/split-ring.tex b/split-ring.tex
> index 418f63d..724bb82 100644
> --- a/split-ring.tex
> +++ b/split-ring.tex
> @@ -1,12 +1,13 @@
>  \section{Split Virtqueues}\label{sec:Basic Facilities of a Virtio Device / Split Virtqueues}
> -The split virtqueue format is the original format used by legacy
> -virtio devices.  The split virtqueue format separates the
> +The split virtqueue format is the original format used by devices
> +conforming to the 1.0 version of this standard (and a variant thereof
> +by legacy virtio devices).

Ah, just noticed this hunk. Might make sense to move this to a prior
patch, although it does not matter in the end.

> +The split virtqueue format separates the
>  virtqueue into several parts, where each part is write-able by
>  either the driver or the device, but not both. Multiple
>  locations need to be updated when making a buffer available
>  and when marking it as used.
>  
> -

Dito here (should probably go to a prior patch).

>  Each queue has a 16-bit queue size
>  parameter, which sets the number of entries and implies the total size
>  of the queue.

Else:

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

