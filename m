Return-Path: virtio-dev-return-6681-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 421A1985F8C
	for <virtio-dev@lists.oasis-open.org>; Wed, 22 Jan 2020 08:23:18 +0000 (UTC)
Date: Wed, 22 Jan 2020 03:23:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200122032103-mutt-send-email-mst@kernel.org>
References: <CAD=HUj640QfNwO4J_tdcSx36YOVAVT_dZUXYuKPaCKvZVWeHsg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAD=HUj640QfNwO4J_tdcSx36YOVAVT_dZUXYuKPaCKvZVWeHsg@mail.gmail.com>
Subject: Re: [virtio-dev][RFC PATCH v1 1/2] content: define what an exported
 object is
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: David Stevens <stevensd@chromium.org>
Cc: virtio-dev@lists.oasis-open.org, Gerd Hoffmann <kraxel@redhat.com>, Dylan Reid <dgreid@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Zach Reizner <zachr@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, =?iso-8859-1?Q?St=E9phane?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, Gurchetan Singh <gurchetansingh@chromium.org>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 22, 2020 at 04:16:24PM +0900, David Stevens wrote:
> Define a mechanism for sharing objects between different virtio
> devices.
>=20
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>  content.tex | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
>=20
> diff --git a/content.tex b/content.tex
> index b1ea9b9..6c6dd59 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -373,6 +373,24 @@ \section{Driver Notifications}
> \label{sec:Virtqueues / Driver notifications}
>=20
>  \input{shared-mem.tex}
>=20
> +\section{Exporting Objects}\label{sec:Basic Facilities of a Virtio
> Device / Exporting Objects}
> +
> +When an object created by one virtio device needs to be
> +shared with a seperate virtio device, the first device can
> +export the object by generating a \field{uuid}

This is a field where?

> which the
> +guest can pass to the second device to identify the object.


s/guest/Driver/ ?

> +
> +What constitutes an object, how to export objects, and
> +how to import objects are defined by the individual device
> +types. The generation method of a \field{uuid} is dependent
> +upon the implementation of the exporting device.
> +
> +Whether a particular exported object can be imported into
> +a device is dependent upon the implementations of the exporting
> +and importing devices. Generally speaking, the guest should
> +have some knowledge of the host configuration before trying to
> +use exported objects.

this last paragraph seems to be too general to be really useful.

Also - what are guest and host here?


> +
>  \chapter{General Initialization And Device
> Operation}\label{sec:General Initialization And Device Operation}
>=20
>  We start with an overview of device initialization, then expand on the
> --=20
> 2.25.0.341.g760bfbb309-goog
>=20
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

