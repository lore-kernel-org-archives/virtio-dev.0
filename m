Return-Path: virtio-return-3107-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
References: <1524740402-18934-1-git-send-email-pasic@linux.ibm.com>
 <1524740402-18934-6-git-send-email-pasic@linux.ibm.com>
 <20180515085855.GV5182@stefanha-x1.localdomain>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Tue, 15 May 2018 11:25:39 +0200
MIME-Version: 1.0
In-Reply-To: <20180515085855.GV5182@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <b655413c-db77-1a89-afd7-56df4cde6101@linux.ibm.com>
Subject: [virtio] Re: [virtio-dev] Re: [virtio] [PATCH 5/6] mmio: map common
 notifications terminology to MMIO
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Pawel Moll <pawel.moll@arm.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 05/15/2018 10:58 AM, Stefan Hajnoczi wrote:
> On Thu, Apr 26, 2018 at 01:00:01PM +0200, Halil Pasic wrote:
>> @@ -1716,26 +1716,28 @@ The driver will typically initialize the virtual queue in the following way:
>>   \item Write 0x1 to \field{QueueReady}.
>>   \end{enumerate}
>>   
>> -\subsubsection{Notifying The Device}\label{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Notifying The Device}
>> +\subsubsection{Available Buffer Notifications}\label{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Available Buffer Notifications}
>>   
>> -The driver notifies the device about new buffers being available in
>> -a queue by writing the index of the updated queue to \field{QueueNotify}.
>> +The driver sends an available buffer notification to the device a by
> 
> s/device a by/device by/
> 
>> +writing the index of the queue to \field{QueueNotify} to be notified.
>>   
>>   \subsubsection{Notifications From The Device}\label{sec:Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Notifications From The Device}
>>   
>>   The memory mapped virtio device is using a single, dedicated
>>   interrupt signal, which is asserted when at least one of the
>>   bits described in the description of \field{InterruptStatus}
>> -is set. This is how the device notifies the
>> -driver about a new used buffer being available in the queue
>> -or about a change in the device configuration.
>> +is set. This is how the device sends an used buffer notification
>> +or a configuration change notifaciton to the device.
> 
> s/notifaciton/notification/
> 
> Please run a spell checker over the patches in case I missed other
> typos.

I did but I missed this one (and maybe some more). Will try to be
more careful when preparing v2.

> 
>>   
>>   \drivernormative{\paragraph}{Notifications From The Device}{Virtio Transport Options / Virtio Over MMIO / MMIO-specific Initialization And Device Operation / Notifications From The Device}
>>   After receiving an interrupt, the driver MUST read
>> -\field{InterruptStatus} to check what caused the interrupt
>> -(see the register description). After the interrupt is handled,
>> -the driver MUST acknowledge it by writing a bit mask
>> -corresponding to the handled events to the InterruptACK register.
>> +
>> +\field{InterruptStatus} to check what caused the interrupt (see the
>> +register description).  The used buffer notification bit being set,
> 
> The comma is unnecessary here.  The "SHOULD ..." clause is not
> independent and needs something directly before it.
> 

Right.

I won't comment back to the rest of your comments separately. I recognize
them as legit and I will address them in v2.

Many thanks!

Regards,
Halil


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

