Return-Path: virtio-dev-return-6684-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 07B26985F97
	for <virtio-dev@lists.oasis-open.org>; Wed, 22 Jan 2020 10:13:53 +0000 (UTC)
MIME-Version: 1.0
References: <CAD=HUj640QfNwO4J_tdcSx36YOVAVT_dZUXYuKPaCKvZVWeHsg@mail.gmail.com>
 <20200122032103-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200122032103-mutt-send-email-mst@kernel.org>
From: David Stevens <stevensd@chromium.org>
Date: Wed, 22 Jan 2020 19:13:41 +0900
Message-ID: <CAD=HUj4pORJK1SQ2+n_oiXJyGaKqakSiOGcXdRCGSAMnuxY4cw@mail.gmail.com>
Subject: Re: [virtio-dev][RFC PATCH v1 1/2] content: define what an exported
 object is
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Dylan Reid <dgreid@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Zach Reizner <zachr@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, Gurchetan Singh <gurchetansingh@chromium.org>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Linux Media Mailing List <linux-media@vger.kernel.org>, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

> > +When an object created by one virtio device needs to be
> > +shared with a seperate virtio device, the first device can
> > +export the object by generating a \field{uuid}
>
> This is a field where?

It's a property of the exported object, but I guess it doesn't really
correspond to any concrete field. I'll remove \field.

> > which the
> > +guest can pass to the second device to identify the object.
>
> s/guest/Driver/ ?

The uuid can be passed to a second device controlled by a different
driver, so I think 'driver' by itself is ambiguous. I'm using guest as
a shorthand for 'system which includes the drivers and software which
sits on top of the drivers', and that meaning does seem to be
compatible with language in the rest of the spec. If that shorthand
isn't acceptable, I can rewrite the sentence passively as '... a uuid
which can then be passed to a second device ...'.

> Also - what are guest and host here?

There are a number of places in the virtio spec where 'guest' is used
to refer to the system where drivers run and where 'host' is used to
refer to the system where devices run. I guess those terms aren't
concretely defined within the spec, but they do seem to have a well
understood meaning. Or is the guest/host language discouraged in new
additions to the spec?

-David

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

