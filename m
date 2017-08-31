Return-Path: virtio-return-2788-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
References: <1490655576-12173-1-git-send-email-mst@redhat.com>
Date: Thu, 31 Aug 2017 13:30:26 +0200
MIME-Version: 1.0
In-Reply-To: <1490655576-12173-1-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <14c81460-bf85-4724-98bd-5160d49b08f9@linux.vnet.ibm.com>
Subject: [virtio] Re: [virtio-dev] [PATCH] net: clarify device rules for mergeable
 buffers
To: "Michael S. Tsirkin" <mst@redhat.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>



On 03/28/2017 01:09 AM, Michael S. Tsirkin wrote:
> The idea behind mergeable buffers was to simply use them in a way
> similar to a chain of descriptors.  Unfortunately the current text does
> not say so - apparently nothing says device can't spread a packet over
> as many buffers as it likes - but this didn't prevent drivers from
> relying on buffers being used as a chain of descriptors, completely -
> and blindly accessing it without checking the length at least for the
> packet header.
> 
> Let's just make the spec match this reality - if devices ever want more
> flexibility, we can add a feature bit.
> 
> Further, correct all misuses of a "descriptor" to "buffer" as that
> is the entity that is being merged.
> 
> VIRTIO-160
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Sorry for not commenting sooner. I'm revisiting this because I would
like to have a good understanding of what I'm voting about.

I think this patch is surely an improvement, but I'm not sure it brings
us to the point, where the information is easy to understand and hard
to misinterpret.

In my understanding we have 3 levels here, starting from the lowest
(regarding abstraction):
I) Descriptor level: a descriptor designates a single continuous piece
of memory (at places called buffer in the spec).
II) Descriptor chain, aka buffer: a linked list of descriptors arranged
according specific constrains (device-readable before device-writable).
The chain of descriptors can contain indirect descriptors.
III) Device type specific messages defined by as a part of the protocol
defining the device type (optional, not existent for e.g. console). The
names used in the spec for these are: packet (net), request (blk, scsi-host,
crypto), descriptor of one or more buffers (rng), descriptor describing the
resulting 32-bit array (balloon),

Now between level I and level II we have what we call 'framing' and
'message framing' requirements if I understand it correctly. Basically
with some legacy motivated exceptions we say it should not matter how a
buffer is mapped to descriptors.

The relationship between level II and level III seems is a tougher nut.
I'm under the impression, that it was supposed to be a direct
correspondence except for exceptions. That is a buffer (II) is supposed
to contain exactly one request or one response, or one request&response
depending on the queue and the design of the device type. For instance
for blk the amount of data involved is determined by the buffer length.

AFAIU the VIRTIO_NET_F_MRG_RXBUF is supposed to be an exception from that
rule: if VIRTIO_NET_F_MRG_RXBUF a packet (level III concept) is allowed
to span multiple buffers (level II concept), but a packet is only allowed
to 'begin' at the beginning of a buffer.

Bottom line is, even with this patch applied the situation remains messy.
Part of the problem is that 'buffer' is used to denote two different
things (level II and level I). And I think, there are devices, which say
descriptor when they mean buffer (level II). Furthermore what I describe
as level III is mostly just implicitly present in the spec. IMHO if we
want these things nice and easy to understand we need a bigger overhaul.
I will vote for because it is an improvement -- even if its sufficiency
is somewhat debatable.

Regards,
Halil


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

