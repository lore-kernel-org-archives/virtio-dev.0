Return-Path: <virtio-dev-return-13202-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092CCEB64DA
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 22:00:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 39B352AECE
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 22:00:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0EAC29866F2
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 22:00:11 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E956E9866EF; Fri, 30 Jun 2023 22:00:10 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CC7169866F0
	for <virtio-dev@lists.oasis-open.org>; Fri, 30 Jun 2023 22:00:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688162405; x=1690754405;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Yth2qD5ZMMAch1Z3V0d5FBKwppugfVJ0kU4hh3o0nF0=;
        b=RK4W9iTsZTEHWnwswTufZOKgVzUCdR6fbTD/OL5X+vbIT8TDL3dgFTgrPu/VpV1pyA
         4PCnsq8yyaBxSSuu1Atc3uMwgRvCrTJIeyJfpT9zM6Z7Bx9xRfMJ6qs0P74i9KntALf2
         mjCbLM9+eVqF5K4vdm4TGvn3Lmnbtus41jZkQx1EfVp12jnoE+fBH5INPPkqBA3axX4k
         v8LQzAxIE7Mp7R9t1xHhEF7o9zwhzBDtQaiZOSoxmVSKIuyNDLpG9SWdsTqQxcOlOAwy
         ovIVmlWIPvm0C03GwBWFlqBjYHrfkrvroTg4pzZozPI6iwfWtcJHP41TySizQQGh0Nav
         C1hw==
X-Gm-Message-State: ABy/qLZNhDQmZjWNGzYfTf8kiLQS/5ZQIpuS1NBK2RJCZYL6ZCmhpWwQ
	w5F7Zq98Zkb61IEssSWdZ3YN8SsuiBA+GucNzgoqbQ==
X-Google-Smtp-Source: APBJJlGGIY2aWajrwGN6e56NAzgWcCh0u4dE0Gq2EMw7wuMUhAsAyjgQRmI9BhJrSfLn5u3JdeFI6HkhHjEBOekdj3s=
X-Received: by 2002:a05:6e02:216a:b0:33d:8c8a:cd0e with SMTP id
 s10-20020a056e02216a00b0033d8c8acd0emr60343ilv.20.1688162405363; Fri, 30 Jun
 2023 15:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000925c1305ff1f7c76@google.com> <fd2e0d5d-a3e9-027a-bec1-d0e821ec6421@quicinc.com>
In-Reply-To: <fd2e0d5d-a3e9-027a-bec1-d0e821ec6421@quicinc.com>
From: Jonathon Reinhart <jrreinhart@google.com>
Date: Fri, 30 Jun 2023 17:59:54 -0400
Message-ID: <CAJJa5HxA6T+xv--80aWEtGWNx=a-yfNXwNsnyz3s8praHqg6Ew@mail.gmail.com>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: Cornelia Huck <cohuck@redhat.com>, quic_ztu@quicinc.com, 
	virtio-dev@lists.oasis-open.org
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [virtio-dev][PATCH 2/2] virtio-spi: add the device specification

> Hi @jrreinhart@google.com,
>      Thank you very much for your helpful comments.
>
>      I missed the delay and cs_change_delay parameters. I will add both
> of them, although cs_change_delay can not be set from userspace, but can
> be set in kernel space.
>
>
>      For CS delays such as PRE_DELAY/POST_DELAY, it seems that they are
> defined in structure spi_device:
>
>      @cs_setup: delay to be introduced by the controller after CS is
> asserted.
>
>      @cs_hold: delay to be introduced by the controller before CS is
> deasserted.
>
>      @cs_inactive: delay to be introduced by the controller after CS is
> deasserted. If @cs_change_delay is used from @spi_transfer, then the
> two delays will be added up.
>
>      They show the SPI controller ability to control the CS
> assertion/deassertion timing and should not be changed for each transfer
> (because thay can be updated by setting structure spi_transfer or
> structure spi_ioc_transfer). I think it better to define these parameter
> in host OS rather than in guest OS since it's the host OS to operate the
> hardware SPI controller directly. Besides, it can also avoid passing the
> same values from guest to host time after time.
>
>      What's your opinion on this topic? Again, thank you very much.

Hi Haixu,

I took another look at the Linux structures and attempted to map up the
delay parameters to the various points in a SPI sequence. Please correct
me if I'm wrong about any of this.

Consider this diagram where CS# is an active-low chip select, and SCLK
is the serial clock:

      ___.                                                   ._____.
  CS#    |___________________________________________________|     |___
         .                                                   .     .
         .                                                   .     .
 SCLK ________NNNN___NNNN___NNNN_______NNNN___NNNN___NNNN______________
         .   .    . .           .     .                  .   .     .
Delays:  +-A-+    +B+           +--C--+                  +-D-+--E--+
         .   .    . .           .     .                  .   .     .
         0   1    2 3           4     5                  6   7     8
         .   .    .             .     .                  .   .
