Return-Path: <virtio-comment-return-3756-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <PH0PR12MB548116EBA8343DA37A8F345DDCFF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230109162849.463101-1-parav@nvidia.com>
 <20230109121857-mutt-send-email-mst@kernel.org>
 <87358i4ow0.fsf@redhat.com>
 <PH0PR12MB548116EBA8343DA37A8F345DDCFF9@PH0PR12MB5481.namprd12.prod.outlook.com>
Date: Tue, 10 Jan 2023 16:21:13 +0100
Message-ID: <87zgaq2z6e.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] RE: [virtio-dev] Re: [PATCH v2 00/20] Split device spec to its
 individual files
Content-Type: text/plain
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Jan 10 2023, Parav Pandit <parav@nvidia.com> wrote:

>> From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> On
>> Behalf Of Cornelia Huck
>> 
>> On Mon, Jan 09 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> > Does makediff still work? Documentation says latexpand does not
>> > support import. without latexdiff generating redlined versions would
>> > be very difficult.
>> >
>> >
>> > I am also worried about consistency since we already use \\input.
>> > If using \\input means putting everything in a single directory,
>> > that's a small price to pay:
>> >
>> > virtio-sound.tex + virtio-sound-conformance.tex
>> >
>> > is not fundamentally worse than device-types/virtio-sound/device.tex
>> > and device-types/virtio-sound/device-conformance.tex
>> >
>> > and it avoids the duplicated "device" in the name.
>> >
>> > Previously it looked like a cosmetic issue, but now it looks like it's
>> > important.
>> 
>> I agree, and we need to decide quickly what to do with the ballot. We don't
>> want to merge v1, but the current votes still have a majority of 'yes'. My
>> preference would be to withdraw the ballot, which needs to be done before
>> 22:00 UTC today, if I'm not confused.
>> 
>> Parav, what do you think? If you request to withdraw the ballot, that's easy to
>> do; we'll just open a new one once we've agreed on a version.
>
> I am revising the v2 and should be available in 7 pm UTC time.
> This will include,
> a. white space removal at end of the net and blk files
> b. fix missing device conformance links for 4 devices
> c. import to input
> d. continue with directories
> e. rename device-types/<name>/device.tex to device-types/<name>/description.tex

Apologies if I sound like a process stickler, but the main problem is
that the ballot is currently about v1 of the patches (and we obviously
can't change that while it is open, as that would invalidate the votes
that already have been cast.) If your v3 looks good, we need a new
ballot to vote on that. As it stands now, the TC would have voted to
include v1 with its known problems... that's why I think a withdrawal
would be best.


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
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

