Return-Path: <mst@redhat.com>
Date: Tue, 21 Feb 2023 18:18:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v9] virtio-net: support inner header hash
Message-ID: <20230221180945-mutt-send-email-mst@kernel.org>
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
 <PH0PR12MB5481224CBC059BD482347133DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230221115147-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54815A89628D17FA1F455F2BDCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230221161551-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54812CB5FBE771428A1D06BFDCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230221163930-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54816DA52C42EE769C4CBAF4DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54816DA52C42EE769C4CBAF4DCA59@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Jason Wang <jasowang@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 21, 2023 at 10:32:11PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Tuesday, February 21, 2023 4:46 PM
> > 
> > What is this information driver can't observe? It sees all the packets after all,
> > we are not stripping tunneling headers.
> Just the tunnel type.
> If/when that tunnel header is stripped, it gets complicated where tunnel type is still present in the virtio_net_hdr because hash_report_tunnel feature bit is negotiated.

whoever strips off the tunnel has I imagine strip off the virtio net hdr
too - everything else in it such as gso type refers to the outer packet.

> > I also don't really know what are upper layer drivers - for sure layering of
> > drivers is not covered in the spec for now so I am not sure what do you mean by
> > that.  The risk I mentioned is leaking the information *on the network*.
> > 
> Got it.
> 
> > 
> > 
> > 
> > > > > > \begin{lstlisting}  struct virtio_net_rss_config {
> > > > > > > >      le32 hash_types;
> > > > > > > > +    le32 hash_tunnel_types;
> > > > > > > This field is not needed as device config space advertisement
> > > > > > > for the support
> > > > > > is enough.
> > > > > > >
> > > > > > > If the intent is to enable hashing for the specific tunnel(s),
> > > > > > > an individual
> > > > > > command is better.
> > > > > >
> > > > > > new command? I am not sure why we want that. why not handle
> > > > > > tunnels like we do other protocols?
> > > > >
> > > > > I didn't follow.
> > > > > We probably discussed in another thread that to set M bits, it is
> > > > > wise to avoid
> > > > setting N other bits just to keep the command happy, where N >>> M
> > > > and these N have a very strong relation in hw resource setup and packet
> > steering.
> > > > > Any examples of 'other protocols'?
> > > >
> > > > #define VIRTIO_NET_HASH_TYPE_IPv4              (1 << 0)
> > > > #define VIRTIO_NET_HASH_TYPE_TCPv4             (1 << 1)
> > > > #define VIRTIO_NET_HASH_TYPE_UDPv4             (1 << 2)
> > > >
> > > > this kind of thing.
> > > >
> > > > I don't see how a tunnel is different fundamentally. Why does it
> > > > need its own field?
> > >
> > > Driver is in control to enable/disable tunnel based inner hash acceleration
> > only when its needed.
> > > This way certain data path hw parsers can be enabled/disabled.
> > > Without this it will be always enabled even if there may not be any user of it.
> > > Device has scope to optimize this flow.
> > 
> > I feel you misunderstand the question. Or maybe I misunderstand what you are
> > proposing.  So tunnels need their own bits. But why a separate field and not just
> > more bits along the existing ones?
> 
> Because the hashing is not covering the outer header contents.
> 
> We may be still not discussing the same.
> So let me refresh the context.
> 
> The question of discussion was,
> Scenario:
> 1. device advertises the ability to hash on the inner packet header.
> 2. device prefers that driver enable it only when it needs to use this extra packet parser in hardware.
> 
> There are 3 options.
> a. Because the feature is negotiated, it means it is enabled for all the tunnel types.
> Pros:
> 1. No need to extend cvq cmd.
> Cons:
> 1. device parser is always enabled, and the driver never uses it. This may result in inferior rx performance.
> 
> b. Since the feature is useful in a narrow case of sw-based vxlan etc driver, better not to enable hw for it.
> Hence, have the knob to explicitly enable in hw.
> So have the cvq command.
> b.1 should it be combined with the existing command?
> Cons:
> a. when the driver wants to enable hash on inner, it needs to supply the exact same RSS config as before. Sw overhead with no gain.
> b. device needs to parse new command value, compare with old config, and drop the RSS config, just enable inner hashing hw parser.
> Or destroy the old rss config and re-apply. This results in weird behavior for the short interval with no apparent gain.
>
> b.2 should it be on its own command?
> Pros:
> a. device and driver doesn't need to bother about b.1.a and b.1.b.
> b. still benefits from not always enabling hw parser, as this is not a common case.
> c. has the ability to enable when needed.

I prefer b.1. With reporting of the tunnel type gone I don't see a
fundamental difference between hashing over tunneling types and other
protocol types we support.  It's just a flag telling device over which
bits to calculate the hash. We don't have a separate command for hashing
of TCPv6, why have it for vxlan?  Extending with more HASH_TYPE makes
total sense to me, seems to fit better with the existing design and will
make patch smaller.


-- 
MST

