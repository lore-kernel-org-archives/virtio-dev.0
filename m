Return-Path: <virtio-dev-return-11046-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E350698673A
	for <virtio-dev@lists.oasis-open.org>; Thu, 16 Feb 2023 16:30:14 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <PH0PR12MB54814F1CCBA0CD40A4908274DCA09@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230214180405.364920-1-parav@nvidia.com>
 <87ilg1aehi.fsf@redhat.com>
 <PH0PR12MB5481F4E1099DF88D667DBD2CDCA09@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230216104714-mutt-send-email-mst@kernel.org>
 <87cz69a98e.fsf@redhat.com>
 <PH0PR12MB54814F1CCBA0CD40A4908274DCA09@PH0PR12MB5481.namprd12.prod.outlook.com>
Date: Thu, 16 Feb 2023 17:30:09 +0100
Message-ID: <87a61da7zi.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v6] virtio-net: Improve
 introductory description
Content-Type: text/plain
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>, David Edmondson <david.edmondson@oracle.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Feb 16 2023, Parav Pandit <parav@nvidia.com> wrote:

>> From: Cornelia Huck <cohuck@redhat.com>
>> Sent: Thursday, February 16, 2023 11:03 AM
>> 
>> On Thu, Feb 16 2023, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> 
>> > On Thu, Feb 16, 2023 at 02:30:03PM +0000, Parav Pandit wrote:
>> >>
>> >> > From: Cornelia Huck <cohuck@redhat.com>
>> >> > Sent: Thursday, February 16, 2023 9:10 AM
>> >> >
>> >> > On Tue, Feb 14 2023, Parav Pandit <parav@nvidia.com> wrote:
>> >> >
>> >> > > The control VQ of the virtio network device is used beyond
>> >> > > advance steering control. The control VQ dynamically changes
>> >> > > multiple features of the initialized device.
>> >> > >
>> >> > > Hence, update this area of control VQ introductory description at
>> >> > > few places and also place the link to its description.
>> >> > >
>> >> > > Also update the introduction section to better describe receive
>> >> > > and transmit virtqueues.
>> >> > >
>> >> > > Fixes: https://github.com/oasis-tcs/virtio-spec/issues/156
>> >> > > Reviewed-by: David Edmondson <david.edmondson@oracle.com>
>> >> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
>> >> >
>> >> > Are you requesting a vote for this?
>> >>
>> >> I was not sure if its need voting as most are editorial cleanups, better
>> description, structure movement.
>> >> Please advise if we need voting.
>> >
>> >
>> > The bylaws are here:
>> > https://github.com/oasis-tcs/virtio-spec/blob/master/README.md
>> > Minor cleanups, including editorial formatting changes, spelling and
>> > typo fixes can be committed directly into git for approval as part of
>> > the next specification approval ballot.
>> >
>> > This is way beyond that. And generally when in doubt vote.
>> 
>> Agreed.
>> 
>> (Btw: the github issue needs to be updated to point to the latest version of the
>> patch, it still points to v1.)
>
> Done.

Do you request to withdraw the ballot, so that we can start a new ballot
with the proper URL?

(Sorry about being a stickler for process here.)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

