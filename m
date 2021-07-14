Return-Path: <virtio-dev-return-8281-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E9F019863E1
	for <virtio-dev@lists.oasis-open.org>; Wed, 14 Jul 2021 09:37:09 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <YO6ro345FI0XE8vv@stefanha-x1.localdomain>
References: <20210505193655.2414268-1-egranata@google.com>
 <CAPR809ukYeThsPy4eg8A-G8b4Hwt7Prxh9P75=Vp9jnCKb6WqQ@mail.gmail.com>
 <YO6ro345FI0XE8vv@stefanha-x1.localdomain>
Date: Wed, 14 Jul 2021 11:36:58 +0200
Message-ID: <87pmvlck3p.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-dev] Fwd: [PATCH v2] Provide detailed specification of
 virtio-blk lifetime metrics
Content-Type: text/plain
To: Stefan Hajnoczi <stefanha@redhat.com>, Enrico Granata <egranata@google.com>
Cc: virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jul 14 2021, Stefan Hajnoczi <stefanha@redhat.com> wrote:

> On Wed, May 05, 2021 at 12:37:26PM -0700, Enrico Granata wrote:
>> ---------- Forwarded message ---------
>> From: Enrico Granata <egranata@google.com>
>> Date: Wed, May 5, 2021 at 1:37 PM
>> Subject: [PATCH v2] Provide detailed specification of virtio-blk
>> lifetime metrics
>> To: <virtio-dev@lists.oasis-open.org>
>> Cc: <egranata@google.com>, <hch@infradead.org>, <mst@redhat.com>,
>> <linux-block@vger.kernel.org>,
>> <virtualization@lists.linux-foundation.org>
>> 
>> 
>> In the course of review, some concerns were surfaced about the
>> original virtio-blk lifetime proposal, as it depends on the eMMC
>> spec which is not open
>> 
>> Add a more detailed description of the meaning of the fields
>> added by that proposal to the virtio-blk specification, as to
>> make it feasible to understand and implement the new lifetime
>> metrics feature without needing to refer to JEDEC's specification
>> 
>> This patch does not change the meaning of those fields nor add
>> any new fields, but it is intended to provide an open and more
>> clear description of the meaning associated with those fields.
>> 
>> Signed-off-by: Enrico Granata <egranata@google.com>
>> ---
>> Changes in v2:
>>   - clarified JEDEC references;
>>   - added VIRTIO_BLK prefix and cleaned up comment syntax;
>>   - clarified reserved block references
>> 
>>  content.tex | 40 ++++++++++++++++++++++++++++++++--------
>>  1 file changed, 32 insertions(+), 8 deletions(-)
>
> Ping?
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

[Enrico is currently on leave of absence]

Is there any outstanding feedback from the linux-block folks? I've lost
track of this, I'm afraid. (Your R-b is the only feedback I see on this
list...)

We can certainly put up a vote. This is one of the things I wanted to
see fixed for the next release of the standard.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

