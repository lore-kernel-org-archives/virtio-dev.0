Return-Path: <pasic@linux.ibm.com>
Date: Wed, 11 Jan 2023 16:22:10 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [virtio-dev] [PATCH v2 1/1] virtio-ism: introduce new device
 virtio-ism
Message-ID: <20230111162210.5160f3b9.pasic@linux.ibm.com>
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

> >  
> > > +        Large shared memories are divided into multiple chunks, and one time  
> >
> > "Memories" sounds wrong here. I guess what you used to call "regions"
> > you now call "chunks". But I may be wrong.  
> 
> A ism region consists of multiple chunks. The size of each chunk is fixed.
> The size of ism region is not fixed.

Hm. I'm still a little confused. Does this mean you have something like

virtio shared memory region (with shmid) >= ism shared memory region >=
ism shared memory chunk

Than is multiple ism shared memory regions may live within a single
virtio shared memory region, and multiple ism shared memory chunks may
compose an ism shared memory region?

Regards,
Halil