Terms:   .   +Word+             .     .                  .   .
         .   .                  .     .                  .   .
         .   +-------Frame------+     +-------Frame------+   .
         .                                                   .
         +-----------------Transfer--------------------------+

Using NXP terminology:

  From 1 to 2 is a "word"     (with e.g. 8 bits).
  From 1 to 4 is a "frame"    (with 3 words).
  From 1 to 6 is a "transfer" (with 3 frames).

Linux does not have the concept of a frame, only a series of transfers
(a spi_message), each of which can specify whether CS changes or not.

I've identified these various timing points and attempted to match them
to the Linux spi_device and spi_transfer parameters:

A - CS Setup: Delay after CS asserted before clock starts.
    spi_device.cs_setup

B - Word Delay: Delay between words.
    spi_transfer.word_delay

C - Frame Delay: Delay between frames.
    (Linux does not have the concept of a SPI "frame".)

D - CS Hold: Delay after clock stops, and before CS deasserted.
    spi_device.cs_hold (+ spi_transfer.delay ??)

E - CS Inactive: Delay after CS deasserted, before asserting again.
    spi_device.cs_inactive + spi_transfer.cs_change_delay


While I agree with you that some of these timings are unlikely to change
from transfer-to-transfer, the subset of which should be specified
at the device level vs. per-transfer seems somewhat arbitrary. As you
can see there is some overlap between them.

If I understand correctly, it appears that the CS hold time *can* be
controlled on a per-transfer bases, using spi_transfer.delay
("after this transfer before changing the chipselect status").

That leaves CS setup as the only parameter that cannot be influenced on
a per-transfer basis.

Theoretically, one might require different CS setup/hold times,
depending on which slave_id they are talking to (on the same bus).
In that case, one must set those spi_device parameters to the worst-case
(maximum) values. However, this is already a Linux limitation, so I'm
not sure it needs to be improved here.

I think you've achieved parity with what the Linux kernel API allows,
and that's probably good enough. As you said, anything else can be
adjusted in the host OS -- I'm not sure how the guest would go about
achieving that, though. You're not proposing the use of configuration
space for virtio-spi, are you?

Regards,
Jonathon Reinhart


>
> Best Regards
> Haixu Cui
>
> On 6/28/2023 1:06 AM, jrreinhart@google.com wrote:
> > Hi Haixu,
> >
> >> +The \field{word_delay} defines how long to wait between words within
> >> one SPI transfer,
> >> +in ns unit.
> >
> > I'm a little surprised to see a word_delay but no frame_delay or
> > transfer_delay.
> >
> > For example, many SPI peripherals require a delay after CS is asserted,
> > but before the first SCLK edge, allowing them to prepare to send data.
> > (E.g. an ADC might begin taking a sample.)
> >
> >
> > The linux struct spi_transfer has three delay fields:
> >
> > * @cs_change_delay: delay between cs deassert and assert when
> > *      @cs_change is set and @spi_transfer is not the last in
> > *      @spi_message
> > * @delay: delay to be introduced after this transfer before
> > *    (optionally) changing the chipselect status, then starting the
> > *    next transfer or completing this @spi_message.
> > * @word_delay: inter word delay to be introduced after each word size
> > *    (set by bits_per_word) transmission.
> >
> > The userspace spidev.h API has only two:
> >
> > * @delay_usecs: If nonzero, how long to delay after the last bit
> > *       transfer before optionally deselecting the device before the
> > *       next transfer.
> > * @word_delay_usecs: If nonzero, how long to wait between words within
> > *       one transfer. This property needs explicit support in the SPI
> > *       controller, otherwise it is silently ignored.
> >
> > The NXP i.MX RT500 SPI (master) controller, for example, has four
> > configurable delays:
> >
> > - PRE_DELAY: After CS assertion, before first SCLK edge.
> > - POST_DELAY: After a transfer, before CS deassertion.
> > - FRAME_DELAY: Between frames (which are arbitrarily defined by
> >    software).
> > - TRANSFER_DELAY: Minimum CS deassertion time between transfers.
> >
> > The NVIDIA Tegra114 SPI controller has:
> >
> > - nvidia,cs-setup-clk-count: CS setup timing parameter.
> > - nvidia,cs-hold-clk-count: CS hold timing parameter.
> >
> >
> > I understand that accurately representing all possible delays might be
> > difficult or futile, but I'm curious to understand why, of all the
> > possible delays, inter-word delay was chosen for inclusion.
> >
> > In a microcontroller, delays around CS (de)assertion can be customized
> > by using a GPIO -- rather than the hardware SPI block -- to drive the CS
> > signal. This way, delays can be inserted where needed. To do so with a
> > virtualized SPI controller might prove difficult however, as the virtual
> > channel carrying a CS GPIO signal might not be synchronized to the
> > channel carrying the SPI data.
> >
> > Curious to hear your thoughts.
> >
> > Thanks,
> > Jonathon Reinhart

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

