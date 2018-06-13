Return-Path: virtio-return-3125-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Wed, 13 Jun 2018 11:44:43 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180613114443.4f7a6bba.cohuck@redhat.com>
In-Reply-To: <1528733518-24950-2-git-send-email-pasic@linux.ibm.com>
References: <1528733518-24950-1-git-send-email-pasic@linux.ibm.com>
	<1528733518-24950-2-git-send-email-pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [virtio] Re: [PATCH v2 1/6] notifications: unify notifications wording in
 core
To: Halil Pasic <pasic@linux.ibm.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael
 S. Tsirkin" <mst@redhat.com>, Pawel Moll <pawel.moll@arm.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 11 Jun 2018 18:11:53 +0200
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
>  cl-os.tex       |    2 +-
>  conformance.tex |    8 +++---
>  content.tex     |   26 +++++++++++--------
>  packed-ring.tex |   61 ++++++++++++++++++++++++++--------------------
>  split-ring.tex  |   72 ++++++++++++++++++++++++++++++++-----------------------
>  5 files changed, 96 insertions(+), 73 deletions(-)
> 

> diff --git a/content.tex b/content.tex
> index be18234..e1dcaea 100644
> --- a/content.tex
> +++ b/content.tex

(...)

> @@ -388,10 +391,11 @@ reads unless notified.
>  
>  \subsection{Notification of Device Configuration Changes}\label{sec:General Initialization And Device Operation / Device Operation / Notification of Device Configuration Changes}
>  
> -For devices where the device-specific configuration information can be changed, an
> -interrupt is delivered when a device-specific configuration change occurs.
> +For devices where the device-specific configuration information can be
> +changed, a configuration change notification is delivered when a

Perhaps better "is sent", to keep in line with the used/available
buffer notifications?

> +device-specific configuration change occurs.
>  
> -In addition, this interrupt is triggered by the device setting
> +In addition, this notification is triggered by the device setting
>  DEVICE_NEEDS_RESET (see \ref{sec:Basic Facilities of a Virtio Device / Device Status Field / DEVICENEEDSRESET}).
>  
>  \section{Device Cleanup}\label{sec:General Initialization And Device Operation / Device Cleanup}

(...)

> @@ -309,22 +310,20 @@ in the ring.
>  
>  \subsection{Driver and Device Event Suppression}
>  \label{sec:Packed Virtqueues / Driver and Device Event Suppression}
> -In many systems driver and device notifications involve
> +In many systems used and available buffer notifications involve
>  significant overhead. To mitigate this overhead,
>  each virtqueue includes two identical structures used for
>  controlling notifications between the device and the driver.
>  
>  The Driver Event Suppression structure is read-only by the
> -device and controls the events sent by the device
> -to the driver (e.g. interrupts).
> +device and controls the used buffer notifications (sent by the device
> +to the driver).

Drop the brackets?

>  
>  The Device Event Suppression structure is read-only by
> -the driver and controls the events sent by the driver
> -to the device (e.g. IO).
> +the driver and controls the available buffer notifications (sent by the
> +driver to the device).

Here as well.

>  
> -Each of these Event Suppression structures controls
> -both Descriptor Ring events and structure events, and
> -each includes the following fields:
> +Each of these Event Suppression includes the following fields:

"Event Suppression" what? Keep "structures"?

>  
>  \begin{description}
>  \item [Descriptor Ring Change Event Flags] Takes values:
> @@ -352,9 +351,9 @@ matches this value and a descriptor is
>  made available/used respectively.
>  \end{description}
>  
> -After writing out some descriptors, both the device and the driver
> +After writing out some descriptors, the device/driver

Keep this unchanged?

>  are expected to consult the relevant structure to find out
> -whether an interrupt/notification should be sent.
> +whether a(n) used/available buffer notification should be sent.

"whether a used respectively an available buffer notification..."?

>  
>  \subsubsection{Structure Size and Alignment}
>  \label{sec:Packed Virtqueues / Structure Size and Alignment}

---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

