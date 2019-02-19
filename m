Return-Path: virtio-dev-return-5459-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7EE5E9812AE
	for <virtio-dev@lists.oasis-open.org>; Tue, 19 Feb 2019 14:27:48 +0000 (UTC)
Date: Tue, 19 Feb 2019 09:27:44 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190219092333-mutt-send-email-mst@kernel.org>
References: <20190211233612-mutt-send-email-mst@kernel.org>
 <02809024-c99c-caf5-5ec4-98ee96ca6cd5@solarflare.com>
 <20190212085415-mutt-send-email-mst@kernel.org>
 <15b8c0b7-643d-d9c2-f05c-0f5d8c8169c3@solarflare.com>
 <20190212122619-mutt-send-email-mst@kernel.org>
 <f120aec1-60d7-33e2-9188-4abbdd887532@redhat.com>
 <20190213121733-mutt-send-email-mst@kernel.org>
 <d01ae149-2074-fe50-5dc2-2c5f0391f624@redhat.com>
 <20190213224204-mutt-send-email-mst@kernel.org>
 <e6535c70-32ed-1213-3f2c-fcfc05ec107a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e6535c70-32ed-1213-3f2c-fcfc05ec107a@redhat.com>
Subject: Re: [virtio-dev] RFC: Doorbell suppression, packed-ring mode and
 hardware offload
To: Jason Wang <jasowang@redhat.com>
Cc: David Riddoch <driddoch@solarflare.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Feb 19, 2019 at 02:33:04PM +0800, Jason Wang wrote:
> 
> On 2019/2/14 下午12:04, Michael S. Tsirkin wrote:
> > On Thu, Feb 14, 2019 at 11:34:22AM +0800, Jason Wang wrote:
> > > On 2019/2/14 上午1:30, Michael S. Tsirkin wrote:
> > > > On Wed, Feb 13, 2019 at 06:33:50PM +0800, Jason Wang wrote:
> > > > > On 2019/2/13 上午1:35, Michael S. Tsirkin wrote:
> > > > > > On Tue, Feb 12, 2019 at 04:47:08PM +0000, David Riddoch wrote:
> > > > > > > > > > > I would prefer to have the write barrier before writing the idx.
> > > > > > > > > > Well that's driver overhead for something device might never utilise in
> > > > > > > > > > a given workload. If we are optimizing let's optimize for speed.
> > > > > > > > > I think doing the barrier before writing idx is best for speed (see below).
> > > > > > > > I don't see it below:(
> > > > > > > Sorry, I'm not being clear.  If the write barrier is before the idx, then a
> > > > > > > PV device can read the idx, do a single rmb and read a whole bunch of
> > > > > > > descriptors.  As things stand today a PV device has to do an rmb for each
> > > > > > > descriptor that it reads.
> > > > > > > 
> > > > > > > I'm not sure, but this may be what Jason meant when he said "prefetch".
> > > > > Yes.
> > > > > 
> > > > > 
> > > > > > Oh. Right. So for PV it's easy to convert an rmb to a data dependency
> > > > > > instead.  It remains to be seen whether an extra cache miss per
> > > > > > batch is cheaper or more expensive than such a dependency
> > > > > > per descriptor.
> > > > > > 
> > > > > > I hope Jason can experiment and let us know.
> > > > > > 
> > > > > > 
> > > > > To clarify, actually I did play someting like:
> > > > > 
> > > > > 
> > > > > if (desc_is_avail((last_avail + 32) % size))
> > > > > 
> > > > >       [last_avail, last_avail + 32] is avail [1]
> > > > > 
> > > > > else if (desc_is_avail(last_avail + 1) % size))
> > > > > 
> > > > >       last_avail is avail
> > > > > 
> > > > > else
> > > > > 
> > > > >      no new
> > > > > 
> > > > > 
> > > > > And looks like [1] depends on the driver to do:
> > > > > 
> > > > > for all descriptors
> > > > > 
> > > > >       update desc (but not make it available for the flag)
> > > > > 
> > > > > wmb()
> > > > > 
> > > > > for all descriptors
> > > > > 
> > > > >       update desc.flag
> > > > > 
> > > > > 
> > > > > This means if last_avail + 32 is avail, no need to check flags of
> > > > > [last_avail, last_avail + 31] since the descriptor content (except for the
> > > > > flag) is guaranteed to be correct.
> > > > We can try looking into that, sure. It's not just wmb though which is
> > > > anyway free on x86. There are cases of e.g. chained descriptors
> > > > to consider where we do not want device to see a partial chain.
> > > 
> > > If we saw the last descriptor is in a chain, it's still doesn't harm, just
> > > read more?
> > So it's possible to add a variant that sticks a wmb after each flag
> > update for sure. However if you are writing out batches that's an
> > upfront cost and what you gain is prefetch on the other side which is
> > speculative.
> 
> 
> Yes.
> 
> 
> > 
> > 
> > > > 
> > > > > I get ~10% PPS improvement.
> > > > > 
> > > > > Thanks
> > > > I suspect most of the gain isn't in the check at all though.
> > > 
> > > The gain was:
> > > 
> > > 1) batching reading descriptors, saving the times of userspace access
> > Yes that needs to be fixed. The way linux vhost driver does userspace
> > accesses right now with stac/clac and memory barriers within a loop is
> > plain silly.  Designing a host/guest interface to work around that kind
> > of inefficiency makes no sense, it's purely an implementation issue.
> 
> 
> Actually, it has other advantages, consider the case when driver is faster,
> batch reading may reduce the cache contention on the descriptor ring (when
> the ring is almost full).

A shared index implies always doing a cache miss though.
By comparison speculating a read ahead of a cache line
will sometimes bring you a cache.

