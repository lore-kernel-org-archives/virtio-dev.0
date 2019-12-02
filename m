Return-Path: virtio-dev-return-6434-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3A860985A86
	for <virtio-dev@lists.oasis-open.org>; Mon,  2 Dec 2019 10:25:38 +0000 (UTC)
References: <20191202100216.133556-1-stefanha@redhat.com>
From: Matti Moell <Matti.Moell@opensynergy.com>
Message-ID: <4802bbbe-e3fc-ca96-bc45-e6f805f2ea96@opensynergy.com>
Date: Mon, 2 Dec 2019 11:25:19 +0100
MIME-Version: 1.0
In-Reply-To: <20191202100216.133556-1-stefanha@redhat.com>
Content-Language: en-US
Subject: Re: [virtio-dev] [PATCH] virtio-blk: document VIRTIO_BLK_T_GET_ID
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
To: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org
Cc: Jan Kiszka <jan.kiszka@siemens.com>
List-ID: <virtio-dev.lists.oasis-open.org>


On 02.12.19 11:02, Stefan Hajnoczi wrote:
> The VIRTIO_BLK_T_GET_ID request type was implemented in Linux and QEMU
> in 2010.  It does not have a feature bit but devices respond with
> VIRTIO_BLK_S_UNSUPP if a request type is unimplemented.
>=20
> This patch documents the VIRTIO_BLK_T_GET_ID request type as currently
> implemented in Linux and QEMU.
>=20
> Suggested-by: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   content.tex | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Matti M=C3=B6ll <Matti.Moell@opensynergy.com>

I wanted to ask the same question hours before seeing Jans mail about=20
it, thank you very much for picking this up.

Cheers,

=09=09Matti

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

