Return-Path: virtio-return-3101-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
References: <1524740402-18934-1-git-send-email-pasic@linux.ibm.com>
 <1524740402-18934-2-git-send-email-pasic@linux.ibm.com>
 <20180514163659.GR5182@stefanha-x1.localdomain>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Mon, 14 May 2018 21:40:43 +0200
MIME-Version: 1.0
In-Reply-To: <20180514163659.GR5182@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <bfecd798-33bd-a08b-59af-27af699e32ed@linux.ibm.com>
Subject: [virtio] Re: [virtio-dev] [PATCH 1/6] notifications: unify notifications
 wording in core
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Pawel Moll <pawel.moll@arm.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 05/14/2018 06:36 PM, Stefan Hajnoczi wrote:
> On Thu, Apr 26, 2018 at 12:59:57PM +0200, Halil Pasic wrote:
>> @@ -235,12 +236,13 @@ transmit and one for receive.}.
>>   Driver makes requests available to device by adding
>>   an available buffer to the queue - i.e. adding a buffer
>>   describing the request to a virtqueue, and optionally triggering
>> -a driver event - i.e. sending a notification to the device.
>> +a driver event - i.e. sending an available buffer notification
>> +to the device.
>>   
>>   Device executes the requests and - when complete - adds
>>   a used buffer to the queue - i.e. lets the driver
>>   know by marking the buffer as used. Device can then trigger
>> -a device event - i.e. send an interrupt to the driver.
>> +a device event - i.e. send an used buffer notification to the driver.
> 
> I would say "a used buffer notification".  "A" vs "an" depends on the
> sound of the initial syllable, not the spelling.  So "a used car" vs "an
> upper body".
> 
> There are several instances of this in this patch.
> 

Right. Will try to hunt all of them down.

>>   
>>   Device reports the number of bytes it has written to memory for
>>   each buffer it uses. This is referred to as ``used length''.
>> @@ -330,7 +332,8 @@ set the FAILED status bit to indicate that it has given up on the
>>   device (it can reset the device later to restart if desired).  The
>>   driver MUST NOT continue initialization in that case.
>>   
>> -The driver MUST NOT notify the device before setting DRIVER_OK.
>> +The driver MUST NOT send any buffer available notifications to
>> +the device before setting DRIVER_OK.
>>   
>>   \subsection{Legacy Interface: Device Initialization}\label{sec:General Initialization And Device Operation / Device Initialization / Legacy Interface: Device Initialization}
>>   Legacy devices did not support the FEATURES_OK status bit, and thus did
>> @@ -388,10 +391,11 @@ reads unless notified.
>>   
>>   \subsection{Notification of Device Configuration Changes}\label{sec:General Initialization And Device Operation / Device Operation / Notification of Device Configuration Changes}
>>   
>> -For devices where the device-specific configuration information can be changed, an
>> -interrupt is delivered when a device-specific configuration change occurs.
>> +For devices where the device-specific configuration information can be
>> +changed, a notification is delivered when a device-specific configuration
>> +change occurs.
> 
> Unlike used/available buffer notifications, the text here just says
> "notification" without explicitly saying "configuration change
> notification".  I think it makes the spec slightly clearer (and easier
> to search) to name the exact type of notification.

I decided to not spell it out for stylistic reasons. If I do we end
up with 3xconfiguration and 3xchange in a single sentence. But I'm also
a fan of searching and finding all instances. And I used to say for
specifications it's consistency over style.

I will change it according to your request.


> 
>> @@ -309,22 +310,20 @@ in the ring.
>>   
>>   \subsection{Driver and Device Event Suppression}
>>   \label{sec:Packed Virtqueues / Driver and Device Event Suppression}
>> -In many systems driver and device notifications involve
>> +In many systems used and available buffer  notifications involve
> 
> s/  / /
> 
>> @@ -352,9 +351,9 @@ matches this value and a descriptor is
>>   made available/used respectively.
>>   \end{description}
>>   
>> -After writing out some descriptors, both the device and the driver
>> +After writing out some descriptors,the device/driver
> 
> s/,/, /
> 
>> @@ -562,8 +570,8 @@ The driver offers buffers to one of the device's virtqueues as follows:
>>   \item The driver performs a suitable memory barrier to ensure that it updates
>>     the \field{idx} field before checking for notification suppression.
>>   
>> -\item If notifications are not suppressed, the driver notifies the device
>> -    of the new available buffers.
>> +\item The driver sends an available buffers notification to the device if
> 
> s/available buffers notification/available buffer notification/
> 

Will apply all of these.

Thank you for your review!

Regards,
Halil


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

