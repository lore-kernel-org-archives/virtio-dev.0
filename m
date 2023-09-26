Return-Path: <virtio-dev-return-13958-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C016BEE3F2A
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 06:44:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 178AD2AD4D
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 06:44:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EEC2B98640F
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 06:44:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D3581983DE3; Tue, 26 Sep 2023 06:44:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C229C9863A6
	for <virtio-dev@lists.oasis-open.org>; Tue, 26 Sep 2023 06:44:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695710668; x=1696315468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EuN6SIaIKQkrXqkuAtnD10zrgpzgl7JTDsK2ngMSMhw=;
        b=LYq00DmLYek15H7UF+Nld3PmuK7Ep272yyU15BjxrCkUtgXmKihrwHgwYYvDcGDkMC
         bsZmOCGwi/vrSDlZJs5L+jNOhs3k/AczX1pks4IM8PMk6iNnLYN7uM0zwCNRcQkgZ5a7
         6mYFNPYjBJaki6zjKnqHbQlljjj+vvy+co0iE4FcTlQi4zThP/TF1SlnxAoSiWEHipyh
         LDoMYIws61SXG9eTho2eicNW2OibDA9SkAag66FQ5vfuMpnHw9sVmaDb2KkOlJgKlWie
         5iFL3NRn6JxdzavtzUSfXQkcUXK+bcIhq6TvB/c2LjZV9yfYxf5D5PNR+yxARNEzJllZ
         xh4w==
X-Gm-Message-State: AOJu0YxjVkYc468GOzIgXK4m1OeW2JpOcEfSbijK8z9TviQZn+Nf3Noc
	TIqIKeyIOmYwUr94M12osTY4a633xEKVwpHCfv/GwQ==
X-Google-Smtp-Source: AGHT+IHPM5dL2I+3RrAvnTyTCMtjITEObJsJRtuKSbU+iCHZskh2uVTTYbMcHUvzsvMk4XHMoq7HvFFOstseIEbP6BE=
X-Received: by 2002:a05:6102:134f:b0:450:f9eb:f412 with SMTP id
 j15-20020a056102134f00b00450f9ebf412mr6680903vsl.5.1695710668548; Mon, 25 Sep
 2023 23:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <80a2e4337affb043909c348395fb45aeeb693dc7.1695640593.git.JESHWANTHKUMAR.NK@amd.com>
 <904049f9-3ddf-7e88-c6f3-785a29a08210@linaro.org> <CAHUa44GzHPkntr=sFYYzokW0=9CCN7n6Ch1i6J7L7Uhh5U5P3A@mail.gmail.com>
In-Reply-To: <CAHUa44GzHPkntr=sFYYzokW0=9CCN7n6Ch1i6J7L7Uhh5U5P3A@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 26 Sep 2023 08:44:17 +0200
Message-ID: <CAFA6WYOsPhFkyrG0P7B6Ec=AnDvoUaerLocM89KtmybLmKbsaw@mail.gmail.com>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: jeshwanthkumar.nk@amd.com, Devaraj.Rangasamy@amd.com, 
	Mythri.Pandeshwarakrishna@amd.com, Nimesh.Easow@amd.com, 
	Rijo-john.Thomas@amd.com, babulu.ellune@amd.com, 
	virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, 
	Arnd Bergmann <arnd.bergmann@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] [PATCH v2] virtio-tee: Reserve device ID 46 for TEE device

+cc Alex

On Tue, 26 Sept 2023 at 08:16, Jens Wiklander <jens.wiklander@linaro.org> w=
rote:
>
> Hi,
>
> [+cc Arnd]
>
> On Tue, Sep 26, 2023 at 8:00=E2=80=AFAM Sumit Garg <sumit.garg@linaro.org=
> wrote:
> >
> > +cc Jens
> >
> > > In a virtual environment, an application running in guest VM may want
> > > to delegate security sensitive tasks to a Trusted Application (TA)
> > > running within a Trusted Execution Environment (TEE). A TEE is a trus=
ted
> > > OS running in some secure environment, for example, TrustZone on ARM
> > > CPUs, or a separate secure co-processor etc.
> >
> > I have been exploring this area quite recently with an effort to have a=
 common VIRIO interface which can support different trusted OS implementati=
ons. I guess you intend to test it with AMD-TEE, right? Any plans to test i=
t with OP-TEE? As currently we have these two supported upstream.
> >
> > Do you currently have any virtio frontend/backend implementations for t=
his?
> >
> > >
> > > A virtual TEE device emulates a TEE within a guest VM. Such a virtual
> > > TEE device supports multiple operations such as:
> > >
> > > VIRTIO_TEE_CMD_OPEN_DEVICE =E2=80=93 Open a communication channel wit=
h virtio
> > >                              TEE device.
> > > VIRTIO_TEE_CMD_CLOSE_DEVICE =E2=80=93 Close communication channel wit=
h virtio
> > >                               TEE device.
> > > VIRTIO_TEE_CMD_GET_VERSION =E2=80=93 Get version of virtio TEE.
> > > VIRTIO_TEE_CMD_OPEN_SESSION =E2=80=93 Open a session to communicate w=
ith
> > >                               trusted application running in TEE.
> > > VIRTIO_TEE_CMD_CLOSE_SESSION =E2=80=93 Close a session to end communi=
cation
> > >                                with trusted application running in TE=
E.
> > > VIRTIO_TEE_CMD_INVOKE_FUNC =E2=80=93 Invoke a command or function in =
trusted
> > >                              application running in TEE.
> > > VIRTIO_TEE_CMD_CANCEL_REQ =E2=80=93 Cancel an ongoing command within =
TEE.
> > >
> >
> > How about shared memory support? We would like to register guest pages =
with the trusted OS.
>
> Coincidently Arnd and I (among others) discussed this in person last
> week and the conclusion was that only temporary shared memory is
> possible with virtio. So the shared memory has to be set up and torn
> down by the host during each operation, typically open-session or
> invoke-func.

Agree as I was part of those discussions. But I would like to
understand the reasoning behind it. Is there any restriction by VIRTIO
specification that we can't register guest page PAs to a device (TEE
in our case) to allow for zero copy transfers?

Alex mentioned some references to virtio GPU device. I suppose I need
to dive into its implementation to see if there are any similarities
to our use-case.

> That might not be optimal if trying to maximize
> performance, but it is portable.

IMO, the ABI should be flexible enough to support a TEE with optimum
performance.

-Sumit

>
> Cheers,
> Jens
>
> >
> > -Sumit
> >
> > > We would like to reserve device ID 46 for Virtio-TEE device.
> > >
> > > Signed-off-by: Jeshwanth Kumar <jeshwanthkumar.nk@amd.com>
> > > ---
> > >  content.tex | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/content.tex b/content.tex
> > > index 0a62dce..644aa4a 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -739,6 +739,8 @@ \chapter{Device Types}\label{sec:Device Types}
> > >  \hline
> > >  45         &   SPI master \\
> > >  \hline
> > > +46         &   TEE device \\
> > > +\hline
> > > \end{tabular}
> > >
> > >  Some of the devices above are unspecified by this document,

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

