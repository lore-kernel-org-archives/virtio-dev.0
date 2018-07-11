Return-Path: virtio-dev-return-4687-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8DEA6985B2D
	for <virtio-dev@lists.oasis-open.org>; Wed, 11 Jul 2018 13:56:02 +0000 (UTC)
From: "Wang, Wei W" <wei.w.wang@intel.com>
Date: Wed, 11 Jul 2018 13:55:15 +0000
Message-ID: <286AC319A985734F985F78AFA26841F7396EEFD8@SHSMSX101.ccr.corp.intel.com>
References: <1531215067-35472-1-git-send-email-wei.w.wang@intel.com>
 <1531215067-35472-2-git-send-email-wei.w.wang@intel.com>
 <CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com>
 <5B455D50.90902@intel.com>
 <CA+55aFzqj8wxXnHAdUTiOomipgFONVbqKMjL_tfk7e5ar1FziQ@mail.gmail.com>
 <20180711092152.GE20050@dhcp22.suse.cz> <5B45E17D.2090205@intel.com>
 <20180711110949.GJ20050@dhcp22.suse.cz>
In-Reply-To: <20180711110949.GJ20050@dhcp22.suse.cz>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [virtio-dev] RE: [PATCH v35 1/5] mm: support to get hints of free page blocks
To: Michal Hocko <mhocko@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, virtualization <virtualization@lists.linux-foundation.org>, KVM list <kvm@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, "Michael S. Tsirkin" <mst@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Paolo Bonzini <pbonzini@redhat.com>, "liliang.opensource@gmail.com" <liliang.opensource@gmail.com>, "yang.zhang.wz@gmail.com" <yang.zhang.wz@gmail.com>, "quan.xu0@gmail.com" <quan.xu0@gmail.com>, "nilal@redhat.com" <nilal@redhat.com>, Rik van Riel <riel@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wednesday, July 11, 2018 7:10 PM, Michal Hocko wrote:
> On Wed 11-07-18 18:52:45, Wei Wang wrote:
> > On 07/11/2018 05:21 PM, Michal Hocko wrote:
> > > On Tue 10-07-18 18:44:34, Linus Torvalds wrote:
> > > [...]
> > > > That was what I tried to encourage with actually removing the
> > > > pages form the page list. That would be an _incremental_
> > > > interface. You can remove MAX_ORDER-1 pages one by one (or a
> > > > hundred at a time), and mark them free for ballooning that way.
> > > > And if you still feel you have tons of free memory, just continue
> removing more pages from the free list.
> > > We already have an interface for that. alloc_pages(GFP_NOWAIT,
> MAX_ORDER -1).
> > > So why do we need any array based interface?
> >
> > Yes, I'm trying to get free pages directly via alloc_pages, so there
> > will be no new mm APIs.
>=20
> OK. The above was just a rough example. In fact you would need a more
> complex gfp mask. I assume you only want to balloon only memory directly
> usable by the kernel so it will be
> 	(GFP_KERNEL | __GFP_NOWARN) & ~__GFP_RECLAIM

Sounds good to me, thanks.

>=20
> > I plan to let free page allocation stop when the remaining system free
> > memory becomes close to min_free_kbytes (prevent swapping).
>=20
> ~__GFP_RECLAIM will make sure you are allocate as long as there is any
> memory without reclaim. It will not even poke the kswapd to do the
> background work. So I do not think you would need much more than that.

"close to min_free_kbytes" - I meant when doing the allocations, we intenti=
onally reserve some small amount of memory, e.g. 2 free page blocks of "MAX=
_ORDER - 1". So when other applications happen to do some allocation, they =
may easily get some from the reserved memory left on the free list. Without=
 that reserved memory, other allocation may cause the system free memory be=
low the WMARK[MIN], and kswapd would start to do swapping. This is actually=
 just a small optimization to reduce the probability of causing swapping (n=
ice to have, but not mandatary because we will allocate free page blocks on=
e by one).

 > But let me note that I am not really convinced how this (or previous)
> approach will really work in most workloads. We tend to cache heavily so
> there is rarely any memory free.

With less free memory, the improvement becomes less, but should be nicer th=
an no optimization. For example, the Linux build workload would cause 4~5 G=
B (out of 8GB) memory to be used as page cache at the final stage, there is=
 still ~44% live migration time reduction.

Since we have many cloud customers interested in this feature, I think we c=
an let them test the usefulness.

Best,
Wei

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

