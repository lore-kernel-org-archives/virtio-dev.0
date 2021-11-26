Return-Path: <virtio-dev-return-8979-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 696579864A7
	for <virtio-dev@lists.oasis-open.org>; Fri, 26 Nov 2021 08:35:41 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <CACGkMEun-obsMTLAGCCtKpqNxWHBKk_QC_6WywsVsFb7mfW9qw@mail.gmail.com>
References: <20210831135753.GG9207@quicinc.com>
 <20211125162349-mutt-send-email-mst@kernel.org>
 <CACGkMEun-obsMTLAGCCtKpqNxWHBKk_QC_6WywsVsFb7mfW9qw@mail.gmail.com>
Date: Fri, 26 Nov 2021 09:35:30 +0100
Message-ID: <87v90fiab1.fsf@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] Re: [PATCH v3] virtio-mmio: Specify wait needed in driver during reset
Content-Type: text/plain
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Trilok Soni <tsoni@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On Fri, Nov 26 2021, Jason Wang <jasowang@redhat.com> wrote:

> On Fri, Nov 26, 2021 at 5:25 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> On Tue, Aug 31, 2021 at 07:27:53PM +0530, Srivatsa Vaddagiri wrote:
>> > Reset of a virtio-mmio device is initiated by writing 0 to its Status register.
>> > In case of some devices, the reset operation itself may not be completed
>> > by the time write instruction completes and hence such devices would require
>> > drivers to wait on reset operation to complete before they proceed with
>> > remaining steps of initialization.
>> >
>> > Update the specification to indicate which devices would need driver to block on
>> > reset completion.
>> >
>> > Suggested-by: Jason Wang <jasowang@redhat.com>
>> > Signed-off-by: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
>>
>> I have been thinking about this some more.
>>
>>
>> \section{Device Reset}\label{sec:Basic Facilities of a Virtio Device / Device Reset}
>>
>> The driver may want to initiate a device reset at various times; notably,
>> it is required to do so during device initialization and device cleanup.
>>
>> The mechanism used by the driver to initiate the reset is transport specific.
>>
>> \devicenormative{\subsection}{Device Reset}{Basic Facilities of a Virtio Device / Device Reset}
>>
>> A device MUST reinitialize \field{device status} to 0 after receiving a reset.
>>
>> A device MUST NOT send notifications or interact with the queues after
>> indicating completion of the reset by reinitializing \field{device status}
>> to 0, until the driver re-initializes the device.
>>
>> \drivernormative{\subsection}{Device Reset}{Basic Facilities of a Virtio Device / Device Reset}
>>
>> The driver SHOULD consider a driver-initiated reset complete when it
>> reads \field{device status} as 0.
>
> I wonder if we need to switch to using MUST here.

I'm not quite sure what advantage s/SHOULD/MUST/ would give us here.

I don't think we want to force the driver to read back the device status
to determine success if the transport already has a different way to
signal completion. (I probably should undust my ccw reset clarification
patch...)

>> So I guess we can just fix the mmio driver to read status
>> and declare victory? Do we really need all the spec changes?
>
> Probably, but one consideration of this change is to avoid the
> breaking of existing devices. Maybe it's over engineering.

How big is the chance that we use an unfixed driver with a device that
would get it into trouble? The proposed change is pretty complex, I'd
rather avoid it if possible.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

