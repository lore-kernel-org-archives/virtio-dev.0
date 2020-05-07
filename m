Return-Path: virtio-dev-return-7265-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id DC666985E38
	for <virtio-dev@lists.oasis-open.org>; Thu,  7 May 2020 12:11:44 +0000 (UTC)
Date: Thu, 7 May 2020 08:11:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200507080849-mutt-send-email-mst@kernel.org>
References: <20200507103119.11219-1-david@redhat.com>
 <20200507103119.11219-8-david@redhat.com>
 <20200507064558-mutt-send-email-mst@kernel.org>
 <a915653f-232e-aa13-68f7-f988704fa84c@redhat.com>
 <441bfb92-ecfa-f54e-3661-b219ea166e55@redhat.com>
 <20200507073408-mutt-send-email-mst@kernel.org>
 <3bed2d1d-d94a-45ca-afe3-5e6ee660b0fc@redhat.com>
MIME-Version: 1.0
In-Reply-To: <3bed2d1d-d94a-45ca-afe3-5e6ee660b0fc@redhat.com>
Subject: [virtio-dev] Re: [PATCH v3 07/15] mm/memory_hotplug: Introduce
 offline_and_remove_memory()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Michal Hocko <mhocko@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Oscar Salvador <osalvador@suse.com>, Pavel Tatashin <pasha.tatashin@soleen.com>, Wei Yang <richard.weiyang@gmail.com>, Dan Williams <dan.j.williams@intel.com>, Qian Cai <cai@lca.pw>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, May 07, 2020 at 01:37:30PM +0200, David Hildenbrand wrote:
> On 07.05.20 13:34, Michael S. Tsirkin wrote:
> > On Thu, May 07, 2020 at 01:33:23PM +0200, David Hildenbrand wrote:
> >>>> I get:
> >>>>
> >>>> error: sha1 information is lacking or useless (mm/memory_hotplug.c).
> >>>> error: could not build fake ancestor
> >>>>
> >>>> which version is this against? Pls post patches on top of some tag
> >>>> in Linus' tree if possible.
> >>>
> >>> As the cover states, latest linux-next. To be precise
> >>>
> >>> commit 6b43f715b6379433e8eb30aa9bcc99bd6a585f77 (tag: next-20200507,
> >>> next/master)
> >>> Author: Stephen Rothwell <sfr@canb.auug.org.au>
> >>> Date:   Thu May 7 18:11:31 2020 +1000
> >>>
> >>>     Add linux-next specific files for 20200507
> >>>
> >>
> >> The patches seem to apply cleanly on top of
> >>
> >> commit a811c1fa0a02c062555b54651065899437bacdbe (linus/master)
> >> Merge: b9388959ba50 16f8036086a9
> >> Author: Linus Torvalds <torvalds@linux-foundation.org>
> >> Date:   Wed May 6 20:53:22 2020 -0700
> >>
> >>     Merge git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net
> >=20
> > Because you have the relevant hashes in your git tree not pruned yet.
> > Do a new clone and they won't apply.
> >=20
>=20
> Yeah, most probably, it knows how to merge. I'm used to sending all my
> -mm stuff based on -next, so this here is different.


Documentation/process/5.Posting.rst addresses this:


Patches must be prepared against a specific version of the kernel.  As a
general rule, a patch should be based on the current mainline as found in
Linus's git tree.  When basing on mainline, start with a well-known release
point - a stable or -rc release - rather than branching off the mainline at
an arbitrary spot.

It may become necessary to make versions against -mm, linux-next, or a
subsystem tree, though, to facilitate wider testing and review.  Depending
on the area of your patch and what is going on elsewhere, basing a patch
against these other trees can require a significant amount of work
resolving conflicts and dealing with API changes.





> I'll wait a bit and then send v4 based on latest linus/master, adding
> the two acks and reshuffling the MAINTAINERS patch. Thanks.
>=20
> --=20
> Thanks,
>=20
> David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

