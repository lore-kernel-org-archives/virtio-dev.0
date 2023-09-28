Return-Path: <virtio-dev-return-13983-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D59E732DB
	for <virtio-dev@archiver.kernel.org>; Thu, 28 Sep 2023 14:48:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 4818542A76
	for <virtio-dev@archiver.kernel.org>; Thu, 28 Sep 2023 14:48:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1F6899866AC
	for <virtio-dev@archiver.kernel.org>; Thu, 28 Sep 2023 14:48:48 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 044C7986407; Thu, 28 Sep 2023 14:48:48 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E2B449864C6
	for <virtio-dev@lists.oasis-open.org>; Thu, 28 Sep 2023 14:48:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695912526; x=1696517326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oeY8vLv8vQeSg7xTwhkatz5AxJR//U8OnQHHYEiz0xs=;
        b=Lxki6KkNjdRReqKrBm7ocy62Si9NB9v1PJRDju0ujtFaNl0aKtlGv/+/1EHC5RkWXl
         S7qD6oAtwRZBoCnyf10IcpU6YqraeJC0mK0UtzSFZiLR7/+RJnHvh9T9q22jheE47SrI
         qm9CccqyPUpZxSTTerMKP7JT0hYvWRC+ygMaM6xhKGl3Gfz9iEj2JrIAiZqpaKxrQvE7
         sgTAxBlaLtlryq6k6BFpguIh9VYYRIoTSbyHsqxfv25q0B+Zvrwa36iIX24krnpzi3Hn
         KWxt6jSpi1cEGqhj/LBUhNczTcOHAF9RTIMZ52G+ur6Hp5EegENOuyawpJlkN/6FI5gR
         7ehA==
X-Gm-Message-State: AOJu0YxCHnV24kQDGDhStY77WnZlmRZtKlMGjR3I/BSEs6Ms2bKf+mm1
	/5vBirmSOtnqrUPOV4A7x7/okdjG+70/62d2VDvvxQ==
X-Google-Smtp-Source: AGHT+IElZKSb0hDhUn6VnU8gtJT6Sut/zfOR5W5NZt+B2Ffdy5o0HDjVKgjTkYfA189JB9oCSw1ntA8hsEXoOY3FOPw=
X-Received: by 2002:a05:6102:3a55:b0:452:88c9:21cf with SMTP id
 c21-20020a0561023a5500b0045288c921cfmr1189052vsu.33.1695912526543; Thu, 28
 Sep 2023 07:48:46 -0700 (PDT)
MIME-Version: 1.0
References: <80a2e4337affb043909c348395fb45aeeb693dc7.1695640593.git.JESHWANTHKUMAR.NK@amd.com>
 <904049f9-3ddf-7e88-c6f3-785a29a08210@linaro.org> <CAHUa44GzHPkntr=sFYYzokW0=9CCN7n6Ch1i6J7L7Uhh5U5P3A@mail.gmail.com>
 <CAFA6WYOsPhFkyrG0P7B6Ec=AnDvoUaerLocM89KtmybLmKbsaw@mail.gmail.com>
 <CAKWjNY-tixKn=N2_5vcjZHEuh0bBE9BpFXwRV7Y5MDDLsPYzfw@mail.gmail.com>
 <CAFA6WYMraufRMwK=u+5pn4r2a4g-RzcLFiJiNa+t=CjjAE+_xA@mail.gmail.com> <CAKWjNY-Gf-Kf1Ldsni6oXp2+POghFWWg36WYtvZcnUXqhurcLw@mail.gmail.com>
In-Reply-To: <CAKWjNY-Gf-Kf1Ldsni6oXp2+POghFWWg36WYtvZcnUXqhurcLw@mail.gmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 28 Sep 2023 20:18:35 +0530
Message-ID: <CAFA6WYP65bR7a8teOo0tDVVgaVQx-1xg=pyJqTtoAKzmOs4TPQ@mail.gmail.com>
To: Arnd Bergmann <arnd@linaro.org>
Cc: jeshwanthkumar.nk@amd.com, Devaraj.Rangasamy@amd.com, 
	Mythri.Pandeshwarakrishna@amd.com, Nimesh.Easow@amd.com, 
	Rijo-john.Thomas@amd.com, babulu.ellune@amd.com, 
	virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, 
	Arnd Bergmann <arnd.bergmann@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Jens Wiklander <jens.wiklander@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [virtio-dev] [PATCH v2] virtio-tee: Reserve device ID 46 for TEE device

On Wed, 27 Sept 2023 at 21:39, Arnd Bergmann <arnd@linaro.org> wrote:
>
> On Wed, 27 Sept 2023 at 16:09, Sumit Garg <sumit.garg@linaro.org> wrote:
> >
>
> It looks like I accidentally dropped the entire Cc list in my earlier rep=
ly,
> adding them all back.

No worries.

