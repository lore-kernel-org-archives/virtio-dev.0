Return-Path: <virtio-dev-return-8899-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8DA339865C4
	for <virtio-dev@lists.oasis-open.org>; Fri, 15 Oct 2021 11:13:49 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <CAM9Jb+isBoXr2TNb9zswOeALcS4h9E-pAesD2amUdiHUibOqNg@mail.gmail.com>
References: <20211006103244.32388-1-pankaj.gupta.linux@gmail.com>
 <87fst3vaqm.fsf@redhat.com>
 <CAM9Jb+isBoXr2TNb9zswOeALcS4h9E-pAesD2amUdiHUibOqNg@mail.gmail.com>
Date: Fri, 15 Oct 2021 13:13:30 +0200
Message-ID: <874k9iv8v9.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v6] virtio-pmem: PMEM device spec
Content-Type: text/plain
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: virtio-dev@lists.oasis-open.org, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Taylor Stark <tstark@linux.microsoft.com>, Pankaj Gupta <pankaj.gupta@ionos.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Oct 15 2021, Pankaj Gupta <pankaj.gupta.linux@gmail.com> wrote:

>> So, I ran into some problems while trying to apply this.
>>
>> First, this is against an older version of the tree, so it did not apply
>> cleanly.
>
> Sorry! somehow i missed this.

No worries, I fixed that up; but rebasing makes things easier for the
person applying it.

>>
>> Second, the conformance section looks off: we don't have a driver
>> conformance section, and the device conformance section ends up being
>> called a driver conformance section. Unfortunately, I had neglected to
>> review that properly :(
>>
>> I think the following would be correct; I'm inclined to apply this spec
>> with it as an editorial edit. Any comments/objections?
>
> my bad :(
>
> Thank you for your help!
> Hope this makes into master now.

I pushed this out now. If something is off, we can fix that on top.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

