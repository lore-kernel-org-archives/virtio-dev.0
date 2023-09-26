Return-Path: <virtio-dev-return-13960-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 521EBE7D24C
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 07:50:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 8F9FE7B3C8
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 07:50:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7BB6F986422
	for <virtio-dev@archiver.kernel.org>; Tue, 26 Sep 2023 07:50:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 69F26983DE3; Tue, 26 Sep 2023 07:50:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 4428098639D
	for <virtio-dev@lists.oasis-open.org>; Tue, 26 Sep 2023 07:50:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695714601; x=1696319401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JoRoWYzKsZx/U+zfEFm6GJnWoCsn89rNZJFrs/wC98U=;
        b=cQbSykaSbN05qiW5w/d9MoAuhcJPl9Gw/9azkuGsjLSnh4ppO7keucckVo08GaqOFr
         WSRhcxulhuKHbA+Vr4ROlFsudZWbARha9sW6EmBNMpc5xfmty8ZEZoiIFJs2hTdWXHLj
         V65nS12zXp7saDN5P9NW/pLzc5+m0NXNPa12KYeMu/MyuIG7/Vz/Pu09WoTFiSQDsjzO
         VDooCKPA9UB9+swf9oKwDRE1FaSJZhWP9IZU+igimWPGvCJVtURtW+7d+2GECS//P637
         /UzSB5daHXCqccVRDYauKx1G/dHTmg3GKu/zis24xx4GLcZr3Qngtp+hZ8xcxYzDa1Qq
         fLig==
X-Gm-Message-State: AOJu0YwFg+oPvan1//CvZXhpEwUYmO+sy3LuZY+kNhRgSK++XCyn5DJ1
	wO+T97KwLoraRN4nF6CGILPdg43mjQURHJvkfW82xw==
X-Google-Smtp-Source: AGHT+IHOt70sjkmvVt4wH4Lv+gAIZahx4WhGptnBHGTmREQdGGrY/OV3/ok1M6Jc2f6TA+jL0Q8NQi42ufTjnU4INlU=
X-Received: by 2002:a67:eb16:0:b0:452:6ac7:cdf with SMTP id
 a22-20020a67eb16000000b004526ac70cdfmr4574499vso.24.1695714601340; Tue, 26
 Sep 2023 00:50:01 -0700 (PDT)
MIME-Version: 1.0
References: <80a2e4337affb043909c348395fb45aeeb693dc7.1695640593.git.JESHWANTHKUMAR.NK@amd.com>
 <904049f9-3ddf-7e88-c6f3-785a29a08210@linaro.org> <CAHUa44GzHPkntr=sFYYzokW0=9CCN7n6Ch1i6J7L7Uhh5U5P3A@mail.gmail.com>
 <CAFA6WYOsPhFkyrG0P7B6Ec=AnDvoUaerLocM89KtmybLmKbsaw@mail.gmail.com> <b15e849c-f424-1afb-4b99-ae2df954a044@amd.com>
In-Reply-To: <b15e849c-f424-1afb-4b99-ae2df954a044@amd.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Tue, 26 Sep 2023 13:19:50 +0530
Message-ID: <CAFA6WYNMJ_njp95+AUu-p6H2wat+GCxntNX+WddKpufM4AVVYw@mail.gmail.com>
To: Rijo Thomas <Rijo-john.Thomas@amd.com>
Cc: Jens Wiklander <jens.wiklander@linaro.org>, jeshwanthkumar.nk@amd.com, 
	Devaraj.Rangasamy@amd.com, Mythri.Pandeshwarakrishna@amd.com, 
	Nimesh.Easow@amd.com, babulu.ellune@amd.com, virtio-dev@lists.oasis-open.org, 
	virtio-comment@lists.oasis-open.org, Arnd Bergmann <arnd.bergmann@linaro.org>, 
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] [PATCH v2] virtio-tee: Reserve device ID 46 for TEE device

On Tue, 26 Sept 2023 at 12:53, Rijo Thomas <Rijo-john.Thomas@amd.com> wrote=
:
>
> On 9/26/2023 12:14 PM, Sumit Garg wrote:
> > +cc Alex
> >
> > On Tue, 26 Sept 2023 at 08:16, Jens Wiklander <jens.wiklander@linaro.or=
g> wrote:
> >>
> >> Hi,
> >>
> >> [+cc Arnd]
> >>
> >> On Tue, Sep 26, 2023 at 8:00=E2=80=AFAM Sumit Garg <sumit.garg@linaro.=
org> wrote:
> >>>
> >>> +cc Jens
> >>>
> >>>> In a virtual environment, an application running in guest VM may wan=
t
> >>>> to delegate security sensitive tasks to a Trusted Application (TA)
> >>>> running within a Trusted Execution Environment (TEE). A TEE is a tru=
sted
> >>>> OS running in some secure environment, for example, TrustZone on ARM
> >>>> CPUs, or a separate secure co-processor etc.
> >>>
> >>> I have been exploring this area quite recently with an effort to have=
 a common VIRIO interface which can support different trusted OS implementa=
