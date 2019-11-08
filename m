Return-Path: virtio-dev-return-6304-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CB614985F34
	for <virtio-dev@lists.oasis-open.org>; Fri,  8 Nov 2019 07:58:21 +0000 (UTC)
MIME-Version: 1.0
References: <20191105191919.167345-1-dmitry.sepp@opensynergy.com>
 <20191107095657.72dlxzm4uz7ndkek@sirius.home.kraxel.org> <1573181413.STYvEGL1rf@os-lin-dmo>
 <20191108074955.t7mtqks4dfmrdzod@sirius.home.kraxel.org>
In-Reply-To: <20191108074955.t7mtqks4dfmrdzod@sirius.home.kraxel.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Fri, 8 Nov 2019 16:58:08 +0900
Message-ID: <CAAFQd5DEdLM=BmfQqsDryGgzu73A=u7KWA3RAT0no4kvjkg+oA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [virtio-dev] [RFC RESEND] virtio-video: Add virtio video device specification
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Dmitry Sepp <dmitry.sepp@opensynergy.com>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Keiichi Watanabe <keiichiw@chromium.org>, Alexandre Courbot <acourbot@chromium.org>, alexlau@chromium.org, dgreid@chromium.org, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, David Stevens <stevensd@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, Daniel Vetter <daniel@ffwll.ch>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Nov 8, 2019 at 4:50 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Thu, Nov 07, 2019 at 02:09:34PM +0100, Dmitry Sepp wrote:
> > Hello Gerd,
> >
> > Thank you for your feedback.
> >
> > There is no relationship between those. As I mentioned earlier. we have also
> > been working on a virtio video device at the same time. And there is no
> > relationship between the two specs.
>
> Keiichi, have you looked at the spec?
>
> I think it is useful to have a single device specification for all video
> functions given that there is a bunch of common stuff.  Both encoder and
> decoder must negotiate video frame and video stream parameters for
> example.  Also the virtio-video spec looks like a superset of
> virtio-vdec.
>
> Is there any important feature in video-vdec which is missing in
> virtio-video?
>

I just replied to Dmitry's email with further clarification on some
vdec aspects and rationale behind some of the design decisions. Please
take a look.

I think it should be possible to build one protocol for both decoding
and encoding. Actually virtio-vdec shouldn't need too much
modification to handle encoding. The ability to set operating mode
(decoder vs encoder) and set frame buffer format should be enough.

However I believe that making it as generic as virtio-video adds too
much complexity, increasing the possible attack surface and making it
difficult to validate.

Best regards,
Tomasz

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

