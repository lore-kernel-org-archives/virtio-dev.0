Return-Path: <pankaj.gupta.linux@gmail.com>
MIME-Version: 1.0
References: <20210728150435.264551-1-pankaj.gupta.linux@gmail.com>
 <YQp1D+Ece28livMx@stefanha-x1.localdomain> <CAM9Jb+gQwz5x4=iVxrv2OHRs24h=NA+hyhq7c-PsH7MZqWKJmA@mail.gmail.com>
 <YQqJsy49sEXRD8dl@stefanha-x1.localdomain>
In-Reply-To: <YQqJsy49sEXRD8dl@stefanha-x1.localdomain>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Wed, 4 Aug 2021 14:40:58 +0200
Message-ID: <CAM9Jb+gf3184MV-ZsQVvpKkUSg7-S1OdKn2tUNK4ZMw_AZ7jaw@mail.gmail.com>
Subject: Re: [virtio-dev] [PATCH RESEND] virtio-pmem: PMEM device spec
Content-Type: text/plain; charset="UTF-8"
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Dan Williams <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Taylor Stark <tstark@linux.microsoft.com>, Pankaj Gupta <pankaj.gupta@ionos.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> > > > +\subsection{Device Initialization}\label{sec:Device Types / PMEM Device / Device Initialization}
> > > > +
> > > > +Device hotplugs physical memory to guest address space. Persistent memory device
> > > > +is emulated with file backed memory at host side.
> > >
> > > This paragraph can be dropped. The device could be implemented in a
> > > number of ways and it's beyond the scope of the specification.
> >
> > But spec is for current implementation?  As we have more devices or ways, we
> > can amend this.
>
> The spec defines the driver/device interface, not the implementation. By
> focussing on the interface rather than implementation, we leave room for
> multiple implementations and avoid baking in assumptions about one
> particular implementation (e.g. file-backed MAP_SHARED host memory).

Fair point. Will remove the paragraph.

Thanks,
Pankaj

