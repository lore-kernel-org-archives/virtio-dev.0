Return-Path: <pankaj.gupta.linux@gmail.com>
MIME-Version: 1.0
References: <20210813095216.487591-1-pankaj.gupta.linux@gmail.com>
 <YRvVFbhQ83kY2xKw@stefanha-x1.localdomain> <CAM9Jb+idw-LNTbEekYz9KkuYu4w+T4UbzLJoGfQULU=2Zd97ng@mail.gmail.com>
 <87tujnrviv.fsf@redhat.com> <CAM9Jb+hDhck-4zMXOvd5dwVU2Qxu1QU6aVsq=SNvwz=-NjMbfw@mail.gmail.com>
 <YR4mq0lXtAWzzQgE@stefanha-x1.localdomain>
In-Reply-To: <YR4mq0lXtAWzzQgE@stefanha-x1.localdomain>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Thu, 19 Aug 2021 12:11:46 +0200
Message-ID: <CAM9Jb+j58d1xtm8EAc2-zkPVku6k+2BhHtDXb_ny5Acz7HKWpg@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH v2] virtio-pmem: PMEM device spec
Content-Type: text/plain; charset="UTF-8"
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org, Dan Williams <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Taylor Stark <tstark@linux.microsoft.com>, Pankaj Gupta <pankaj.gupta@ionos.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 19 Aug 2021 at 11:39, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> On Thu, Aug 19, 2021 at 07:53:48AM +0200, Pankaj Gupta wrote:
> > > >> > +\drivernormative{\subsubsection}{Driver Initialization: Virtio flush}{Device Types / PMEM Driver / Driver Initialization / Virtio flush}
> > > >> > +
> > > >> > +The driver MUST implement a virtio based flushing interface.
> > > >>
> > > >> I think this can be dropped. The only way to make writes persistent is
> > > >> by sending flush requests. There is no need to say that the driver has
> > > >> to use this interface. It doesn't really have to, but then it won't be
> > > >> able to guarantee persistence.
> > > >
> > > > I am not 100 percent sure on this.
> > >
> > > I don't think we want this in a normative section, but maybe there's a
> > > place for it in a section that describes the general operation?
> >
> > I was saying because this is the must property for virtio-pmem device
> > which is emulated
> > on regular block device. virtio-pmem above real persistent devices
> > don't need any explicit flush.
> >
> > This can be enhanced later for real persistent devices which don't
> > need explicit flush
> > and thus driver writers don't have to worry about it.
>
> A feature bit can be added in the future that hints to the driver that
> flushes are not necessary (only CPU cache flushes are required for
> persistence).

Sure. will remove this then.
>
> However, I remember seeing specifications for persistent memory devices
> that do require explicit flush operations (not just a CPU cache flush).
> Let's keep them in mind too.

Thanks. Maybe internally they would be doing CPU flushes (a guess) and/or
some metadata sync operation.

Thank you for all the feedback. Will send a v3 with the suggested changes.

Best regards,
Pankaj

>
> Stefan

