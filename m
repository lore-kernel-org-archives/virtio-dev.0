Return-Path: <virtio-return-3622-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <1716817.ojcOkzPiJ8@silver>
References: <871r27qw8o.fsf@redhat.com> <1716817.ojcOkzPiJ8@silver>
Date: Mon, 20 Dec 2021 16:02:05 +0100
Message-ID: <87y24fpbf6.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio] Re: [virtio-comment] Plans for releasing a VIRTIO 1.2 spec
Content-Type: text/plain
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, virtio-comment@lists.oasis-open.org
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael
 S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Dec 20 2021, Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Montag, 20. Dezember 2021 13:47:03 CET Cornelia Huck wrote:
>> We are due (or rather overdue) for a new release of the VIRTIO spec. As
>> doing a release takes some time, we need to tie things up soon (remember
>> that there will also be a next revision for changes that don't make the
>> cut.)
>> 
>> We propose to declare a freeze on changes starting January 25th, 2022 (no
>> new non-editorial changes committed). This would mean that any ballot
>> needs to conclude on January 24th the latest (and therefore has to be
>> opened before January 17th). Any change that you want to see included in
>> 1.2 has to reach enough consensus to open a ballot in early January 2022.
>> 
>> Next steps would be creating a Comittee Specification Draft (and voting
>> on it), putting it out for review, and then creating (and voting on) a
>> Comittee Specification, hopefully before the end of March 2022.
>> 
>> To reiterate, anything that should be included in VIRTIO 1.2 needs to
>> have a ballot started
>> 
>>               *before January 17th, 2022*
>> 
>> at the very latest (preferably earlier).
>
> As holidays are starting this week, that realistically means a window of about 
> just one or two weeks, for both bringing a discussion eventually to its spec 
> commit, as well as concluding its subsequent ballot.

Yes, I realize that it seems short; however, we have to draw a line
somewhere...

>
> Maybe it's just me, but considering that the last virtio revision was 3 years 
> ago, that sounds like a sudden hammer fall to me.

...especially as we've dragged our feet for so long already, and we
really intend to put out a new spec release every year or so :(

>
>> This should give us enough time to tie up most proposals currently
>> actively discussed. Again, remember that anything that is late will
>> simply make it into the next release instead.
>
> Which will be when approximately?

I think our aim should be to release one spec per year (ISTR that we
also put that into the charter); so *hopefully* that would be in the
first quarter/half of 2023.

>
>> Please let us know if you have any concerns.
>> 
>> The VIRTIO TC Chairs
>
> Spec issues that won't make it through within this narrow time window would 
> not suffer under any negative consequences in form of reluctance for their 
> actual implementation patches on Linux kernel / QEMU side, would they?

For Linux/QEMU, I think we always operated under the assumption that a
commit in git is sufficient; IOW, for Linux/QEMU a new version of the
spec is not that important.

I am not sure if there are other projects out there that look only at
released versions. My impression was rather that most people were happy
enough once something seemed stable.


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

