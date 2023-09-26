Return-Path: <virtio-dev-return-13968-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 906F6E7E62F
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 12:32:38 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EA46029FCF
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 12:32:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9C1DC986420
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 12:32:37 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 80B07983DE3; Tue, 26 Sep 2023 12:32:37 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6F6149863A6
	for <virtio-dev@lists.oasis-open.org>; Tue, 26 Sep 2023 12:32:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695731556; x=1696336356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mkD6wrBG9QFokO0ZT5IfY2cfhyB6ZWcZNUzJaCP87oQ=;
        b=WOiU//dYIkQfX25oLqKuUakj/8cdLoD76qt2pTdZyknRhBFTj0/6cOYQyQT1vJ0Ld2
         R1adqt0ri7IreV0aDKM/jXWjA7oWkE2Ax3+PpqL45r+Pr29sY8tsnd+vvYsVjq3emI4P
         tWF5P5pGbn10dilMyswSUHEMv4XFQoKlOkemWRVve3HyRlM2lrDi+pIow1MVhxe5hfwG
         rc+SDoHAEJ1ir/BjHrZmq6Ysiu0hTsZqnWjxvkD0gCRKqv6EWfxHul6RLToak16eI5Tg
         3S1GoyJIt1eziPKrOIqfpjjMqLDQ2kScgjGYX3dbQdjXNnDjPUTlnAqkd39DoYMu70pR
         azpg==
X-Gm-Message-State: AOJu0Yzt7tBiVgOiqX1p0PrP7j58xj6hLhtP+wbdUEX+goJ2Kd5UW40n
	QAkX2UP1x58rcp8WpWE4uyQ/AQp56bdxQR4/VjoT2Q==
X-Google-Smtp-Source: AGHT+IGVKKoWHfUTDYuSUsnXv+MHM8/gRRYZ+xYL8LMdUCMaME/BD/KiTC8A/tz4NJsSpyoz1485K+ylVAnQTXFTPSA=
X-Received: by 2002:a05:6102:10c:b0:452:9988:5cb8 with SMTP id
 z12-20020a056102010c00b0045299885cb8mr5810096vsq.13.1695731555998; Tue, 26
 Sep 2023 05:32:35 -0700 (PDT)
MIME-Version: 1.0
References: <80a2e4337affb043909c348395fb45aeeb693dc7.1695640593.git.JESHWANTHKUMAR.NK@amd.com>
 <904049f9-3ddf-7e88-c6f3-785a29a08210@linaro.org> <CAHUa44GzHPkntr=sFYYzokW0=9CCN7n6Ch1i6J7L7Uhh5U5P3A@mail.gmail.com>
 <CAFA6WYOsPhFkyrG0P7B6Ec=AnDvoUaerLocM89KtmybLmKbsaw@mail.gmail.com>
 <b15e849c-f424-1afb-4b99-ae2df954a044@amd.com> <CAFA6WYNMJ_njp95+AUu-p6H2wat+GCxntNX+WddKpufM4AVVYw@mail.gmail.com>
 <70848d35-6288-24d4-e4dc-01ca7e4e180a@amd.com>
In-Reply-To: <70848d35-6288-24d4-e4dc-01ca7e4e180a@amd.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 26 Sep 2023 18:02:24 +0530
Message-ID: <CAFA6WYNPRzaa=5HDpqN191KN8bQv1nCF6gXo4RPSG0SZ55WOVA@mail.gmail.com>
To: Rijo Thomas <Rijo-john.Thomas@amd.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, jeshwanthkumar.nk@amd.com, 
	Devaraj.Rangasamy@amd.com, Mythri.Pandeshwarakrishna@amd.com, 
	Nimesh.Easow@amd.com, babulu.ellune@amd.com, virtio-dev@lists.oasis-open.org, 
	virtio-comment@lists.oasis-open.org, Arnd Bergmann <arnd.bergmann@linaro.org>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] [PATCH v2] virtio-tee: Reserve device ID 46 for TEE device

+cc OP-TEE ML

