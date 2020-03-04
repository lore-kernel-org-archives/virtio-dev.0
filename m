Return-Path: virtio-dev-return-6883-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0DE2D985D7E
	for <virtio-dev@lists.oasis-open.org>; Wed,  4 Mar 2020 04:39:06 +0000 (UTC)
MIME-Version: 1.0
References: <20200206102058.247258-1-keiichiw@chromium.org>
 <20200206102058.247258-2-keiichiw@chromium.org> <20200225095956.7rtwugfru4dbjj7q@sirius.home.kraxel.org>
 <CAD90VcaTJh5MTRggpOmCK2LAryMHha2+7nPkFVTT8N8S06tf-A@mail.gmail.com> <20200227092856.p4kuh5dhh2tk3nnf@sirius.home.kraxel.org>
In-Reply-To: <20200227092856.p4kuh5dhh2tk3nnf@sirius.home.kraxel.org>
From: Alexandre Courbot <acourbot@chromium.org>
Date: Wed, 4 Mar 2020 13:31:19 +0900
Message-ID: <CAPBb6MWwBbNULCfMxN_KLt_Zd8kmmNy2JPi6XjLF1YgxxCPydw@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v3 1/2] virtio-video: Add virtio video device specification
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Keiichi Watanabe <keiichiw@chromium.org>, virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, David Staessens <dstaessens@chromium.org>, Dmitry Sepp <dmitry.sepp@opensynergy.com>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, Tomasz Figa <tfiga@chromium.org>, uril@redhat.com, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, Kiran Pawar <kiran.pawar@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 27, 2020 at 6:29 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > Dmitry's virtio-video driver
> > https://patchwork.linuxtv.org/patch/61717/.
> > Once it becomes fully functional, I'll post a list of possible
> > improvements of protocol.
>
> Cool.  Actually implementing things can find design problems
> in the protocol you didn't notice earlier.
>
> > > > +\begin{description}
> > > > +\item[\field{version}] is the protocol version that the device tal=
ks.
> > > > +  The device MUST set this to 0.
> > >
> > > What is the intended use case for this?
> > >
> > > Given that virtio has feature flags to negotiate support for optional
> > > features and protocol extensions between driver and device, why do yo=
u
> > > think this is needed?
> >
> > While feature flags work well when we "extend" the protocol with an
> > optional feature, they don't when we want to "drop" or "modify"
> > features.
> > For example, I guess it'd be useful when we want:
> > * to abandon a non-optional command,
> > * to change a non-optional struct's layout,or
> > * to change the order of commands in which the device expects to be sen=
t.
> >
> > Though it might be possible to handle these changes by feature flags,
> > I suspect the version number allow us to transition protocols more
> > smoothly.
>
> Feature flags can be mandatory, both device and driver can fail
> initialization when a specific feature is not supported by the other
> end.  So in case we did screw up things so badly that we have to
> effectively start over (which I hope wouldn't be the case) we can add a
> VERSION_2 feature flag for a new set of commands with new structs and
> new semantics.
>
> With a feature flag both driver and device can choose whenever they want
> support v1 or v2 or both.  With a version config field this is more
> limited, the device can't decide to support both.  So the bonus points
> for a smooth transition go to the feature flags not the version field ;)

I agree that feature flags would be preferable in general, but I'm
concerned by the fact that there is (IIUC) a limited number of them.
Video tends to change significantly over time, and to have optional
features that would also be presented as feature flags. After a while
we may run out of them, while a new protocol version would allow us to
extend the config struct with some new flags. Or am I missing
something?

I also wonder how "support v1 or v2 or both" would work with feature
flags. In order to make it possible to opt out of v1, I guess we would
need "v1 supported" flag to begin with?

Sorry for the newbie question about feature flags, I'm still in the
process of wrapping my head around virtio. :)

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

