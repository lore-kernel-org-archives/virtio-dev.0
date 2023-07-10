Return-Path: <virtio-dev-return-13334-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB91EB64DA
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Jul 2023 16:43:11 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C7D413E30A
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Jul 2023 16:43:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A87F19864BA
	for <virtio-dev@archiver.kernel.org>; Mon, 10 Jul 2023 16:43:10 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8C63698648A; Mon, 10 Jul 2023 16:43:10 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 78D0C98648C
	for <virtio-dev@lists.oasis-open.org>; Mon, 10 Jul 2023 16:43:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689007389; x=1691599389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k9IVMmKuCXqln1h+0z8wu9M8RJOIhGbtOuIPskLs8OA=;
        b=DNiw6Se1w9lwG/sk0KTNz5MZVg9n5OrnsdtqvZsvoMhNdTc5nLJziwxKyr3m00nFq7
         ZxKFiqRoGdkp+kiSVlABUGZcnDHrWDIoOEhTT12frEvnu91MVl9y2bKjw3Y4N64tBjXQ
         hzMk5/us0ihGjViH6Gq5C0YpBe+MOYE/zKNaLwn8fipBLZsEVguw2SgRZy04ChVb0VzQ
         3KXf4zyogXotdYazS7nvssB1UqIwkiOEItvDzysCCNldn2fbZkiu9njMMSPTo1F9qxDw
         y9RW3tGCekuo3l3IVn63JZSC6pdMHUaDGxcPr3ggoPAqQzG2oytWsmgYsvNA0A1nrNe3
         fClQ==
X-Gm-Message-State: ABy/qLaSf3Bai6m6iiVsln5yEoo5MiYDDSsXlVaUZHtZoDrDu6Zzcb8x
	DMx9efBY3cuzpwmIh7i+jnU6MB+QIJj4e6uhMMsp5g==
X-Google-Smtp-Source: APBJJlEUxdrk3RAcs8ZrE18Clh1Tozt/9AmP5/T1kMJpYMH9x6wcDP4tKk5lIppxSduhlSl+UnKfDX0AEecJ1pOLddI=
X-Received: by 2002:a05:622a:246:b0:3ef:4319:c6c5 with SMTP id
 c6-20020a05622a024600b003ef4319c6c5mr284461qtx.19.1689007388902; Mon, 10 Jul
 2023 09:43:08 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000925c1305ff1f7c76@google.com> <fd2e0d5d-a3e9-027a-bec1-d0e821ec6421@quicinc.com>
 <CAJJa5HxA6T+xv--80aWEtGWNx=a-yfNXwNsnyz3s8praHqg6Ew@mail.gmail.com> <46ab6180-c639-6da4-d6c3-dc8b87345de9@quicinc.com>
In-Reply-To: <46ab6180-c639-6da4-d6c3-dc8b87345de9@quicinc.com>
From: Jonathon Reinhart <jrreinhart@google.com>
Date: Mon, 10 Jul 2023 12:42:57 -0400
Message-ID: <CAJJa5HwV76co8n4WeeL-mcMwwL9sKVWz_Ejiv-EMWgemsGGS3w@mail.gmail.com>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: Cornelia Huck <cohuck@redhat.com>, quic_ztu@quicinc.com, 
	virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev][PATCH 2/2] virtio-spi: add the device specification

On Fri, Jul 7, 2023 at 3:21=E2=80=AFAM Haixu Cui <quic_haixcui@quicinc.com>=
 wrote:
