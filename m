Return-Path: virtio-dev-return-7472-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id D7F4E985EFE
	for <virtio-dev@lists.oasis-open.org>; Thu, 18 Jun 2020 12:54:45 +0000 (UTC)
References: <20200527041212.12700.60627.stgit@localhost.localdomain>
 <20200527041414.12700.50293.stgit@localhost.localdomain>
 <CAKgT0UdPC1s0c-wqsNc4x8DeZhtZQVMmLArWQ=Z345Mkof650Q@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <4f37c184-cf62-5711-a737-925533b52d73@redhat.com>
Date: Thu, 18 Jun 2020 14:54:36 +0200
MIME-Version: 1.0
In-Reply-To: <CAKgT0UdPC1s0c-wqsNc4x8DeZhtZQVMmLArWQ=Z345Mkof650Q@mail.gmail.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v25 QEMU 3/3] virtio-balloon: Replace free page hinting
 references to 'report' with 'hint'
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Alexander Duyck <alexander.duyck@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 13.06.20 22:07, Alexander Duyck wrote:
> On Tue, May 26, 2020 at 9:14 PM Alexander Duyck
> <alexander.duyck@gmail.com> wrote:
>>
>> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>
>> In an upcoming patch a feature named Free Page Reporting is about to be
>> added. In order to avoid any confusion we should drop the use of the wor=
d
>> 'report' when referring to Free Page Hinting. So what this patch does is=
 go
>> through and replace all instances of 'report' with 'hint" when we are
>> referring to free page hinting.
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>> ---
>>  hw/virtio/virtio-balloon.c         |   78 ++++++++++++++++++-----------=
-------
>>  include/hw/virtio/virtio-balloon.h |   20 +++++----
>>  2 files changed, 49 insertions(+), 49 deletions(-)
>>
>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
>> index 3e2ac1104b5f..dc15409b0bb6 100644
>> --- a/hw/virtio/virtio-balloon.c
>> +++ b/hw/virtio/virtio-balloon.c
>=20
> ...
>=20
>> @@ -817,14 +817,14 @@ static int virtio_balloon_post_load_device(void *o=
paque, int version_id)
>>      return 0;
>>  }
>>
>> -static const VMStateDescription vmstate_virtio_balloon_free_page_report=
 =3D {
>> +static const VMStateDescription vmstate_virtio_balloon_free_page_hint =
=3D {
>>      .name =3D "virtio-balloon-device/free-page-report",
>>      .version_id =3D 1,
>>      .minimum_version_id =3D 1,
>>      .needed =3D virtio_balloon_free_page_support,
>>      .fields =3D (VMStateField[]) {
>> -        VMSTATE_UINT32(free_page_report_cmd_id, VirtIOBalloon),
>> -        VMSTATE_UINT32(free_page_report_status, VirtIOBalloon),
>> +        VMSTATE_UINT32(free_page_hint_cmd_id, VirtIOBalloon),
>> +        VMSTATE_UINT32(free_page_hint_status, VirtIOBalloon),
>>          VMSTATE_END_OF_LIST()
>>      }
>>  };
>=20
> So I noticed this patch wasn't in the list of patches pulled, but that
> is probably for the best since I believe the change above might have
> broken migration as VMSTATE_UINT32 does a stringify on the first
> parameter.

Indeed, it's the name of the vmstate field. But I don't think it is
relevant for migration. It's and indicator if a field is valid and it's
used in traces/error messages.

See git grep "field->name"

I don't think renaming this is problematic. Can you rebase and resent?
Thanks!

> Any advice on how to address it, or should I just give up on renaming
> free_page_report_cmd_id and free_page_report_status?
>=20
> Looking at this I wonder why we even need to migrate these values? It
> seems like if we are completing a migration the cmd_id should always
> be "DONE" shouldn't it? It isn't as if we are going to migrate the

The *status* should be DONE IIUC. The cmd_id might be relevant, no? It's
always incremented until it wraps.

> hinting from one host to another. We will have to start over which is
> essentially the signal that the "DONE" value provides. Same thing for
> the status. We shouldn't be able to migrate unless both of these are
> already in the "DONE" state so if anything I wonder if we shouldn't
> have that as the initial state for the device and just drop the
> migration info.

We'll have to glue that to a compat machine unfortunately, so we can
just keep migrating it ... :(


--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

