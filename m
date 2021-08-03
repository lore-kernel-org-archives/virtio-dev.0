Return-Path: <pankaj.gupta.linux@gmail.com>
MIME-Version: 1.0
References: <20210728150435.264551-1-pankaj.gupta.linux@gmail.com>
 <87r1fg10hm.fsf@redhat.com> <CAM9Jb+jAbBrsQbR8hHFcskqXojj47kMc0xzivQMH0Ax2uUb8ng@mail.gmail.com>
 <87mtpzylvl.fsf@redhat.com> <543eb53d-144d-380c-f495-8e6ca3cf5374@redhat.com>
In-Reply-To: <543eb53d-144d-380c-f495-8e6ca3cf5374@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Tue, 3 Aug 2021 11:02:24 +0200
Message-ID: <CAM9Jb+jvdNvp=Y-LpKVRYHNzuhAgA0K+dwKzLe2Nm8SnffaRsw@mail.gmail.com>
Subject: Re: [PATCH RESEND] virtio-pmem: PMEM device spec
Content-Type: text/plain; charset="UTF-8"
To: David Hildenbrand <david@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org, Dan Williams <dan.j.williams@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Taylor Stark <tstark@linux.microsoft.com>, Pankaj Gupta <pankaj.gupta@ionos.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> >>>> +Also, configures a flush callback function with the corresponding region.
> >>>
> >>> Not sure if that is too specific already... maybe something like "Also,
> >>> it configures a notification for when the corresponding region is flushed."?
> >>
> >> Maybe will remove this line altogether as it is implementation
> >> details?
> >
> > Maybe... I think the point is to configure _something_, not sure if we
> > can really generalize that. Other ideas welcome.
> >
> >>> See above for "flush callback". I'm mostly worrying about the wording
> >>> being generic enough (even though it's probably obvious enough for
> >>> non-Linux people as well.)
> >>
> >> yes, Something below is better?
> >>
> >> The driver MUST not enable any explicit FLUSH on the file memory
> >> mapped from the Virtio pmem device
> >
> > Hm, not sure. Would like to see feedback from others that had worked in
> > this area.
>
>
> I think instead of describing detailed device handling in regard to
> e.g., fsync, we should document what the exact semantics are in POV of
> the driver when issuing a flush, and when it makes sense to issue a
> flush. The device is free to implement that however it likes (fsync,
> whatsoever).
>
> Why do we care about "The driver MUST not enable any explicit FLUSH on
> the file memory mapped from the Virtio pmem device" and what exactly do
> we mean with "explicit FLUSH" here ?

Fair. Will remove this and any other hints towards implementation.
Thanks for having a look.

Best regards,
Pankaj

