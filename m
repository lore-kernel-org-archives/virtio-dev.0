Return-Path: <virtio-comment-return-4292-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20230216104714-mutt-send-email-mst@kernel.org>
References: <20230214180405.364920-1-parav@nvidia.com>
 <87ilg1aehi.fsf@redhat.com>
 <PH0PR12MB5481F4E1099DF88D667DBD2CDCA09@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230216104714-mutt-send-email-mst@kernel.org>
Date: Thu, 16 Feb 2023 17:03:13 +0100
Message-ID: <87cz69a98e.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-comment] Re: [PATCH v6] virtio-net: Improve introductory description
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, David Edmondson <david.edmondson@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 16 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Feb 16, 2023 at 02:30:03PM +0000, Parav Pandit wrote:
>> 
>> > From: Cornelia Huck <cohuck@redhat.com>
>> > Sent: Thursday, February 16, 2023 9:10 AM
>> > 
>> > On Tue, Feb 14 2023, Parav Pandit <parav@nvidia.com> wrote:
>> > 
>> > > The control VQ of the virtio network device is used beyond advance
>> > > steering control. The control VQ dynamically changes multiple features
>> > > of the initialized device.
>> > >
>> > > Hence, update this area of control VQ introductory description at few
>> > > places and also place the link to its description.
>> > >
>> > > Also update the introduction section to better describe receive and
>> > > transmit virtqueues.
>> > >
>> > > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/156
>> > > Reviewed-by: David Edmondson <david.edmondson@oracle.com>
>> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
>> > 
>> > Are you requesting a vote for this?
>> 
>> I was not sure if its need voting as most are editorial cleanups, better description, structure movement.
>> Please advise if we need voting.
>
>
> The bylaws are here:
> https://github.com/oasis-tcs/virtio-spec/blob/master/README.md
> Minor cleanups, including editorial formatting changes, spelling and
> typo fixes can be committed directly into git for approval as part of
> the next specification approval ballot.
>
> This is way beyond that. And generally when in doubt vote.

Agreed.

(Btw: the github issue needs to be updated to point to the latest
version of the patch, it still points to v1.)


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

