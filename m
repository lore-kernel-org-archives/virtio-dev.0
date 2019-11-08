Return-Path: virtio-dev-return-6302-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 47235985F35
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 Nov 2019 07:50:04 +0000 (UTC)
Date: Fri, 8 Nov 2019 08:49:55 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191108074955.t7mtqks4dfmrdzod@sirius.home.kraxel.org>
References: <20191105191919.167345-1-dmitry.sepp@opensynergy.com>
 <20191107095657.72dlxzm4uz7ndkek@sirius.home.kraxel.org>
 <1573181413.STYvEGL1rf@os-lin-dmo>
MIME-Version: 1.0
In-Reply-To: <1573181413.STYvEGL1rf@os-lin-dmo>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: Re: [virtio-dev] [RFC RESEND] virtio-video: Add virtio video device
 specification
To: Dmitry Sepp <dmitry.sepp@opensynergy.com>
Cc: virtio-dev@lists.oasis-open.org, linux-media@vger.kernel.org, tfiga@chromium.org, keiichiw@chromium.org, acourbot@chromium.org, alexlau@chromium.org, dgreid@chromium.org, marcheu@chromium.org, posciak@chromium.org, stevensd@chromium.org, hverkuil@xs4all.nl, daniel@ffwll.ch
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Nov 07, 2019 at 02:09:34PM +0100, Dmitry Sepp wrote:
> Hello Gerd,
>=20
> Thank you for your feedback.
>=20
> There is no relationship between those. As I mentioned earlier. we have a=
lso=20
> been working on a virtio video device at the same time. And there is no=
=20
> relationship between the two specs.

Keiichi, have you looked at the spec?

I think it is useful to have a single device specification for all video
functions given that there is a bunch of common stuff.  Both encoder and
decoder must negotiate video frame and video stream parameters for
example.  Also the virtio-video spec looks like a superset of
virtio-vdec.

Is there any important feature in video-vdec which is missing in
virtio-video?

> virtio-video:
> 1. Uses the 'driver requests - device responses' model.
> 2. Does not  have the logical split of bitstreams and framebuffers, has o=
nly a=20
> generic buffer object.

Can you give a quick summary on buffer object management?

thanks,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

