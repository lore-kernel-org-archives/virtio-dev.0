Return-Path: <virtio-dev-return-14127-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A15C10DC1
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Dec 2023 09:43:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C8D5F2AD7A
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Dec 2023 09:43:58 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ABBD99868F3
	for <virtio-dev@archiver.kernel.org>; Wed,  6 Dec 2023 09:43:58 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 907BB9866C1; Wed,  6 Dec 2023 09:43:58 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 81DA39866E7
	for <virtio-dev@lists.oasis-open.org>; Wed,  6 Dec 2023 09:43:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701855837; x=1702460637;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1/2rVRN5uJy4fDe/dMEhHKkV5HEIZH4+Cb1BJJ6UlQ=;
        b=fLfPRFIAdBgOdtQh9QxStPdDTnJ5mfSXLAVp7Y6MkYHaMXjxwf/scsCs0wBbu77HxX
         Cz0b5qGGn9GG4ElyXJKXrVjsS1frromzaI7ehMdkA19XxyLhKJcSswUOARBh5KqtqCmp
         3R1IO4h99J4bIf4V2qWy2qQepGGpb1Rm8eF0pruiiVQKlJRfbqjgJ+mEPZ/10Y5G9ICJ
         SV5BGk7Kw34gdEqZkc0vXfPm7P1yl30Ngh3T3ouqLBbHf1OsdjU2Q45p6EKtoHPct8jL
         jmsea+ZclHOQK2pIDZrAxz6oEe0pGc7Y6POpcGd4ZCAsnKEmS+y+pKahnjuN0T2MLQA5
         bLsg==
X-Gm-Message-State: AOJu0YylTvvm15gPzJq59pjFnsR2y5mmVcUorOKVRYJm9vcnWXpIQp6F
	6AME7LlPbVjkVoLT1i5IX70gYg==
X-Google-Smtp-Source: AGHT+IFOwg7Ur9X05x0+d+bWZ0vEn+sxS6bzi8sbfWi5jP/dvqcnffom5UEgaNdw4Nsslt3F4G8izg==
X-Received: by 2002:a05:6a20:3d14:b0:187:4ee0:e95e with SMTP id y20-20020a056a203d1400b001874ee0e95emr455415pzi.52.1701855836775;
        Wed, 06 Dec 2023 01:43:56 -0800 (PST)
Date: Wed, 6 Dec 2023 15:13:54 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
	stratos-dev@op-lists.linaro.org,
	Erik Schilling <erik.schilling@linaro.org>,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>
Message-ID: <20231206094354.nzjax4lx4e5jwgwo@vireshk-i7>
References: <3fbb010e96124cfbffd70709d9ce7a2a458322c8.1701771424.git.viresh.kumar@linaro.org>
 <875y1ciy9h.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875y1ciy9h.fsf@redhat.com>
Subject: [virtio-dev] Re: [PATCH] virtio-transport: Clarify requirements

On 05-12-23, 14:18, Cornelia Huck wrote:
> On Tue, Dec 05 2023, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > diff --git a/content.tex b/content.tex

> I think we should concentrate on the transport being what links device
> and driver together... what about (reusing parts of your writeup):
> 
> "Devices and drivers can use different transport methods to enable
> interaction, for example PCI, MMIO, or Channel I/O. The transport
> methods define various aspects of the communication between the device
> and the driver, like device discovery, exchanging capabilities,
> interrupt handling, data transfer, etc. For example, in a host/guest
> architecture, the host might expose a device to the guest on a PCI bus,
> and the guest will use a PCI-specific driver to interact with it.
> 
> The standard is split into sections describing general virtio
> implementation and transport-specific sections."

Looks good.

> > +\section{Virtio Transport Requirements}\label{sec:Virtio Transport Options / Virtio Transport Requirements}
> > +
> > +\devicenormative{\subsection}{Virtio Transport Requirements}{Virtio Transport Options}
> 
> I'm not sure we can introduce MUST (NOT) requirements for basic
> functionality after the spec has been published for quite a time already
> (although I'd assume every implementation is fulfilling the requirements
> anyway)... thoughts?

