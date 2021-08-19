Return-Path: <pankaj.gupta.linux@gmail.com>
MIME-Version: 1.0
References: <20210813095216.487591-1-pankaj.gupta.linux@gmail.com>
 <YRvVFbhQ83kY2xKw@stefanha-x1.localdomain> <CAM9Jb+idw-LNTbEekYz9KkuYu4w+T4UbzLJoGfQULU=2Zd97ng@mail.gmail.com>
 <87tujnrviv.fsf@redhat.com>
In-Reply-To: <87tujnrviv.fsf@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Thu, 19 Aug 2021 07:53:48 +0200
Message-ID: <CAM9Jb+hDhck-4zMXOvd5dwVU2Qxu1QU6aVsq=SNvwz=-NjMbfw@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-pmem: PMEM device spec
Content-Type: text/plain; charset="UTF-8"
To: Cornelia Huck <cohuck@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, virtio-dev@lists.oasis-open.org, Dan Williams <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Taylor Stark <tstark@linux.microsoft.com>, Pankaj Gupta <pankaj.gupta@ionos.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> >> > +\drivernormative{\subsubsection}{Driver Initialization: Virtio flush}{Device Types / PMEM Driver / Driver Initialization / Virtio flush}
> >> > +
> >> > +The driver MUST implement a virtio based flushing interface.
> >>
> >> I think this can be dropped. The only way to make writes persistent is
> >> by sending flush requests. There is no need to say that the driver has
> >> to use this interface. It doesn't really have to, but then it won't be
> >> able to guarantee persistence.
> >
> > I am not 100 percent sure on this.
>
> I don't think we want this in a normative section, but maybe there's a
> place for it in a section that describes the general operation?

I was saying because this is the must property for virtio-pmem device
which is emulated
on regular block device. virtio-pmem above real persistent devices
don't need any explicit flush.

This can be enhanced later for real persistent devices which don't
need explicit flush
and thus driver writers don't have to worry about it.

>