> 
> > 
> > > 2) reduce the rmb(), otherwise you need rmb per descriptor
> > Well not really, you can
> > - validate a batch then do a single rmb
> > - replace rmb with a dependency
> > 
> > > > It's probably reading descriptors and maybe loop unrolling.
> > > 
> > > I'm not quite understand why unrolling help in this case.
> > The amount of operations in this loop is tiny but not tiny
> > enough for gcc to decide it's free. Take a look
> > 
> > 
> > #include <stdio.h>
> > 
> > struct desc {
> >          unsigned long long a;
> >          unsigned len;
> >          unsigned short type;
> >          unsigned short flags;
> > };
> > #ifdef UNROLL
> > __attribute__((optimize("unroll-loops")))
> > #endif
> > int foo(struct desc *desc)
> > {
> >       unsigned short aflags = 0xffff;
> >       unsigned short oflags = 0x0;
> > 
> >       int i;
> > 
> >          for (i=0; i < 4; ++i) {
> >               aflags &= desc[i].flags;
> >               oflags |= desc[i].flags;
> >          }
> > 
> >          return aflags == oflags;
> > }
> > 
> > $ gcc -Wall -DUNROLL -O2 -c l.c
> 
> 
> I think you mean without -DUNROLL.


Since there's a jump I think you are right.

> 
> > 
> > 0000000000000000 <foo>:
> > foo():
> >     0:   48 8d 47 0e             lea    0xe(%rdi),%rax
> >     4:   31 c9                   xor    %ecx,%ecx
> >     6:   48 83 c7 4e             add    $0x4e,%rdi
> >     a:   be ff ff ff ff          mov    $0xffffffff,%esi
> >     f:   0f b7 10                movzwl (%rax),%edx
> >    12:   48 83 c0 10             add    $0x10,%rax
> >    16:   21 d6                   and    %edx,%esi
> >    18:   09 d1                   or     %edx,%ecx
> >    1a:   48 39 f8                cmp    %rdi,%rax
> >    1d:   75 f0                   jne    f <foo+0xf>
> >    1f:   31 c0                   xor    %eax,%eax
> >    21:   66 39 ce                cmp    %cx,%si
> >    24:   0f 94 c0                sete   %al
> >    27:   c3                      retq
> > 
> > 
> > 
> > $ gcc -Wall -DUNROLL -O2 -c l.c
> > 
> > Disassembly of section .text:
> > 
> > 0000000000000000 <foo>:
> > foo():
> >     0:   0f b7 47 1e             movzwl 0x1e(%rdi),%eax
> >     4:   0f b7 77 2e             movzwl 0x2e(%rdi),%esi
> >     8:   0f b7 4f 0e             movzwl 0xe(%rdi),%ecx
> >     c:   89 c2                   mov    %eax,%edx
> >     e:   09 f0                   or     %esi,%eax
> >    10:   21 f2                   and    %esi,%edx
> >    12:   09 c8                   or     %ecx,%eax
> >    14:   21 ca                   and    %ecx,%edx
> >    16:   0f b7 4f 3e             movzwl 0x3e(%rdi),%ecx
> >    1a:   09 c8                   or     %ecx,%eax
> >    1c:   21 ca                   and    %ecx,%edx
> >    1e:   66 39 c2                cmp    %ax,%dx
> >    21:   0f 94 c0                sete   %al
> >    24:   0f b6 c0                movzbl %al,%eax
> >    27:   c3                      retq
> > 
> > 
> > See? gcc just does not unroll agressively enough.
> 
> 
> Ok, so this is just for avoiding branches.

Which is important for a variety of reasons, e.g. linux adds in tricks
to block speculation so branches might not be predicted even on intel.
A pipeline stall on each read isn't good for speed.

> 
> > 
> > > > Something like:
> > > > 
> > > > __attribute__((optimize("unroll-loops")))
> > > > bool fast_get_descriptors(vq, desc)
> > > > {
> > > > 
> > > > 	copy X descriptors
> > > > 	u16 aflags = 0xffff;
> > > > 	u16 oflags = 0x0;
> > > > 	for (i = 0; i < X; ++i) {
> > > > 		aflags &= desc[i].flags;
> > > > 		oflags |= desc[i].flags;
> > > > 	}
> > > > 	/* all flags must be same */
> > > > 	if (aflags != oflags)
> > > > 		return false;
> > > > 
> > > > 	return is_avail(vq->wrapcount, aflags);
> > > > }
> > > 
> > > This may work. It should be a little bit less efficient but without any
> > > assumption of driver if I understand correctly.
> > > 
> > > 
> > > > 
> > > > I also think 32 is very aggressive, I would start with 8.
> > > 
> > > Maybe, or adding some heuristic to predict it.
> > > 
> > > Thanks
> > The reason I say 8 is because it's two cache lines which
> > is typically what cpu pulls in anyway (1+linear pfetch).
> > Anything more might have more cost as it might
> > put more pressure on the cache. Further
> > static sized short loops can be unrolled by compiler if
> > you ask it nicely, which saves a bunch of branching,
> > speculation etc. Dynamic sized ones can't,
> > you end up with extra math and branches in the loop.
> 
> 
> You're probably right here, but need some benchmark to check.
> 
> Thanks
> 
> 
> > 
> > 
> > > > 
> > > > With above, you could try:
> > > > 
> > > > 	if (fast_get_descriptors(vq, desc))
> > > > 	     [last_avail, last_avail + 32] is avail [1]
> > > > 	else if (desc_is_avail(last_avail + 1) % size))
> > > > 	     last_avail is avail
> > > > 	 else
> > > >    	 	no new
> > > > 
> > > > 

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

