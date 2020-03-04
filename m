Return-Path: virtio-dev-return-6888-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 59B62985D7E
	for <virtio-dev@lists.oasis-open.org>; Wed,  4 Mar 2020 10:08:17 +0000 (UTC)
MIME-Version: 1.0
References: <20200206102058.247258-1-keiichiw@chromium.org>
 <20200206102058.247258-2-keiichiw@chromium.org> <20200225095956.7rtwugfru4dbjj7q@sirius.home.kraxel.org>
 <CAD90VcaTJh5MTRggpOmCK2LAryMHha2+7nPkFVTT8N8S06tf-A@mail.gmail.com>
 <20200227092856.p4kuh5dhh2tk3nnf@sirius.home.kraxel.org> <CAPBb6MWwBbNULCfMxN_KLt_Zd8kmmNy2JPi6XjLF1YgxxCPydw@mail.gmail.com>
 <20200304064251.zzkhevqgth6uets6@sirius.home.kraxel.org>
In-Reply-To: <20200304064251.zzkhevqgth6uets6@sirius.home.kraxel.org>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Wed, 4 Mar 2020 19:07:58 +0900
Message-ID: <CAPBb6MVPjgLkbVjOY6O3srywNm8Zb1pMR2pGM1NinByhgFaZ_A@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v3 1/2] virtio-video: Add virtio video device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Keiichi Watanabe <keiichiw@chromium.org>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, David Staessens <dstaessens@chromium.org>, Dmitry Sepp <dmitry.sepp@opensynergy.com>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, Tomasz Figa <tfiga@chromium.org>, uril@redhat.com, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, Kiran Pawar <kiran.pawar@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Mar 4, 2020 at 3:43 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > > With a feature flag both driver and device can choose whenever they w=
ant
> > > support v1 or v2 or both.  With a version config field this is more
> > > limited, the device can't decide to support both.  So the bonus point=
s
> > > for a smooth transition go to the feature flags not the version field=
 ;)
> >
> > I agree that feature flags would be preferable in general, but I'm
> > concerned by the fact that there is (IIUC) a limited number of them.
>
> We have 64 total, some reserved, 24 are available to devices right now,
> see https://www.kraxel.org/virtio/virtio-v1.1-cs01-video-v3.html#x1-13000=
2
>
> > Video tends to change significantly over time, and to have optional
> > features that would also be presented as feature flags. After a while
> > we may run out of them, while a new protocol version would allow us to
> > extend the config struct with some new flags. Or am I missing
> > something?
>
> Not everything needs a feature flag.  For example we have
> VIRTIO_VIDEO_CMD_QUERY_CAPABILITY, and we can add new video formats
> without needing a feature flag.  Maybe it is a good idea to explicitly
> say in the specs that this can happen and that the driver should simply
> ignore any unknown format returned by the device.
>
> > I also wonder how "support v1 or v2 or both" would work with feature
> > flags. In order to make it possible to opt out of v1, I guess we would
> > need "v1 supported" flag to begin with?
>
> The driver can ignore any device without v2 feature flag set.
> The device can refuse to accept a driver without v2 support (don't allow
> setting the FEATURES_OK bit).

That should work as long as we want to add features. I had deprecation
of old features in mind, but maybe the more reasonable answer to that
is "always remain backward compatible". :)

As for the 24 feature flags, I guess that should we run out of them we
can always use the last one to signal that more flags can be found at
the end of the device configuration space.

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

