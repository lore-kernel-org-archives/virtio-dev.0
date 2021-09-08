Return-Path: <pankaj.gupta.linux@gmail.com>
MIME-Version: 1.0
References: <20210902054033.75455-1-pankaj.gupta.linux@gmail.com>
 <YTCUamWUA24yt3g0@stefanha-x1.localdomain> <CAM9Jb+hqv-WRrhSObpaTvKwWE+bEgdHC_ck85wdj=guYjFUssw@mail.gmail.com>
 <YTDql6wICevfv3bv@stefanha-x1.localdomain>
In-Reply-To: <YTDql6wICevfv3bv@stefanha-x1.localdomain>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Wed, 8 Sep 2021 13:08:36 +0200
Message-ID: <CAM9Jb+gKo409O9s1i7zc7WfaX=o_zjT+FpSwtDMzsfTDdvXjfw@mail.gmail.com>
Subject: Re: [PATCH v3] virtio-pmem: PMEM device spec
Content-Type: text/plain; charset="UTF-8"
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Dan Williams <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Taylor Stark <tstark@linux.microsoft.com>, Pankaj Gupta <pankaj.gupta@ionos.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> > > > +Requests have the following format:
> > > > +
> > > > +\begin{lstlisting}
> > > > +struct virtio_pmem_req {
> > > > +        le32 type;
> > > > +};
> > > > +\end{lstlisting}
> > > > +
> > > > +\field{type} is the request command type.
> > >
> > > Where are the type constants defined? I was expecting a flush request
> > > type constant:
> > >
> > >   /* Request types */
> > >   #define VIRTIO_PMEM_REQ_T_FLUSH 0
> >
> > Removed this in current version. Thinking this might be driver specific detail.
> > Will add again.
>
> Constant values that the driver places into the "type" field need to be
> defined in the specification. Otherwise there's a risk that drivers
> place different values into the field and we cannot add new types of
> requests in the future.

Agree.

Waiting for any other comment before I send next version with the
minor changes suggested
by Stefan in v3.

Thanks,
Pankaj

