Return-Path: virtio-dev-return-6615-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EBB4A985E01
	for <virtio-dev@lists.oasis-open.org>; Wed,  8 Jan 2020 10:45:04 +0000 (UTC)
Date: Wed, 8 Jan 2020 11:44:59 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20200108104459.qikjl4n2j5wkwslu@sirius.home.kraxel.org>
References: <CAD=HUj5U-TxqbPJiRRbyMHON21sht75q3nisvwvKrO+Bf=n8ng@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAD=HUj5U-TxqbPJiRRbyMHON21sht75q3nisvwvKrO+Bf=n8ng@mail.gmail.com>
Subject: Re: [virtio-dev][RFC PATCH v1 2/2] virtio-gpu: add the ability to
 export resources
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: David Stevens <stevensd@chromium.org>
Cc: virtio-dev@lists.oasis-open.org, Dylan Reid <dgreid@chromium.org>, Tomasz Figa <tfiga@chromium.org>, Zach Reizner <zachr@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>, Alexandre Courbot <acourbot@chromium.org>, Alex Lau <alexlau@chromium.org>, =?utf-8?B?U3TDqXBoYW5l?= Marchesin <marcheu@chromium.org>, Pawel Osciak <posciak@chromium.org>, Gurchetan Singh <gurchetansingh@chromium.org>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, Linux Media Mailing List <linux-media@vger.kernel.org>
List-ID: <virtio-dev.lists.oasis-open.org>

> +\begin{lstlisting}
> +struct virtio_gpu_export_resource {
> +        struct virtio_gpu_ctrl_hdr hdr;
> +        le32 resource_id;
> +        le32 padding;
> +};
> +
> +struct virtio_gpu_resp_export_resource {
> +        struct virtio_gpu_ctrl_hdr hdr;
> +        le64 uuid_low;
> +        le64 uuid_high;
> +};
> +\end{lstlisting}

Is there a specific reason why you want the host pick the uuid?  I would
let the guest define the uuid, i.e. move the uuid fields to
virtio_gpu_export_resource and scratch virtio_gpu_resp_export_resource.

Also I'd siggest to name the command (and struct) RESOURCE_ASSIGN_UUID.

cheers,
  Gerd


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

