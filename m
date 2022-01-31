Return-Path: <virtio-dev-return-9237-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 08D279865D1
	for <virtio-dev@lists.oasis-open.org>; Mon, 31 Jan 2022 16:13:18 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20220131164729.71eab1b6.pasic@linux.ibm.com>
References: <87wnikys4p.fsf@redhat.com>
 <20220128074613-mutt-send-email-mst@kernel.org>
 <87tudnzwq9.fsf@redhat.com>
 <20220128105012-mutt-send-email-mst@kernel.org>
 <CACGkMEsXhKDGqpK=umdFkKubqm09Z45YgnNSYH-xwwJQEd9PEA@mail.gmail.com>
 <e80bdf0d-4b52-03ca-6378-cf9e2a062b34@nvidia.com>
 <20220130043917-mutt-send-email-mst@kernel.org>
 <f3644061-70b6-892d-a2e0-1e710bf58609@nvidia.com>
 <20220130093740-mutt-send-email-mst@kernel.org>
 <da7444d6-f67d-3598-814d-a1b945c3542d@nvidia.com>
 <20220130102940-mutt-send-email-mst@kernel.org>
 <87ilu0z2mc.fsf@redhat.com> <20220131164729.71eab1b6.pasic@linux.ibm.com>
Date: Mon, 31 Jan 2022 17:12:34 +0100
Message-ID: <87a6fbzxxp.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Re: [PATCH v2 1/4] Add virtio Admin Virtqueue
Content-Type: text/plain
To: Halil Pasic <pasic@linux.ibm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>, Jason Wang <jasowang@redhat.com>, virtio-comment@lists.oasis-open.org, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Parav Pandit <parav@nvidia.com>, Shahaf Shuler <shahafs@nvidia.com>, Oren Duer <oren@nvidia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Jan 31 2022, Halil Pasic <pasic@linux.ibm.com> wrote:

> On Mon, 31 Jan 2022 10:16:43 +0100
> Cornelia Huck <cohuck@redhat.com> wrote:
>> For ccw, I'd do something like
>> 
>> #define CCW_CMD_READ_MISC_CONF 0x82
>> 
>> struct virtio_misc_conf {
>>        be16 admin_queue_index;
>> };
>> 
>> bound to revision 3, which gets a payload data containing the length of
>> this structure (for future expansions).
>> 
>> Halil, do you think that would work?
>
>
> I think so. But I would like to review the actual proposal :)
>
> Some of the questions I have in mind are:
> * Are fields in this config protected with feature bits

I'd say they exist, as long as they are contained in the length provided
via the revision data. Whether the data in the field is valid depends on
feature bits.

> * Do we ever need to write this config? Adding a writable field to pci
>   is easier than to ccw (no need to invent a new ccw)

If we need that, we need to define a companion write command. If we
already think we might need to write some fields in the future, we could
introduce that command already right now.

> * Looks like we will have an addressability mismatch with
>   ccw compared to pci and mmio: ccw can only read a prefix of this new
>   config, while mmio and pci have access to the individual fields

Yeah, that's basically like the config space access, which we're also
modelling with reading up to the requested field. I'm not sure whether
there's a better way to model this.

> * Is this static stuff only? If not, do we need notifications for config
>   change like for the device specific config?

This needs more thought :) To the others reading this thread: do you
think "a mechanism for the device to make various extra configuration
information available to the driver" (i.e. static and read-only) is
enough, or do you think we need more? I think "initiate an action" like
the queue reset is not neccessarily served best by an interface like
this (I had thought about a multiplexing "initiate action" ccw for that
purpose.) The different transports likely have different preferences
here.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

