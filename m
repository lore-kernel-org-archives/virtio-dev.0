Return-Path: <virtio-dev-return-13382-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E2CEB64DC
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Jul 2023 16:20:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id E8FC842C2E
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Jul 2023 16:20:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C4948986603
	for <virtio-dev@archiver.kernel.org>; Mon, 17 Jul 2023 16:20:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id A7D85986191; Mon, 17 Jul 2023 16:20:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3EC4F9865B8
	for <virtio-dev@lists.oasis-open.org>; Mon, 17 Jul 2023 16:19:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689610797; x=1692202797;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vxKkZzCw2WuLi/1NzNBJipGRWCAd6HH+/Lz/1WbjzJ8=;
        b=ermatJ7EZJxwVWeoOMYUSguOXJULenb8gcpi9kcbxCmZLqTF4DR3/1H5w5DF/9aJYI
         N/8oshcVOmIQFIoZMLcnmDDW9ajvxEuucAonOUhBlRMaLovW4A+iUTe/7O8jpIGQNpXY
         oCIfig3LCyjhlBOrnLOfR62tp3zCnHiZw8jjAwYUw8cW0iKId7gD1wrzJrW9ZzRx8wVv
         W3KAu2KGt8PdlLE1a07R0kR2D/qfP5y3nRCcR5+OQvcnjWLHBQYb9V81pe5kS3DqkMp+
         R86VwpULhdAv+9h7Lfoj1CQJaEchL/cdjymFIj+IiQjhkqs+T95Gr9VetgQbyqUwWb8Z
         QdWA==
X-Gm-Message-State: ABy/qLYVFMindnCmXtqlxrs5/mVTxOib7q61Hy5zyPI6xyYUa5bAmffX
	vdimtr9EVeyGZ8p2T5oemgTdESD72DJOJKUYV24tog==
X-Google-Smtp-Source: APBJJlGwvRkO/DTVjy5lhJG6PVII0i3t1wc3ZzRogqmAi5nEmsZLz3YLke1b/CL6pIYs1L6DQ5n+tmRk+qx0I2Iimss=
X-Received: by 2002:a05:6e02:1bcf:b0:346:5a8b:545e with SMTP id
 x15-20020a056e021bcf00b003465a8b545emr1430434ilv.14.1689610796588; Mon, 17
 Jul 2023 09:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000925c1305ff1f7c76@google.com> <fd2e0d5d-a3e9-027a-bec1-d0e821ec6421@quicinc.com>
 <CAJJa5HxA6T+xv--80aWEtGWNx=a-yfNXwNsnyz3s8praHqg6Ew@mail.gmail.com>
 <46ab6180-c639-6da4-d6c3-dc8b87345de9@quicinc.com> <CAJJa5HwV76co8n4WeeL-mcMwwL9sKVWz_Ejiv-EMWgemsGGS3w@mail.gmail.com>
 <e778aec9-5401-d11d-9363-f8ac2436ad76@quicinc.com>
In-Reply-To: <e778aec9-5401-d11d-9363-f8ac2436ad76@quicinc.com>
From: Jonathon Reinhart <jrreinhart@google.com>
Date: Mon, 17 Jul 2023 12:19:45 -0400
Message-ID: <CAJJa5HxvVFtcjX=PVw5UnAStG=GiDRUkEr_LRbyAmwvfAMTFwA@mail.gmail.com>
To: Haixu Cui <quic_haixcui@quicinc.com>
Cc: Cornelia Huck <cohuck@redhat.com>, quic_ztu@quicinc.com, 
	virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev][PATCH 2/2] virtio-spi: add the device specification

On Mon, Jul 17, 2023 at 10:53=E2=80=AFAM Haixu Cui <quic_haixcui@quicinc.co=
m> wrote:
>
> Hi Jonathon Reinhart,
>      Thank you very much for your comments.
>
> On 7/11/2023 12:42 AM, Jonathon Reinhart wrote:
> > On Fri, Jul 7, 2023 at 3:21=E2=80=AFAM Haixu Cui <quic_haixcui@quicinc.=
com> wrote:
> >>
> >> Hi Jonathon Reinhart,
> >>
> >>       Thank you so much for all your helpful advice and info!
> >>
> >>       I took a look at latest Linux SPI driver and found, for
> >> cs_setup/cs_hold/cs_inactive set in device-tree, there are following t=
wo
> >> conditions:
> >>       1) if SPI controller supports CS timing configuration and CS is =
not
> >> using a GPIO line, then the SPI driver set the
> >> cs_setup/cs_hold/ca_inactive values into the corresponding SPI CS regi=
sters;
> >>       2) if CS is using a GPIO line, or SPI controller doesn't support=
 CS