On Tue, 26 Sept 2023 at 13:47, Rijo Thomas <Rijo-john.Thomas@amd.com> wrote=
:
>
> On 9/26/2023 1:19 PM, Sumit Garg wrote:
> > On Tue, 26 Sept 2023 at 12:53, Rijo Thomas <Rijo-john.Thomas@amd.com> w=
rote:
> >>
> >> On 9/26/2023 12:14 PM, Sumit Garg wrote:
> >>> +cc Alex
> >>>
> >>> On Tue, 26 Sept 2023 at 08:16, Jens Wiklander <jens.wiklander@linaro.=
org> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> [+cc Arnd]
> >>>>
> >>>> On Tue, Sep 26, 2023 at 8:00=E2=80=AFAM Sumit Garg <sumit.garg@linar=
o.org> wrote:
> >>>>>
> >>>>> +cc Jens
> >>>>>
> >>>>>> In a virtual environment, an application running in guest VM may w=
ant
> >>>>>> to delegate security sensitive tasks to a Trusted Application (TA)
> >>>>>> running within a Trusted Execution Environment (TEE). A TEE is a t=
rusted
> >>>>>> OS running in some secure environment, for example, TrustZone on A=
RM
> >>>>>> CPUs, or a separate secure co-processor etc.
> >>>>>
> >>>>> I have been exploring this area quite recently with an effort to ha=
ve a common VIRIO interface which can support different trusted OS implemen=
tations. I guess you intend to test it with AMD-TEE, right? Any plans to te=
st it with OP-TEE? As currently we have these two supported upstream.
> >>>>>
> >> Yes, we have tested with AMD-TEE. We have not yet tested with OP-TEE. =
Sure, we will try it out.
> >
> > Glad to hear that. I can help get it tested with OP-TEE as well.
> >
>
> We will test it out internally. Shall let you know in case we need help.
>
> >>
> >>>>> Do you currently have any virtio frontend/backend implementations f=
or this?
> >>>>>
> >>
> >> Yes, we have. Frontend is a Linux virtio-TEE driver, and backend is vi=
rtio-TEE device emulated in QEMU.
> >> We used the Xen hypervisor.
> >
> > Can you share corresponding references? I can give it a try using Qemu =
with KVM.
> >
>
> We will share it in next couple of weeks. We have not yet hosted the code=
 for external consumption.
>
> >>
> >>>>>>
> >>>>>> A virtual TEE device emulates a TEE within a guest VM. Such a virt=
ual
> >>>>>> TEE device supports multiple operations such as:
> >>>>>>
> >>>>>> VIRTIO_TEE_CMD_OPEN_DEVICE =E2=80=93 Open a communication channel =
with virtio
> >>>>>>                              TEE device.
> >>>>>> VIRTIO_TEE_CMD_CLOSE_DEVICE =E2=80=93 Close communication channel =
with virtio
> >>>>>>                               TEE device.
> >>>>>> VIRTIO_TEE_CMD_GET_VERSION =E2=80=93 Get version of virtio TEE.
> >>>>>> VIRTIO_TEE_CMD_OPEN_SESSION =E2=80=93 Open a session to communicat=
e with
> >>>>>>                               trusted application running in TEE.
> >>>>>> VIRTIO_TEE_CMD_CLOSE_SESSION =E2=80=93 Close a session to end comm=
unication
> >>>>>>                                with trusted application running in=
 TEE.
> >>>>>> VIRTIO_TEE_CMD_INVOKE_FUNC =E2=80=93 Invoke a command or function =
in trusted
> >>>>>>                              application running in TEE.
> >>>>>> VIRTIO_TEE_CMD_CANCEL_REQ =E2=80=93 Cancel an ongoing command with=
in TEE.
> >>>>>>
> >>>>>
> >>>>> How about shared memory support? We would like to register guest pa=
ges with the trusted OS.
> >> We have a command VIRTIO_TEE_CMD_REGISTER_MEM for registering shared m=
emory buffer with Trusted OS.
> >
> > I suppose the commit message has to be appended then. Do you have the
> > draft virtio-tee device specification ready for review? I would be
> > interested to review that.
> >
>
> Yes, the command is missed out in the commit message.

