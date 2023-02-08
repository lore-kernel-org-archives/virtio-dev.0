Return-Path: <mst@redhat.com>
Date: Wed, 8 Feb 2023 09:10:09 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-comment] RE: [virtio-dev] Re: [virtio-comment] Re:
 [PATCH v7] virtio-net: support inner header hash
Message-ID: <20230208090936-mutt-send-email-mst@kernel.org>
References: <f7e5a6c8-ad4c-c60c-2d9e-cd64f6fdd90e@redhat.com>
 <20230131052834.GA34480@h68b04307.sqa.eu95>
 <5bee268d-a0dc-d649-4174-7b211a49e2f0@linux.alibaba.com>
 <PH0PR12MB5481CA073B96CC2828F8AA15DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <52ddcc45-70e0-a670-9ac2-215e84eb12ba@linux.alibaba.com>
 <PH0PR12MB5481F054A6BA5C10831F0AA8DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208082210-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481A88AC7D4CA548F95FA95DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208083938-mutt-send-email-mst@kernel.org>
 <PH0PR12MB54813DBBE112FC0E35B59E67DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54813DBBE112FC0E35B59E67DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Feb 08, 2023 at 02:05:52PM +0000, Parav Pandit wrote:
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Wednesday, February 8, 2023 8:52 AM
> > 
> > On Wed, Feb 08, 2023 at 01:38:36PM +0000, Parav Pandit wrote:
> > >
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Wednesday, February 8, 2023 8:32 AM
> > > >
> > > > On Wed, Feb 08, 2023 at 05:18:32AM +0000, Parav Pandit wrote:
> > > > > > From: Heng Qi <hengqi@linux.alibaba.com>
> > > > > > Sent: Tuesday, February 7, 2023 10:25 PM
> > > > >
> > > > > [..]
> > > > > > >>
> > > > > > >> Do you think we need both hash_types and hash_tunnel_types?
> > > > > > > In struct virtio_net_config we need two fields.
> > > > > > > a. supported_hash_types (already exists) b.
> > > > > > > supported_hash_tunnel_type
> > > > > > > -> bitmap indicating for which outer headers, inner hash
> > > > > > > -> calculation is
> > > > > > supported.
> > > > > >
> > > > > > Thanks for the suggestion, we seem to have reached an agreement.
> > > > > >
> > > > > > >
> > > > > > > In struct virtio_net_hdr we need two fields.
> > > > > > > a. hash_report (already exists) b. hash_tunnel_type 8 bits ->
> > > > > > > absolute value indicating which outer header
> > > > > > exists when inner header hash calculated.
> > > > > > > You already have it in your patch named as hash_report_tunnel.
> > > > > > > May be better to name as hash_report_tunnel_type to make it
> > > > > > > clearer that its
> > > > > > type.
> > > > > >
> > > > > > Sure.
> > > > > >
> > > > > > Thanks for your reply.
> > > > >
> > > > > I had one last question. Why do we need to inform the
> > > > hash_report_tunnel_type of the outer header in the virtio_net_hdr?
> > > > > Is this for debug? Or is there a use case that will process this value?
> > > >
> > > > Well we have hash_report which is kind of similar (and also kind of
> > > > pointless but I think it's there because WHQL wants it).
> > > Hash_report is useful. It tells hash_value is in which namespace (ipv4-tcp/ipv4
> > udp etc).
> > > OS can use this value to find tcp connection in a given namespace.
> > >
> > > > Maybe we can steal some bits
> > > > from there instead of a new field?
> > > >
> > > I do not have problem adding extra bits. I just don't find that just telling that
> > its vxlan or nvgre to the OS is useful.
> > > If OS needs to know about outer header details, it needs to know the VNI
> > information than just telling vxlan.
> > 
> > This does make sense.
> > 
> > 
> > > >
> > > > I have a follow up question though: are we only hashing the inner
> > > > header or both inner and outer header? Somewhat confused on this.
> > > >
> > > I understood as inner header. But worth to describe it. May be there. Need to
> > read v8 patch.
> > 
> > Hmm. I just realized that there's a security problem with hashing just the inner
> > header: it allow users inside the tunnel control queueing outside.
> > By observing packet loss some information leaks between tunnels.
> > 
> Ah I know now.
> We are leaking outer header information inside the virtio net hdr, and outer header might be already stripped off by a different entity.
> 
> I think the use case here is it's the same sw entity that owns the virtio net device does the encap/decap too.

No not exactly, we are leaking info between encap tunnels.

-- 
MST

