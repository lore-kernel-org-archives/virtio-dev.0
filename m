Return-Path: virtio-dev-return-6251-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DFF08986007
	for <virtio-dev@lists.oasis-open.org>; Thu, 17 Oct 2019 10:13:06 +0000 (UTC)
Date: Thu, 17 Oct 2019 12:13:04 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191017101304.pbjoj3knyveuacqm@sirius.home.kraxel.org>
References: <20190919093404.182015-1-keiichiw@chromium.org>
 <4037801.MZecyecTDs@os-lin-dmo>
 <CAAFQd5CfNK1oisDaOWaW+9NTQOLn1EHPrPzvxMPcSxLkBgv3Ww@mail.gmail.com>
 <15135216.K0K410U5qv@os-lin-dmo>
 <CAAFQd5DuChujakwmhtQ8v2CSLFqVYjLz9eGHuqrQnJ7apft+3Q@mail.gmail.com>
 <20191017071952.s3dq2oxdiy3khp5w@sirius.home.kraxel.org>
 <CAAFQd5ByuyTDqwiBeT7U7cVA8omOPGRRxb2tB8=J-u7WYU-urQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAFQd5ByuyTDqwiBeT7U7cVA8omOPGRRxb2tB8=J-u7WYU-urQ@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH] [RFC RESEND] vdec: Add virtio video decode
 device specification
To: Tomasz Figa <tfiga@chromium.org>
Cc: Dmitry Morozov <dmitry.morozov@opensynergy.com>, David Stevens <stevensd@chromium.org>, virtio-dev@lists.oasis-open.org, Keiichi Watanabe <keiichiw@chromium.org>, Alexandre Courbot <acourbot@chromium.org>, alexlau@chromium.org, dgreid@chromium.org, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Linux Media Mailing List <linux-media@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> That could be still a guest physical address. Like on a bare metal
> system with TrustZone, there could be physical memory that is not
> accessible to the CPU.

Hmm.  Yes, maybe.  We could use the dma address of the (first page of
the) guest buffer.  In case of a secure buffer the guest has no access
to the guest buffer would be unused, but it would at least make sure
that things don't crash in case someone tries to map & access the
buffer.

The host should be able to figure the corresponding host buffer from the
guest buffer address.

When running drm-misc-next you should be able to test whenever that'll
actually work without any virtio-gpu driver changes.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

