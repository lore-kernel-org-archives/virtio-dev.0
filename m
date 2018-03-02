Return-Path: virtio-dev-return-3365-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 98EA25818EF8
	for <virtio-dev@lists.oasis-open.org>; Thu,  1 Mar 2018 23:14:24 -0800 (PST)
References: <cover.1519961667.git.jbaron@akamai.com>
 <c9d3cf2fbc3c64bb28e0438185d85d95b2088127.1519961667.git.jbaron@akamai.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7fc612d0-9610-9b07-d054-bb1438898f47@redhat.com>
Date: Fri, 2 Mar 2018 15:14:01 +0800
MIME-Version: 1.0
In-Reply-To: <c9d3cf2fbc3c64bb28e0438185d85d95b2088127.1519961667.git.jbaron@akamai.com>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH 4/4] virtio-net: add linkspeed and duplex settings to
 virtio-net
To: Jason Baron <jbaron@akamai.com>, mst@redhat.com
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>



On 2018年03月02日 11:46, Jason Baron wrote:
> Although linkspeed and duplex can be set in a linux guest via 'ethtool -s',
> this requires custom ethtool commands for virtio-net by default.
>
> Introduce a new feature flag, VIRTIO_NET_F_SPEED_DUPLEX, which allows
> the hypervisor to export a linkspeed and duplex setting. The user can
> subsequently overwrite it later if desired via: 'ethtool -s'.
>
> Linkspeed and duplex settings can be set as:
> '-device virtio-net,speed=10000,duplex=full'

I was thinking whether or not it's better to decide the duplex by the 
type of backends.

E.g userspace and vhost-kernel implement a in fact half duplex. But dpdk 
implement a full duplex.

Thanks

>
> where speed is [0...INT_MAX], and duplex is ["half"|"full"].
>
> Signed-off-by: Jason Baron<jbaron@akamai.com>
> Cc: "Michael S. Tsirkin"<mst@redhat.com>
> Cc: Jason Wang<jasowang@redhat.com>
> Cc:virtio-dev@lists.oasis-open.org
> ---


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

