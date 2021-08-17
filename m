Return-Path: <virtio-dev-return-8541-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7B01B9863B9
	for <virtio-dev@lists.oasis-open.org>; Tue, 17 Aug 2021 10:01:19 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <YRuDYG6LKSyssCDa@stefanha-x1.localdomain>
References: <cb15de92f8cb840204a945ae643c14700b567600.1628492314.git.viresh.kumar@linaro.org>
 <YRuDYG6LKSyssCDa@stefanha-x1.localdomain>
Date: Tue, 17 Aug 2021 12:01:04 +0200
Message-ID: <87bl5wtmov.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH V9] virtio-gpio: Add the device specification
Content-Type: text/plain
To: Stefan Hajnoczi <stefanha@redhat.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Arnd Bergmann <arnd@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Vincent Guittot <vincent.guittot@linaro.org>, Jean-Philippe Brucker <jean-philippe@linaro.org>, Bill Mills <bill.mills@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, "Enrico Weigelt, metux IT
 consult" <info@metux.net>, virtio-dev@lists.oasis-open.org, Geert Uytterhoeven <geert@linux-m68k.org>, stratos-dev@op-lists.linaro.org, Arnd Bergmann <arnd@arndb.de>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Aug 17 2021, Stefan Hajnoczi <stefanha@redhat.com> wrote:

> On Mon, Aug 09, 2021 at 12:32:14PM +0530, Viresh Kumar wrote:
>> +\subsubsection{requestq Operation: Get Line Names}\label{sec:Device Types / GPIO Device / requestq Operation / Get Line Names}
>> +
>> +The driver sends this message to receive a stream of zero-terminated strings,
>> +where each string represents the name of a GPIO line, present in increasing
>> +order of the GPIO line numbers. The names of the GPIO lines are optional and may
>> +be present only for a subset of GPIO lines. If missing, then a zero-byte must be
>> +present for the GPIO line. If present, the name string must be zero-terminated
>> +and the name must be unique within a GPIO Device.
>
> Sorry I didn't get to this patch before the vote. It's necessary to
> specify the character encoding. In the text above it's unclear whether
> the characters are limited to US-ASCII, UTF-8, or something else.
>
> I suggest UTF-8 for maximum flexibility.

Agree on UTF-8. We can do this with a patch on top.

>
>> +These names of the GPIO lines should be most meaningful producer names for the
>> +system, such as name indicating the usage. For example "MMC-CD", "Red LED Vdd"
>> +and "ethernet reset" are reasonable line names as they describe what the line is
>> +used for, while "GPIO0" is not a good name to give to a GPIO line.
>
> Does this belong in the device normative section? Normally "should",
> "must", "may", etc are only used there. If you prefer to keep it here,
> please adjust the language ("The device describes GPIO lines with the
> most meaningful producer names for the system, ...").

The all caps SHOULD etc. are for normative sections; I consider the
usage here ok, although we can certainly consider tweaking the wording
on top of this. It seems more like advice to me.

>
>> +
>> +The driver sends this message to request the device to configure a line's
>> +direction. The driver can either set the direction to
>> +\field{VIRTIO_GPIO_DIRECTION_IN} or \field{VIRTIO_GPIO_DIRECTION_OUT}, which
>> +also activates the line, or to \field{VIRTIO_GPIO_DIRECTION_NONE}, which
>> +deactivates the line.
>> +
>> +The driver should set the value of the GPIO line, using the
>> +\field{VIRTIO_GPIO_MSG_SET_VALUE} message, before setting the direction of the
>> +line to output to avoid any undesired behavior.
>
> Does this belong in the driver normative section? Normally "should",
> "must", "may", etc are only used there. If you prefer to keep it here,
> please adjust the language ("The driver sets the value ...").

Same here.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