> >> timing configuration, it is the software to perform the
> >> cs_setup/cs_hold/cs_inactive delays, which is implemented in function
> >> spi_set_cs in driver/spi/spi.c.
> >>
> >>       So I agree it is necessary to pass cs_setup/cs_hold/cs_inactive =
to
> >> the host for each transfer.
> >>
> >>       For condition 1, host should set these values into the CS timing
> >> registers. And as you mentioned "one might require different CS
> >> setup/hold times, depending on which slave_id they are talking to (on
> >> the same bus)", if so, host need to overwrite the CS timing registers
> >> between the two transfers talking to different salve_id.
> >>
> >>       For condition 2, SPI driver running in the host performing the
> >> cs_setup/cs_hold/cs_inactive delays seems more accurate, compared with
> >> performing delays in guest.
> >>
> >>
> >>       And the latest virtio spi transfer structure is defined as follo=
ws:
> >>
> >>        struct spi_transfer_head {
> >>           u8 slave_id;
> >>           u8 bits_per_word;
> >>           u8 cs_change;
> >>           u8 tx_nbits;
> >>          u8 rx_nbits;
> >>          u8 reserved[3];
> >>           u32 mode;
> >>           u32 freq;
> >>           u32 word_delay_ns;
> >>           u32 delay_ns;
> >>           u32 cs_change_delay_ns;
> >>           u32 cs_setup_ns;
> >>           u32 cs_hold_ns;
> >>           u32 cs_inactive_ns;
> >>        };
> >>
> >
> > Hello Haixu Cui,
> >
> > I think there may be some unnecessary redundancy in these fields. See b=
elow.
> >
> >>        @slave_id: chipselect index the SPI transfer used
> >>        @bits_per_word: the number of bits in each SPI transfer word
> >>        @cs_change: True to deselect device before starting the next tr=
ansfer
> >>        @tx_nbits: number of bits used for writing
> >>        @rx_nbits: number of bits used for reading
> >>        @reserved: reserved for future use
> >>        @mode: the spi mode defines how data is clocked out and in
> >>        @freq: transfer speed
> >>        @word_delay_ns: delay to be inserted between consecutive words =
of
> >> a transfer, in ns unit
> >>        @cs_setup_ns: delay to be introduced by the controller after CS=
 is
> >> asserted, in ns unit
> >
> > (I am reordering these in my quoted text to be grouped appropriately.)
> >
> >>        @delay_ns: delay to be introduced after this transfer before
> >> (optionally) changing the chipselect status, in ns unit
> >>        @cs_hold_ns: delay to be introduced by the controller before CS=
 is
> >> deasserted, in ns unit
> >
> > Aren't @delay_ns and @cs_hold_ns specifying the same thing?
>
> I think they are not the same thing, delay_ns is the spi transfer
> property while cs_hold_ns is the spi device property=EF=BC=8C although th=
ey take
> effect at the same stage.

I see. I think we have differing perspectives here.

I assume that you are looking at this from the perspective of a Linux
guest on a Linux host, where virtio-spi is connecting a virtual spi
driver in the guest to a hardware spi driver on the host. In this
case, it makes sense to have parity between the fields in Linux
spi_device / spi_transfer and the fields in the virtio
spi_transfer_head. It makes the implementation easier if there is a
simple 1:1 mapping between them, even if you have to copy some
spi_transfer_head fields to spi_device (like the cs_ fields).

My interest in virtio-spi is actually a bit different. We are looking
to connect a virtual spi driver in a guest running Linux to another
instance of QEMU emulating a baremetal firmware image. For a use-case
like mine, the redundancy in the fields complicates things slightly.
Because there is no physical SPI controller represented by the
spi_device, all fields on spi_transfer_head have to be implemented in
software -- including adding together the delays when appropriate
(@delay_ns + @cs_hold_ns, and @cs_change_delay_ns + @cs_inactive_ns).

It's not a deal-breaker, but I wanted you to consider the non-Linux
perspective. From a purely protocol-centric view, I think the fields
can still be seen as redundant.

