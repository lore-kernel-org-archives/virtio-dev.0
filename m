Return-Path: virtio-dev-return-6249-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9F4E3986005
	for <virtio-dev@lists.oasis-open.org>; Thu, 17 Oct 2019 08:11:53 +0000 (UTC)
MIME-Version: 1.0
References: <20190919093404.182015-1-keiichiw@chromium.org>
 <4037801.MZecyecTDs@os-lin-dmo> <CAAFQd5CfNK1oisDaOWaW+9NTQOLn1EHPrPzvxMPcSxLkBgv3Ww@mail.gmail.com>
 <15135216.K0K410U5qv@os-lin-dmo> <CAAFQd5DuChujakwmhtQ8v2CSLFqVYjLz9eGHuqrQnJ7apft+3Q@mail.gmail.com>
 <20191017071952.s3dq2oxdiy3khp5w@sirius.home.kraxel.org>
In-Reply-To: <20191017071952.s3dq2oxdiy3khp5w@sirius.home.kraxel.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 17 Oct 2019 17:11:38 +0900
Message-ID: <CAAFQd5ByuyTDqwiBeT7U7cVA8omOPGRRxb2tB8=J-u7WYU-urQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [virtio-dev] [PATCH] [RFC RESEND] vdec: Add virtio video decode
 device specification
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Dmitry Morozov <dmitry.morozov@opensynergy.com>, David Stevens <stevensd@chromium.org>, virtio-dev@lists.oasis-open.org, Keiichi Watanabe <keiichiw@chromium.org>, Alexandre Courbot <acourbot@chromium.org>, alexlau@chromium.org, dgreid@chromium.org, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Linux Media Mailing List <linux-media@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Oct 17, 2019 at 4:19 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > That said, Chrome OS would use a similar model, except that we don't
> > use ION. We would likely use minigbm backed by virtio-gpu to allocate
> > appropriate secure buffers for us and then import them to the V4L2
> > driver.
>
> What exactly is a "secure buffer"?  I guess a gem object where read
> access is not allowed, only scanout to display?  Who enforces this?
> The hardware?  Or the kernel driver?

In general, it's a buffer which can be accessed only by a specific set
of entities. The set depends on the use case and the level of security
you want to achieve. In Chrome OS we at least want to make such
buffers completely inaccessible for the guest, enforced by the VMM,
for example by not installing corresponding memory into the guest
address space (and not allowing transfers if the virtio-gpu shadow
buffer model is used).

Beyond that, the host memory itself could be further protected by some
hardware mechanisms or another hypervisor running above the host OS,
like in the ARM TrustZone model. That shouldn't matter for a VM guest,
though.

>
> It might make sense for virtio-gpu to know that concept, to allow guests
> ask for secure buffers.
>
> And of course we'll need some way to pass around identifiers for these
> (and maybe other) buffers (from virtio-gpu device via guest drivers to
> virtio-vdec device).  virtio-gpu guest driver could generate a uuid for
> that, attach it to the dma-buf and also notify the host so qemu can
> maintain a uuid -> buffer lookup table.

That could be still a guest physical address. Like on a bare metal
system with TrustZone, there could be physical memory that is not
accessible to the CPU.

Best regards,
Tomasz

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

