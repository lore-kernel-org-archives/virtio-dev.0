Return-Path: <mst@redhat.com>
Date: Fri, 24 Feb 2023 03:04:30 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v9] virtio-net: support inner header hash
Message-ID: <20230224030306-mutt-send-email-mst@kernel.org>
References: <20230218143715.841-1-hengqi@linux.alibaba.com>
 <20230223080358-mutt-send-email-mst@kernel.org>
 <73668f4f-2a69-d132-51a1-d1a160c0ee08@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <73668f4f-2a69-d132-51a1-d1a160c0ee08@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Parav Pandit <parav@nvidia.com>, Jason Wang <jasowang@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>, Cornelia Huck <cohuck@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, ailan@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Feb 24, 2023 at 12:42:40PM +0800, Heng Qi wrote:
> 
> 
> 在 2023/2/23 下午9:13, Michael S. Tsirkin 写道:
> > On Sat, Feb 18, 2023 at 10:37:15PM +0800, Heng Qi wrote:
> > > +\subparagraph{Security risks between encapsulated packets and RSS}
> > > +There may be potential security risks when encapsulated packets using RSS to
> > > +select queues for placement.
> > Is this just with RSS? I assume hash calculation is also used for
> > something like queueing so there's a similar risk even just
> > with hash reporting, no?
> 
> I don't understand why it would be risky to just report hash when not used
> for queuing,
> and even we don't report whether hash come from inner or outer now because
> there is no more hash_report_tunnel.

Well what is the hash used for? Presumably it's used for queueing within
driver, no? Collisions there then have exactly the same effect as queue
collisions in the device.

> > 
> > > When a user inside a tunnel tries to control the
> > > +enqueuing of encapsulated packets, then the user can flood the device with invaild
> > > +packets, and the flooded packets may be hashed into the same queue as packets in
> > > +other normal tunnels, which causing the queue to overflow.
> > > +
> > > +This can pose several security risks:
> > > +\begin{itemize}
> > > +\item  Encapsulated packets in the normal tunnels cannot be enqueued due to queue
> > > +       overflow, resulting in a large amount of packet loss.
> > > +\item  The delay and retransmission of packets in the normal tunnels are extremely increased.
> > > +\item  The user can observe the traffic information and enqueue information of other normal
> > > +       tunnels, and conduct targeted DoS attacks.
> > > +\end{\itemize}
> > > +
> > 
> > So for RSS specifically, we brain-stormed with Amnon (Cc'd) and came
> > up with an idea: RSS indirection table entries are 16 bit but
> > onlu 15 bits are used to indentify an RX queue.
> > We can use the remaining bit as a "tunnel bit" to signal whether to use the
> > inner or the outer hash for queue selection.
> > 
> > The lookup will work like this then:
> > 
> > calculate outer hash
> > if (rss[outer hash] & tunnel bit)
> 
> How a tunnel bit distinguishes between multiple tunnel types, and I think it
> is not so reasonable to use the
> indirection table to determine the switch of the inner hash. The inner hash
> is only the ability to calculate the hash,
> and does not involve the indirection table.
> 
> Thanks.
> 
> > then
> > 	calculate inner hash
> > 	return rss[inner hash] & ~tunnel bit
> > else
> > 	return rss[outer hash]
> > 
> > 
> > this fixes the security issue returning us back to
> > status quo : specific tunnels can be directed to separate queues.
> > 
> > 
> > This is for RSS.
> > 
> > 
> > For hash reporting indirection table is not used.
> > Maybe it is enough to signal to driver that inner hash was used.
> > We do need that signalling though.
> > 
> > My question would be whether it's practical to implement in hardware.
> > 

