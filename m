Return-Path: <mst@redhat.com>
Date: Mon, 25 Apr 2022 09:42:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] Re: queue_reset register polarity to improve
Message-ID: <20220425085415-mutt-send-email-mst@kernel.org>
References: <PH0PR12MB54819125071ED675E2B72F0EDCF99@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20220424023301-mutt-send-email-mst@kernel.org>
 <871qxl8k51.fsf@redhat.com>
 <PH0PR12MB54811ABC8173F4DE9AABED5EDCF89@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54811ABC8173F4DE9AABED5EDCF89@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Apr 25, 2022 at 12:01:21PM +0000, Parav Pandit wrote:
> 
> > From: Cornelia Huck <cohuck@redhat.com>
> > Sent: Monday, April 25, 2022 7:42 AM
> 
> > >
> > > Well it's been merged since November. Probably too late unless you can
> > > convince the TC that the current feature should be abandoned and the
> > > feature completely redesigned. Above does not look like a deal
> > > breaker.
> > 
> > Agreed. We can add clarifications on top, though.
> 
> I replied to Michael in other thread.
> Feature was merged in Dec-21.

It has been under review since August of that year though and underwent
several revisions.

> It is likely not too late to fix it now, instead of keeping this behavior for next 10 years.
> Are there any devices, drivers that have adopted and broken due to this?

Hard to say. Even just speaking about open source drivers patches
have been on linux mailing list already, and I was planning on
including them in linux-next for meging a month from now.

> If not, lets please fix it.

Question is what exactly is the advantage of making changes now.  If we
are trying to save bits then maybe an alternative that uses queue enable
instead should be worked on.


> Spec is not released, right?

Kind of yes. The vote to release for a review is technically ongoing,
but practically 6 out of 8 voting members already cast a ballot and
voted yes.
The best way forward if you think the issue is important enough to delay
the release is probably working on a proposal for a change meanwhile and
submitting it as part of the 30 day public review. Since the change
seems material this would imply another 15 day public review period,
delaying the release by about a month in total.

As part of that I would suggest explaining the motivation for the
change beyond the simple "seems a bit cleaner".


-- 
MST