>
> > On Wed, 27 Sept 2023 at 01:44, Arnd Bergmann <arnd@linaro.org> wrote:
> > >
> > > On Tue, 26 Sept 2023 at 08:44, Sumit Garg <sumit.garg@linaro.org> wro=
te:
> > > > On Tue, 26 Sept 2023 at 08:16, Jens Wiklander <jens.wiklander@linar=
o.org> wrote:
> > > > > On Tue, Sep 26, 2023 at 8:00=E2=80=AFAM Sumit Garg <sumit.garg@li=
naro.org> wrote:
> > > > > >
> > > > > > How about shared memory support? We would like to register gues=
t pages with the trusted OS.
> > > > >
> > > > > Coincidently Arnd and I (among others) discussed this in person l=
ast
> > > > > week and the conclusion was that only temporary shared memory is
> > > > > possible with virtio. So the shared memory has to be set up and t=
orn
> > > > > down by the host during each operation, typically open-session or
> > > > > invoke-func.
> > > >
> > > > Agree as I was part of those discussions. But I would like to
> > > > understand the reasoning behind it. Is there any restriction by VIR=
TIO
> > > > specification that we can't register guest page PAs to a device (TE=
E
> > > > in our case) to allow for zero copy transfers?
> > > >
> > > > Alex mentioned some references to virtio GPU device. I suppose I ne=
ed
> > > > to dive into its implementation to see if there are any similaritie=
s
> > > > to our use-case.
> > > >
> > > > > That might not be optimal if trying to maximize
> > > > > performance, but it is portable.
> > > >
> > > > IMO, the ABI should be flexible enough to support a TEE with optimu=
m
> > > > performance.
> > >
> > > As we discussed last week, I can see two possible ways to implement
> > > a TEE device within the constraints of the virtio specification:
> > >
> > > a) Allocate a shared memory area in the device (host) and export it
> > >    to the driver (guest) via a virtio shared memory area. This shared
> > >    memory can be shared with userspace using mmap() if necessary.
> > >    A tee command in this case would be sent using a normal virtqueue
> > >    to the device with a pair of one transmit and one receive buffer.
> > >    Any arguments that refer to memory blocks in this case are
> > >    offsets into the shared memory area. Using this preallocated buffe=
r
> > >    is similar to earlier TEE implementations but has some restriction=
s.
> > >    The command in this case has to be copied in and out by the
> > >    hypervisor implementation.
> >
> > Yeah that was the initial approach that we used for OP-TEE but it was
> > limited by the fixed size of the shared memory area. A guest client
> > application may want to share a larger data buffer with TA which can't
> > be supported via this approach.
>
> I don't know if there is a limit on the size of the virtio shared
> memory area other than the PCI MMIO space size, could
> this just be made (much) larger?

Actually it's a double edged sword. You wouldn't like to block too
much host memory which remains unused and on the other hand not too
less that can't serve guest application needs. That's the reason we
should provide an option to dynamically share guest memory with a TEE.

>
> > > b) Send all data through the virtqueue itself, pointing into normal
> > >    guest memory. The first buffer sent to the device is the request,
> > >    while the receive buffer is the result. Instead of pointers to
> > >    shared memory, this means that all data transfers would be
> > >    done in additional buffers on the same virtio transaction, and
> > >    the host would have to register the guest memory dynamically
> > >    as part of the command before forwarding them to a TEE that
> > >    relies on registering shared memory, and unmap it afterwards
> > >    since the guest might reuse the buffers for other data later
> > >    that it does not want to share with the TEE
> > >
> >
> > The TEE communication protocol has to support INOUT shared memory
> > buffers. So it will be quite tricky to support it via TX only and RX
> > only buffers (many more buffer copies).
>
> I don't remember if you can just list the same address in
> virtio for both directions, but that could solve this problem.
>

Okay in that case I think following approach can work:

- Issue VIRTIO_TEE_CMD_REGISTER_MEM to register an additional buffer
passed through virtqueue.
- Instruct TEE to perform operations on it via VIRTIO_TEE_CMD_INVOKE_FUNC.
- Issue VIRTIO_TEE_CMD_UNREGISTER_MEM to unregister that additional
buffer passed through virtqueue.

I suppose we can pass either guest user-space or kernel reference in
that virtqueue. Does this approach make sense to you?

-Sumit

> > > Registering guest memory to the TEE permanently would be
> > > a layering violation since that makes invalid assumptions about
> > > the type of virtio transport that do not make sense to a virtio
> > > driver.
> >
> > AFAICS, the VIRTIO is just a transport to relay information among
> > guest kernel drivers and host emulated devices. The registration of
> > guest memory to TEE won't be permanent but rather has a limited
> > lifetime which is alive until the guest client application closes the
> > context with TEE. So once the TEE context is closed by the guest
> > client application then all the corresponding registered memory will
> > be freed.
>
> Right, so while in theory you can implement random non-virtio
> semantics by passing other commands through a virtqueue, I would
> no longer consider it a virtio driver at that point, since it makes
> assumptions about the host system implementation beyond what
> is abstracted in virtio.
>
> > > As far as the driver is concerned, the virtqueue is a
> > > socket type interface that does transactions on input and
> > > output data in place but has no concept of guest memory.
> >
> > That's true. As part of virtio-tee, we will pass page pointers in that
> > virtio input/output data in place. I suppose it's better to discuss
> > the implementation details once AMD folks put the virtio-tee
> > specification out for review. Also, they have implementations for
> > virtio-tee frontend and backend too which they will make up for public
> > review.
> >
> > There certainly can be some essential details of virtio spec that I am
> > missing here since I only started exploring it a month back. If you
> > have some certain pointers to the spec then I will be happy to read
> > them carefully.
>
> I have not found an explicit wording that forbids you from
> referencing physical memory addresses indirectly in buffers
> that are passed through virtqueues, but the basic definition of
> a virtqueue in section 2.6 [1] describes the way that buffers
> are passed, and if a TEE driver wants to pass commands
> and their arguments in something that is not a virtqueue or
> a virtio-shmem area, I think you are clearly outside of the intended
> model.
>
>      Arnd
>
> https://docs.oasis-open.org/virtio/virtio/v1.2/csd01/virtio-v1.2-csd01.ht=
ml#x1-270006

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