Fair point. I think it would be okay to use MUST (NOT) if we are sure
that the existing implementations are fulfilling the requirements.
Else maybe we can use SHOULD (NOT) ?

> > +The device MUST present each event, in a transport defined way, from the
> > +moment it takes place until the driver acknowledges the event.
> 
> I don't believe "event" is well-defined here.

I liked Alex's suggestion, how about that ?

"A device initiated transaction can isn't considered complete until
acknowledged by the driver. As such data MUST remain visible to the
driver until the transaction is complete"

> > +The device MUST NOT access virtqueue's contents before the driver
> > +notifies that the queue is ready for access, in a transport defined way.
> > +
> > +The device MUST NOT access buffers on the virtqueue, after it has
> > +modified them and notified the driver about their availability.
> > +
> > +The device MUST reset the virtqueues if requested by the driver, in a
> > +transport defined way.
> 
> Isn't all of this already defined in one place of the spec or another?

Yes, some of this is picked from those places only. The purpose of
this patch is to get it all at a single place, which would be easier
for people to go through. Especially while introducing new transports
or device specifications.

> > +\drivernormative{\subsection}{Virtio Transport Requirements}{Virtio Transport Options}
> > +
> > +The driver MUST NOT access guest memory locations outside what's made
> > +available by the device to the driver.
> 
> I don't think that makes sense -- I'd assume most guest memory locations
> do not have anything to do with virtio, and we should try to avoid
> host/guest terminology.

Hmm, you are right about the guest/host terminology. This comes mostly
from the MMIO transport section, where a guest presents 0x100 bytes of
memory, followed by configuration space (whose length is device/driver
dependent). The MMIO section has this:

"The driver MUST NOT access memory locations not described in the
table \ref{tab:Virtio Transport Options / Virtio Over MMIO / MMIO Device Register Layout}
(or, in case of the configuration space, described in the device specification),
MUST NOT write to the read-only registers (direction R) and
MUST NOT read from the write-only registers (direction W)."

> > +The driver MUST NOT write to the read-only memory area and MUST NOT read
> > +from the write-only memory area.
> 
> Which memory areas does that refer to? Parts of the transport-specific
> data structures?

Yes, based again on the above MMIO section, but perhaps apply to other
transports as well..

> > +The driver MUST acknowledge events presented by the device, as mandated
> > +by the transport.
> 
> I don't think this is quite correct in the absolute -- for example, it
> should be fine to not acknowledge events if some overriding event comes
> along, or if the driver initiates a reset.

What about:

The driver SHOULD acknowledge events presented by the device, as
mandated by the transport, unless a new event from the device
overrides the previous one or the driver initiates a reset.

> > +The driver MUST NOT access virtqueue contents before the device notifies
> > +about the readiness of the same.
> > +
> > +The driver MUST NOT access buffers, after it has added them to the
> > +virtqueue and notified the device about their availability. The driver
> > +MAY access them after the device has processed them and notified the
> > +driver of their availability, in a transport defined way.
> > +
> > +The driver MAY ask the device to reset the virtqueues if, for example,
> > +the driver times out waiting for a notification from the device for a
> > +previously queued request.
> 
> Again, I believe this has already been covered in the generic
> sections

Right, but having it all at a single place makes it more convenient,
instead of looking at implementations.

> do we instead need to specify that a transport MUST provide
> a method to do xy? (or SHOULD, MAY, as applicable -- it would be good to
> list explicitly what is mandatory for a transport to implement, and what
> is optional.)

Hmm, yeah sounds good. How about these ?

- The transport MUST provide a mechanism for device discovery at the
  driver's end.

- The transport must provide a mechanism for the driver to identify
  the device type.

- The transport MUST provide a mechanism for the driver to share
  virtqueue configurations with the device.

- The transport SHOULD allow multiple virtqueues per device. The
  number of virtqueues for a pair of device-driver are governed by the
  individual device protocol.

- The transport MUST provide shared memory regions between the device
  and the driver for the implementation of virtqueues.

- The transport MUST provide a mechanism for the device and the driver
  to notify each other, for example about availability of a buffer on
  the virtqueue.

- The transport SHOULD provide a mechanism for the driver to initiate
  a reset of the virtqueues and device.

-- 
viresh

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

