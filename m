Return-Path: virtio-dev-return-6796-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 84E3E985E3A
	for <virtio-dev@lists.oasis-open.org>; Thu, 27 Feb 2020 09:29:14 +0000 (UTC)
Date: Thu, 27 Feb 2020 10:28:56 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200227092856.p4kuh5dhh2tk3nnf@sirius.home.kraxel.org>
References: <20200206102058.247258-1-keiichiw@chromium.org>
 <20200206102058.247258-2-keiichiw@chromium.org>
 <20200225095956.7rtwugfru4dbjj7q@sirius.home.kraxel.org>
 <CAD90VcaTJh5MTRggpOmCK2LAryMHha2+7nPkFVTT8N8S06tf-A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAD90VcaTJh5MTRggpOmCK2LAryMHha2+7nPkFVTT8N8S06tf-A@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v3 1/2] virtio-video: Add virtio video device
 specification
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: Keiichi Watanabe <keiichiw@chromium.org>
Cc: virtio-dev@lists.oasis-open.org, Linux Media Mailing List <linux-media@vger.kernel.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, David Staessens <dstaessens@chromium.org>, Dmitry Sepp <dmitry.sepp@opensynergy.com>, Enrico Granata <egranata@google.com>, Frediano Ziglio <fziglio@redhat.com>, Hans Verkuil <hverkuil@xs4all.nl>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, spice-devel@lists.freedesktop.org, David Stevens <stevensd@chromium.org>, Tomasz Figa <tfiga@chromium.org>, uril@redhat.com, Samiullah Khawaja <samiullah.khawaja@opensynergy.com>, Kiran Pawar <kiran.pawar@opensynergy.com>
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> Dmitry's virtio-video driver
> https://patchwork.linuxtv.org/patch/61717/.
> Once it becomes fully functional, I'll post a list of possible
> improvements of protocol.

Cool.  Actually implementing things can find design problems
in the protocol you didn't notice earlier.

> > > +\begin{description}
> > > +\item[\field{version}] is the protocol version that the device talks=
.
> > > +  The device MUST set this to 0.
> >
> > What is the intended use case for this?
> >
> > Given that virtio has feature flags to negotiate support for optional
> > features and protocol extensions between driver and device, why do you
> > think this is needed?
>=20
> While feature flags work well when we "extend" the protocol with an
> optional feature, they don't when we want to "drop" or "modify"
> features.
> For example, I guess it'd be useful when we want:
> * to abandon a non-optional command,
> * to change a non-optional struct's layout,or
> * to change the order of commands in which the device expects to be sent.
>=20
> Though it might be possible to handle these changes by feature flags,
> I suspect the version number allow us to transition protocols more
> smoothly.

Feature flags can be mandatory, both device and driver can fail
initialization when a specific feature is not supported by the other
end.  So in case we did screw up things so badly that we have to
effectively start over (which I hope wouldn't be the case) we can add a
VERSION_2 feature flag for a new set of commands with new structs and
new semantics.

With a feature flag both driver and device can choose whenever they want
support v1 or v2 or both.  With a version config field this is more
limited, the device can't decide to support both.  So the bonus points
for a smooth transition go to the feature flags not the version field ;)

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

