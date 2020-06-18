Return-Path: virtio-dev-return-7489-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D51C79860D0
	for <virtio-dev@lists.oasis-open.org>; Thu, 18 Jun 2020 20:20:56 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Date: Thu, 18 Jun 2020 22:20:51 +0200
Message-Id: <B304BB6D-DBDB-4C36-B376-896945E5AE6D@redhat.com>
References: <CAKgT0UfgyVyfLSg1dZejUR0g6znijY+dRyW_TAFJMZU+qXK+UQ@mail.gmail.com>
In-Reply-To: <CAKgT0UfgyVyfLSg1dZejUR0g6znijY+dRyW_TAFJMZU+qXK+UQ@mail.gmail.com>
Subject: [virtio-dev] Re: [PATCH v25 QEMU 3/3] virtio-balloon: Replace free page hinting references to 'report' with 'hint'
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, "Wang, Wei W" <wei.w.wang@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

>=20
>> 2. Unclear semantics. Alex tried to document what the actual semantics
>> of hinted pages are. Assume the following in the guest to a previously
>> hinted page
>>=20
>> /* page was hinted and is reused now */
>> if (page[x] !=3D Y)
>>        page[x] =3D=3D Y;
>> /* migration ends, we now run on the destination */
>> BUG_ON(page[x] !=3D Y);
>> /* BUG, because the content chan
>>=20
>> A guest can observe that. And that could be a random driver that just
>> allocated a page.
>>=20
>> (I *assume* in Linux we might catch that using kasan, but I am not 100%
>> sure, also, the actual semantics to document are unclear - e.g., for
>> other guests)
>>=20
>> As Alex mentioned, it is not even guaranteed in QEMU that we receive a
>> zero page on the destination, it could also be something else (e.g.,
>> previously migrated values).
>=20
> So this is only an issue for pages that are pushed out of the balloon
> as a part of the shrinker process though. So fixing it would be pretty
> straightforward as we would just have to initialize or at least dirty
> pages that are leaked as a part of the shrinker. That may have an
> impact on performance though as it would result in us dirtying pages
> that are freed as a result of the shrinker being triggered.
>=20

It really depends on the desired semantics, which are unclear because there=
 is no doc/spec. Either QEMU is buggy or the kernel is buggy.

>> 3. If I am not wrong, the iothread works in
>> virtio_ballloon_get_free_page_hints() on the virtqueue only with holding
>> the free_page_lock (no BQL).
>>=20
>> Assume we're migrating, the iothread is active, and the guest triggers a
>> device reset.
>>=20
>> virtio_balloon_device_reset() will trigger a
>> virtio_balloon_free_page_stop(s). That won't actually wait for the
>> iothread to stop, it will only temporarily lock free_page_lock and
>> update s->free_page_report_status.
>>=20
>> I think there can be a race between the device reset and the iothread.
>> Once virtio_balloon_free_page_stop() returned,
>> virtio_ballloon_get_free_page_hints() can still call
>> - virtio_queue_set_notification(vq, 0);
>> - virtio_queue_set_notification(vq, 1);
>> - virtio_notify(vdev, vq);
>> - virtqueue_pop()
>>=20
>> I doubt this is very nice.
>=20
> And our conversation had me start looking though reference to
> virtio_balloon_free_page_stop. It looks like we call it for when we
> unrealize the device or reset the device. It might make more sense for
> us to look at pushing the status to DONE and forcing the iothread to
> be flushed out.
>=20
>> There are other concerns I had regarding the iothread (e.g., while
>> reporting is active, virtio_ballloon_get_free_page_hints() is
>> essentially a busy loop, in contrast to documented -
>> continue_to_get_hints will always be true).
>>=20
>>> The appeal of hinting is that it's 0 overhead outside migration,
>>> and pains were taken to avoid keeping pages locked while
>>> hypervisor is busy.
>>>=20
>>> If we are to drop hinting completely we need to show that reporting
>>> can be comparable, and we'll probably want to add a mode for
>>> reporting that behaves somewhat similarly.
>>=20
>> Depends on the actual users. If we're dropping a feature that nobody is
>> actively using, I don't think we have to show anything.
>>=20
>> This feature obviously saw no proper review.
>=20
> I'm pretty sure it had some, as it went through several iterations as
> I recall. However I don't think the review of the virtio interface was
> very detailed as I think most of the attention was on the kernel
> interface.

Yes, that=E2=80=98s what I meant. The kernel side and the migration code (Q=
EMU) got a lot of attention.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

