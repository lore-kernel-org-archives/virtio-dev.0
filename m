Return-Path: <virtio-dev-return-10008-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BDB0D9863C4
	for <virtio-dev@lists.oasis-open.org>; Tue, 11 Oct 2022 09:20:44 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20221007165643.3920613-2-usama.arif@bytedance.com>
References: <20221007165643.3920613-1-usama.arif@bytedance.com>
 <20221007165643.3920613-2-usama.arif@bytedance.com>
Date: Tue, 11 Oct 2022 11:20:37 +0200
Message-ID: <87tu4ad8d6.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v3 1/4] content: Introduce driver/device
 auxiliary notifications
Content-Type: text/plain
To: Usama Arif <usama.arif@bytedance.com>, virtio-dev@lists.oasis-open.org
Cc: mst@redhat.com, stefanha@redhat.com, ndragazis@arrikto.com, fam.zheng@bytedance.com, liangma@liangbit.com, Usama Arif <usama.arif@bytedance.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Oct 07 2022, Usama Arif <usama.arif@bytedance.com> wrote:

> Driver auxiliary notifications allow the device to send notifications
> other than configuration changes and used buffer notifications to the
> driver, these are optional and their meaning is device-specific.
>
> Device auxiliary notifications allow the driver to send notifications
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
> ---
>  content.tex | 35 ++++++++++++++++++++++-------------
>  1 file changed, 22 insertions(+), 13 deletions(-)
>
> diff --git a/content.tex b/content.tex
> index e863709..49f9f2a 100644
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

Should we postfix the two new entries with "(optional)"?

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
> +notifications allow the driver to send notifications other than available
> +buffer notifications to the device for example through a device register, these
> +are optional and their meaning is device-specific.
>  
>  The semantics, the transport-specific implementations, and other
>  important aspects of the different notifications are specified in detail


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

