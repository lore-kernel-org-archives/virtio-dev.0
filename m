Return-Path: <virtio-dev-return-9547-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0BE88986467
	for <virtio-dev@lists.oasis-open.org>; Tue, 17 May 2022 10:08:31 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <PH0PR12MB5481DD681A0172899E09BC6CDCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220426225824.5918-1-mgurtovoy@nvidia.com>
 <20220426225824.5918-3-mgurtovoy@nvidia.com>
 <20220515111056-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481DD681A0172899E09BC6CDCCF9@PH0PR12MB5481.namprd12.prod.outlook.com>
Date: Tue, 17 May 2022 12:08:25 +0200
Message-ID: <87zgjgfp46.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [virtio-comment] RE: [PATCH v5 2/7] Introduce admin command set
Content-Type: text/plain
To: Parav Pandit <parav@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: "jasowang@redhat.com" <jasowang@redhat.com>, "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, Oren Duer <oren@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, "aadam@redhat.com" <aadam@redhat.com>, "virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, May 16 2022, Parav Pandit <parav@nvidia.com> wrote:

> Hi Michael,
>
>> From: Michael S. Tsirkin <mst@redhat.com>
>> Sent: Sunday, May 15, 2022 11:24 AM
>
> [..]
>
>> > +\subsection{VIRTIO ADMIN DEVICE CAPS ACCEPT
>> command}\label{sec:Basic
>> > +Facilities of a Virtio Device / Admin command set / VIRTIO ADMIN
>> > +DEVICE CAPS ACCEPT command}
>> > +
>> > +The VIRTIO_ADMIN_DEVICE_CAPS_ACCEPT command is used by the
>> driver to acknowledge those admin capabilities it understands and wishes to
>> use.
>> 
>> 
>> ok so we have a protocol here, kind of like feature negotiation. Please write
>> its description.
>> e.g. is it ok to change accepted caps? when? can device change its caps etc
>> etc etc.
>> 
>> Avoiding this kind of spec work is exactly why me and jason keep telling you
>> to consider just using features instead. Add a 64 bit admin features field to
>> the PCI transport and be done with it. CCW and MMIO already have feature
>> selector so it's trivial to add feature bits.
>> 
> As we begin to scale with the device, adding more and more registers like this demands more on-device real estate to comply to the PCI standards.
>
> And therefore, things are queried/accessed rare or occasionally, are better accessed via a queue interface.
>
> One can argue that admin VQ is proposed only for the mgmt. functions so having this cfg register for PF is enough.
>
> However, AQ may find some usage in the VF/SF themselves down the road.
> Hence, keeping the cap exchange transport this way is more optimal.
>
> Max has called out this AQ rationale in 4 or 5 points in the cover letter.

I'm not against using a queue, but why not use feature bits for
capabilities? As Michael said, the infrastructure for that is already in
place.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

