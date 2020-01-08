Return-Path: virtio-dev-return-6614-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 23036985E01
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Jan 2020 10:40:10 +0000 (UTC)
Date: Wed, 8 Jan 2020 11:40:02 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200108104002.jxh6amnrazhnamej@sirius.home.kraxel.org>
References: <CAD=HUj6FA3VoTJqNa+gmAgVOv9zS7Qk9pdg46EY9NvtJOdz5_A@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAD=HUj6FA3VoTJqNa+gmAgVOv9zS7Qk9pdg46EY9NvtJOdz5_A@mail.gmail.com>
Subject: Re: [virtio-dev][RFC PATCH v1 1/2] content: define what exporting a
 resource is
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: David Stevens <stevensd@chromium.org>
Cc: virtio-dev@lists.oasis-open.org, Dylan Reid <dgreid@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Zach Reizner <zachr@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, Gurchetan Singh <gurchetansingh@chromium.org>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 08, 2020 at 06:01:58PM +0900, David Stevens wrote:
> Define a mechanism for sharing resources between different virtio
> devices.
>=20
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>  content.tex | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/content.tex b/content.tex
> index b1ea9b9..73bd28e 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -373,6 +373,24 @@ \section{Driver Notifications}
> \label{sec:Virtqueues / Driver notifications}
>=20
>  \input{shared-mem.tex}
>=20
> +\section{Exporting Resources}\label{sec:Basic Facilities of a Virtio
> Device / Exporting Resources}
> +
> +When a resource created by one virtio device needs to be
> +shared with a seperate virtio device, the first device can
> +export the resource by generating a \field{uuid} which the
> +guest can pass to the second device to identify the resource.
> +
> +What constitutes a resource, how to export resources, and
> +how to import resources are defined by the individual device
> +types. The generation method of a \field{uuid} is dependent
> +upon the implementation of the exporting device.
> +
> +Whether a particular exported resource can be imported into
> +a device is dependent upon the implementations of the exporting
> +and importing devices. Generally speaking, the guest should
> +have some knowledge of the host configuration before trying to
> +use exported resources.

Hmm, I'd suggest to move the whole thing into the virtio-gpu section.
There is no such thing as a "resource" in general virtio context ...

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

