Return-Path: virtio-dev-return-6246-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 38123986005
	for <virtio-dev@lists.oasis-open.org>; Thu, 17 Oct 2019 07:19:55 +0000 (UTC)
Date: Thu, 17 Oct 2019 09:19:52 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191017071952.s3dq2oxdiy3khp5w@sirius.home.kraxel.org>
References: <20190919093404.182015-1-keiichiw@chromium.org>
 <4037801.MZecyecTDs@os-lin-dmo>
 <CAAFQd5CfNK1oisDaOWaW+9NTQOLn1EHPrPzvxMPcSxLkBgv3Ww@mail.gmail.com>
 <15135216.K0K410U5qv@os-lin-dmo>
 <CAAFQd5DuChujakwmhtQ8v2CSLFqVYjLz9eGHuqrQnJ7apft+3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAFQd5DuChujakwmhtQ8v2CSLFqVYjLz9eGHuqrQnJ7apft+3Q@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] [RFC RESEND] vdec: Add virtio video decode
 device specification
To: Tomasz Figa <tfiga@chromium.org>
Cc: Dmitry Morozov <dmitry.morozov@opensynergy.com>, stevensd@chromium.org, virtio-dev@lists.oasis-open.org, Keiichi Watanabe <keiichiw@chromium.org>, Alexandre Courbot <acourbot@chromium.org>, alexlau@chromium.org, dgreid@chromium.org, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Linux Media Mailing List <linux-media@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> That said, Chrome OS would use a similar model, except that we don't
> use ION. We would likely use minigbm backed by virtio-gpu to allocate
> appropriate secure buffers for us and then import them to the V4L2
> driver.

What exactly is a "secure buffer"?  I guess a gem object where read
access is not allowed, only scanout to display?  Who enforces this?
The hardware?  Or the kernel driver?

It might make sense for virtio-gpu to know that concept, to allow guests
ask for secure buffers.

And of course we'll need some way to pass around identifiers for these
(and maybe other) buffers (from virtio-gpu device via guest drivers to
virtio-vdec device).  virtio-gpu guest driver could generate a uuid for
that, attach it to the dma-buf and also notify the host so qemu can
maintain a uuid -> buffer lookup table.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

