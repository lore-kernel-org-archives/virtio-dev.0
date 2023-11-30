Return-Path: <virtio-dev-return-14087-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C04CFC4167B
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Nov 2023 09:01:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0592A2AEDC
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Nov 2023 09:01:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DBD2398668B
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Nov 2023 09:01:09 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id C217798666F; Thu, 30 Nov 2023 09:01:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B1A5A986670
	for <virtio-dev@lists.oasis-open.org>; Thu, 30 Nov 2023 09:01:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: whtmrKjZOXmChmBExpYgQw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701334865; x=1701939665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNU1l5Prn4odXZCXbgzW7h5Gji1bJg0ks2wiyAJLqWw=;
        b=tIte1qHFHQrMCQouDnYZl8p+I672YZvPjnY3rnjpaR9KVHSVBBCUx/NGdWmKUIEo0b
         Hz8DacVPvFXZbligmxA76tKqkRUDpEJS+XkKe+u9vXZSRSWN7ZL1CM9ieS7Qe66pLh/q
         Shbc6KiRTlhlQHamWXGr8uJB3/6UKm08cIou5GRZpx6iCqJuQlVnBV8pLfidCrHrbHFi
         L0wogAGy0ZDN3t+ZzbjS2NOlm6+9dkur5oQYJJ+nEpHftrUkpsSUfckfE598oIyZrd9b
         IW3T5HCs0BaefYojobVQUiqZ1cm1lx3HUcfaHvvAEm1O31GuDMT8HkT0r/SSVA9iXNpk
         t+PQ==
X-Gm-Message-State: AOJu0YzMzQ1GizMryeHML5mN2LFEKKhenx4dVf7+KGf5YxUh3AztlsPv
	eG9sGvl0R+AGPZxDXvHmhEYXYwMSvBb1h0mkpjRE7kvqu+4LzmZod5l39wVuaoZfYV1a/t3w0M0
	cViMGEsK4dfY/nLKlrmWdfnh2Wfum
X-Received: by 2002:a5d:638d:0:b0:332:eeba:ee8f with SMTP id p13-20020a5d638d000000b00332eebaee8fmr12899884wru.11.1701334865299;
        Thu, 30 Nov 2023 01:01:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqULGMOZHavtF2MXEUBIbsY1pSSrssNmHiqOR1KdzcjEi0jriZdKYLKMhI0wbxgxw/x65R4w==
X-Received: by 2002:a5d:638d:0:b0:332:eeba:ee8f with SMTP id p13-20020a5d638d000000b00332eebaee8fmr12899859wru.11.1701334864814;
        Thu, 30 Nov 2023 01:01:04 -0800 (PST)
Date: Thu, 30 Nov 2023 04:01:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Stevens <stevensd@chromium.org>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Message-ID: <20231130032929-mutt-send-email-mst@kernel.org>
References: <20231113061950.122683-1-stevensd@chromium.org>
 <20231113061950.122683-2-stevensd@chromium.org>
MIME-Version: 1.0
In-Reply-To: <20231113061950.122683-2-stevensd@chromium.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v2 1/1] Define a low power mode for
 devices

