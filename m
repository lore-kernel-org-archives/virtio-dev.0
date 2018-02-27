Return-Path: virtio-dev-return-3297-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Date: Tue, 27 Feb 2018 11:23:06 +0100
From: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20180227102306.umrmvreh23bydsrl@dhcp-192-241.str.redhat.com>
References: <1518765602-8739-1-git-send-email-mst@redhat.com>
 <20180216092412-mutt-send-email-mst@kernel.org>
 <55eb7e9c-97ee-f7d7-10db-190dd844160d@linux.vnet.ibm.com>
 <20180226224109-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20180226224109-mutt-send-email-mst@kernel.org>
Subject: Re: [virtio-dev] Re: [PATCH v8 08/16] packed virtqueues: more
 efficient virtqueue layout
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Halil Pasic <pasic@linux.vnet.ibm.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, Cornelia Huck <cohuck@redhat.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Mon, Feb 26, 2018 at 11:05:14PM +0200, Michael S. Tsirkin wrote:
>On Mon, Feb 26, 2018 at 06:19:21PM +0100, Halil Pasic wrote:
>> > +                vq->driver_event.flags = 0x1;
>> > +                memory_barrier();
>> > +
>> > +                flags = d->flags;
>> > +                bool avail = flags & (1 << VIRTQ_DESC_F_AVAIL);
>> > +                bool used = flags & (1 << VIRTQ_DESC_F_USED);
>> > +                if (avail != used) {
>> > +                        break;
>> > +                }
>> > +
>> > +                vq->driver_event.flags = 0x2;
>> > +        }
>> > +
>> > +	read_memory_barrier();
>>
>> Now with the condition avail != used a freshly (that is zero initialized)
>> ring would appear all used. And we would do process_buffer(d) for the
>> whole ring if this code happens to get executed. Do we have to make
>> sure that this does not happen?
>
>I'll have to think about this.

With the wrap counter initialized to 1 descriptors would not be seen
as used. 

>
>
>> I was under the impression that this whole wrap counter exercise is
>> to be able to distinguish these cases.
>>
>> BTW tools/virtio/ringtest/ring.c has a single flag bit to indicate
>> available/used and does not have these wrap counters AFAIR.
>
>A single flag is fine if there's not s/g support and all descriptors are
>written out.  Wrap counters are needed if we are to support skipping
>descriptors because of s/g or in order.
>
>
>> Also for split virtqueues  a descriptor has three possible states:
>> * available
>> * used
>> * free
>>
>> I wonder if it's the same for packed, and if, how do I recognize
>> free descriptors (that is descriptors that are neither available
>> nor used.
>
>I'll think about this.
>
>> I'm pretty much confused on how this scheme with the available
>> and used wrap counters (or device and driver wrap counters is
>> supposed to work). A working implementation in C would really help
>> me to understand this.
>
>DPDK based implementation has been posted.

vhost and guest drivers have also been posted.
guest: https://lkml.org/lkml/2018/2/23/242
vhost: https://lkml.org/lkml/2018/2/13/1102

regards,
Jens 

>
>> > +        process_buffer(d);
>> > +        vq->next_used++;
>> > +        if (vq->next_used >= vq->size) {
>> > +                vq->next_used = 0;
>> > +        }
>> > +}
>> > +\end{lstlisting}
>> >
>
>---------------------------------------------------------------------
>To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
>For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

