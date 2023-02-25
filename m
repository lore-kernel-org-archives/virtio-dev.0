Return-Path: <alvaro.karsz@solid-run.com>
MIME-Version: 1.0
References: <20230224142602.657-1-hengqi@linux.alibaba.com> <CAJs=3_C_NATOMyLJs1G7cmewpSasW67UBpoa53ZHayw+Uw5+-g@mail.gmail.com>
In-Reply-To: <CAJs=3_C_NATOMyLJs1G7cmewpSasW67UBpoa53ZHayw+Uw5+-g@mail.gmail.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Sat, 25 Feb 2023 16:20:52 +0200
Message-ID: <CAJs=3_AgSgbqUnpS6SiAobWR9zZbFsAVJNrra8r2EksYMwgcRw@mail.gmail.com>
Subject: Re: [PATCH v8] virtio-net: support the virtqueue coalescing moderation
Content-Type: text/plain; charset="UTF-8"
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, virtio-comment@lists.oasis-open.org, "Michael S . Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>, David Edmondson <david.edmondson@oracle.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> A general note,
>
> Correct my if I'm wrong, but the fact that a driver can't send
> VIRTIO_NET_CTRL_NOTF_COAL_[T/R]X_SET  commands if
> VIRTIO_NET_F_NOTF_COAL is not negotiated isn't explicitly mentioned
> anywhere.
> A reader may think that the commands cant be sent if

I meant "can", not "cant"
Sorry about that.

> VIRTIO_NET_F_VQ_NOTF_COAL is negotiated.
> I'm not talking about the conformance parts, but I think that we
> should write somewhere in the beginning which commands can be used
> with which feature bits.