On Mon, Nov 13, 2023 at 03:19:50PM +0900, David Stevens wrote:
> Define a low power mode for virtio devices where the devices are
> expected to maintain their state. This gives drivers an option for power
> management besides simply resetting their device. In the virtualization
> use case, this allows the guest to be suspended even with stateful
> virtio devices like gpu and fs.
> 
> Low power mode is primarily defined at the transport layer. The only
> part that depends on device-type specific details is whether a given
> virtqueue is device driven or driver driven.
> 
> This change only defines the transport-specific implementation for
> Virtio over PCI.
> ---
>  content.tex       | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  transport-pci.tex |  7 +++++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/content.tex b/content.tex
> index 0a62dce5f65f..7016778c38d6 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -502,6 +502,51 @@ \section{Exporting Objects}\label{sec:Basic Facilities of a Virtio Device / Expo
>  types. It is RECOMMENDED that devices generate version 4
>  UUIDs as specified by \hyperref[intro:rfc4122]{[RFC4122]}.
>  
> +\section{Low Power Mode}\label{sec:Basic Facilities of a Virtio Device / Low Power Mode}




> +
> +Low power mode is a state a driver can put its device into to try to
> +reduce the resource consumption of the device.

This sounds somewhat vague and the grammar is convoluted. E.g. who
tries what?

How about something like:
	Devices and drivers can implement a low power mode: in this mode device
	state is maintained but driver does not access the device, allowing the
	device to reduce the power consumption.


> While in low power
> +mode, a device can generate wakeup events to inform its driver about
> +device driven events.

using the term events here is confusing because it already
has a meaning in the spec solely related to ring (discussed
in the context of device event suppression).
And "driven" is too close to "driver" and
confuses me.

I think these are
really vq notifications and config change events right?
Maybe just say so instead of coming up with new terms.


> How a device is put into and taken out of low
> +power mode is transport specific, as is how wakeup events are
> +implemented.
> +

I would move the definition of device driven queues here and
add the definition of driver driven queues.

And add a high level explanation of how device and driver
interact (repeating a bit what normative sections say,
this duplication is normal).


> +\devicenormative{\subsection}{Low Power Mode}{Basic Facilities of a Virtio
> +Device / Low Power Mode}
> +
> +A device in low power mode MUST maintain its state such that all
> +driver visible state after exiting low power mode exactly matches
> +driver visible state before entering low power mode.
> +
> +A device in low power mode MUST continue to operate device driven
> +queues. Device driven queues are queues where the driver provides

makes available is the term we use

> +buffers to the device that the device holds onto for an indeterminate
> +time until some device-side event occurs (e.g. event queues, rx
> +queues). When sending a used buffer notification for such a queue, the
> +device MUST generate a wakeup event.

is it only when sending notification? not when buffers are used?
also what does "when" mean here? after sending a notification?

> +
> +A device in low power mode MUST continue to send configuration change
> +notifications. When sending a configuration change notification, the
> +device MUST generate a wakeup event.
> +
> +A device in low power mode SHOULD NOT generate wakeup events for
> +driver driven queues. A device SHOULD stop sending used buffer
> +notifications for such queues until after exiting the low power state.
> +
> +A device in low power mode SHOULD minimize its resource usage,
> +although what steps to take are specific to a particular device
> +implementation.
> +
> +\drivernormative{\subsection}{Low Power Mode}{Basic Facilities of a Virtio
> +Device / Low Power Mode}
> +
> +A driver MUST not interact with a device in low power mode except
> +to take the device out of low power mode

i get this
in a transport specific manner, yes?

> or to handle wakeup events
> +generated by the device.

i don't get this. what does "handle" mean here?


> +
> +A driver MAY use wakeup events as a trigger to take the device out of
> +low power mode, but it MAY also ignore wakeup events.
> +
>  \input{admin.tex}
>  
>  \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
> diff --git a/transport-pci.tex b/transport-pci.tex
> index a5c6719ea871..6694e0f72d46 100644
> --- a/transport-pci.tex
> +++ b/transport-pci.tex
> @@ -1212,3 +1212,10 @@ \subsubsection{Driver Handling Interrupts}\label{sec:Virtio Transport Options /
>          re-examine the configuration space to see what changed.
>      \end{itemize}
>  \end{itemize}
> +
> +\subsubsection{Low Power Mode}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Low Power Mode}
> +

a bit of introduction here can't hurt too - this is a cmpletely separate
section.
e.g. devices can implement support for low power mode, see
(link to generic description).

> +Low power mode corresponds to the device power management state
> +D3\textsubscript{Hot}. A device advertises support for low power mode
> +by presenting the PCI Power Management Capability. Wakeup events are
> +implemented as PCI Power Management Events (PMEs).
> -- 
> 2.42.0.869.gea05f2083d-goog
> 
> 
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
> 
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
> 
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

