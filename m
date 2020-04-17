Return-Path: virtio-dev-return-7117-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 02739986077
	for <virtio-dev@lists.oasis-open.org>; Fri, 17 Apr 2020 10:09:47 +0000 (UTC)
References: <20200416192809.8763.19308.stgit@localhost.localdomain>
 <20200416180845-mutt-send-email-mst@kernel.org>
 <CAKgT0UfWHHyCekU+dReNfhAa6u6FNbm7Ff5wmyN58d1VymmAMA@mail.gmail.com>
 <20200417021335-mutt-send-email-mst@kernel.org>
 <08d2c4e2-8c0f-7d3c-89f1-0e6c6a2756c8@redhat.com>
 <20200417044641-mutt-send-email-mst@kernel.org>
 <0f867029-aef4-72b9-356f-ec25c265db1b@redhat.com>
 <20200417051223-mutt-send-email-mst@kernel.org>
 <3447361c-4d07-1785-c59b-8c98ddaebd92@redhat.com>
 <20200417055217-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1823d9be-d175-6cb5-0c7d-8a68d959a0d5@redhat.com>
Date: Fri, 17 Apr 2020 12:09:38 +0200
MIME-Version: 1.0
In-Reply-To: <20200417055217-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Subject: Re: [virtio-dev] Re: [PATCH] virtio-balloon: Disable free page
 hinting/reporting if page poison is disabled
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, Jason Wang <jasowang@redhat.com>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

 > What do you call "hinting ends" though? The fact we put
> a page in the VQ is not a guarantee that it's been consumed
> by the hypervisor.
>=20

I'd say hinting ends once the hypervisor sets FREE_PAGE_REPORT_S_DONE.

>=20
> I think a strict definition is this:
> - hint includes a command ID
> - hint implies "page was unused at some point after guest reading command=
 ID"
>=20
>=20
> Hypervisor can use dirty tracking tricks to get from that to
> "page is unused at the moment".
>=20
>> Whereby X is
>> currently assumed to be 0, correct?
>=20
>=20
>=20
> Now we are talking about what's safe to do with the page.
>=20
> If POISON flag is set by hypervisor but clear by guest,
> or poison_val is 0, then it's clear it's safe to blow
> away the page if we can figure out it's unused.
>=20
> Otherwise, it's much less clear :)

Hah! Agreed :D

>=20
>=20
>=20
> I'll have to come back and re-read the rest next week, this
> is complex stuff and I'm too rushed with other things today.

Yeah, I'm also loaded with other stuff. Maybe Alex has time to
understand the details as well.

--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

