Return-Path: <mst@redhat.com>
Date: Tue, 10 Jan 2023 00:57:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] Re: [virtio-comment] Re: [PATCH v7] virtio-net:
 support inner header hash
Message-ID: <20230110005158-mutt-send-email-mst@kernel.org>
References: <20230104071401.31746-1-hengqi@linux.alibaba.com>
 <20230106002431-mutt-send-email-mst@kernel.org>
 <20230106064221.GA61196@h68b04307.sqa.eu95>
 <20230106015425-mutt-send-email-mst@kernel.org>
 <20230109024341.GA85179@h68b04307.sqa.eu95>
 <CACGkMEv_dppsyTW3TC8xymjgjB0iLDessoj1nVkHmpME2ACbtA@mail.gmail.com>
 <20230109062943-mutt-send-email-mst@kernel.org>
 <CACGkMEvjo8t_MhEXvn_u3R827105E1nHDRWku9j1ARWfH7yUPA@mail.gmail.com>
 <20230110002017-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230110002017-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 10, 2023 at 12:25:02AM -0500, Michael S. Tsirkin wrote:
> > This will give extra pressure on the management stack, e.g it requires
> > the device to have an out of spec way for introspection.
> > 
> > Thanks
> 
> As I tried to explain this is already the case. Feature bits do not
> describe device capabilities fully, some of them are in config space.

To be precise, this does not necessarily require introspection, but
it does require management control over config space
such as supported hash types just like it has control over feature bits.
E.g. QEMU currently seems to hard-code these to
#define VIRTIO_NET_RSS_SUPPORTED_HASHES (VIRTIO_NET_RSS_HASH_TYPE_IPv4 | \
                                         VIRTIO_NET_RSS_HASH_TYPE_TCPv4 | \
                                         VIRTIO_NET_RSS_HASH_TYPE_UDPv4 | \
                                         VIRTIO_NET_RSS_HASH_TYPE_IPv6 | \
                                         VIRTIO_NET_RSS_HASH_TYPE_TCPv6 | \
                                         VIRTIO_NET_RSS_HASH_TYPE_UDPv6 | \
                                         VIRTIO_NET_RSS_HASH_TYPE_IP_EX | \
                                         VIRTIO_NET_RSS_HASH_TYPE_TCP_EX | \
                                         VIRTIO_NET_RSS_HASH_TYPE_UDP_EX)

but there's no reason not to give management control over these.

-- 
MST

