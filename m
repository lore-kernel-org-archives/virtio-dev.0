Return-Path: <virtio-dev-return-8563-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BE58A986488
	for <virtio-dev@lists.oasis-open.org>; Wed, 18 Aug 2021 08:45:49 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <CAM9Jb+idw-LNTbEekYz9KkuYu4w+T4UbzLJoGfQULU=2Zd97ng@mail.gmail.com>
References: <20210813095216.487591-1-pankaj.gupta.linux@gmail.com>
 <YRvVFbhQ83kY2xKw@stefanha-x1.localdomain>
 <CAM9Jb+idw-LNTbEekYz9KkuYu4w+T4UbzLJoGfQULU=2Zd97ng@mail.gmail.com>
Date: Wed, 18 Aug 2021 10:45:28 +0200
Message-ID: <87tujnrviv.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v2] virtio-pmem: PMEM device spec
Content-Type: text/plain
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Dan Williams <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, "Michael
 S . Tsirkin" <mst@redhat.com>, Taylor Stark <tstark@linux.microsoft.com>, Pankaj Gupta <pankaj.gupta@ionos.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Tue, Aug 17 2021, Pankaj Gupta <pankaj.gupta.linux@gmail.com> wrote:

>> > +\drivernormative{\subsubsection}{Driver Initialization: Virtio flush}{Device Types / PMEM Driver / Driver Initialization / Virtio flush}
>> > +
>> > +The driver MUST implement a virtio based flushing interface.
>>
>> I think this can be dropped. The only way to make writes persistent is
>> by sending flush requests. There is no need to say that the driver has
>> to use this interface. It doesn't really have to, but then it won't be
>> able to guarantee persistence.
>
> I am not 100 percent sure on this.

I don't think we want this in a normative section, but maybe there's a
place for it in a section that describes the general operation?


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

