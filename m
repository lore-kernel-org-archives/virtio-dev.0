Return-Path: <virtio-dev-return-11121-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E470C9863CE
	for <virtio-dev@lists.oasis-open.org>; Mon, 20 Feb 2023 09:40:45 +0000 (UTC)
MIME-Version: 1.0
References: <20230220093551.1619951-1-alvaro.karsz@solid-run.com>
In-Reply-To: <20230220093551.1619951-1-alvaro.karsz@solid-run.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Mon, 20 Feb 2023 11:40:07 +0200
Message-ID: <CAJs=3_B7sU=Y9qAc80S6obysN0fYaNX-tdexATTPOu1qv-38Gw@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH] virtio-net: define the VIRTIO_NET_F_CTRL_RX_EXTRA feature bit
Content-Type: text/plain; charset="UTF-8"
To: mst@redhat.com
Cc: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, hengqi@linux.alibaba.com, parav@nvidia.com, "virtio-dev @ lists . oasis-open . org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

I didn't add the control vq feature as a feature bit requirement for
the same reason as [1].

If you think that we can add a feature bit requirement instead of
"SHOULD NOT offer" and "SHOULD NOT negotiate", I can add it in v2.

[1] https://github.com/oasis-tcs/virtio-spec/issues/158

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

