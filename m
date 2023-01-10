Return-Path: <virtio-dev-return-10506-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 10A33986528
	for <virtio-dev@lists.oasis-open.org>; Tue, 10 Jan 2023 15:34:14 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <PH0PR12MB5481324F6E61B352850E8FB5DCFF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230109162849.463101-1-parav@nvidia.com>
 <20230109121857-mutt-send-email-mst@kernel.org>
 <87358i4ow0.fsf@redhat.com>
 <PH0PR12MB548116EBA8343DA37A8F345DDCFF9@PH0PR12MB5481.namprd12.prod.outlook.com>
 <87zgaq2z6e.fsf@redhat.com>
 <PH0PR12MB5481324F6E61B352850E8FB5DCFF9@PH0PR12MB5481.namprd12.prod.outlook.com>
Date: Tue, 10 Jan 2023 16:33:35 +0100
Message-ID: <87wn5u2yls.fsf@redhat.com>
MIME-Version: 1.0
Subject: RE: [virtio-dev] Re: [PATCH v2 00/20] Split device spec to its
 individual files
Content-Type: text/plain
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 10 2023, Parav Pandit <parav@nvidia.com> wrote:

>> From: Cornelia Huck <cohuck@redhat.com>
>> Sent: Tuesday, January 10, 2023 10:21 AM
>> 
>> On Tue, Jan 10 2023, Parav Pandit <parav@nvidia.com> wrote:
>> 
>> >> From: virtio-dev@lists.oasis-open.org
>> >> <virtio-dev@lists.oasis-open.org> On Behalf Of Cornelia Huck
>> >>
>> >> On Mon, Jan 09 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> >> > Does makediff still work? Documentation says latexpand does not
>> >> > support import. without latexdiff generating redlined versions
>> >> > would be very difficult.
>> >> >
>> >> >
>> >> > I am also worried about consistency since we already use \\input.
>> >> > If using \\input means putting everything in a single directory,
>> >> > that's a small price to pay:
>> >> >
>> >> > virtio-sound.tex + virtio-sound-conformance.tex
>> >> >
>> >> > is not fundamentally worse than
>> >> > device-types/virtio-sound/device.tex
>> >> > and device-types/virtio-sound/device-conformance.tex
>> >> >
>> >> > and it avoids the duplicated "device" in the name.
>> >> >
>> >> > Previously it looked like a cosmetic issue, but now it looks like
>> >> > it's important.
>> >>
>> >> I agree, and we need to decide quickly what to do with the ballot. We
>> >> don't want to merge v1, but the current votes still have a majority
>> >> of 'yes'. My preference would be to withdraw the ballot, which needs
>> >> to be done before
>> >> 22:00 UTC today, if I'm not confused.
>> >>
>> >> Parav, what do you think? If you request to withdraw the ballot,
>> >> that's easy to do; we'll just open a new one once we've agreed on a version.
>> >
>> > I am revising the v2 and should be available in 7 pm UTC time.
>> > This will include,
>> > a. white space removal at end of the net and blk files b. fix missing
>> > device conformance links for 4 devices c. import to input d. continue
>> > with directories e. rename device-types/<name>/device.tex to
>> > device-types/<name>/description.tex
>> 
>> Apologies if I sound like a process stickler, but the main problem is that the
>> ballot is currently about v1 of the patches (and we obviously can't change that
>> while it is open, as that would invalidate the votes that already have been cast.)
> If it auto invalidates, is there any withdrawal process needed?
> If no, lets withdraw an re-vote on v3.

No, there's no such thing as auto-invalidation, as we cannot modify the
ballot (sorry if I was unclear.) Let's just withdraw the ballot.

>
>> If your v3 looks good, we need a new ballot to vote on that. As it stands now,
>> the TC would have voted to include v1 with its known problems... that's why I
>> think a withdrawal would be best.
>
> We will use the same github issue for v3, and new ballot yes?

Yes, exactly. (This is not the first time this has happened.)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