> I list 4 conditions, here transfer cs delay including
> spi_transfer->delay and spi_transfer->cs_change_delay, and device cs
> delay including spi_device->cs_hold, spi_device->cs_setup and
> spi_device->cs_inactive.
>
> condition 1:
>      virtio-spi controller only has transfer_one interface but no
> transfer_one_message interface, and spi_transfer_one_message is the
> default transfer_one_message interface of virtio-spi controller.
>      Hardware SPI controller doesn't support CS timing configuration.
>
>      In this case, both transfer cs delay and device cs delay are
> executed by software in spi_transfer_one_message function in guest Linux
> OS. So guest doesn't need pass these cs timing parameters to host.
>
> condition 2:
>      virtio-spi controller only has transfer_one interface but no
> transfer_one_message interface, and spi_transfer_one_message is the
> default transfer_one_message interface of virtio-spi controller.
>      Hardware SPI controller supports device CS timing configuration,
> which means it has registers to hold these configuration values.
>
>      In this case, transfer cs delay is executed in
> spi_transfer_one_message function, and guest need pass device cs delay
> to host. Because one SPI number may have more than one slave, these
> slaves also may have different device cs delay values, so for each
> transfer, guest should pass device cs delay along with the slave_id to
> host to overwrite the corresponding registers.
>
> condition 3:
>      virtio-spi controller has transfer_one_message interface but no
> transfer_one interface.
>      Hardware SPI controller doesn't support CS timing configuration.
>
>      In this case, host SPI driver should implement all cs delay
> operations with the transfer cs delay and device cs delay received from
> the guest.
>
> condition 4:
>      virtio-spi controller has transfer_one_message interface but no
> transfer_one interface.
>      Hardware SPI controller supports CS timing configuration.
>
>      In this case, guest pass transfer cs delay and device cs delay to
> guest, and guest SPI driver should implement logic to execute transfer
> cs delay then overwrite the corresponding register with the device cs
> delay values.
>
> Except for condition 1, in other three conditions, guest should pass
> both transfer cs delay and device cs delay to host.
>
>
> Best Regards
> Haixu Cui
>
> >
> > Linux spi_transfer defines @delay as:
> >      delay to be introduced after this transfer before
> >      (optionally) changing the chipselect status, then starting the
> >      next transfer or completing this spi_message.
> >
> > ...and spi_device @cs_hold as: delay to be introduced by the
> >      controller before CS is deasserted.
> >
> > (This is the period labeled "D" in my diagram.)
> >
> > I guess the only difference is if you have a series of transfers, where
> > only the last transfer has @cs_change=3Dtrue, and all preceding message=
s
> > have @cs_change=3Dfalse. In this case, @delay_ns would apply between ea=
ch
> > transfer, and after the last transfer @delay_ns + @cs_hold would apply
> > before CS is deasserted:
> >
> >      Transfer[0] (cs_change=3Dfalse)
> >      delay(@delay_ns)
> >      Transfer[1] (cs_change=3Dfalse)
> >      delay(@delay_ns)
> >      Transfer[3] (cs_change=3Dtrue)
> >      delay(@delay_ns) + delay(@cs_hold_ns)
> >      CS deasserted
> >
> >
> >>        @cs_change_delay_ns: delay between cs deassert and assert when
> >> cs_change is set, in ns unit
> >>        @cs_inactive_ns: delay to be introduced by the controller after=
 CS
> >> is deasserted, in ns unit
> >
> > Similarly, aren't @cs_change_delay_ns and @cs_inactive_ns applied at th=
e
> > same point in the cycle?
> >
> > (This is the period labeled "E" in my diagram.)
> >
> > Linux spi_device defines @cs_inactive as: delay to be introduced by the
> >      controller after CS is deasserted. If @cs_change_delay is used fro=
m
> >      @spi_transfer, then the two delays will be added up.
> >
> > ...and spi_transfer defines @cs_change_delay as: delay between cs
> >      deassert and assert when @cs_change is set and @spi_transfer is no=
t
> >      the last in @spi_message.
> >
> > It even says they will be added up.
> >
> > The only difference seems to be that @cs_change_delay applies only when
> > the transfer is not the last in a list (spi_message, which we don't hav=
e
> > here.)
> >
> >      CS asserted
> >      Transfer[0] (cs_change=3Dtrue)
> >      CS deasserted
> >      delay(@cs_inactive) + delay(@cs_change_delay)
> >      CS asserted
> >      Transfer[1] (cs_change=3Dtrue)
> >      CS deasserted
> >      delay(@cs_inactive)
> >
> >
> > In both cases of redundancy above, the difference in semantics between
> > the spi_device and spi_transfer only seem to apply when a series of
> > transfers (spi_message or SPI_IOC_MESSAGE) are involved. Since (AFAICT)
> > you aren't proposing that construct here, maybe the separate fields are
> > not necessary? IOW, maybe @delay_ns and @cs_change_delay can be
> > eliminated?
> >
> > Please let me know if I've misunderstood anything.
> >
> > Jonathon
> >
> >>
> >>       Could you please help check if this new structure contains enoug=
h
> >> information. Really appreciate for kind help.
> >>
> >> Best Regards
> >> Haixu Cui
> >>
> >> On 7/1/2023 5:59 AM, Jonathon Reinhart wrote:
> >>>> Hi @jrreinhart@google.com,
> >>>>        Thank you very much for your helpful comments.
> >>>>
> >>>>        I missed the delay and cs_change_delay parameters. I will add=
 both
