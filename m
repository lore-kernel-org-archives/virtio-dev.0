Return-Path: <mst@redhat.com>
Date: Tue, 9 Aug 2022 16:07:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH 1/4] content: Introduce driver/device auxiliary
 notifications
Message-ID: <20220809160711-mutt-send-email-mst@kernel.org>
References: <20220330152105.3770439-1-usama.arif@bytedance.com>
 <20220330152105.3770439-2-usama.arif@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <20220330152105.3770439-2-usama.arif@bytedance.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Usama Arif <usama.arif@bytedance.com>
Cc: virtio-dev@lists.oasis-open.org, stefanha@redhat.com, ndragazis@arrikto.com, fam.zheng@bytedance.com, liangma@liangbit.com, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Mar 30, 2022 at 04:21:02PM +0100, Usama Arif wrote:
> Driver auxiliary notifications allow the device to send notifications
> other than configuration changes and used buffer notifications to the
> driver, these are optional and their meaning is device-specific.
> 
> Device auxiliary notifcations allow the driver to send notifcations
> other than available buffer notifications to the device for example
> through a device register, these are optional and their meaning is
> device-specific.
> 
> These device-specific notifications are needed later when adding support
> for virtio-vhost-user device.
> 
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>

I see ccw is missing. Cornelia, any suggestions?

> ---
>  content.tex | 35 ++++++++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/content.tex b/content.tex
> index c6f116c..85980ac 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -160,29 +160,38 @@ \subsection{Legacy Interface: A Note on Feature
>  Specification text within these sections generally does not apply
>  to non-transitional devices.
>  
> -\section{Notifications}\label{sec:Basic Facilities of a Virtio Device
> -/ Notifications}
> +\section{Notifications}\label{sec:Basic Facilities of a Virtio Device / Notifications}
>  
>  The notion of sending a notification (driver to device or device
>  to driver) plays an important role in this specification. The
>  modus operandi of the notifications is transport specific.
>  
> -There are three types of notifications: 
> +There are five types of notifications:
>  \begin{itemize}
>  \item configuration change notification
>  \item available buffer notification
> -\item used buffer notification. 
> +\item used buffer notification
> +\item driver auxiliary notification
> +\item device auxiliary notification
>  \end{itemize}
>  
> -Configuration change notifications and used buffer notifications are sent
> -by the device, the recipient is the driver. A configuration change
> -notification indicates that the device configuration space has changed; a
> -used buffer notification indicates that a buffer may have been made used
> -on the virtqueue designated by the notification.
> -
> -Available buffer notifications are sent by the driver, the recipient is
> -the device. This type of notification indicates that a buffer may have
> -been made available on the virtqueue designated by the notification.
> +Configuration change notifications, used buffer notifications and
> +driver auxiliary notifications are sent by the device,
> +the recipient is the driver. A configuration change notification indicates
> +that the device configuration space has changed; a used buffer notification
> +indicates that a buffer may have been made used on the virtqueue designated
> +by the notification; driver auxiliary notifications allow the
> +device to send notifications other than configuration changes and used
> +buffer notifications to the driver, these are optional and their meaning
> +is device-specific.
> +
> +Available buffer notifications and device auxiliary notifications
> +are sent by the driver, the recipient is the device. Available buffer
> +notifications indicate that a buffer may have been made available on the
> +virtqueue designated by the notification; device auxiliary
> +notifcations allow the driver to send notifcations other than available
> +buffer notifications to the device for example through a device register, these
> +are optional and their meaning is device-specific.
>  
>  The semantics, the transport-specific implementations, and other
>  important aspects of the different notifications are specified in detail
> -- 
> 2.25.1

