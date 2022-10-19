Return-Path: <xuanzhuo@linux.alibaba.com>
Message-ID: <1666146893.4959266-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [virtio-dev] [PATCH 0/2] introduce virtio-ism: internal shared memory device
Date: Wed, 19 Oct 2022 10:34:53 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20221017074724.89569-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuh0N5sQ1K2Bk70Z-CrQSFb8ttp9vBG+tMypg3pAB0Mpg@mail.gmail.com>
In-Reply-To: <CACGkMEuh0N5sQ1K2Bk70Z-CrQSFb8ttp9vBG+tMypg3pAB0Mpg@mail.gmail.com>
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: Jason Wang <jasowang@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, gerry@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, 17 Oct 2022 16:17:31 +0800, Jason Wang <jasowang@redhat.com> wrote:


Hi Jason,

I think there may be some problems with the direction we are discussing. Our
goal is to add an new ism device. As far as the spec is concerned, we are not
concerned with the implementation of the backend.

The direction we should discuss is what is the difference between the ism device
and other devices such as virtio-net, and whether it is necessary to introduce
this new device. How to share the backend with other deivce is another problem.

Our goal is to dynamically obtain a piece of memory to share with other vms.

In a connection, this memory will be used repeatedly. As far as SMC is concerned,
it will use it as a ring. Of course, we also need a notify mechanism.

That's what we're aiming for, so we should first discuss whether this
requirement is reasonable. I think it's a feature currently not supported by
other devices specified by the current virtio spce.

Thanks.


