Return-Path: <alvaro.karsz@solid-run.com>
MIME-Version: 1.0
References: <20230220093551.1619951-1-alvaro.karsz@solid-run.com>
 <CAJs=3_B7sU=Y9qAc80S6obysN0fYaNX-tdexATTPOu1qv-38Gw@mail.gmail.com> <87o7poljlf.fsf@redhat.com>
In-Reply-To: <87o7poljlf.fsf@redhat.com>
From: Alvaro Karsz <alvaro.karsz@solid-run.com>
Date: Mon, 20 Feb 2023 13:15:47 +0200
Message-ID: <CAJs=3_AG7+n5pj0SWW6eu2vLXtv7q-s+070gRfsnNEgue=uvrw@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH] virtio-net: define the
 VIRTIO_NET_F_CTRL_RX_EXTRA feature bit
Content-Type: text/plain; charset="UTF-8"
To: Cornelia Huck <cohuck@redhat.com>
Cc: mst@redhat.com, jasowang@redhat.com, virtio-comment@lists.oasis-open.org, hengqi@linux.alibaba.com, parav@nvidia.com, "virtio-dev @ lists . oasis-open . org" <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

Hi,

> I agree that we need to stick with SHOULD here.
>
> Are VIRTIO_NET_F_CTRL_RX_EXTRA and VIRTIO_NET_F_CTRL_RX independent of
> each other, i.e. can you negotiate VIRTIO_NET_F_CTRL_RX_EXTRA but not
> VIRTIO_NET_F_CTRL_RX? Looks like it to me, but would like to confirm.
> (We would at most be able to add a SHOULD statement anyway.)
>

It seems to me that the features can work independently.

