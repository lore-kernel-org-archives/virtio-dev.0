Return-Path: virtio-dev-return-7118-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9803F986077
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Apr 2020 10:19:44 +0000 (UTC)
Date: Fri, 17 Apr 2020 06:19:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20200417061815-mutt-send-email-mst@kernel.org>
References: <20200416180845-mutt-send-email-mst@kernel.org>
 <CAKgT0UfWHHyCekU+dReNfhAa6u6FNbm7Ff5wmyN58d1VymmAMA@mail.gmail.com>
 <20200417021335-mutt-send-email-mst@kernel.org>
 <08d2c4e2-8c0f-7d3c-89f1-0e6c6a2756c8@redhat.com>
 <20200417044641-mutt-send-email-mst@kernel.org>
 <0f867029-aef4-72b9-356f-ec25c265db1b@redhat.com>
 <20200417051223-mutt-send-email-mst@kernel.org>
 <3447361c-4d07-1785-c59b-8c98ddaebd92@redhat.com>
 <20200417055217-mutt-send-email-mst@kernel.org>
 <1823d9be-d175-6cb5-0c7d-8a68d959a0d5@redhat.com>
MIME-Version: 1.0
In-Reply-To: <1823d9be-d175-6cb5-0c7d-8a68d959a0d5@redhat.com>
Subject: Re: [virtio-dev] Re: [PATCH] virtio-balloon: Disable free page
 hinting/reporting if page poison is disabled
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
To: David Hildenbrand <david@redhat.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, Jason Wang <jasowang@redhat.com>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Apr 17, 2020 at 12:09:38PM +0200, David Hildenbrand wrote:
>  > What do you call "hinting ends" though? The fact we put
> > a page in the VQ is not a guarantee that it's been consumed
> > by the hypervisor.
> >=20
>=20
> I'd say hinting ends once the hypervisor sets FREE_PAGE_REPORT_S_DONE.

Can't find that one anywhere. what did I miss?



> >=20
> > I think a strict definition is this:
> > - hint includes a command ID
> > - hint implies "page was unused at some point after guest reading comma=
nd ID"
> >=20
> >=20
> > Hypervisor can use dirty tracking tricks to get from that to
> > "page is unused at the moment".
> >=20
> >> Whereby X is
> >> currently assumed to be 0, correct?
> >=20
> >=20
> >=20
> > Now we are talking about what's safe to do with the page.
> >=20
> > If POISON flag is set by hypervisor but clear by guest,
> > or poison_val is 0, then it's clear it's safe to blow
> > away the page if we can figure out it's unused.
> >=20
> > Otherwise, it's much less clear :)
>=20
> Hah! Agreed :D
>=20
> >=20
> >=20
> >=20
> > I'll have to come back and re-read the rest next week, this
> > is complex stuff and I'm too rushed with other things today.
>=20
> Yeah, I'm also loaded with other stuff. Maybe Alex has time to
> understand the details as well.
>=20
> --=20
> Thanks,
>=20
> David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

