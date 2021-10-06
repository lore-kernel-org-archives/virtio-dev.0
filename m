Return-Path: <pankaj.gupta.linux@gmail.com>
MIME-Version: 1.0
References: <20211006062157.21768-1-pankaj.gupta.linux@gmail.com>
 <874k9u1vf5.fsf@redhat.com> <CAM9Jb+h130AAJRMNz1rEuKSXeOjtyR=oi23KMr+w4GQPhRwuQg@mail.gmail.com>
 <87y276zh3p.fsf@redhat.com> <CAM9Jb+jtYgyPrgVaHV-c5PPE8yLoJKhU-r+XWYx6qruMrmEgiA@mail.gmail.com>
 <87pmsizccq.fsf@redhat.com>
In-Reply-To: <87pmsizccq.fsf@redhat.com>
From: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Date: Wed, 6 Oct 2021 12:24:00 +0200
Message-ID: <CAM9Jb+hvYkzOVvwmjh3EQ_HspG3v=aZ1=o3AO6KsqsJ1LrcphA@mail.gmail.com>
Subject: Re: [virtio-dev] Re: [PATCH v5] virtio-pmem: PMEM device spec
Content-Type: text/plain; charset="UTF-8"
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, Stefan Hajnoczi <stefanha@redhat.com>, Dan Williams <dan.j.williams@intel.com>, David Hildenbrand <david@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Taylor Stark <tstark@linux.microsoft.com>, Pankaj Gupta <pankaj.gupta@ionos.com>
List-ID: <virtio-dev.lists.oasis-open.org>

> >> >> > +\subsubsection{ Workload specific mapping}\label{sec:Device Types / PMEM Device / Possible Security Implications / Countermeasures / Workload}
> >> >> > +For SHARED mappings, for the workload is a single application inside
> >> >> > +the driver and there is no risk in sharing data. Device sharing
> >> >>
> >> >> Sorry for noticing this only now, but I have trouble parsing this
> >> >> sentence. Does it mean that you can use SHARED mapping if the workload
> >> >> is a single application?
> >> >
> >> > yes and if risk in sharing data is very less or acceptable.
> >> >
> >> >>
> >> >> > +same backing region with SHARED mapping can be used as a valid configuration.
> >>
> >> Hm... maybe rephrase this paragraph as:
> >>
> >> "When using SHARED mappings with a workload that is a single application
> >> inside the driver where the risk in sharing data is very low or
> >> nonexisting, the device sharing the same backing region with a SHARED
> >> mapping can be used as a valid configuration."
> >
> > Thank you Cornelia!
> > I tried to reread my initial statement and I think that also precisely conveys
> > the use-case.
> >
> > If you are okay, I will respin v6 with only space with bracket change
> > and Stefan r-o-b?
>
> And my proposed change? If nobody else has a comment, I think we could
> start voting on that.

Sure.

Thanks,
Pankaj
>

