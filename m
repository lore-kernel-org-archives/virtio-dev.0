Return-Path: virtio-dev-return-6618-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B5B10985E03
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Jan 2020 11:20:41 +0000 (UTC)
MIME-Version: 1.0
References: <CAD=HUj5U-TxqbPJiRRbyMHON21sht75q3nisvwvKrO+Bf=n8ng@mail.gmail.com>
 <20200108104459.qikjl4n2j5wkwslu@sirius.home.kraxel.org>
In-Reply-To: <20200108104459.qikjl4n2j5wkwslu@sirius.home.kraxel.org>
From: David Stevens <stevensd@chromium.org>
Date: Wed, 8 Jan 2020 20:20:29 +0900
Message-ID: <CAD=HUj7Y9x_cpWvKF-7oK_jcgKXfQxXe-198JbkCA=LyERvA4A@mail.gmail.com>
Subject: Re: [virtio-dev][RFC PATCH v1 2/2] virtio-gpu: add the ability to
 export resources
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Dylan Reid <dgreid@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Zach Reizner <zachr@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, Gurchetan Singh <gurchetansingh@chromium.org>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

> Is there a specific reason why you want the host pick the uuid?  I would
> let the guest define the uuid, i.e. move the uuid fields to
> virtio_gpu_export_resource and scratch virtio_gpu_resp_export_resource.

Sending the uuid in the original request doesn't really buy us
anything, at least in terms of asynchronicity. The guest would still
need to wait for the response to arrive before it could safely pass
the uuid to any other virtio devices, to prevent a race where the
import fails because it is processed before virtio-gpu processes the
export. Perhaps this wouldn't be the case if we supported sharing
fences between virtio devices, but even then, fences are more of a
thing for the operation of a pipeline, not for the setup of a
pipeline.

At that point, I think it's just a matter of aesthetics. I lean
slightly towards returning the uuid from the host, since that rules
out any implementation with the aforementioned race. That being said,
if there are any specific reasons or preferences to assigning the uuid
from the guest, I can switch to that direction.

-David

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

