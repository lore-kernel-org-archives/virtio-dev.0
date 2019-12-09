Return-Path: virtio-dev-return-6478-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5F6D5984345
	for <virtio-dev@lists.oasis-open.org>; Mon,  9 Dec 2019 10:46:24 +0000 (UTC)
Date: Mon, 9 Dec 2019 11:46:15 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191209104615.ulct6p34cn7ypvrz@sirius.home.kraxel.org>
References: <20191105191919.167345-1-dmitry.sepp@opensynergy.com>
 <CAD90Vcbr7L2KsyDxPeoKPRt6y_ai8xkJ=J0JCGsW6tGZJGH=0A@mail.gmail.com>
 <20191120112929.gvsne7ykvcyw65lu@sirius.home.kraxel.org>
 <7736193.Whgddqjo8n@os-lin-dmo>
 <CAD90VcbYAhk9CiagSEi=ouNMioR4v71uc40rRHGMe_+wvAm+0g@mail.gmail.com>
 <20191204091620.zpnd7jttkpkduort@sirius.home.kraxel.org>
 <CAPR809uYEjSGqPA57HiDgTf7MESrXnsCKwvSEQQ8LfMvCJwaaQ@mail.gmail.com>
 <CAD90VcaTWvos-PPrniZn_AfFQrCEkMHNXvhR56ApD8kfdTSG9g@mail.gmail.com>
 <20191206073205.4f3bbqbyeyxeipsx@sirius.home.kraxel.org>
 <CAD90VcY1QgJGYYXTWDFMVshtV0ZnwLjYUzf3uHcDR=FNA2mMEw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAD90VcY1QgJGYYXTWDFMVshtV0ZnwLjYUzf3uHcDR=FNA2mMEw@mail.gmail.com>
Subject: Re: [virtio-dev] [RFC RESEND] virtio-video: Add virtio video device
 specification
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Keiichi Watanabe <keiichiw@chromium.org>
Cc: Enrico Granata <egranata@google.com>, Dmitry Sepp <dmitry.sepp@opensynergy.com>, virtio-dev@lists.oasis-open.org, Tomasz Figa <tfiga@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Dylan Reid <dgreid@chromium.org>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, David Stevens <stevensd@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> > For (1) you'll simply do a QUEUE_BUFFER.  The command carries reference=
s
> > to the buffer pages.  No resource management needed.
> >
> > For (2) you'll have RESOURCE_CREATE + RESOURCE_DESTROY + QUEUE_RESOURCE=
,
> > where RESOURCE_CREATE passes the scatter list of buffer pages to the
> > host and QUEUE_RESOURCE will carry just the resource id.
> >
> > For (3) you'll have RESOURCE_IMPORT + RESOURCE_DESTROY + QUEUE_RESOURCE=
.
> >
>=20
> Thanks for the clarification.
> On second thought, however, I'm wondering if we should keep all
> RESOURCE controls.
> This should be an option (4).

Well, that's actually (2), aka "we use RESOURCE_* commands to manage
resources".  With the commands in the latest draft that would be:

  (1) RESOURCE_CREATE
  (2) RESOURCE_ATTACH_BACKING
  (3) RESOURCE_QUEUE (resource can be used multiple times here)
  (4) RESOURCE_DETACH_BACKING
  (5) RESOURCE_DESTROY

I'm not sure we need the separate *_BACKING commands.  I think we could
also have RESOURCE_CREATE pass the buffer pages scatter list instead.

Why it is done this way?  Just because the design was copied from
virtio-gpu?  Or is there some specific reason?

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

