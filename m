Return-Path: <mgurtovoy@nvidia.com>
Message-ID: <00153057-1332-047a-2ce7-20570cb6fe31@nvidia.com>
Date: Mon, 1 Aug 2022 03:11:58 +0300
Subject: Re: [PATCH v6 4/5] Add admin_queue_index register to PCI common
 configuration structure
References: <20220731154354.15698-1-mgurtovoy@nvidia.com>
 <20220731154354.15698-5-mgurtovoy@nvidia.com>
 <20220731170049-mutt-send-email-mst@kernel.org>
From: Max Gurtovoy <mgurtovoy@nvidia.com>
In-Reply-To: <20220731170049-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowang@redhat.com, virtio-comment@lists.oasis-open.org, cohuck@redhat.com, virtio-dev@lists.oasis-open.org, oren@nvidia.com, parav@nvidia.com, shahafs@nvidia.com, aadam@redhat.com, virtio@lists.oasis-open.org, eperezma@redhat.com
List-ID: <virtio-dev.lists.oasis-open.org>


On 8/1/2022 12:03 AM, Michael S. Tsirkin wrote:
> On Sun, Jul 31, 2022 at 06:43:53PM +0300, Max Gurtovoy wrote:
>> This new register will be used for querying the index of the admin
>> virtqueue of a virtio device. To configure, reset or enable the admin
>> virtqueue, the driver should follow existing queue configuration/setup
>> sequence.
>>
>> Reviewed-by: Parav Pandit <parav@nvidia.com>
>> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>
>
> Can you please at least add text to MMIO and CCW that drivers and
> devices must not negotiate the new feature bit? Will help avoid confusion.

why this is needed ? who will create a device and expose bits that it 
doesn't know how to implement.

And if I'll add it, we might forget to remove it later on.

>
>> ---
>>   content.tex | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/content.tex b/content.tex
>> index c15423e..5fda1a0 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -904,6 +904,9 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>>           le64 queue_device;              /* read-write */
>>           le16 queue_notify_data;         /* read-only for driver */
>>           le16 queue_reset;               /* read-write */
>> +
>> +        /* About admin virtqueue. */
>> +        le16 admin_queue_index;         /* read-only for driver */
>>   };
>>   \end{lstlisting}
>>   
>> @@ -989,6 +992,10 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>>           This field exists only if VIRTIO_F_RING_RESET has been
>>           negotiated. (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
>>   
>> +\item[\field{admin_queue_index}]
>> +        The device uses this to report the index of the admin virtqueue.
>> +        This field always exists. Its value is valid only if VIRTIO_F_ADMIN_VQ has been negotiated.
>> +
>>   \end{description}
>>   
>>   \devicenormative{\paragraph}{Common configuration structure layout}{Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Common configuration structure layout}
> we have a mess with this exists versus valid. I think exists is the same

the bigest mess that we have is for things like ring_reset that are 
optionally exist according to bit negotiation.

about valid - the driver shouldn't even look on registers that it didn't 
negotiated it's feature bits. There is no reason to do so.

So yes, there is a mess but not in our proposal.

> is valid personally. Do others object if we say same as for reset here?
> Not a big deal either way, we need to clean this up later.
>
>> @@ -1075,6 +1082,9 @@ \subsubsection{Common configuration structure layout}\label{sec:Virtio Transport
>>   were used before the queue reset.
>>   (see \ref{sec:Basic Facilities of a Virtio Device / Virtqueues / Virtqueue Reset}).
>>   
>> +For configuring the admin virtqueue, the driver MUST use the value of \field{admin_queue_index}.
>> +For more details on virtqueue configuration see section \ref{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI-specific Initialization And Device Operation / Device Initialization / Virtqueue Configuration}.
>> +
>>   \subsubsection{Notification structure layout}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / PCI Device Layout / Notification capability}
>>   
>>   The notification location is found using the VIRTIO_PCI_CAP_NOTIFY_CFG
>> -- 
>> 2.21.0

