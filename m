Return-Path: <virtio-dev-return-11122-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1B4DD9863D4
	for <virtio-dev@lists.oasis-open.org>; Mon, 20 Feb 2023 10:25:23 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <CAJs=3_B7sU=Y9qAc80S6obysN0fYaNX-tdexATTPOu1qv-38Gw@mail.gmail.com>
References: <20230220093551.1619951-1-alvaro.karsz@solid-run.com>
 <CAJs=3_B7sU=Y9qAc80S6obysN0fYaNX-tdexATTPOu1qv-38Gw@mail.gmail.com>
Date: Mon, 20 Feb 2023 11:25:16 +0100
Message-ID: <87o7poljlf.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [PATCH] virtio-net: define the
 VIRTIO_NET_F_CTRL_RX_EXTRA feature bit
Content-Type: text/plain
To: Alvaro Karsz <alvaro.karsz@solid-run.com>, mst@redhat.com
Cc: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, hengqi@linux.alibaba.com, parav@nvidia.com, "virtio-dev @ lists .
 oasis-open . org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 20 2023, Alvaro Karsz <alvaro.karsz@solid-run.com> wrote:

> I didn't add the control vq feature as a feature bit requirement for
> the same reason as [1].
>
> If you think that we can add a feature bit requirement instead of
> "SHOULD NOT offer" and "SHOULD NOT negotiate", I can add it in v2.
>
> [1] https://github.com/oasis-tcs/virtio-spec/issues/158

I agree that we need to stick with SHOULD here.

Are VIRTIO_NET_F_CTRL_RX_EXTRA and VIRTIO_NET_F_CTRL_RX independent of
each other, i.e. can you negotiate VIRTIO_NET_F_CTRL_RX_EXTRA but not
VIRTIO_NET_F_CTRL_RX? Looks like it to me, but would like to confirm.
(We would at most be able to add a SHOULD statement anyway.)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

