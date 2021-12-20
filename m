Return-Path: <qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [virtio-comment] Plans for releasing a VIRTIO 1.2 spec
Date: Mon, 20 Dec 2021 15:04:13 +0100
Message-ID: <1716817.ojcOkzPiJ8@silver>
In-Reply-To: <871r27qw8o.fsf@redhat.com>
References: <871r27qw8o.fsf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
To: virtio-comment@lists.oasis-open.org
Cc: Cornelia Huck <cohuck@redhat.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Montag, 20. Dezember 2021 13:47:03 CET Cornelia Huck wrote:
> We are due (or rather overdue) for a new release of the VIRTIO spec. As
> doing a release takes some time, we need to tie things up soon (remember
> that there will also be a next revision for changes that don't make the
> cut.)
> 
> We propose to declare a freeze on changes starting January 25th, 2022 (no
> new non-editorial changes committed). This would mean that any ballot
> needs to conclude on January 24th the latest (and therefore has to be
> opened before January 17th). Any change that you want to see included in
> 1.2 has to reach enough consensus to open a ballot in early January 2022.
> 
> Next steps would be creating a Comittee Specification Draft (and voting
> on it), putting it out for review, and then creating (and voting on) a
> Comittee Specification, hopefully before the end of March 2022.
> 
> To reiterate, anything that should be included in VIRTIO 1.2 needs to
> have a ballot started
> 
>               *before January 17th, 2022*
> 
> at the very latest (preferably earlier).

As holidays are starting this week, that realistically means a window of about 
just one or two weeks, for both bringing a discussion eventually to its spec 
commit, as well as concluding its subsequent ballot.

Maybe it's just me, but considering that the last virtio revision was 3 years 
ago, that sounds like a sudden hammer fall to me.

> This should give us enough time to tie up most proposals currently
> actively discussed. Again, remember that anything that is late will
> simply make it into the next release instead.

Which will be when approximately?

> Please let us know if you have any concerns.
> 
> The VIRTIO TC Chairs

Spec issues that won't make it through within this narrow time window would 
not suffer under any negative consequences in form of reluctance for their 
actual implementation patches on Linux kernel / QEMU side, would they?

Best regards,
Christian Schoenebeck


