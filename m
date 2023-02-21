Return-Path: <mst@redhat.com>
Date: Tue, 21 Feb 2023 16:46:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v9] virtio-net: support inner header hash
Message-ID: <20230221163930-mutt-send-email-mst@kernel.org>
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
 <PH0PR12MB5481224CBC059BD482347133DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230221115147-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815A89628D17FA1F455F2BDCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230221161551-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812CB5FBE771428A1D06BFDCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54812CB5FBE771428A1D06BFDCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 21, 2023 at 09:36:06PM +0000, Parav Pandit wrote:
> > So you are saying either live with the problem (this is best effort yes?) 
> Yes to best effort usage.

For sure something can be done to mitigate? How about randomizing the
key for example? That's in just like 1 minute of thinking. I am guessing
more can be done.


> > 
> > 
> > > > > > +\item  The user can observe the traffic information and enqueue
> > > > > > +information
> > > > > > of other normal
> > > > > > +       tunnels, and conduct targeted DoS attacks.
> > > > > Once hash_report_tunnel_types is removed, this second attack is no
> > > > > longer
> > > > applicable.
> > > > > Hence, please remove this too.
> > > >
> > > >
> > > > ?
> > > > I don't get how removing a field helps DoS.
> > > >
> > > I meant for the "observe and enqueue" part of the tunnel as not applicable.
> > 
> > Sorry still don't get it :( I don't know what is the "observe and enqueue" part of
> > the tunnel and what is not applicable. But maybe Heng Qi does.
> > 
> Tunnel type such as vxlan/gre etc is not placed in the virtio_net_hdr.
> This way the net_hdr doesn't leak such information to upper layer drivers as it cannot observe it.

What is this information driver can't observe? It sees all the packets
after all, we are not stripping tunneling headers.
I also don't really know what are upper layer drivers - for sure
layering of drivers is not covered in the spec for now so I am not sure
what do you mean by that.  The risk I mentioned is leaking the
information *on the network*.




> > > > \begin{lstlisting}  struct virtio_net_rss_config {
> > > > > >      le32 hash_types;
> > > > > > +    le32 hash_tunnel_types;
> > > > > This field is not needed as device config space advertisement for
> > > > > the support
> > > > is enough.
> > > > >
> > > > > If the intent is to enable hashing for the specific tunnel(s), an
> > > > > individual
> > > > command is better.
> > > >
> > > > new command? I am not sure why we want that. why not handle tunnels
> > > > like we do other protocols?
> > >
> > > I didn't follow.
> > > We probably discussed in another thread that to set M bits, it is wise to avoid
> > setting N other bits just to keep the command happy, where N >>> M and these
> > N have a very strong relation in hw resource setup and packet steering.
> > > Any examples of 'other protocols'?
> > 
> > #define VIRTIO_NET_HASH_TYPE_IPv4              (1 << 0)
> > #define VIRTIO_NET_HASH_TYPE_TCPv4             (1 << 1)
> > #define VIRTIO_NET_HASH_TYPE_UDPv4             (1 << 2)
> > 
> > this kind of thing.
> > 
> > I don't see how a tunnel is different fundamentally. Why does it need its own
> > field?
> 
> Driver is in control to enable/disable tunnel based inner hash acceleration only when its needed.
> This way certain data path hw parsers can be enabled/disabled.
> Without this it will be always enabled even if there may not be any user of it.
> Device has scope to optimize this flow.

I feel you misunderstand the question. Or maybe I misunderstand what you
are proposing.  So tunnels need their own bits. But why a separate field
and not just more bits along the existing ones?

-- 
MST

