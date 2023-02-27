Return-Path: <mst@redhat.com>
Date: Mon, 27 Feb 2023 02:39:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v9] virtio-net: support inner header hash
Message-ID: <20230227023657-mutt-send-email-mst@kernel.org>
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
 <20230221124518-mutt-send-email-mst@kernel.org>
 <4d123e32-1ad0-e692-7fa6-0565eb34c487@redhat.com>
 <0f53212f-a89b-ad3c-73e3-a7a7b5533058@linux.alibaba.com>
 <1047920c-5dd5-8f31-0c4c-a108f36155f8@redhat.com>
 <20230223075934-mutt-send-email-mst@kernel.org>
 <CACGkMEvc2Px_Zz11R5QYwMXYm_j5rsYV2LrZt5yf8tZQxuT_Bg@mail.gmail.com>
 <20230224030509-mutt-send-email-mst@kernel.org>
 <CACGkMEuOu=6qKQO2TJ0B6ZLRH_-rGtZMYVtw7gn+BFbnJgWkrw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuOu=6qKQO2TJ0B6ZLRH_-rGtZMYVtw7gn+BFbnJgWkrw@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 27, 2023 at 12:07:17PM +0800, Jason Wang wrote:
> Btw, this kind of 1:1 hash features seems not scalable and flexible.
> It requires an endless extension on bits/fields. Modern NICs allow the
> user to customize the hash calculation, for virtio-net we can allow to
> use eBPF program to classify the packets. It seems to be more flexible
> and scalable and there's almost no maintain burden in the spec (only
> bytecode is required, no need any fancy features/interactions like
> maps), easy to be migrated etc.
> 
> Prototype is also easy, tun/tap had an eBPF classifier for years.
> 
> Thanks

Yea BPF offload would be great to have. We have been discussing it for
years though - security issues keep blocking it. *Maybe* it's finally
going to be there but I'm not going to block this work waiting for BPF
offload.  And easily migrated is what BPF is not.

-- 
MST

