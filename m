Return-Path: virtio-dev-return-7181-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id C9B89985BA9
	for <virtio-dev@lists.oasis-open.org>; Mon, 27 Apr 2020 15:09:50 +0000 (UTC)
References: <20200424162103.6681.436.stgit@localhost.localdomain>
 <31bc73ea-5d33-a79d-5f30-dc91b85f9b63@redhat.com>
 <CAKgT0UfhH3pyOqaTcO3yyEE94NsFkgZvVzNDNsyyVqNDgHzGdQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9d92de1d-5af5-e8e6-23b9-e61d34bbf677@redhat.com>
Date: Mon, 27 Apr 2020 17:09:37 +0200
MIME-Version: 1.0
In-Reply-To: <CAKgT0UfhH3pyOqaTcO3yyEE94NsFkgZvVzNDNsyyVqNDgHzGdQ@mail.gmail.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v2] virtio-balloon: Disable free page reporting if page
 poison reporting is not enabled
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 27.04.20 16:58, Alexander Duyck wrote:
> On Mon, Apr 27, 2020 at 1:08 AM David Hildenbrand <david@redhat.com> wrot=
e:
>>
>> On 24.04.20 18:24, Alexander Duyck wrote:
>>> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>
>>> We should disable free page reporting if page poisoning is enabled in t=
he
>>> kernel but we cannot report it via the balloon interface. This way we c=
an
>>> avoid the possibility of corrupting guest memory. Normally the page poi=
son
>>> reporting feature should always be present when free page reporting is
>>> enabled on the hypervisor, however this allows us to correctly handle a
>>> case of the virtio-balloon device being possibly misconfigured.
>>>
>>> Fixes: 5d757c8d518d ("virtio-balloon: add support for providing free pa=
ge reports to host")
>>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>> ---
>>>
>>> Changes since v1:
>>> Originally this patch also modified free page hinting, that has been re=
moved.
>>> Updated patch title and description.
>>> Added a comment explaining reasoning for disabling free page reporting.
>>>
>>>  drivers/virtio/virtio_balloon.c |    9 ++++++++-
>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_ba=
lloon.c
>>> index 51086a5afdd4..1f157d2f4952 100644
>>> --- a/drivers/virtio/virtio_balloon.c
>>> +++ b/drivers/virtio/virtio_balloon.c
>>> @@ -1107,11 +1107,18 @@ static int virtballoon_restore(struct virtio_de=
vice *vdev)
>>>
>>>  static int virtballoon_validate(struct virtio_device *vdev)
>>>  {
>>> -     /* Tell the host whether we care about poisoned pages. */
>>> +     /*
>>> +      * Inform the hypervisor that our pages are poisoned or
>>> +      * initialized. If we cannot do that then we should disable
>>> +      * page reporting as it could potentially change the contents
>>> +      * of our free pages.
>>> +      */
>>>       if (!want_init_on_free() &&
>>>           (IS_ENABLED(CONFIG_PAGE_POISONING_NO_SANITY) ||
>>>            !page_poisoning_enabled()))
>>>               __virtio_clear_bit(vdev, VIRTIO_BALLOON_F_PAGE_POISON);
>>> +     else if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON))
>>> +             __virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
>>>
>>>       __virtio_clear_bit(vdev, VIRTIO_F_IOMMU_PLATFORM);
>>>       return 0;
>>>
>>
>> Did you see my feedback on v1?
>>
>> https://www.spinics.net/lists/linux-virtualization/msg42783.html
>>
>> In case of want_init_on_free(), we don't really need VIRTIO_BALLOON_F_PA=
GE_POISON.
>=20
> I believe we do. We had discussions earlier in which Michael had
> mentioned that the guest should not assume implementation details of
> the host/hypervisor.

We can simply document this, as I suggested already ("either the old
page, or a page filled with zero"). Perfectly fine IMHO.

>=20
> The PAGE_POISON feature is being used to indicate that we expect the
> page to contain a certain value when it is returned to us. With the
> current implementation in QEMU if that value is zero we can work with
> it because that is the effect that MADV_DONTNEED has. However if there
> were some other effect being used by QEMU we would want to know that
> the guest is expecting us to write a 0 page. So I believe it makes
> sense to inform the hypervisor that we are doing something that
> expects us to fill the page with zeros in the case of

Informing makes sense, yes. And we inform it via the poison feature, if
possible. This discussion is about "what happens if the poison feature
is not there, but we do have want_init_on_free()."

> want_init_on_free rather than not providing that information to QEMU.
> This way, if in the future we decide to change the implementation in
> some way that might effect the value contained in the pages, we might

If the hypervisor can no longer guarantee "either the old page, or a
page filled with zero", it would have to disable the feature. I don't
see that happening, really.

> have the flexibility to identify the want_init_on_free case so we can
> work around it.

I don't have a too strong opinion here, but this sounds like one of the
improvements we wanted to have for free page hinting, but learned that
it's not possible because it was *underspecified*.


--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

