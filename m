Return-Path: <virtio-dev-return-14165-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8297EC35274
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Dec 2023 14:09:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id D8C912B062
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Dec 2023 14:09:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ABD079864D3
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Dec 2023 14:09:11 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 94884986445; Mon, 18 Dec 2023 14:09:11 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8580F986478
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 Dec 2023 14:09:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702908550; x=1703513350;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X+lF2zP/Q3MymnSMHM53VZ29V0JUgFDgyAzWN+lsxTY=;
        b=plrU8bhm0fgRlLBOEWi7wni5VMHAzxqKoLLA6dLLxHZc5RDex7hdAq1COvB5YhIbeI
         wzswGhJv0tREfwTxh3AvhzfAPTzWruAV4xFONilcAEbHAXCuWrgOMXcrgx48KFDI+GrP
         mG0EDJVx3HgoGtkdG9vZJ/hTHdB2ZYic0j6+Pm300mcrZ+slT+5d0Dx2VkmodTc3H/pV
         p+Yz32s9kQVNzQDO/xblVSbSvnyaLsj3g2dw8w9mn1/eqvExR+m/6paTpM29ziCB5OM3
         ZJ7L7TE7i9h57wnc9dbHBVqvhgagIhqrt0rOn4nYyujs2NBtyVK0nSPjvSnFDRizf7Qo
         n9Xw==
X-Gm-Message-State: AOJu0YzCqJNlWEYijYqTVNLa2t7mzmkzGpMIh0apPDcH8yB1uE2xVWLz
	TUYSoqzHxypEqbrvYX615uxkvQ==
X-Google-Smtp-Source: AGHT+IEDdxA62mx8DVBKRh6JFjm4/Th32euSxan9PCh/Kn9CAB4lge+PozMtwcJeONhVHGIEq9DIcA==
X-Received: by 2002:adf:fa45:0:b0:336:6690:6d0 with SMTP id y5-20020adffa45000000b00336669006d0mr1158188wrr.76.1702908549754;
        Mon, 18 Dec 2023 06:09:09 -0800 (PST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
  virtio-dev@lists.oasis-open.org,  "Michael S. Tsirkin" <mst@redhat.com>,
  Vincent Guittot <vincent.guittot@linaro.org>,
  stratos-dev@op-lists.linaro.org,  Erik Schilling
 <erik.schilling@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Mathieu Poirier
 <mathieu.poirier@linaro.org>,  Matias Ezequiel Vara Larsen
 <matiasevara@gmail.com>, Bill Mills <bill.mills@linaro.org>
In-Reply-To: <87ttoffydj.fsf@redhat.com> (Cornelia Huck's message of "Mon, 18
	Dec 2023 14:12:24 +0100")
References: <3fbb010e96124cfbffd70709d9ce7a2a458322c8.1701771424.git.viresh.kumar@linaro.org>
	<875y1ciy9h.fsf@redhat.com> <87plzk92l8.fsf@draig.linaro.org>
	<87ttoffydj.fsf@redhat.com>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Mon, 18 Dec 2023 14:09:08 +0000
Message-ID: <87cyv361rv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH] virtio-transport: Clarify requirements

Cornelia Huck <cohuck@redhat.com> writes:

> On Tue, Dec 05 2023, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>
>> Cornelia Huck <cohuck@redhat.com> writes:
>>
>>> On Tue, Dec 05 2023, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>>> +
>>>> +The device MUST present each event, in a transport defined way, from =
the
>>>> +moment it takes place until the driver acknowledges the event.
>>>
<snip>
>>>> +
>>>> +\drivernormative{\subsection}{Virtio Transport Requirements}{Virtio T=
ransport Options}
>>>> +
>>>> +The driver MUST NOT access guest memory locations outside what's made
>>>> +available by the device to the driver.
>>>
>>> I don't think that makes sense -- I'd assume most guest memory locations
>>> do not have anything to do with virtio, and we should try to avoid
>>> host/guest terminology.
>>
>> I agree guest memory isn't the right terminology here. However there are
>> discussions about how to implement secure buffers for VirtIO - so for
>> example a buffer mediated by some sort of secure layer. In those cases
>> the driver may not have access to it outside of the transactions.=20
>
> Yes, I think we need to limit the scope of "guest memory" here. I think
> we are basically wanting to deal with any memory used by virtio (device
> type including memory access controlled by it, transport, and the
> protocol itself). We would be talking about memory made available to the
> device by the driver for explicit usage to implement the virtio spec. I
> think this would cover mediation by a secure layer as well (with the
> driver calling into that secure layer?) Or does the (host) device end up
> donating memory to the (guest) driver, and we need to make sure it
> doesn't scribble over it?

I'm not sure if we have example of the host donating memory apart from
the sort of static partitioning we see with guests on start-up where a
region is defined as shared. The Xen grant model leaves the guest to
grant access to its own pages to the backend.

I guess for firmware mediated sharing this would still be driven by the
guest rather than the host?

>
>>>> +
>>>> +The driver MUST NOT access virtqueue contents before the device notif=
ies
>>>> +about the readiness of the same.
>>>> +
>>>> +The driver MUST NOT access buffers, after it has added them to the
>>>> +virtqueue and notified the device about their availability. The driver
>>>> +MAY access them after the device has processed them and notified the
>>>> +driver of their availability, in a transport defined way.
>>>> +
>>>> +The driver MAY ask the device to reset the virtqueues if, for example,
>>>> +the driver times out waiting for a notification from the device for a
>>>> +previously queued request.
>>>
>>> Again, I believe this has already been covered in the generic
>>> sections -- do we instead need to specify that a transport MUST provide
>>> a method to do xy? (or SHOULD, MAY, as applicable -- it would be good to
>>> list explicitly what is mandatory for a transport to implement, and what
>>> is optional.)
>>
>> Yes I think so. The s390x channel transport gets referenced because it
>> has a nice enumerated list of operations. It would be good to codify
>> which operations are mandatory for all transports and which are
>> optional.
>
> The problem with the ccw transport is that while it has a nice list of
> operations, (a) it only covers guest-initiated actions,

What examples of host initiated actions are there (aside from an IPI
indicating a receive VirtQueue has buffers waiting)?

> (b) probably not
> all of them shold be mandatory (and some of them are more of an artifact
> of how channel I/O works),

These ones?

  #define CCW_CMD_SET_IND 0x43
  #define CCW_CMD_SET_CONF_IND 0x53
  #define CCW_CMD_SET_IND_ADAPTER 0x73

> and (c) it only implements a subset of the
> defined operations (which makes the not-implemented ones de facto
> optional, of course :) But yes, we could use it as a starting point.

Got to start somewhere :-)

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

