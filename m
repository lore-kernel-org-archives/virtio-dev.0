Return-Path: virtio-dev-return-7502-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 59324985F30
	for <virtio-dev@lists.oasis-open.org>; Tue, 23 Jun 2020 06:54:42 +0000 (UTC)
References: <20200619214912.25598.8400.stgit@localhost.localdomain>
 <20200619215309.25598.7553.stgit@localhost.localdomain>
 <acac152a-8be5-aa5c-ca52-e5ffc90b6ed4@redhat.com>
 <CAKgT0UcP6gGK_X80pepwpsC=JFmL9+n61ow-HEJMKbFVZ4Jh8g@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <4ea55633-51df-1ca7-72bc-4c9c7d429575@redhat.com>
Date: Tue, 23 Jun 2020 08:54:31 +0200
MIME-Version: 1.0
In-Reply-To: <CAKgT0UcP6gGK_X80pepwpsC=JFmL9+n61ow-HEJMKbFVZ4Jh8g@mail.gmail.com>
Content-Language: en-US
Subject: [virtio-dev] Re: [PATCH 1/2] virtio-balloon: Prevent guest from starting a report
 when we didn't request one
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
List-ID: <virtio-dev.lists.oasis-open.org>

>>> +++ b/hw/virtio/virtio-balloon.c
>>> @@ -527,7 +527,8 @@ static bool get_free_page_hints(VirtIOBalloon *dev)
>>>              ret =3D false;
>>>              goto out;
>>>          }
>>> -        if (id =3D=3D dev->free_page_report_cmd_id) {
>>> +        if (dev->free_page_report_status =3D=3D FREE_PAGE_REPORT_S_REQ=
UESTED &&
>>> +            id =3D=3D dev->free_page_report_cmd_id) {
>>>              dev->free_page_report_status =3D FREE_PAGE_REPORT_S_START;
>>>          } else {
>>>              /*
>>
>> But doesn't that mean that, after the first hint, all further ones will
>> be discarded and we'll enter the STOP state in the else case? Or am I
>> missing something?
>>
>> Shouldn't this be something like
>>
>> if (id =3D=3D dev->free_page_report_cmd_id) {
>>     if (dev->free_page_report_status =3D=3D FREE_PAGE_REPORT_S_REQUESTED=
) {
>>         dev->free_page_report_status =3D FREE_PAGE_REPORT_S_START;
>>     }
>>     /* Stay in FREE_PAGE_REPORT_S_START as long as the cmd_id match .*/
>> } else { ...
>=20
> There should only be one element containing an outbuf at the start of
> the report. Once that is processed we should not see the driver
> sending additional outbufs unless it is sending the STOP command ID.

Ok, I assume what Linux guests do is considered the correct protocol.

[...]

>=20
>>> @@ -592,14 +593,16 @@ static void virtio_balloon_free_page_start(VirtIO=
Balloon *s)
>>>          return;
>>>      }
>>>
>>> -    if (s->free_page_report_cmd_id =3D=3D UINT_MAX) {
>>> +    qemu_mutex_lock(&s->free_page_lock);
>>> +
>>> +    if (s->free_page_report_cmd_id++ =3D=3D UINT_MAX) {
>>>          s->free_page_report_cmd_id =3D
>>>                         VIRTIO_BALLOON_FREE_PAGE_REPORT_CMD_ID_MIN;
>>> -    } else {
>>> -        s->free_page_report_cmd_id++;
>>>      }
>>
>> Somewhat unrelated cleanup.
>=20
> Agreed. I can drop it if preferred. I just took care of it because I
> was adding the lock above and below to prevent us from getting into
> any wierd states where the command ID might be updated but the report
> status was not.

No hard feelings, it just makes reviewing harder, because one has to
investigate how the changes relate to the locking changes - to find out
they don't. :)

Acked-by: David Hildenbrand <david@redhat.com>

--=20
Thanks,

David / dhildenb


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

