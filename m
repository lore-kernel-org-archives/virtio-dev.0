Return-Path: virtio-comment-return-1281-cohuck=redhat.com@lists.oasis-open.org
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
 <be88b182-3e52-1244-a44c-f8db013ddcd9@redhat.com>
 <CAKgT0Uff+fJV1ZeDVysMWSZcRdUCAx5TwDw7DEMBKYO8kwu2dQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <e1a22ec8-3a90-8786-39d9-75f9477c442d@redhat.com>
Date: Wed, 20 May 2020 10:24:02 +0200
MIME-Version: 1.0
In-Reply-To: <CAKgT0Uff+fJV1ZeDVysMWSZcRdUCAx5TwDw7DEMBKYO8kwu2dQ@mail.gmail.com>
Content-Language: en-US
Subject: Re: [virtio-comment] [PATCH v2 1/3] content: Document balloon feature
 free page hints
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Alexander Duyck <alexander.duyck@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Wang, Wei W" <wei.w.wang@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 19.05.20 23:00, Alexander Duyck wrote:
> On Tue, May 19, 2020 at 9:09 AM David Hildenbrand <david@redhat.com> wrot=
e:
>>
>>>> I proposed that the driver MUST reinitialize the pages when reusing
>>>> (which is what Linux does), so then this is true. Reuse implies
>>>> initializing, implies modification. It's somewhat simpler than what yo=
u
>>>> propose, leaving the case open where the driver would reuse pages by
>>>> only reading them (I don't really see a use case for that ...). But I
>>>> don't care as long as it's consistent and correct :)
>>>
>>> Linux does not reinitialize the pages when it frees them. That only
>>
>> Whoever uses the pages has to initialize. Again, I don't think we should
>> make difference between the guest and the driver. From spec POV, they
>> are one piece. Everything else is implementation detail.
>=20
> Right, but the problem is "use". In the case of balloon it was pages
> being pulled out of the balloon. In the case of free pages nobody is
> really using them. They are "free" already. Part of the issue here is
> that unlike the balloon or page reporting we don't really have a good
> definition for where they are. Getting back to the wording I have been
> using for free page hinting I am looking at something like:
>   The driver MUST reinitialize the contents of any previously hinted page
>   released before receiving the command ID VIRTIO_BALLOON_CMD_ID_DONE.
>=20
> I might reference that as well as the earlier comment about treating
> the hinted pages as uninitialized memory.
>=20
>>> happens if poison or init_on_free are enabled which are rare cases.
>>> When it does reinitialize the pages then I agree that the device
>>> cannot modify the contents.
>>
>> What about a user who relies on the content of uninitialized pages?
>> Like, read it, if it has the value, don't set it to the value. Unlikely
>> but possible, no? We could have data corruption.
>>
>> We should document that in some way, because this is what could happen
>> with the *current* QEMU implementation
>=20
> Agreed. This is a problem with the current QEMU/Linux driver
> implementation. What worries me is that I wonder if this might not be
> more possible then we realize. For example I wonder if something like
> KSM could read the page and try merging it with others just for the
> value to eventually change.
>=20
> So I was documenting the driver side mostly as-is for the
> specification. What we probably do need to do is update both the
> driver and the specification to address this since if we are pulling
> the page out before we get "DONE" we probably should reinitialize it
> so that the state if fixed going forward and it cannot change.
>=20
>>>
>>> The current implementation is assuming QEMU live-migration with the
>>> Linux guest as the only use case. As such I want to make sure we
>>> correctly capture all of the behaviors that are expected based on
>>> those assumptions, but I want to avoid inserting behaviors we would
>>> like to see occur but aren't really a part of this.
>>
>> Exactly that's why I bring this ^ up.
>>
>>>
>>>>>
>>>>> The driver can end up releasing the pages back to the buddy allocator
>>>>> and if they are not poisoned/init_on_free then they will go there and
>>>>> can still potentially change until such time as the guest writes to
>>>>> the page modifying it or the balloon driver switches the cmd ID to
>>>>> VIRTIO_BALLOON_CMD_ID_DONE. That was one of the reasons for trying to
>>>>> frame it the way I did. So what I can do is reword the two statements
>>>>> as follows:
>>>>>
>>>>>   If the content of a previously hinted page has not been modified by=
 the
