Return-Path: <pasic@linux.ibm.com>
Date: Fri, 20 Jan 2023 14:06:05 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [virtio-dev] [PATCH v2 1/1] virtio-ism: introduce new device
 virtio-ism
Message-ID: <20230120140605.665e1a96.pasic@linux.ibm.com>
In-Reply-To: <1673526684.462258-6-xuanzhuo@linux.alibaba.com>
References: <20221223081354.15026-1-xuanzhuo@linux.alibaba.com>
	<20221223081354.15026-2-xuanzhuo@linux.alibaba.com>
	<20230110233401.131cc97a.pasic@linux.ibm.com>
	<1673435333.1297436-1-xuanzhuo@linux.alibaba.com>
	<20230111221238.0ba94650.pasic@linux.ibm.com>
	<1673526684.462258-6-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtio-dev@lists.oasis-open.org, hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, gerry@linux.alibaba.com, mst@redhat.com, cohuck@redhat.com, jasowang@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, wintera@linux.ibm.com, kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com, hca@linux.ibm.com, twinkler@linux.ibm.com, raspl@linux.ibm.com, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 12 Jan 2023 20:31:24 +0800
Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:

> > > Shmid is used to define what this sharing memory is used to do, not its unique
> > > identifier.  
> >
> > As far as I can tell the shmid is supposed to uniquely identify a single
> > shared memory region!
> >
> > " A device may have multiple shared memory regions associated with it.
> > Each region has a shmid to identify it, the meaning of which is device-specific."
> >
> > @MST: Can you please help us to get clarity on this?
> >
[..]
> 
> 
> Oh, I may really be wrong.
> 
> @MST: we need your help.

@Michael: Ping! Can you help us out on this one?

