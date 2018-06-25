Return-Path: virtio-return-3156-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Mon, 25 Jun 2018 16:45:12 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180625164512.720767c5.cohuck@redhat.com>
In-Reply-To: <1529929292-11900-2-git-send-email-pasic@linux.ibm.com>
References: <1529929292-11900-1-git-send-email-pasic@linux.ibm.com>
	<1529929292-11900-2-git-send-email-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [PATCH v3 1/6] notifications: unify notifications wording in
 core
To: Halil Pasic <pasic@linux.ibm.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael
 S. Tsirkin" <mst@redhat.com>, Pawel Moll <pawel.moll@arm.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 25 Jun 2018 14:21:27 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> Let us unify the wording when talking about notifications. This change
> establishes the terms available buffer notification for what was usually
> simply called notification or virtqueue notification in v1.0 and used
> buffer notification for what was usually called interrupt.
> 
> The term configuration change notification in kept where called so and
> consolidated where it's called configuration change interrupt or
> similar.
> 
> The changes done here are limited to the core part, and don't
> conceptually involve neither the transports nor the devices (references
> are updated though). Future changes should address these parts.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
> v2 -> v3
> * Addressed all comments by Connie and Stefan (changed both directions
> with the my nonsensical "i.e.'s" that was pointed out by Stefan)
> * Added unrelated grammar fix s/writes entry/writes an entry/ (Stefan)
> ---
>  cl-os.tex       |    2 +-
>  conformance.tex |    8 +++---
>  content.tex     |   26 +++++++++++--------
>  packed-ring.tex |   60 ++++++++++++++++++++++++++--------------------
>  split-ring.tex  |   72 ++++++++++++++++++++++++++++++++-----------------------
>  5 files changed, 96 insertions(+), 72 deletions(-)
> 

> diff --git a/content.tex b/content.tex
> index be18234..9b1f3e1 100644
> --- a/content.tex
> +++ b/content.tex
(...)
> @@ -235,12 +236,13 @@ transmit and one for receive.}.
>  Driver makes requests available to device by adding
>  an available buffer to the queue - i.e. adding a buffer
>  describing the request to a virtqueue, and optionally triggering
> -a driver event - i.e. sending a notification to the device.
> +a driver event - i.e. sending an available buffer notification
> +to the device.
>  
>  Device executes the requests and - when complete - adds
>  a used buffer to the queue - i.e. lets the driver
>  know by marking the buffer as used. Device can then trigger
> -a device event - i.e. send an interrupt to the driver.
> +a device event - i.e. send a used buffer notification to the driver.
>  
>  Device reports the number of bytes it has written to memory for
>  each buffer it uses. This is referred to as ``used length''.

Unrelated: Device and driver are missing the definite article in some
places. Might be an idea for an additional patch :)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

