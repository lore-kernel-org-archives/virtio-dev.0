Return-Path: virtio-dev-return-6292-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2B79A985EED
	for <virtio-dev@lists.oasis-open.org>; Wed,  6 Nov 2019 12:50:31 +0000 (UTC)
Date: Wed, 6 Nov 2019 13:50:23 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20191106125023.uhdhtqisybilxasr@sirius.home.kraxel.org>
References: <20191105105456.7xbhtistnbp272lj@sirius.home.kraxel.org>
 <20191106084344.GB189998@stefanha-x1.localdomain>
 <20191106095122.jju7eo57scfoat6a@sirius.home.kraxel.org>
 <CAJSP0QUJBkqtVJq17tfX5O-JuvEGcZQviP0C3tv9qSDy-P-hcg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJSP0QUJBkqtVJq17tfX5O-JuvEGcZQviP0C3tv9qSDy-P-hcg@mail.gmail.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [virtio-dev] Re: guest / host buffer sharing ...
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: geoff@hostfission.com, virtio-dev@lists.oasis-open.org, Alex Lau <alexlau@chromium.org>, Daniel Vetter <daniel@ffwll.ch>, Alexandre Courbot <acourbot@chromium.org>, qemu-devel <qemu-devel@nongnu.org>, Tomasz Figa <tfiga@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>, David Stevens <stevensd@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Dylan Reid <dgreid@chromium.org>, Gurchetan Singh <gurchetansingh@chromium.org>, Dmitry Morozov <dmitry.morozov@opensynergy.com>, Pawel Osciak <posciak@chromium.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

  Hi,

> In the graphics buffer sharing use case, how does the other side
> determine how to interpret this data?

The idea is to have free form properties (name=3Dvalue, with value being
a string) for that kind of metadata.

> Shouldn't there be a VIRTIO
> device spec for the messaging so compatible implementations can be
> written by others?

Adding a list of common properties to the spec certainly makes sense,
so everybody uses the same names.  Adding struct-ed properties for
common use cases might be useful too.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

