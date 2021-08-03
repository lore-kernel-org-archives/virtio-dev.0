Return-Path: <pankaj.gupta.linux@gmail.com>
MIME-Version: 1.0
References: <20210728150435.264551-1-pankaj.gupta.linux@gmail.com>
 <87r1fg10hm.fsf@redhat.com> <CAM9Jb+jAbBrsQbR8hHFcskqXojj47kMc0xzivQMH0Ax2uUb8ng@mail.gmail.com>
 <87mtpzylvl.fsf@redhat.com>
In-Reply-To: <87mtpzylvl.fsf@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Tue, 3 Aug 2021 11:16:29 +0200
Message-ID: <CAM9Jb+jjRE0q+kU6FgxoTxmXM_tUQQJcA4Kvg3Ra+UmHz7ym4g@mail.gmail.com>
Subject: Re: [PATCH RESEND] virtio-pmem: PMEM device spec
Content-Type: text/plain; charset="UTF-8"
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Dan Williams <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Taylor Stark <tstark@linux.microsoft.com>, Pankaj Gupta <pankaj.gupta@ionos.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> >> > +Also, configures a flush callback function with the corresponding region.
> >>
> >> Not sure if that is too specific already... maybe something like "Also,
> >> it configures a notification for when the corresponding region is flushed."?
> >
> > Maybe will remove this line altogether as it is implementation
> > details?
>
> Maybe... I think the point is to configure _something_, not sure if we
> can really generalize that. Other ideas welcome.

Agree.
>
> >> See above for "flush callback". I'm mostly worrying about the wording
> >> being generic enough (even though it's probably obvious enough for
> >> non-Linux people as well.)
> >
> > yes, Something below is better?
> >
> > The driver MUST not enable any explicit FLUSH on the file memory
> > mapped from the Virtio pmem device
>
> Hm, not sure. Would like to see feedback from others that had worked in
> this area.

As suggested by David, will remove this as well. As this seems to be
implementation
details.
>
> >
> >>
> >> > +
> >> > +\subsection{Driver Operations}\label{sec:Device Types / PMEM Driver / Driver Operation}
> >> > +\drivernormative{\subsubsection}{Driver Operation: Virtqueue command}{Device Types / PMEM Driver / Driver Operation / Virtqueue command}
> >> > +
> >> > +Driver MUST send VIRTIO_FLUSH command on request virtqueue, allows guest userspace process to perform IO operations asynchronously.
> >>
> >> s/Driver/The driver/
> >>
> >> I don't think we should refer to "guest userspace" in the spec; can we
> >> reword this?
> >
> > Sure
> >
> > Driver MUST send VIRTIO_FLUSH command on request virtqueue, thus
> > allows asynchronous FLUSH operation on the files present in Virtio
> > pmem device.
>
> s/Driver/The driver/
> s/allows/allowing/

o.k

>
> I'm not sure whether we should refer to 'files'.
>
> Again, feedback from others welcome; this is not really one of my core topics.

Sure. Will recheck.
>
> >
> >>
> >> > +
> >> > +Driver SHOULD handle multiple fsync requests on files present on the device.
> >>
> >> s/Driver/The driver/
> >
> > o.k
> >
> >>
> >> Again, a bit unsure on whether this is generic enough.
> >
> > Driver SHOULD handle multiple FLUSH requests on the files present on
> > the Virtio pmem device.
>
> Same here. I'm afraid this is not easy :(

hmm...

The driver SHOULD handle multiple FLUSH requests.

Thanks,
Pankaj

>

