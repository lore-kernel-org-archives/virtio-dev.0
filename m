Return-Path: virtio-dev-return-6682-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 02DBD985F8C
	for <virtio-dev@lists.oasis-open.org>; Wed, 22 Jan 2020 08:24:10 +0000 (UTC)
Date: Wed, 22 Jan 2020 03:24:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200122032328-mutt-send-email-mst@kernel.org>
References: <CAD=HUj71Z_eQUj93LZYOAc+Prj9ohym1oJtiLWzCy5=T-cNxCQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAD=HUj71Z_eQUj93LZYOAc+Prj9ohym1oJtiLWzCy5=T-cNxCQ@mail.gmail.com>
Subject: Re: [virtio-dev][RFC PATCH v2 0/2] Cross-device resource sharing
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: David Stevens <stevensd@chromium.org>
Cc: virtio-dev@lists.oasis-open.org, Gerd Hoffmann <kraxel@redhat.com>, Dylan Reid <dgreid@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Zach Reizner <zachr@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, Gurchetan Singh <gurchetansingh@chromium.org>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 22, 2020 at 04:16:15PM +0900, David Stevens wrote:
> This RFC comes from the recent discussion on buffer sharing [1],
> specifically about the need to share resources between different
> virtio devices. For a concrete use case, this can be used to share
> virtio-gpu allocated buffers with the recently proposed virtio video
> device [2], without the need to memcpy decoded frames through the
> guest.
>=20
> [1] https://markmail.org/thread/jeh5xjjxvylyrbur
> [2] https://markmail.org/thread/yb25fim2dqfuktgf


Wrong list- this belongs on virtio-comment.
dev is for implementation discussions.

> Changes v1 -> v2:
> Rename exported resource to exported object
> Rename the virtio-gpu export command
>=20
> David Stevens (2):
>   content: define what an exported object is
>   virtio-gpu: add the ability to export resources
>=20
>  content.tex    | 18 ++++++++++++++++++
>  virtio-gpu.tex | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

