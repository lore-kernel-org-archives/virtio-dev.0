Return-Path: virtio-dev-return-3385-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 8C8845818F5D
	for <virtio-dev@lists.oasis-open.org>; Fri,  2 Mar 2018 12:22:30 -0800 (PST)
Date: Fri, 2 Mar 2018 22:22:19 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180302222015-mutt-send-email-mst@kernel.org>
References: <cover.1519961667.git.jbaron@akamai.com>
 <c9d3cf2fbc3c64bb28e0438185d85d95b2088127.1519961667.git.jbaron@akamai.com>
 <7fc612d0-9610-9b07-d054-bb1438898f47@redhat.com>
 <c01a1ccd-a864-00a8-edf9-4a16c5dd6c32@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c01a1ccd-a864-00a8-edf9-4a16c5dd6c32@akamai.com>
Subject: [virtio-dev] Re: [PATCH 4/4] virtio-net: add linkspeed and duplex settings to
 virtio-net
To: Jason Baron <jbaron@akamai.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Mar 02, 2018 at 11:59:00AM -0500, Jason Baron wrote:
> On 03/02/2018 02:14 AM, Jason Wang wrote:
> > 
> > 
> > On 2018年03月02日 11:46, Jason Baron wrote:
> >> Although linkspeed and duplex can be set in a linux guest via 'ethtool
> >> -s',
> >> this requires custom ethtool commands for virtio-net by default.
> >>
> >> Introduce a new feature flag, VIRTIO_NET_F_SPEED_DUPLEX, which allows
> >> the hypervisor to export a linkspeed and duplex setting. The user can
> >> subsequently overwrite it later if desired via: 'ethtool -s'.
> >>
> >> Linkspeed and duplex settings can be set as:
> >> '-device virtio-net,speed=10000,duplex=full'
> > 
> > I was thinking whether or not it's better to decide the duplex by the
> > type of backends.
> > 
> > E.g userspace and vhost-kernel implement a in fact half duplex. But dpdk
> > implement a full duplex.
> 
> Interesting - could this be derived only from the backend 'type'. IE:
> NET_CLIENT_DRIVER_TAP, NET_CLIENT_DRIVER_VHOST_USER...
> 
> 
> I was also thinking this could be specified as 'duplex=backend', in
> addition to the proposed 'duplex=full' or 'duplex=half'?
> 
> Thanks,
> 
> -Jason

I'd say it would make more sense to teach backends to obey what's
specified by the user. E.g. if vhost gets a duplex config,
create two threads.

But I think all that's for future, we can just fake it for
now - the current uses don't seem to particularly care about whether
virtio actually is or isn't a duplex.



> > 
> > Thanks
> > 
> >>
> >> where speed is [0...INT_MAX], and duplex is ["half"|"full"].
> >>
> >> Signed-off-by: Jason Baron<jbaron@akamai.com>
> >> Cc: "Michael S. Tsirkin"<mst@redhat.com>
> >> Cc: Jason Wang<jasowang@redhat.com>
> >> Cc:virtio-dev@lists.oasis-open.org
> >> ---
> > 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

