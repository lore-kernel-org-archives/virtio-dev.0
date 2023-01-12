Return-Path: <mst@redhat.com>
Date: Thu, 12 Jan 2023 02:01:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [virtio-dev] [PATCH v2 1/1] virtio-ism: introduce new device
 virtio-ism
Message-ID: <20230112015716-mutt-send-email-mst@kernel.org>
References: <20221223081354.15026-1-xuanzhuo@linux.alibaba.com>
 <20221223081354.15026-2-xuanzhuo@linux.alibaba.com>
 <20230110233401.131cc97a.pasic@linux.ibm.com>
 <1673435333.1297436-1-xuanzhuo@linux.alibaba.com>
 <20230111221238.0ba94650.pasic@linux.ibm.com>
MIME-Version: 1.0
In-Reply-To: <20230111221238.0ba94650.pasic@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtio-dev@lists.oasis-open.org, hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, gerry@linux.alibaba.com, cohuck@redhat.com, jasowang@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, wintera@linux.ibm.com, kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com, hca@linux.ibm.com, twinkler@linux.ibm.com, raspl@linux.ibm.com
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, Jan 11, 2023 at 10:12:38PM +0100, Halil Pasic wrote:
> On Wed, 11 Jan 2023 19:08:53 +0800
> Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> 
> > > > +The device shares memory to the driver based on shared memory regions
> > > > +\ref{sec:Basic Facilities of a Virtio Device / Shared Memory Regions}.
> > > > +However, it does not need to allocate physical memory during initialization.
> > > > +
> > > > +The \field{shmid} of a region MUST be one of the following
> > > > +\begin{lstlisting}
> > > > +enum virtio_ism_shm_id {
> > > > +	VIRTIO_ISM_SHM_ID_UNDEFINED = 0,
> > > > +	VIRTIO_ISM_SHM_ID_REGIONS   = 1,
> > > > +	VIRTIO_ISM_SHM_ID_NOTIFY    = 2,
> > > > +};
> > > > +\end{lstlisting}
> > > > +
> > > > +The shared memory whose shmid is VIRTIO_ISM_SHM_ID_REGIONS is used to implement
> > > > +ism regions.  
> > >
> > > Hm. AFAIU, these are supposed to be used for exchanging data between the
> > > VMs that are supposed to communicate with each other via ism.
> > >
> > > How does this relate to the following normative section:
> > > """
> > > 2.10.2 Device Requirements: Shared Memory Regions
> > >
> > > Shared memory regions MUST NOT expose shared memory regions which are used to control the operation of the device, nor to stream data.
> > > """  
> > 
> > From https://lists.oasis-open.org/archives/virtio-comment/201906/msg00010.html
> > 
> > 	I'm trying to find a way to say that people shouldn't side-step virtio
> > 	queues by putting everything in a big blob of shared memory.
> > 
> > So I think this should not be conflict.
> 
> AFAIU putting everything in a big blob of shared memory is what ISM
> does. I'm not saying that this is bad. But I'm for sure confused.
> 
> In my opinion we should either clarify what is meant by that sentence
> and maybe also why, or get rid of it.
> 
> @MST: What is your take on this?

I think what this is trying to prevent is people building proprietary
extensions into devices themselves. This as opposed to proprietary
communication between devices.

If we want to do this, maybe just say that device itself should not
access or modify the data inside the region. But we need to
clarify that as multiple devices refer to the same shared
memory driver must not assume it will not be read or written since
another driver can access it through another device.




> > 
> > >  
> > > > If there are multiple shared memories whose shmid is
> > > > +VIRTIO_ISM_SHM_ID_REGIONS, they are used as contiguous memory in the order of
> > > > +acquisition.  
> > >
> > > Hm, I used to think that the shmid is an unique identifier for a shared
> > > memory region. How can multiple virtio shared memory regions have the
> > > same shmid?  
> > 
> > Shmid is used to define what this sharing memory is used to do, not its unique
> > identifier.
> 
> As far as I can tell the shmid is supposed to uniquely identify a single
> shared memory region!
> 
> " A device may have multiple shared memory regions associated with it.
> Each region has a shmid to identify it, the meaning of which is device-specific." 
> 
> @MST: Can you please help us to get clarity on this?
> 
> BTW, this is why I pointed you to the corresponding MMIO interface:
> """
> SHMSel	             Shared memory id
> 0x0ac
> W
> 
> Writing to this register selects the shared memory region 2.10 following
> operations on SHMLenLow, SHMLenHigh, SHMBaseLow and SHMBaseHigh apply
> to.
> 
> SHMLenLow            Shared memory region 64 bit long length 
> 0x0b0
> SHMLenHigh
> 0x0b4
> R
> 	
> 
> These registers return the length of the shared memory region in bytes,
> as defined by the device for the region selected by the SHMSel register.
> The lower 32 bits of the length are read from SHMLenLow and the higher
> 32 bits from SHMLenHigh. Reading from a non-existent region (i.e. where
> the ID written to SHMSel is unused) results in a length of -1.
> 	
> 
> SHMBaseLow         Shared memory region 64 bit long physical address 
> 0x0b8
> SHMBaseHigh
> 0x0bc
> R  
> 
> The driver reads these registers to discover the base address of the
> region in physical address space. This address is chosen by the device
> (or other part of the VMM). The lower 32 bits of the address are read
> from SHMBaseLow with the higher 32 bits from SHMBaseHigh. Reading from a
> non-existent region (i.e. where the ID written to SHMSel is unused)
> results in a base address of 0xffffffffffffffff. 
> """
> 
> I.e. after you write the shmid into SHMSel you can obtain the base
> address and the length of that region, provided there is a region
> with that id.
> 
> > 
> > This is the point that device provides multiple shared memory areas.
> > These memory areas are used to provide ISM Region.
> > 
> 
> Thus I don't think this is possible without violating the currently
> standing rules on shared memory regions.
> 
> > >
> > > Can you have a look at the MMIO interface for virtio shared memory
> > > regions.  
> > 
> > Is there any special attention?
> > 
> 
> Please see above.
> 
> > 
> > >
> > > How far what ISM tries to do consistent with virtio shared memory. I
> > > mean, AFAIU once the shared memory is advertised, the  shared memory is
> > > supposed to be there and accessible by the driver for both writes and
> > > reads.  
> > 
> > Before allocation, VMM did not allocate physical memory for it. Therefore, it
> > was illegal to read and write this memory.
> 
> I'm not sure whether generating addressing exceptions on accesses to the
> advertised virtio shared memory regions is acceptable or not. Maybe
> Michael, Connie and the TC members more versed in shared memory regions
> can help us get clarity on this.
> 
> I don't think it is per-se prohibited, but on the other hand, to me
> virtio shared memory regions read more like memory that is supposed to
> work , and less like an address space that may or may not be backed by
> memory. So if this is allowed, maybe adding a sentence to the part that
> describes virtio shared memory regions in the basic facilities portion of
> the spec would be beneficial.
> 
> Regards,
> Halil

