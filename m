Return-Path: <virtio-dev-return-9220-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 113AE9865A1
	for <virtio-dev@lists.oasis-open.org>; Fri, 28 Jan 2022 16:24:17 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <20220128111514-mutt-send-email-mst@kernel.org>
References: <20220124093918.34371-1-mgurtovoy@nvidia.com>
 <20220124093918.34371-2-mgurtovoy@nvidia.com> <87wnikys4p.fsf@redhat.com>
 <20220128074613-mutt-send-email-mst@kernel.org>
 <87tudnzwq9.fsf@redhat.com>
 <20220128105012-mutt-send-email-mst@kernel.org>
 <87r18rzvki.fsf@redhat.com>
 <20220128111514-mutt-send-email-mst@kernel.org>
Date: Fri, 28 Jan 2022 17:23:42 +0100
Message-ID: <87o83vzv5d.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v2 1/4] Add virtio Admin Virtqueue
Content-Type: text/plain
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Max Gurtovoy <mgurtovoy@nvidia.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, jasowang@redhat.com, parav@nvidia.com, shahafs@nvidia.com, oren@nvidia.com, stefanha@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jan 28 2022, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Fri, Jan 28, 2022 at 05:14:37PM +0100, Cornelia Huck wrote:
>> Maybe pci gets a new entry in common_cfg, mmio gets a new register, and
>> ccw gets a new command?
>
> That's fine.
>
>> (Although I'd prefer to be conservative with new
>> commands for ccw, maybe it's time to introduce a "get misc config" type
>> command that can be reused for other things. There's a generic ccw for
>> that, but adding new stuff to it would require an s390 architecture
>> change AFAIK, so I had decided not to go down that path for virtio.)
>
> You mean a generic "get misc config" for all transports? That's fine
> by me too. I suspect nvidia guys will need help building
> something like this though ...

I was more thinking about ccw only... not sure if we can define
something useful for all transports.

I'm willing to help with defining a ccw mechanism; I realize that this
will be hard for most people.

(Let's get agreement on whether we want to go down that route first.)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

