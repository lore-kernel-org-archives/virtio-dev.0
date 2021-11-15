Return-Path: <virtio-dev-return-8947-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9C70A9862EF
	for <virtio-dev@lists.oasis-open.org>; Mon, 15 Nov 2021 06:45:03 +0000 (UTC)
MIME-Version: 1.0
References: <20210120083143.766189-1-acourbot@chromium.org> <874k8k9wsi.fsf@redhat.com>
In-Reply-To: <874k8k9wsi.fsf@redhat.com>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Mon, 15 Nov 2021 15:44:50 +0900
Message-ID: <CAPBb6MUD_oYeUt8_bGRwAPCPam40Jtktz2F7+A3SO5PFRdUsiw@mail.gmail.com>
Subject: Re: [virtio-dev] [RFC PATCH v5] virtio-video: Add virtio video device specification
Content-Type: text/plain; charset="UTF-8"
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, linux-media@vger.kernel.org, alexlau@chromium.org, daniel@ffwll.ch, dgreid@chromium.org, dstaessens@chromium.org, egranata@google.com, kraxel@redhat.com, posciak@chromium.org, spice-devel@lists.freedesktop.org, stevensd@chromium.org, tfiga@chromium.org, uril@redhat.com, kiran.pawar@opensynergy.com, enric.balletbo@collabora.com, alex.bennee@linaro.org, Matti.Moell@opensynergy.com, Keiichi Watanabe <keiichiw@chromium.org>, Dmitry Sepp <dmitry.sepp@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Cornelia,

On Wed, Nov 10, 2021 at 6:37 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Wed, Jan 20 2021, Alexandre Courbot <acourbot@chromium.org> wrote:
>
> > From: Keiichi Watanabe <keiichiw@chromium.org>
> >
> > The virtio video encoder and decoder devices are virtual devices that
> > support video encoding and decoding respectively. Although they are
> > different devices, they use the same protocol.
> >
> > Signed-off-by: Dmitry Sepp <dmitry.sepp@opensynergy.com>
> > Signed-off-by: Keiichi Watanabe <keiichiw@chromium.org>
> > Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> > ---
> > Here is the new revision of the virtio-video specification. Compared to
> > v4 some extra simplification work has been performed, and all stream
> > settings are now consolidated under the parameters. Hopefully this can
> > be used as the basis to write a new version of the Linux driver and
> > virtual device, or maybe even to drop that RFC tag! :)
>
> It seems that there has not been any followup on this, has there?
>
> I assume that there is still interest (after all, the ids have already
> been reservered); let me add some quick comments from the spec pov (I
> don't really know anything about how video is supposed to work here.)

Thanks for the comments ; they come at the right time as we are
currently working on what will become the v6 of this draft. The
precision about the use of normative sections in particular is
welcome.

Although other work keeps getting in the way I hope to post v6
sometime this week. We are also thinking of updating our current
implementation of an older protocol version to provide a working
proof-of-concept, although this will likely take some more time to be
done.

Cheers,
Alex.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

