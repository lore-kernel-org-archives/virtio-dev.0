Return-Path: <virtio-dev-return-14120-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F9DDC4167B
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Dec 2023 13:54:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C9B372B04F
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Dec 2023 13:54:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A339498664C
	for <virtio-dev@archiver.kernel.org>; Tue,  5 Dec 2023 13:54:46 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 871B8986496; Tue,  5 Dec 2023 13:54:46 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 77411986497
	for <virtio-dev@lists.oasis-open.org>; Tue,  5 Dec 2023 13:54:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701784484; x=1702389284;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gNuaCuEaf7bM8i7/MWTQxi6svOik2ZO+2bxIU/xC55w=;
        b=OYrI56ZwqoU3Mxn1xJQdw+rssIlAdpF9+wKl1j1ec3wZM/TJz7x0fn9dB0qwbEH5QF
         sDW6JhpywNsTv+epWQqZ9R6TxufjkW8X8TsdERWo0yfVPVlYQbw9LbUffeJp/e/jV072
         7UFpJ6JQ62Ew8Dq422YpyXgBm6Gh6VPyPxWErupZpAZgLhTWbxdk1Mj0NuEoWyKv7/YD
         tRjYTvGJ7J0+YPaE+Nn3oYkQBPTLBVk158mTScYT9PwtJTTFlCderwCwZE9pCEl+hRO7
         Ag6qLk/XIG+M6AjmetLiNzv8050RgvEPQcZVINAGEAKiLoNR2iY37w/ttfckCfPeEBz0
         ghwg==
X-Gm-Message-State: AOJu0YzcTmoU7gGVhKBg0dzAF7xinzwq1FPvzaqhKqSMB3ci4RaoE0Q9
	swr1R+vy/PdKcu+NeeTsAyiQfA==
