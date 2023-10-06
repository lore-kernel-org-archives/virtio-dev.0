Return-Path: <virtio-dev-return-13986-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7947E92FF8
	for <virtio-dev@archiver.kernel.org>; Fri,  6 Oct 2023 08:00:49 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id EA24D190900
	for <virtio-dev@archiver.kernel.org>; Fri,  6 Oct 2023 08:00:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DD59798681A
	for <virtio-dev@archiver.kernel.org>; Fri,  6 Oct 2023 08:00:48 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id CC6D698680D; Fri,  6 Oct 2023 08:00:48 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B665C98680E
	for <virtio-dev@lists.oasis-open.org>; Fri,  6 Oct 2023 08:00:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696579246; x=1697184046;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0oVIBg0bBR7OezktmdZUVe+VpoAMqQTM3s9pABHnIOE=;
        b=qShqepAntHKlfX9bhfZqPQavZ3+pVPTZCuWGKm76OGiVE0WfeIjE5K9vEF7Z0Lmcwy
         dWbrVsR30DDoKn7Vbk6fN1kQRQ2z4MWuiqfUZ6iQdW8k3yJn69JB2hTKV8YP1wg+tRTp
         Q3WKi7Q5e/8tiHUW00T6gWtZ3GmBgHEZ/ng6ykkXJ5pBhSzoJKzFRvCQ+QMfMZV1QBao
         ty+332qSrFhe3MHAoFDStiSo2VRNzhcJLOTWfYEGVs4E/GeXQKJBUNJR9euWikX2DCvu
         pqaB2xcVozh6fteNbyhJLy4mg6Dokx+eql1Mbajc/cVvRqIpjGRqIpCUhon99Gd4mVPe
         8VrA==
X-Gm-Message-State: AOJu0YzZ9rwYYavkRCH+fondAWEBM3MlorrqNBLjcWOPsdA0aSEyk/jw
	N5JS12hb7bsLkSUkkTtzkU9oopmdh2YUlordD25caQ==
X-Google-Smtp-Source: AGHT+IHka+zR3jH+qJhGOQmqR1nSX9AbBMdj8Dil3zHSO3ddXzsQPwKcSNnLxHo22WS2cdnO877Jgei3wnQu21BTrP4=
X-Received: by 2002:a05:6102:274e:b0:452:85eb:e36d with SMTP id
 p14-20020a056102274e00b0045285ebe36dmr7508663vsu.20.1696579245669; Fri, 06
 Oct 2023 01:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <80a2e4337affb043909c348395fb45aeeb693dc7.1695640593.git.JESHWANTHKUMAR.NK@amd.com>
 <904049f9-3ddf-7e88-c6f3-785a29a08210@linaro.org> <CAHUa44GzHPkntr=sFYYzokW0=9CCN7n6Ch1i6J7L7Uhh5U5P3A@mail.gmail.com>
 <CAFA6WYOsPhFkyrG0P7B6Ec=AnDvoUaerLocM89KtmybLmKbsaw@mail.gmail.com>
 <CAKWjNY-tixKn=N2_5vcjZHEuh0bBE9BpFXwRV7Y5MDDLsPYzfw@mail.gmail.com>
 <CAFA6WYMraufRMwK=u+5pn4r2a4g-RzcLFiJiNa+t=CjjAE+_xA@mail.gmail.com>
 <CAKWjNY-Gf-Kf1Ldsni6oXp2+POghFWWg36WYtvZcnUXqhurcLw@mail.gmail.com>
 <CAFA6WYP65bR7a8teOo0tDVVgaVQx-1xg=pyJqTtoAKzmOs4TPQ@mail.gmail.com> <8124dd4b-d69d-46ca-8b39-7d0aacb078f7@app.fastmail.com>
In-Reply-To: <8124dd4b-d69d-46ca-8b39-7d0aacb078f7@app.fastmail.com>
From: Sumit Garg <sumit.garg@linaro.org>
Date: Fri, 6 Oct 2023 13:30:34 +0530
Message-ID: <CAFA6WYNyA_ZD1Ca=cHokOjRpuTX59kjFiG46UJ8HtGOBWk2=_w@mail.gmail.com>
To: Arnd Bergmann <arnd@arndb.de>, mst@redhat.com
Cc: Arnd Bergmann <arnd@linaro.org>, jeshwanthkumar.nk@amd.com, Devaraj.Rangasamy@amd.com, 
	Mythri.Pandeshwarakrishna@amd.com, Nimesh.Easow@amd.com, 
	Rijo-john.Thomas@amd.com, babulu.ellune@amd.com, 
	virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, 
	Arnd Bergmann <arnd.bergmann@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
	Jens Wiklander <jens.wiklander@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [virtio-dev] [PATCH v2] virtio-tee: Reserve device ID 46 for TEE device

