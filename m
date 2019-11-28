Return-Path: virtio-dev-return-6425-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BBCB6985ECB
	for <virtio-dev@lists.oasis-open.org>; Thu, 28 Nov 2019 18:04:28 +0000 (UTC)
References: <20191128131941.25069-1-kraxel@redhat.com>
From: Matti Moell <Matti.Moell@opensynergy.com>
Message-ID: <3815f3b3-135a-97ae-8f4a-0eee8cca81bb@opensynergy.com>
Date: Thu, 28 Nov 2019 19:04:23 +0100
MIME-Version: 1.0
In-Reply-To: <20191128131941.25069-1-kraxel@redhat.com>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH] virtio-gpu: add shared resource feature
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Gerd Hoffmann <kraxel@redhat.com>, virtio-dev@lists.oasis-open.org
Cc: Gurchetan Singh <gurchetansingh@chromium.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Gerd,

I really like this!

On 28.11.19 14:19, Gerd Hoffmann wrote:
> @@ -186,6 +211,7 @@ \subsubsection{Device Operation: Request header}\labe=
l{sec:Device Types / GPU De
>           VIRTIO_GPU_CMD_GET_CAPSET_INFO,
>           VIRTIO_GPU_CMD_GET_CAPSET,
>           VIRTIO_GPU_CMD_GET_EDID,
> +        VIRTIO_GPU_CMD_RESOURCE_CREATE_2D_SHARED,
Shouldn't there also the RESOURCE_CREATE_3D_SHARED? I know that 3D isn't=20
speced here but it looks awkward not to reserve it.

>  =20
>           /* cursor commands */
>           VIRTIO_GPU_CMD_UPDATE_CURSOR =3D 0x0300,
> @@ -205,6 +231,7 @@ \subsubsection{Device Operation: Request header}\labe=
l{sec:Device Types / GPU De
>           VIRTIO_GPU_RESP_ERR_INVALID_RESOURCE_ID,
>           VIRTIO_GPU_RESP_ERR_INVALID_CONTEXT_ID,
>           VIRTIO_GPU_RESP_ERR_INVALID_PARAMETER,
> +        VIRTIO_GPU_RESP_ERR_NO_BACKING_STORAGE,
>   };
>  =20
>   #define VIRTIO_GPU_FLAG_FENCE (1 << 0)
>=20

Cheers,

=09=09Matti

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

