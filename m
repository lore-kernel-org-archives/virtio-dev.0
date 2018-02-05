Return-Path: virtio-return-2862-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
References: <1515577653-9336-1-git-send-email-mst@redhat.com>
 <1516665617-30748-8-git-send-email-mst@redhat.com>
 <20180130145044.648bbe4e.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon, 5 Feb 2018 12:54:41 +0100
MIME-Version: 1.0
In-Reply-To: <20180130145044.648bbe4e.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <180bf54b-4e40-8c24-2888-0ea102ddb772@linux.vnet.ibm.com>
Subject: [virtio] Re: [virtio-dev] Re: [virtio] [PATCH v7 08/11] packed virtqueues:
 more efficient virtqueue layout
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
List-ID: <virtio-dev.lists.oasis-open.org>



On 01/30/2018 02:50 PM, Cornelia Huck wrote:
> On Tue, 23 Jan 2018 02:01:07 +0200
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
>> Performance analysis of this is in my kvm forum 2016 presentation.  The
>> idea is to have a r/w descriptor in a ring structure, replacing the used
>> and available ring, index and descriptor buffer.
>>
>> This is also easier for devices to implement than the 1.0 layout.
>> Several more enhancements will be necessary to actually make this
>> efficient for devices to use.
>>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>> ---
[..]
> 
>> +\subsubsection{Notifying The Device}\label{sec:Basic Facilities
>> +of a Virtio Device / Packed Virtqueues / Supplying Buffers to The Device / Notifying The Device}
>> +
>> +The actual method of device notification is bus-specific, but generally
>> +it can be expensive.  So the device MAY suppress such notifications if it
>> +doesn't need them, using the Driver Event Suppression structure
>> +as detailed in section \ref{sec:Basic
>> +Facilities of a Virtio Device / Packed Virtqueues / Event
>> +Suppression Structure Format}.
>> +
>> +The driver has to be careful to expose the new \field{flags}
>> +value before checking if notifications are suppressed.
> 
> This is all I could find regarding notifications, and it leaves me
> puzzled how notifications are actually supposed to work; especially,
> where that driver notification structure is supposed to be relayed.
> 
> I'm obviously coming from a ccw perspective, but I don't think that pci
> is all that different (well, hopefully).
> 
> Up to now, we notified for a certain virtqueue -- i.e., the device
> driver notified the device that there is something to process for a
> certain queue. ccw uses the virtqueue number in a gpr for a hypercall,
> pci seems to use a write to the config space IIUC. With the packed
> layout, we have more payload per notification. We should be able to put
> it in the same gpr than the virtqueue for ccw (if needed, with some
> compat magic, or with a new hypercall, which would be ugly but doable).
> Not sure how this is supposed to work with pci.
> 
> Has there been any prototyping done to implement this in qemu + KVM?
> I'm unsure how this will work with ioeventfds, which just trigger.
> 


I'm also interested in an answer to Connie's question regarding a QEMU +
KVM prototype. IMHO we should definitively have at least a such an
prototype (preferably a reasonable implementation) before voting about
the changes envisioned by this series.

[META]

Unfortunately I have skipped v6 altogether (that is not even lurker
mode). I'm a bit overwhelmed. I'm also in doubt about how to articulate
my feelings and opinions. Maybe I will wait for v8 with my comments. You
seem to have received enough comments for v7 already.

Anyway, I'm happy to see virtio version 1.1 is slowly materializing.

Regards,
Halil


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