> >>>> of them, although cs_change_delay can not be set from userspace, but=
 can
> >>>> be set in kernel space.
> >>>>
> >>>>
> >>>>        For CS delays such as PRE_DELAY/POST_DELAY, it seems that the=
y are
> >>>> defined in structure spi_device:
> >>>>
> >>>>        @cs_setup: delay to be introduced by the controller after CS =
is
> >>>> asserted.
> >>>>
> >>>>        @cs_hold: delay to be introduced by the controller before CS =
is
> >>>> deasserted.
> >>>>
> >>>>        @cs_inactive: delay to be introduced by the controller after =
CS is
> >>>> deasserted. If @cs_change_delay is used from @spi_transfer, then the
> >>>> two delays will be added up.
> >>>>
> >>>>        They show the SPI controller ability to control the CS
> >>>> assertion/deassertion timing and should not be changed for each tran=
sfer
> >>>> (because thay can be updated by setting structure spi_transfer or
> >>>> structure spi_ioc_transfer). I think it better to define these param=
eter
> >>>> in host OS rather than in guest OS since it's the host OS to operate=
 the
> >>>> hardware SPI controller directly. Besides, it can also avoid passing=
 the
> >>>> same values from guest to host time after time.
> >>>>
> >>>>        What's your opinion on this topic? Again, thank you very much=
.
> >>>
> >>> Hi Haixu,
> >>>
> >>> I took another look at the Linux structures and attempted to map up t=
he
> >>> delay parameters to the various points in a SPI sequence. Please corr=
ect
> >>> me if I'm wrong about any of this.
> >>>
> >>> Consider this diagram where CS# is an active-low chip select, and SCL=
K
> >>> is the serial clock:
> >>>
> >>>         ___.                                                   ._____=
.
> >>>     CS#    |___________________________________________________|     =
|___
> >>>            .                                                   .     =
.
> >>>            .                                                   .     =
.
> >>>    SCLK ________NNNN___NNNN___NNNN_______NNNN___NNNN___NNNN__________=
____
> >>>            .   .    . .           .     .                  .   .     =
.
> >>> Delays:  +-A-+    +B+           +--C--+                  +-D-+--E--+
> >>>            .   .    . .           .     .                  .   .     =
.
> >>>            0   1    2 3           4     5                  6   7     =
8
> >>>            .   .    .             .     .                  .   .
> >>> Terms:   .   +Word+             .     .                  .   .
> >>>            .   .                  .     .                  .   .
> >>>            .   +-------Frame------+     +-------Frame------+   .
> >>>            .                                                   .
> >>>            +-----------------Transfer--------------------------+
> >>>
> >>> Using NXP terminology:
> >>>
> >>>     From 1 to 2 is a "word"     (with e.g. 8 bits).
> >>>     From 1 to 4 is a "frame"    (with 3 words).
> >>>     From 1 to 6 is a "transfer" (with 3 frames).
> >>>
> >>> Linux does not have the concept of a frame, only a series of transfer=
s
> >>> (a spi_message), each of which can specify whether CS changes or not.
> >>>
> >>> I've identified these various timing points and attempted to match th=
em
> >>> to the Linux spi_device and spi_transfer parameters:
> >>>
> >>> A - CS Setup: Delay after CS asserted before clock starts.
> >>>       spi_device.cs_setup
> >>>
> >>> B - Word Delay: Delay between words.
> >>>       spi_transfer.word_delay
> >>>
> >>> C - Frame Delay: Delay between frames.
> >>>       (Linux does not have the concept of a SPI "frame".)
> >>>
> >>> D - CS Hold: Delay after clock stops, and before CS deasserted.
> >>>       spi_device.cs_hold (+ spi_transfer.delay ??)
> >>>
> >>> E - CS Inactive: Delay after CS deasserted, before asserting again.
> >>>       spi_device.cs_inactive + spi_transfer.cs_change_delay
> >>>
> >>>
> >>> While I agree with you that some of these timings are unlikely to cha=
nge
> >>> from transfer-to-transfer, the subset of which should be specified
> >>> at the device level vs. per-transfer seems somewhat arbitrary. As you
> >>> can see there is some overlap between them.
> >>>
> >>> If I understand correctly, it appears that the CS hold time *can* be
> >>> controlled on a per-transfer bases, using spi_transfer.delay
> >>> ("after this transfer before changing the chipselect status").
> >>>
> >>> That leaves CS setup as the only parameter that cannot be influenced =
on
> >>> a per-transfer basis.
> >>>
> >>> Theoretically, one might require different CS setup/hold times,
> >>> depending on which slave_id they are talking to (on the same bus).
> >>> In that case, one must set those spi_device parameters to the worst-c=
ase
> >>> (maximum) values. However, this is already a Linux limitation, so I'm
> >>> not sure it needs to be improved here.
> >>>
> >>> I think you've achieved parity with what the Linux kernel API allows,
> >>> and that's probably good enough. As you said, anything else can be
> >>> adjusted in the host OS -- I'm not sure how the guest would go about
> >>> achieving that, though. You're not proposing the use of configuration
> >>> space for virtio-spi, are you?
> >>>
> >>> Regards,
> >>> Jonathon Reinhart
> >>>
> >>>
> >>>>
> >>>> Best Regards
> >>>> Haixu Cui
> >>>>
> >>>> On 6/28/2023 1:06 AM, jrreinhart@google.com wrote:
> >>>>> Hi Haixu,
> >>>>>
> >>>>>> +The \field{word_delay} defines how long to wait between words wit=
hin
> >>>>>> one SPI transfer,
> >>>>>> +in ns unit.
> >>>>>
> >>>>> I'm a little surprised to see a word_delay but no frame_delay or
> >>>>> transfer_delay.
> >>>>>
> >>>>> For example, many SPI peripherals require a delay after CS is asser=
ted,
> >>>>> but before the first SCLK edge, allowing them to prepare to send da=
ta.
> >>>>> (E.g. an ADC might begin taking a sample.)
> >>>>>
> >>>>>
> >>>>> The linux struct spi_transfer has three delay fields:
> >>>>>
> >>>>> * @cs_change_delay: delay between cs deassert and assert when
> >>>>> *      @cs_change is set and @spi_transfer is not the last in
> >>>>> *      @spi_message
> >>>>> * @delay: delay to be introduced after this transfer before
> >>>>> *    (optionally) changing the chipselect status, then starting the
> >>>>> *    next transfer or completing this @spi_message.
> >>>>> * @word_delay: inter word delay to be introduced after each word si=
ze
> >>>>> *    (set by bits_per_word) transmission.
> >>>>>
> >>>>> The userspace spidev.h API has only two:
> >>>>>
> >>>>> * @delay_usecs: If nonzero, how long to delay after the last bit
> >>>>> *       transfer before optionally deselecting the device before th=
e
> >>>>> *       next transfer.
> >>>>> * @word_delay_usecs: If nonzero, how long to wait between words wit=
hin
> >>>>> *       one transfer. This property needs explicit support in the S=
PI
> >>>>> *       controller, otherwise it is silently ignored.
> >>>>>
> >>>>> The NXP i.MX RT500 SPI (master) controller, for example, has four
> >>>>> configurable delays:
> >>>>>
> >>>>> - PRE_DELAY: After CS assertion, before first SCLK edge.
> >>>>> - POST_DELAY: After a transfer, before CS deassertion.
> >>>>> - FRAME_DELAY: Between frames (which are arbitrarily defined by
> >>>>>      software).
> >>>>> - TRANSFER_DELAY: Minimum CS deassertion time between transfers.
> >>>>>
> >>>>> The NVIDIA Tegra114 SPI controller has:
> >>>>>
> >>>>> - nvidia,cs-setup-clk-count: CS setup timing parameter.
> >>>>> - nvidia,cs-hold-clk-count: CS hold timing parameter.
> >>>>>
> >>>>>
> >>>>> I understand that accurately representing all possible delays might=
 be
> >>>>> difficult or futile, but I'm curious to understand why, of all the
> >>>>> possible delays, inter-word delay was chosen for inclusion.
> >>>>>
> >>>>> In a microcontroller, delays around CS (de)assertion can be customi=
zed
> >>>>> by using a GPIO -- rather than the hardware SPI block -- to drive t=
he CS
> >>>>> signal. This way, delays can be inserted where needed. To do so wit=
h a
> >>>>> virtualized SPI controller might prove difficult however, as the vi=
rtual
> >>>>> channel carrying a CS GPIO signal might not be synchronized to the
> >>>>> channel carrying the SPI data.
> >>>>>
> >>>>> Curious to hear your thoughts.
> >>>>>
> >>>>> Thanks,
> >>>>> Jonathon Reinhart

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

