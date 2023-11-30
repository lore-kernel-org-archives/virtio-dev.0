Return-Path: <virtio-dev-return-14095-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C59FBC10DC2
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Nov 2023 16:43:47 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id F3F88217AB
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Nov 2023 16:43:46 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D3E0F98669E
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Nov 2023 16:43:46 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BCC8698668B; Thu, 30 Nov 2023 16:43:46 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id AD1CE98668C
	for <virtio-dev@lists.oasis-open.org>; Thu, 30 Nov 2023 16:43:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701362625; x=1701967425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rKm583GmYtBk9Bb+AeNElgEcytTtkdjinT9kiWgsXXA=;
        b=jbk0YU1OVYsn6fOAvfqVpRN7l4vDtdgAmOy6iyBGUHyNH8Tr7XhifONoWpYfJrP0wH
         j78O74fgIRJqQ5SMd2ZP+tkWN4PCdjuTKAsKMSL3PGHyt1yoYVeju1yl5e25eFlBiL+z
         x8EGgdEsQ3n8blSWiuRKMWGezDZrvJS6QQNTXp/ks03ZeUHKKwK9Qp/5+uymQ/7H56WW
         F8FcQ7rSrdE2Mj6vcda6GyAyIswSW5+uRVQKC1BJRrU/CDfPQKT1eq4+G5xs76ODJV5c
         T1mTlatE8/wyaSSs0i7PW8zMaodNWqJyJbbeb4V4iabi9DAk7v31OfTEXILE5s9L5paU
         67/w==
X-Gm-Message-State: AOJu0YzFev8c3QfAGAF4/x74aPbcbkShyy0B4MPPqXqgdYTC/St85JW4
	4nVloEmEVcA7E5L/MmtPtSsVEfsDKvw6m9kVEusi0Q==
X-Google-Smtp-Source: AGHT+IFxIKBa1tqPuei+t3YNQYNLEo22+z1HTgkjWoSuDLfihLCPCbThavhrgNgaRHjJH8+rusjZ8X1FPeiIZjPocY4=
X-Received: by 2002:a50:d098:0:b0:54b:6b3f:4aa8 with SMTP id
 v24-20020a50d098000000b0054b6b3f4aa8mr186981edd.4.1701362624722; Thu, 30 Nov
 2023 08:43:44 -0800 (PST)
MIME-Version: 1.0
References: <20231124072015.12655-1-quic_haixcui@quicinc.com>
 <20231127101750.6xmthho6lnppyw3k@vireshk-i7> <2ca987a6-eeb2-4ed6-9a12-10ae450eb4bf@quicinc.com>
 <20231129073022.ohxsfuawambvh3hm@vireshk-i7> <0674be8e-221f-479a-8da2-8a3e59e45bb9@quicinc.com>
 <871qc9x8k2.fsf@redhat.com> <9e0c5e5e-db7b-4634-9423-f4db1800b148@quicinc.com>
 <20231129100002.q73wtz6mkfixcbzt@vireshk-i7>
In-Reply-To: <20231129100002.q73wtz6mkfixcbzt@vireshk-i7>
From: Jonathon Reinhart <jrreinhart@google.com>
Date: Thu, 30 Nov 2023 11:43:33 -0500
Message-ID: <CAJJa5HxD4=ucpQG7TwrcDbWnr+vVAoerfPh9j4SMQTF6AAu3aQ@mail.gmail.com>
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Haixu Cui <quic_haixcui@quicinc.com>, Cornelia Huck <cohuck@redhat.com>, 
	virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, 
	harald.mommer@opensynergy.com, broonie@kernel.org, 
	qiang4.zhang@linux.intel.com, quic_ztu@quicinc.com, alex.bennee@linaro.org, 
	vincent.guittot@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] Re: [virtio-comment] [PATCH] [PATCH v5] virtio-spi:
 add the device specification

On Wed, Nov 29, 2023 at 5:00=E2=80=AFAM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 29-11-23, 16:54, Haixu Cui wrote:
> > On 11/29/2023 4:33 PM, Cornelia Huck wrote:
> > > On Wed, Nov 29 2023, Haixu Cui <quic_haixcui@quicinc.com> wrote:
> > > > On 11/29/2023 3:30 PM, Viresh Kumar wrote:
> > > > > On 28-11-23, 20:58, Haixu Cui wrote:
> > > > > > On 11/27/2023 6:17 PM, Viresh Kumar wrote:
> > > > > Hmm, I worked with a SPI controller over a decade ago, and I must=
 be forgetting
> > > > > something here I guess. But from whatever little I remember, with=
 full-duplex
> > > > > transfer, data flows on both MOSI and MISO lines as soon as clock=
 signal is
> > > > > applied.  And so amount of data sent is always be equal to amount=
 of data
> > > > > received by both sides.
> > > > >
> > > > > Also if I see Linux's implementation of the `struct spi_transfer`=
 [1], I see
> > > > > `tx_buf`, `rx_buf` and a single `len` field, which applies to bot=
h the buffers.
> > > > > Which I guess is indicating that both buffers are supposed to be =
of same length.
> > > > >
> > > > > What am I missing ?
> > > >
> > > > Oh so sorry for that. And I don't make it clear. Yes, tx_buf and rx=
_buf
> > > > have the same size, Linux has such restriction. Just as you mention=
,
> > > > kernel level spi_transfer has single "len", the same for
> > > > spi_ioc_transfer passed from the userland.
> > > >
> > > > But I am not sure if this is in the scope of the spec. Because this=
 is
> > > > ensured by Linux, but Virtio SPI driver won't also can't verify thi=
s.
> > > > This is a prerequisite for virtio spi processing requests.
>
> I don't think this is a Linux only thing. This is how the SPI protocol is
> designed to begin with. A clock is applied, data from FIFOs of both maste=
r and
> slaves gets exchanged over the MOSI and MISO lines... And the length is _=
always_
> the same. We are talking about the full-duplex mode of the hardware here =
and
> this is how it works AFAICT.
>

IMO the length doesn't _need_ to be the same. Sure, the clock always
runs, and the shift registers of the master and slave are always
clocking in data from their respective input lines. But that doesn't
mean that (all of) the received data actually *means* anything -- that
is determined by the application protocol.

For example, the initiator (master) might want to send 100 bytes but
only cares about the first 8 bytes received. Why should it need to
provide a 100 byte buffer for that received data? Certainly the stack
should be capable of discarding the other 92 bytes?

For a given SPI transfer, the clock needs to run for
(max(num_tx_bytes, num_rx_bytes) * word_size) cycles.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

