Return-Path: <virtio-dev-return-9789-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 636E89863BA
	for <virtio-dev@lists.oasis-open.org>; Tue, 16 Aug 2022 16:26:07 +0000 (UTC)
Date: Tue, 16 Aug 2022 02:29:53 +0000
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Message-ID: <YvsBIQU/DlHOpbEH@bullseye>
References: <cover.1660362668.git.bobby.eshleman@bytedance.com>
MIME-Version: 1.0
In-Reply-To: <cover.1660362668.git.bobby.eshleman@bytedance.com>
Subject: [virtio-dev] Re: [PATCH 0/6] virtio/vsock: introduce dgrams, sk_buff, and qdisc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Bobby Eshleman <bobby.eshleman@gmail.com>
Cc: virtio-dev@lists.oasis-open.org, Bobby Eshleman <bobby.eshleman@bytedance.com>, Cong Wang <cong.wang@bytedance.com>, Jiang Wang <jiang.wang@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Stephen Hemminger <sthemmin@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
List-ID: <virtio-dev.lists.oasis-open.org>

CC'ing virtio-dev@lists.oasis-open.org

On Mon, Aug 15, 2022 at 10:56:03AM -0700, Bobby Eshleman wrote:
> Hey everybody,
> 
> This series introduces datagrams, packet scheduling, and sk_buff usage
> to virtio vsock.
> 
> The usage of struct sk_buff benefits users by a) preparing vsock to use
> other related systems that require sk_buff, such as sockmap and qdisc,
> b) supporting basic congestion control via sock_alloc_send_skb, and c)
> reducing copying when delivering packets to TAP.
> 
> The socket layer no longer forces errors to be -ENOMEM, as typically
> userspace expects -EAGAIN when the sk_sndbuf threshold is reached and
> messages are being sent with option MSG_DONTWAIT.
> 
> The datagram work is based off previous patches by Jiang Wang[1].
> 
> The introduction of datagrams creates a transport layer fairness issue
> where datagrams may freely starve streams of queue access. This happens
> because, unlike streams, datagrams lack the transactions necessary for
> calculating credits and throttling.
> 
> Previous proposals introduce changes to the spec to add an additional
> virtqueue pair for datagrams[1]. Although this solution works, using
> Linux's qdisc for packet scheduling leverages already existing systems,
> avoids the need to change the virtio specification, and gives additional
> capabilities. The usage of SFQ or fq_codel, for example, may solve the
> transport layer starvation problem. It is easy to imagine other use
> cases as well. For example, services of varying importance may be
> assigned different priorities, and qdisc will apply appropriate
> priority-based scheduling. By default, the system default pfifo qdisc is
> used. The qdisc may be bypassed and legacy queuing is resumed by simply
> setting the virtio-vsock%d network device to state DOWN. This technique
> still allows vsock to work with zero-configuration.
> 
> In summary, this series introduces these major changes to vsock:
> 
> - virtio vsock supports datagrams
> - virtio vsock uses struct sk_buff instead of virtio_vsock_pkt
>   - Because virtio vsock uses sk_buff, it also uses sock_alloc_send_skb,
>     which applies the throttling threshold sk_sndbuf.
> - The vsock socket layer supports returning errors other than -ENOMEM.
>   - This is used to return -EAGAIN when the sk_sndbuf threshold is
>     reached.
> - virtio vsock uses a net_device, through which qdisc may be used.
>  - qdisc allows scheduling policies to be applied to vsock flows.
>   - Some qdiscs, like SFQ, may allow vsock to avoid transport layer congestion. That is,
>     it may avoid datagrams from flooding out stream flows. The benefit
>     to this is that additional virtqueues are not needed for datagrams.
>   - The net_device and qdisc is bypassed by simply setting the
>     net_device state to DOWN.
> 
> [1]: https://lore.kernel.org/all/20210914055440.3121004-1-jiang.wang@bytedance.com/
> 
> Bobby Eshleman (5):
>   vsock: replace virtio_vsock_pkt with sk_buff
>   vsock: return errors other than -ENOMEM to socket
>   vsock: add netdev to vhost/virtio vsock
>   virtio/vsock: add VIRTIO_VSOCK_F_DGRAM feature bit
>   virtio/vsock: add support for dgram
> 
> Jiang Wang (1):
>   vsock_test: add tests for vsock dgram
> 
>  drivers/vhost/vsock.c                   | 238 ++++----
>  include/linux/virtio_vsock.h            |  73 ++-
>  include/net/af_vsock.h                  |   2 +
>  include/uapi/linux/virtio_vsock.h       |   2 +
>  net/vmw_vsock/af_vsock.c                |  30 +-
>  net/vmw_vsock/hyperv_transport.c        |   2 +-
>  net/vmw_vsock/virtio_transport.c        | 237 +++++---
>  net/vmw_vsock/virtio_transport_common.c | 771 ++++++++++++++++--------
>  net/vmw_vsock/vmci_transport.c          |   9 +-
>  net/vmw_vsock/vsock_loopback.c          |  51 +-
>  tools/testing/vsock/util.c              | 105 ++++
>  tools/testing/vsock/util.h              |   4 +
>  tools/testing/vsock/vsock_test.c        | 195 ++++++
>  13 files changed, 1176 insertions(+), 543 deletions(-)
> 
> -- 
> 2.35.1
> 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