With the commit message updated to include support for shared memory,
feel free to add:

Acked-by: Sumit Garg <sumit.garg@linaro.org>

>
> We are in the process of preparing virtio-tee device specification. We wi=
ll be sending it out to this
> list.

I would also suggest you to CC: op-tee@lists.trustedfirmware.org for review=
.

>
> >>
> >> In this command, the guest pages are copied into a shadow buffer in th=
e host OS. And this shadow
> >> buffer is mapped with Trusted OS. So, buffer-copy is involved.
> >>
> >> One limitation, that we had was that the guest pages were non-contiguo=
us. So, the number of physical
> >> pages that had to be mapped with Trusted OS was exceeding 64 entries w=
hen we were testing out the
> >> registering of guest pages. AMD-TEE Trusted OS can map a physically no=
n-contiguous buffer, but the
> >> number of sg entries for such a buffer must be less than 64. So, we re=
sorted to using a shadow buffer
> >> that is allocated within host, and gets mapped with Trusted OS.
> >
> > I don't think OP-TEE OS has such a limitation on non-contiguous pages.
> > So I would suggest you to keep VIRTIO_TEE_CMD_REGISTER_MEM as part of
> > the ABI. It can be an optional feature for a particular trusted OS
> > implementation to support.
> >
>
> Currently, the reg_mem (register memory) control is dictated by a flag in=
 virtio-tee qemu code. This flag
> for our testing was hard-coded as false. We will enhance our code, so tha=
t it is configurable. The value
> of reg_mem shall be set to true/false depending upon whether the underlyi=
ng TEE driver reports TEE_GEN_CAP_REG_MEM.

Sounds good to me.

-Sumit

>
> Thanks,
> Rijo
>
> > -Sumit
> >
> >>
> >> Thanks,
> >> Rijo
> >>
> >>>>
> >>>> Coincidently Arnd and I (among others) discussed this in person last
> >>>> week and the conclusion was that only temporary shared memory is
> >>>> possible with virtio. So the shared memory has to be set up and torn
> >>>> down by the host during each operation, typically open-session or
> >>>> invoke-func.
> >>>
> >>> Agree as I was part of those discussions. But I would like to
> >>> understand the reasoning behind it. Is there any restriction by VIRTI=
O
> >>> specification that we can't register guest page PAs to a device (TEE
> >>> in our case) to allow for zero copy transfers?
> >>>
> >>> Alex mentioned some references to virtio GPU device. I suppose I need
> >>> to dive into its implementation to see if there are any similarities
> >>> to our use-case.
> >>>
> >>>> That might not be optimal if trying to maximize
> >>>> performance, but it is portable.
> >>>
> >>> IMO, the ABI should be flexible enough to support a TEE with optimum
> >>> performance.
> >>>
> >>> -Sumit
> >>>
> >>>>
> >>>> Cheers,
> >>>> Jens
> >>>>
> >>>>>
> >>>>> -Sumit
> >>>>>
> >>>>>> We would like to reserve device ID 46 for Virtio-TEE device.
> >>>>>>
> >>>>>> Signed-off-by: Jeshwanth Kumar <jeshwanthkumar.nk@amd.com>
> >>>>>> ---
> >>>>>>  content.tex | 2 ++
> >>>>>>  1 file changed, 2 insertions(+)
> >>>>>>
> >>>>>> diff --git a/content.tex b/content.tex
> >>>>>> index 0a62dce..644aa4a 100644
> >>>>>> --- a/content.tex
> >>>>>> +++ b/content.tex
> >>>>>> @@ -739,6 +739,8 @@ \chapter{Device Types}\label{sec:Device Types}
> >>>>>>  \hline
> >>>>>>  45         &   SPI master \\
> >>>>>>  \hline
> >>>>>> +46         &   TEE device \\
> >>>>>> +\hline
> >>>>>> \end{tabular}
> >>>>>>
> >>>>>>  Some of the devices above are unspecified by this document,

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

