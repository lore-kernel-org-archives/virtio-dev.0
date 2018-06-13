Return-Path: virtio-return-3135-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
References: <1528733518-24950-1-git-send-email-pasic@linux.ibm.com>
 <1528733518-24950-2-git-send-email-pasic@linux.ibm.com>
 <20180613130405.GE24528@stefanha-x1.localdomain>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Wed, 13 Jun 2018 15:22:33 +0200
MIME-Version: 1.0
In-Reply-To: <20180613130405.GE24528@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <21bf3f4b-cdbb-e818-a197-c4a141dc20b0@linux.ibm.com>
Subject: [virtio] Re: [PATCH v2 1/6] notifications: unify notifications wording in core
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Pawel Moll <pawel.moll@arm.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 06/13/2018 03:04 PM, Stefan Hajnoczi wrote:
> On Mon, Jun 11, 2018 at 06:11:53PM +0200, Halil Pasic wrote:
>> @@ -65,11 +65,12 @@ in which their processing is complete.
>>   
>>   The Device Event Suppression data structure is write-only by the
>>   device. It includes information for reducing the number of
>> -device events - i.e. driver notifications to device.
>> +device events - i.e. sending an available buffer notification
>> +to the device.
>>   
>>   The Driver Event Suppression data structure is read-only by the
>>   device. It includes information for reducing the number of
>> -driver events - i.e. device interrupts to driver.
>> +driver events - i.e. send a used buffer notification to the driver.
> 
> This makes the "i.e." more natural:
> 
> "sending fewer used buffer notifications to the driver"
> 
> because the "send a used buffer notification to the driver" phrase
> doesn't directly relate to any preceding subphrase ("driver events",
> "number of driver events", or "reducing the number of driver events").
> 

Will do. My sentence does not make sense.

>>   
>>   \subsection{Driver and Device Ring Wrap Counters}
>>   \label{sec:Packed Virtqueues / Driver and Device Ring Wrap Counters}
>> @@ -309,22 +310,20 @@ in the ring.
>>   
>>   \subsection{Driver and Device Event Suppression}
>>   \label{sec:Packed Virtqueues / Driver and Device Event Suppression}
>> -In many systems driver and device notifications involve
>> +In many systems used and available buffer notifications involve
>>   significant overhead. To mitigate this overhead,
>>   each virtqueue includes two identical structures used for
>>   controlling notifications between the device and the driver.
>>   
>>   The Driver Event Suppression structure is read-only by the
>> -device and controls the events sent by the device
>> -to the driver (e.g. interrupts).
>> +device and controls the used buffer notifications (sent by the device
>> +to the driver).
>>   
>>   The Device Event Suppression structure is read-only by
>> -the driver and controls the events sent by the driver
>> -to the device (e.g. IO).
>> +the driver and controls the available buffer notifications (sent by the
>> +driver to the device).
>>   
>> -Each of these Event Suppression structures controls
>> -both Descriptor Ring events and structure events, and
>> -each includes the following fields:
>> +Each of these Event Suppression includes the following fields:
> 
> Something is missing, "these" is plural but Event Suppression is
> singular:
> 
> Each of these Event Suppression structures ...
> 

Will put back structures. Connie spotted it too.

>>   Otherwise, if the VIRTIO_F_EVENT_IDX feature bit is negotiated:
>>   \begin{itemize}
>>   \item The driver MUST set \field{flags} to 0.
>> -\item The driver MAY use \field{used_event} to advise the device that interrupts are unnecessary until the device writes entry with an index specified by \field{used_event} into the used ring (equivalently, until \field{idx} in the
>> +\item The driver MAY use \field{used_event} to advise the device that
>> +notifications are unnecessary until the device writes entry with an index specified by \field{used_event} into the used ring (equivalently, until \field{idx} in the
> 
> Pre-existing issue:
> 
>    the device writes *an* entry
> 

I will fix it if already touching the sentence. Thanks
for spotting it!

>> @@ -562,8 +570,8 @@ The driver offers buffers to one of the device's virtqueues as follows:
>>   \item The driver performs a suitable memory barrier to ensure that it updates
>>     the \field{idx} field before checking for notification suppression.
>>   
>> -\item If notifications are not suppressed, the driver notifies the device
>> -    of the new available buffers.
>> +\item The driver sends an available buffers notification to the device if
>> +    such notifications are not suppressed.
> 
> For consistency:
> 
> s/available buffers notification/available buffer notification/
> 

Sorry, I missed this one. Will fix.

Thanks for your review!

Regards,
Halil


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

