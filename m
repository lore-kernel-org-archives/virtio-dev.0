Return-Path: <hengqi@linux.alibaba.com>
Date: Thu, 9 Feb 2023 14:05:07 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
Subject: Re: [virtio-dev] Re: [virtio-comment] RE: [virtio-dev] Re:
 [virtio-comment] Re: [PATCH v7] virtio-net: support inner header hash
Message-ID: <20230209060507.GB77861@h68b04307.sqa.eu95>
References: <5bee268d-a0dc-d649-4174-7b211a49e2f0@linux.alibaba.com>
 <PH0PR12MB5481CA073B96CC2828F8AA15DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <52ddcc45-70e0-a670-9ac2-215e84eb12ba@linux.alibaba.com>
 <PH0PR12MB5481F054A6BA5C10831F0AA8DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208082210-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481A88AC7D4CA548F95FA95DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208083938-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CA102D99F708E3B198D1DCD89@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230208090304-mutt-send-email-mst@kernel.org>
 <20230209051252.GA77861@h68b04307.sqa.eu95>
MIME-Version: 1.0
In-Reply-To: <20230209051252.GA77861@h68b04307.sqa.eu95>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, yuri.benditovich@daynix.com, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 09, 2023 at 01:12:52PM +0800, Heng Qi wrote:
> On Wed, Feb 08, 2023 at 09:09:15AM -0500, Michael S. Tsirkin wrote:
> > On Wed, Feb 08, 2023 at 02:00:14PM +0000, Parav Pandit wrote:
> > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > Sent: Wednesday, February 8, 2023 8:52 AM
> > > > 
> > > > On Wed, Feb 08, 2023 at 01:38:36PM +0000, Parav Pandit wrote:
> > > > >
> > > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > > Sent: Wednesday, February 8, 2023 8:32 AM
> > > > > >
> > > > > > On Wed, Feb 08, 2023 at 05:18:32AM +0000, Parav Pandit wrote:
> > > > > > > > From: Heng Qi <hengqi@linux.alibaba.com>
> > > > > > > > Sent: Tuesday, February 7, 2023 10:25 PM
> > > > > > >
> > > > > > > [..]
> > > > > > > > >>
> > > > > > > > >> Do you think we need both hash_types and hash_tunnel_types?
> > > > > > > > > In struct virtio_net_config we need two fields.
> > > > > > > > > a. supported_hash_types (already exists) b.
> > > > > > > > > supported_hash_tunnel_type
> > > > > > > > > -> bitmap indicating for which outer headers, inner hash
> > > > > > > > > -> calculation is
> > > > > > > > supported.
> > > > > > > >
> > > > > > > > Thanks for the suggestion, we seem to have reached an agreement.
> > > > > > > >
> > > > > > > > >
> > > > > > > > > In struct virtio_net_hdr we need two fields.
> > > > > > > > > a. hash_report (already exists) b. hash_tunnel_type 8 bits ->
> > > > > > > > > absolute value indicating which outer header
> > > > > > > > exists when inner header hash calculated.
> > > > > > > > > You already have it in your patch named as hash_report_tunnel.
> > > > > > > > > May be better to name as hash_report_tunnel_type to make it
> > > > > > > > > clearer that its
> > > > > > > > type.
> > > > > > > >
> > > > > > > > Sure.
> > > > > > > >
> > > > > > > > Thanks for your reply.
> > > > > > >
> > > > > > > I had one last question. Why do we need to inform the
> > > > > > hash_report_tunnel_type of the outer header in the virtio_net_hdr?
> > > > > > > Is this for debug? Or is there a use case that will process this value?
> > > > > >
> > > > > > Well we have hash_report which is kind of similar (and also kind of
> > > > > > pointless but I think it's there because WHQL wants it).
> > > > > Hash_report is useful. It tells hash_value is in which namespace (ipv4-tcp/ipv4
> > > > udp etc).
> > > > > OS can use this value to find tcp connection in a given namespace.
> > > > >
> > > > > > Maybe we can steal some bits
> > > > > > from there instead of a new field?
> > > > > >
> > > > > I do not have problem adding extra bits. I just don't find that just telling that
> > > > its vxlan or nvgre to the OS is useful.
> > > > > If OS needs to know about outer header details, it needs to know the VNI
> > > > information than just telling vxlan.
> > > > 
> > > > This does make sense.
> > > > 
> > > > 
> > > > > >
> > > > > > I have a follow up question though: are we only hashing the inner
> > > > > > header or both inner and outer header? Somewhat confused on this.
> > > > > >
> > > > > I understood as inner header. But worth to describe it. May be there. Need to
> > > > read v8 patch.
> > > > 
> > > > Hmm. I just realized that there's a security problem with hashing just the inner
> > > > header: it allow users inside the tunnel control queueing outside.
> > > > By observing packet loss some information leaks between tunnels.
> > > > 
> > > I likely didn't understand. Can you please explain?
> > > 
> > > Queuing is always done on the inner header with/without encapsulation.
> > > Hash is always reported for inner header.
> > > It is only adding the ability to hash even when outer header exists.
> > 
> > 
> > If hashing just on outer header (currently the only option) then
> > a given tunnel all lands in a given queue.
> > Just keep that queue separate and users of this tunnel can not
> > learn whether other queues are overflowing, and can not overflow
> > other queues.
> > 
> 
> 
> This is not a problem with the inner hash, it is a general problem with the outer hash.
> I communicated with our people who are doing cloud security (they are also one of the demanders of inner hash),
> and it is a common problem for one tunnel to attack another tunnel, which has nothing to do with inner hash or outer hash.
> 
> For example, there is a tunnel t1; a tunnel t2; a tunnel endpoint VTEP0, and the vni id of t1 is id1, and the vni id of v2 is id2; a VM.
> 
>                                   -----------
>                Tunnel t1          |         |
> VTEP_1 <=======================> (vni id1)  |
>                                   |         |
> 								  |   VTEP0 | ======================> VM
>                Tunnel t2          |         |
> VTEP_2 <=======================> (vni id2)  |
> 								  -----------

The description graph should look like this:

                                  -----------
               Tunnel t1          |         |
VTEP_1 <=======================> (vni id1)  |
                                  |         |
                                  |   VTEP  | ======================> VM
               Tunnel t2          |         |
VTEP_2 <=======================> (vni id2)  |
                                  -----------

> 
> At this time, regardless of the inner hash or the outer hash, the traffic of tunnel t1 and tunnel t2 will reach the VM
> through VTEP0 (whether it is a single queue or multiple queues), and may be placed on the same queue to cause queue overflow.
> Some current forwarding tools such as DPDK have good forwarding performance, and it is difficult to fill up the queue; or
> switch the attack traffic to the attack clusters; or connect the traffic of different tunnels to different network card ports or network devices.
> 
> Thanks.
> 
> > 
> > If you hash inner header then user can flood device with
> > packets of a given connection and the same connection in a different
> > tunnel hashes to the same queue. Now one tunnel can
> > - cause DoS for another tunnel
> > - cause packet loss or latency triggering possible security bugs within guest
> > - detect that another tunnel is using the connection by
> >   detecting its own packet loss or increased latency
> > 
> > 
> > 
> > 
> > > If queuing to be decided based on outer header (hash), then that is different.
> > > Hashing both inner and outer in a flat q structure unlikely works, right?
> > > Because both hashes can result in different q selection.
> > 
> > 
> > That's the point.
> > 
> > Is there any precedent in OSes for configuring things like this
> > that we can look at?
> > 
> > 
> > > > 
> > > > Ideas for solving this they all involve hashing both inner and outer
> > > > header:
> > > > 1- report two sets of hashes. overkill?
> > > > 2- hash both headers together
> > > > 2- add salt. can come from driver or device itself
> > > > 
> > > > More ideas?
> > > > 
> > > > --
> > > > MST
> > 
> > 
> > This publicly archived list offers a means to provide input to the
> > OASIS Virtual I/O Device (VIRTIO) TC.
> > 
> > In order to verify user consent to the Feedback License terms and
> > to minimize spam in the list archive, subscription is required
> > before posting.
> > 
> > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > List help: virtio-comment-help@lists.oasis-open.org
> > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> > Committee: https://www.oasis-open.org/committees/virtio/
> > Join OASIS: https://www.oasis-open.org/join/
> 
> ---------------------------------------------------------------------
> To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
> For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

