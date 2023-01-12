Return-Path: <pasic@linux.ibm.com>
Date: Thu, 12 Jan 2023 13:15:55 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [virtio-dev] [PATCH v2 1/1] virtio-ism: introduce new device
 virtio-ism
Message-ID: <20230112131555.70836a62.pasic@linux.ibm.com>
In-Reply-To: <20230112014722-mutt-send-email-mst@kernel.org>
References: <20221223081354.15026-1-xuanzhuo@linux.alibaba.com>
	<20221223081354.15026-2-xuanzhuo@linux.alibaba.com>
	<20230110233401.131cc97a.pasic@linux.ibm.com>
	<1673435333.1297436-1-xuanzhuo@linux.alibaba.com>
	<20230111161128.48e6d7e0.pasic@linux.ibm.com>
	<CACGkMEuT5L2DH1ga+HOJb0DHdF04VmvC3viEoRPhraLxc7RCjg@mail.gmail.com>
	<20230112014722-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtio-dev@lists.oasis-open.org, hans@linux.alibaba.com, herongguang@linux.alibaba.com, zmlcc@linux.alibaba.com, dust.li@linux.alibaba.com, tonylu@linux.alibaba.com, zhenzao@linux.alibaba.com, helinguo@linux.alibaba.com, gerry@linux.alibaba.com, cohuck@redhat.com, Jan Kiszka <jan.kiszka@siemens.com>, wintera@linux.ibm.com, kgraul@linux.ibm.com, wenjia@linux.ibm.com, jaka@linux.ibm.com, hca@linux.ibm.com, twinkler@linux.ibm.com, raspl@linux.ibm.com, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Thu, 12 Jan 2023 01:56:14 -0500
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> I think fundamentally from spec POV memory is shared between devices.

Right, but with the gid stuff and the corresponding rules shared between
two or more arbitrary virtio-ism devices won't do. We need to find a way
to express the what device can communicate with what device relationship.

> How sharing is accomplished guest does not care so neither should the
> spec.

One of the goals of the spec is to foster interoperability. I wonder
how far that goes. For example one could imagine a shared memory on
the same host implementation by one vendor, and an RDMA based
implementation of an other vendor both implementing the very same
interface on the driver-device level. Two entities would not be
able to talk to each other via virtio-ism devices that use different
ways to accomplish the sharing. Is that out of scope for this spec?

> Can some RDMA tricks be used for synchronisation behind the
> scenes? 

I'm not familiar enough with RDMA. But I guess it may also depend on
the "memory consistency" and coherency properties. Which are not
specified for now for the ISM shared memory regions AFAIU.

> Maybe, the spec does not care. But we can give an example.
> 

At this point I'm not sure, whether the spec should care or not.

> So something like:
> 
> 	An ISM(Internal Shared Memory) device provides the ability to
> 	access memory shared between multiple devices. This allows low-overhead
> 	communication in presence of such memory. For example, memory can be
> 	shared with guests of multiple virtual machines running on the same
> 	host, with each virtual machine including an ISM device and with
> 	the guests using the ISM devices to access the shared memory.
> 
> what do others think?

I agree, the spec should be as abstract as possible. As stated above,
I don't have clarity on the interoperability goals. Is multiple flavors
of virtio-ism devices that are not mutually interoperable a good outcome?

Regards,
Halil

