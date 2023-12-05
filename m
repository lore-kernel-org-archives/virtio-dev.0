Return-Path: <virtio-dev-return-14119-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED3EC4167B
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Dec 2023 13:18:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 3578B2AF98
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Dec 2023 13:18:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 203FE9864A1
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Dec 2023 13:18:10 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 01AC698645D; Tue,  5 Dec 2023 13:18:10 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E5902986496
	for <virtio-dev@lists.oasis-open.org>; Tue,  5 Dec 2023 13:18:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: bbfLuuOzO96jOzGrHOF2_A-1
From: Cornelia Huck <cohuck@redhat.com>
To: Viresh Kumar <viresh.kumar@linaro.org>, virtio-dev@lists.oasis-open.org,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot
 <vincent.guittot@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 stratos-dev@op-lists.linaro.org, Erik Schilling
 <erik.schilling@linaro.org>, Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>, Mathieu Poirier
 <mathieu.poirier@linaro.org>
In-Reply-To: <3fbb010e96124cfbffd70709d9ce7a2a458322c8.1701771424.git.viresh.kumar@linaro.org>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy
 Ross"
References: <3fbb010e96124cfbffd70709d9ce7a2a458322c8.1701771424.git.viresh.kumar@linaro.org>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Tue, 05 Dec 2023 14:18:02 +0100
Message-ID: <875y1ciy9h.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Subject: [virtio-dev] Re: [PATCH] virtio-transport: Clarify requirements

On Tue, Dec 05 2023, Viresh Kumar <viresh.kumar@linaro.org> wrote:

> The virtio documentation currently doesn't define any generic
> requirements that are applicable to all transports. They can be useful
> while adding support for a new transport.
>
> This commit tries to define the same.

Thank you for tackling this, albeit the devil's in the details :)

>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  content.tex | 48 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 46 insertions(+), 2 deletions(-)
>
> diff --git a/content.tex b/content.tex
> index 0a62dce5f65f..d4d5e7d7045b 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -631,8 +631,52 @@ \section{Device Cleanup}\label{sec:General Initialization And Device Operation /
>  
>  \chapter{Virtio Transport Options}\label{sec:Virtio Transport Options}
>  
> -Virtio can use various different buses, thus the standard is split
> -into virtio general and bus-specific sections.
> +The virtio devices are exposed to the guest as if they are physical
> +devices using a specific transport method, like PCI, MMIO or Channel
> +I/O.

I'm not sure we can talk about "exposed to the guest" here, except as an
example... maybe if we reword the whole paragraph (see my suggestion
below.)

> The transport methods define various aspects of the communication
> +between the device and the driver, like device discovery, exchanging
> +capabilities, interrupt handling, data transfer, etc.. Virtio can use
> +various different buses, thus the standard is split into virtio general
> +and bus-specific sections.

I think we should concentrate on the transport being what links device
and driver together... what about (reusing parts of your writeup):

"Devices and drivers can use different transport methods to enable
interaction, for example PCI, MMIO, or Channel I/O. The transport
methods define various aspects of the communication between the device
and the driver, like device discovery, exchanging capabilities,
interrupt handling, data transfer, etc. For example, in a host/guest
architecture, the host might expose a device to the guest on a PCI bus,
and the guest will use a PCI-specific driver to interact with it.

The standard is split into sections describing general virtio
implementation and transport-specific sections."

> +
> +\section{Virtio Transport Requirements}\label{sec:Virtio Transport Options / Virtio Transport Requirements}
> +
> +\devicenormative{\subsection}{Virtio Transport Requirements}{Virtio Transport Options}

I'm not sure we can introduce MUST (NOT) requirements for basic
functionality after the spec has been published for quite a time already
(although I'd assume every implementation is fulfilling the requirements
anyway)... thoughts?

> +
> +The device MUST present each event, in a transport defined way, from the
> +moment it takes place until the driver acknowledges the event.

I don't believe "event" is well-defined here.

> +
> +The device MUST NOT access virtqueue's contents before the driver
> +notifies that the queue is ready for access, in a transport defined way.
> +
> +The device MUST NOT access buffers on the virtqueue, after it has
> +modified them and notified the driver about their availability.
> +
> +The device MUST reset the virtqueues if requested by the driver, in a
> +transport defined way.

Isn't all of this already defined in one place of the spec or another?

> +
> +\drivernormative{\subsection}{Virtio Transport Requirements}{Virtio Transport Options}
> +
> +The driver MUST NOT access guest memory locations outside what's made
> +available by the device to the driver.

I don't think that makes sense -- I'd assume most guest memory locations
do not have anything to do with virtio, and we should try to avoid
host/guest terminology.

> +
> +The driver MUST NOT write to the read-only memory area and MUST NOT read
> +from the write-only memory area.

Which memory areas does that refer to? Parts of the transport-specific
data structures?

> +
> +The driver MUST acknowledge events presented by the device, as mandated
> +by the transport.

I don't think this is quite correct in the absolute -- for example, it
should be fine to not acknowledge events if some overriding event comes
along, or if the driver initiates a reset.

> +
> +The driver MUST NOT access virtqueue contents before the device notifies
> +about the readiness of the same.
> +
> +The driver MUST NOT access buffers, after it has added them to the
> +virtqueue and notified the device about their availability. The driver
> +MAY access them after the device has processed them and notified the
> +driver of their availability, in a transport defined way.
> +
> +The driver MAY ask the device to reset the virtqueues if, for example,
> +the driver times out waiting for a notification from the device for a
> +previously queued request.

Again, I believe this has already been covered in the generic
sections -- do we instead need to specify that a transport MUST provide
a method to do xy? (or SHOULD, MAY, as applicable -- it would be good to
list explicitly what is mandatory for a transport to implement, and what
is optional.)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