>
> Hi Jonathon Reinhart,
>
>      Thank you so much for all your helpful advice and info!
>
>      I took a look at latest Linux SPI driver and found, for
> cs_setup/cs_hold/cs_inactive set in device-tree, there are following two
> conditions:
>      1) if SPI controller supports CS timing configuration and CS is not
> using a GPIO line, then the SPI driver set the
> cs_setup/cs_hold/ca_inactive values into the corresponding SPI CS registe=
rs;
>      2) if CS is using a GPIO line, or SPI controller doesn't support CS
> timing configuration, it is the software to perform the
> cs_setup/cs_hold/cs_inactive delays, which is implemented in function
> spi_set_cs in driver/spi/spi.c.
>
>      So I agree it is necessary to pass cs_setup/cs_hold/cs_inactive to
> the host for each transfer.
>
>      For condition 1, host should set these values into the CS timing
> registers. And as you mentioned "one might require different CS
> setup/hold times, depending on which slave_id they are talking to (on
> the same bus)", if so, host need to overwrite the CS timing registers
> between the two transfers talking to different salve_id.
>
>      For condition 2, SPI driver running in the host performing the
> cs_setup/cs_hold/cs_inactive delays seems more accurate, compared with
> performing delays in guest.
>
>
>      And the latest virtio spi transfer structure is defined as follows:
>
>       struct spi_transfer_head {
>          u8 slave_id;
>          u8 bits_per_word;
>          u8 cs_change;
>          u8 tx_nbits;
>         u8 rx_nbits;
>         u8 reserved[3];
>          u32 mode;
>          u32 freq;
>          u32 word_delay_ns;
>          u32 delay_ns;
>          u32 cs_change_delay_ns;
>          u32 cs_setup_ns;
>          u32 cs_hold_ns;
>          u32 cs_inactive_ns;
>       };
>

Hello Haixu Cui,

I think there may be some unnecessary redundancy in these fields. See below=
.

>       @slave_id: chipselect index the SPI transfer used
>       @bits_per_word: the number of bits in each SPI transfer word
>       @cs_change: True to deselect device before starting the next transf=
er
>       @tx_nbits: number of bits used for writing
>       @rx_nbits: number of bits used for reading
>       @reserved: reserved for future use
>       @mode: the spi mode defines how data is clocked out and in
>       @freq: transfer speed
>       @word_delay_ns: delay to be inserted between consecutive words of
> a transfer, in ns unit
>       @cs_setup_ns: delay to be introduced by the controller after CS is
> asserted, in ns unit

(I am reordering these in my quoted text to be grouped appropriately.)

>       @delay_ns: delay to be introduced after this transfer before
> (optionally) changing the chipselect status, in ns unit
>       @cs_hold_ns: delay to be introduced by the controller before CS is
> deasserted, in ns unit

Aren't @delay_ns and @cs_hold_ns specifying the same thing?

Linux spi_transfer defines @delay as:
    delay to be introduced after this transfer before
    (optionally) changing the chipselect status, then starting the
    next transfer or completing this spi_message.

...and spi_device @cs_hold as: delay to be introduced by the
    controller before CS is deasserted.

(This is the period labeled "D" in my diagram.)

I guess the only difference is if you have a series of transfers, where
only the last transfer has @cs_change=3Dtrue, and all preceding messages
have @cs_change=3Dfalse. In this case, @delay_ns would apply between each
transfer, and after the last transfer @delay_ns + @cs_hold would apply
before CS is deasserted:

    Transfer[0] (cs_change=3Dfalse)
    delay(@delay_ns)
    Transfer[1] (cs_change=3Dfalse)
    delay(@delay_ns)
    Transfer[3] (cs_change=3Dtrue)
    delay(@delay_ns) + delay(@cs_hold_ns)
    CS deasserted


>       @cs_change_delay_ns: delay between cs deassert and assert when
> cs_change is set, in ns unit
>       @cs_inactive_ns: delay to be introduced by the controller after CS
> is deasserted, in ns unit

Similarly, aren't @cs_change_delay_ns and @cs_inactive_ns applied at the
same point in the cycle?

(This is the period labeled "E" in my diagram.)

Linux spi_device defines @cs_inactive as: delay to be introduced by the
    controller after CS is deasserted. If @cs_change_delay is used from
    @spi_transfer, then the two delays will be added up.

...and spi_transfer defines @cs_change_delay as: delay between cs
    deassert and assert when @cs_change is set and @spi_transfer is not
    the last in @spi_message.

It even says they will be added up.

The only difference seems to be that @cs_change_delay applies only when
the transfer is not the last in a list (spi_message, which we don't have
here.)

    CS asserted
    Transfer[0] (cs_change=3Dtrue)
    CS deasserted
    delay(@cs_inactive) + delay(@cs_change_delay)
    CS asserted
    Transfer[1] (cs_change=3Dtrue)
    CS deasserted
    delay(@cs_inactive)