>>>>>   guest since the device issued the \field{free_page_hint_cmd_id} ass=
ociated
>>>>>   with the hint, the device MAY modify the contents of the page.
>>>>>
>>>>>   The device MUST NOT modify the content of a previously hinted page
>>>>> after
>>>>>   \field{free_page_hint_cmd_id} is set to VIRTIO_BALLOON_CMD_ID_DONE.
>>>> Is it really only "DONE" that closes the current window? I think a
>>>> "STOP" from the device will also close the window. DONE is only set at
>>>> the very last iteration during memory migration.
>>>
>>> So the CMD_ID_DONE is issued when the migration has occurred. The
>>> migration is what is actually modifying the memory.
>>>
>>>> (virtio_balloon_free_page_report_notify() in QEMU)
>>>>
>>>> I consider one window =3D=3D one iteration =3D=3D one value of
>>>> \field{free_page_hint_cmd_id} until either DONE or STOP
>>>
>>> CMD_ID_STOP will close the current window for providing hints, but the
>>> migration hasn't happened yet. We are still accumulating the hints. We
>>> don't receive CMD_ID_DONE from the device until the migration has
>>> occurred. It is the migration that will alter the content of the pages
>>> by leaving them behind on the previous VM.
>>
>> I'll have to think about again if your statements reflect the reality
>> today. I'll have to dive once again into QEMU code :( Complicated stuff.
>=20
> So I am operating on the assumption that the memory isn't going to
> change until the migration occurs. If you take a look at
> virtio_balloon_free_page_hint_notify you will see that it changes the
> status to FREE_PAGE_HINT_S_DONE after the bitmap is synced with the VM
> not running. I am assuming that is the stop-and-copy phase of the
> migration so when the VM does come back up it should report that the
> CMD_ID_DONE in the free page hinting command ID.
>=20
>>>
>>>> [...]
>>>>
>>>> Let's think this through, what about this scenario:
>>>>
>>>> The device sets \field{free_page_hint_cmd_id} =3D X
>>>> The driver starts reporting free pages (and reports all pages it has)
>>>> 1. Sends X to start the windows
>>>> 2. Sends all page hints (\field{free_page_hint_cmd_id} stays X)
>>>> 3. Sends VIRTIO_BALLOON_CMD_ID_STOP to end the window
>>>> The driver sets \field{free_page_hint_cmd_id} =3D DONE or STOP
>>>>
>>>> The guest can reuse the pages any time (triggered by the shrinker),
>>>> especially, during 2, before the hypervisor even processed a hint
>>>> request. It can happen that the guest reuses a page before the
>>>> hypervisor processes the request and before
>>>> \field{free_page_hint_cmd_id} changes.
>>>>
>>>> In QEMU, the double-bitmap magic makes sure that this is guaranteed to
>>>> work IIRC.
>>>>
>>>> In that case, the page has to be migrated in that windows, the
>>>> hypervisor must not modify the content.
>>>
>>> If by "reuse" you mean write to or reinitialize then that is correct.
>>> All that is really happening is that any pages that are hinted have
>>> the potential to be left behind with the original VM and not migrated
>>> to the new one. We get the notification that the migration happened
>>> when CMD_ID_DONE is passed to us. At that point the hinting is
>>> complete and the device has no use for additional data.
>>>
>>> Instead of CMD_ID_STOP it probably would have made more sense to call
>>> it something like CMD_ID_PAUSE or CMD_ID_HOLD as that is what it is
>>> really doing. It is just temporarily holding the hints off while the
>>> hypervisor synchronizes the dirty bits from the host.
>>
>> I think if migration fails, it will be left set to STOP. Guess we should
>> specify that possibility somehow as well.
>=20
> Actually I think that is a bug in the QEMU implementation. We cannot
> let that happen otherwise the guest is never going to let the memory
> go. If we have to abort the migration we should be calling
> virtio_balloon_free_page_done(), probably in response to something
> like PRECOPY_NOTIFY_CLEANUP?
>=20
> The problem is I am not that familiar with the migration process
> itself within QEMU so I am not sure which labels mean what in the
> notifier, but we should be signaling DONE if we are either going to
> abort the migration or if we completed it and are now on the new
> system.
>=20

We are starting to see way too many issues in QEMU code that are hard to
tackle.

1. The issue with hinted pages not being 0 or the old content when
re-accessed, due to the way they are skipped during migration. MST
called that a memory corruption and that this would be broken. Very hard
to fix, maybe impossible.

2. Some cases (migration failing while we are only sending memory) not
setting the status to DONE. The handling is just a mess.

3. Take a look at that asynchronous iothread handling.
virtio_ballloon_get_free_page_hints(). I think you can trick it into
doing nasty things while you are e.g., resetting the device. Also,
virtio_ballloon_get_free_page_hints() will just busy-loop while waiting
for requests. Just ugly. Also that block_iothread, just hard to grasp.

Besides all the other issues I keep finding.

At this point I'd just love to rip out the QEMU implement and let
whoever wants to really have it try again. The Linux side seems to be in
a better state.

This feature is in an unmaintainable state in QEMU.

@MST, is there something that speaks against ripping out the QEMU and
Linux parts, documenting in the spec that this feature should not be used?

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

