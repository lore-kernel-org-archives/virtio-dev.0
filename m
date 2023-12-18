Return-Path: <virtio-dev-return-14166-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDA8C35274
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Dec 2023 14:20:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9D7E02AD60
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Dec 2023 14:20:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6A9BD9864CC
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Dec 2023 14:20:31 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 428D1986445; Mon, 18 Dec 2023 14:20:31 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0BAD7986478
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 Dec 2023 14:19:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702909184; x=1703513984;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ued4sAgrYvij0oIFagEPIi4sTAlxESeKxHmnchCSXrA=;
        b=QIlfOxbwy4gWUgHgiq7OM3umzUNge9E2j1vIJYACdxQ8B5rTmGTe+jl9jdcQ50dBWG
         HYAjZC5w3TWqt+0VE4BhJ4eMBJdFx0nzKgdLVTAShArwGNIsiCYsQbAIAm7LP04FA/St
         NWLUvKcvEaEjWdmo0eHdKdYimYMbGqfvngC5Mn+u/UfJ6Qpwj5zY8jFqRxUkvduCK+n6
         r9ACNd3hvpF0MnDPabpMMENxMR9m4IXWfML0M4dsRAlM9JJ+dg4ft7YEverfrSdSvAof
         X4vpE2nYSvZZrfmr4e4MiKUbjVCInRxs2E23VOLcJVDyZxC8wxsnbCUIkh0uveqEmIk8
         avOQ==
X-Gm-Message-State: AOJu0YzJ/M0jH5PZdT8lupnole0xpD0hN2FL9cqKy5V2HikSri8iXj9t
	WmYKRLvlJIUx3hIM9uqUrNu/Yg==
X-Google-Smtp-Source: AGHT+IFCUyZvjvTlWhJgbAKsl4uBgw+S8AOz+bse2XW8ZqN7lKBu3Jd7N6c7al4aHOEKcRoEjg4GHQ==
X-Received: by 2002:a05:600c:2492:b0:40c:5583:c6b7 with SMTP id 18-20020a05600c249200b0040c5583c6b7mr5220955wms.109.1702909184370;
        Mon, 18 Dec 2023 06:19:44 -0800 (PST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
  virtio-dev@lists.oasis-open.org,  "Michael S. Tsirkin" <mst@redhat.com>,
  Vincent Guittot <vincent.guittot@linaro.org>,
  stratos-dev@op-lists.linaro.org,  Erik Schilling
 <erik.schilling@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Mathieu Poirier
 <mathieu.poirier@linaro.org>, Bill Mills <bill.mills@linaro.org>
In-Reply-To: <87r0jjfw21.fsf@redhat.com> (Cornelia Huck's message of "Mon, 18
	Dec 2023 15:02:30 +0100")
References: <3fbb010e96124cfbffd70709d9ce7a2a458322c8.1701771424.git.viresh.kumar@linaro.org>
	<875y1ciy9h.fsf@redhat.com>
	<20231206094354.nzjax4lx4e5jwgwo@vireshk-i7>
	<87r0jjfw21.fsf@redhat.com>
User-Agent: mu4e 1.11.26; emacs 29.1
Date: Mon, 18 Dec 2023 14:19:43 +0000
Message-ID: <877clb61a8.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH] virtio-transport: Clarify requirements

Cornelia Huck <cohuck@redhat.com> writes:

> On Wed, Dec 06 2023, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
>> On 05-12-23, 14:18, Cornelia Huck wrote:
>>> On Tue, Dec 05 2023, Viresh Kumar <viresh.kumar@linaro.org> wrote:
<snip>
>>
>> - The transport MUST provide a mechanism for the device and the driver
>>   to notify each other, for example about availability of a buffer on
>>   the virtqueue.
>
> Probably a mechanism for the device to notify the driver, and a
> mechanism for the driver to notify the device? They can be different, as
> long both of them are present.
>
>>
>> - The transport SHOULD provide a mechanism for the driver to initiate
>>   a reset of the virtqueues and device.
>
> Can we mandate a mechanism for a device reset? Reset of virtqueues needs
> to be optional, I'm not sure whether a SHOULD would be appropriate for
> that (or maybe we should finally come up with something for ccw ;)
>
> Other things that probably should be mandatory:
>
> - A way for the driver to change the device status. Reading it would
>   probably be a strong SHOULD.
> - A way to implement config space. (For example, channel devices don't
>   have a config space or anything similar enough to repurpose, so I had
>   to invent a mechanism for ccw... maybe future transports will be in
>   the same boat.)

I think Bill has run into problems with config space on OpenAMP setups
where there can be no specific trapping between domains making it hard
to manage a config space where both sides might want to make updates. I
guess the original MMIO transport gets away with it because config space
is always in the trap-and-emulate address space in a normal VM/emulation
situation.

Bill,

Is the plan to introduce a new transport that manages config in a
different way?

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

