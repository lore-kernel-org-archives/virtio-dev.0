Return-Path: <pasic@linux.ibm.com>
Date: Wed, 11 Jan 2023 16:30:34 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [virtio-dev] [PATCH v2 1/1] virtio-ism: introduce new device
 virtio-ism
Message-ID: <20230111163034.159a9eb5.pasic@linux.ibm.com>
In-Reply-To: <1673435333.1297436-1-xuanzhuo@linux.alibaba.com>
References: <20221223081354.15026-1-xuanzhuo@linux.alibaba.com>
	<20221223081354.15026-2-xuanzhuo@linux.alibaba.com>
	<20230110233401.131cc97a.pasic@linux.ibm.com>
	<1673435333.1297436-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, gerry@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com, jasowang@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, wintera@linux.ibm.com, kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com, hca@linux.ibm.com, twinkler@linux.ibm.com, raspl@linux.ibm.com, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Wed, 11 Jan 2023 19:08:53 +0800
Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:

> > > +\begin{description}
> > > +\item[\field{ev_type}] The type of event, the driver can get the size of the
> > > +    structure based on this.
> > > +
> > > +\item[\field{offset}] The offset of ism regions with the event.  
> >
> > Offset with respect to what?  
> 
> Used to specify a region. Offset is the position of this ISM Region inside the
> memory of Device.

An offset is per definition always relative to something. I would have
thought this is an offset relative to the beginning of *the* virtio
shared memory region identified by the ismid 1. But since you claim that
there may be multiple virtio shared memory regions with the shmid 1 I'm
heavily confused. What is here "the memory of Device"?

