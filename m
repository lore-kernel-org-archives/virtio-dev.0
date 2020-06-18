Return-Path: virtio-dev-return-7483-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BFEE0985F02
	for <virtio-dev@lists.oasis-open.org>; Thu, 18 Jun 2020 15:58:39 +0000 (UTC)
References: <20200527041212.12700.60627.stgit@localhost.localdomain>
 <20200527041414.12700.50293.stgit@localhost.localdomain>
 <CAKgT0UdPC1s0c-wqsNc4x8DeZhtZQVMmLArWQ=Z345Mkof650Q@mail.gmail.com>
 <4f37c184-cf62-5711-a737-925533b52d73@redhat.com>
 <CAKgT0Udmxjx66hEhDyqWS1wBkAfEf_hht8FZAOuh3NMDOAOR3w@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <aea3b6e6-f653-dd0c-5e17-d0c948a6af4b@redhat.com>
Date: Thu, 18 Jun 2020 17:58:28 +0200
MIME-Version: 1.0
In-Reply-To: <CAKgT0Udmxjx66hEhDyqWS1wBkAfEf_hht8FZAOuh3NMDOAOR3w@mail.gmail.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH v25 QEMU 3/3] virtio-balloon: Replace free page hinting
 references to 'report' with 'hint'
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 18.06.20 17:14, Alexander Duyck wrote:
> On Thu, Jun 18, 2020 at 5:54 AM David Hildenbrand <david@redhat.com> wrot=
e:
>>
>> On 13.06.20 22:07, Alexander Duyck wrote:
>>> On Tue, May 26, 2020 at 9:14 PM Alexander Duyck
>>> <alexander.duyck@gmail.com> wrote:
>>>>
>>>> From: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>>
>>>> In an upcoming patch a feature named Free Page Reporting is about to b=
e
>>>> added. In order to avoid any confusion we should drop the use of the w=
ord
>>>> 'report' when referring to Free Page Hinting. So what this patch does =
is go
>>>> through and replace all instances of 'report' with 'hint" when we are
>>>> referring to free page hinting.
>>>>
>>>> Acked-by: David Hildenbrand <david@redhat.com>
>>>> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
>>>> ---
>>>>  hw/virtio/virtio-balloon.c         |   78 ++++++++++++++++++---------=
---------
>>>>  include/hw/virtio/virtio-balloon.h |   20 +++++----
>>>>  2 files changed, 49 insertions(+), 49 deletions(-)
>>>>
>>>> diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
>>>> index 3e2ac1104b5f..dc15409b0bb6 100644
>>>> --- a/hw/virtio/virtio-balloon.c
>>>> +++ b/hw/virtio/virtio-balloon.c
>>>
>>> ...
>>>
>>>> @@ -817,14 +817,14 @@ static int virtio_balloon_post_load_device(void =
*opaque, int version_id)
>>>>      return 0;
>>>>  }
>>>>
>>>> -static const VMStateDescription vmstate_virtio_balloon_free_page_repo=
rt =3D {
>>>> +static const VMStateDescription vmstate_virtio_balloon_free_page_hint=
 =3D {
>>>>      .name =3D "virtio-balloon-device/free-page-report",
>>>>      .version_id =3D 1,
>>>>      .minimum_version_id =3D 1,
>>>>      .needed =3D virtio_balloon_free_page_support,
>>>>      .fields =3D (VMStateField[]) {
>>>> -        VMSTATE_UINT32(free_page_report_cmd_id, VirtIOBalloon),
>>>> -        VMSTATE_UINT32(free_page_report_status, VirtIOBalloon),
>>>> +        VMSTATE_UINT32(free_page_hint_cmd_id, VirtIOBalloon),
>>>> +        VMSTATE_UINT32(free_page_hint_status, VirtIOBalloon),
>>>>          VMSTATE_END_OF_LIST()
>>>>      }
>>>>  };
>>>
>>> So I noticed this patch wasn't in the list of patches pulled, but that
>>> is probably for the best since I believe the change above might have
>>> broken migration as VMSTATE_UINT32 does a stringify on the first
>>> parameter.
>>
>> Indeed, it's the name of the vmstate field. But I don't think it is
>> relevant for migration. It's and indicator if a field is valid and it's
>> used in traces/error messages.
>>
>> See git grep "field->name"
>>
>> I don't think renaming this is problematic. Can you rebase and resent?
>> Thanks!
>=20
> Okay, I will.
>=20
>>> Any advice on how to address it, or should I just give up on renaming
>>> free_page_report_cmd_id and free_page_report_status?
>>>
>>> Looking at this I wonder why we even need to migrate these values? It
>>> seems like if we are completing a migration the cmd_id should always
>>> be "DONE" shouldn't it? It isn't as if we are going to migrate the
>>
>> The *status* should be DONE IIUC. The cmd_id might be relevant, no? It's
>> always incremented until it wraps.
>=20
> The thing is, the cmd_id visible to the driver if the status is DONE
> is the cmd_id value for DONE. So as long as the driver acknowledges
> the value we could essentially start over the cmd_id without any
> negative effect. The driver would have to put down a new descriptor to
> start a block of hinting in order to begin reporting again so there
> shouldn't be any risk of us falsely hinting pages that were in a
> previous epoch.
>=20
> Ugh, although now looking at it I think we might have a bug in the
> QEMU code in that the driver could in theory force its way past a
> "STOP" by just replaying the last command_id descriptor and then keep
> going. Should be a pretty easy fix though as we should only allow a
> transition to S_START if the status is S_REQUESTED/

Ugh, ...

@MST, you might have missed that in another discussion, what's your
general opinion about removing free page hinting in QEMU (and Linux)? We
keep finding issues in the QEMU implementation, including non-trivial
ones, and have to speculate about the actual semantics. I can see that
e.g., libvirt does not support it yet.

--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

