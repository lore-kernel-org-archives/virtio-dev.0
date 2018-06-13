Return-Path: virtio-return-3126-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 13 Jun 2018 11:48:12 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180613114812.19e65bb1.cohuck@redhat.com>
In-Reply-To: <1528733518-24950-3-git-send-email-pasic@linux.ibm.com>
References: <1528733518-24950-1-git-send-email-pasic@linux.ibm.com>
	<1528733518-24950-3-git-send-email-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [PATCH v2 2/6] notifications: notifications as basic virtio
 facility
To: Halil Pasic <pasic@linux.ibm.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael
 S. Tsirkin" <mst@redhat.com>, Pawel Moll <pawel.moll@arm.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 11 Jun 2018 18:11:54 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> Let's introduce notifications as basic virtio facility early on. This
> shall not only increase the cohesion between core and transport
> description by having a well-defined  place where notifications are
> introduced, but also give us the opportunity to explain some
> discrepancies.
> 
> Namely notifications sent by the device to the driver were often called
> interrupts prior to v1.1. Getting completely rid of that terminology is
> however not viable in case of some names.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> ---
>  content.tex |   36 ++++++++++++++++++++++++++++++++++++
>  1 files changed, 36 insertions(+), 0 deletions(-)
> 
> diff --git a/content.tex b/content.tex
> index e1dcaea..3aa9be8 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -8,6 +8,7 @@ device consists of the following parts:
>  \begin{itemize}
>  \item Device status field
>  \item Feature bits
> +\item Notifications
>  \item Device Configuration space
>  \item One or more virtqueues
>  \end{itemize}
> @@ -150,6 +151,41 @@ requirements documented within these legacy interface sections.
>  Specification text within these sections generally does not apply
>  to non-transitional devices.
>  
> +\section{Notifications}\label{sec:Basic Facilities of a Virtio Device
> +/ Notifications}
> +
> +The notion of sending a notification (driver to device or device
> +to driver) plays an important role in this specification. The
> +modus operandi of the notifications is transport specific.
> +
> +There are three types of notifications: 
> +\begin{itemize}
> +\item device configuration space notification

Shouldn't that be "configuration _change_ notification"?

> +\item available buffer notification
> +\item used buffer notification. 
> +\end{itemize}
> +
> +Device configuration space notifications and used buffer notifications
> +are sent by the device, the recipient is the driver. A device
> +configuration space notification indicates that a configuration space
> +has changed; a used buffer notification indicates that a buffer may
> +have been made used on the virtqueue designated by the notification.
> +
> +Available buffer notifications are sent by the driver, the recipient is
> +the device. This type of notification indicates that a buffer may have
> +been made available on the virtqueue designated by the notification.
> +
> +The semantic, the transport-specific implementations and other
> +important aspects of the different notifications are specified in detail
> +in the following chapters.
> +
> +Most transports implement notifications sent by the device to the
> +driver using interrupts. Therefore, in previous versions of this
> +specification, these notifications were often called interrupts.
> +Some names defined in this specification still retain this interrupt
> +terminology. Occasionally, the term event is used to refer to
> +a notification or a receipt of a notification.
> +
>  \section{Device Configuration Space}\label{sec:Basic Facilities of a Virtio Device / Device Configuration Space}
>  
>  Device configuration space is generally used for rarely-changing or


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

