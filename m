Return-Path: virtio-dev-return-3384-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id B7E805818F64
	for <virtio-dev@lists.oasis-open.org>; Fri,  2 Mar 2018 12:19:56 -0800 (PST)
Date: Fri, 2 Mar 2018 22:19:42 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180302221831-mutt-send-email-mst@kernel.org>
References: <cover.1519961667.git.jbaron@akamai.com>
 <c9d3cf2fbc3c64bb28e0438185d85d95b2088127.1519961667.git.jbaron@akamai.com>
 <7fc612d0-9610-9b07-d054-bb1438898f47@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7fc612d0-9610-9b07-d054-bb1438898f47@redhat.com>
Subject: [virtio-dev] Re: [PATCH 4/4] virtio-net: add linkspeed and duplex settings to
 virtio-net
To: Jason Wang <jasowang@redhat.com>
Cc: Jason Baron <jbaron@akamai.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Mar 02, 2018 at 03:14:01PM +0800, Jason Wang wrote:
> 
> 
> On 2018年03月02日 11:46, Jason Baron wrote:
> > Although linkspeed and duplex can be set in a linux guest via 'ethtool -s',
> > this requires custom ethtool commands for virtio-net by default.
> > 
> > Introduce a new feature flag, VIRTIO_NET_F_SPEED_DUPLEX, which allows
> > the hypervisor to export a linkspeed and duplex setting. The user can
> > subsequently overwrite it later if desired via: 'ethtool -s'.
> > 
> > Linkspeed and duplex settings can be set as:
> > '-device virtio-net,speed=10000,duplex=full'
> 
> I was thinking whether or not it's better to decide the duplex by the type
> of backends.
> 
> E.g userspace and vhost-kernel implement a in fact half duplex. But dpdk
> implement a full duplex.
> 
> Thanks

OTOH it's a priority for some people to be able to support migration
between different backend types. Breaking that won't be nice.

> > 
> > where speed is [0...INT_MAX], and duplex is ["half"|"full"].
> > 
> > Signed-off-by: Jason Baron<jbaron@akamai.com>
> > Cc: "Michael S. Tsirkin"<mst@redhat.com>
> > Cc: Jason Wang<jasowang@redhat.com>
> > Cc:virtio-dev@lists.oasis-open.org
> > ---

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