In both cases of redundancy above, the difference in semantics between
the spi_device and spi_transfer only seem to apply when a series of
transfers (spi_message or SPI_IOC_MESSAGE) are involved. Since (AFAICT)
you aren't proposing that construct here, maybe the separate fields are
not necessary? IOW, maybe @delay_ns and @cs_change_delay can be
eliminated?

Please let me know if I've misunderstood anything.

Jonathon

>
>      Could you please help check if this new structure contains enough
> information. Really appreciate for kind help.
>
> Best Regards
> Haixu Cui
>
> On 7/1/2023 5:59 AM, Jonathon Reinhart wrote:
> >> Hi @jrreinhart@google.com,
> >>       Thank you very much for your helpful comments.
> >>
> >>       I missed the delay and cs_change_delay parameters. I will add bo=
th
> >> of them, although cs_change_delay can not be set from userspace, but c=
an
> >> be set in kernel space.
> >>
> >>
> >>       For CS delays such as PRE_DELAY/POST_DELAY, it seems that they a=
re
> >> defined in structure spi_device:
> >>
> >>       @cs_setup: delay to be introduced by the controller after CS is
> >> asserted.
> >>
> >>       @cs_hold: delay to be introduced by the controller before CS is
> >> deasserted.
> >>
> >>       @cs_inactive: delay to be introduced by the controller after CS =
is
> >> deasserted. If @cs_change_delay is used from @spi_transfer, then the
> >> two delays will be added up.
> >>
> >>       They show the SPI controller ability to control the CS
> >> assertion/deassertion timing and should not be changed for each transf=
er
> >> (because thay can be updated by setting structure spi_transfer or
> >> structure spi_ioc_transfer). I think it better to define these paramet=
er
> >> in host OS rather than in guest OS since it's the host OS to operate t=
he
> >> hardware SPI controller directly. Besides, it can also avoid passing t=
he
> >> same values from guest to host time after time.
> >>
> >>       What's your opinion on this topic? Again, thank you very much.
> >
> > Hi Haixu,
> >
> > I took another look at the Linux structures and attempted to map up the
> > delay parameters to the various points in a SPI sequence. Please correc=
t
> > me if I'm wrong about any of this.
> >
> > Consider this diagram where CS# is an active-low chip select, and SCLK
> > is the serial clock:
> >
> >        ___.                                                   ._____.
> >    CS#    |___________________________________________________|     |__=
_
> >           .                                                   .     .
> >           .                                                   .     .
> >   SCLK ________NNNN___NNNN___NNNN_______NNNN___NNNN___NNNN_____________=
_
> >           .   .    . .           .     .                  .   .     .
> > Delays:  +-A-+    +B+           +--C--+                  +-D-+--E--+
> >           .   .    . .           .     .                  .   .     .
> >           0   1    2 3           4     5                  6   7     8
> >           .   .    .             .     .                  .   .
> > Terms:   .   +Word+             .     .                  .   .
> >           .   .                  .     .                  .   .
> >           .   +-------Frame------+     +-------Frame------+   .
> >           .                                                   .
> >           +-----------------Transfer--------------------------+
> >
> > Using NXP terminology:
> >
> >    From 1 to 2 is a "word"     (with e.g. 8 bits).
> >    From 1 to 4 is a "frame"    (with 3 words).
> >    From 1 to 6 is a "transfer" (with 3 frames).
> >
> > Linux does not have the concept of a frame, only a series of transfers
> > (a spi_message), each of which can specify whether CS changes or not.
> >
> > I've identified these various timing points and attempted to match them
> > to the Linux spi_device and spi_transfer parameters:
> >
> > A - CS Setup: Delay after CS asserted before clock starts.
> >      spi_device.cs_setup
> >
> > B - Word Delay: Delay between words.
> >      spi_transfer.word_delay
> >
> > C - Frame Delay: Delay between frames.
> >      (Linux does not have the concept of a SPI "frame".)
> >
> > D - CS Hold: Delay after clock stops, and before CS deasserted.
> >      spi_device.cs_hold (+ spi_transfer.delay ??)
> >
> > E - CS Inactive: Delay after CS deasserted, before asserting again.
> >      spi_device.cs_inactive + spi_transfer.cs_change_delay
> >
> >
> > While I agree with you that some of these timings are unlikely to chang=
e
> > from transfer-to-transfer, the subset of which should be specified
> > at the device level vs. per-transfer seems somewhat arbitrary. As you
> > can see there is some overlap between them.
> >
> > If I understand correctly, it appears that the CS hold time *can* be
> > controlled on a per-transfer bases, using spi_transfer.delay
> > ("after this transfer before changing the chipselect status").
> >
> > That leaves CS setup as the only parameter that cannot be influenced on
> > a per-transfer basis.
> >
> > Theoretically, one might require different CS setup/hold times,
> > depending on which slave_id they are talking to (on the same bus).
> > In that case, one must set those spi_device parameters to the worst-cas=
e
> > (maximum) values. However, this is already a Linux limitation, so I'm
> > not sure it needs to be improved here.
> >
> > I think you've achieved parity with what the Linux kernel API allows,
> > and that's probably good enough. As you said, anything else can be
> > adjusted in the host OS -- I'm not sure how the guest would go about
> > achieving that, though. You're not proposing the use of configuration
> > space for virtio-spi, are you?
> >
> > Regards,
> > Jonathon Reinhart
> >
> >
> >>
> >> Best Regards
> >> Haixu Cui
> >>
> >> On 6/28/2023 1:06 AM, jrreinhart@google.com wrote:
> >>> Hi Haixu,
> >>>
> >>>> +The \field{word_delay} defines how long to wait between words withi=
n
> >>>> one SPI transfer,
> >>>> +in ns unit.
> >>>
> >>> I'm a little surprised to see a word_delay but no frame_delay or
> >>> transfer_delay.
> >>>
> >>> For example, many SPI peripherals require a delay after CS is asserte=
d,
> >>> but before the first SCLK edge, allowing them to prepare to send data=
.
> >>> (E.g. an ADC might begin taking a sample.)
> >>>
> >>>
> >>> The linux struct spi_transfer has three delay fields:
> >>>
> >>> * @cs_change_delay: delay between cs deassert and assert when
> >>> *      @cs_change is set and @spi_transfer is not the last in
> >>> *      @spi_message
> >>> * @delay: delay to be introduced after this transfer before
> >>> *    (optionally) changing the chipselect status, then starting the
> >>> *    next transfer or completing this @spi_message.
> >>> * @word_delay: inter word delay to be introduced after each word size
> >>> *    (set by bits_per_word) transmission.
> >>>
> >>> The userspace spidev.h API has only two:
> >>>
> >>> * @delay_usecs: If nonzero, how long to delay after the last bit
> >>> *       transfer before optionally deselecting the device before the
> >>> *       next transfer.
> >>> * @word_delay_usecs: If nonzero, how long to wait between words withi=
n
> >>> *       one transfer. This property needs explicit support in the SPI
> >>> *       controller, otherwise it is silently ignored.
> >>>
> >>> The NXP i.MX RT500 SPI (master) controller, for example, has four
> >>> configurable delays:
> >>>
> >>> - PRE_DELAY: After CS assertion, before first SCLK edge.
> >>> - POST_DELAY: After a transfer, before CS deassertion.
> >>> - FRAME_DELAY: Between frames (which are arbitrarily defined by
> >>>     software).
> >>> - TRANSFER_DELAY: Minimum CS deassertion time between transfers.
> >>>
> >>> The NVIDIA Tegra114 SPI controller has:
> >>>
> >>> - nvidia,cs-setup-clk-count: CS setup timing parameter.
> >>> - nvidia,cs-hold-clk-count: CS hold timing parameter.
> >>>
> >>>
> >>> I understand that accurately representing all possible delays might b=
e
> >>> difficult or futile, but I'm curious to understand why, of all the
> >>> possible delays, inter-word delay was chosen for inclusion.
> >>>
> >>> In a microcontroller, delays around CS (de)assertion can be customize=
d
> >>> by using a GPIO -- rather than the hardware SPI block -- to drive the=
 CS
> >>> signal. This way, delays can be inserted where needed. To do so with =
a
> >>> virtualized SPI controller might prove difficult however, as the virt=
ual
> >>> channel carrying a CS GPIO signal might not be synchronized to the
> >>> channel carrying the SPI data.
> >>>
> >>> Curious to hear your thoughts.
> >>>
> >>> Thanks,
> >>> Jonathon Reinhart

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

