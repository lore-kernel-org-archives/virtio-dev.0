Return-Path: <mst@redhat.com>
Date: Thu, 28 Oct 2021 01:50:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] RE: [PATCH v2] Add device reset timeout field
Message-ID: <20211028014301-mutt-send-email-mst@kernel.org>
References: <CACGkMEthjkX3pV+1L9Eg-nJOArSUfmDRY8UCK_2LJ7-oxO6SpQ@mail.gmail.com>
 <DM8PR12MB548048016A0311F809BF0E67DCB99@DM8PR12MB5480.namprd12.prod.outlook.com>
 <CACGkMEuP6nZCSyz8piHYdMzwSKGgZbn65SBx486C-Lm2jbw5TA@mail.gmail.com>
 <PH0PR12MB5481C32F9D9A54AFA4E337A3DC809@PH0PR12MB5481.namprd12.prod.outlook.com>
 <2984c445-a7fd-97c4-34aa-3a40778a0fcd@redhat.com>
 <PH0PR12MB54810528108E4EB12CC1C401DC839@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtBJavHQr2SaMiz8TSTt-fCsm3WoJMfRYEO=dr-=Ld-1Q@mail.gmail.com>
 <PH0PR12MB54818FC7BD40A16F656CAE90DC859@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20211027040559-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481CEC3BB8BB3EC0B0A368BDC869@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481CEC3BB8BB3EC0B0A368BDC869@PH0PR12MB5481.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Parav Pandit <parav@nvidia.com>
Cc: Jason Wang <jasowang@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Max Gurtovoy <mgurtovoy@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Oct 28, 2021 at 04:01:52AM +0000, Parav Pandit wrote:
> >   how it looks like, whether there is a timeout is
> >   a separate question.
> 
> > E.g. a read counter sounds
> >   more generic, if device is stuck it can just stop
> >   incrementing it.
> This is not scalable solution for hundreds of devices and it breaks the layering too.
> A virtio layer itself is not in up_state to perform counter update.
> A non virtio layer is expected to implement this counter. This is not right.

Donnu what does the above mean. My point is simple: there's little
difference between device being stuck during firmware boot and
device being stuck right after boot.

> But this timer is not useful for publishing device readiness. Having device readiness register is enough to indicate that.
> For health monitoring such counting register is useful. But its out of scope to address this problem.
> So will skip this.
> 
> I will explore the device readiness register and update the proposal.
> Thanks.