On Tue, 3 Oct 2023 at 19:06, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Sep 28, 2023, at 16:48, Sumit Garg wrote:
> > On Wed, 27 Sept 2023 at 21:39, Arnd Bergmann <arnd@linaro.org> wrote:
> >> On Wed, 27 Sept 2023 at 16:09, Sumit Garg <sumit.garg@linaro.org> wrote:
> >>
> >> I don't know if there is a limit on the size of the virtio shared
> >> memory area other than the PCI MMIO space size, could
> >> this just be made (much) larger?
> >
> > Actually it's a double edged sword. You wouldn't like to block too
> > much host memory which remains unused and on the other hand not too
> > less that can't serve guest application needs. That's the reason we
> > should provide an option to dynamically share guest memory with a TEE.
>
> To clarify: the address space in the virtio-shmem segment
> does not have to be permanently backed by host memory, it
> just provides a part of the guest-physical mmio space and
> could be populated as needed. So you might have a 1TB
> shmem region in the device itself but only use a single 4KB
> page in it.

Thanks for the clarification. It makes sense to use this approach for
TEE shared memory allocation purposes. The guest client application
should be able to mmap() the buffer allocated from virtio-shmem space.

>
> The restriction here is that the address of the shmem segment
> itself is fixed on the PCI bus (or whichever virtio transport
> is used), rather than decided by the guest from its memory.
>

I can understand this restriction.

> >> > The TEE communication protocol has to support INOUT shared memory
> >> > buffers. So it will be quite tricky to support it via TX only and RX
> >> > only buffers (many more buffer copies).
> >>
> >> I don't remember if you can just list the same address in
> >> virtio for both directions, but that could solve this problem.
> >
> > Okay in that case I think following approach can work:
> >
> > - Issue VIRTIO_TEE_CMD_REGISTER_MEM to register an additional buffer
> > passed through virtqueue.
> > - Instruct TEE to perform operations on it via VIRTIO_TEE_CMD_INVOKE_FUNC.
> > - Issue VIRTIO_TEE_CMD_UNREGISTER_MEM to unregister that additional
> > buffer passed through virtqueue.
> >
> > I suppose we can pass either guest user-space or kernel reference in
> > that virtqueue. Does this approach make sense to you?
>
> No, I'm not sure what you are suggesting here, i.e. which address
> space VIRTIO_TEE_CMD_REGISTER_MEM would operate on. This would
> normally be guest physical memory, which might correspond to pinned
> userspace pages, but I don't think that makes sense in the context
> of virtio, as we discussed before.

I suppose this is a similar situation with DMA buffers too, correct?
Is it not allowed to share DMA buffers backed by guest physical memory
with virtio devices?

As otherwise, in case of VIRTIO-TEE we will be reluctant to maintain
shadow/bounce buffers in virtio-shmem space which will be inefficient.

> If you would use the virtio
> shmem backing, VIRTIO_TEE_CMD_REGISTER_MEM could refer to an offset
> within the device shmem address space, which would then become
> backed by host memory.

Yeah that sounds like a sensible approach for buffers allocated from
virtio-shmem space.

>
> IIRC the way we had discussed this before was that the virtio-tee
> driver would not register memory at all, but instead pass all
> requests through virtqueues. When the device (host) passes the
> request up to the actual TEE, it could transparently register
> the buffer before the transaction and unregister it afterwards,
> or copy the data to a pre-registered area.

This refers to temporary shared memory in TEE terms. It is the least
efficient approach. It may turn a single VIRTIO_TEE_CMD_INVOKE_FUNC
into at max 9 transactions underneath among host and TEE: 8
register/unregister shared memory invocations and 1 actual invoke
command. This can be turned into a single transaction among host and
TEE if we can make the above discussed approaches to work.

-Sumit

>
>     Arnd

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

