Return-Path: virtio-dev-return-6633-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0A933985E3F
	for <virtio-dev@lists.oasis-open.org>; Thu,  9 Jan 2020 13:44:38 +0000 (UTC)
MIME-Version: 1.0
References: <CAD=HUj6FA3VoTJqNa+gmAgVOv9zS7Qk9pdg46EY9NvtJOdz5_A@mail.gmail.com>
 <20200108104002.jxh6amnrazhnamej@sirius.home.kraxel.org> <CAOiLmNHMAz6UqxuEsiq6Y_dSNcCvtBrFR-FHG6voJAhpF8SeeA@mail.gmail.com>
 <20200109131218.5xc6zhovbgjavfpv@sirius.home.kraxel.org>
In-Reply-To: <20200109131218.5xc6zhovbgjavfpv@sirius.home.kraxel.org>
From: David Stevens <stevensd@chromium.org>
Date: Thu, 9 Jan 2020 22:44:29 +0900
Message-ID: <CAD=HUj7jdKsWAfmmzO7bpmd3PyHFDA91RKkzKiVbuv8=PT2Qxw@mail.gmail.com>
Subject: Re: [virtio-dev][RFC PATCH v1 1/2] content: define what exporting a
 resource is
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: David Stevens <stevensd@google.com>, virtio-dev@lists.oasis-open.org, Dylan Reid <dgreid@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Zach Reizner <zachr@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, Gurchetan Singh <gurchetansingh@chromium.org>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

> > that isn't just a leaf node of the spec. I think it's better to define
> > 'resource' as a top level concept for virtio devices, even if the speci=
fics
> > of what a 'resource' is are defined by individual device types.
>
> Your patch doesn't define what a resource is though.  It only refers to
> something it calls 'resource' ...

Reading it again, what I wrote was a little ambiguous. Stating things
more clearly, the top level defines an 'exported resource' as a
'resource' associated with a uuid for the purpose of sharing between
different virtio devices. It leaves the definition of what constitutes
a 'resource' to individual device types. Perhaps it would be better to
use 'object' or something instead of 'resource', to avoid the
collision with virtio-gpu resources.

-David

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

