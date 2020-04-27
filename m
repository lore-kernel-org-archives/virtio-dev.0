Return-Path: virtio-dev-return-7187-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 114F8985BA9
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Apr 2020 16:07:30 +0000 (UTC)
References: <20200424162103.6681.436.stgit@localhost.localdomain>
 <31bc73ea-5d33-a79d-5f30-dc91b85f9b63@redhat.com>
 <CAKgT0UfhH3pyOqaTcO3yyEE94NsFkgZvVzNDNsyyVqNDgHzGdQ@mail.gmail.com>
 <9d92de1d-5af5-e8e6-23b9-e61d34bbf677@redhat.com>
 <CAKgT0UcEUnT1_VEp4ByzcF38jxg7yPUqsZ6VKDUm82HKhHZSwA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <ba763509-566e-1862-431d-5c746517b11d@redhat.com>
Date: Mon, 27 Apr 2020 18:07:10 +0200
MIME-Version: 1.0
In-Reply-To: <CAKgT0UcEUnT1_VEp4ByzcF38jxg7yPUqsZ6VKDUm82HKhHZSwA@mail.gmail.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v2] virtio-balloon: Disable free page reporting if page
 poison reporting is not enabled
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

>>>
>>> The PAGE_POISON feature is being used to indicate that we expect the
>>> page to contain a certain value when it is returned to us. With the
>>> current implementation in QEMU if that value is zero we can work with
>>> it because that is the effect that MADV_DONTNEED has. However if there
>>> were some other effect being used by QEMU we would want to know that
>>> the guest is expecting us to write a 0 page. So I believe it makes
>>> sense to inform the hypervisor that we are doing something that
>>> expects us to fill the page with zeros in the case of
>>
>> Informing makes sense, yes. And we inform it via the poison feature, if
>> possible. This discussion is about "what happens if the poison feature
>> is not there, but we do have want_init_on_free()."
>=20
> My preference is to err on the side of caution.  I view want_init_on
> free() as equivalent to page_poison_enabled with
> CONFIG_PAGE_POISONING_ZERO and treated the same way. So if we are
> going to let one by then we would want to let the other by as well.
>=20

Agreed.

>>> want_init_on_free rather than not providing that information to QEMU.
>>> This way, if in the future we decide to change the implementation in
>>> some way that might effect the value contained in the pages, we might
>>
>> If the hypervisor can no longer guarantee "either the old page, or a
>> page filled with zero", it would have to disable the feature. I don't
>> see that happening, really.
>=20
> My concern is we can never see how things might be used in the future.
> The advantage of setting the poison feature flag and leaving the value
> as 0 is that it indicates that we are strictly expecting a zero page
> versus allowing the page to contain some other content. I'm expecting
> that in most cases that we should see that the page poisoning feature
> will be present if page reporting is present so my thought is it is
> safer to put the limitation on the guest rather than on the host as it
> allows us more flexibility for future implementations.
>=20

I consider it very unlikely that you want to provide something else than
- the old page
- a zeroed page

But yes, while having VIRTIO_BALLOON_F_REPORTING &&
!VIRTIO_BALLOON_F_PAGE_POISON in QEMU as of now would be possible, it's
unlikely that we'll see this very often. Similar to want_init_on_free()

>>> have the flexibility to identify the want_init_on_free case so we can
>>> work around it.
>>
>> I don't have a too strong opinion here, but this sounds like one of the
>> improvements we wanted to have for free page hinting, but learned that
>> it's not possible because it was *underspecified*.
>=20
> Right. For free page hinting it is underspecified. By defining a tight
> relationship between free page reporting and page poison we might be
> able to better handle those sorts of cases. I suspect there may be
> interest in having free page reporting eventually take on many of the
> responsibilities of free page hinting as it doesn't have the extra
> complication of having to consume all of the guests memory. If we
> dictate that free page reporting has to have a very clear definition
> in relation to any page initialization it lays the groundwork for us
> to be able to eventually handle those kind of cases.
I would encourage you to document the semantics of free page reporting
properly - especially, that we decided that the content of a reported
page with VIRTIO_BALLOON_F_REPORTING && !VIRTIO_BALLOON_F_PAGE_POISON is
*undefined* and needs a reinit. Only with VIRTIO_BALLOON_F_REPORTING &&
VIRTIO_BALLOON_F_PAGE_POISON the content is either the old page content
or a page filled with poison_val.

So take my

Acked-by: David Hildenbrand <david@redhat.com>

--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