tions. I guess you intend to test it with AMD-TEE, right? Any plans to test=
 it with OP-TEE? As currently we have these two supported upstream.
> >>>
> Yes, we have tested with AMD-TEE. We have not yet tested with OP-TEE. Sur=
e, we will try it out.

Glad to hear that. I can help get it tested with OP-TEE as well.

>
> >>> Do you currently have any virtio frontend/backend implementations for=
 this?
> >>>
>
> Yes, we have. Frontend is a Linux virtio-TEE driver, and backend is virti=
o-TEE device emulated in QEMU.
> We used the Xen hypervisor.

Can you share corresponding references? I can give it a try using Qemu with=
 KVM.

>
> >>>>
> >>>> A virtual TEE device emulates a TEE within a guest VM. Such a virtua=
l
> >>>> TEE device supports multiple operations such as:
> >>>>
> >>>> VIRTIO_TEE_CMD_OPEN_DEVICE =E2=80=93 Open a communication channel wi=
th virtio
> >>>>                              TEE device.
> >>>> VIRTIO_TEE_CMD_CLOSE_DEVICE =E2=80=93 Close communication channel wi=
th virtio
> >>>>                               TEE device.
> >>>> VIRTIO_TEE_CMD_GET_VERSION =E2=80=93 Get version of virtio TEE.
> >>>> VIRTIO_TEE_CMD_OPEN_SESSION =E2=80=93 Open a session to communicate =
with
> >>>>                               trusted application running in TEE.
> >>>> VIRTIO_TEE_CMD_CLOSE_SESSION =E2=80=93 Close a session to end commun=
ication
> >>>>                                with trusted application running in T=
EE.
> >>>> VIRTIO_TEE_CMD_INVOKE_FUNC =E2=80=93 Invoke a command or function in=
 trusted
> >>>>                              application running in TEE.
> >>>> VIRTIO_TEE_CMD_CANCEL_REQ =E2=80=93 Cancel an ongoing command within=
 TEE.
> >>>>
> >>>
> >>> How about shared memory support? We would like to register guest page=
s with the trusted OS.
> We have a command VIRTIO_TEE_CMD_REGISTER_MEM for registering shared memo=
ry buffer with Trusted OS.

I suppose the commit message has to be appended then. Do you have the
draft virtio-tee device specification ready for review? I would be
interested to review that.

>
> In this command, the guest pages are copied into a shadow buffer in the h=
ost OS. And this shadow
> buffer is mapped with Trusted OS. So, buffer-copy is involved.
>
> One limitation, that we had was that the guest pages were non-contiguous.=
 So, the number of physical
> pages that had to be mapped with Trusted OS was exceeding 64 entries when=
 we were testing out the
> registering of guest pages. AMD-TEE Trusted OS can map a physically non-c=
ontiguous buffer, but the
> number of sg entries for such a buffer must be less than 64. So, we resor=
ted to using a shadow buffer
> that is allocated within host, and gets mapped with Trusted OS.

I don't think OP-TEE OS has such a limitation on non-contiguous pages.
So I would suggest you to keep VIRTIO_TEE_CMD_REGISTER_MEM as part of
the ABI. It can be an optional feature for a particular trusted OS
implementation to support.

-Sumit

>
> Thanks,
> Rijo
>
> >>
> >> Coincidently Arnd and I (among others) discussed this in person last
> >> week and the conclusion was that only temporary shared memory is
> >> possible with virtio. So the shared memory has to be set up and torn
> >> down by the host during each operation, typically open-session or
> >> invoke-func.
> >
> > Agree as I was part of those discussions. But I would like to
> > understand the reasoning behind it. Is there any restriction by VIRTIO
> > specification that we can't register guest page PAs to a device (TEE
> > in our case) to allow for zero copy transfers?
> >
> > Alex mentioned some references to virtio GPU device. I suppose I need
> > to dive into its implementation to see if there are any similarities
> > to our use-case.
> >
> >> That might not be optimal if trying to maximize
> >> performance, but it is portable.
> >
> > IMO, the ABI should be flexible enough to support a TEE with optimum
> > performance.
> >
> > -Sumit
> >
> >>
> >> Cheers,
> >> Jens
> >>
> >>>
> >>> -Sumit
> >>>
> >>>> We would like to reserve device ID 46 for Virtio-TEE device.
> >>>>
> >>>> Signed-off-by: Jeshwanth Kumar <jeshwanthkumar.nk@amd.com>
> >>>> ---
> >>>>  content.tex | 2 ++
> >>>>  1 file changed, 2 insertions(+)
> >>>>
> >>>> diff --git a/content.tex b/content.tex
> >>>> index 0a62dce..644aa4a 100644
> >>>> --- a/content.tex
> >>>> +++ b/content.tex
> >>>> @@ -739,6 +739,8 @@ \chapter{Device Types}\label{sec:Device Types}
> >>>>  \hline
> >>>>  45         &   SPI master \\
> >>>>  \hline
> >>>> +46         &   TEE device \\
> >>>> +\hline
> >>>> \end{tabular}
> >>>>
> >>>>  Some of the devices above are unspecified by this document,

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

