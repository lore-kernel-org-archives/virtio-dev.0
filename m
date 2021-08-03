Return-Path: <virtio-dev-return-8460-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id B43D09863C4
	for <virtio-dev@lists.oasis-open.org>; Tue,  3 Aug 2021 08:26:53 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <CAM9Jb+jAbBrsQbR8hHFcskqXojj47kMc0xzivQMH0Ax2uUb8ng@mail.gmail.com>
References: <20210728150435.264551-1-pankaj.gupta.linux@gmail.com>
 <87r1fg10hm.fsf@redhat.com>
 <CAM9Jb+jAbBrsQbR8hHFcskqXojj47kMc0xzivQMH0Ax2uUb8ng@mail.gmail.com>
Date: Tue, 03 Aug 2021 10:26:38 +0200
Message-ID: <87mtpzylvl.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH RESEND] virtio-pmem: PMEM device spec
Content-Type: text/plain
To: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: virtio-dev@lists.oasis-open.org, Dan Williams <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, "Michael
 S . Tsirkin" <mst@redhat.com>, Taylor Stark <tstark@linux.microsoft.com>, Pankaj Gupta <pankaj.gupta@ionos.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Jul 30 2021, Pankaj Gupta <pankaj.gupta.linux@gmail.com> wrote:

>> > +Also, configures a flush callback function with the corresponding region.
>>
>> Not sure if that is too specific already... maybe something like "Also,
>> it configures a notification for when the corresponding region is flushed."?
>
> Maybe will remove this line altogether as it is implementation
> details?

Maybe... I think the point is to configure _something_, not sure if we
can really generalize that. Other ideas welcome.

>> See above for "flush callback". I'm mostly worrying about the wording
>> being generic enough (even though it's probably obvious enough for
>> non-Linux people as well.)
>
> yes, Something below is better?
>
> The driver MUST not enable any explicit FLUSH on the file memory
> mapped from the Virtio pmem device

Hm, not sure. Would like to see feedback from others that had worked in
this area.

>
>>
>> > +
>> > +\subsection{Driver Operations}\label{sec:Device Types / PMEM Driver / Driver Operation}
>> > +\drivernormative{\subsubsection}{Driver Operation: Virtqueue command}{Device Types / PMEM Driver / Driver Operation / Virtqueue command}
>> > +
>> > +Driver MUST send VIRTIO_FLUSH command on request virtqueue, allows guest userspace process to perform IO operations asynchronously.
>>
>> s/Driver/The driver/
>>
>> I don't think we should refer to "guest userspace" in the spec; can we
>> reword this?
>
> Sure
>
> Driver MUST send VIRTIO_FLUSH command on request virtqueue, thus
> allows asynchronous FLUSH operation on the files present in Virtio
> pmem device.

s/Driver/The driver/
s/allows/allowing/

I'm not sure whether we should refer to 'files'.

Again, feedback from others welcome; this is not really one of my core topics.

>
>>
>> > +
>> > +Driver SHOULD handle multiple fsync requests on files present on the device.
>>
>> s/Driver/The driver/
>
> o.k
>
>>
>> Again, a bit unsure on whether this is generic enough.
>
> Driver SHOULD handle multiple FLUSH requests on the files present on
> the Virtio pmem device.

Same here. I'm afraid this is not easy :(


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