X-Google-Smtp-Source: AGHT+IFVEOvD2WSj7twFFnjT6hTfZBx8HUeMDsTfPhuyWTWyxttNj4B9D7kfkicCi5JGnziLWwsQWQ==
X-Received: by 2002:a05:600c:3411:b0:40b:5e59:e9f1 with SMTP id y17-20020a05600c341100b0040b5e59e9f1mr513745wmp.144.1701784484536;
        Tue, 05 Dec 2023 05:54:44 -0800 (PST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
  virtio-dev@lists.oasis-open.org,  "Michael S. Tsirkin" <mst@redhat.com>,
  Vincent Guittot <vincent.guittot@linaro.org>,
  stratos-dev@op-lists.linaro.org,  Erik Schilling
 <erik.schilling@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Mathieu Poirier
 <mathieu.poirier@linaro.org>, Matias Ezequiel Vara Larsen
 <matiasevara@gmail.com>
In-Reply-To: <875y1ciy9h.fsf@redhat.com> (Cornelia Huck's message of "Tue, 05
	Dec 2023 14:18:02 +0100")
References: <3fbb010e96124cfbffd70709d9ce7a2a458322c8.1701771424.git.viresh.kumar@linaro.org>
	<875y1ciy9h.fsf@redhat.com>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Tue, 05 Dec 2023 13:54:43 +0000
Message-ID: <87plzk92l8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH] virtio-transport: Clarify requirements

Cornelia Huck <cohuck@redhat.com> writes:

> On Tue, Dec 05 2023, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
>> The virtio documentation currently doesn't define any generic
>> requirements that are applicable to all transports. They can be useful
>> while adding support for a new transport.
>>
>> This commit tries to define the same.
>
> Thank you for tackling this, albeit the devil's in the details :)
>
>>
>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>> ---
>>  content.tex | 48 ++++++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 46 insertions(+), 2 deletions(-)
>>
>> diff --git a/content.tex b/content.tex
>> index 0a62dce5f65f..d4d5e7d7045b 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -631,8 +631,52 @@ \section{Device Cleanup}\label{sec:General Initiali=
zation And Device Operation /
>>=20=20
>>  \chapter{Virtio Transport Options}\label{sec:Virtio Transport Options}
>>=20=20
>> -Virtio can use various different buses, thus the standard is split
>> -into virtio general and bus-specific sections.
>> +The virtio devices are exposed to the guest as if they are physical
>> +devices using a specific transport method, like PCI, MMIO or Channel
>> +I/O.
>
> I'm not sure we can talk about "exposed to the guest" here, except as an
> example... maybe if we reword the whole paragraph (see my suggestion
> below.)
>
>> The transport methods define various aspects of the communication
>> +between the device and the driver, like device discovery, exchanging
>> +capabilities, interrupt handling, data transfer, etc.. Virtio can use
>> +various different buses, thus the standard is split into virtio general
>> +and bus-specific sections.
>
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
>
>> +
>> +\section{Virtio Transport Requirements}\label{sec:Virtio Transport Opti=
ons / Virtio Transport Requirements}
>> +
>> +\devicenormative{\subsection}{Virtio Transport Requirements}{Virtio Tra=
nsport Options}
>
> I'm not sure we can introduce MUST (NOT) requirements for basic
> functionality after the spec has been published for quite a time already
> (although I'd assume every implementation is fulfilling the requirements
> anyway)... thoughts?
>
>> +
>> +The device MUST present each event, in a transport defined way, from the
>> +moment it takes place until the driver acknowledges the event.
>
> I don't believe "event" is well-defined here.

Maybe:

"A device initiated transaction can isn't considered complete until
acknowledged by the driver. As such data MUST remain visible to the
driver until the transaction is complete"?

>
>> +
>> +The device MUST NOT access virtqueue's contents before the driver
>> +notifies that the queue is ready for access, in a transport defined way.
>> +
>> +The device MUST NOT access buffers on the virtqueue, after it has
>> +modified them and notified the driver about their availability.
>> +
>> +The device MUST reset the virtqueues if requested by the driver, in a
>> +transport defined way.
>
> Isn't all of this already defined in one place of the spec or another?

I think the recent example is the virtio-sound driver continuing to feed
data into buffers after those buffers where submitted into the
virtqueue. We should be explicit that the only time both sides of a
VirtIO implementation can access things at the same time is with
explicitly shared memory (and you need some sort of mechanism to mediate
that to avoid chaos).

>> +
>> +\drivernormative{\subsection}{Virtio Transport Requirements}{Virtio Tra=
nsport Options}
>> +
>> +The driver MUST NOT access guest memory locations outside what's made
>> +available by the device to the driver.
>
> I don't think that makes sense -- I'd assume most guest memory locations
> do not have anything to do with virtio, and we should try to avoid
> host/guest terminology.

I agree guest memory isn't the right terminology here. However there are
discussions about how to implement secure buffers for VirtIO - so for
example a buffer mediated by some sort of secure layer. In those cases
the driver may not have access to it outside of the transactions.=20

>
>> +
>> +The driver MUST NOT write to the read-only memory area and MUST NOT read
>> +from the write-only memory area.
>
> Which memory areas does that refer to? Parts of the transport-specific
> data structures?
>
>> +
>> +The driver MUST acknowledge events presented by the device, as mandated
>> +by the transport.
>
> I don't think this is quite correct in the absolute -- for example, it
> should be fine to not acknowledge events if some overriding event comes
> along, or if the driver initiates a reset.
>
>> +
>> +The driver MUST NOT access virtqueue contents before the device notifies
>> +about the readiness of the same.
>> +
>> +The driver MUST NOT access buffers, after it has added them to the
>> +virtqueue and notified the device about their availability. The driver
>> +MAY access them after the device has processed them and notified the
>> +driver of their availability, in a transport defined way.
>> +
>> +The driver MAY ask the device to reset the virtqueues if, for example,
>> +the driver times out waiting for a notification from the device for a
>> +previously queued request.
>
> Again, I believe this has already been covered in the generic
> sections -- do we instead need to specify that a transport MUST provide
> a method to do xy? (or SHOULD, MAY, as applicable -- it would be good to
> list explicitly what is mandatory for a transport to implement, and what
> is optional.)

Yes I think so. The s390x channel transport gets referenced because it
has a nice enumerated list of operations. It would be good to codify
which operations are mandatory for all transports and which are
optional.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

