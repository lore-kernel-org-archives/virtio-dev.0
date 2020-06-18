Return-Path: virtio-dev-return-7485-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E9DD1985F03
	for <virtio-dev@lists.oasis-open.org>; Thu, 18 Jun 2020 17:10:52 +0000 (UTC)
References: <20200527041212.12700.60627.stgit@localhost.localdomain>
 <20200527041414.12700.50293.stgit@localhost.localdomain>
 <CAKgT0UdPC1s0c-wqsNc4x8DeZhtZQVMmLArWQ=Z345Mkof650Q@mail.gmail.com>
 <4f37c184-cf62-5711-a737-925533b52d73@redhat.com>
 <CAKgT0Udmxjx66hEhDyqWS1wBkAfEf_hht8FZAOuh3NMDOAOR3w@mail.gmail.com>
 <aea3b6e6-f653-dd0c-5e17-d0c948a6af4b@redhat.com>
 <20200618120121-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1ee4f06d-f0bb-4155-ee82-1d56c346e2a0@redhat.com>
Date: Thu, 18 Jun 2020 19:10:43 +0200
MIME-Version: 1.0
In-Reply-To: <20200618120121-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v25 QEMU 3/3] virtio-balloon: Replace free page hinting
 references to 'report' with 'hint'
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alexander Duyck <alexander.duyck@gmail.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

>>
>> Ugh, ...
>>
>> @MST, you might have missed that in another discussion, what's your
>> general opinion about removing free page hinting in QEMU (and Linux)? We
>> keep finding issues in the QEMU implementation, including non-trivial
>> ones, and have to speculate about the actual semantics. I can see that
>> e.g., libvirt does not support it yet.
>=20
> Not maintaining two similar features sounds attractive.

I consider free page hinting (in QEMU) to be in an unmaintainable state
(and it looks like Alex and I are fixing a feature we don't actually
intend to use / not aware of users). In contrast to that, the free page
reporting functionality/implementation is a walk in the park.

>=20
> I'm still trying to get my head around the list of issues.  So far they
> all look kind of minor to me.  Would you like to summarize them
> somewhere?

Some things I still have in my mind


1. If migration fails during RAM precopy, the guest will never receive a
DONE notification. Probably easy to fix.

2. Unclear semantics. Alex tried to document what the actual semantics
of hinted pages are. Assume the following in the guest to a previously
hinted page

/* page was hinted and is reused now */
if (page[x] !=3D Y)
=09page[x] =3D=3D Y;
/* migration ends, we now run on the destination */
BUG_ON(page[x] !=3D Y);
/* BUG, because the content chan

A guest can observe that. And that could be a random driver that just
allocated a page.

(I *assume* in Linux we might catch that using kasan, but I am not 100%
sure, also, the actual semantics to document are unclear - e.g., for
other guests)

As Alex mentioned, it is not even guaranteed in QEMU that we receive a
zero page on the destination, it could also be something else (e.g.,
previously migrated values).

3. If I am not wrong, the iothread works in
virtio_ballloon_get_free_page_hints() on the virtqueue only with holding
the free_page_lock (no BQL).

Assume we're migrating, the iothread is active, and the guest triggers a
device reset.

virtio_balloon_device_reset() will trigger a
virtio_balloon_free_page_stop(s). That won't actually wait for the
iothread to stop, it will only temporarily lock free_page_lock and
update s->free_page_report_status.

I think there can be a race between the device reset and the iothread.
Once virtio_balloon_free_page_stop() returned,
virtio_ballloon_get_free_page_hints() can still call
- virtio_queue_set_notification(vq, 0);
- virtio_queue_set_notification(vq, 1);
- virtio_notify(vdev, vq);
- virtqueue_pop()

I doubt this is very nice.

There are other concerns I had regarding the iothread (e.g., while
reporting is active, virtio_ballloon_get_free_page_hints() is
essentially a busy loop, in contrast to documented -
continue_to_get_hints will always be true).

> The appeal of hinting is that it's 0 overhead outside migration,
> and pains were taken to avoid keeping pages locked while
> hypervisor is busy.
>=20
> If we are to drop hinting completely we need to show that reporting
> can be comparable, and we'll probably want to add a mode for
> reporting that behaves somewhat similarly.

Depends on the actual users. If we're dropping a feature that nobody is
actively using, I don't think we have to show anything.

This feature obviously saw no proper review.

--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

