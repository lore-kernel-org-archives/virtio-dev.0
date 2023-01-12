Return-Path: <mst@redhat.com>
Date: Thu, 12 Jan 2023 01:56:14 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] [PATCH v2 1/1] virtio-ism: introduce new device
 virtio-ism
Message-ID: <20230112014722-mutt-send-email-mst@kernel.org>
References: <20221223081354.15026-1-xuanzhuo@linux.alibaba.com>
 <20221223081354.15026-2-xuanzhuo@linux.alibaba.com>
 <20230110233401.131cc97a.pasic@linux.ibm.com>
 <1673435333.1297436-1-xuanzhuo@linux.alibaba.com>
 <20230111161128.48e6d7e0.pasic@linux.ibm.com>
 <CACGkMEuT5L2DH1ga+HOJb0DHdF04VmvC3viEoRPhraLxc7RCjg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuT5L2DH1ga+HOJb0DHdF04VmvC3viEoRPhraLxc7RCjg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtio-dev@lists.oasis-open.org, hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, gerry@linux.alibaba.com, cohuck@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, wintera@linux.ibm.com, kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com, hca@linux.ibm.com, twinkler@linux.ibm.com, raspl@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, Jan 12, 2023 at 10:01:25AM +0800, Jason Wang wrote:
> On Wed, Jan 11, 2023 at 11:11 PM Halil Pasic <pasic@linux.ibm.com> wrote:
> >
> > On Wed, 11 Jan 2023 19:08:53 +0800
> > Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> >
> > > > > +ISM(Internal Shared Memory) device provides the ability to share memory between
> > > > > +different VMs launched from the same entity.
> > > >
> > > > Launched by instead of from? Maybe introduce a catchy name for the
> > > > "entity that launched the VMs" and prevent oversimplification by
> > > > explaining any shortcomings of the name if any in one place. Host would
> > > > be one candidate, VMM another.
> > >
> > > Cornelia Huck wrote:
> > >
> > >       Is there a way to avoid the term "host" (throughout this document)?
> > >       IIUC, you need the uniqueness within the scope of the entity that
> > >       launches the different instances that get shared access to the regions
> > >       (which could conceivably a unit of hardware?)
> > >
> > > And I think she is right, so I am trying to remove the term HOST.
> > >
> > > Do you have better opinions? I think VMM is not particularly suitable.

I think fundamentally from spec POV memory is shared between devices.
How sharing is accomplished guest does not care so neither should the
spec. Can some RDMA tricks be used for synchronisation behind the
scenes? Maybe, the spec does not care. But we can give an example.

So something like:

	An ISM(Internal Shared Memory) device provides the ability to
	access memory shared between multiple devices. This allows low-overhead
	communication in presence of such memory. For example, memory can be
	shared with guests of multiple virtual machines running on the same
	host, with each virtual machine including an ISM device and with
	the guests using the ISM devices to access the shared memory.

what do others think?


-- 
MST

