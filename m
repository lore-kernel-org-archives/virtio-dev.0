Return-Path: <virtio-dev-return-11126-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 08E00986418
	for <virtio-dev@lists.oasis-open.org>; Mon, 20 Feb 2023 14:21:47 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20230206080210.37758-1-alvaro.karsz@solid-run.com>
References: <20230206080210.37758-1-alvaro.karsz@solid-run.com>
Date: Mon, 20 Feb 2023 15:21:41 +0100
Message-ID: <87fsb0l8ne.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v3] virtio-net: Mention
 VIRTIO_NET_F_HASH_REPORT dependency on VIRTIO_NET_F_CTRL_VQ
Content-Type: text/plain
To: Alvaro Karsz <alvaro.karsz@solid-run.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: jasowang@redhat.com, mst@redhat.com, Alvaro Karsz <alvaro.karsz@solid-run.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 06 2023, Alvaro Karsz <alvaro.karsz@solid-run.com> wrote:

> If the VIRTIO_NET_F_HASH_REPORT feature is negotiated, the driver may
> send VIRTIO_NET_CTRL_MQ_HASH_CONFIG commands, thus, the control VQ
> feature should be negotiated.
>
> ---
> v2: Use SHOULD instead of Feature bit requirement, version 1.2 is already
>     out and doesn't include this depencency.
>
> v3: Explain the dependency in a less confusing way.
>
> Signed-off-by: Alvaro Karsz <alvaro.karsz@solid-run.com>

Minor nit (for the next time, was trivial to fix up): Putting your s-o-b
beneath the "---" instructs git am to cut it off; the changelog should
go below the s-o-b.

>
>  device-types/net/description.tex | 6 ++++++
>  1 file changed, 6 insertions(+)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

