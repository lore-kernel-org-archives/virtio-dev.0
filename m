Return-Path: <usama.arif@bytedance.com>
Message-ID: <826b0089-20a0-3243-f12a-8a3eb39506e6@bytedance.com>
Date: Tue, 11 Oct 2022 17:58:25 +0100
MIME-Version: 1.0
Subject: Re: [virtio-dev] [PATCH v3 1/4] content: Introduce driver/device
 auxiliary notifications
References: <20221007165643.3920613-1-usama.arif@bytedance.com>
 <20221007165643.3920613-2-usama.arif@bytedance.com>
 <87tu4ad8d6.fsf@redhat.com>
From: Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <87tu4ad8d6.fsf@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Cornelia Huck <cohuck@redhat.com>, virtio-dev@lists.oasis-open.org
Cc: mst@redhat.com, stefanha@redhat.com, ndragazis@arrikto.com, fam.zheng@bytedance.com, liangma@liangbit.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 11/10/2022 10:20, Cornelia Huck wrote:
> On Fri, Oct 07 2022, Usama Arif <usama.arif@bytedance.com> wrote:
> 
>> Driver auxiliary notifications allow the device to send notifications
>> other than configuration changes and used buffer notifications to the
>> driver, these are optional and their meaning is device-specific.
>>
>> Device auxiliary notifications allow the driver to send notifications
>> other than available buffer notifications to the device for example
>> through a device register, these are optional and their meaning is
>> device-specific.
>>
>> These device-specific notifications are needed later when adding support
>> for virtio-vhost-user device.
>>
>> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
>> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>> Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
>> ---
>>   content.tex | 35 ++++++++++++++++++++++-------------
>>   1 file changed, 22 insertions(+), 13 deletions(-)
>>
>> diff --git a/content.tex b/content.tex
>> index e863709..49f9f2a 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -160,29 +160,38 @@ \subsection{Legacy Interface: A Note on Feature
>>   Specification text within these sections generally does not apply
>>   to non-transitional devices.
>>   
>> -\section{Notifications}\label{sec:Basic Facilities of a Virtio Device
>> -/ Notifications}
>> +\section{Notifications}\label{sec:Basic Facilities of a Virtio Device / Notifications}
>>   
>>   The notion of sending a notification (driver to device or device
>>   to driver) plays an important role in this specification. The
>>   modus operandi of the notifications is transport specific.
>>   
>> -There are three types of notifications:
>> +There are five types of notifications:
>>   \begin{itemize}
>>   \item configuration change notification
>>   \item available buffer notification
>> -\item used buffer notification.
>> +\item used buffer notification
>> +\item driver auxiliary notification
>> +\item device auxiliary notification
> 
> Should we postfix the two new entries with "(optional)"?
>

I can add that in the next version I send. I have "these are optional 
and their meaning is device-specific." in the description below as well.

>>   \end{itemize}
>>   
>> -Configuration change notifications and used buffer notifications are sent
>> -by the device, the recipient is the driver. A configuration change
>> -notification indicates that the device configuration space has changed; a
>> -used buffer notification indicates that a buffer may have been made used
>> -on the virtqueue designated by the notification.
>> -
>> -Available buffer notifications are sent by the driver, the recipient is
>> -the device. This type of notification indicates that a buffer may have
>> -been made available on the virtqueue designated by the notification.
>> +Configuration change notifications, used buffer notifications and
>> +driver auxiliary notifications are sent by the device,
>> +the recipient is the driver. A configuration change notification indicates
>> +that the device configuration space has changed; a used buffer notification
>> +indicates that a buffer may have been made used on the virtqueue designated
>> +by the notification; driver auxiliary notifications allow the
>> +device to send notifications other than configuration changes and used
>> +buffer notifications to the driver, these are optional and their meaning
>> +is device-specific.
>> +
>> +Available buffer notifications and device auxiliary notifications
>> +are sent by the driver, the recipient is the device. Available buffer
>> +notifications indicate that a buffer may have been made available on the
>> +virtqueue designated by the notification; device auxiliary
>> +notifications allow the driver to send notifications other than available
>> +buffer notifications to the device for example through a device register, these
>> +are optional and their meaning is device-specific.
>>   
>>   The semantics, the transport-specific implementations, and other
>>   important aspects of the different notifications are specified in detail
> 

