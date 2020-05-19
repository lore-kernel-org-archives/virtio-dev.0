Return-Path: virtio-comment-return-1273-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <158956393696.246123.9443729217250549606.stgit@ahduyck-workstation>
 <158956398852.246123.13563550180731658368.stgit@ahduyck-workstation>
 <7558cc20-262b-ddc4-2442-e05f0b74b59d@redhat.com>
 <CAKgT0Ucx6nF9_e6+Qj-A6t_c5Mm1u-=kphAtF31bz9t8Oo+n6w@mail.gmail.com>
 <15d1908f-4137-8079-da20-e423721014c8@redhat.com>
 <CAKgT0UcvteBsvKa8TJFoOpXxXPDxqUPLwtqbfGj287g6_NAeYQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <be88b182-3e52-1244-a44c-f8db013ddcd9@redhat.com>
Date: Tue, 19 May 2020 18:09:32 +0200
MIME-Version: 1.0
In-Reply-To: <CAKgT0UcvteBsvKa8TJFoOpXxXPDxqUPLwtqbfGj287g6_NAeYQ@mail.gmail.com>
Content-Language: en-US
Subject: Re: [virtio-comment] [PATCH v2 1/3] content: Document balloon feature
 free page hints
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Wang, Wei W" <wei.w.wang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

>> I proposed that the driver MUST reinitialize the pages when reusing
>> (which is what Linux does), so then this is true. Reuse implies
>> initializing, implies modification. It's somewhat simpler than what you
>> propose, leaving the case open where the driver would reuse pages by
>> only reading them (I don't really see a use case for that ...). But I
>> don't care as long as it's consistent and correct :)
>=20
> Linux does not reinitialize the pages when it frees them. That only

Whoever uses the pages has to initialize. Again, I don't think we should
make difference between the guest and the driver. From spec POV, they
are one piece. Everything else is implementation detail.

> happens if poison or init_on_free are enabled which are rare cases.
> When it does reinitialize the pages then I agree that the device
> cannot modify the contents.

What about a user who relies on the content of uninitialized pages?
Like, read it, if it has the value, don't set it to the value. Unlikely
but possible, no? We could have data corruption.

We should document that in some way, because this is what could happen
with the *current* QEMU implementation

>=20
> The current implementation is assuming QEMU live-migration with the
> Linux guest as the only use case. As such I want to make sure we
> correctly capture all of the behaviors that are expected based on
> those assumptions, but I want to avoid inserting behaviors we would
> like to see occur but aren't really a part of this.

Exactly that's why I bring this ^ up.

>=20
>>>
>>> The driver can end up releasing the pages back to the buddy allocator
>>> and if they are not poisoned/init_on_free then they will go there and
>>> can still potentially change until such time as the guest writes to
>>> the page modifying it or the balloon driver switches the cmd ID to
>>> VIRTIO_BALLOON_CMD_ID_DONE. That was one of the reasons for trying to
>>> frame it the way I did. So what I can do is reword the two statements
>>> as follows:
>>>
>>>   If the content of a previously hinted page has not been modified by t=
he
>>>   guest since the device issued the \field{free_page_hint_cmd_id} assoc=
iated
>>>   with the hint, the device MAY modify the contents of the page.
>>>
>>>   The device MUST NOT modify the content of a previously hinted page
>>> after
>>>   \field{free_page_hint_cmd_id} is set to VIRTIO_BALLOON_CMD_ID_DONE.
>> Is it really only "DONE" that closes the current window? I think a
>> "STOP" from the device will also close the window. DONE is only set at
>> the very last iteration during memory migration.
>=20
> So the CMD_ID_DONE is issued when the migration has occurred. The
> migration is what is actually modifying the memory.
>=20
>> (virtio_balloon_free_page_report_notify() in QEMU)
>>
>> I consider one window =3D=3D one iteration =3D=3D one value of
>> \field{free_page_hint_cmd_id} until either DONE or STOP
>=20
> CMD_ID_STOP will close the current window for providing hints, but the
> migration hasn't happened yet. We are still accumulating the hints. We
> don't receive CMD_ID_DONE from the device until the migration has
> occurred. It is the migration that will alter the content of the pages
> by leaving them behind on the previous VM.

I'll have to think about again if your statements reflect the reality
today. I'll have to dive once again into QEMU code :( Complicated stuff.

>=20
>> [...]
>>
>> Let's think this through, what about this scenario:
>>
>> The device sets \field{free_page_hint_cmd_id} =3D X
>> The driver starts reporting free pages (and reports all pages it has)
>> 1. Sends X to start the windows
>> 2. Sends all page hints (\field{free_page_hint_cmd_id} stays X)
>> 3. Sends VIRTIO_BALLOON_CMD_ID_STOP to end the window
>> The driver sets \field{free_page_hint_cmd_id} =3D DONE or STOP
>>
>> The guest can reuse the pages any time (triggered by the shrinker),
>> especially, during 2, before the hypervisor even processed a hint
>> request. It can happen that the guest reuses a page before the
>> hypervisor processes the request and before
>> \field{free_page_hint_cmd_id} changes.
>>
>> In QEMU, the double-bitmap magic makes sure that this is guaranteed to
>> work IIRC.
>>
>> In that case, the page has to be migrated in that windows, the
>> hypervisor must not modify the content.
>=20
> If by "reuse" you mean write to or reinitialize then that is correct.
> All that is really happening is that any pages that are hinted have
> the potential to be left behind with the original VM and not migrated
> to the new one. We get the notification that the migration happened
> when CMD_ID_DONE is passed to us. At that point the hinting is
> complete and the device has no use for additional data.
>=20
> Instead of CMD_ID_STOP it probably would have made more sense to call
> it something like CMD_ID_PAUSE or CMD_ID_HOLD as that is what it is
> really doing. It is just temporarily holding the hints off while the
> hypervisor synchronizes the dirty bits from the host.

I think if migration fails, it will be left set to STOP. Guess we should
specify that possibility somehow as well.

--=20
Thanks,

David / dhildenb


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lis=
ts
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

